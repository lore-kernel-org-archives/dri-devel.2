Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23080C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6650610F20F;
	Fri, 18 Sep 2026 07:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VFpxGotI";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4A210EEB0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:47:24 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so598154a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 05:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789649244; x=1790254044; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DbfultDs2OD6410ViT9useBSnVgsUPIPJqHZwqlPlSs=;
 b=VFpxGotIYIe/rFyQAJCdpMT7t/xQVjPlHpYAnfpLEpc6CZayyN3HYTkQaZ5Nfo18yA
 KAZfvP0GM0zPF+58zPs8FWmjm3OwbB4RWN5T//eBCy8plvINwwZ+McbKaZfd2jCNm8Y9
 EboueAWbDtblEgwavTeoN/RhjLX7t/cvl+t0Kkz8r0ZXDTzwjjJ/7/wUUf+KBUG/MZ02
 4/RsjChhYLAvyttOqspCCVAMZg1R/Q5jmac71YaRh/3jiLG8p5rsSpyjnvn71hGqjzCG
 5QWSDAEGlHBlYPg1XRmUsWbcTtkEwtLHu50aZVSS0FyfXMo1k9DjGZyolxpeksNLEvRf
 hRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649244; x=1790254044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DbfultDs2OD6410ViT9useBSnVgsUPIPJqHZwqlPlSs=;
 b=CHMf2IYEWWDrdcefSPjw+Ld0HY75Ln8UBVeV8EjU+nO1odYCjEmKvaNAmthjn9KWGm
 Lz46R1f56qh67mcgzYQazIPYiqcKkOtpnKzluDT1NpNaBhDQxz6dPxdLjb1Dqghz59aR
 rjFSEaGTN1reNvOgWbRI5OFWaXDtFFLGku5nmHF14SRRZw5JvAh8hwCWSWvwWTsS3iX/
 xXcqsEkuxJYqeU7etkXSeV/XNdr/OfsYUORt+Jv0GePUCiL5Gzfs54mEDvM0qrnN7WsT
 GVKoHpNP9h2pG46lG1VXYXBXJGWTLK0DoSzbhf7gxP7Y5mJ8JK6nJZ2cgZ8UdjGTrUBm
 K88g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBRTlfKoNfVLLEM+4AWarbWgX3vCb1owtmn0D98HLuj/Rv17YNPLMbUnpgW9+D93VzD6KACVmyGfo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mHaBZnwAKgQUPMP+Yj6y+age4iHhJM96chloyym31g5kDt//Kg
 zxh0L/q4A6vu5ognLjFiicERBIuSoUvSuu3R5LzBXrwkCyAECq2noEMA
X-Gm-Gg: AYBFou1E310PT57yGVEgBTuFNlXUJjwuP+oBuMNw7cr7ToXA8zft5/DjHmumDfwmecw
 1E/RPGJcdIIJksQJs9DXPMuqwFGaJ000wcBPUPtSwEGZmhUFb2OD4qBFD8ziv9yHzRQFtb1A/jt
 GjgUVLSLdHyOinjT6nRNQAQlxwoA649xl12gs9phZf3gmpvYmUplE6rUYCXJX2zlf90JJGZjKM8
 JiCMcIRLpVdZtE4QemQX6AgkUYx0fj2s6WWMMe27W/omLRIvV7SdoDUE3UPVUACtBgc/92POE/a
 hJ4/2sYeDlE7MrKHVD12fUY2SrdNW7jOyzgKuxd0U6bfNdfCEujHblmFkVE0JdZisSeODBvWhd4
 MqMPrRTUiq52yhUWAE2j7cl2ji9zC8SYcpevkVT5/ogbcQACkrpzshHRVu4lHhNAHox23l19Egp
 L/ruk/Y9DLpH7RXddX0QsBscePFkzwFTyzG6XBnhLNo4N4t0TO/uqDZ1ByWmY+GFmTzAmgkSVWS
 n7Xs4q09AUAlc37WM/DsKJ4syPI7a4=
X-Received: by 2002:a17:90a:d16:b0:39e:3554:4d0e with SMTP id
 98e67ed59e1d1-39e35545939mr9663298a91.1.1789649244173; 
 Thu, 17 Sep 2026 05:47:24 -0700 (PDT)
Received: from flyingfox ([2402:a00:163:2ce9:6c87:7904:21fa:8675])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395cfb0b1sm12349328c88.5.2026.09.17.05.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:47:23 -0700 (PDT)
From: Vivek Kumar <vk092kumar@gmail.com>
To: robin.clark@oss.qualcomm.com
Cc: lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Vivek Kumar <vk092kumar@gmail.com>
Subject: [PATCH v3] drm/msm/dp: allow eDP sinks without DP_SINK_COUNT
Date: Thu, 17 Sep 2026 18:17:06 +0530
Message-ID: <20260917124706.421107-1-vk092kumar@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:09:59 +0000
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

Some eDP sinks, especially fixed-format eDP-to-HDMI bridge chips with
no downstream AUX-capable panel behind them, do not report a non-zero
DP_SINK_COUNT even though they participate normally in DPCD capability
exchange and link training.

Treating sink_count == 0 as a permanent disconnect is valid for external
DisplayPort, but it breaks eDP probe/enable paths in
msm_dp_display_prepare_link().

Use the same eDP exemption as drm_dp_read_sink_count_cap() for the raw
sink_count checks in this driver, via a small shared helper, so valid eDP
outputs are not rejected as disconnected just because the downstream sink
does not expose a usable DP_SINK_COUNT.

Tested on a Qualcomm QCS6490-based board driving a fixed-format
eDP-to-HDMI bridge IC (chrontel,ch7218a).

Signed-off-by: Vivek Kumar <vk092kumar@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_aux.c  |  8 ++++++++
 drivers/gpu/drm/msm/dp/dp_aux.h  |  1 +
 drivers/gpu/drm/msm/dp/dp_link.c | 10 ++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 3825a2fb48e2..3b5a4da93122 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -679,6 +679,14 @@ u32 msm_dp_aux_is_link_connected(struct drm_dp_aux *msm_dp_aux)
 	return status;
 }
 
+bool msm_dp_aux_is_edp(struct drm_dp_aux *msm_dp_aux)
+{
+	struct msm_dp_aux_private *aux =
+		container_of(msm_dp_aux, struct msm_dp_aux_private, msm_dp_aux);
+
+	return aux->is_edp;
+}
+
 struct drm_dp_aux *msm_dp_aux_get(struct device *dev,
 			      struct phy *phy,
 			      bool is_edp,
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.h b/drivers/gpu/drm/msm/dp/dp_aux.h
index 4be02e8b4d0b..9ab401c8526f 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.h
+++ b/drivers/gpu/drm/msm/dp/dp_aux.h
@@ -22,6 +22,7 @@ void msm_dp_aux_hpd_intr_enable(struct drm_dp_aux *msm_dp_aux);
 void msm_dp_aux_hpd_intr_disable(struct drm_dp_aux *msm_dp_aux);
 u32 msm_dp_aux_get_hpd_intr_status(struct drm_dp_aux *msm_dp_aux);
 u32 msm_dp_aux_is_link_connected(struct drm_dp_aux *msm_dp_aux);
+bool msm_dp_aux_is_edp(struct drm_dp_aux *msm_dp_aux);
 
 struct phy;
 struct drm_dp_aux *msm_dp_aux_get(struct device *dev,
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 34a91e194a12..bf08b5b18097 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -725,6 +725,16 @@ static int msm_dp_link_parse_sink_status_field(struct msm_dp_link_private *link)
 		DRM_ERROR("DP parse sink count failed\n");
 		return ret;
 	}
+
+	/*
+	 * Some eDP sinks do not report a valid sink count, even though they
+	 * otherwise participate in link training and DPCD capability exchange.
+	 * Treat a zero raw count as a valid non-zero placeholder so we do not
+	 * misclassify the link as disconnected on eDP.
+	 */
+	if (msm_dp_aux_is_edp(link->aux) && ret == 0)
+		ret = 1;
+
 	link->msm_dp_link.sink_count = ret;
 
 	ret = drm_dp_dpcd_read_link_status(link->aux,
-- 
2.55.0

