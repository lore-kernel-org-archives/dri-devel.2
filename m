Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53AECA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 439D210FE29;
	Fri,  9 Oct 2026 03:19:42 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4318310FE29;
 Fri,  9 Oct 2026 03:19:40 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515882t0fd3316f
X-QQ-Originating-IP: XXNfWD6sBCjyqaCfOai782WfGgGzZkkZ7WXlzuAHYJ8=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12552488957466588621
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:16:07 +0800
Subject: [PATCH v2 15/20] drm/msm/dp: Flush VSC updates when leaving YUV420
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-15-1835d4966da3@radxa.com>
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
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3407; i=sophon@radxa.com;
 h=from:subject:message-id; bh=Z9h8OALLyQT16FzQH0lJ854H/RrF3oqTzDkmSpjnkKg=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlb1VPj7TlmssD18z5dZVp5Ppsnl555o3H0o43fcB
 ObaR1emd5SyMIhxMciKKbIoxDPMZa/MvfZUrFQPZg4rE8gQBi5OAZhI73OGP/zX8mwuvhZWVrnI
 7bFGYuPsY+HM55Xnmi62Pr/Ir+V41j9Ghon8wfmbPuw8te/9xiPC/eobRRgEtL9c6PXaL+ncdvT
 zUVYA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NQzH8pzEc5hGI+mOX+sK8WrWJPiXdgZBqb4S/aI847o2PN74zOn4/+d7
 nu6c/ZCPnsuBOcjYM1lZMrkU9eCoU8EKmTeLTA5PiAno/vbO7b6OR4CYnDuv9vwxCnaNH2n
 h13lZDuzh11BN5O5RsNbRk1D1hgEOUtY41aRLuerobWBMOxMQw9ULMWsTO47f3PCYOkNAU9
 lLciuC05nAt+PlZrawBsO6uRYmgyfgRDR30hmUqOu3vaKt1slEj97md+IY/YncdzILGNKqL
 IZ8AgXSi1Sdw9BOqbU7K8mmQZqQAhmMUKI0+vbyqe++GfTKYhhTbVAxBWf6VPj9n/hNXC9Q
 DBjifgsP+u46xlHC3zXqAFEIexUUpVq2HuVdxtxVRMjCMn2IFfxd8/cRCsuy6J/VbgNE4CE
 2lXyQ+jqpMx8rOQbQzFuVgE+puxmE81plYCXHwFtt/xILO3ygBiTX+xRUZbm6tOpPhN2ETZ
 EZpKxW/Lo88Jx681N5obJJSecrlAJMkSdxloc8ock/x25kAiRHc7NPVjjuG2soT6p3fESpr
 1TqhPNKfnIpUfHZ3ZjECipOy75WRq7hdnV82lVjArmp4ft1pa74OF0k1vZxDT20/vhs1ZF0
 9j9W8ebEzznvJ1F6r1Or0FuVz0nsx809siX35oE96SQ3iAf8DE2ntmujk+gVx3HaTwO6d34
 gRpFbQkT4cm4FdMh01PJ0gz9QiQbLDzvk3YC6P2SgQkar7QX1/KUEBGhOB+tkQ71i2M1dv2
 ctzYP+o86XAe7zoV9Dfkn9IjbsekA7os2or0iGc034TyH/xxXx3pFVYzNv9bjg9cFivFIFx
 47ST+L3ZvCo6GEuiY7zuMOcK7hzwZI0EJfiO6Pg/e1WlxsLVbORuMSD2M6HDc71qDVogki2
 43lJ0Y+GDwl3AJsvW4e7J+Hnpw9hzRTBb59h+HLTP7wwNmNy8AJFntVcmDr7OSvQ84418Nu
 W4DMF60S3TUG2jrBVbT0ru5od0YusMxM+hTXrKb5gbumO9IkChz4KWDCV6fJworqjg0o3LN
 U5W3fGxYyu8nDRYcJNBOr/dpMEltSsejOpt3+Ta4T1FE565wiXEJMwyfbyHpWN//QGSsUht
 Q==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

Peripheral flush is currently requested only for the new YUV420 mode.
Returning to RGB also changes SDP state and must remove the old VSC
packet rather than leaving its enable bits set.

Track whether either stream needs VSC and request peripheral flush for
both enabling and removing it. Explicitly disable VSC for RGB, and write
the packet payload before enabling transmission. Retain the existing
hardware-specific SDP update mechanism.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 7 ++++++-
 drivers/gpu/drm/msm/dp/dp_panel.c   | 6 ++++--
 drivers/gpu/drm/msm/dp/dp_panel.h   | 1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1f9595ff5fd9..486348113b8a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -691,6 +691,8 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	else
 		bpp = state->bpp;
 
+	msm_dp_panel->sdp_needs_flush = msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ||
+		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode);
 	msm_dp_panel_init_panel_info(msm_dp_panel, adjusted_mode, bpp ? bpp : 24);
 
 	/* populate wide_bus_support to different layers */
@@ -1557,7 +1559,10 @@ void __exit msm_dp_unregister(void)
 bool msm_dp_needs_periph_flush(const struct msm_dp *msm_dp_display,
 			       const struct drm_display_mode *mode)
 {
-	return drm_mode_is_420_only(&msm_dp_display->connector->display_info, mode);
+	struct msm_dp_display_private *dp = container_of(msm_dp_display,
+					struct msm_dp_display_private, msm_dp_display);
+
+	return dp->panel->sdp_needs_flush;
 }
 
 bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index af05441bc32a..026074cafc88 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -526,14 +526,14 @@ void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sd
 	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2);
 	misc = msm_dp_read_link(panel, REG_DP_MISC1_MISC0);
 
+	msm_dp_panel_send_sdp(panel, vsc_sdp, MMSS_DP_GENERIC0_0);
+
 	cfg |= GEN0_SDP_EN;
 	msm_dp_write_link(panel, MMSS_DP_SDP_CFG, cfg);
 
 	cfg2 |= GENERIC0_SDPSIZE_VALID;
 	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2, cfg2);
 
-	msm_dp_panel_send_sdp(panel, vsc_sdp, MMSS_DP_GENERIC0_0);
-
 	/* indicates presence of VSC (BIT(6) of MISC1) */
 	misc |= DP_MISC1_VSC_SDP;
 
@@ -686,6 +686,8 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 
 	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
 		msm_dp_panel_setup_vsc_sdp_yuv_420(msm_dp_panel);
+	else
+		msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	panel->panel_on = true;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index a5cb8a4a9498..31752895f124 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -42,6 +42,7 @@ struct msm_dp_panel {
 	bool link_caps_valid;
 	/* All capability reads completed; eDP can reuse the full cache. */
 	bool caps_cached;
+	bool sdp_needs_flush;
 	u32 hw_revision;
 
 	u32 max_bw_code;

-- 
2.56.0

