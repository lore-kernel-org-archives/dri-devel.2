Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE08C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9051B10F566;
	Thu,  3 Sep 2026 12:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DOzbJSpH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O6i6CfA4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D06EA10E0ED
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:19:14 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHK1B162985
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 12:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=d1v+GC8Hhix4s/ZeQXqidP
 kZI2JR/xI9DRh0/nfz9oc=; b=DOzbJSpH1/bEeTonQSd4JC9BM4dkM5TW7nNiTE
 lVTSHhmnqKwNBKA5sBCV18eBY/7/OPgLYJ3eyBCULVCsbnu0neVf6+oNIKgn4mm2
 v+Rsi0GYCfbnLrh+rXxoShHaFo185qWtjabiJpij0SElcWJiv0SkmjcqZ6sZrg8J
 iDJUwJImDwAJUU5pUOqoyQYZ22/el1lkvPUAD4IrhFnqKoNGDhJNbw63V/CgOOGT
 nPXvIR/h5a1tQsjOkWynuORRx42upgSNJv2+XoaBzEXkaERDK0FQNpKVLXMgJGm+
 XGcvbYoHN9fJts6kcLskW7dKTGCg8L9KVmTlhTdpEcRakQKw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx0ff6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 12:19:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93915f50a5cso200379385a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788437953; x=1789042753;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d1v+GC8Hhix4s/ZeQXqidPkZI2JR/xI9DRh0/nfz9oc=;
 b=O6i6CfA4gTMesJlTvSsb3By5Gd6A5O/mVnbX6ZUVP/GGoWXLrsnlk33vOdWsHFxgnu
 ceTDsNY7s3o1+EMg3wXYs/S2FFHUNOQC+yLjoENdtiO1gFrvz9ay78r7u3BzPTyRDHv+
 zyndwrGUjQzufqIYkL+8irbjCGVWIgf/DVQGf1uPQEWj1c38sQOGpQXr2TzsAtSLUp/5
 EQ36435r5TldPgehesf9SQTAt38eaB2c5zYCnViBwfp0a+LYn59pSiHQvWNGXILoGnj7
 z9CjY70PSBM+u669A+wv8qEMN1dGpFb7RQp0lrKGkip4LmUXbFRQ6z0VhQ+cySEzRM/6
 EPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788437953; x=1789042753;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=d1v+GC8Hhix4s/ZeQXqidPkZI2JR/xI9DRh0/nfz9oc=;
 b=fPX38BqnsIL/TrzWrMdywxylFT2V29nNJ6+M1ExkivmxEKJKucFeJm+DCeg3WtGA1s
 68B45j4bf2Z6qoL6zziaBV60AqW5PjSeOL9qUW2O9uglNXKPAwephLusrHI+l6FKD59R
 zgvR/iNxp2Y1Xhg/boSfkCjHEf/b2Ig8Rhf8q4V95pCkaeBF09kuTneNjSZasd7QC7U+
 3uVw+CsSkzV3ivozQWESLbZVkO6zi+x5jNOfPYCCiXogetZ5eRUJ/hztyUFxuToPZSWQ
 q0IzP0o9mSd4FmqTvRxTVH3ztQJGNWq0h82PoDHfsQkuNpNmAdn3CCr27Y3LYpbvPq8Q
 1xUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByV7p/8RSfBOpyjHtOLg4182pCMsU17hT6eB52BqsgJqwdlApjlacVebsrDeUZfAsmRnc2jQ2oMWuY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n7SOCgjwSHvaLc+1YalcazABgTkO5GRoiRv/CStniml4CwPAQA
 JodCKuWJRT4Da72YqL+4Ol7YkmMIJ2GeBWHRLIQ2PWBR/JXDgOWqz7K5nkT6MmEaOV+l5n2lS6o
 M+B6zlyRtn4CFn1Y3pAhDRAG9kz9w4QN5HwyQZixRDouTxqDnNHhy4q895yueCSo/YAUi6rw=
X-Gm-Gg: AYBFou0TDuTE30hcgHnP92otwLuXXJx+lBtOAnkJbfltsnD2Dua6q7iJMhdhbPLrNm2
 cHFlgkroxtH7RIpbM22l+KLHoCFOSELApbz7ArJtFxZjwMdGV/SQTv2im0mcOmz0VdjsQhhDDt0
 JTkATHHLaExjDbM8V8XSGGxvQ3dSHyFjeE97p58Cg+1OGytTO1vtTFaAcJCtrr4i6SInf7B650L
 4k1dTcuKvkYaal7U4V/Yney3vUCkoC3FPPpCSXC2/X3jT5wFk4RlUBiYK6CnaUvqH9KFr+EoAar
 GjJaO8zz/hXaMp/6IrJwqF9qOuMTG8i/eBgfy9mM6SdFS4jqBIHG+7aITUER14EpmbhXEEra5LK
 LDLC1wCOULaRD5wbvnUhIZhK9THv1bKZe373elStwPw8Gm0kzICBImRp6kcgwWJYza/fdhtgemN
 NZXiCSgH+/xL2V
X-Received: by 2002:a05:620a:3704:b0:939:79c:1104 with SMTP id
 af79cd13be357-9396df22e93mr542211985a.10.1788437952976; 
 Thu, 03 Sep 2026 05:19:12 -0700 (PDT)
X-Received: by 2002:a05:620a:3704:b0:939:79c:1104 with SMTP id
 af79cd13be357-9396df22e93mr542207585a.10.1788437952445; 
 Thu, 03 Sep 2026 05:19:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b606b0ecdbsm1254298e87.9.2026.09.03.05.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 05:19:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 15:19:10 +0300
Subject: [PATCH] drm/msm/dsi: round the byte clock rate after reparenting
 to the PHY PLL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-fix-eliza-dsi-v1-1-3474a6c9f2e0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAL1lmWoC/yXMQQqEMAyF4atI1gZqBFGvMszCtlEj4gyNiije3
 arLD977D1AOwgp1ckDgVVR+U0SWJuD6ZuoYxUcDGSpMZXJsZUMeZW/Qq2BpHbXsyVFlIX7+geP
 g6X2+r3WxA7v5jsB5XjXjCcRxAAAA
X-Change-ID: 20260903-fix-eliza-dsi-8bc2fed2c29b
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kavan Smith <kavansmith82@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4272;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=uz7L8jZC+FRa4iH6HND9+Fq9kcOFbjPiksyeJbgXaOI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqmWW+wJLWxHequ4iwL3l+6YA4eVuefTeu/unAo
 EV3dXdw19uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCapllvgAKCRCLPIo+Aiko
 1bXzB/4k3Sk7t3WsIolAsFnZopkL7GkMimyro3AHD/0eM3i6vM5oCIE1pOgThrWM2sNbJXk7ERb
 67KOCDyUQJrcDtgItRcKLFxnxxbXnVO+mMQxfrZQCJ45gDRnbpUxNbCEDWqxRscKleU7Sp7hbvb
 EnvalAlN3LAWXFVhJd8bESdvaFJjmzXozx8rwFZnBzUzc1k/QrNfJ1/GOb14Iuv8BOuEg3XnMVF
 G4lzqU96wEU9KO9sxqupC02/kbWE8jfbjmPQo/0CupEJYwEq6In25Y/zT6YtSsuy3xbrRTulueH
 +LfGn5/m9Sslh3U3PmERfB8EFT+1g+gk+biY+gNuoAt56x0A
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: IYvdCEzSNDZ0lRCsT_vNi5PH3V1PyY0L
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a9965c1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=hm1qJ70bMNtfgpIXLUgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: IYvdCEzSNDZ0lRCsT_vNi5PH3V1PyY0L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwNiBTYWx0ZWRfX5YJtje4XT29n
 ojtmW0KarypxZ0OsNZRW4eFjsbNDSqGI13gV+CzLLnbawy5W1p53Ds/+jIpllK3QaJb3DGbfH4f
 0+54GvZes01TxFwtzl4JOvRW7XF0+hE6vxysu57ZFGrm7V4a4PRj7mrREXOm/YHt47hpOP6VzWM
 b7W01VQubWfRXuZ3bycmZi+Vg0mP66bxvqW7beZKooO7GJ3H3sVcui33JGfxsj4qAPRmYoEdFl+
 Nr3JKSICHgcRla+86vhhpWmIaeWZ/h/4x3JLsQzxuauXsdaDNzvHhVA0ILrliI+WkLDBNjKrpqw
 R6ad5z1ooZd+oJ/oa8nos3zqGRT2/SSg8CohVdZyToUFNt7n6/poT777O9flEWpNWV1Za0/CypH
 r3ZVOMghKY1pg/QYX/P65HvySwnAxje/TsBsxHLetpTGEWQWUy1lsIZWHn8EPRWXipSzKW4+mxb
 FnSI7J8placFbG/Gn2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwNiBTYWx0ZWRfX+mYIf4mpJH17
 d1Uj4bpKpOPbIy3/ZtpERUa7dUXd/At7Gp+3/Amu1tXu7xtgzDVZK8VX4X+RknL4bnUt9tmB5B6
 AuWXZXmZOPTIhTJqKcqc0wdEF1F+gAc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030106
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

DSI 6G v2.9 hosts (SM8650, SM8750, Kaanapali, etc.) reparent the byte and
pixel RCGs to the DSI PHY PLL at runtime from
dsi_link_clk_set_rate_6g_v2_9(), after the PHY has been enabled. However
dsi_calc_clk_rate_6g() runs earlier, in order to compute the bit clock
request for the PHY. At that point the byte RCG still has its reset
parent (XO), so clk_round_rate() returns a bogus rate, which then ends up
in the PHY bit clock request and the PLL gets programmed to a wrong
frequency, breaking the panel.

Move the rounding to dsi_link_clk_set_rate_6g(), which is called after
the RCGs have been reparented to the PLL. Storing the rounded rate at
this point still makes later link_clk_set_rate() calls no-ops in the
CCF. Derive the byte interface clock rate from the rounded byte clock
rate, otherwise it would keep requesting the idealized rate and
retrigger the PLL on every transfer.

Reported-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Fixes: 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 7e4e3718b536..b292dfd266d1 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -129,7 +129,7 @@ struct msm_dsi_host {
 	struct clk *dsi_pll_pixel_clk;
 
 	unsigned long byte_clk_rate;
-	unsigned long byte_intf_clk_rate;
+	bool byte_intf_clk_div_2;
 	unsigned long pixel_clk_rate;
 	unsigned long esc_clk_rate;
 
@@ -382,8 +382,20 @@ int msm_dsi_runtime_resume(struct device *dev)
 
 int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
 {
+	unsigned long byte_intf_clk_rate;
+	long rounded_byte_clk_rate;
 	int ret;
 
+	rounded_byte_clk_rate = clk_round_rate(msm_host->byte_clk,
+					       msm_host->byte_clk_rate);
+	if (rounded_byte_clk_rate < 0) {
+		pr_err("%s: failed to round byte clock rate, %ld\n",
+		       __func__, rounded_byte_clk_rate);
+		return rounded_byte_clk_rate;
+	}
+
+	msm_host->byte_clk_rate = rounded_byte_clk_rate;
+
 	DBG("Set clk rates: pclk=%lu, byteclk=%lu",
 	    msm_host->pixel_clk_rate, msm_host->byte_clk_rate);
 
@@ -401,7 +413,11 @@ int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
 	}
 
 	if (msm_host->byte_intf_clk) {
-		ret = clk_set_rate(msm_host->byte_intf_clk, msm_host->byte_intf_clk_rate);
+		byte_intf_clk_rate = msm_host->byte_clk_rate;
+		if (msm_host->byte_intf_clk_div_2)
+			byte_intf_clk_rate /= 2;
+
+		ret = clk_set_rate(msm_host->byte_intf_clk, byte_intf_clk_rate);
 		if (ret) {
 			pr_err("%s: Failed to set rate byte intf clk, %d\n",
 			       __func__, ret);
@@ -669,24 +685,12 @@ static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
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
@@ -2495,9 +2499,7 @@ int msm_dsi_host_power_on(struct mipi_dsi_host *host,
 		goto unlock_ret;
 	}
 
-	msm_host->byte_intf_clk_rate = msm_host->byte_clk_rate;
-	if (phy_shared_timings->byte_intf_clk_div_2)
-		msm_host->byte_intf_clk_rate /= 2;
+	msm_host->byte_intf_clk_div_2 = phy_shared_timings->byte_intf_clk_div_2;
 
 	msm_dsi_sfpb_config(msm_host, true);
 

---
base-commit: a9117574de38e27355ded76850df9200ce7870e6
change-id: 20260903-fix-eliza-dsi-8bc2fed2c29b

Best regards,
--  
With best wishes
Dmitry

