Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB54ACA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB8F10FE2D;
	Fri,  9 Oct 2026 03:18:49 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA30710FE29;
 Fri,  9 Oct 2026 03:18:47 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515842t5bf99465
X-QQ-Originating-IP: EPo9yvjcUKSxfds5pH10PS+8bETia1Xjr/JTyOz/FM8=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1232975757929523936
EX-QQ-RecipientCnt: 30
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:15:57 +0800
Subject: [PATCH v2 05/20] drm/msm/dp: Support multiple generic SDP slots
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-5-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
In-Reply-To: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3697; i=sophon@radxa.com;
 h=from:subject:message-id; bh=zp9J/I3KL2ekRKRZ8uv9r2FRGz6DzqPhr0mZSqbj3oI=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlaUy17ccsbAemrHk8quDZmxgcmqxgUGifWiH5n5U
 npr6zg7SlkYxLgYZMUUWRTiGeayV+ZeeypWqgczh5UJZAgDF6cATCTQieGf9Z2fvZMTV6QYZqeY
 /Zq5b2t2t484/6WsjY57l7PdbmYyYGT40DnzKPOMH7vyVOX3uR+sWjfrsf6yWzX65TofD67zZc1
 lAwA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OMxr5LZhXS0MU8wPwCXiPLjcdXOc14c3engRk5tc6gRAlcGGmPzSzwSq
 NdybTfi7EqgypwJMTTc6rUU60qIajHcobnOj5PFkl5adFnkEFfZ0SdAqpkN1LJ2OJ1TaWn1
 tMQfwTA4KFe15k/0pI1fZKeGuUWRo0PP8VRo07CUpQ7XgO7z2dASl+OO8RTCsfJP/j8X7dK
 oStedkhlsGrsVNF+m/EuOld8OEWaoYsb2Er6We4TlMrem4TdYUjddVPBWOKLVspylcskvEl
 ZaqQxdoPvI7UFY6JsbjZd2Sfr6kyS/ccGJjJOoeP33At064PwNU956fFSBLM5mwIbP9Wj1M
 Zuyttvi+zklpCPD5tcVibctrOd7lYzD5GgSNFEQ8+em+LdRI2+5okv2nfWRX+BhpGFo3EED
 Mi8LygXjp8Tzv9V4bzGx6yiSl9i5cX+8xiTA33zaItkmcN0DSvkA8FJM1AgdQK6F1+g7ScQ
 kUy4uoSWyRcAudnR68UjheLx81HtNGC/mahD98Gx/xKMrzK15oXVhLLuqeNvyg19o7hBzW/
 vk3155D0aKRu75GVNHt8RH6pAO4LyjG+nbVU/qULlko9fmyKUcvjeorUlo45sUXfFFs/xsU
 ndUoplcgmnR/fpbak1Y1KJNaBTovaGDxsxHpkKASY1PHzdosQtleBnAJotDl37jK3pUV8BO
 RVE2okNXGKlSZgEUG5J1KQwCxHFX88IiwvGNVijlzdWuu4yI5S0ew4sQd4W8cD0WEbjv9Bh
 4p66CCZ325XaubkecSnmtWyrnlYswd1QvpoPk3GCORAzzkZOC/pQqFwbPRxCFw9e4c3/eIU
 GBg9Oy0aHIEXscf53N/O0M7Gbssocy+TPnHRCJJ7DRm+1PWBufmBEcQL3zfZ1fuJh0P4ekW
 8JtjQk1vMasrfycca39UtN8jvul0wbAwAhTufRMUAdSXiqm7YpmYbLI61bk95o+sLR8HPNM
 bg/t+cBqd75XBj3oFy0LRiYmAYcDHFylt1uwpB0udAMBX11q57n3mGHU+9PjRusg4gy0NP2
 RgO+KghVIwVvh8KPqdqbJNsMSsofzcgLsofff6v6pNH7mZzfYpXxCA4Rmr+38nR7ef3o/LT
 A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
little-endian loads for the payload words.

The existing VSC packet continues to use Generic0 without changing its
layout or enable sequence.

Assisted-by: LLM
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 22 ++++++++++------------
 drivers/gpu/drm/msm/dp/dp_reg.h   |  4 ++++
 2 files changed, 14 insertions(+), 12 deletions(-)

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

-- 
2.56.0

