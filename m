Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BFACA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 845C610E318;
	Tue,  6 Oct 2026 09:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QoxI3MXo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UKGu2Unn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E024B10E317
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:50:39 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966gm7e1045854
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 09:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bLRe/KiPWxzXT/tAnFIYoNKsNapLNEr3heqbzCvIFlU=; b=QoxI3MXoX8I+o0uv
 nV7K3HZHkNuNV2VSvXnDVB0/NF/VJWnX/tQ8DUQda5J8acAvHuC9KDuMrcM+14EI
 +sh3mRsqnF3hHAKp01QWd6lyyVh18r6qWZEKsfYfFsOZyi9zoswpkGw4oeCfp1NJ
 U3hTJjU5kuj2pKk4Z8y/Ebv/KjkCzh6GQr4PrZsD08BlOg22dyihju/Iv+e6vfbD
 17mhRGHXWWUKAjmSXb4PUgB1FAPiVIUs9Npk/yW9+O0snZs4u9vF0kJgnt5ABdXb
 Ma1wuXS4Fxr7j4xr9Kx/8H8QqwMWKxzlgBtpLdIThfPzK9ZI9iuEb4md16KuVyWi
 +bVr6g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4uy4gmwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 09:50:39 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbb92868263so1450779a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 02:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791280239; x=1791885039;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bLRe/KiPWxzXT/tAnFIYoNKsNapLNEr3heqbzCvIFlU=;
 b=UKGu2UnnkwEo4aRQg6Pic/OkFgljhIBJ+T5KPsz/21zpSDTvBDi2Xe8GJtj/5EG5Dp
 43fWGDMuoKv9oIBJBM+JfwWI9aQ8XUwPbulwildqG+7mc8kRUwo41LqtpTqR95Wsqq+1
 w/qQCne+ItzlhztF9oKGQdHqg9NkblwJB1X0K7DB4YepmRP/mSts2KLhFdMPVSwICvEG
 uOIlMXOCrYikT11r+sqSayMxyUIw7CG9oH6lRnhxJ11tytGR4P/njQNKBK3g0DEjK6el
 9Q1tTrwxjCJ+7/qHz4OIahxxQJ/uP530ByQsmaZkxVWDyGYY71iURn+DjO9bme88PKPu
 70Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791280239; x=1791885039;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bLRe/KiPWxzXT/tAnFIYoNKsNapLNEr3heqbzCvIFlU=;
 b=rfW6rt0C88MoxTW88jDtvGRTjKrX30oofmVgJPZaSfwoNyJv3E3Hie6dlwvVeViXDq
 F3ReUfYAdggb3XPnGA+lenUPEeFU9ESaQyS4QS+oiMmOCxUSVffvzGQzz2bVclNVZdAp
 gQuMpInhtsaSL/vX13WVH+KJ4GLjXK2iszj84XgltPGonAwr6j3lhnt0LA8M05oQSu0y
 6fkoXzKtUs8bYtqSzwEhMdWMej7NxOXGfYeuh//L6NalY+/wSyMSX9Z4E7UrSi9XcRYE
 e5a8rFSq5zIQUR51XLKP0rXDTY+5qgWL4U00q/S9/aBQbxKLghE2dov9t7KtKEDzZQ4A
 oq1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTFeu+jCAZC0ctTVnsIiHUyJLmWNmTSfFHA8jO3zHu3pHj1jYugZClA59mSYa5OGsdLlMgGY+ttCc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ndMF7woA3lHYzNLS3laoLlSpNg5Q9t2oHXi+V6p+i4BjgyD82U
 rOnnlTToS6yjAN2aM2kltleyTy+1rs+uYE/1CeZTu6UkLG1TXfUjEEiecYRLSxeh2C/PdoSGqj5
 DjDDPdvLAhDSYyoD2503Of+ugJBX2NUP1aHGdGG3YBYY7rR9rqD0TwyoQFNiaRGpjwoefAKo=
X-Gm-Gg: AYBFou033x+lxX7TOCsLauBrwUvYkKHmTejfmvV9k77sgW26cAQeDPSWXxs5ahrGdUD
 CwVqqohC6xKu4IKMTeBBbj60LiJLEdvoLIx0C2ElyKFdkiBd4pBG2lolEvXM5i5MZqux2sQDOlz
 Ouh5IdG/zrzrfjkK+ReFd+fIl+wb3uI8Jq2RfaEIj0cup6s5JRM0of2iZuvXoNnuRf62sDBcQOm
 l0CjdzSInKcfqApjl63Exv5tZDwAT1QoGcbDeeY8TVKCcAf1SBANI2YF9a8Ui+UGsVCs2PoE2Jp
 EE5kvmr7dPo57QSxDhf+lu3O/d5gq3edDIdyrn8n3q4jGWXxemcOgNQdupmQdpqhLy+qBlk5HK8
 97jlJDDu/55iSBYUNTokj+/tUgvse5jzGvyQvijcFpJFZRYcz1K5NI+2gxID3302m
X-Received: by 2002:a05:6a00:2e99:b0:88d:8074:1a7f with SMTP id
 d2e1a72fcca58-890ddb0c9f8mr759192b3a.12.1791280238641; 
 Tue, 06 Oct 2026 02:50:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e99:b0:88d:8074:1a7f with SMTP id
 d2e1a72fcca58-890ddb0c9f8mr759158b3a.12.1791280238135; 
 Tue, 06 Oct 2026 02:50:38 -0700 (PDT)
Received: from hu-ggarmidi-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-890acde961asm535523b3a.61.2026.10.06.02.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:50:37 -0700 (PDT)
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 02:50:29 -0700
Subject: [PATCH 3/5] platform/surface: aggregator_registry: Add Surface
 Laptop 8th Edition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mahua-surface-laptop-v1-3-406fc042162a@oss.qualcomm.com>
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
In-Reply-To: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791280230; l=1170;
 i=gopikrishna.garmidi@oss.qualcomm.com; s=20260102;
 h=from:subject:message-id; bh=cKCbUJL3peZodopZrkU4az4Vc5EiL7DexQZLckubZeg=;
 b=6tDSpCSmekiNK5dcRRYH8U2GJbxjtEyfcL4E8yOW/PBvh8w5QxuuX3bhjmPX6A5+uyIJxIoJB
 fF9A24FLXLkCCnoEaFFxWdSjV0YJceYOj7OCM58f6hUXaZosor/ib8s
X-Developer-Key: i=gopikrishna.garmidi@oss.qualcomm.com; a=ed25519;
 pk=TkSjNEhrfsj90i3wkABTZtAjLNr2cfYsujaTvyOIDsE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX8a0cIbL7sxHl
 jIeUmyPxRSzzkWS4sA213Kz9gACYKyADSXErAaSq9j59fB859KN5qeXfDbfYmLjQsCrbVQCHxhY
 d/bvJQEujusfapuBUw3FPoC5TnHwg4jQnXn+By056HvSlKIVHOm0nOIx6vGPk/ssAKffmhci4FC
 CFg9UD5ONRFuu2tMGlFae2ndfRLVVB7Urhasee3eZuirzDGZSIqe9UJ5UVZufexA66VY7gogjnZ
 5ng4p90jsr7kHA9wZqFFvJedymLXtCsV0RpH5XCro4Uhx/VZpcFRIME2B6YeOlSL1d1glqhFqxg
 JySDTLOrvdTXZTnW5+ivMPDOvKvVA7l6/yJHnwgZHAiC080VR7END2iSxSspGdexSHIPeFka/Zp
 O/fLVMz7kyYLzxQneVl13Cuuxt8I7YcN9h5yZE/LcG5NuGmuvjgXRmwAgHFSiaoqkAG8p9AjVh/
 4rxSIJI6vlHs56Q+TOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX4xV2ixWgqDlF
 KtIvlfRM391R3CNdo62/Sis83SgQokOS3jxT1utsiBUYNLmpHdWU9QGS/J1uLe53+K1oFqUnnJd
 SQYX/5wQg9mCde26vJ/uAFadmig0o0k=
X-Authority-Analysis: v=2.4 cv=F97C5ahN c=1 sm=1 tr=0 ts=6ac4c46f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KHsj_NB48akNOyL9wRcA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: sC6lJ7KunN7q7JoG1UkZAqCp8bchdQhb
X-Proofpoint-GUID: sC6lJ7KunN7q7JoG1UkZAqCp8bchdQhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060039
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

The Mahua-based Surface Laptop 13.8" 8th Edition exposes the same SAM
client devices as the Surface Laptop 7: keyboard, fan and platform
profile. Battery and AC status come from pmic-glink here as well, so
the Surface Laptop 7 node group can be reused as is.

Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 061d4a567a06..cf3ae252b1c4 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -517,6 +517,8 @@ static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
 	/* Surface Laptop 7 */
 	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
 	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
+	/* Surface Laptop 8th Edition (13.8") */
+	{ .compatible = "microsoft,surface-laptop-8-13in", (void *)ssam_node_group_sl7 },
 	{ },
 };
 

-- 
2.34.1

