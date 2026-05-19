Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B493CD5BAC
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 13:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F4D10E2F9;
	Sat, 23 May 2026 13:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="Snk5RZ0l";
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="FWqZW+86";
	dkim-atps=neutral
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D0510E2F9
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Subject:Date:Cc:To:From:References:In-Reply-To:Message-ID:Sender:
 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yEgrKS1yuvRt1SapJoA7ktrpyTmlvnKNqxmZJDoUF6o=; b=Snk5RZ0lbfY2zD4XrnFehj7llD
 TsBfM9yHtksiAoNpZ+d4KMVhRyFUXvS2ULL7kQRxVzSz16wFJHpg2PfwoI9+nw3M2904Bjtd1Znu7
 cVg8lrJGneP13Me3T/OYCdkwy9n+Bmj/U9A1woM+WJ34xLQ7FjLE+9437L0vE+efPqTnNQbhvYpz5
 ix9SBx1JAFYAdFUdXo685b/REoz6fyv6Yb3ex27pvn4ZYniI/WzP8sD7PDn0aF8DVO8TvqJlRRfrR
 U4WPl9TdxIgcU++ZBmO6EilKy/Db1Uh64gVcKaAeCJU7aBseJecxuZdQ47hpFHFJEKONVvDSK45L2
 OKfz0oKw==;
Received: from localhost by mail-03.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wQmsu-004mB3-1K;
 Sat, 23 May 2026 13:59:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779544752; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=yEgrKS1yuvRt1SapJoA7ktrpyTmlvnKNqxmZJDoUF6o=;
 b=FWqZW+86/YJ+Hdt8DHHQ2s3zs0tbmTsspFIx94URgEeY8Zf6NqcXikXU22A+f4bUNgd94
 o++WP2q9kJ1k5Hyy6GAHDHJVBsog6N65KvGZdLgS7Y4eY0ZcyjOsbTvkZU8s6wnlvolP/KI
 r2bWLOZbVbM25+7Vs10P4qbpo9xtE491WDeFZKjLI/3nzEasPSiCBRRJr5d5nEpiFDyuRdP
 G1ZV3KGJDKUra4yGpousXkukgDWg8JhpIP16STMSaqZ6jZZGwfatgdIfcF0ZEy9do1FJ7sZ
 XemwDhBYDRWus5S7B1Yg6j3TRb7VkgbLD/XcUw5KGF9vbRBdkD7vb8tr+aqg==
Message-ID: <6945b22419c7d404b4954a113de2ac9c900dba93.1779542874.git.me@berkoc.com>
In-Reply-To: <cover.1779542874.git.me@berkoc.com>
References: <cover.1779542874.git.me@berkoc.com>
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, K. Y. Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Date: Tue, 19 May 2026 22:08:17 +0200
Subject: [PATCH v5 1/2] drm/hyperv: validate resolution_count and fix WIN8
 fallback
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

A SYNTHVID_RESOLUTION_RESPONSE with resolution_count > 64 walks past
the supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT] array in the
parse loop. Bound resolution_count against the array size, folded
into the existing zero-check.

When the WIN10 resolution probe fails, the caller in
hyperv_connect_vsp() left hv->screen_*_max / preferred_* unpopulated,
which sets mode_config.max_width / max_height to 0 and makes
drm_internal_framebuffer_create() reject every userspace framebuffer
with -EINVAL. The pre-WIN10 branch had the same gap for
preferred_width / preferred_height. Use a single post-probe fallback
guarded by screen_width_max == 0 so both paths converge on the WIN8
defaults.

Signed-off-by: Berkant Koc <me@berkoc.com>
Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Cc: stable@vger.kernel.org # 5.14+
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 051ecc526..c3d0ff229 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -391,8 +391,11 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
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
 
@@ -508,9 +511,13 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 		ret = hyperv_get_supported_resolution(hdev);
 		if (ret)
 			drm_err(dev, "Failed to get supported resolution from host, use default\n");
-	} else {
+	}
+
+	if (!hv->screen_width_max) {
 		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
 		hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
+		hv->preferred_width = SYNTHVID_WIDTH_WIN8;
+		hv->preferred_height = SYNTHVID_HEIGHT_WIN8;
 	}
 
 	hv->mmio_megabytes = hdev->channel->offermsg.offer.mmio_megabytes;
-- 
2.47.3

