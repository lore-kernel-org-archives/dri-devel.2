Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C52606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E9V8VedL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2A110E299;
	Fri, 27 Nov 2026 21:09:18 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E9FE10E299
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 21:09:12 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-93f1e5d7450so781276585a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 13:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795813751; x=1796418551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XIvy0mpNH25dJka9yiHVSc+lFF3CQmZ8/QH30h3M4Z8=;
 b=E9V8VedLpUv7hJrsw3OrCkO2HtlhK6oRtGORFZLQYlnWnBDYTy4irCYQs81rg1oqnL
 WNqL+9Uqa/w6kmjM+U3fJ59CFZgZSFfCkaehOgdSXNxBS6FopJVt2KzzbxXZEKC07Nxv
 6GKeDx66ot4x5e+21Qnie8uyFtuMjrJZBT2xld0RSikYc7FLdaNPToN3jRfMFZMF+nk2
 UM/4Mpu9pWfFVckIYKcQksjH4ld1SJM/vzJz/tQTRQ71sQcvd1FW4uLptN7SsT+hrChZ
 poV9/r+uHmXx4aRt0/Lp3KIZ4SZ+8MMNZETxzm7JxiNFH8f7PdmrpRGahHReKdlnnVqt
 WngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795813751; x=1796418551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XIvy0mpNH25dJka9yiHVSc+lFF3CQmZ8/QH30h3M4Z8=;
 b=ZpfwID2yrq0F8SXCLazdGolLg+2NQzCVk4le6JR+yD+CkSOJb0ulZjP2dPtD3xmetL
 kUu7etyGp1SLt+dcdnzxAVWwaGfeeFLk/n4jDmSFwEYFnF7uEL7PURi7lVvqhFdF0Pn5
 13/bGhXuc798w1Aw35Zqyf+SrPgEmH7MFaUJVSELIu78IOCASUBrcC+9LYx/iEEzQ+o3
 NiD9SEjoupC8qOFZPlmefghhwp/qCfKv43cDmRVoKL77BqkI5xtLKOaEvrvhnSBguZeT
 psYXDqA5I8WmL4/bVF4QCdtKFityUsOBxHoeylHL6I+1U+le6Wc8rVtdyLUuKjPNVjho
 rhyQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEfWHWQGxQ5HSKA/uuA/gUxzRkw8tc82T9jDwHS+XvxD/UglTl6qiWbCOYjyUlsiF4SyfWCJT9F71k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+xT61DPvYcRqagHE1ST7lAAw36Mgq+Om6oMdNN6/2jU0R/CRu+
 tKkXsNbm+V3L3XedGCdwvtoc+/1nacROMZjHtp9+bsxRKspgfWMF5UQ9WzRN4JTzfq8FrJAl
X-Gm-Gg: AZFdTZf5akXh3i5Y7rG4nU3NcEKGp8Ay+ZIoMxPi2lIHe3lBoKvzoksLRCTaGbpfP6d
 2eXYRCXZqEnvV7Y7+xQi0DdHWhSosZ/ikgvQVjj60aHBTQzOcLZdKBFEKFZLcG/VgR2NAfXwjMo
 G4IPHdv5O+sJYv1RZXs2uzyVy1MvwlICQw75d/LBEfMEqZbOhFP0no/4IX1dUsxQwb11jUhFlf0
 Rdma+4QUP2OJnPnsr9OzsNhr00M6yuDzXfgTAut0eFwI88nMrGHyZ64GWGBXTmxwaDgj0a0wC8F
 jN+tDitqAl8FDtEZnYl/Ofo0pyVAQkHXdHtyFhpcQGI2+gZ6aLkJdfyVSRDmewfgVR2tr9scT7c
 lzcInAogGCQ8FlMacF1YYaqJjKtz7ULGC+TXnD6rt2OoJUG+44a0rOKJSw2c6eCkcBDXhVMT+mK
 qg0rvAIz3m5ha7Ubjy0NjPT+wpok+aloYmz3f3O5sdulkBIkS5IOQcDE9FDO4PvxZDpgOcjzbG2
 rJ3XWv6YIvqBk+x+eie+DJncNaP7d4VSPLGkDHMczdAwCdSXTrs4+adbj+LnydKWjUSaAQ0BusN
 qwf8T8n2dRh0XZ6POCcFm2qhnE+mM1fVf9TPVrM5rK1gHvVyd9O/jKr6rm/7mD3iPxv3SQt9jhb
 uFOs1vYjaGVpodXh7W3hOmChK0L0Cm06zz2o769LM0dlBllGCDUMqxCBZakl4IGoWGL/zAjnFxy
 IKDr3JBpv+AV7lM61KFsGPkjDKo0QT+Z4k6WD/6vFdtCGi91OxSqRmW12LcE8rp+miBniwP4Qo/
 z7Y45h5EjV1uNduEuplbUkH1bxWfbYc3QDvYfoshOjYtQ==
X-Received: by 2002:a05:622a:a10:b0:55d:17e:f87 with SMTP id
 d75a77b69052e-55d769374d6mr471770991cf.1.1795813739524; 
 Fri, 27 Nov 2026 13:08:59 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net
 ([2600:4041:5046:1a00:2403:c7fc:983f:c934])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882e32dsm219584681cf.13.2026.11.27.13.08.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Nov 2026 13:08:58 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jesse Casco <jesse.casco@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: link Glymur layer mixers 4-7 to DSPPs 4-7
Date: Fri, 27 Nov 2026 16:08:57 -0500
Message-ID: <20261127210857.65336-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Glymur DPU catalog defines eight DSPP blocks (DSPP_0..DSPP_7), but
only LM_0..LM_3 set .dspp. When a CRTC requests a DSPP per mixer (e.g.
for a CTM or gamma LUT), any third display assigned to LM_4..LM_7 fails
resource reservation:

  LM_4, invalid DSPP_-1
  failed to reserve hw resources: -119

Set .dspp = DSPP_4..DSPP_7 on LM_4..LM_7 to match the declared DSPP
blocks. Tested on an ASUS Zenbook A16 (UX3607OA) with eDP, HDMI, and
USB-C DP active simultaneously.

Fixes: e2aeb8deddae ("drm/msm/dpu: Add support for Glymur")
Cc: stable@vger.kernel.org
Signed-off-by: Jesse Casco <jesse.casco@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h
index 4eb4a0e..280df25 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h
@@ -175,6 +175,7 @@ static const struct dpu_lm_cfg glymur_lm[] = {
 		.sblk = &sm8750_lm_sblk,
 		.lm_pair = LM_5,
 		.pingpong = PINGPONG_4,
+		.dspp = DSPP_4,
 	}, {
 		.name = "lm_5", .id = LM_5,
 		.base = 0x49000, .len = 0x400,
@@ -182,6 +183,7 @@ static const struct dpu_lm_cfg glymur_lm[] = {
 		.sblk = &sm8750_lm_sblk,
 		.lm_pair = LM_4,
 		.pingpong = PINGPONG_5,
+		.dspp = DSPP_5,
 	}, {
 		.name = "lm_6", .id = LM_6,
 		.base = 0x4a000, .len = 0x400,
@@ -189,6 +191,7 @@ static const struct dpu_lm_cfg glymur_lm[] = {
 		.sblk = &sm8750_lm_sblk,
 		.lm_pair = LM_7,
 		.pingpong = PINGPONG_6,
+		.dspp = DSPP_6,
 	}, {
 		.name = "lm_7", .id = LM_7,
 		.base = 0x4b000, .len = 0x400,
@@ -196,6 +199,7 @@ static const struct dpu_lm_cfg glymur_lm[] = {
 		.sblk = &sm8750_lm_sblk,
 		.lm_pair = LM_6,
 		.pingpong = PINGPONG_7,
+		.dspp = DSPP_7,
 	},
 };
 
-- 
2.56.0

