Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB87C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4011310F341;
	Wed,  2 Sep 2026 20:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D4/xxysH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dZc5S8EP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD9610F341
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:18:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHIMS1962876
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=c6HQDZCYEIM
 syPfEAWg93U0OzA1bvoHTLf63dEO3qvM=; b=D4/xxysHu6h5JqhAcumyeOuS3B8
 W8HHU0fAh48XcC6p1FWpCc2Nbh86TBNshywT7oaRRWlnNNGj16e5t8MJkIl0qkg3
 QlE0KLApseLXQGMF/TkpZph7x6/qwS3VGBhQ1yQaaay0gsb5lbWSfZKY5MwXlzPO
 SWK+FZWTmf61Vr2egMo37bFGQmD2M08uWW4WJWts/XSXmNiEpoWQj29wYB3AnRMG
 oerW2EcPR842lQMgQNkheGBnvx4wVE9HKfFPSaEy2lHtx4dN+TadUgisT0+mDKZf
 MpZfNS0m23xfe+zQsYROXrYO9VBk7cxQv3AEwOItzm7SU2pEAXWFA+pi+RA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4srur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:18:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso1777516a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380297; x=1788985097;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c6HQDZCYEIMsyPfEAWg93U0OzA1bvoHTLf63dEO3qvM=;
 b=dZc5S8EPCA+OTJPI8iqiiVViGAfeCv8gQFXC6ZZ5v81fGH0REBawoVBJYUebV3GvlY
 JyqDncV7lzzOuFmX0tRJm+hLTNU2tIn1ronQypwNWq9wlRct0myWPOfsLkwH0VtiebdO
 59kYypyfgrtBiW91JMYGR81N7rXhNpmzAQBG7eqXfe+7KoHoe9O9uvVJExdlG7Toi8mm
 tXMWjh9xJkm5QvUhh9B8UFA0mSL8PJOexE+hnCeOSedgIbVojZRZ38ASJFVtERd2U28+
 9zWQVxUoaK14lSoPW6PKw/Nn8Z88A1y9uIKeA20riJHwqP2wymR3DM14NYgWIIe0hubO
 kIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380297; x=1788985097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c6HQDZCYEIMsyPfEAWg93U0OzA1bvoHTLf63dEO3qvM=;
 b=BKXl/C1Y78MDDynRkgC0Hq/iVEXqRp0Eol+J4jTH/zXTUFvmATV7gNQRiuyjFttq0m
 YuPxNurV6uTVJD969kPCRJtXxdD0pQPvHXXfGpbU3PoG7el2no1vrsmDWW3zhLbGb5fD
 qQEsNUHBDuhEbyljurr1lYmQMBrV5lOn0Kq0f1pMFfUgu8gJeC/JaD3utruYUnnbDDnR
 nKkgo8f6fd7I8wUOl/yrDhQ5CGGxo3jXC2q3ukntUJQ07JPoCrbT/5uxv1QM0thao3W8
 Bq5esykf46PTklE+oSYoiV7hySXsdGX41r6ezp2KL0u/xWytfZig7bjcJyyf3WY62xzg
 6k8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDz8upgQbne1/WkfkBy2Zu6yqZKyZJyAdN0aRfmN2je7bCbRTVBw8AtwJvo1stXM+NWHJ30b6SrgQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m/G/KWt3ZpyZHQiSb4p4QW+XL/8RKLKU1JurLpQMHcwq2ylSZK
 4wetJyutG/6K5X4shi3V+pffE4IgnHjLN4jgW3I/2N3Zcdv75F74qpI2Sa9gL5UPJFOgAH0pHrG
 6ex8iG3VSzZNUBAuam3VGjaSaFJWM0OemqDd/4sLYJW2IcNJyEiacepO2HVKVr/qy+5zp8fY=
X-Gm-Gg: AYBFou2moWM89ZF+hTNLD8hye9Gzhvc7iJyZCQVB3tOPsRSGkPBwfVjS9Yc+0M5gSwV
 596/arJHQ3QxjNEpx7Rn9J+npr90Yeev6JU2hkqzOk64OorxcdiabXJtysrwxlW7i4VwFfZBmoe
 /40dj4W7s/9g4A6gIuaACvfSCHSfFkyJ8r17YmDDdrMDJPLPHHFExstwEr2CACvwlWD0QMhN7Fl
 oB6U/8uCysjv3GB7rrdwwRLbVpZ3DoraU0W8XTjYqiP/LFWfY29jhcEedHzqLBxU5YWRFolerJq
 PCaeGIB8w1mdQ/zSbj+4pIH50g4IrfuPFpCREil+XGO06rTE+9/fi2SNJ37cKJw4Zfm9yv5rENg
 RXWpL63gTNcZksbuECq47vDRESVM=
X-Received: by 2002:a17:90b:33c4:b0:398:d132:ba76 with SMTP id
 98e67ed59e1d1-39aee178de8mr9152927a91.21.1788380296964; 
 Wed, 02 Sep 2026 13:18:16 -0700 (PDT)
X-Received: by 2002:a17:90b:33c4:b0:398:d132:ba76 with SMTP id
 98e67ed59e1d1-39aee178de8mr9152869a91.21.1788380296440; 
 Wed, 02 Sep 2026 13:18:16 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:18:16 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 10/11] drm: aspeed: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:39 +0530
Message-ID: <20260902201640.2024648-11-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX/iyfdLDI7Uk5
 dm6WnOEIRoPrbWvwKembhItIfs5N+9GTccILb1tpqtQ9kq3giCJL+8j+2OP8IZGswuojye3DGQO
 8Dd3M3UyRhFidxkjvTtU6o6eTQm3DbHvzaRq8OzLUXXvX6mgKvBaKHlCHsnZJgu/humQE7gYEdp
 G+gxrwElOwLpeVL1n4BYCdP4a+yU/69bL0yiCa2IRURSznKMqeexqJVB7LSawOpWqTWZzK90ivE
 zSrcsGZsboagyAi1VuVo9+zIiz61LR8NwOo1TKwCuRT+k9S2rbuPDMK1yN5U9McANjjMWIG3vGK
 CrvoatYZ4nXbd3jU59uebkUWOdW4cUxSRw51Gr1N57bzgDC8msVD7nOwyySlT83J2F1zdRvpPPu
 0Xmf9HGIm9IlLHY8apl/lxsXZQPzXdJvR0OLAeTRsAEfiATfQA02TmLwNt1fhbw5ORIpvopiXNY
 QfYgRZE8yhSQqHR1E8g==
X-Proofpoint-ORIG-GUID: Tq6NYf8qv7_5A0zIKEwwT5L14q0yBmMY
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a98848a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Tq6NYf8qv7_5A0zIKEwwT5L14q0yBmMY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXwCpNUt00OgJq
 s8/4VBPP4PZ4yXCeikF915leg9hwy91xwrS/82RfFeSY3ADlZzGOf8395fSzunEtZMzmfXlRJt0
 GQ5xlrNaJqi0x/JM2HpezS2iNvsVkuY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179
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

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index d4577663a1f0..2c7e54fc35d9 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -168,7 +168,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
 		}
 	}
 
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"failed to initialize reserved mem: %d\n", ret);
-- 
2.55.0

