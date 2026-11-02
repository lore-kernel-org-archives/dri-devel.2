Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7C606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=exnL2Y8/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YaMRKxLh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E31710F182;
	Mon,  2 Nov 2026 19:00:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C4410F181
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 19:00:25 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2IuWT1558525
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 19:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UttVKb7MWsl
 vuojwoH1mw96vCZ9byntzzqymS3UyJsI=; b=exnL2Y8/JnVvjbjSfuTYD8Xumt0
 Zlgs47QV8kvS56AE11qpAnVESj7x434Ofy60fnejMpiPwSHlcrDrPWOnvrWOoJxE
 X/h3SHAXPRY7uTlZL9N8S7jNiXvMMmqIFWEn7cXKhz1u/3zGeYFs+d5m3j4x6iom
 EU+8pU2jJRJ9j1XirOHjQfc8V+qHACm9Ssj05EMrK/H5CaJ3kUOFZzWqkB+h9w1B
 YiQME+56ZvDYoWS6zO89GlG7HEUrphkU/05Tko+V4BfzLCbjuyzjuRFPOMHJgrzz
 PLA2+QhRY9TjeTzAZtYky/CwLrVT92gGp4bMXV6I+Q5u0GOddkUNIQErcRw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq08700k4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 19:00:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cdb155f3229so977207a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793646023; x=1794250823;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UttVKb7MWslvuojwoH1mw96vCZ9byntzzqymS3UyJsI=;
 b=YaMRKxLhGMKVbKI6jC1Ec8BMOZaoeJVxREXT3OhHgyEQzC4tf4LbQzLpGK2DgOQQCD
 AMd3iQlQ6DLBJtsMrPM1Y+rVKKc1HxnzI+Dz6UdGQZp9fpFesNTAWT+3kCoeixp2qADp
 /qfSIyJ9MSok6ErHiWrInn1bMZJ7M9tLlvg90emEGCDskarimasYZ3KHA1gbBClwCOuk
 599bLbg549xowQLaeLyKjNylNQXMtA3V572Xs9MU1R5W9in/1DmL1T3gYQR3ST3hiOeN
 3HLNtRknZqIpNUA0DHstlkrF5j4x7UEMbdGyiRj+OstnGnziq5r4nu+bv7GNn8Tiii7n
 qutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793646023; x=1794250823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UttVKb7MWslvuojwoH1mw96vCZ9byntzzqymS3UyJsI=;
 b=iN6htnRPGMXWY6n/n44qW/4d3QS3Se9yp004q0PFl8ffejxSKGkOGKJSkUYukp9y78
 Nbujp4OGLgwiYmzWNpnaFxAR5sx7cskEOmspWqBZbG04wmLzulIAZttJpPaS6mmFp2Mw
 Gmf0PgOqFwW7XRdQuiOQXNfNGjRMruQqyEstUvAmcRdSJ04R/oWO0WMO70BhtsKWamMs
 M1M7/llNK3eKnik0YQGvGhg8WYnSMogHasFp2i58kzOBqJRxt6IaLZPIA7heMGY1G3oY
 mQfrjGvIIttZRhq2WLbwagHXKiaZbo0vIB8aR1AXxGwfaJxwbq6EbhTzu6CVSeT72lrU
 CTwA==
X-Gm-Message-State: APuU4Z9DdzR7FdWlcckBMxWd1kBkJ9NAOn4sHE/XO58QjeOsuJWD8Y/4
 RhXDGcZ4G6nRKRLAFN3o5pnGOPuqF0NrGZY2ZUSmHNcjhMfTwZPTlbeFhwxVZQnhBRee0j82CM/
 K28a4n48EnwC3ZfLgA+wLWXrvRzvpaxAmJCmGfUioMDg91AEPhZ/02CrAnCaa4saMU9WPI0iaLE
 cvX9Zrwg==
X-Gm-Gg: AYBFou3K+Mmg8IQfx/Z0enLCr8biXi8uVR2goESG6hPkCvY7S/lenW38/6rNWcSJdm+
 dwF4bz/9/K96AWCB+AHLG6orSFI8w9mOg/U61/LqnzO33SxLMTogykoYN8dvrh7Cn8GuMMNbqj6
 cf+IOT9z8bKeuKSdvKVyxSmAPfTuMZVuhLZoDoZLlQXfBfYWMpkq0fQxshgnS+9/MQdJy9+sObF
 e5zCHhw0bcQVTfjmA2T2XwBo+hY4pdyAF6ts74sDUY24277hbodoBq+8LohMgOlKSa6/LmggWHp
 AKlsdYGwAGkFT57OVuzw9hGSlzEz1zDz1UOsuhtVrCcOFPRuol/Y37dSfpYtTWKsoE5DgxwfzWa
 W/7HpRN+lSbKBEjMpdCsnbOuQPRGLMYMD+NkiRlL3jSsn+MdYrDdTviCbs7pTf5zPdwOUqZxptD
 AGN8SC9eKMc/W4Q2LxX4676Q==
X-Received: by 2002:a17:90b:1d47:b0:3a0:c85a:ee02 with SMTP id
 98e67ed59e1d1-3ae896f87c2mr9662319a91.17.1793646022610; 
 Mon, 02 Nov 2026 11:00:22 -0800 (PST)
X-Received: by 2002:a17:90b:1d47:b0:3a0:c85a:ee02 with SMTP id
 98e67ed59e1d1-3ae896f87c2mr9662286a91.17.1793646022177; 
 Mon, 02 Nov 2026 11:00:22 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c62984bsm444552a91.9.2026.11.02.11.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:00:21 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/4] drm/msm: Inhibit IFPC for state snapshot
Date: Mon,  2 Nov 2026 11:00:07 -0800
Message-ID: <20261102190010.720443-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3NSBTYWx0ZWRfXycZYFeQKG8UC
 yU8C/XNScZsAcXEDdQk1Ff9OFMr2dQKphsYRQRCU+ii0ib6Wevz1RLENoZpWu9wGbL1MJGkyEd1
 IgT83W6RsxzpLfI7WjWaJ+6opu8z8es=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae8ddc7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=jgQnFmZX3A3noQDnNKkA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3NSBTYWx0ZWRfXwWG1Rbja+4Gw
 TKqDpRZMsZoFfSgUDSCQr9ZbvBm9r9f91howgAXenH6VVyvpXo7Iybs+v7/QAjl1pkpx4kGXGHR
 aNOUao2axQXJnCa133QEFZTYDtR4Ba2Qu4N2/O/NG80ObP1rnCw8yB7UMD2JIW0CqvMNwWM9JZG
 Cqd4Ev01ePODYo5V2WM8GH/C/LZz1bmlyE6FZbQ9NHDhscSqMj36gJUHQstOgIXGScuNZ/pDsTb
 HwFqwlO9ZjbNY8tyxz7aP9NYY4T+kG6L7C9UT899t8smfP+aLwuuWXl9N+8eXvZdAo920VyPpn8
 qsKLDdouWsVzATshPiaV5fG4D8HGuzvp4VEkEEaplFOIKXky1oYmKAM0KtwadBvsHFy8WJTWOf9
 8HNIUrRhyHbR7/KXy4DG4TCDmaXQGP/XlLPGQLnPreNFnBRArFFkZN8binHFeLzv6enR8Iydbd+
 6j+2/Svgmg2eick0g+Q==
X-Proofpoint-ORIG-GUID: APVTVgpnbMyw1wlOOGea61qcWh54RHHf
X-Proofpoint-GUID: APVTVgpnbMyw1wlOOGea61qcWh54RHHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020075
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

We need the GPU to stay awake for this.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index aa59b28a3392..29209c23fcfa 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -81,6 +81,8 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
+		guard(ifpc_disable)(gpu);
+
 		scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
 			msm_gpu_hw_init(gpu);
 			show_priv->state = gpu->funcs->gpu_state_get(gpu);
-- 
2.56.0

