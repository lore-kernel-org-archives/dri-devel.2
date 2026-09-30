Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21BACA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B97010E9FB;
	Wed, 30 Sep 2026 12:44:53 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA41C10F385;
 Wed, 30 Sep 2026 12:44:46 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772143t79ee699b
X-QQ-Originating-IP: zOO+HqN63uHDLco1J9sZubYYQJGF3SjCLO8JhGcq5sM=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12881138118086274213
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:46 +0800
Subject: [PATCH 02/13] drm/msm/dp: Support multiple generic SDP slots
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-2-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
In-Reply-To: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4973; i=sophon@radxa.com;
 h=from:subject:message-id; bh=q8kaetrGFNEPEL5KF0HC44382x67d587QU+JcdIqgLQ=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZcu/85/2tdX97t8pl9mun9n6OeTbq33P2w5rnUk8
 15imOaWjlIWBjEuBlkxRRaFeIa57JW5156KlerBzGFlAhnCwMUpABOZNYmRod03TbeCeXvhtvj+
 rW77jqjUN29wnZGotqFMPOUB++GGWIa/Yl/XFC/4rtJS4xJUnhl5Yl9Tw4ZJ/1IMDllP0Uz3iP7
 PAwA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NhdiEwnVOUqE1gnLn6MZhwV6u6VX9ARHdX25nGpIWkmWq3+uJ0bRCKZj
 3Vx1uqzWXDPvdoXOlZgt2N1L2mGgdzs2wCrd0Ej07P3iYaWUitq2zGXALxP7Eu0lWGHYOkl
 IiQQ4ZE5+IAPgd27ILbwxY+KE05eHf2K0yPWwRU8miox/Sw7WkpQiqFpCuhRJCt67RK/OlT
 /VZdhNDtkIcAmm9pgu1ec7Cfab0W9P/AIJvpdyj9UA2/LSPpySAZfmFJSG07ziqI+9bZkoH
 +cY+XMyO+mc59RtP8oTvL8PQUSpgrTA0Q0EjVoQuhEJod7vBomeFfXzAQBWbTZsQC4nKeM6
 Ejz9fmdFUKv8p5CHgyib4vWPjO8eVFLp/8pahgcXxxXo0oNeBgZz4tXlCFSv0tbgwhUFvju
 tsabVgjti6irPGK8ckQ/oANRSTTdp6JmA8odXGJhqOntxUV8q17zsTVZtsEdzCtA8X1sjAs
 89eSP5OLf2pBGO0q+Xd/vuEPb5LkCfsHekcQu8WBYJgZc3jgTXu0fR3AHu36FuzMhuH1UUm
 2Ix6mRZ8vOPHbVbWzeY9rKdD2zZdYyjzB5WIw96Xi02ezE4mbvQjEJDtxVJUIfiXWuOvD/N
 3bKCasJpdsUY1mk4OZTxOgZ0pfc9zAhGMRV/73vrugCxyC9jKKFsnac6eAVu1nApES8QkWF
 aaEdiGzUC2LpppqiHRlUbmfHCytmkIe0EGPswbfnir8lhv1Q7gn8Dp6UzkwG8ix6AEg3jhD
 ADxgu6ejIOTGGjjMOeyb9FSZyWZxTjlaWIA12sPvRIIAbA89KCgHzfjcshfUvI5RSAi43Dx
 wHOW+c7vormpX0AbsfSR9a+UKVNDVWHAcuLptpuCfVMloOmor+XpGKu22xMHjvdT6RL6PYl
 4J8tboVmP+BcePt5O59Liz7oQg9epbHmVR7Lbq2Rhp7a3eObFFaBR0giIBL1f3zApZOL0ww
 XkpwAawq5e7cvPKEn0aZEAI8QA0FTWeEJ9W59xAHwAvVYfIymwagxFznRhf+JV5Kb1YwUxr
 4vi91K2yeJoTmON6TzTTwSqo9MaXE=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
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

The SDP writer currently targets Generic0 for VSC packets. Static HDR
metadata needs a separate slot so that both packets can be sent on the
same stream.

Allow the SDP writer to address a generic packet slot, and define the
Generic2 registers needed for static HDR metadata. Use unaligned
little-endian loads for the payload words and accept a const SDP header.

The existing VSC packet continues to use Generic0 without changing its
layout or enable sequence.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 22 ++++++++++------------
 drivers/gpu/drm/msm/dp/dp_reg.h   |  4 ++++
 drivers/gpu/drm/msm/dp/dp_utils.c |  3 ++-
 drivers/gpu/drm/msm/dp/dp_utils.h |  3 ++-
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index e76dad0f6663..fdf1a3f437ba 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -14,6 +14,7 @@
 
 #include <linux/io.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <asm/byteorder.h>
 
 #define DP_INTF_CONFIG_DATABUS_WIDEN     BIT(4)
@@ -442,22 +443,19 @@ void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel)
 	msm_dp_write_p0(panel, MMSS_DP_DSC_DTO, 0x0);
 }
 
-static void msm_dp_panel_send_vsc_sdp(struct msm_dp_panel_private *panel, struct dp_sdp *vsc_sdp)
+static void msm_dp_panel_send_sdp(struct msm_dp_panel_private *panel,
+				  const struct dp_sdp *sdp, u32 base)
 {
 	u32 header[2];
-	u32 val;
 	int i;
 
-	msm_dp_utils_pack_sdp_header(&vsc_sdp->sdp_header, header);
+	msm_dp_utils_pack_sdp_header(&sdp->sdp_header, header);
+	msm_dp_write_link(panel, base, header[0]);
+	msm_dp_write_link(panel, base + 4, header[1]);
 
-	msm_dp_write_link(panel, MMSS_DP_GENERIC0_0, header[0]);
-	msm_dp_write_link(panel, MMSS_DP_GENERIC0_1, header[1]);
-
-	for (i = 0; i < sizeof(vsc_sdp->db); i += 4) {
-		val = ((vsc_sdp->db[i]) | (vsc_sdp->db[i + 1] << 8) | (vsc_sdp->db[i + 2] << 16) |
-		       (vsc_sdp->db[i + 3] << 24));
-		msm_dp_write_link(panel, MMSS_DP_GENERIC0_2 + i, val);
-	}
+	for (i = 0; i < sizeof(sdp->db); i += 4)
+		msm_dp_write_link(panel, base + 8 + i,
+				  get_unaligned_le32(&sdp->db[i]));
 }
 
 static void msm_dp_panel_update_sdp(struct msm_dp_panel_private *panel)
@@ -487,7 +485,7 @@ void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sd
 	cfg2 |= GENERIC0_SDPSIZE_VALID;
 	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2, cfg2);
 
-	msm_dp_panel_send_vsc_sdp(panel, vsc_sdp);
+	msm_dp_panel_send_sdp(panel, vsc_sdp, MMSS_DP_GENERIC0_0);
 
 	/* indicates presence of VSC (BIT(6) of MISC1) */
 	misc |= DP_MISC1_VSC_SDP;
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index dda4b642c81b..6767a215b662 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -232,10 +232,12 @@
 #define MMSS_DP_AUDIO_CTRL_RESET		(0x00000214)
 
 #define MMSS_DP_SDP_CFG				(0x00000228)
+#define GEN2_SDP_EN				BIT(19)
 #define GEN0_SDP_EN				(0x00020000)
 #define MMSS_DP_SDP_CFG2			(0x0000022C)
 #define MMSS_DP_AUDIO_TIMESTAMP_0		(0x00000230)
 #define MMSS_DP_AUDIO_TIMESTAMP_1		(0x00000234)
+#define GENERIC2_SDPSIZE_VALID			BIT(20)
 #define GENERIC0_SDPSIZE_VALID			(0x00010000)
 
 #define MMSS_DP_AUDIO_STREAM_0			(0x00000240)
@@ -291,6 +293,8 @@
 #define MMSS_DP_GENERIC1_8			(0x00000348)
 #define MMSS_DP_GENERIC1_9			(0x0000034C)
 
+#define MMSS_DP_GENERIC2_0			(0x000003D8)
+
 #define MMSS_DP_VSCEXT_0			(0x000002D0)
 #define MMSS_DP_VSCEXT_1			(0x000002D4)
 #define MMSS_DP_VSCEXT_2			(0x000002D8)
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.c b/drivers/gpu/drm/msm/dp/dp_utils.c
index 4a5ebb0c33b8..226b370ce8fe 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.c
+++ b/drivers/gpu/drm/msm/dp/dp_utils.c
@@ -74,7 +74,8 @@ u8 msm_dp_utils_calculate_parity(u32 data)
 	return parity_byte;
 }
 
-void msm_dp_utils_pack_sdp_header(struct dp_sdp_header *sdp_header, u32 header_buff[2])
+void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
+				  u32 header_buff[2])
 {
 	header_buff[0] = FIELD_PREP(HEADER_0_MASK, sdp_header->HB0) |
 		FIELD_PREP(PARITY_0_MASK, msm_dp_utils_calculate_parity(sdp_header->HB0)) |
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.h b/drivers/gpu/drm/msm/dp/dp_utils.h
index 2e4f98a863c4..2fdb89efc57c 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.h
+++ b/drivers/gpu/drm/msm/dp/dp_utils.h
@@ -31,6 +31,7 @@
 u8 msm_dp_utils_get_g0_value(u8 data);
 u8 msm_dp_utils_get_g1_value(u8 data);
 u8 msm_dp_utils_calculate_parity(u32 data);
-void msm_dp_utils_pack_sdp_header(struct dp_sdp_header *sdp_header, u32 header_buff[2]);
+void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
+				  u32 header_buff[2]);
 
 #endif /* _DP_UTILS_H_ */

-- 
2.55.0

