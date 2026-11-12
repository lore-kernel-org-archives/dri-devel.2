Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44EE606A330
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LRSbAy7X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2F810F035;
	Thu, 12 Nov 2026 07:52:42 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEAB010F035
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:52:35 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8b58d6f67a5so2323154b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794469955; x=1795074755; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zR8Eij2FPJgIUhxryQ5YRxF7TN8W0EpDXclL86k6m10=;
 b=LRSbAy7XX5z1w2VIKJK6WSW2HArtGthvv+eGk6hSgUyqq63cVZZPiqiEQiA3gWdoAm
 pScVRS0yvkWgGFhD2KvAdbDDbUJKJmmyZV7WjPjLHiIYB/lDsHhofmomHPLEn8Hd0g80
 D/OSb6ffSPqCR/VGnQGyAuTYD2yU9W5+g61sVgAD6q26rqxADEK/RwncQU8CecbawLhU
 qhN3n6cxyoeuzBiYgFEPXORwwjt8K8vbDOf7sOU/7dU0vOe5pNV+wmWsvnBww5/z8IIv
 s/vHp/XZsE6fxCKljo8zpIPVMBtRfIkG3M2nddRzHwkOS4bL8IgeiawRhwNa/PeOALLU
 Mwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469955; x=1795074755;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zR8Eij2FPJgIUhxryQ5YRxF7TN8W0EpDXclL86k6m10=;
 b=x+f2+KS/DcO1hNEQx2jG/4MKbqYM+B/B5lhxt8p97jtvAsz0sj75Wm0ble+r6BR/zi
 q7ye5f+vrAXdR51xOML3c7/HSEQ3sqI6ZrdJcXoJkaFuOks9ZxD4lrJKxeVzOGR/enh6
 uFcovTOWuPorSRY9hXMyZAb+Pv+hbiHr8RJV5rWUaRd6irlWFxnt15cBETQU6Ea/tOOR
 eps7Jqnw07BNIWYHdh7vOsqyVRik+tMIKNbzgFijfut3ZEIX4Q3pI34JGAgEgSwBvVeW
 Ty9IsXlkFVahWuaAs1UhFllLyZIvKluA03ftSx0ndMZtejjbBDj++dwvrffFSITlWkAP
 fZnA==
X-Forwarded-Encrypted: i=1;
 AL+hErGm59jFm3YEEvyfsAhYp0GHJ6nwamSZbwh/TDxEWFrYadIWBH4QmSqnDVd+AEGM+zVbO+zC8iYQJCo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z92u69e7RVX8pRUcpjVsjsjP/074UZw9iorCXDCJ7ANbO+tCYXU
 PXyBHLK0+dl6B8rszsRQ4ILE8F1EgBEQPo5lYBcGelec3QMyumcl+g6+QfNcAWKhXjM=
X-Gm-Gg: AYBFou3xmU6dhuCKxxbewxe+rZkSPKgnUuaQozAQeaEq/Ld4eqHMH0HV+LHE4uLJeji
 ZsvmZbub9OLoBcMS/tBt5gJDKbW4wOuzFvWDwmE1VHn06gMvsgQo5mH19ETXUStPvrOspLR7HU4
 P+0znNQ9Lu2+dXkYoS5idZMUvfzNxkZMjz8+hFvBlSaCe7Woz/EPvbGPhdiJbMdLjghA0r48em4
 N0hJ1XfbgryHxnGP78IWma21Mij/QMfUBlxTWQqsOdJ4aeTehtuctOQgh+958QIwD1t/89r555I
 C2P2vQRy7muEKOjbUdF1KedcMNS6jA897vFQJmom14D3oqyb6Jtq1VirwTQzICkTDOgcpjgDxQj
 yeBjio6Stur2CRBWQ7lqsw/ZVCcE2UoSTuNZMzBlJCeNpEJfn+U7zQbErPCyL5rIZlV5qCP76BO
 BrQ5t6LmNKd55VQv8bszBc9HRG20pBP/cutKYKTuY0Iyx6tbNWcQbAHyDF98ev0bOFrgfLklKZw
 uQ2gwSjRxhzWbhIXROpcrfXV/IUgucFt6Y9IoAVcnyh1/8kNt4mjlbFob78ePZj2MNeDHn5VWFW
 mYLxyKsqGvHnz1WiDJbPwuJvV+nb3w==
X-Received: by 2002:a05:6a00:2343:b0:8a0:3336:4b45 with SMTP id
 d2e1a72fcca58-8bc1c594810mr5000583b3a.12.1794469955132; 
 Wed, 11 Nov 2026 23:52:35 -0800 (PST)
Received: from [127.0.1.1] ([116.237.168.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab5f3f99sm3131256b3a.51.2026.11.11.23.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:52:34 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 12 Nov 2026 15:52:05 +0800
Subject: [PATCH 4/8] drm/msm/dpu: expand CWB to 4 pipes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-cwb-upstream-v1-4-a6a88d928aa4@linaro.org>
References: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
In-Reply-To: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794469928; l=3075;
 i=jun.nie@linaro.org; h=from:subject:message-id;
 bh=4/WCCF14ztFcYuwH5sdlLJ/Y7c6CkeQnN0+bpY4resY=;
 b=nyBY/lFPmt026D4jaKbY3LdrTEesIm0s11kGJMZMD+33M+x3eBjnEEOkuqbVPgMHoBAu76oXa
 DrBwZvYJAoCA6o82V6wAXorre2C0gYxNXBja5PIX5ldV+gQZX1gnuoZ
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=O9aRQ3+xXWihQiRRgStCET+eFXx1EZs43Fh0Xh+8Bu4=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Only 2 CWB is supported in topology currently. Expand to 4 CWB
with dedicated CWB counter to support quad-pipe use case.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 4 +++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 7 ++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h      | 1 +
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 09563a766390..7ac2cdbce8de 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1423,7 +1423,6 @@ static struct msm_display_topology dpu_crtc_get_topology(
 
 	if (topology.num_intf == 2) {
 		if (dpu_use_virtual_planes && caps->has_3d_merge &&
-		    !topology.cwb_enabled &&
 		    (mode->hdisplay > 2 * caps->max_mixer_width ||
 		     mode_rate > 2 * dpu_kms->perf.max_core_clk_rate))
 			topology.num_lm = 4;
@@ -1443,6 +1442,9 @@ static struct msm_display_topology dpu_crtc_get_topology(
 	if (dsc)
 		topology.num_dsc = topology.num_lm;
 
+	if (topology.cwb_enabled)
+		topology.num_cwb = topology.num_lm;
+
 	if (crtc_state->ctm || crtc_state->gamma_lut)
 		topology.num_dspp = topology.num_lm;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index d455845ba14b..11eae4b19684 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -56,7 +56,7 @@
 	(MAX_H_TILES_PER_DISPLAY * NUM_PHYS_ENCODER_TYPES)
 
 #define MAX_CHANNELS_PER_ENC 4
-#define MAX_CWB_PER_ENC 2
+#define MAX_CWB_PER_ENC MAX_CHANNELS_PER_ENC
 
 #define IDLE_SHORT_TIMEOUT	1
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 4ada16cf8610..9519cc59e9f3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -240,12 +240,17 @@ static int _dpu_rm_reserve_cwb_mux_and_pingpongs(struct dpu_rm *rm,
 						 uint32_t crtc_id,
 						 struct msm_display_topology *topology)
 {
-	int num_cwb_mux = topology->num_lm, cwb_mux_count = 0;
+	int num_cwb_mux = topology->num_cwb, cwb_mux_count = 0;
 	int cwb_pp_start_idx = PINGPONG_CWB_0 - PINGPONG_0;
 	int cwb_pp_idx[MAX_BLOCKS];
 	int cwb_mux_idx[MAX_BLOCKS];
 	int cwb_mux_idx_start = 0;
 
+	if (!topology->num_cwb) {
+		DPU_ERROR("invalid number of cwb: %d\n", topology->num_cwb);
+		return -EINVAL;
+	}
+
 	/*
 	 * Reserve additional dedicated CWB PINGPONG blocks and muxes for each
 	 * mixer
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
index ccd64404f12d..9b2ea51608de 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
@@ -62,6 +62,7 @@ struct msm_display_topology {
 	u32 num_intf;
 	u32 num_dspp;
 	u32 num_dsc;
+	u32 num_cwb;
 	int num_cdm;
 	bool cwb_enabled;
 };

-- 
2.53.0

