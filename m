Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED24103A9A0
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD1710E6C5;
	Wed, 25 Mar 2026 03:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="leoRcw44";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gLJTc0m6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1816710E6C4
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:06:16 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJDoOG3984690
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=nRVe0VN6NMg6YbJQc1OFKi
 dXXu9EH61dteZPLjntYfg=; b=leoRcw44WNBmHx4IeY3pL//yqkOi5AmWTWMPIj
 /HYn9GxyPUxHAVPilme+UGpghbTLZv8srJkdoBN0qfIhgkw+WXxw4Wb0c7rcPCLD
 XqyldjriacAI4S7WPadi1bYz2/0JYL9pEy2KK4wgOkfDBYVCXVv/0q3WfaXDaQqV
 FbwaEkTyKW+4UmlXyPYAW6StKo9hyQGlBoO4asBpTCHAkNwZ/ckJGAvqChaXB9cp
 sr1r+ha7GFkCVYxSr2h4MIvWESAVsRtd0kKXwV65RIe1yS6MggwuXAdCnPx0ZTOi
 Pl+XWHDu3qzI3H4alI2JZ2maWQytHSGVJvl4D7Z4RpER8AhQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3p8340d7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:06:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50925fed647so121913701cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 20:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774407974; x=1775012774;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nRVe0VN6NMg6YbJQc1OFKidXXu9EH61dteZPLjntYfg=;
 b=gLJTc0m6EKwPSB66Epr9N87sB25M/oqWam0Cd+KZp3E4UM02AtPobEerTOCygXvVuF
 g1f4h3DTIp4ltZFWcMW0hW2aUpACWc639NTJNrM5QFpde3ZGe1vta62UdJmwW7RrfosN
 KGxGMbwNPAYaQ5N/JCkwINI55hWrfKZdciQsVOwdwBrmVxjes5/AvwmdK2tPLKb9JXVc
 6Io1E5lGOilSHp4nULNGNAPEanN+U6PM9Wy08ZWm1jNW3qxyud5ISspdY9ELbJJuVa+0
 AbDyBoGT+pIA4IvPLMVXL81+oq9oyUHjaLIk5vOKNZPRr+4nWuzQUa2q3hzEO87ShcJl
 bo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774407974; x=1775012774;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nRVe0VN6NMg6YbJQc1OFKidXXu9EH61dteZPLjntYfg=;
 b=f0NGOZvPJyoQqpFcC6eiy/4q6Vf2ZCiN2tLVwggCXmHCGE6ezYa0825STrDWTG5W+A
 lArupuhI4wqMEJ4q4ceDbiA6d6fX3LjusDRdztrv30nUJpiLktOHjs17zGJJS1+e9bf0
 pE0lwEs3hCp2Lh6W/lQ0dY3Iah9ApqLGqlfZb9mZC8PC4WNp4mpE5PzwpPLrOK9o+4Ue
 aKe1WT0ppACWFEtHeCBCZ6YMuadHRKQM/kyXB5zCtaKx2crr9GipzavFThj+W+6ufieO
 EtyNVXEt4dAy7FK6RnmVAG5z5MoaiAOcqfa8ryTt39PZZH/shaBvXYN7tpR5nd+nOwXn
 DTfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBbNzhQDTQn+BEn8Zw/AFZZnR9/89vvcV1vq9kgMhDM4pHphq0X0JZNVaM1YMJxrOg+XZhyg8xoH4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+0dFqW92KQycxOW/czSAc0fNUbhSCm2dekpFs1U440/qn3Kgh
 eAi13WjxZ70dnZEgmFpxVhoD/6WF40+Jsx5EG7kfCDoM8HlURQjZslhYdLL5XaSmHyVw2+ZPX2T
 FuAfgvC1k/cvvKaX31FR90j6D3qSrrYffab07q5HE0YzLSEiPdOVF4sr0CHf4BQ22kxNl2CDlx4
 07/+4=
X-Gm-Gg: ATEYQzz3LqUVPe+NcO6/fAAUnyYf9HRpMFPmeT3maWRB1YWIwPP9TfE2xKjVymLwHsf
 0sjzP2XwQdUTQQPELQyQMK8p+8upcr+BSuI0YgxK6GgxmZUw/f4qMTodNb2rZW0Apj0LAvcZOlg
 u5/9Wi2oOSopA5EgRAM8BmXkpdhpzd3dNkf+vIYZN8s1dc60CKgEANstQZTfy9vzaxxsv9UFrAW
 ea4cryde3ywq9294WeZ7vKgjXv8EpmuXkorZwK0iN+FzBNGW97bJsLSWEznC/dXSH95ZDJ7HH+f
 L3s7WFz7SJ0c2gQGTbncAk86rFyhgbc9YS7xrYDG4SqGzT1bPpTXtxRFUaEL5iRM4eBS1M94NP/
 aQrhZm3JsIHkOhgx21KAyXQBNozDsFE4lZC6N+eC8BqmZmWb/xGN/qdIMJU37XP5aqY6HP2nbBU
 8XPt9RIH7R2Dw0KaRzdIhCEXd0389lFY16eR4=
X-Received: by 2002:a05:622a:4a86:b0:50b:3a6d:db4b with SMTP id
 d75a77b69052e-50b80e8a2e1mr28360941cf.55.1774407974076; 
 Tue, 24 Mar 2026 20:06:14 -0700 (PDT)
X-Received: by 2002:a05:622a:4a86:b0:50b:3a6d:db4b with SMTP id
 d75a77b69052e-50b80e8a2e1mr28360681cf.55.1774407973653; 
 Tue, 24 Mar 2026 20:06:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2851a0a90sm3536435e87.26.2026.03.24.20.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 20:06:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 05:06:06 +0200
Subject: [PATCH] drm/msm/mdp5: drop workarounds specific to MDP5 1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-mdp5-further-drop-mdp1-0-v1-1-5ccee47fd1aa@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAB5Rw2kC/02OzQ6CMBCEX4Xs2Y0tgvy8iiGmtAvUpBTbQkgI7
 24RDx7m8E1mZ2cDT06ThzrZwNGivbZjBH5JQA5i7Am1igwpS+/sluZo1JRjN7swkEPl7HQ4HBl
 2lWqp6mRBpCCeT446vX6rH83Jfm5fJMPR90s4es/xZzhj0ApPKK0xOtSJ8eYahSOtAf731Mm5h
 qUY7KQl9taqUfdDeJZVkS0cJSch2kwIVsp64dDs+wdrJYbe6gAAAA==
X-Change-ID: 20260325-mdp5-further-drop-mdp1-0-f9dbe9fc7eed
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Vkjszgod7ecBFFlgxz1Z2BKiK8yC1tYFiEe/JnuFfQ4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpw1EjsfUhiEwAEwmFX3/jxigQC4e5KLTxhtDyA
 JIAHWlbosaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacNRIwAKCRCLPIo+Aiko
 1eS2CACzNJtMpFMjJQ5tW2v2bttHcCI0rFGUV56WJzr204A1TrQMHi4PM5LywjUkX7rSW9ET27p
 Zbnn/85s/LtB82hhRd8pbWpqfkGg71VsjHyEoHiYZ6cbM1eREn9OmMxlP79DzBbbgPW9a0Tfw+j
 2f5x0pVGIbnteGIc154BGoL7LHnm6W59aCVdzcNJL+Id+0XQO02ZTzejAjE/8T3UBaNoVT+AbK6
 kJUQFtb0jYeyK8w/4cYE2vRz/BUOaKn0ernS0hyBv8Jk+8Hq90CjNbYL012zpZ2SKldPgWha49m
 wxLOfrN3WuqlN9kojO4bgjwdRXnBaGBk2GsJpgGdSFJImFR0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyMCBTYWx0ZWRfX6uZ78gceB0T6
 HMc8x1cpO5yziQCe2U0COCKX0OSDqTqy/zwmcwrEyf0iFYpimg4Enh7dQCfDOM0Ry9Wt+fkHioK
 +AbRoiLJ/HjmVzT0TDz9WdGrkErqoF7TXMOT3xLejLrbPJk6cbJbMve/5gk7v27/I20PrXmY7Td
 7aBK5ZDhhd/9pY0hOcTA3v9z/AODoWpGraPSh76OtUHAv70P7rYhLz+J9rrOouIzhmB6pIZBD0g
 uTU0Xn6Yq7MWzj78jweIdwSdaNDiNiB2b3wauKrQWWchPIREnUu/nHlRTzF1HxPxBRFKtJVP/fa
 fkwJVZ85XtpZaVKWvLCQOH7TXuEINcIg6Ni6ip8JYegMd5vvBR5lkxGQYaWaK4e1/TVlLwVEk0z
 GXUwE6gcZylrZvo/AFaaRNMAHRc/fgXACcn20HHldVcWUsLqnjtALDPgjCMceOHnT1tObyfM+1+
 aoY9RyfjQ8tYW9rGqQw==
X-Proofpoint-ORIG-GUID: Rv-CtIecSust7XRcu-LOds_GDawivkyG
X-Authority-Analysis: v=2.4 cv=F6hat6hN c=1 sm=1 tr=0 ts=69c35127 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=jsC9N8fVNmDsa5cqphsA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Rv-CtIecSust7XRcu-LOds_GDawivkyG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250020
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

With support for MSM8974v1 being removed from the driver, there is no
need to keep workarounds specific to that particular MDP5 revision. Drop
them, slightly simplifying the logic.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
index 500b7dc895d0..890d2f31510e 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
@@ -118,8 +118,6 @@ uint32_t mdp5_smp_calculate(struct mdp5_smp *smp,
 		u32 width, bool hdecim)
 {
 	const struct drm_format_info *info = drm_format_info(format->pixel_format);
-	struct mdp5_kms *mdp5_kms = get_kms(smp);
-	int rev = mdp5_cfg_get_hw_rev(mdp5_kms->cfg);
 	int i, hsub, nplanes, nlines;
 	uint32_t blkcfg = 0;
 
@@ -133,7 +131,7 @@ uint32_t mdp5_smp_calculate(struct mdp5_smp *smp,
 	 * U and V components (splits them from Y if necessary) and packs
 	 * them together, writes to SMP using a single client.
 	 */
-	if ((rev > 0) && (format->chroma_sample > CHROMA_FULL)) {
+	if (format->chroma_sample > CHROMA_FULL) {
 		nplanes = 2;
 
 		/* if decimation is enabled, HW decimates less on the
@@ -151,10 +149,6 @@ uint32_t mdp5_smp_calculate(struct mdp5_smp *smp,
 
 		n = DIV_ROUND_UP(fetch_stride * nlines, smp->blk_size);
 
-		/* for hw rev v1.00 */
-		if (rev == 0)
-			n = roundup_pow_of_two(n);
-
 		blkcfg |= (n << (8 * i));
 	}
 

---
base-commit: 6efced27f5df9d7a57e4847fe2898cdd19f72311
change-id: 20260325-mdp5-further-drop-mdp1-0-f9dbe9fc7eed
prerequisite-change-id: 20260302-topic-goodnight_8974v1-c1eaab4aa08c:v1
prerequisite-patch-id: 7b71df892e1f8548f0f2b7345560edb17df5d5a6

Best regards,
--  
With best wishes
Dmitry

