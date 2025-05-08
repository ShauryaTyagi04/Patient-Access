<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Dashboard.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="PatientAccess.pages.dashboard.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid-blur p-4">
        <div class="row">
            <!-- Left Section: Image and Change Password Button -->
            <div class="col-md-4 text-center">
                <img id="profileImage" runat="server" class="rounded-circle mb-3" style="width: 250px; height: 250px; object-fit: cover;">
                <label class="text-primary form-label mb-2">Upload your profile picture</label>
                <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control mb-2" />
                <asp:Button runat="server" ID="uploadImageBtn" Text="Upload Image" CssClass="alt-btn-primary medium-button mb-3" OnClick="UploadImage" />
                <asp:Button runat="server" ID="changePasswordBtn" CssClass="alt-btn-primary medium-button" Text="Change Password" OnClientClick="showChangePasswordModal(); return false;" />
            </div>

            <!-- Right Section: Editable Profile Fields -->
            <div class="col-md-8">
                <!-- Profile Container -->
                <div class="p-4 shadow-sm bg-white rounded position-relative">
                    <!-- Edit Icon -->
                    <i class="fas fa-edit position-absolute pe-3 pt-3 top-0 end-0 text-black" id="editIcon" style="cursor: pointer;" title="Edit Profile"></i>

                    <!-- First Name and Last Name -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="text-primary" for="firstName">First Name:</label>
                            <input runat="server" type="text" id="firstName" class="form-control" disabled />
                        </div>
                        <div class="col-md-6">
                            <label class="text-primary" for="lastName">Last Name:</label>
                            <input runat="server" type="text" id="lastName" class="form-control" disabled />
                        </div>
                    </div>

                    <!-- Patient ID -->
                    <div class="mb-3">
                        <label class="text-danger" for="patientId">Patient ID:</label>
                        <input runat="server" type="text" id="patientId" class="form-input-disabled"/>
                    </div>

                    <!-- Email Address -->
                    <div class="position-relative mb-3" style="width:100%">
                        <label class="text-primary" for="email">Email Address:</label>
                        <input runat="server" type="email" id="email" class="form-control" disabled />
                        <div class="invalid-tooltip" id="emailError" runat="server">Email already registered.</div>
                    </div>

                    <!-- Phone Number -->
                    <div class="position-relative mb-3" style="width:100%">
                            <label class="text-primary" for="phoneNumber">Phone Number:</label>
                            <input runat="server" type="text" id="phoneNumber" class="form-control" disabled />
                            <div class="invalid-tooltip" id="phoneError" runat="server">Phone number already registered.</div>
                    </div>

                    <!-- NHS Number -->
                    <div class="mb-3">
                        <label class="text-secondary" for="nhsNumber">NHS Number:</label>
                        <input runat="server" type="text" id="nhsNumber" class="form-input-disabled"/>
                    </div>

                    <!-- Date of Birth -->
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label  class="text-secondary" for="dobDay">Day:</label>
                            <input runat="server" type="text" id="dobDay" class="form-input-disabled"/>
                        </div>
                        <div class="col-md-4">
                            <label class="text-secondary" for="dobMonth">Month:</label>
                            <select id="dobMonth" class="form-select-disabled" runat="server" ></select>
                        </div>
                        <div class="col-md-4">
                            <label class="text-secondary" for="dobYear">Year:</label>
                            <input runat="server" type="text" id="dobYear" class="form-input-disabled"/>
                        </div>
                    </div>

                    <!-- Post Code -->
                    <div class="mb-3">
                        <label class="text-primary" for="postcode">Post Code:</label>
                        <input runat="server" type="text" id="postcode" class="form-control" disabled />
                    </div>

                    <!-- Gender and Emergency Contact -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label  class="text-secondary" for="gender">Gender:</label>
                            <select id="gender" runat="server" class="form-select-disabled">
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="text-primary" for="emergencyContact">Emergency Contact Number:</label>
                            <input runat="server" type="text" id="emergencyContact" class="form-control" disabled />
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="text-center mt-4">
                    <asp:Button runat="server" ID="submitBtn" CssClass="btn-primary large-button" Text="Save Changes" OnClick="SubmitChanges" />
                </div>
            </div>
        </div>
    </div>

                <!-- Change Password Modal -->
    <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="changePasswordModalLabel">Change Password</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <label for="newPassword">Enter New Password:</label>
                    <input runat="server" type="password" id="newPassword" class="form-control" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" ID="confirmChangePassword" CssClass="btn-primary" Text="Confirm" OnClick="ChangePassword" />
                </div>
            </div>
        </div>
    </div>


    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const editIcon = document.getElementById("editIcon");
            const allInputs = document.querySelectorAll(".form-control, .form-select");
            const alwaysDisabled = document.querySelectorAll(".form-input-disabled, .form-select-disabled");
            const fileUpload = document.getElementById("fileUpload");

            editIcon.addEventListener("click", function () {
                const isActive = this.classList.toggle("active");
                this.classList.toggle("text-black", !isActive);
                this.classList.toggle("text-primary", isActive);

                // Toggle only editable fields
                allInputs.forEach(input => {
                    if (!input.classList.contains("form-input-disabled") && !input.classList.contains("form-select-disabled")) {
                        input.disabled = !isActive;
                    }
                });

                // Ensure "always disabled" fields remain disabled
                alwaysDisabled.forEach(input => {
                    input.disabled = true;
                });

                // Keep file upload always enabled
                fileUpload.disabled = false;
            });

            // Ensure "always disabled" fields are locked from the start
            alwaysDisabled.forEach(input => {
                input.disabled = true;
            });


            
        });
        window.showChangePasswordModal = function () {
            const changePasswordModal = new bootstrap.Modal(document.getElementById("changePasswordModal"));
            changePasswordModal.show();
        }

    </script>
</asp:Content>
