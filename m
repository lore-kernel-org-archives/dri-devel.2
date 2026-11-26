Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ABF606A69D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KwLkEcN+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MGuPEvFX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B18210FBE8;
	Thu, 26 Nov 2026 06:32:22 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FAF10FBD2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36Z5j2069150
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DeKH8TEoLZ+vJK0OK3U5kpUI+ceUEEYaOyX5flLErhs=; b=KwLkEcN+3tM7E/Jq
 zrm3P6u1PZaHxwIDGxCqcQv67I8AFt5Z6oAFSlGRZNygTSa8Zdud/JWqoU1ciy1o
 ZVUDxEtEFTew0UWzEEQhlj+leiGzmap8kC2czZcUp03ICNBUAoms5plgWzac9age
 WAcJsgbhjFE4f7BMXMyjKs8I7cG6IJrtN33VUKJEJyp0AcWn+VEDAuZ05Zl7cchV
 B7wsoLBOEatDcqR4Qx15WMs1Vf9vERRaioz7/HjuDhj/znDdBNmr47SurzVMqeMv
 7MHECDSdFczxFmeKZFjYehR1CVIwg5U93GZwcXFmvsvc7ZzlwqLVhg6BuI8JL9yl
 t4xmZQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662s9s0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2f08196b148so41043405ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674730; x=1796279530;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DeKH8TEoLZ+vJK0OK3U5kpUI+ceUEEYaOyX5flLErhs=;
 b=MGuPEvFXPEHyMuoqj2G4Nuu7JQrkX2og5CBkEHpJTMsmyYBl+6Ds1IHNyTzIrGtLqN
 7Dh53KPvX3ZbaX/MSVJPjveWCicxu0xAX8ZlLnl6Dq14EaZrXJw4woJw5Sa97LiHjf+N
 29xrg/GfNmCe5VXM8aJHtcgALAS6aF2Z5SiFsprgVcaqBD890g48M5upDiKoQ1TzSokr
 +uHGy08B1Mp6V9ik63+pkLGzNSkul03+cDilaMASso2kYGGynxb68eiHyR3YjMyuza6x
 hsmn75C7nXIaAjQ8MCCK3hlx/7g2PURYV2FgQEMmd77wIl64QB9ya0JUVdF4uhXUY+eH
 XRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674730; x=1796279530;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DeKH8TEoLZ+vJK0OK3U5kpUI+ceUEEYaOyX5flLErhs=;
 b=Rv7Zj8cfN7Oa6OhbY0F6UgYvd5wt2uIEY/zsWbETf2qyON6/E2QONssTp9D+hetW6n
 It9qKqmk3bfLhsI8m4mPD1LuzdlTm2nO4RX8XxRSqlZt9EA5bRlUkoMc3wfnh+4EJ42D
 MeDrWO4Zf5VoxMzcECqgeW++KrOJfuVxOczaPOhdOy4tVYIzBuP4sctT85NXXSyW8Vva
 LTQR0z7sqcamAX/9b+KLR7FzIdGaXduaF2swt6YNaSmhS4hPZC+F3d8BXEHzugRVLgpj
 Uerf8qNHXgyaF7axTge1f/IiNxAKfFTcfjppLr/Hqx++m4vXy6wd983k3OdKSiGL/MBE
 6gPA==
X-Forwarded-Encrypted: i=1;
 AL+hErFCsE6S/hEeRjpcleVjsNIAwiNlNHy0FxiEmPMrBMleHXaddxE1+XG1/mq6FwlpLwLuDxfpBPTlbck=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9f87APD0wbZLIkkss/PxIRJAFq+PrOmrcUO9BkP2VrfbbEAoA9
 SyEjAvu9PlltkmclGjCM1N6s13VRTaUChIVlhmTvbXt/0tUBx8nkLIirocRhYYkw5KKSsnGGGef
 /kShQANI9/xGtAYJBYG4lef6quLtB9ZwKHjvCbmlXc68+kkKRU7OAavpcbaRjecwtv2pzsRU=
X-Gm-Gg: AZFdTZd2oX1BT4odskug5tTvjUef0b6u1/IzHAf8XwLPKOt6MvbuCu6SexXx4n6Si8J
 cProlyGeWVcW1EUQzrp+kLCygQdfDMh9Wa7Gl/VSMbrp4nipx9huawHmxVqYLc4ByuCHsMv9TDw
 4KtyP4apE3qpGqmqcc1vMdPqVgBuGedWe5ySVnzIG3MHDwqS/N9HSODPztgqhnx5UuKhxadlioc
 Po3SHauDVIStVxK97YZ26YtEFpdZvhO+imZfxU3lOcm6eMgcrFG8d5BBXtd6rUmRze0SFRMPYZ9
 YDvZXzLKdomN5aC+PyG4jgx0vjAM/Il3E+PWoPZn01HG8cdy9f39jQktjLpaxqgXTyIPZEF9QxI
 whBwtyrS2dCcNudbx9ki6st6KZE3lA+3F+j2oLeFZIoWrfRdz2jWQGwd2GfyluVDNKZbBpHEcQM
 W6CzWtewd7
X-Received: by 2002:a17:903:19cb:b0:2ed:101c:480a with SMTP id
 d9443c01a7336-2f03f1c007dmr218271195ad.37.1795674729932; 
 Wed, 25 Nov 2026 22:32:09 -0800 (PST)
X-Received: by 2002:a17:903:19cb:b0:2ed:101c:480a with SMTP id
 d9443c01a7336-2f03f1c007dmr218270835ad.37.1795674729434; 
 Wed, 25 Nov 2026 22:32:09 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:32:09 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:27 +0530
Subject: [PATCH v3 19/21] drm/msm: Support KMS backends without a display IRQ
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-19-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=1191;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=OeeUkS71qhEHZfJKt5l7tFxYoS0sgnGLM8wENixTSYU=;
 b=xviT776rfCeMHIFO3g8aaW6MLHf1PKw27DBdPxkNYkyDI6t+nLjVEm6uO4H7Ode9HZee3kh4X
 Qit8ls5DWndAfFs+hSXsT9IZFIJa4EXjRfVkVEvK5CL6qZ2pjmmnDDb
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b07d26a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=g9RcmOnx5enkyd0xrYgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: r3KQDM_QHcLw81sTM10BqtYkkD4ZKrgX
X-Proofpoint-ORIG-GUID: r3KQDM_QHcLw81sTM10BqtYkkD4ZKrgX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX3IPa/AhwxYFs
 6do9xG+vbz2KTYUKZH3oNylBmMJQXsAf7EGGLDqJWsCW5uyLYD2P0WLbA4Me2sWsf7todRnoPin
 h4DpK8Jq4CpWU9GQrl3bhjDJsY5dWFo1Tywb5tqYo8fnjHU+Xr3GdpqGSeP6rEyqn64UV+QMVd6
 A1AvXJ0e5cgG5HTfQzFj2OP/6aA84NwegStRjRe6s+2q6kKsR043INLVqI3nf6Ve83LtDolU2AX
 HCpbZw+kCX3K0l8agGmPsJ8DTSGQ3p4TKm5+VY07NHemqWMTefHhRY/2IvirIrqUqfNMrwUF00z
 bqs+NGwZyPx5aq6Lvl+WhYs0wcG21m+7EapNRVj9nskRLHxVF8+CZfNCjBm/S773cAfKsaM1/jk
 cn63Ik5GZBK1CUj8ArmoBE98l0j2ifYMk/WwnmTj/CQIMvD9neFbUM1XtMLOU7YQ2A2HIPCszPJ
 Nt6RyV6NHY/ToCBepgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX/9NkGR9TbttN
 AgJkSqvHIQoTZROaQeOzjpM1u0sq2SIjw8/s4Vysx1Wo/pJP5dW5XCbjO7zKJ2+brZ+lZU9NcUL
 dFzfMYBkTQe49UT0gameSSqjNqvxCVo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024
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

The DCP (Display Co-Processor) KMS backend receives display events
through firmware over VirtIO and therefore has no host-visible display
interrupt. Rejecting it during common KMS initialization prevents it
from using the MSM DRM framework.

Allow KMS backends to use IRQ_NOTCONNECTED. DCP receives VSYNC and
frame-scan completion as asynchronous HFI events over VirtIO; its IPCC
interrupt is reserved for power-notify acknowledgments. Existing
IRQ-backed KMS implementations retain their current request and
teardown flow.

Assisted-by: LLM
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 9592fa28c85b..fe6f290d7be0 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -72,7 +72,7 @@ static int msm_irq_install(struct drm_device *dev, unsigned int irq)
 	int ret;
 
 	if (irq == IRQ_NOTCONNECTED)
-		return -ENOTCONN;
+		return 0;
 
 	msm_irq_preinstall(dev);
 

-- 
2.43.0

