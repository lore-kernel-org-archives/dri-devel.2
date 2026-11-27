Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85B606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOgDVuq9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E101129E1;
	Fri, 27 Nov 2026 10:27:56 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A164511299A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:14:32 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso56872735e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795774471; x=1796379271; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8+PAwb+mXQI4gAhMwD/y+lNTC9Q12C33hVekcKZeeF4=;
 b=GOgDVuq9GbdF/i7Fn51654KljNoV3LTYuVtA7xjLPNRFOf0TwNTenshCob9Y6H09Bg
 13E3GmFSdXk8HQ4zMVRxqDZbvociU/+B37qKVMU6G/wtkA017qUwMh3MKIGKcXAl8RIx
 amyGySG6x0h16krdpam7PrdXtl5fGyPEUcfvkG87B664d3jMlYajJmnsDnHFmbXyyEmF
 UU8eVT7PClBNNQaZISggr/U1JIIs8an0d7m7wILm05UGn+xtF3PRAqbj1v6EX5vGzuxs
 +B1KOBw4NbGPLemLTDkhLQh3/3TPmKq5pMqghyCrZiyVObhhtY8xfBC0vywujCfDNgDe
 TRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774471; x=1796379271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8+PAwb+mXQI4gAhMwD/y+lNTC9Q12C33hVekcKZeeF4=;
 b=DfcIVNuwnt+544oyk9JBY0QK1RkR9poBVHDdi5f2x1lxzncuCVAcfCYuuEP0sIRy06
 hmlAuTIFhUmvah7iEKiA7JRnUOGiJSAq/QOT+mPD32h7dZrJn5WcbBxbXbRGEoEOAH52
 A9IHnCr1yEaHiJff1fWXy+hI8Z8g9SgkffwttwNSzvVjcjE7MTOdhuzEpVM/ml5lq1Kq
 yaeVOfWSvlRJPPmVjIhjTAj9pOlWaPBzQ3JQAdtfn30YI8a/a2d5KyQ/tm/V+h04Rs/b
 wl16WpMGjMjwxEbwlc6z4ZbsnUgFxj7CTx4Z+PYacBD/exIbMZ79TfY0AN6sY0eneUjy
 hF7w==
X-Forwarded-Encrypted: i=1;
 AL+hErHin3m0xVn3vYbCWBldI78WdFeClTfHclNNplyO1IKM9h/orFIxqekwRmLllsYYm362VrmGR35t4AY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ciQNoxz7HqdBcmDOFo7a3B2qya7IFDqjBzoOrMtzaTdS9MkXQ
 79uXmAbpZ+YKe0jORwgWU4zbh8BhzNZR9D8UWXjN4lLUBtnac68t3Dk=
X-Gm-Gg: AZFdTZf09kmqRJrHdqEcWOh2KLgriBILu4/MAwKnCpIB4CLaYp2tOUcHE6DGlNe4iUD
 bzkVUiuZmlEktPGRR3f33WYBDLgyukFv2RtLe/a3mXgNnzWRL+hdx2N0wLwA2ASBh92Grq6b0ia
 HkXMA9o+WOzYvqp2WfLYQNkomQViQ3QKd7OFT6fVpQ5Q/sCmwZpImgb4QGFAPWEo0UZ6I5kTf8s
 6xhlf0Qi8vXsKr/fwRTP2AElT4x3S9z+siRfrUvIXArSSpLRzKYzClL7XAiyv8J/5oKGw8fWQdY
 MokqicWtxyYeEqOx4pqIdlycc+yJXu8tsjt9Xi6p4NdTd2oUbiFDqwqChaVmrdAfcEeGq5Qm61x
 IN2nOi3L30T1yaWz9JoZp0YKYHwKiP+yu2sxAml41enVQcdx4h4XnjcrQgff8ixk8ND9nxwGKjZ
 PO1RxNdhdDzou5LMwkafrsvcSRAAcwute3kCn0pTMt406BnwCKFwnvkWlPAzsTUbd16h6N349pG
 OZT5CIPoUu7AW1ikkZp1NUS7yeNYoWQWpKILa4ZvuR2rd9QRxy3kQTbyDBCCw8cX1u/hHdggbDG
 uF2dPBofkSsVCgkuqc4KTxir0Rjzxxw+UCAQ36GK6iZo343ncHlkDEMmPCNR3CFkbLFRJiC0uBn
 wvBHRx6gq2Vnc6qL2RmSeCGnB5XAw0W19861zCxWInjGClsVqta0Z1ogenzfF
X-Received: by 2002:a05:600c:3ba4:b0:4ba:493b:3401 with SMTP id
 5b1f17b1804b1-4bb8880abafmr574459845e9.9.1795774470905; 
 Fri, 27 Nov 2026 02:14:30 -0800 (PST)
Received: from localhost.localdomain
 (host-94-89-17-99.business.telecomitalia.it. [94.89.17.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm43651234f8f.26.2026.11.27.02.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:14:30 -0800 (PST)
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
 Dale Whinham <daleyo@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Subject: [PATCH v2 06/10] drm/msm/dp: track DP_SINK_COUNT capability and sync
 prev_sink_count
Date: Fri, 27 Nov 2026 11:14:13 +0100
Message-Id: <20261127101417.24303-7-gianfranco.mariotti94@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
References: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 10:27:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

msm_dp_panel_read_link_caps() only checked DP_SINK_COUNT on branch
devices (without checking count < 0 for AUX errors or updating
panel->link->sink_count when non-zero), while
msm_dp_link_parse_sink_status_field() unconditionally read DP_SINK_COUNT
on every sink.

On non-branch SST sinks that do not implement DP_SINK_COUNT and return 0
at DPCD 0x200, sink_count stayed 0 or flipped between 1 and 0 on
subsequent IRQ_HPD requests, causing msm_dp_display_prepare_link() to
bail out with -ENOTCONN or msm_dp_link_process_ds_port_status_change()
to misclassify link maintenance pulses as DS_PORT_STATUS_CHANGED.

Query drm_dp_read_sink_count_cap() in msm_dp_panel_read_link_caps() and
record it in link->has_sink_count, default sinks without DP_SINK_COUNT
support to sink_count = 1, keep sink_count and prev_sink_count
synchronized via msm_dp_link_set_sink_count(), and clear both on unplug.

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
Fixes: b7ba5db9c863 ("drm/msm/dp: Use drm_dp_read_sink_count() helper")
Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c |  3 +++
 drivers/gpu/drm/msm/dp/dp_link.c    | 26 +++++++++++++++++++++-----
 drivers/gpu/drm/msm/dp/dp_link.h    |  2 ++
 drivers/gpu/drm/msm/dp/dp_panel.c   | 19 +++++++++++++++----
 4 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 3c15f984b29e..7831dd13b067 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -477,6 +477,9 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 	if (dp->link->sink_count == 0)
 		msm_dp_display_host_phy_exit(dp);
 
+	dp->link->has_sink_count = false;
+	msm_dp_link_set_sink_count(dp->link, 0);
+
 	/*
 	 * We don't need separate work for disconnect as
 	 * connect/attention interrupts are disabled
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 34a91e194a12..b619707b8e3b 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -720,12 +720,16 @@ static int msm_dp_link_parse_sink_status_field(struct msm_dp_link_private *link)
 	int ret;
 
 	link->prev_sink_count = link->msm_dp_link.sink_count;
-	ret = drm_dp_read_sink_count(link->aux);
-	if (ret < 0) {
-		DRM_ERROR("DP parse sink count failed\n");
-		return ret;
+	if (link->msm_dp_link.has_sink_count) {
+		ret = drm_dp_read_sink_count(link->aux);
+		if (ret < 0) {
+			DRM_ERROR("DP parse sink count failed\n");
+			return ret;
+		}
+		link->msm_dp_link.sink_count = ret;
+	} else {
+		link->msm_dp_link.sink_count = 1;
 	}
-	link->msm_dp_link.sink_count = ret;
 
 	ret = drm_dp_dpcd_read_link_status(link->aux,
 					   link->link_status);
@@ -1348,3 +1352,15 @@ struct msm_dp_link *msm_dp_link_get(struct device *dev, struct drm_dp_aux *aux)
 
 	return msm_dp_link;
 }
+
+void msm_dp_link_set_sink_count(struct msm_dp_link *msm_dp_link, u8 sink_count)
+{
+	struct msm_dp_link_private *link;
+
+	if (!msm_dp_link)
+		return;
+
+	link = container_of(msm_dp_link, struct msm_dp_link_private, msm_dp_link);
+	msm_dp_link->sink_count = sink_count;
+	link->prev_sink_count = sink_count;
+}
diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
index 76125e9c07e9..11be55ade0a8 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.h
+++ b/drivers/gpu/drm/msm/dp/dp_link.h
@@ -72,6 +72,7 @@ struct msm_dp_link {
 	u32 test_response;
 
 	u8 sink_count;
+	bool has_sink_count;
 	struct msm_dp_link_test_video test_video;
 	struct msm_dp_link_test_audio test_audio;
 	struct msm_dp_link_phy_params phy_params;
@@ -112,6 +113,7 @@ static inline u32 msm_dp_link_bit_depth_to_bpp(u32 tbd)
 }
 
 void msm_dp_link_reset_phy_params_vx_px(struct msm_dp_link *msm_dp_link);
+void msm_dp_link_set_sink_count(struct msm_dp_link *msm_dp_link, u8 sink_count);
 u32 msm_dp_link_get_test_bits_depth(struct msm_dp_link *msm_dp_link, u32 bpp);
 int msm_dp_link_process_request(struct msm_dp_link *msm_dp_link);
 int msm_dp_link_get_colorimetry_config(struct msm_dp_link *msm_dp_link);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index e633afdf2b47..0f81aaa7e6db 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -332,6 +332,7 @@ int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
 {
 	int rc, bw_code;
 	int count;
+	struct drm_dp_desc desc;
 	struct msm_dp_panel_private *panel;
 
 	if (!msm_dp_panel || !connector) {
@@ -356,12 +357,22 @@ int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
 		return -EINVAL;
 	}
 
-	if (drm_dp_is_branch(msm_dp_panel->dpcd)) {
+	rc = drm_dp_read_desc(panel->aux, &desc, drm_dp_is_branch(msm_dp_panel->dpcd));
+	if (rc)
+		return rc;
+
+	panel->link->has_sink_count =
+		drm_dp_read_sink_count_cap(connector, msm_dp_panel->dpcd, &desc);
+
+	if (panel->link->has_sink_count) {
 		count = drm_dp_read_sink_count(panel->aux);
-		if (!count) {
-			panel->link->sink_count = 0;
-			return -ENOTCONN;
+		if (count <= 0) {
+			msm_dp_link_set_sink_count(panel->link, 0);
+			return count < 0 ? count : -ENOTCONN;
 		}
+		msm_dp_link_set_sink_count(panel->link, count);
+	} else {
+		msm_dp_link_set_sink_count(panel->link, 1);
 	}
 
 	rc = drm_dp_read_downstream_info(panel->aux, msm_dp_panel->dpcd,
-- 
2.25.1

