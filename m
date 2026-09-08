Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B6CC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 427D010E178;
	Wed,  9 Sep 2026 06:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hLF0wWCx";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13B710E12B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:17:30 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-66bd7857841so4101695d50.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788859049; x=1789463849; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=04BJLFntpwJWlUY4qt1TWhif2X5sPaJQXijGBxMTbU4=;
 b=hLF0wWCx7azYaCsYFM1E4ttjuXD/uSmAWwsEN11fWX/8g4HOQkrniiaPUQ2LYqVex2
 RpDdhaB1qshLhvKzmJV4/KeZZbSclPzwUcejNWn5xFDLxdYlVS2DNGbCRa80NGx7OcNA
 7IilmR4xeHNDubaHsq3v0B+dZdXIMirfSbjmCYYbgVHBT8dyUzj/8GGz9o4ZDbb5M2js
 H+eTp+tBBIjsTm1S1nNHWOj40lEmctOaYc9O3DLSJB/mjgQZS15Eu64bBMDqZjKeZ4/P
 qVNw/ECjnejWhnssw6vbvTmKG6dfYxwdwvjghoSUpH37nBokrK2mjnuvL65vrGujaHrd
 8ERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788859049; x=1789463849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=04BJLFntpwJWlUY4qt1TWhif2X5sPaJQXijGBxMTbU4=;
 b=ma0bQ1NRvMXHMJs1y89mp03MuYILNdWoW8RuXYDdGDJ108N0MtVTNTWEd8R7VeWQTq
 tN0ltOT2bcjh8m0evXj2xVvDL54hmwXppJ6sS66ytUuMCNNMN5eBvTXdf20/u5tdL943
 I0ZJ+5MbT+w5yjMhUnRTpNfHoKNu/dAKl/dwXAUUpWK2u21ULzLPQZcxt923F2ZOpMEq
 qdDE76DcrkQt/htow/XgGo9dTdN/ib3/68CljfoyaiOk+2ZRDedNCY9ublDfajt0bVGL
 0R0K6fCFG5f6zDm6FD0rNyQsXWMJ0iMxhuV4l4rLLiiOvXaTEnbJhBf2mpVDN4gIFIls
 YEpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByonhSFyUkizRn4zxw+IQ7o7xpPMMWyL6VKgb9OUWycoOI03nwETYgqUKTB/K7AP1vYl6Iu+W4I6pE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mctZF5MCKD+Amm1xudDqN6AV80STGggwRrAnB5vH7mniEdJBJr
 me0tm041URO3P546FIGJzpTUaNlsyotSF6MMTejCzTH8VpE3ti1epcf+
X-Gm-Gg: AYBFou1ZxVPEaADXyAOuJEJXdxKC7Zf1yN1SM2aeHdAyctByF0vDvl5xC8DK4heaFDD
 cIybm1PluQ37tDo3vRJkxnBEPjlULjn9aP0tGdpWGTGmrbr2Y1DAb4R1UDzlDXMNaFvhIylt7gQ
 wTfaBW9mgvPwLKiwEZjywk7TNu6LdXcpnOdIiWp6N/jF8AD65Lq6yOkOjlQzht5bkwzJiXGpUzg
 VvGXYdJrPvaQbKR7m96k5DgrZOR1hF0I3niQ9zkMcEK6rrpTd570a4R5dUYUttYfuysuiGmueDN
 y3lTPA3LSGhLMGuZGjr0JE0eAWrhtx0BsrCE4e5zW3ZF5H9S1ioCrRlyGfQnbLem+upZ983pZZx
 DKZGNscLmnYbkOF0p7acZTWyNiTnU9LPfNmfjFihWouWja6lyKEY2n84zb2A4q7DQ5gj57Li/ww
 pk4plnp4T5b21In464Nc0Hpp3tTp100ngBMiGYkbA1rXnDbRX44R1Yv8oyG9Ne4upHuQV5TuHyh
 CuaaTu+iDpp8+XLN6Wqv21rwddc3zdcSEfmnOcfNiB/DvZkJhYSOVQ=
X-Received: by 2002:a05:690e:4845:b0:66f:dd72:8fd7 with SMTP id
 956f58d0204a3-66fdd729038mr1907789d50.90.1788859049437; 
 Tue, 08 Sep 2026 02:17:29 -0700 (PDT)
Received: from flyingfox.tail3d542a.ts.net
 ([2402:a00:163:2ce9:6c87:7904:21fa:8675])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-670f4f6d3cdsm1803318d50.6.2026.09.08.02.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:17:28 -0700 (PDT)
From: Vivek Kumar <vk092kumar@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Vivek Kumar <vk092kumar@gmail.com>
Subject: [PATCH v2] drm/msm/dp: don't gate eDP on DP_SINK_COUNT
Date: Tue,  8 Sep 2026 14:47:08 +0530
Message-ID: <20260908091708.3123735-1-vk092kumar@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

msm_dp_display_prepare_link(), msm_dp_display_disable(), and
msm_dp_hpd_unplug_handle() all treat dp->link->sink_count == 0 as
"nothing is connected", and in msm_dp_display_prepare_link() this
causes probe/enable to fail outright with -ENOTCONN.

This is correct for external DisplayPort, where a compliant sink is
required to report a valid DP_SINK_COUNT over the AUX channel. It is
not correct for eDP: some eDP sinks -- particularly fixed-format
eDP-to-HDMI bridge chips with no downstream AUX-capable panel
behind them -- never populate DP_SINK_COUNT with a nonzero value,
even while otherwise participating normally in DPCD capability
exchange and link training.

drm_dp_read_sink_count_cap() already accounts for this by excluding
eDP connectors from the sink-count requirement for other DPCD-derived
checks (msm_dp_bridge_detect() takes care). Apply the same exemption
to the raw sink_count reads in this file via a small shared
helper, so eDP outputs with a non-AUX-capable downstream sink are
not treated as permanently disconnected.

Tested on a Qualcomm QCS6490-based board driving a fixed-format
eDP-to-HDMI bridge IC (chrontel,ch7218a) with no negotiable
DPCD-capable panel behind it; without this fix,
msm_dp_display_prepare_link() unconditionally returns -ENOTCONN
and the display never comes up.

Fixes: ca16db3d18cf ("drm/msm/dp: break up dp_display_enable into two parts")

Signed-off-by: Vivek Kumar <vk092kumar@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bc646d172abe..9254f080f0ea 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -400,6 +400,12 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
 	return 0;
 }
 
+static inline bool msm_dp_link_no_sink(struct msm_dp_display_private *dp)
+{
+	/* eDP sinks are not required to report a valid sink count */
+	return !dp->msm_dp_display.is_edp && dp->link->sink_count == 0;
+}
+
 static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 {
 	int ret;
@@ -467,7 +473,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 		drm_edid_connector_update(dp->msm_dp_display.connector, NULL);
 
 	/* triggered by irq_hdp with sink_count = 0 */
-	if (dp->link->sink_count == 0)
+	if (msm_dp_link_no_sink(dp))
 		msm_dp_display_host_phy_exit(dp);
 
 	/*
@@ -634,7 +640,7 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 		return rc;
 	}
 
-	if (dp->link->sink_count == 0)
+	if (msm_dp_link_no_sink(dp))
 		return -ENOTCONN;
 
 	if (!msm_dp_display->power_on) {
@@ -723,12 +729,12 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
 	/* dongle is still connected but sinks are disconnected */
-	if (dp->link->sink_count == 0)
+	if (msm_dp_link_no_sink(dp))
 		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
 
 	msm_dp_ctrl_off_link(dp->ctrl, msm_dp_panel);
 
-	if (dp->link->sink_count == 0)
+	if (msm_dp_link_no_sink(dp))
 		/* re-init the PHY so that we can listen to Dongle disconnect */
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
 	else
-- 
2.55.0

