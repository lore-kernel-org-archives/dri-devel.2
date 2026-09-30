Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14834CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF3210EA0C;
	Wed, 30 Sep 2026 12:43:38 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52EEE10E9FB;
 Wed, 30 Sep 2026 12:43:36 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772157t7d649573
X-QQ-Originating-IP: Iidu7VP4a111+giCVdqXAJh03guybrfOXCgSuwkCqXQ=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15461729371588361155
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:51 +0800
Subject: [PATCH 07/13] drm/msm/dp: Track validity of cached sink link
 capabilities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-7-dbbf8b2b42bc@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441; i=sophon@radxa.com;
 h=from:subject:message-id; bh=a4IGsafgyKnughPqfb+gTDfDIqsfU4od/9aIZi6cjrE=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZcZ/L2w6UiRRcfjr29veyV82DVTcd/Vk3n+vm8UO
 rmrWruXdJSyMIhxMciKKbIoxDPMZa/MvfZUrFQPZg4rE8gQBi5OAZjIun5GhudXohg/mWb99bDl
 O/I3+QPXtUu7RcvvTW0512fw9ejhwixGhnflF+9WBBg9cp/0NnJhQd/xBtOM90kXr+22jX2k5G8
 ymxEA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MjtcwOZJa0nj6DdlXf8My+47FuyQecZ4OciG14cFiIpqv3ROfFlBQmLj
 uz670Q0YLabEtND3zY8RZZ+mJVBpkm0+VznDRfSECvPUt+pkk1iTBX0lxcDPd8ZioPcAqMv
 FauquwsLD/HNuzJYXUMN8n4GhbvzGzneYIsFB9YO2gF3utJ38U7o+HoZZewPSXUY8uHHzwO
 1ASkSDa3p8o8ej7DanIBAr1cZHslT9LWwyudY14glyExIONR55v4YeajLND4O9OcWLaZMju
 2K2RIpGAYD8+WjHvsZj6xMzXOoyyADKN7mZLbnE1bPscHYpDGqhUWtxnopiR9LgqniKDIuT
 Jw90/qBkGwXatSGS6xfjE9dTwo5qkQZEbWJ4iynHl4tIeOuEj0HO7oWqg3jMbTbZvSU2NGK
 MWdyO25GkqBkHDnNMYf/USPp8lQlihC2rii1CqSsuXkWB61Uw3NoEjPSy+1aRAr7icrZD5/
 tUcatEFlS8hIKtvOg+pNQA6crvOLcix+9x++DXllcuAd5ct5uvcZc97LwIq3QZDJCmgBGYP
 spLp1rbRXAsJlHdK/kpheeHMvN6Kx71AJR9FlqdcvMSI3eIXpQoizRFssBN4IldCGT3MWlN
 yK1wJHHianqkychDszbk3lXtvhuvAYVWVUlUIIqiKdC4Y0yf5HwK8PChAWQA8r0WzzU0uFN
 jmy0EoF166BWG1WODZTH2jgWSqD2Zku3Kvc3YepGuAqHB+A5XWdHL+Zs+XBMFeB5MT5urj7
 41txS+e0GMJYyIXRhnqpNvkrThbEOsbFMWL88oehiA4jVyFS5YD5NSaycob72lX1Zv1ErEx
 p2p2lq3XWlIG8URgjmQ7r+368OlICkqqz8tPi2Mxe5y40dId79+HlClFdSB9DhSNbXRLWD1
 P1pBCx4oZh78A86xnaRGQbcufRSDEI/yfFHOedyUNhben1E0eGEkjSnztEx/HLPI0GPVGMw
 fZi4EDFM9f65pZ18TMPazGBwBLejB5F4D6zi+6xQxdLxPc7nBJBfEc2OjdvzgAPaygEPB3r
 uPVX9nx3KdV0niXB1Ux449agOzESTVbI02057tuwJxlYDhn4wRv4bu2IhbfP4d1xldVW625
 QXSROZQgxhm
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

An eDP panel may not have been powered up when its mode is checked, and a
disconnected DP sink can leave cached link capabilities behind. The cached
values alone do not distinguish either case from a current read.

Track whether link capability discovery completed successfully. Clear the
flag before reading capabilities and on unplug, and set it only after the
downstream information has been read successfully. Subsequent atomic
checks can then defer checks against unknown capabilities until the sink
is accessible.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 1 +
 drivers/gpu/drm/msm/dp/dp_panel.c   | 3 +++
 drivers/gpu/drm/msm/dp/dp_panel.h   | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1bfa6696d904..9c5b1cd200f8 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -519,6 +519,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
+	dp->panel->link_caps_valid = false;
 	if (!dp->plugged)
 		return 0;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index fdf1a3f437ba..f7aac0d25c87 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -247,6 +247,7 @@ int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
 
 	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
 
+	msm_dp_panel->link_caps_valid = false;
 	rc = msm_dp_panel_read_dpcd(msm_dp_panel);
 	if (rc) {
 		DRM_ERROR("read dpcd failed %d\n", rc);
@@ -272,6 +273,8 @@ int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
 
 	rc = drm_dp_read_downstream_info(panel->aux, msm_dp_panel->dpcd,
 					 msm_dp_panel->downstream_ports);
+	if (!rc)
+		msm_dp_panel->link_caps_valid = true;
 	return rc;
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 4519ac374220..4fe6af8b304e 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -38,6 +38,7 @@ struct msm_dp_panel {
 	struct msm_dp_panel_psr psr_cap;
 	bool video_test;
 	bool vsc_sdp_supported;
+	bool link_caps_valid;
 	u32 hw_revision;
 
 	u32 max_bw_code;

-- 
2.55.0

