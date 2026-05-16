Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D7ACD4F25
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F38F10E4A0;
	Sat, 16 May 2026 11:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bHNQx3Pz";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D305210E4A0
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:07:01 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so6792465e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929620; x=1779534420; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GZ3vDaJ2jqpNbKxKrO5UqJVvEsFWMV1I/ds8vkY2noo=;
 b=bHNQx3Pz5FXPRbivmR3+l6L78e+NUfYMKs2acnVjJXNTlARg3xd/ho/MtBjk5gJzgz
 0Nhj1KM3d3TQch/NQjOSlIkDKUqM7cmpvRENej3VgXmNRVTBMOEosK1Rx5vb5P8wn3Y0
 UdJahdlxPyH9KMGLkoimHTIM5LsMHTmkgnhXVd8XPDMQPOKSHYfoVO+baURCZxh6re9Y
 HTDR3BejCb2jmBeg5+DOV5xVau2vLEq+k9zZfd2NF+2++IuaB5TJKQm18zcXNh2aF+f+
 FfbfstxiDpbmsaG2Y4RKKn0MpysSUJqarcW7Tbf3NfnIx/5td5TAJD0Fp3PK2qC6G6YB
 J4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929620; x=1779534420;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GZ3vDaJ2jqpNbKxKrO5UqJVvEsFWMV1I/ds8vkY2noo=;
 b=qDCoiOUwDf6KdjjN8yWwZ3+4U4ROKTfDV654NvKGqbcVeCQV0Whf307EASyiRMIlrW
 0idS/ZNSNqjQV9PLzSsTR5jqiaiHlK4szF24PCx3nBNFYu9HXwE93WwJESf/l5Ak4Yqn
 3KB3t4mWKJ7FGXEYrbRG7Hz+LYtPi7H8E7Dmvs6t19vbSpUUFrPdxNz8jpTtxNhoh/uZ
 nQdh+A5ikfjhtvjQq9uF5zyoQWDXB0vp8uP2IgkrwS/aicGeKQVh2JLlm5q+eWFiduRk
 K9hDhb5i+m0bgIEXXGunRcmHOIsWOtg4OEmt1IQn8T3SibhR3PGHqGY+JUURMuoT944L
 VB8g==
X-Gm-Message-State: AOJu0YxHFl5dnH/ZItZJEIORv2p2Kkt9+vt+AlFBbJ/82eqX4a0BBA/j
 qV7ejIAFSKK/9TOi8Z4f5IjXrthZTPQSCv7SdyB4pXG9lprub2Ua98Oc
X-Gm-Gg: Acq92OF8YwngE8PE0iu1jKZ9Ph1BhMOl/Zksk1JnVdmlHFM8CJEIO8r/PkbzKquBUqo
 1Oyo2IewvEkxsbU7gHrRJtz1JMVONsCAPS9X8F2sISPpdmWRCY1s8paPruLClYkd7HgpUf3L1T7
 RUsYX8JtwnM3ns4tnaSIhjxCQWBp6D2wtWdJzOh65YnjGnOtIuK7Lse6+JGk6bmmt1fheUjVKfH
 Znv4O8gVrui0IkYWv6S8uSeXkbCsX8cOWuKvU2eq1qK3S6C0Tu61go06ZuOF1gsD2ORyJsbXLLf
 LjA5QyQtdpsivQjQ6RrOZPXtCBuAPWCIbnczkytDVtVPWSYQnfYTJjwm3XZXER8XK7Zk19yD4/7
 KHUoQV+5Qc6qs+0arZhfvyxrwhGufXe8jPoZHJt9nJR3yZh3AY0LxI1QZn6312p5vBaOyGxlKny
 7Q6NwPbuhrMTOBZ/Jluz9t8ALiLHE7bjxkidt3B6vax2q5dFBb3VB+GIh2naWukiaUYaWelZWFF
 CBn7Oo=
X-Received: by 2002:a05:600c:4fc9:b0:48a:7a10:4f17 with SMTP id
 5b1f17b1804b1-48fe60e50b9mr96881595e9.6.1778929620265; 
 Sat, 16 May 2026 04:07:00 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:59 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:15 +0200
Subject: [PATCH 12/12] misc/syncobj: add new device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-12-88ede9d98a81@gmail.com>
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
In-Reply-To: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org, 
 ju.orth@gmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=15478;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=WhzJjcCvKJj2CD2b9qjHPi70/JQ1jm0ddKfGtp0BfmM=;
 b=jK2Bs4uyWC+jcOGk8NJpgy6AhVj99OtKJKeddomFMCahmbTtCGP/1EMGI3Uk76dKu/2he7YQr
 MHj5Bk+wIAfC0Qq8ZU8mGV3xEfWXNYUa3uV6jFFeOZROh9bhflVxWag
X-Developer-Key: i=ju.orth@gmail.com; a=ed25519;
 pk=uM2SS4lelkuIoYHc7v9N9bgBZ3hS632zJS2xjRJLPLI=
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

This device makes the DRM_IOCTL_SYNCOBJ_* ioctls available via a
dedicated device. This allows applications to use syncobjs without
having to open device nodes in /dev/dri, on systems that don't have any
such nodes, or on systems whose devices don't support the
DRIVER_SYNCOBJ_TIMELINE feature.

Wayland uses syncobjs as its buffer synchronization mechanism. Most
compositors use the DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to perform a pure
CPU wait for syncobj point. DRM devices are not involved in this process
except insofar that a DRM device needs to be used to access the ioctl.

Similarly, a software-rendered client might perform rendering on a
dedicated thread and use the wayland syncobj protocol to submit frames
before they finish rendering. Again, this does not involve DRM devices
except insofar ... as above.

As an added benefit, this device removes the need to translate between
file descriptors and handles.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
 drivers/misc/Kconfig                               |  10 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/syncobj.c                             | 404 +++++++++++++++++++++
 include/uapi/linux/syncobj.h                       |  75 ++++
 5 files changed, 491 insertions(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 331223761fff..5e140ae5735e 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -395,6 +395,7 @@ Code  Seq#    Include File                                             Comments
                                                                        <mailto:michael.klein@puffin.lb.shuttle.de>
 0xCC  00-0F  drivers/misc/ibmvmc.h                                     pseries VMC driver
 0xCD  01     linux/reiserfs_fs.h                                       Dead since 6.13
+0xCD  00-0F  uapi/linux/syncobj.h
 0xCE  01-02  uapi/linux/cxl_mem.h                                      Compute Express Link Memory Devices
 0xCF  02     fs/smb/client/cifs_ioctl.h
 0xDD  00-3F                                                            ZFCP device driver see drivers/s390/scsi/
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 00683bf06258..c1e7749bd356 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -644,6 +644,16 @@ config MCHP_LAN966X_PCI
 	    - lan966x-miim (MDIO_MSCC_MIIM)
 	    - lan966x-switch (LAN966X_SWITCH)
 
+config SYNCOBJ_DEV
+	tristate "DRM syncobj device (/dev/syncobj)"
+	depends on DRM
+	help
+	  Creates a /dev/syncobj device node that provides DRM synchronization
+	  objects (syncobjs) without requiring a DRM device.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called syncobj.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b32a2597d246..9e5deb1d0d76 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -75,3 +75,4 @@ obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
 obj-y				+= amd-sbi/
 obj-$(CONFIG_MISC_RP1)		+= rp1/
+obj-$(CONFIG_SYNCOBJ_DEV)	+= syncobj.o
diff --git a/drivers/misc/syncobj.c b/drivers/misc/syncobj.c
new file mode 100644
index 000000000000..11ef46ddfeef
--- /dev/null
+++ b/drivers/misc/syncobj.c
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * syncobj.c - Standalone device for syncobj manipulation.
+ *
+ * Copyright (C) 2026 Julian Orth <ju.orth@gmail.com>
+ */
+
+#include <linux/fdtable.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <drm/drm_syncobj.h>
+#include <drm/drm_utils.h>
+#include <uapi/drm/drm.h>
+#include <uapi/linux/syncobj.h>
+
+static int syncobj_array_find(void __user *user_fds, u32 count,
+			      struct drm_syncobj ***syncobjs_out)
+{
+	u32 i;
+	s32 *fds;
+	struct drm_syncobj **syncobjs;
+	int ret;
+
+	fds = kmalloc_array(count, sizeof(*fds), GFP_KERNEL);
+	if (!fds)
+		return -ENOMEM;
+
+	if (copy_from_user(fds, user_fds, sizeof(s32) * count)) {
+		ret = -EFAULT;
+		goto err_free_fds;
+	}
+
+	syncobjs = kmalloc_array(count, sizeof(*syncobjs), GFP_KERNEL);
+	if (!syncobjs) {
+		ret = -ENOMEM;
+		goto err_free_fds;
+	}
+
+	for (i = 0; i < count; i++) {
+		syncobjs[i] = drm_syncobj_from_fd(fds[i]);
+		if (!syncobjs[i]) {
+			ret = -EBADF;
+			goto err_put_syncobjs;
+		}
+	}
+
+	kfree(fds);
+	*syncobjs_out = syncobjs;
+	return 0;
+
+err_put_syncobjs:
+	while (i-- > 0)
+		drm_syncobj_put(syncobjs[i]);
+	kfree(syncobjs);
+err_free_fds:
+	kfree(fds);
+	return ret;
+}
+
+static void syncobj_array_free(struct drm_syncobj **syncobjs, u32 count)
+{
+	u32 i;
+
+	for (i = 0; i < count; i++)
+		drm_syncobj_put(syncobjs[i]);
+	kfree(syncobjs);
+}
+
+static int syncobj_ioctl_create(void __user *argp)
+{
+	struct syncobj_create_args args;
+	struct drm_syncobj *syncobj;
+	int fd, ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (args.flags & ~SYNCOBJ_CREATE_SIGNALED)
+		return -EINVAL;
+
+	static_assert(SYNCOBJ_CREATE_SIGNALED == DRM_SYNCOBJ_CREATE_SIGNALED);
+
+	ret = drm_syncobj_create(&syncobj, args.flags, NULL);
+	if (ret)
+		return ret;
+
+	ret = drm_syncobj_get_fd(syncobj, &fd);
+	drm_syncobj_put(syncobj);
+	if (ret)
+		return ret;
+
+	args.fd = fd;
+	if (copy_to_user(argp, &args, sizeof(args))) {
+		close_fd(fd);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int syncobj_ioctl_wait(void __user *argp)
+{
+	struct syncobj_wait_args args;
+	struct drm_syncobj **syncobjs;
+	signed long timeout;
+	u32 first = ~0;
+	ktime_t t, *tp = NULL;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (args.flags & ~(SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
+			   SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+			   SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE |
+			   SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE))
+		return -EINVAL;
+
+	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_ALL        == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL);
+	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT);
+	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE  == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE);
+	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE   == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE);
+
+	if (args.pad)
+		return -EINVAL;
+
+	if (args.count == 0)
+		return 0;
+
+	ret = syncobj_array_find(u64_to_user_ptr(args.fds),
+				 args.count, &syncobjs);
+	if (ret < 0)
+		return ret;
+
+	if (args.flags & SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE) {
+		t = ns_to_ktime(args.deadline_nsec);
+		tp = &t;
+	}
+
+	timeout = drm_timeout_abs_to_jiffies(args.timeout_nsec);
+	timeout = drm_syncobj_array_wait_timeout(syncobjs,
+						 u64_to_user_ptr(args.points),
+						 args.count,
+						 args.flags,
+						 timeout, &first, tp);
+
+	syncobj_array_free(syncobjs, args.count);
+
+	if (timeout < 0)
+		return timeout;
+
+	args.first_signaled = first;
+	if (copy_to_user(argp, &args, sizeof(args)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int syncobj_ioctl_reset(void __user *argp)
+{
+	struct syncobj_array_args args;
+	struct drm_syncobj **syncobjs;
+	u32 i;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (args.flags)
+		return -EINVAL;
+
+	if (args.points)
+		return -EINVAL;
+
+	if (args.count == 0)
+		return -EINVAL;
+
+	ret = syncobj_array_find(u64_to_user_ptr(args.fds),
+				 args.count, &syncobjs);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < args.count; i++)
+		drm_syncobj_replace_fence(syncobjs[i], NULL);
+
+	syncobj_array_free(syncobjs, args.count);
+	return 0;
+}
+
+static int syncobj_ioctl_signal(void __user *argp)
+{
+	struct syncobj_array_args args;
+	struct drm_syncobj **syncobjs;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (args.flags)
+		return -EINVAL;
+
+	if (args.count == 0)
+		return -EINVAL;
+
+	ret = syncobj_array_find(u64_to_user_ptr(args.fds),
+				 args.count, &syncobjs);
+	if (ret < 0)
+		return ret;
+
+	ret = drm_syncobj_timeline_signal(syncobjs, args.points, args.count);
+
+	syncobj_array_free(syncobjs, args.count);
+	return ret;
+}
+
+static int syncobj_ioctl_query(void __user *argp)
+{
+	struct syncobj_array_args args;
+	struct drm_syncobj **syncobjs;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (args.flags & ~SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED)
+		return -EINVAL;
+
+	static_assert(SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED == DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED);
+
+	if (args.count == 0)
+		return -EINVAL;
+
+	ret = syncobj_array_find(u64_to_user_ptr(args.fds),
+				 args.count, &syncobjs);
+	if (ret < 0)
+		return ret;
+
+	ret = drm_syncobj_query(syncobjs, args.points, args.count, args.flags);
+
+	syncobj_array_free(syncobjs, args.count);
+	return ret;
+}
+
+static int syncobj_ioctl_transfer(void __user *argp)
+{
+	struct syncobj_transfer_args args;
+	struct drm_syncobj *src, *dst;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (args.pad)
+		return -EINVAL;
+
+	if (args.flags & ~SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
+		return -EINVAL;
+
+	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT);
+
+	src = drm_syncobj_from_fd(args.src_fd);
+	if (!src)
+		return -EBADF;
+
+	dst = drm_syncobj_from_fd(args.dst_fd);
+	if (!dst) {
+		drm_syncobj_put(src);
+		return -EBADF;
+	}
+
+	ret = drm_syncobj_transfer(src, args.src_point,
+				   dst, args.dst_point, args.flags);
+
+	drm_syncobj_put(dst);
+	drm_syncobj_put(src);
+
+	return ret;
+}
+
+static int syncobj_ioctl_eventfd(void __user *argp)
+{
+	struct syncobj_eventfd_args args;
+	struct drm_syncobj *syncobj;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (args.flags & ~SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)
+		return -EINVAL;
+
+	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE);
+
+	if (args.pad)
+		return -EINVAL;
+
+	syncobj = drm_syncobj_from_fd(args.syncobj_fd);
+	if (!syncobj)
+		return -EBADF;
+
+	ret = drm_syncobj_register_eventfd(syncobj, args.eventfd,
+					   args.point, args.flags);
+
+	drm_syncobj_put(syncobj);
+
+	return ret;
+}
+
+static int syncobj_ioctl_export_sync_file(void __user *argp)
+{
+	struct syncobj_sync_file_args args;
+	struct drm_syncobj *syncobj;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	syncobj = drm_syncobj_from_fd(args.syncobj_fd);
+	if (!syncobj)
+		return -EBADF;
+
+	ret = drm_syncobj_export_sync_file(syncobj, args.point,
+					   &args.sync_file_fd);
+	drm_syncobj_put(syncobj);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(argp, &args, sizeof(args))) {
+		close_fd(args.sync_file_fd);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int syncobj_ioctl_import_sync_file(void __user *argp)
+{
+	struct syncobj_sync_file_args args;
+	struct drm_syncobj *syncobj;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	syncobj = drm_syncobj_from_fd(args.syncobj_fd);
+	if (!syncobj)
+		return -EBADF;
+
+	ret = drm_syncobj_import_sync_file(syncobj, args.sync_file_fd,
+					   args.point);
+
+	drm_syncobj_put(syncobj);
+
+	return ret;
+}
+
+static long syncobj_dev_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case SYNCOBJ_IOC_CREATE:
+		return syncobj_ioctl_create(argp);
+	case SYNCOBJ_IOC_WAIT:
+		return syncobj_ioctl_wait(argp);
+	case SYNCOBJ_IOC_RESET:
+		return syncobj_ioctl_reset(argp);
+	case SYNCOBJ_IOC_SIGNAL:
+		return syncobj_ioctl_signal(argp);
+	case SYNCOBJ_IOC_QUERY:
+		return syncobj_ioctl_query(argp);
+	case SYNCOBJ_IOC_TRANSFER:
+		return syncobj_ioctl_transfer(argp);
+	case SYNCOBJ_IOC_EVENTFD:
+		return syncobj_ioctl_eventfd(argp);
+	case SYNCOBJ_IOC_EXPORT_SYNC_FILE:
+		return syncobj_ioctl_export_sync_file(argp);
+	case SYNCOBJ_IOC_IMPORT_SYNC_FILE:
+		return syncobj_ioctl_import_sync_file(argp);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+static const struct file_operations syncobj_dev_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= syncobj_dev_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+};
+
+static struct miscdevice syncobj_misc = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "syncobj",
+	.fops	= &syncobj_dev_fops,
+	.mode	= 0666,
+};
+
+module_misc_device(syncobj_misc);
+
+MODULE_AUTHOR("Julian Orth");
+MODULE_DESCRIPTION("DRM syncobj device");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/syncobj.h b/include/uapi/linux/syncobj.h
new file mode 100644
index 000000000000..c4068fbd5773
--- /dev/null
+++ b/include/uapi/linux/syncobj.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_SYNCOBJ_H_
+#define _UAPI_LINUX_SYNCOBJ_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define SYNCOBJ_CREATE_SIGNALED			(1 << 0)
+
+#define SYNCOBJ_WAIT_FLAGS_WAIT_ALL		(1 << 0)
+#define SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT	(1 << 1)
+#define SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE	(1 << 2)
+#define SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE	(1 << 3)
+
+#define SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED	(1 << 0)
+
+struct syncobj_create_args {
+	__s32 fd;
+	__u32 flags;
+};
+
+struct syncobj_wait_args {
+	__u64 fds;
+	__u64 points;
+	__s64 timeout_nsec;
+	__u32 count;
+	__u32 flags;
+	__u32 first_signaled;
+	__u32 pad;
+	__u64 deadline_nsec;
+};
+
+struct syncobj_array_args {
+	__u64 fds;
+	__u64 points;
+	__u32 count;
+	__u32 flags;
+};
+
+struct syncobj_transfer_args {
+	__s32 src_fd;
+	__s32 dst_fd;
+	__u64 src_point;
+	__u64 dst_point;
+	__u32 flags;
+	__u32 pad;
+};
+
+struct syncobj_eventfd_args {
+	__s32 syncobj_fd;
+	__s32 eventfd;
+	__u64 point;
+	__u32 flags;
+	__u32 pad;
+};
+
+struct syncobj_sync_file_args {
+	__s32 syncobj_fd;
+	__s32 sync_file_fd;
+	__u64 point;
+};
+
+#define SYNCOBJ_IOC_BASE		0xCD
+
+#define SYNCOBJ_IOC_CREATE		_IOWR(SYNCOBJ_IOC_BASE, 0, struct syncobj_create_args)
+#define SYNCOBJ_IOC_WAIT		_IOWR(SYNCOBJ_IOC_BASE, 1, struct syncobj_wait_args)
+#define SYNCOBJ_IOC_RESET		_IOW(SYNCOBJ_IOC_BASE,  2, struct syncobj_array_args)
+#define SYNCOBJ_IOC_SIGNAL		_IOW(SYNCOBJ_IOC_BASE,  3, struct syncobj_array_args)
+#define SYNCOBJ_IOC_QUERY		_IOW(SYNCOBJ_IOC_BASE,  4, struct syncobj_array_args)
+#define SYNCOBJ_IOC_TRANSFER		_IOW(SYNCOBJ_IOC_BASE,  5, struct syncobj_transfer_args)
+#define SYNCOBJ_IOC_EVENTFD		_IOW(SYNCOBJ_IOC_BASE,  6, struct syncobj_eventfd_args)
+#define SYNCOBJ_IOC_EXPORT_SYNC_FILE	_IOWR(SYNCOBJ_IOC_BASE, 7, struct syncobj_sync_file_args)
+#define SYNCOBJ_IOC_IMPORT_SYNC_FILE	_IOW(SYNCOBJ_IOC_BASE,  8, struct syncobj_sync_file_args)
+
+#endif /* _UAPI_LINUX_SYNCOBJ_H_ */

-- 
2.54.0

