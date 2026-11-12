Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514D606A8A9
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SyqH1Y4Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DF410EB57;
	Thu, 12 Nov 2026 07:52:27 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC49110EB3E
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:52:20 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8b5e5e64494so2148487b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794469940; x=1795074740; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9CWiDyw1g7jDT+BVerXT3sWV7E4AqptmK2wbWTyQpZc=;
 b=SyqH1Y4YJnj2/bdpbv56Sj9viCTTUKQD/dCp8zQBOsSwhDsAwQoPJ0LvJGN5L0ksXd
 yvFwu0KGkOkjDEnGV5H0DkT+lawddIi61TzuMtuW98p65jrXV42iuPrz2o2haFZADk8W
 OaFtzq0oSwO/4d1kAImmR//a0pSbkKHmP1FPSGL6XB2THaD/Q0PilOqo65VwUggr7klj
 Hpag49tRF0Aq/VN89vDt5ELCOyGaAaGyT/PODxQs0Jd+lCZ40XR7w/RclZ+JGYqmQcBX
 5hllFDo1j3d/N1YYTzmMAJlOS4WpdRTLS6uL6vEwkCvrIXVvLRa+MeLh59htAdaPjHdA
 WioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469940; x=1795074740;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9CWiDyw1g7jDT+BVerXT3sWV7E4AqptmK2wbWTyQpZc=;
 b=uHmh6jJ0zBolMrt4dUuGLhfgl4EvIO9hPoV3rQLN/ljQFoSvYwppj9aXDIS1vmV0BD
 0Orrh1R94l5EbhRBy3iTdB6uaeIvL8GxjqChjABl/dUmM525vNWmsXKYAcqz0vbrBmp1
 O5G1gaPXUZL0X3ve7p3SsN3R2eZLZt3Xx3uMp2qtiax8mI+4TaHhoXe0XH/BUxAj1Yvv
 x8h//VIvusBUhc4c4RJibrS811SchAMGDKOOB2EW8zwzrrcmqch73YSKHCS73+XtX+4D
 uH3N4hp9YGo/0lxuxnBGh0EKknyHBMzPP0aKBDRCIFHzuRt6uSXS96deRfCOLPX9X01g
 LoIw==
X-Forwarded-Encrypted: i=1;
 AL+hErGrcA9Dw3IbxHDVlvtAjeH9Y8meWiRuLlUKFbGpuqBHA3EA9DyIqol2zui1paRCOiFzkQKXwgDHUCo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/M76QPZpz+CHj6DYSJrHUU3dD6OZyT4zWr5B3Gnhi+N7nVvDf9
 Xt1ckIU2sgrLnHhWF34JXHaRo5Uiw6BxhXnsVQp0h/JboGw2I4cUVzCY2NP+wq2D01g=
X-Gm-Gg: AYBFou1J9U/8CkhwajnQF88QiSlMtFNCEcF6riPcGdVqmGCUMycbRL2muspmeZJly1u
 UaMMk/XkZ7GxAYMdxFUcPQd5PaktwXpTFPuBzjWboETvQ93D+9U4MfpwcpduWEfCcwFgRAXcUZl
 DfFhRtni3scaiY5WatLFGZkGOMK5ZvVEfkYdxhDvRlPMZCGJPnCxPC0HG0eL8aM3hvgq7Ri1e3V
 3hLaexe53z1gSZYv2uGzqXM5cx5PqY/yotk7+hdDglp1OWH9sSdfOOG5b80HzCxPVutzNoZtKDR
 hCOApYKbWN5b4S9m4Jz39sfHPYB+Mne2zbUQU34ysSd0Pf14iryPIGuCzdUKtTrPOL8icP4YGgM
 lIT/lAgF8dqjDlOmVE6LjXoW7ykxIpN6dAjOCAB2e6UvtU28CqtPcPzm7IEN2v1habuORP2VEIU
 ekQfjbPKzCVT3fqy5yAxhVrWSpFzdVSUTkG+fGaoCe1gwjuH8XgJ0mmzsHyT+LgXWwLqtjjuPgE
 jQPv/63N23dazu3oWKPu3i68Ge3EetLmRylUa7Djmjl8ewxrjsvvO/pOCk2VqOah4dbmgoQnv55
 45VygRqDEbpRehwEP0XqkXuhvdZ4gRA=
X-Received: by 2002:a05:6a00:a85:b0:89f:37a0:b2cb with SMTP id
 d2e1a72fcca58-8bc1dcfeb9bmr5054300b3a.49.1794469940139; 
 Wed, 11 Nov 2026 23:52:20 -0800 (PST)
Received: from [127.0.1.1] ([116.237.168.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab5f3f99sm3131256b3a.51.2026.11.11.23.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:52:19 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 12 Nov 2026 15:52:02 +0800
Subject: [PATCH 1/8] drm/msm/dpu: support allocating multiple CWB pairs for
 quad-pipe
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-cwb-upstream-v1-1-a6a88d928aa4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794469928; l=2316;
 i=jun.nie@linaro.org; h=from:subject:message-id;
 bh=DFFqJXWFJxJyHSAZmG8rnS2E1iwzVj1z2iZiYN5BVgs=;
 b=Cs6nofFJ7hs40Muu1yiYuOl8z54smVBLQh8txW3GCdn3f+u4H2JkZRypu80WaBRlsDJ5YGuf6
 tvuiBPyWPS3AzLvS1IcXy6C9jMzu33R+Sqy9NptyboIp+zVn9Gt/yfD
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

Currently, CWB allocation only supports a single pair of CWB muxes and
dedicated pingpong blocks. In quad-pipe topologies, two pairs of CWB blocks
are required to feed concurrent writeback paths.

Because each Layer Mixer (LM) iteration previously restarted the search
from CWB index 0, allocating a second pair would attempt to re-evaluate
already considered or reserved CWB blocks.

Track the start search index (`cwb_mux_idx_start`) and advance it past the
most recently assigned CWB block. This ensures subsequent LMs only scan
unallocated CWB blocks, enabling support for multiple CWB pairs.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 7e77d88f8959..4ada16cf8610 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -244,6 +244,7 @@ static int _dpu_rm_reserve_cwb_mux_and_pingpongs(struct dpu_rm *rm,
 	int cwb_pp_start_idx = PINGPONG_CWB_0 - PINGPONG_0;
 	int cwb_pp_idx[MAX_BLOCKS];
 	int cwb_mux_idx[MAX_BLOCKS];
+	int cwb_mux_idx_start = 0;
 
 	/*
 	 * Reserve additional dedicated CWB PINGPONG blocks and muxes for each
@@ -252,9 +253,9 @@ static int _dpu_rm_reserve_cwb_mux_and_pingpongs(struct dpu_rm *rm,
 	 * TODO: add support reserving resources for platforms with no
 	 *       PINGPONG_CWB
 	 */
-	for (int i = 0; i < ARRAY_SIZE(rm->mixer_blks) &&
+	for (int i = 0; i < ARRAY_SIZE(rm->cwb_blks) &&
 	     cwb_mux_count < num_cwb_mux; i++) {
-		for (int j = 0; j < ARRAY_SIZE(rm->cwb_blks); j++) {
+		for (int j = cwb_mux_idx_start; j < ARRAY_SIZE(rm->cwb_blks); j++) {
 			/*
 			 * Odd LMs must be assigned to odd CWB muxes and even
 			 * LMs with even CWB muxes.
@@ -268,6 +269,11 @@ static int _dpu_rm_reserve_cwb_mux_and_pingpongs(struct dpu_rm *rm,
 			    i % 2 != j % 2)
 				continue;
 
+			/*
+			 * Advance search offset past the allocated block so
+			 * subsequent mixers allocate the next available CWB block.
+			 */
+			cwb_mux_idx_start = j + 1;
 			cwb_mux_idx[cwb_mux_count] = j;
 			cwb_pp_idx[cwb_mux_count] = j + cwb_pp_start_idx;
 			cwb_mux_count++;

-- 
2.53.0

