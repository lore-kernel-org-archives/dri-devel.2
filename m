Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442FCCD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 14:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA44910E27C;
	Sun, 17 May 2026 14:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="fu9d1BKu";
	dkim-atps=neutral
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A92F10E27C
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gTqRY6sQfKZTTJNrPsag8pd2dprTtNMTjuf+gLE+BZk=; b=fu9d1BKuMdBjtrqIvVOiANgRiE
 4QKyasC9whyRqUh2xU0NBLLeXTjYfE9oMuLVYJEeisQ2QOGNx4O/fi+h1NGRXxxm/suDMJONWLoO7
 tCNnqP+D525EUzpXvy7EZxdC/lRIRfHWBVODG/Sq5lUbl/Kc8rWsZSz+qn0laVlhqju0nxqDSXF7/
 9y7oLQM2UCyqI2vUc0+M3Agh5K/l8HTaZX8QhBMPQH5Wrw8nfszmVHjnnbwDnb5TNLOpOlC6HmSpU
 FV/9/t01dRQSW858P2h28v63VdyJf+ui9GPRgboNw+drgUFLwvkMzVdvQ3qiamzZokjzi937lWVnY
 duKN8bog==;
Received: from localhost by mail-03.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wOcHU-00HFWk-1I;
 Sun, 17 May 2026 14:15:49 +0000
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/hyperv: validate resolution_count and harden VSP
 request paths
Date: Sun, 17 May 2026 16:25:01 +0200
Message-ID: <20260517-drm-hyperv-patch1-v2@berkoc.com>
In-Reply-To: <20260517-drm-hyperv-cover-v2@berkoc.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
 <20260517-drm-hyperv-patch1@berkoc.com>
 <20260517134926.B4179C2BCB0@smtp.kernel.org>
 <20260517-drm-hyperv-cover-v2@berkoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: git-send-email/2.47.3
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
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

The synthetic video device parses a SYNTHVID_RESOLUTION_RESPONSE that
contains a u8 resolution_count and a u8 default_resolution_index. The
existing check rejects resolution_count == 0 and an index greater or
equal to resolution_count, but does not bound resolution_count itself
against the fixed supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT]
array. A host that returns resolution_count > 64 together with an
in-range default_resolution_index causes the subsequent loop to read
past the array. Reject any resolution_count that exceeds the array
bound, folded into the existing zero-check so a single log entry
remains per failure.

When that bounds check (or any later failure in
hyperv_get_supported_resolution()) returns an error, the caller in
hyperv_connect_vsp() previously logged a warning and continued without
populating hv->screen_width_max / hv->screen_height_max / preferred_*.
hyperv_mode_config_init() then set dev->mode_config.max_width and
max_height to 0, which makes drm_internal_framebuffer_create() reject
every userspace framebuffer with -EINVAL. Populate the fields with the
WIN8 defaults that the pre-WIN10 branch already uses so a failed
resolution probe degrades to a usable display instead of disabling it.

The driver also issues three sequential VSP requests (negotiate
version, update VRAM location, get supported resolution) that share a
single hv->wait completion. None of the call sites call
reinit_completion() between requests. If wait_for_completion_timeout()
returns 0 but a delayed response later triggers complete(&hv->wait) in
the receive callback, the next request's wait can consume that stale
completion, return immediately, and parse stale data out of
hv->init_buf. Call reinit_completion() before each send so every
request waits for its own response.

Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Cc: stable@vger.kernel.org # 5.14+
Signed-off-by: Berkant Koc <me@berkoc.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 051ecc526832..3b5065fe06e4 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -223,6 +223,7 @@ static int hyperv_negotiate_version(struct hv_device *hdev, u32 ver)
 	msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
 		sizeof(struct synthvid_version_req);
 	msg->ver_req.version = ver;
+	reinit_completion(&hv->wait);
 	hyperv_sendpacket(hdev, msg);
 
 	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
@@ -257,6 +258,7 @@ int hyperv_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp)
 	msg->vram.user_ctx = vram_pp;
 	msg->vram.vram_gpa = vram_pp;
 	msg->vram.is_vram_gpa_specified = 1;
+	reinit_completion(&hv->wait);
 	hyperv_sendpacket(hdev, msg);
 
 	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
@@ -383,6 +385,7 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 		sizeof(struct synthvid_supported_resolution_req);
 	msg->resolution_req.maximum_resolution_count =
 		SYNTHVID_MAX_RESOLUTION_COUNT;
+	reinit_completion(&hv->wait);
 	hyperv_sendpacket(hdev, msg);
 
 	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
@@ -391,8 +394,11 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 		return -ETIMEDOUT;
 	}
 
-	if (msg->resolution_resp.resolution_count == 0) {
-		drm_err(dev, "No supported resolutions\n");
+	if (msg->resolution_resp.resolution_count == 0 ||
+	    msg->resolution_resp.resolution_count >
+	    SYNTHVID_MAX_RESOLUTION_COUNT) {
+		drm_err(dev, "Invalid resolution count: %d\n",
+			msg->resolution_resp.resolution_count);
 		return -ENODEV;
 	}
 
@@ -506,8 +512,13 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 
 	if (hyperv_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
 		ret = hyperv_get_supported_resolution(hdev);
-		if (ret)
+		if (ret) {
 			drm_err(dev, "Failed to get supported resolution from host, use default\n");
+			hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
+			hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
+			hv->preferred_width = SYNTHVID_WIDTH_WIN8;
+			hv->preferred_height = SYNTHVID_HEIGHT_WIN8;
+		}
 	} else {
 		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
 		hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
-- 
2.47.3

