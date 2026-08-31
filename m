Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42DBC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E3210EB81;
	Tue,  1 Sep 2026 07:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UZXx38vP";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F7C110E7D5
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:01:29 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48433e9562bso403022f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788206488; x=1788811288; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cjz68ETwAN2FKUN9LzjvKRJdYA9ykCyAklcCT+ptStE=;
 b=UZXx38vP8MZx83oCgI/nW4bBmyb1SxzkDyjc/EAjrfpu5lhP15RaZtm9Q4OeqiIVSo
 qPW4kK0D3trt8Qhexq0LAr45zE8Dfycl593QeZwnkbzCbZQcmqDYo2W3L8Vda9eJtDlF
 zfcn9bUbctGWbc8BpcKC6OOxGhLuD97MTSjzFS/m4soQbgd0RZHDpxPz9v65MAMKNuTL
 3z6p+0LbXSggRZkn1OViDY40Up1WA34rPe8OJktTC2MQOz3x4V8qBJLcQzXkLtw0crPT
 6qKz8e5h45VSEA4rIxeGouSEcp2DO2P6oZdGaoQWdBxfgglELqE+2DpSsBdP9K3C6PN7
 BM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788206488; x=1788811288;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cjz68ETwAN2FKUN9LzjvKRJdYA9ykCyAklcCT+ptStE=;
 b=KXcCqdoL7VS3m7+pnFUnXOQNYhqzf1RZ5EG3l4Du+V/CcV4y4c2caD+G8DXQjwNPG7
 9HUY76JkdAOHERJkXIUXV041JgE26Cr6+nsu1Zaiycat7JqJgkkjLUUK3oLtseuc+5Qu
 r4sxqB5VzTrjmozbXxFZQCy1j9vc5zAYCea8lLbnki4DT+muW+ySF+7Ic4LQbw0bYGMT
 yNRrDxQjYosi+Cuu2oYYMvF2fpApSJLVrNKxM17M013yeuoT/ndRCZPXoSoZXJNPIIRo
 SPF6zCKwjttvQ3VryGJIGvijMgl6NoR+Sgw+Hn9Y5+ILJh2SD8/qrprvHQ5dMRdp8lzI
 czwg==
X-Gm-Message-State: AFuF++m4K+tzC639InuyyKfIHeWk0LjLJoe2v1ioor/UEXz90ZfYj3Pk
 eTrK9m1Kr/c9YP6gxIN4J78zedf+x5lXjlqHuv6wPugUva4xhooli3w/ANAcfk9K
X-Gm-Gg: AYBFou0cEnYw4miGLUNl87RepFLB920d8LPv2scy6s0u4TjzVoU8EoeUaKts7Ec9dha
 JNOSB5mohxcul7jY+GdRTkGsV3xs+qBUUkSTQrwVWIWSHQyVJZoI5ny45LkfT8e5rnyIj0UA8pt
 /p8werEoobESzrQwSY+09n1KbpQMwy0WLQZ0Z2YWxbQQRwaejqeFX4OymzjMRsOOLQomVZa4l+Q
 sMDzME7CmWFHgF9b/DG1tm76xhCBFvFNJYXTBIrkhfHGjxQLz1EBDLnacywh34YbbZvIhUngGFs
 WrSQQLyIO8Sjmtz27otmqdwk1m38/2q9Xb/4hhJBMoBVAp3jUjGOp86QttCIjoNSLhRmhHDEBfv
 sgn36q4019Ih6H3eIvn/5mgoKDAswfrM2A0aROA+fyPTUY07EMeKkC/8PAmN9pHnsEctFg79M+E
 Gjbx1P77KkJIoeRjYEaI6KyqhqRykepQlUnLwDZaWG88bjxQo9spN23QsDukQtH9X0rQFzFw==
X-Received: by 2002:a05:6000:991:b0:484:3311:3703 with SMTP id
 ffacd0b85a97d-484331138a0mr33648382f8f.26.1788206487499; 
 Mon, 31 Aug 2026 13:01:27 -0700 (PDT)
Received: from user-HP ([82.215.83.93]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d6e905sm42089f8f.23.2026.08.31.13.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 13:01:27 -0700 (PDT)
From: Andrey Erokhin <language.lawyer@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Keith Packard <keithp@keithp.com>,
 Simon Ser <contact@emersion.fr>, linux-api@vger.kernel.org
Subject: [RFC PATCH] drm/lease: optionally expose leases as device nodes
Date: Tue,  1 Sep 2026 01:00:44 +0500
Message-ID: <20260831200047.2533572-1-language.lawyer@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

DRM leases are only returned as anonymous file descriptors. Device
managers such as udev and logind therefore cannot discover a lease, assign
it to a seat, or hand it to a session through their normal device APIs.

Accept O_CREAT in DRM_IOCTL_MODE_CREATE_LEASE to additionally publish the
lease as a DRM class device named after the primary node and the lessee ID.
Make the device a sibling of the primary node and report
DEVTYPE=drm_lease.

The exposed node deliberately reuses the anonymous lease file's private
data and file operations. This keeps DRM and driver ioctl handling on the
original lessee without introducing a proxy driver. Keep that file alive
while the exposed node is open and unregister the device when the lease is
destroyed.

Mirror DRM hotplug uevents to exposed leases so that a display server
monitoring its assigned node observes connector changes.

Userspace can identify these nodes through DEVTYPE=drm_lease. Udev rules
should tag lease nodes as seat masters and exclude them from ordinary DRM
card by-path symlinks because a sibling lease inherits the physical
device's ID_PATH.

Signed-off-by: Andrey Erokhin <language.lawyer@gmail.com>
---
RFC questions:

  * Is extending drm_mode_create_lease.flags with O_CREAT an acceptable UAPI,
    or would a DRM-specific flag or a separate ioctl be preferable?
  * Is a sibling DRM class device with DEVTYPE=drm_lease a suitable device
    model for an exposed lease?
  * Is sharing the anonymous lease file's private_data and fops an acceptable
    lifetime model for the exposed node?
  * Should hotplug uevents be mirrored to every exposed lease, or should
    userspace continue monitoring the physical DRM device?

The kernel only exposes the lease device; a userspace broker is still needed.
For a static multiseat configuration the broker must run before logind.  It
opens the physical DRM node, acquires DRM master, creates all leases from the
same lessor, and keeps the lessor and returned lease file descriptors open.
The QEMU test setup used this logind.service drop-in:

    [Unit]
    Requires=drm-lease-broker.service
    After=drm-lease-broker.service

The QEMU virtio-gpu resources used for the two leases were:

    lease 1 / seat0:
      connector 40 (Virtual-1)
      CRTC 39
      primary plane 35 and cursor plane 36 (implicitly included)

    lease 2 / seat1:
      connector 47 (Virtual-2)
      CRTC 46
      primary plane 42 and cursor plane 43 (implicitly included)

The minimal broker used for this test is available at:
https://gist.github.com/languagelawyer/cfe02f4a0d9ba9726a86f74ecb73f990
Its invocation and output were:

    [root@archlinux ~]# /root/release /dev/dri/card0 [ 40 39 ] [ 47 46 ]
    Created lease 1 for group 1: 40 39
    Created lease 2 for group 2: 47 46

These IDs are specific to this QEMU configuration; a real broker must enumerate
the resources dynamically.  DRM_CLIENT_CAP_UNIVERSAL_PLANES was not enabled,
so the compatible planes were added implicitly by DRM.  With that client
capability enabled, the broker must include the plane IDs explicitly.

With the lease devices and separate input devices assigned through udev, logind
reported:

    [root@archlinux ~]# loginctl seat-status seat0
    seat0
    Devices: n/a
             ├─/sys/devices/pci0000:00/0000:00:03.0/drm/card0-lessee-1
             │ [MASTER] drm:card0-lessee-1
             ├─/sys/devices/platform/LNXPWRBN:00/input/input0
             │ input:input0 "Power Button"
             ├─/sys/devices/platform/i8042/serio0/input/input3
             │ input:input3 "AT Translated Set 2 keyboard"
             └─/sys/devices/platform/i8042/serio1/input/input5
               input:input5 "ImExPS/2 Generic Explorer Mouse"
    [root@archlinux ~]# loginctl seat-status seat1
    seat1
    Devices: n/a
             ├─/sys/devices/pci0000:00/0000:00:03.0/drm/card0-lessee-2
             │ [MASTER] drm:card0-lessee-2
             ├─/sys/devices/pci0000:00/0000:00:04.0/virtio2/input/input1
             │ input:input1 "QEMU Virtio Keyboard"
             └─/sys/devices/pci0000:00/0000:00:05.0/virtio3/input/input2
               input:input2 "QEMU Virtio Mouse"

Two Xorg servers ran concurrently with different modes:

    Virtual-1 connected primary 1024x768+0+0
    Virtual-2 connected primary 800x600+0+0

The corresponding systemd/udev change is available at
https://github.com/languagelawyer/systemd/commit/9781cf0be05f6bcec9bd428db86f37e7d3030570
It tags drm_lease devices as seat masters and prevents them from replacing the
physical card's by-path symlink.  It is not part of this kernel patch.

 Documentation/gpu/drm-uapi.rst |  41 +++++++
 drivers/gpu/drm/drm_drv.c      |   5 +
 drivers/gpu/drm/drm_internal.h |   5 +
 drivers/gpu/drm/drm_lease.c    | 196 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/drm_sysfs.c    |   2 +
 include/uapi/drm/drm_mode.h    |   7 +-
 6 files changed, 254 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 93df92c4ac8c..52f36946874d 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -48,6 +48,47 @@ DRM Display Resource Leasing
 .. kernel-doc:: drivers/gpu/drm/drm_lease.c
    :doc: drm leasing
 
+Exposing a lease as a device
+----------------------------
+
+By default, :c:macro:`DRM_IOCTL_MODE_CREATE_LEASE` only returns an anonymous
+file descriptor. Passing ``O_CREAT`` in ``drm_mode_create_lease.flags`` also
+registers the lease as a DRM class device. The libdrm wrapper can be used as
+follows::
+
+    uint32_t lessee_id;
+    int lease_fd;
+
+    lease_fd = drmModeCreateLease(lessor_fd, object_ids, object_count,
+                                  O_CLOEXEC | O_CREAT, &lessee_id);
+    if (lease_fd < 0)
+            /* Handle the error. */
+
+The device is a sibling of the primary DRM device and is named after the
+primary node and the lessee ID. For example, lessee 1 of ``card0`` is exposed
+as ``/dev/dri/card0-lessee-1``. Its uevent contains ``DEVTYPE=drm_lease`` so
+that device managers can distinguish it from a DRM primary node.
+
+Opening the device accesses the same lease as the anonymous file descriptor.
+In particular, all opens share the lessee's DRM file private data, including
+its DRM master state, client capabilities and GEM handle namespace. Each open
+device file keeps the lease alive. The device is unregistered after the last
+reference to the lease file is closed. Revoking the lease removes its objects
+but does not unregister the device while references remain open.
+
+Connector hotplug changes generate ``HOTPLUG=1`` change uevents for the
+exposed lease as well as for the primary node. A device manager can make an
+exposed lease available for seat assignment with a rule such as::
+
+    SUBSYSTEM=="drm", ENV{DEVTYPE}=="drm_lease", \
+      ENV{ID_FOR_SEAT}="drm-lease-$kernel", TAG+="seat", \
+      TAG+="master-of-seat"
+
+An exposed lease inherits the physical device's path information. Rules which
+create ``dri/by-path/*-card`` links should therefore restrict those links to
+``DEVTYPE=drm_minor`` so that a lease does not replace its primary node's
+link.
+
 Open-Source Userspace Requirements
 ==================================
 
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index c808958a2188..add36fbf693f 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1250,6 +1250,7 @@ static void drm_core_exit(void)
 	drm_privacy_screen_lookup_exit();
 	drm_panic_exit();
 	accel_core_exit();
+	drm_lease_cleanup();
 	unregister_chrdev(DRM_MAJOR, "drm");
 	drm_debugfs_remove_root();
 	drm_sysfs_destroy();
@@ -1283,6 +1284,10 @@ static int __init drm_core_init(void)
 
 	drm_panic_init();
 
+	ret = drm_lease_init();
+	if (ret < 0)
+		goto error;
+
 	drm_privacy_screen_lookup_init();
 
 	ret = drm_ras_genl_family_register();
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index f893b1e3a596..1d72dd7419b6 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -101,6 +101,10 @@ int drm_prime_add_buf_handle(struct drm_prime_file_private *prime_fpriv,
 void drm_prime_remove_buf_handle(struct drm_prime_file_private *prime_fpriv,
 				 uint32_t handle);
 
+/* drm_lease.c */
+int drm_lease_init(void);
+void drm_lease_cleanup(void);
+
 /* drm_managed.c */
 void drm_managed_release(struct drm_device *dev);
 void drmm_add_final_kfree(struct drm_device *dev, void *container);
@@ -171,6 +175,7 @@ void drm_sysfs_connector_remove_early(struct drm_connector *connector);
 void drm_sysfs_connector_remove(struct drm_connector *connector);
 
 void drm_sysfs_lease_event(struct drm_device *dev);
+void drm_lease_uevent(struct drm_device *dev, char *envp[]);
 
 /* drm_gem.c */
 int drm_gem_init(struct drm_device *dev);
diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 5d2cf724cbd7..32a11312d0ce 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -2,8 +2,12 @@
 /*
  * Copyright © 2017 Keith Packard <keithp@keithp.com>
  */
+#include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/file.h>
+#include <linux/fs.h>
 #include <linux/uaccess.h>
+#include <linux/xarray.h>
 
 #include <drm/drm_auth.h>
 #include <drm/drm_crtc.h>
@@ -71,6 +75,9 @@
 
 static uint64_t drm_lease_idr_object;
 
+static int drm_exposed_lease_major;
+static DEFINE_XARRAY_ALLOC(drm_exposed_lease_minors_xa);
+
 struct drm_master *drm_lease_owner(struct drm_master *master)
 {
 	while (master->lessor != NULL)
@@ -263,10 +270,145 @@ static struct drm_master *drm_lease_create(struct drm_master *lessor, struct idr
 	return ERR_PTR(error);
 }
 
+struct drm_exposed_lease {
+	struct file *lessee_file;
+	struct drm_master *lessee;
+	struct file_operations fops;
+	struct device kdev;
+};
+
+static const struct device_type drm_exposed_lease_device_type = {
+	.name = "drm_lease",
+};
+
+void drm_lease_uevent(struct drm_device *dev, char *envp[])
+{
+	struct device *kdev;
+	unsigned long minor = 0;
+
+	for (;;) {
+		struct drm_exposed_lease *exposed;
+
+		kdev = NULL;
+		xa_lock(&drm_exposed_lease_minors_xa);
+		while ((exposed = xa_find(&drm_exposed_lease_minors_xa, &minor,
+					  MINORMASK, XA_PRESENT))) {
+			minor++;
+			if (exposed->lessee->dev == dev) {
+				kdev = get_device(&exposed->kdev);
+				break;
+			}
+		}
+		xa_unlock(&drm_exposed_lease_minors_xa);
+
+		if (!kdev)
+			return;
+
+		kobject_uevent_env(&kdev->kobj, KOBJ_CHANGE, envp);
+		put_device(kdev);
+	}
+}
+
+static void drm_exposed_device_release(struct device *dev)
+{
+	kfree(container_of(dev, struct drm_exposed_lease, kdev));
+}
+
+static int drm_exposed_lease_release(struct inode *inode, struct file *filp)
+{
+	struct drm_exposed_lease *exposed;
+	struct file *lessee_file = NULL;
+
+	xa_lock(&drm_exposed_lease_minors_xa);
+	exposed = xa_load(&drm_exposed_lease_minors_xa, iminor(inode));
+	if (exposed && exposed->lessee_file)
+		lessee_file = exposed->lessee_file;
+	xa_unlock(&drm_exposed_lease_minors_xa);
+
+	if (lessee_file)
+		fput(lessee_file);
+
+	return 0;
+}
+
+static int drm_expose_lease(struct file *lessee_file,
+			    struct drm_master *lessee)
+{
+	int ret = 0;
+	u32 minor;
+	struct drm_exposed_lease *exposed;
+	struct device *drm_kdev;
+	struct device *kdev;
+
+	exposed = kzalloc_obj(*exposed);
+	if (!exposed)
+		return -ENOMEM;
+
+	exposed->lessee_file = lessee_file;
+	exposed->lessee = lessee;
+	exposed->fops = *lessee_file->f_op;
+	exposed->fops.release = drm_exposed_lease_release;
+
+	ret = xa_alloc(&drm_exposed_lease_minors_xa, &minor, exposed,
+		       XA_LIMIT(0, MINORMASK), GFP_KERNEL);
+
+	if (ret < 0) {
+		kfree(exposed);
+		return ret;
+	}
+
+	drm_kdev = lessee->dev->primary->kdev;
+	kdev = &exposed->kdev;
+
+	device_initialize(kdev);
+	kdev->devt = MKDEV(drm_exposed_lease_major, minor);
+	kdev->class = drm_kdev->class;
+	kdev->type = &drm_exposed_lease_device_type;
+	kdev->parent = drm_kdev->parent;
+	kdev->release = drm_exposed_device_release;
+	ret = dev_set_name(kdev, "%s-lessee-%d", dev_name(drm_kdev), lessee->lessee_id);
+	if (ret < 0)
+		goto minor_free;
+	ret = device_add(kdev);
+	if (ret < 0)
+		goto device_put;
+
+	return 0;
+
+device_put:
+	put_device(kdev);
+
+minor_free:
+	xa_erase(&drm_exposed_lease_minors_xa, minor);
+
+	return ret;
+}
+
+static void drm_hide_lease(struct drm_master *master)
+{
+	unsigned long minor;
+	struct drm_exposed_lease *exposed = NULL;
+
+	xa_lock(&drm_exposed_lease_minors_xa);
+	xa_for_each(&drm_exposed_lease_minors_xa, minor, exposed) {
+		if (exposed->lessee == master)
+			break;
+	}
+	if (exposed)
+		__xa_erase(&drm_exposed_lease_minors_xa, minor);
+	xa_unlock(&drm_exposed_lease_minors_xa);
+
+	if (exposed)
+		device_unregister(&exposed->kdev);
+}
+
 void drm_lease_destroy(struct drm_master *master)
 {
 	struct drm_device *dev = master->dev;
 
+	if (master->lessee_id != 0)
+		drm_hide_lease(master);
+
 	mutex_lock(&dev->mode_config.idr_mutex);
 
 	drm_dbg_lease(dev, "drm_lease_destroy %d\n", master->lessee_id);
@@ -491,7 +633,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EOPNOTSUPP;
 
-	if (cl->flags && (cl->flags & ~(O_CLOEXEC | O_NONBLOCK))) {
+	if (cl->flags && (cl->flags & ~(O_CLOEXEC | O_NONBLOCK | O_CREAT))) {
 		drm_dbg_lease(dev, "invalid flags\n");
 		return -EINVAL;
 	}
@@ -566,6 +708,14 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	cl->fd = fd;
 	cl->lessee_id = lessee->lessee_id;
 
+	if (cl->flags & O_CREAT) {
+		ret = drm_expose_lease(lessee_file, lessee);
+		if (ret) {
+			fput(lessee_file);
+			goto out_leases;
+		}
+	}
+
 	/* Hook up the fd */
 	fd_install(fd, lessee_file);
 
@@ -730,3 +880,47 @@ int drm_mode_revoke_lease_ioctl(struct drm_device *dev,
 
 	return ret;
 }
+
+static int drm_lease_open(struct inode *inode, struct file *filp)
+{
+	struct drm_exposed_lease *exposed;
+	struct file *lessee_file = NULL;
+
+	xa_lock(&drm_exposed_lease_minors_xa);
+	exposed = xa_load(&drm_exposed_lease_minors_xa, iminor(inode));
+	if (exposed && exposed->lessee_file && get_file_rcu(&exposed->lessee_file))
+		lessee_file = exposed->lessee_file;
+	xa_unlock(&drm_exposed_lease_minors_xa);
+
+	if (!lessee_file)
+		return -ENODEV;
+
+	replace_fops(filp, &exposed->fops);
+	filp->private_data = lessee_file->private_data;
+
+	return 0;
+}
+
+static const struct file_operations drm_lease_fops = {
+	.owner = THIS_MODULE,
+	.open = drm_lease_open,
+};
+
+int drm_lease_init(void)
+{
+	int ret;
+
+	ret = register_chrdev(0, "drm_lease", &drm_lease_fops);
+	if (ret < 0)
+		return ret;
+
+	drm_exposed_lease_major = ret;
+
+	return 0;
+}
+
+void drm_lease_cleanup(void)
+{
+	if (drm_exposed_lease_major > 0)
+		unregister_chrdev(drm_exposed_lease_major, "drm_lease");
+}
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index ef4e923a8728..63a2c6c035b2 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -449,6 +449,7 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
 	drm_dbg_kms(dev, "generating hotplug event\n");
 
 	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
+	drm_lease_uevent(dev, envp);
 }
 EXPORT_SYMBOL(drm_sysfs_hotplug_event);
 
@@ -474,6 +475,7 @@ void drm_sysfs_connector_hotplug_event(struct drm_connector *connector)
 		    connector->base.id, connector->name);
 
 	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
+	drm_lease_uevent(dev, envp);
 }
 EXPORT_SYMBOL(drm_sysfs_connector_hotplug_event);
 
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index bd435effdcee..9bc69bca891c 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -1436,7 +1436,12 @@ struct drm_mode_create_lease {
 	__u64 object_ids;
 	/** @object_count: Number of object ids */
 	__u32 object_count;
-	/** @flags: flags for new FD (O_CLOEXEC, etc) */
+	/**
+	 * @flags: Flags for the new file descriptor.
+	 *
+	 * O_CLOEXEC and O_NONBLOCK control the returned file descriptor.
+	 * O_CREAT additionally exposes the lease as a DRM class device.
+	 */
 	__u32 flags;
 
 	/** @lessee_id: Return: unique identifier for lessee. */
-- 
2.54.0
