Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B159AC79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EBC810EF1F;
	Wed,  9 Sep 2026 06:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sAGSrdb9";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F40A410EAA4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:02:08 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6b1b766bf01so1767805eaf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788858128; x=1789462928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5yQQXf0ptX+tS4ybVpXcfW4E0EqwJo75cLYXDPk6+nY=;
 b=sAGSrdb9U+ASxXYs2b6OTX4INYuuqLSvGqGeJ8HRxskLWhpB2vmrt0HF7DBH3JO8E6
 BcWmLHCjYUts5eFax+ND3rQGElpcGDjsFgJLDmINOT/TuB/M9QkTMbvEC7oL8/9mKDga
 wX519pkrOCn3a9QRK51J+fIAYKQpha0n4SN4XvVxpaNa2EddCvZLn9daW4C8o4jnVLGS
 8Ul5OtAXITCQkkUSYso7DgKKEL3xwQjKriMlFvL/C08V0e4KSruJzzp1Gi5NbcWB4kYV
 duA24XhmboIax7tiMCKOUHKXxmoXAVgS4Ryz5aPcQiZ21klXHntEJ8rBmTYWEYbhJUKF
 iFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858128; x=1789462928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5yQQXf0ptX+tS4ybVpXcfW4E0EqwJo75cLYXDPk6+nY=;
 b=fdVS2zEM0gb1xvehy4rXIvPUjrxpE+c4l3pqghU9wAb8mHj8CGBMeIQEem5Q7FCske
 ryrdPB6G9em3NEOgne+SxBxRwSf0KBZvovVEFMDEqhO+j4zmlNBy5bO2uBM1vJPKCOxp
 c0Id3C9TqaKPyHzVy0Pkk1wC8pr9aSblUqLhHDSBerYjEK+uAC3xF7b0YsdI2yNgtZrR
 1tFn9rwl5xmWbo19PUKrqOwlguusE8PcTvgwpXDrrIQSlAVuScWSv2rQVlKm4uej4aOG
 +Zh9gLtN0g82p9RAt01+Ut7tnM6J59Z5I1aLSTPVCZpmIhpq6eg13wYQ0fBuxT+eZgZt
 Xv7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHh7xK1foHfespFonQNPSs/RWYT8fXN67sMI9QL0GDSMijiJEIhMovToCrySy2LLB9TtRJaVfAR74=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k5LMASxLuqOogV7BvPWO8mfTFUaO3sn5aUC7dnW5/XwNT++T4z
 ZGNNxr62vysQLovidyXDGxvrALRNNWfE4I+7lk/2UAvnEyQfLC0/CSay
X-Gm-Gg: AYBFou16hIR5mDqWEkN3He/+LPqAbztT0ta/J9qygk3oYG0HxfhsGabW6oeNsJgua89
 sBodP+SNxa2rMVl3q50bnb9GAOSKM5eIzxW73uQZIyv+RdsTNbP3vgjTKBRxxN6szmw9PjFVaF0
 rDnB/hdcwIkUUtJWZ4wqH+LzyvtXgSdyuHPfTssO4/MrHDvrF5n7bHloYRWKhHADaS8KaDkIjZS
 IKpLEFi4wigjFaPn5FCVbMYmFgoufvKoJLg6Nn85K7TMmdkvRCSTHQCS8dOSjjWBTOT3MQc7h6l
 cS4eLRmFuyyhfqX12feONAPBz+gP5lvGKkoYVh6nUSsomWL4qlCtrS2Fg//vQ8qfcGUbTa5hrCy
 didGxYMk2z/7MtBl1Jba63IQzFPbN5lTh8k6oGpeLvStdL+eM9Wj3H4AE+Vd5psAN4AUcNNFVO3
 f0vncKc+vsggqyGRSw+utTx9Fhv8NYYhztiDv5Dv/tJkkDT9PAvaahgTtaMlFKffRzjOi8h+LXu
 YCkoGgNcLIZ2LK6F5jtTjvEiHYV28FEDwp3qDjdbX5k
X-Received: by 2002:a05:6820:1890:b0:6b1:464d:4d1d with SMTP id
 006d021491bc7-6b6fb8d25aemr15032941eaf.11.1788858127679; 
 Tue, 08 Sep 2026 02:02:07 -0700 (PDT)
Received: from flyingfox.tail3d542a.ts.net
 ([2402:a00:163:2ce9:6c87:7904:21fa:8675])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f44d7sm33641223eec.22.2026.09.08.02.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:02:07 -0700 (PDT)
From: 092vk <vk092kumar@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, 092vk <vk092kumar@gmail.com>
Subject: [PATCH] drm/msm/dp: don't gate eDP on DP_SINK_COUNT
Date: Tue,  8 Sep 2026 14:31:46 +0530
Message-ID: <20260908090146.3100787-1-vk092kumar@gmail.com>
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

Signed-off-by: 092vk <vk092kumar@gmail.com>
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

