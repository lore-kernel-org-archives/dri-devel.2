Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40D3CD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 14:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 029F710E27D;
	Sun, 17 May 2026 14:16:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="JQs7UWV+";
	dkim-atps=neutral
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF1CE10E27D
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MQ8YiYdNWpRqmjF8/PofO4sgGjF2gJ1u/rtwQhqBB4A=; b=JQs7UWV+0f8ACDzMvMmCgR0P+M
 RTTcR2fvyyLiN35YD/qnMLGg+S22ZsPGZOZgqz/olECemqjiiGdWEUc4PCuToI8QTEOd3LSaq8bzz
 OHHhyTlaJo/a0tJHLhvikNDv7lDbfOiqzd6Ro1+Q2rFGytyES7TMECdTFh4vRyieuAC1Y6JsvhtEs
 enBLO3JpZZUlhhRgkpPKAZ1fl7cUboQELh8+wNn5KT/Ff9GF5p5TpLuK5ecz6xojdLxkP12heZpYh
 HG1q8c6ejzhm2qkdICdc9kSIwxEgeul/CrJoyHx/csIiUoJ6EqCdj08clvJJO2qy4JWrVwOuUzaI1
 EOvzZ8qA==;
Received: from localhost by mail-01.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wOcHk-00GB2e-1S;
 Sun, 17 May 2026 14:16:05 +0000
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
Subject: [PATCH v2 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Date: Sun, 17 May 2026 16:25:02 +0200
Message-ID: <20260517-drm-hyperv-patch2-v2@berkoc.com>
In-Reply-To: <20260517-drm-hyperv-cover-v2@berkoc.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
 <20260517-drm-hyperv-patch2@berkoc.com>
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

hyperv_receive() reads bytes_recvd from vmbus_recvpacket() but does not
forward that value to hyperv_receive_sub(). The sub-handler reads
msg->vid_hdr.type and msg->feature_chg.is_dirt_needed without knowing
how many bytes the host actually wrote, so a short packet leaves the
parser reading bytes that the host did not write in this packet. The
unconditional memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE) on the
wait-completion path also copies the full 16 KiB recv_buf regardless
of bytes_recvd, including any residue from the prior message.

Pass bytes_recvd into hyperv_receive_sub() and reject any packet shorter
than the pipe + synthvid header. The dirt-feature branch additionally
requires the feature_change payload size before reading is_dirt_needed.
The init_buf copy now uses bytes_recvd as the length argument, which
keeps it bounded by VMBUS_MAX_PACKET_SIZE through the new upper check.

Unchanged from v1.

Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Cc: stable@vger.kernel.org # 5.14+
Signed-off-by: Berkant Koc <me@berkoc.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 3b5065fe06e4..cdab4895dd40 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -423,26 +423,35 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 	return 0;
 }
 
-static void hyperv_receive_sub(struct hv_device *hdev)
+static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
 {
 	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg *msg;
+	size_t hdr_size;
 
 	if (!hv)
 		return;
 
+	hdr_size = sizeof(struct pipe_msg_hdr) +
+		   sizeof(struct synthvid_msg_hdr);
+	if (bytes_recvd < hdr_size || bytes_recvd > VMBUS_MAX_PACKET_SIZE)
+		return;
+
 	msg = (struct synthvid_msg *)hv->recv_buf;
 
 	/* Complete the wait event */
 	if (msg->vid_hdr.type == SYNTHVID_VERSION_RESPONSE ||
 	    msg->vid_hdr.type == SYNTHVID_RESOLUTION_RESPONSE ||
 	    msg->vid_hdr.type == SYNTHVID_VRAM_LOCATION_ACK) {
-		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
+		memcpy(hv->init_buf, msg, bytes_recvd);
 		complete(&hv->wait);
 		return;
 	}
 
 	if (msg->vid_hdr.type == SYNTHVID_FEATURE_CHANGE) {
+		if (bytes_recvd < hdr_size +
+		    sizeof(struct synthvid_feature_change))
+			return;
 		hv->dirt_needed = msg->feature_chg.is_dirt_needed;
 		if (hv->dirt_needed)
 			hyperv_hide_hw_ptr(hv->hdev);
@@ -469,7 +478,7 @@ static void hyperv_receive(void *ctx)
 				       &bytes_recvd, &req_id);
 		if (bytes_recvd > 0 &&
 		    recv_buf->pipe_hdr.type == PIPE_MSG_DATA)
-			hyperv_receive_sub(hdev);
+			hyperv_receive_sub(hdev, bytes_recvd);
 	} while (bytes_recvd > 0 && ret == 0);
 }
 
-- 
2.47.3

