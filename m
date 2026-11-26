Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD658606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZdTmBJzp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BUP31d3v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FED10FBC4;
	Thu, 26 Nov 2026 06:32:31 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D3910FBC4
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:19 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36gnj170329
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4AkcPh/1wch0GkquBRzujr3SqM+yDsjNnQ1ilgbyD90=; b=ZdTmBJzpsejhQ8Nb
 +TcwWFSNTj2fYAuNXt2Fac5+3/twa7YPJCacab9hyvr8QYfFmefKJnKxFnOH37O2
 fcHVJtUkrsDVIc0XgPQyPaeW0CsTQn3X3eihe9H6mPTbsJhjCD6gD+atcm+QiA0B
 PgM04MsCHdUudm/AO+rckGk5PFl/RdgF7FaTqqCfSk3jLkeogRAZ7nXeadwsA6gk
 DypoSQoT6dvoNhKo5FmOrwgCLou7P/J/B/DbWgzq34Oybc8PkAGjHQ+dzKGlnaYx
 ttPLSgE/QxIy9SH1kT6l1n/CQm9PqDcJv5JPVVYoanS/ho3rTmDylnmmOTgu3ZKc
 PIyMPg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vukv9mx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2f04561ee04so38189205ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674738; x=1796279538;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4AkcPh/1wch0GkquBRzujr3SqM+yDsjNnQ1ilgbyD90=;
 b=BUP31d3vP27DYhkA5LRB3uSxQcKO95oGhTdsRgPmef5jZmz7Bo6oO6AQK7LieZdTFi
 bFdbABlKMzWIFJMvSVECXRbmlLdQ5BK7bH/76trMwezJYOiXZbCU6jAyl/IqeYwkveGc
 5XBD0FjF53RI52kFd/lAabQNsINXgsRr5pmzdBcn0EJI9c1XMUy4nERdwWdIUCpg6MZr
 aE12lsT1iSqdvYv7FE8+9W/m3PjlM2RjoZh7I93wJgciYWbpuv6dzsNGmGGGTIXtRSBX
 W5Gkux2aKRSJGKyQedO3oml6jnsEnDLTKV81PlSU/GIukKXaDMjMb2rMXcuQBg68IfHj
 +72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674738; x=1796279538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4AkcPh/1wch0GkquBRzujr3SqM+yDsjNnQ1ilgbyD90=;
 b=Wc8uuektUHaM0G5cieb7CH4OpSYLh33+xIUZR2aBLOlKqFvFgpLuBNeEN9Z6oJkYqx
 diPLsefOSPeHRcwBQt+4tPBVNlxk5kU5JophGnnKvdkQP+KIZ54QdsXVWdrU8mg3ExIS
 Udkts3ENP5WC1tJHZLii8E+gS64Z0LH2eiEAf61CrVGKUUaaLfeOPF1Gr89CLKNAdrqR
 LJdK1m4JZ7ytdgCZTGyBvEkf1dzm/4IS63nwUvnWA+W5Fc1gY6MxmUmLBG7PA9qbjY2c
 PwQz10/PrDmUg5EEyyHU6qzeC69fYEoISc+joq/fsTKmT4ItaU3tcxER1Y38YMb9FNZz
 Nj0Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHoPzTVgjC8kINlwAwYQIy78qaX/vpZK288A2TCbu2F/+q+h6MDQ424Ze6sD6B2Pllv+WBS0zflzhU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+kKKO1ZKOPhHRyBGcIXBZc5m/S03W0CUsMk5DwVQdcUMsP/Nxk
 n3LFqFiw3IIJy+QJwY0YUUEIurrF4MF52zuZ9Tub+BURQuL0mltqQUU+ucWBrM+9fvWa88a2x5X
 g66xV8/5394z1d/F60bgjE73DRpL8Tmv29nS3an51tV2B+NC/Mzk99Q6MaLu3RVoX3zrtv/k=
X-Gm-Gg: AZFdTZd7QjNOLeWT+ftV3NG7B2sF/9cHLLde5STpWZo5iNxbZDzjYn7SUx4BNJE65z3
 hRwf4kxCFx7XDIEqHmrQ88rkkd4ijbqH4Y3Llvy3+xOs4wLO/VPKbc9QtfR5eYjgvOmnAXs3TgF
 IADNzO/odEFXKU1eyT4EVXx9GGOJu/S5lcjECGM9HT0fuNW3PBlCytQdmGVhiumarmUQ/ACWY88
 miPgwaRIIgf5GWrgrW8xVSvOX6/MtNCmzPk0Lg+JXo15JdwTyAY5TaTcwJaPJvVX86CC2XfnrzR
 iemlKIJ3BqQPWAE66hcg1IOdr3kZTe41+7o7ibW9f0Z6uL2Eb3AmeBEbK4vFVR3SgvR1dSn3IrN
 k7n+XNwwOWrGQ+EryEHdnNZX803KwQbuRpXY9OSmhUpRKCKypXYyL+Znc+h/EtL93M5FMQ2YQhh
 FvljInf4p8
X-Received: by 2002:a17:903:2406:b0:2f0:ea76:1a19 with SMTP id
 d9443c01a7336-2f0ea761b46mr18249385ad.54.1795674738155; 
 Wed, 25 Nov 2026 22:32:18 -0800 (PST)
X-Received: by 2002:a17:903:2406:b0:2f0:ea76:1a19 with SMTP id
 d9443c01a7336-2f0ea761b46mr18248945ad.54.1795674737658; 
 Wed, 25 Nov 2026 22:32:17 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:32:17 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:28 +0530
Subject: [PATCH v3 20/21] drm/msm: Register the DCP backend
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-20-f1e9d7505039@oss.qualcomm.com>
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
 linaro-mm-sig@lists.linaro.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=921;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=6PWxDVi4BsbO/741ftQsQBNSZTnRP3jHkckpMt40Eso=;
 b=Wl4BjgymT1IPugnivQbz8x6tsQhKaYhy1kx4zbGuLUWYteGkdm3HxalR5HeEUukju4cP5dIWN
 +kl35YXB7zYAwa3nkmZqDOH4Hq8/2VZ6AY2DQkmg7CXkeXse2A2DgET
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=KfVHIgYD c=1 sm=1 tr=0 ts=6b07d273 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=BMemq1xz1GlmVizxLk0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: U3v8DQZwku0lhFLxWIrFXG2VCd9CGqB3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX+Wpu1W4T3xAn
 BsORo5U1uD9BYVqw8GweL7uwOdVu9UaWSh1aXwTgUz0raHIYfaG/3vfbzkiWRaGr0mqa/K9J5HB
 VYxMsWptqOyKmM6rxnn1bJP/yD+ZzVE=
X-Proofpoint-GUID: U3v8DQZwku0lhFLxWIrFXG2VCd9CGqB3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXznRBC6J/v02N
 NTprc8zB2k+GUKGuEJqxGAwitv2F+noW5udSaFeaik1BblWcGVptBdK6TNh07f5Ei2FZBQ1L5rL
 Z+THKKHGlcSQ0JhWBeVIID/xxMKaejDY2O506X8pGQgJqOMEfu8mZMjubrlmEOalzN5JJys8c1P
 hWA7TKorJl4b2TMpxcc8EO7LAQYn2GPM+nlUXTMTdWBy2rxumHbq1qHm4yBUiuXYqGC9Qv0mV0P
 Tx/8jxUzHDsYb4mwZGLDuvYxiiIZzxm3HgCUir6lL5T2Uv4QXbXQJj2muFnpE7i2EXJFyU6COIs
 plKn9F+8tBYoEGizXByXwL1febICRoNLDLHTSjhOZQW4ZPAaUuFsEWXHKifnYOgLfNV1cmhnrSG
 U3nFoAWEUiHhhZ3moGPuOedunzD9fSECi5oFMd8AamLAcjT+ACC4ZXpo0V7DbbpiZNtlyzadkF8
 kjJ0fI/zUAzvbcz6TaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
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

The DCP display device is discovered over VirtIO, so the MSM DRM core
must have the DCP backend registered for it to bind.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index bb383bb0fe8e..af95237ac872 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1209,6 +1209,7 @@ static int __init msm_drm_register(void)
 	DBG("init");
 	msm_mdp_register();
 	msm_dpu_register();
+	msm_dcp_register();
 	msm_dsi_register();
 	msm_hdmi_register();
 	msm_dp_register();
@@ -1230,6 +1231,7 @@ static void __exit msm_drm_unregister(void)
 	msm_dsi_unregister();
 	msm_mdp_unregister();
 	msm_dpu_unregister();
+	msm_dcp_unregister();
 }
 
 module_init(msm_drm_register);

-- 
2.43.0

