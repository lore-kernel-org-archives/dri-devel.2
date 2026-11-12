Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1A606A885
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fr2aSa27
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FD510F712;
	Thu, 12 Nov 2026 07:53:09 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71BA10F72D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:53:02 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso344571a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794469982; x=1795074782; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M7aNgwut6Pkc4vihJRTUegbGMo517hIzijJR1eDiHBI=;
 b=fr2aSa27ZE3guhBSMPR9O5l9QGrGa6qjcGJw/tXdxeLJ4tKAPfHpFrd9D1dF5NGrnG
 Sne2bQNQ2PeaEYhRY/URY+/AKVfqlSL+YLNZWhNvLJBZQNmXErMPpcqk/7+SEGFzUUgD
 QzIT+s6XGg1g5g4lQoaxVAUgKOsfGGMdJviNNgE5v38OnHuKjROdtrHtn1aBnp9RrkGK
 psaROy/w/azl48Y1Db1o6Aj1ANTi+FO03ook60GdXPaXFMpcwpq3iEjq1QW0FMEFDAwe
 HwzdTwrqjspfqA9BhdHEajx+tFPxcvbTASkiceRDBkKen1jdkdkspidWyAcSTfC374Vp
 AiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469982; x=1795074782;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M7aNgwut6Pkc4vihJRTUegbGMo517hIzijJR1eDiHBI=;
 b=cHZkDJNoP7M7LnJibcCJIcUDVyNUSJmdZlQZ4OGqEcwDTfNr4Ll9V5nyqTphzFOWC/
 IZns4zgn1jzwMAk9Es4UYj6L7nd/yaEJyR8hcIbgA3tWLdNeWqr5LKVaH9H/s93EpPtX
 NGTKpOCPhul3YBcPWuQ/R5LSycCC5MBx+VQ+6cDxcTzmGr0mbMoz9/ncFUjr+xaq+riB
 74UiFv0xST2u+CuKSfDcjqq/hfWVpo6e7Y3xJxZFp6iCJGBMAp0nNueNnPHO/guWuhzY
 dC4RLtK4IdYvVp91a8hur9Jj6n524o+HC5lkQr3qxco4MBSxdv+BBymgagHngcisemfh
 cn2g==
X-Forwarded-Encrypted: i=1;
 AL+hErFRvs3uFOupYJt0K615+DJq8qSEMA8tjZ32fE9rwsZwOd2V2GOPIgTEN3f9fdWqVlAHdBg9V4Rn0OI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9QTlkD6hNfc07cLQhTtpOjMF+BjowtyNpfxJvG/AqsvcQDqu9E
 SM/ir+Sm/64yIQzINhQUB5KfuGyrWS7xjCYeVNUD615Tw5RNwb/o7+YzZTHApy1ioSg=
X-Gm-Gg: AYBFou1bJxSlzdC7/HCf1esFRjxMJXqgobV6Y2ad96capx8HbWzNPXREZXUcTq/JRlS
 YPWWY12LNMoDoeNTwXQArpCDdiPAYWoZE/R3pPhasZoL5jcJuURK415yTR5FeziE8w50EAdawlS
 0DI2Sh3wpxDel/JzgjrHYk1UUJap+/2GRyf4ZQF2abJt5crOk5a0GbukvvNE5vLZQKirE708sQM
 VbiE/6TzHD58nLtD+mwD53Z7iy2S02/B90sl5s8y9sY6DgUVCYcfXCnC+3i5foJ+KmK5J9YU3WZ
 YrY5mDnIlEA2gMSzeGoos6HMFR9/kSzx9x1GtVMhJ+XON7ZsVE2gxanbyYfTiP/LHskWfslQ2Rx
 nEomYanLddXnglxMsBrTxgZZWkmVcGyjea1V9pBGEhoi6mYADOUeNrdnO+ioUAi4ewpWEbnBqVQ
 ybWshwGJtbtHBkt6bxjzWq5cqXfNumuQmtV0LTA8FqfClTq9/S3Kqo7BIVfoueq70bb9/ASRIkO
 JtHju30TOe+Tf5D3Tht4tZEeHLSh4wPXFT4M4C6DnZQJR7kEClwAWLV4vwp5YtGsEFBNUGM9d3R
 L4/onJkpNI77OjHtXg6zlTrGWUfvTrB1FNJ64La40IUrzIJ6Atc=
X-Received: by 2002:a05:6a21:3e0b:b0:3de:57da:7fa6 with SMTP id
 adf61e73a8af0-3f631b8bac5mr1129232637.39.1794469982178; 
 Wed, 11 Nov 2026 23:53:02 -0800 (PST)
Received: from [127.0.1.1] ([116.237.168.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab5f3f99sm3131256b3a.51.2026.11.11.23.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:53:01 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 12 Nov 2026 15:52:09 +0800
Subject: [PATCH 8/8] drm/msm/dpu: Add the all WB interfaces for sm8650
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-cwb-upstream-v1-8-a6a88d928aa4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794469928; l=1060;
 i=jun.nie@linaro.org; h=from:subject:message-id;
 bh=b7WDt00uQDDX1aGwCR8y+UiMnK66w5MHAcAsR5IgoCY=;
 b=JFbfRJDpW8UqYouqr6SrrMmcYZaVK8J9uqILmonXoCX21jGi5cYcWkFvkU7POyec+KG+7HOU0
 HPjiFBu634wAJqeSBX2CGYMriG/EIPVgTAnM6RKH6qIDj+heWRXaub2
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

There are 2 WB interfaces in sm8650. Add all of them to support
quad-pipe topology.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
index 2eef5f69832f..e9fcb402a34c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
@@ -315,6 +315,16 @@ static const struct dpu_dsc_cfg sm8650_dsc[] = {
 };
 
 static const struct dpu_wb_cfg sm8650_wb[] = {
+	{
+		.name = "wb_1", .id = WB_1,
+		.base = 0x64000, .len = 0x2c8,
+		.features = WB_SDM845_MASK,
+		.format_list = wb2_formats_rgb_yuv,
+		.num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
+		.xin_id = 2,
+		.maxlinewidth = 4096,
+		.intr_wb_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 1),
+	},
 	{
 		.name = "wb_2", .id = WB_2,
 		.base = 0x65000, .len = 0x2c8,

-- 
2.53.0

