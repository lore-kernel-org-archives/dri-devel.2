Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4A4CD4F54
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 20:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4688310E3DB;
	Tue, 19 May 2026 20:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="lQU5s627";
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="JNdw+/PN";
	dkim-atps=neutral
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F2710E3DB
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 20:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Cc:To:Subject:Date:From:References:In-Reply-To:Message-ID:Sender:
 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n0hpJfmBe+H1vhGzZwAnLsdgzvMg34OBTLVh3I+WBVU=; b=lQU5s627l2jAAMyXO3W5Yvco2b
 tAZljt+EuNm8zeVkV15tQjkWGoauFs7bByYaw1PmYJeRl21FWcZ9WOR4MhbxCJVzB60/CtKWHPgdQ
 q2A4WgsaUpAav2EUOFACFlPkAhqX0RRpXLqhiX601iewe51uoCsPd/C5YG1adBBZvn5beRFk3s6wB
 bYAtXoytEBq4YW8SFnNv7GuYUqgOza7fB22E1wQE5yB1FXQ/8kpBTrY4XjMqOF70HSqUXnHol4cGa
 zfybHyGl6jtHdW21i2kz3him9q8oQucIQR0zP0t1aFL0oBftd3RrcDcf0lFEF/ttNqfwZ7I2AOcmi
 luKn/uew==;
Received: from localhost by mail-01.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wPQz2-006CJx-0X;
 Tue, 19 May 2026 20:24:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779222239; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=n0hpJfmBe+H1vhGzZwAnLsdgzvMg34OBTLVh3I+WBVU=;
 b=JNdw+/PNzJ60beL8UK21YlQ5IBCyDM2h/8sXeCtJ/UDJBS781DJZ9uELgIyHny83bTNL6
 ytln+pTuStkL5d3T/Up80F8mQa+WpcG+NCzDH1yXdf9AtfXXh5mDwEmC6wgbgSMs8eGUZLp
 PDulYk/N0wqA4XQPboG19SPyE6Fxv9YTZAsyvp4a1pdCbJNscDcVn3HR28Rm7qw27thb8+R
 1Q29wiHhsDruFMBHIsXydn4qQOR/E0vR+tIIMXGW9t0oA2ix31sUYZD14U7pL8TMC+jX5mG
 WAsYecRJhWdZ2m0zbKiJgWRvz8tOKAdeLHrsKfxG8rj/e0o1PSz5FSKWTZ3A==
Message-ID: <e6e63276cca2901641ab39029e4fd3d621b1ee92.1779221799.git.me@berkoc.com>
In-Reply-To: <cover.1779221339.git.me@berkoc.com>
References: <cover.1779221339.git.me@berkoc.com>
From: Berkant Koc <me@berkoc.com>
Date: Tue, 19 May 2026 22:08:53 +0200
Subject: [PATCH v3 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
To: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, K. Y. Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
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

hyperv_receive_sub() reads msg->vid_hdr.type and dispatches into one
of four message-type branches without knowing how many bytes the host
wrote into hv->recv_buf. The completion path then runs
memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE), so the consumer
that wakes on wait_for_completion_timeout() can read up to 16 KiB of
residue from a prior message as if it were the response payload.

Pass bytes_recvd into hyperv_receive_sub() and reject any packet that
does not cover the pipe + synthvid header. For each of the three
completion-driving types (SYNTHVID_VERSION_RESPONSE,
SYNTHVID_RESOLUTION_RESPONSE, SYNTHVID_VRAM_LOCATION_ACK) also
require the type-specific payload before memcpy/complete, and apply
the same rule to SYNTHVID_FEATURE_CHANGE before reading is_dirt_needed.
The memcpy then uses bytes_recvd, which is bounded by
VMBUS_MAX_PACKET_SIZE through the call to vmbus_recvpacket().

Rejected packets are reported via drm_err_ratelimited() rather than
silently dropped, matching the CoCo-hardened pattern in
hv_kvp_onchannelcallback().

Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Cc: stable@vger.kernel.org # 5.14+
Signed-off-by: Berkant Koc <me@berkoc.com>
Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 42 +++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index c3d0ff229..12d3feb4f 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -420,26 +420,62 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
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
+	if (bytes_recvd < hdr_size) {
+		drm_err_ratelimited(&hv->dev,
+				    "synthvid packet too small for header: %u\n",
+				    bytes_recvd);
+		return;
+	}
+
 	msg = (struct synthvid_msg *)hv->recv_buf;
 
 	/* Complete the wait event */
 	if (msg->vid_hdr.type == SYNTHVID_VERSION_RESPONSE ||
 	    msg->vid_hdr.type == SYNTHVID_RESOLUTION_RESPONSE ||
 	    msg->vid_hdr.type == SYNTHVID_VRAM_LOCATION_ACK) {
-		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
+		size_t need = hdr_size;
+
+		switch (msg->vid_hdr.type) {
+		case SYNTHVID_VERSION_RESPONSE:
+			need += sizeof(struct synthvid_version_resp);
+			break;
+		case SYNTHVID_RESOLUTION_RESPONSE:
+			need += sizeof(struct synthvid_supported_resolution_resp);
+			break;
+		case SYNTHVID_VRAM_LOCATION_ACK:
+			need += sizeof(struct synthvid_vram_location_ack);
+			break;
+		}
+		if (bytes_recvd < need) {
+			drm_err_ratelimited(&hv->dev,
+					    "synthvid packet too small for type %u: %u < %zu\n",
+					    msg->vid_hdr.type, bytes_recvd, need);
+			return;
+		}
+		memcpy(hv->init_buf, msg, bytes_recvd);
 		complete(&hv->wait);
 		return;
 	}
 
 	if (msg->vid_hdr.type == SYNTHVID_FEATURE_CHANGE) {
+		if (bytes_recvd < hdr_size +
+		    sizeof(struct synthvid_feature_change)) {
+			drm_err_ratelimited(&hv->dev,
+					    "synthvid feature change packet too small: %u\n",
+					    bytes_recvd);
+			return;
+		}
 		hv->dirt_needed = msg->feature_chg.is_dirt_needed;
 		if (hv->dirt_needed)
 			hyperv_hide_hw_ptr(hv->hdev);
@@ -466,7 +502,7 @@ static void hyperv_receive(void *ctx)
 				       &bytes_recvd, &req_id);
 		if (bytes_recvd > 0 &&
 		    recv_buf->pipe_hdr.type == PIPE_MSG_DATA)
-			hyperv_receive_sub(hdev);
+			hyperv_receive_sub(hdev, bytes_recvd);
 	} while (bytes_recvd > 0 && ret == 0);
 }
 
-- 
2.47.3

