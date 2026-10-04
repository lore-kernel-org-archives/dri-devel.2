Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F473CA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C49910E064;
	Sun,  4 Oct 2026 12:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="xKmyoDQE";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-249.mta0.migadu.com [91.218.175.249])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C99810E064
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 12:06:43 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=/wDs7AqCXjro1en1uYeNesaW+AzN410aG4sQHsUGAvU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791115601; v=1; x=1791720401;
 b=xKmyoDQErtqdNVkOtN66A6MAWRuKHoEzsc/UURfgupf5OhObVMrv+dXPNL1dQ34ID+ycUuMf
 ujnGS+GWbXiQcqE0RF8ZIgl8os9oMP98C+BtSLQQ2PeFTLf6ax2X6YaeviW8/QDs3yEKeB2wfE1
 ULzuDxjokHdoiyjI/0KDUs2k=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 95ef59e2b8d83611;
 Sun, 04 Oct 2026 12:06:31 +0000
X-Mizu-Trace-ID: 95ef59e2b8d83611
X-Migadu-Flow: FLOW_OUT
Message-ID: <586d0b39-40c8-4f3d-a786-c1085f87b858@linux.dev>
Date: Sun, 4 Oct 2026 17:36:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] drm/appletbdrm: Add suspend and resume support
To: vasilij.kernel@tototo.si, Aun-Ali Zaidi <admin@kodeit.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Kerem Karabay <kekrby@gmail.com>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
References: <20260924-appletbdrm-pm-v1-1-0e5432132161@tototo.si>
Content-Language: en-US
From: Aditya Garg <aditya.garg@linux.dev>
In-Reply-To: <20260924-appletbdrm-pm-v1-1-0e5432132161@tototo.si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

From: Vasilij Markin <vasilij.kernel@tototo.si>

The driver has no USB power management callbacks, so the USB core
unbinds it before system suspend and binds it again on resume. The DRM
device is unregistered and registered again on every suspend and resume
cycle, userspace driving the Touch Bar through it (such as tiny-dfr)
loses its device, and the Touch Bar stays dark after resume.

Implement suspend and resume with drm_mode_config_helper_suspend() and
drm_mode_config_helper_resume(), so the device stays registered and the
last committed state is restored on resume. If the device was reset
while suspended, repeat the probe-time handshake first.

Fixes: 0670c2f56e45 ("drm/tiny: add driver for Apple Touch Bars in x86 Macs")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Vasilij Markin <vasilij.kernel@tototo.si>
Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
---
v2: Remove reset_resume

 drivers/gpu/drm/tiny/appletbdrm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
index ef71b9957..c94ed1068 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -30,6 +30,7 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_modeset_helper.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -821,6 +822,20 @@ static void appletbdrm_shutdown(struct usb_interface *intf)
 	drm_atomic_helper_shutdown(&adev->drm);
 }
 
+static int appletbdrm_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct appletbdrm_device *adev = usb_get_intfdata(intf);
+
+	return drm_mode_config_helper_suspend(&adev->drm);
+}
+
+static int appletbdrm_resume(struct usb_interface *intf)
+{
+	struct appletbdrm_device *adev = usb_get_intfdata(intf);
+
+	return drm_mode_config_helper_resume(&adev->drm);
+}
+
 static const struct usb_device_id appletbdrm_usb_id_table[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x05ac, 0x8302, USB_CLASS_AUDIO_VIDEO) },
 	{}
@@ -832,6 +847,8 @@ static struct usb_driver appletbdrm_usb_driver = {
 	.probe		= appletbdrm_probe,
 	.disconnect	= appletbdrm_disconnect,
 	.shutdown	= appletbdrm_shutdown,
+	.suspend	= appletbdrm_suspend,
+	.resume		= appletbdrm_resume,
 	.id_table	= appletbdrm_usb_id_table,
 };
 module_usb_driver(appletbdrm_usb_driver);
-- 
2.53.0
