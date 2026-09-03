Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930DAC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6DAE10F508;
	Thu,  3 Sep 2026 10:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ei9Qz8a8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="azy9F9xQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F6910F50D
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:47:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHKAL055426
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 10:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=bQtHBeLkyoxvrSXVHQiYbnJuaYly5Ui1KhY
 xJIjeP/M=; b=Ei9Qz8a8hR0/5wjpLGkvlAv2zCCzYmtiYE819EX381QpgaCF/YV
 mJGe7K+GHNOmzeC9efDyoUBdv4w2/u9Y+YIgz4V2XRHRgj64MXk1ixZgJrukHfED
 6UEdKZ7WDwUWxwRvMhjU3NaDrKnA9cedsQ5DPWnemEKAWjgbI1rZO9fLukdDKHdE
 SCjiQ86c4v3QOPPucyYg0hfaiS6j9zMjBSbE1YmLJV58gbJtSwpqmLMbLR00aAxp
 TQCSKVmvVufGXui9sw5f2LCXh4l5ui+7p2dtpv0WQmeIs1ZZ0/OWlJAxMoYT1otA
 iBPCSLIHNYa+mq5hSyXKeILp61dG1FOmWlw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdvhd2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 10:47:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so410725685a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432458; x=1789037258;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bQtHBeLkyoxvrSXVHQiYbnJuaYly5Ui1KhYxJIjeP/M=;
 b=azy9F9xQvxFT1hqpBrS5F+mvZpI9jp23CrFPbThQVVkC5t3wetZcno4a1PGkqTT9Kf
 T3ImnimfgwQg3oKY4Ft/VpTfSbX66z1IMGNHV1yjMjYArycSBUVMQ0xIT/mqMFiyHvui
 jPjeIYIgNV+/T0C4tu4/4UL/kFyW9pL5NzP6Uc2iDrhDYYSlmclYsb6YEzrY73wI/75L
 8o52arLkNKagc+3+4vLP49eNmUYbNAwADraSnVvhPJVqFJZzthIdhL2ZcRjnZECGdJwv
 3Uq2W0KJwRnmrsRwe34F3sdaH18lEPqgVhjOPp0nznWsxcscXVvT/mCEf1YF92AZVTBp
 xxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432458; x=1789037258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQtHBeLkyoxvrSXVHQiYbnJuaYly5Ui1KhYxJIjeP/M=;
 b=nhBGkTId9sh5mXvML/nZ5b2QTVnJPLHkucMhJGDKUDEIVoYHwQpYgAKC1T+KUDowRC
 19zTSaOs7yyPZAh+/plLuG7khWOlOU/MTgeZIecYx/JLnyf1M6MYQ/BvRYXSObZu5zAa
 jl3m4Z2qfSuWkXuOiDDUCwsUFAYsquNkAoSYUMzipgn20o+3tI+7tB/c2YkGFCsHOBnq
 xa7dn50u7a1kccMuuQl2NzRGY6TYuhgqRq2n8P7ZVte9jqmT6TTbKN9PkKgZCw1OshNA
 jPgl/sC/C2nF+kw/sOX1VrT4JviBBRNCB0MZdleucqQ4KOeti6MCGqClD6hMC77JAB/K
 9Now==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkg7dtGrMvPM2F/v2QxkrKslFFWsExlFFlRDuea8yHYdxFelDKjUWlNMSRJ5zRYStVFeEdQhUmNQ4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++miktL8wqTMdlyEvLsPYcdQ6DdqzClCk4c1YrwUdCZi7dB5Qjdw
 1wZ2iGw7bkUY36rp70MVt/sTStgJr0lfB47xJl17iEizA/0/bKFAwIbHsI01t/zbOg9cKqCTHyw
 Y3AtvvOF6JkmcTN95sJ9YI43L3VKwUw0ITc9l11FXAwDGVxwsDXXm/vJHKEz/VWH5b1HbOFg=
X-Gm-Gg: AYBFou13ZcfAWXN/f3UZbkdSUmJquUiIywHHNUDrOZBN/oI0yTdyOURECI4T4R9L5z1
 Q3v/WeZFLH8e2dM+mGHnL2psZHv1xnIKlFZNXiLReByvRyrYb3ipauZtMXFPfZD4lN7dzFVK10H
 3X0XyjrbdapAFMXWvObMKfZRFmTmYiIkAltXFiUfCGzjyEysCTathzsMMx3nflMMM/T0YxwfQVg
 VIQyYLz8bsrARfLIwstIdVOkzmiZ8vdvtxEU3DDaBUhLTSa+t2rsN/fBm3B7+uYGOhQ+I4TzSQ8
 p0XnDOE1fRKNMbrfQXg/ChdyI41CYtYuOpCXt688DzaJnKfG8dZNsa4eF0WpOtYl0ZCoEgrf79c
 mhQ60jEPRaTIB1I8=
X-Received: by 2002:a05:620a:8084:b0:939:191c:cac7 with SMTP id
 af79cd13be357-93972cbb0c3mr305156485a.13.1788432458076; 
 Thu, 03 Sep 2026 03:47:38 -0700 (PDT)
X-Received: by 2002:a05:620a:8084:b0:939:191c:cac7 with SMTP id
 af79cd13be357-93972cbb0c3mr305151685a.13.1788432457566; 
 Thu, 03 Sep 2026 03:47:37 -0700 (PDT)
Received: from quoll ([178.197.219.214]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm243012815e9.0.2026.09.03.03.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 03:47:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kavan Smith <kavansmith82@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/msm/dsi: Fix setting completely bogus rate for byte clock
Date: Thu,  3 Sep 2026 12:47:33 +0200
Message-ID: <20260903104732.145353-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=V8nM5ZVDBd1LAKUMw2qo2H8ikwSqlwSyX28b+z3cMbo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqmVBEB9CRsNn5ZoN2a/U571RFRfYoRRPhkrytn
 MYkNHfSz5yJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaplQRAAKCRDBN2bmhouD
 18nLD/95pY1jOWlax5aOMbTncqcjSt3c+6iAQMgw7HZmWnb3s4P4f5fVm5RqCEYnkfO7OHc0gkd
 vc1apdMhVa+rwHNleX88QfYjafyEJldnX9Z31SkAQsA4OLVKfcpJg6gqoplEp7PE4xpJrsVFR90
 f3f1Gx5YRxqLRfJ7+pYeat+bFNKmB0PH2jJ+OmAyE8nBZn6IOT15rLYy3To5DrjRm6VrfguYz+K
 CoGC/6Tf4zMPl6dc9/98ZdQoHfEcpBKtn9KxtVIuDGuQxyjM8w9jNcqhw/gISQnMQMBdela10WO
 b/JRqA/fPltdR7Od7B5FOa/2THAmK2LlCYc6C/3nzBh4tNBorqSBk2Y0XakyAUn1YIN3IxL/j6D
 SnqRW+HUefk+BD4FtgWO+Eu0b6fBXg7lOyYyXp1efsBYddbfsuaRInbcoLlHKsuIMiOMKTQjnf+
 Yuprc4TlQhobfOc/IIoE0XNce78Wjl3YK2CkbWW9yvKpGM2V8+Pbsn1pBZ0aiygop9ySukhyiyf
 8nYjJcA8eoJ+XF+Puhz+ptQAZLgcET4R8YhT93IZ6cY2oS988QigTenlD22VX8wCulx/Z550I3K
 qvVvvJwCbOsTAzYo9rp0KEIgOFTLWP4nRSytTX9e83Ldq5S7Da02VyeYWONCzQyTXmnGn3kORCp
 v1UO/w3/HgkEfhA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a99504a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=sHYYe3itZNe9dr0yhQMA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 28bqiCiNm-BBHimAM9Wyx2EHRJiVHr-c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MyBTYWx0ZWRfXxQDyMJBD0KTl
 g2TRrvz4uKnQlnIP5462TJa6EtrLvRPUDR13qlOqnb9lujM5t8PakbadqxSE59KtNxr6zr7kIq9
 X88OrZvEFKlGHLMZV0AC82XTHL00qY0zfc3u90sB2VQ2FQSXrjS4L8HabQOq/GU/TQ4CkGX6gg0
 z1/DmjkX24cihR/XtY/vU34vtesoJBJG/g40FGDTYgQLVA/42hoNRU2RAvXYPHzlmplDku8YAZN
 T4PD3ygiLwNxqi8C1W+1dORwAxKqBaxFmjORvLwUNkl/EabeUpIQuXBIvg2re53vnZ/ns5OsDx/
 JP64PEys5RPi+MTcFDG5ojLJJcTCpiPRjNaM8VfTDITMEKSp+9CbVHhgN/E88U8zfiEBVunA0u9
 hE0zSLaLf0LWNASNlV03gnI+V8V/uoMouSYJpuQNGJM3NiceXn0MSOHoMBTq8By6LcLOsXL+Fss
 jqFiI4/gtLuHPhN3acA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MyBTYWx0ZWRfX43G0j3dPZVO6
 jo5lzhmkyIqFb3gDV2QiVp4KTtwClO2k0U7Av7eDu3A/eFhrA4D1rnYb0W8zYRItT5Ud+ZlGR8C
 BKdY2QXKpB5OBcevv7lN5lBSQ6/Qljs=
X-Proofpoint-ORIG-GUID: 28bqiCiNm-BBHimAM9Wyx2EHRJiVHr-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030093
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

Revert commit 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to
the PLL-achievable value") because it is absolutely untested on newer
hardware and obviously wrong: it rounds the byte clock when the byte
clock is not parented properly, so the rounded rate (used later to
actually set byte clock rate) is 19.2 MHz.

This broke DSI display on Eliza and probably SM8750, Kaanapali and many
other new devices:

[    3.164727] dsi_link_clk_set_rate_6g: Failed to set rate pixel clk, -22
[    3.164729] msm_dsi_host_power_on: failed to enable link clocks. ret=-22
[    3.164733] dsi_mgr_bridge_power_on: power on host 0 failed, -22
[    3.164760] msm_dsi ae94000.dsi: Power on failed: -22

Fixes: 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 7e4e3718b536..78e6436a92b2 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -669,24 +669,12 @@ static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
 int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 {
-	long rounded_byte_clk_rate;
-
 	if (!msm_host->mode) {
 		pr_err("%s: mode not set\n", __func__);
 		return -EINVAL;
 	}
 
 	dsi_calc_pclk(msm_host, is_bonded_dsi);
-
-	rounded_byte_clk_rate = clk_round_rate(msm_host->byte_clk,
-					       msm_host->byte_clk_rate);
-	if (rounded_byte_clk_rate < 0) {
-		pr_err("%s: failed to round byte clock rate, %ld\n",
-		       __func__, rounded_byte_clk_rate);
-		return rounded_byte_clk_rate;
-	}
-
-	msm_host->byte_clk_rate = rounded_byte_clk_rate;
 	msm_host->esc_clk_rate = clk_get_rate(msm_host->esc_clk);
 	return 0;
 }
-- 
2.53.0

