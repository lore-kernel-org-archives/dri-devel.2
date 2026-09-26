Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AB0C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 18:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A94A910E3C8;
	Sat, 26 Sep 2026 18:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQXusu/G";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VEVt17xd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E189910E1CF
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:58 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxQ603167926
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zk3EFZth1oJ
 /gVFkRmzbBP0BnUbUUlEChymi6rBEiHw=; b=lQXusu/GJwD5OG/M8IwZrtRKLXP
 7CpNTJfQtYJ0uNldqoOUBanEgRO3r0EsrY0Il44hvlgCaJgYdn8R6Obqn5pQgL2q
 XT4Zm9OjJs6tRZpieL/qG3Yev2qwFeovQafyvvGktpBsF1Mtrcbe/CVeQIxqY+/M
 0x8dgKhf/v8d15hP75wc7cDA0A3tbSFtDVELAjVC4D7WA9W16notzwJ1ToTPkAUb
 Fw/9jmoaf89m/2BxdJxKm5sXfThflzVEmtJbA6ny2D1yCt95LAwvMqrmAE1SerFj
 kTOpUy7Ib1nTNX1jfKDW2rMbTh9Q5PSlWzTeyk0SPDJmRbuqRo1KXWN78HQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jscsf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39b77130a7fso2001639a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790447518; x=1791052318;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zk3EFZth1oJ/gVFkRmzbBP0BnUbUUlEChymi6rBEiHw=;
 b=VEVt17xdcbDmfcFqOTfOd0xzSjAIEV9PuKbBHP9wGvacw0uMYkOraNzSVnd1cFcOQU
 9BH5wFFZwpyIA1w6qXJDVa4Dw7ZXzEXwlZT6pNC9+CL6ZtsKIuqTD1VJQnyzu3OyxWea
 oJSlHJFTzbSVNSQM04wbPhFRX+CgOC8KkpLrGeRiA4cNhaMeL6rV1OuI6k+lvd2PwuER
 OEFU6aoVNS9cOVCdM+JeBvT25bcKEo+1AK6F8ENDwV/9stAGIm42K2shHbGKex/3umpH
 5+6pIjxh7AlLNJeFqj8ULvQs9L0zY5Ofw3izgn8oIEJWD+sSzC3uWDwiDOaxB6DHg24q
 KRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790447518; x=1791052318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zk3EFZth1oJ/gVFkRmzbBP0BnUbUUlEChymi6rBEiHw=;
 b=EVM8MMu59t/Rst0H+I3/d7pykW4JbuQrZRkc8gY2AqyHoXLKcl6qzYGAqV+lJaK85n
 1QKG0i6xghOCFRA9fmMJHq7bj3nSngYGIur18ydtW4sjmd/2J0SgqtTeEV8hmJop7JfS
 MuLKy0FELowlxJTARaX8AdqNt6ga4a5JA2/6kOz0Swchqo+ZHZYQ9e4xffW+Nc2p29P3
 T1+hAUEUXYrqG8wl4kMvMBrjEqodyrJLSCO4yv1wWo0lYCb5PZ/mH93dtw9UAv/DghXJ
 HxLDxB72f3cuEDFA5xhgyqMYJlklCP7sSWSHiLMB2dl0PcdmQsePk1j3FhxHE+jgUQEK
 OuGg==
X-Gm-Message-State: AFq9FYLPM8QPAwQXqWOOAdzfGrZQAq7UBYkpEUUSpjkC+rmPtxm7pjt0
 2gzsVdeqd16Wiz9bT4V008xf0AkOKW0VwhhTorbX6q9eLJgu82aX4PdawzQD+/24lxy8331kEDu
 mD/N3iGSw3a6USEUWlIBlengSgvDIuk3PFXdr+F2PCsj6Y7mn1DG6lvyOhMjmJQC6g2hsKAXlQ8
 QBUtE=
X-Gm-Gg: AYBFou1EZaoS7j+RhzV+tP8WUlmKGPydltE7OjmNjgaEcj2aLM+JtOgOK1zw5oQwU7f
 Dv6Tug8G0tcVMGy1PhJwaHTutdMv7AzP4Fij0tHUpUks2WHiemyEwZph+HHy81iXY3IR7fYKD4W
 c71u8yoWiymschlYbopZF5PGW56IhAQHTfPLSEyi3SoSx6h5g5JZhGS4sfqOWnp24xMl8Se+8/i
 tUFzf2dsKAjdaNwN1271QlV0jnO1rwHXDbelRdIs5VUzbAn0FsAzxuul+RBehHsf247O3A0BYRS
 jp/RMl6jHbvg2CNy/io7kpld4PtbcOV5KdX9e1ziKTNtSx8SHpBPPK117EtOwYasGtwx08kKCj4
 1kB7DrHBT1Wl97ZZ8XtpSaR6Sl7g7ZZEN0YULn71rvm9ZSQ==
X-Received: by 2002:a17:90b:2683:b0:3a0:dbe7:971b with SMTP id
 98e67ed59e1d1-3a0dbe79bc2mr2071275a91.67.1790447517589; 
 Sat, 26 Sep 2026 11:31:57 -0700 (PDT)
X-Received: by 2002:a17:90b:2683:b0:3a0:dbe7:971b with SMTP id
 98e67ed59e1d1-3a0dbe79bc2mr2071253a91.67.1790447517113; 
 Sat, 26 Sep 2026 11:31:57 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b9355e49sm10921274a91.4.2026.09.26.11.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 11:31:56 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/6] drm/msm/gem: Stop calling get_pages() for imported
 dma-bufs
Date: Sat, 26 Sep 2026 11:30:45 -0700
Message-ID: <20260926183051.25754-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
References: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfXxtsVw/QP+geC
 S5c5woS4GtmhYvQ4HSLNAMLgeWEXd9zxkFtWqv79U9KvErxVs3ig57kgdjqnQMQ3TghhJC64NqT
 Y2Ir9ObEWRnF+FcmXKe/04YBllda85A=
X-Proofpoint-GUID: 1nhSoo0GqTXj_SMrBMHoUAxMYyu8piKX
X-Proofpoint-ORIG-GUID: 1nhSoo0GqTXj_SMrBMHoUAxMYyu8piKX
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab80f9e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=isCY8TonHXl0-fnU9HAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfX215TzvdWTELz
 wydqkgHO71D8Jyexu0vhjhPuD++91H/LaCAJN9EmpMfwa7TICRMYUYc5HSlEar4YDl9rzQIWc5+
 H/yq2omx8U3bh5kIvHmYBYonqwmXy8/KWNq5SlEmq3XIMQX0s3u9ulgY7wyyX5CNpSwbJsKzVY8
 FwcsihRTgjwmCcQCTurrO9n3mRXCRU3sd5EvxYCsavTI12OLyf0A7DrfDJhHSjudD/ozlNQr4CD
 pquq8xScb2IAIr/gJQ9MCPogqMvm4XZBRXvHOU2j8neFrNDZEdotxsbBNv2mkhap8H9b1BC+3cM
 zbZs2VUSkN/wU6X5b+Td0xvfsJuWRrJXuBH9Y7CsPkSUooOTWkrXRpNtkELua+Fq6tTlAQAacWX
 FUZ3B8NerUHFFZ8v2asX8ZL5wc+5E6Yph3ki6rzqEcqBduA+sqz8+4xj0b6+bO3FSlzfbpom8k0
 MRJnzBVeXvcmji0zLkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260073
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

Use msm_obj->sgt rather than msm_obj->pages to determine that a obj is
resident.  The sgt is populated up-front for imported dma-bufs, so we
will never go down the get_pages() path for imported objects.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 6 ++++++
 drivers/gpu/drm/msm/msm_gem.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 2341f209adf5..3111d7389572 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -193,6 +193,9 @@ static struct page **get_pages(struct drm_gem_object *obj)
 
 	msm_gem_assert_locked(obj);
 
+	if (drm_WARN_ON_ONCE(obj->dev, drm_gem_is_imported(obj)))
+		return ERR_PTR(-EINVAL);
+
 	if (!msm_obj->pages) {
 		struct drm_device *dev = obj->dev;
 		struct page **p;
@@ -286,6 +289,9 @@ int msm_gem_make_resident_locked(struct drm_gem_object *obj, unsigned madv)
 	if (err)
 		return err;
 
+	if (is_resident(to_msm_bo(obj)))
+		return 0;
+
 	struct page **pages = get_pages(obj);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 4f681100ecb0..e92c6723d352 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -422,7 +422,7 @@ static inline bool is_unevictable(struct msm_gem_object *msm_obj)
 /* Are backing pages/sgt allocated? */
 static inline bool is_resident(struct msm_gem_object *msm_obj)
 {
-	return !!msm_obj->pages;
+	return !!msm_obj->sgt;
 }
 
 void msm_gem_purge(struct drm_gem_object *obj);
-- 
2.55.0

