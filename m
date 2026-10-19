Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A1606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HWwCahqH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B9710F318;
	Tue, 20 Oct 2026 07:36:45 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622A310E589
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 05:15:13 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-35943f55c06so2538444eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 22:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792386912; x=1792991712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LHIoBpNvmoiyE7kQhE8I3uJMHpFmjXu6J3zrCSHKMP8=;
 b=HWwCahqHZ3XW/pSXcnSs6fT2w9/Yok0XfYKCH6UMbBUpqxVGnCvD8TnKg0ezqJtlj1
 E/UI3V8eD4MlF3SwDPlEQy9Cbf622gpHH6hKL8Ww9mYV0woMZgtxr9xzGwqY97b6Cjn9
 KWlQWeqUyAhj9xY3CKUEPHmi5Pu1H1wljWpqZRl/dm2UWtPstVihDkTHS7/6P5cyFgQY
 /xDIR3cZgBMP5+fj7aTxPb1JeRRAz9wd/nPRNojt+XP7uEV8JgGWjFlyiWnQr+o219iA
 ybpi5CYRmUeYmYlxG+HxtKuplwKuX8R3yUOlgwFHc6FxTJU5+8kyc4QE4BIR2BrZ9d+5
 R1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792386912; x=1792991712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LHIoBpNvmoiyE7kQhE8I3uJMHpFmjXu6J3zrCSHKMP8=;
 b=VZOkzLNONGyFchXyUPVijb2vPg/GrELmPWR7vymOvdl3pHoB6Q82fftXrETAAgpkg+
 BiIHoT9f5qwK+SMhPeVMTN2f2JFkEeB28HJLurUHK3kCkfyqCFHac6vgWyP+9qDKFVwV
 sh43q3qlOql/Xu9+TGoiTLwefkf70FL9UkUSGxfyE1tiXVlJlivwJcgcUUkNe/SAdv7t
 IJzTlNqv0kiCW3al7ra5sjwBu8OV3R4WCjhPz4QhVSMTaEKz5nhy4QJd2OLFupsQY2SP
 2Now02ggqMgRPOzsXZxIJDAjeS7MOI65cGAMvOKkY6r4J9ou8+yNc/omq9T0b5e+mIvi
 ryqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTD1WzroOVmSnyLwkp4S9fUQFZK3y487kH4JTaVqYCsF9oVecOVTOZ3jJ+BvxOFGlfhoczvjGqxdM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKbdpzQIZz1Eqj3Ms9c7I0GBvQLnrElvsDTaIkeb0pGugfDBBl2
 HAVmlFoBkLs3B8byl4+achSuQ1GEPxTT/pHAhBBQGr+XBwVvGwl0n14u
X-Gm-Gg: AYBFou2OtyuPYFIzYuesICmtW475UAQMha7Bagxb8GGZ51/8iMOufj/Ql7XpLbCOkd6
 tHkkSINOFwqom5IEiugp/ENa+xfWBqCaKOwyXBm8dReRElAoMA76/T+7mDVoY9HiC3CzkpfIK4j
 jAwKCZTPcpKQNubpBfaAcrlAgyF4jS6Z6lOiVvW7/GDlz8HgNDmlbinEh7d4ETOdZQcE1fk+Yig
 9qyUicKLoYfA5KZM3Gtb3Xt6y8jq2qH8P9Z8VplmkvHNGNSr16Rc2tDAD94QWpwkJa/WNsQbrB4
 RQsfCz+ESszKqHyTfzJe6B4Nb6W5tl2zElAG9o9j6UqBV6KFWYZnQtBvLESJdKaTUK5vSMUkqNS
 qSBRBf8ngg/n5Gac2aP0raR2/to2LrG4Vc8chkTOiSNmh9vD+yJ9toGW2BIS8RzFdFSgUAcK5rD
 P8QOtj8oOyolu8GbuafVZBCtPpuxwDA55NQ7fu0MkIgnTuOB0Vw17slMBWBd5n4Jhxy2WQyFq5y
 ZzFmMiFQDF1R4CqQXf1az5YGHxv2RsTVfrXTNlaCduHg419KbP65uT4p7D1E9NT/T7e0dxyczL8
 IuhGJmmr/tcm5KXwTRd5dMUz9hS9TpfdGqbATozH
X-Received: by 2002:a05:7301:2710:b0:35e:af84:bf1e with SMTP id
 5a478bee46e88-361a2053227mr9965350eec.7.1792386912356; 
 Sun, 18 Oct 2026 22:15:12 -0700 (PDT)
Received: from flyingfox.tail3d542a.ts.net
 ([2402:a00:163:2ce9:6c87:7904:21fa:8675])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm47588803eec.28.2026.10.18.22.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 22:15:11 -0700 (PDT)
From: Vivek Kumar <vk092kumar@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Vivek Kumar <vk092kumar@gmail.com>
Subject: [PATCH v4] drm/msm/dp: allow eDP sinks without DP_SINK_COUNT
Date: Mon, 19 Oct 2026 10:44:41 +0530
Message-ID: <20261019051441.2835682-1-vk092kumar@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some eDP sinks, especially fixed-format eDP-to-HDMI bridge chips with
no downstream AUX-capable panel behind them, do not report a non-zero
DP_SINK_COUNT even though they participate normally in DPCD capability
exchange and link training.

Treating sink_count == 0 as a permanent disconnect is valid for external
DisplayPort, but it breaks eDP probe/enable paths in
msm_dp_display_prepare_link().

Use drm_dp_read_sink_count_cap() in msm_dp_link_parse_sink_status_field()
and set link->sink_count to 1 when the capability is not available.

In dp_panel.c, msm_dp_panel_read_link_caps() still reads DP_SINK_COUNT
for branch devices. That read is left unchanged here: the sink on the
tested board reports DPCD 1.4 and does not advertise a downstream port,
so that path is not taken.

Signed-off-by: Vivek Kumar <vk092kumar@gmail.com>
Assisted-by : LLM
---
 drivers/gpu/drm/msm/dp/dp_display.c |  6 ++++--
 drivers/gpu/drm/msm/dp/dp_link.c    | 30 +++++++++++++++++++++--------
 drivers/gpu/drm/msm/dp/dp_link.h    |  5 ++++-
 drivers/gpu/drm/msm/dp/dp_panel.c   |  5 +++++
 drivers/gpu/drm/msm/dp/dp_panel.h   |  1 +
 5 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 4dcbd9b99d06..2ae4dafd755f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -290,7 +290,8 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 			return -ETIMEDOUT;
 	}
 
-	msm_dp_link_process_request(dp->link);
+	msm_dp_link_process_request(dp->link, connector, dp->panel->dpcd,
+					 &dp->panel->desc);
 
 	if (!dp->msm_dp_display.is_edp)
 		drm_dp_set_subconnector_property(connector,
@@ -506,7 +507,8 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 			dp->link->sink_count);
 
 	/* check for any test request issued by sink */
-	rc = msm_dp_link_process_request(dp->link);
+	rc = msm_dp_link_process_request(dp->link, dp->msm_dp_display.connector,
+					 dp->panel->dpcd, &dp->panel->desc);
 	if (!rc) {
 		sink_request = dp->link->sink_request;
 		drm_dbg_dp(dp->drm_dev, "sink_request=%d\n", sink_request);
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 34a91e194a12..f7f25020cacb 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -715,17 +715,25 @@ static int msm_dp_link_parse_request(struct msm_dp_link_private *link)
 	return ret;
 }
 
-static int msm_dp_link_parse_sink_status_field(struct msm_dp_link_private *link)
+static int msm_dp_link_parse_sink_status_field(struct msm_dp_link_private *link,
+						      struct drm_connector *connector,
+						      const u8 *dpcd,
+						      const struct drm_dp_desc *desc)
 {
 	int ret;
 
 	link->prev_sink_count = link->msm_dp_link.sink_count;
-	ret = drm_dp_read_sink_count(link->aux);
-	if (ret < 0) {
-		DRM_ERROR("DP parse sink count failed\n");
-		return ret;
+
+	if (drm_dp_read_sink_count_cap(connector, dpcd, desc)) {
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
@@ -1025,12 +1033,18 @@ static void msm_dp_link_reset_data(struct msm_dp_link_private *link)
 /**
  * msm_dp_link_process_request() - handle HPD IRQ transition to HIGH
  * @msm_dp_link: pointer to link module data
+ * @connector: connector the sink is attached to
+ * @dpcd: receiver capability DPCD of the sink
+ * @desc: DP descriptor of the sink
  *
  * This function will handle the HPD IRQ state transitions from LOW to HIGH
  * (including cases when there are back to back HPD IRQ HIGH) indicating
  * the start of a new link training request or sink status update.
  */
-int msm_dp_link_process_request(struct msm_dp_link *msm_dp_link)
+int msm_dp_link_process_request(struct msm_dp_link *msm_dp_link,
+				       struct drm_connector *connector,
+				       const u8 *dpcd,
+				       const struct drm_dp_desc *desc)
 {
 	int ret = 0;
 	struct msm_dp_link_private *link;
@@ -1044,7 +1058,7 @@ int msm_dp_link_process_request(struct msm_dp_link *msm_dp_link)
 
 	msm_dp_link_reset_data(link);
 
-	ret = msm_dp_link_parse_sink_status_field(link);
+	ret = msm_dp_link_parse_sink_status_field(link, connector, dpcd, desc);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
index 76125e9c07e9..217fc5eb0a68 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.h
+++ b/drivers/gpu/drm/msm/dp/dp_link.h
@@ -113,7 +113,10 @@ static inline u32 msm_dp_link_bit_depth_to_bpp(u32 tbd)
 
 void msm_dp_link_reset_phy_params_vx_px(struct msm_dp_link *msm_dp_link);
 u32 msm_dp_link_get_test_bits_depth(struct msm_dp_link *msm_dp_link, u32 bpp);
-int msm_dp_link_process_request(struct msm_dp_link *msm_dp_link);
+int msm_dp_link_process_request(struct msm_dp_link *msm_dp_link,
+				       struct drm_connector *connector,
+				       const u8 *dpcd,
+				       const struct drm_dp_desc *desc);
 int msm_dp_link_get_colorimetry_config(struct msm_dp_link *msm_dp_link);
 int msm_dp_link_adjust_levels(struct msm_dp_link *msm_dp_link, u8 *link_status);
 bool msm_dp_link_send_test_response(struct msm_dp_link *msm_dp_link);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index e76dad0f6663..50e278286e09 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -252,6 +252,11 @@ int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
 		return rc;
 	}
 
+	rc = drm_dp_read_desc(panel->aux, &msm_dp_panel->desc,
+				 drm_dp_is_branch(msm_dp_panel->dpcd));
+	if (rc)
+		memset(&msm_dp_panel->desc, 0, sizeof(msm_dp_panel->desc));
+
 	bw_code = drm_dp_link_rate_to_bw_code(msm_dp_panel->link_info.rate);
 	if (!is_link_rate_valid(bw_code) ||
 			!is_lane_count_valid(msm_dp_panel->link_info.num_lanes) ||
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 4519ac374220..e52847474f16 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -31,6 +31,7 @@ struct msm_dp_panel {
 	/* dpcd raw data */
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
+	struct drm_dp_desc desc;
 
 	struct msm_dp_link_info link_info;
 	struct drm_connector *connector;
-- 
2.56.0

