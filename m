Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D008BC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23BAB10F3D2;
	Fri, 28 Aug 2026 14:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lEykGVwz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KS3gOmjB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A47F10F3C8
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:36 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDkfqJ3205338
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KTDS+bbOanujBaA6LavrEivitiq85Hyu7Sk6HDc/4Hs=; b=lEykGVwzCrMDFdeb
 9e+QDLAcIZ2XB7THfDrgjzLic1KuB4Lz6y2gR+ZXQ4RPwS0x6qbaNYL5rZTIfYMz
 j10wOar/678L1YAwliMD2yDQmxixLCvu/4SsB8tifv3MszctofHUVMQcYb1twJNc
 Eun6mwsep4wEJvzvFZH9r7DruoazC2p4161cRML5mSHW1o4uzF8vsRVmBfUppO6z
 1zToiG2xEpn3SZtegZBG3mvoGEN/uXCizrqgQcQzDhV211VHui2YBioaRC/oHGSf
 01TsOUHj0lWEOJd6G0eQhz1OWzqNrqbZDCDOqxHdsFC8ReESkkGjsKYs0b6L4kbS
 gRibDw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb7eh10yc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:36 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97bf8de7d8cso958858241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787925935; x=1788530735;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KTDS+bbOanujBaA6LavrEivitiq85Hyu7Sk6HDc/4Hs=;
 b=KS3gOmjBlfhw0mKA10fuUU9hv+JJ3nbb0E2UyY/X3F8jD290INwgm1/64P2M5tFuPV
 fTxFOZO7xYfRxHEN8NxQjqSxrkrZ8YXQJsFYp00xp8qJAe9kjCG+gfGTc0NAAaLI7h+0
 C3EQE8QGJmM4NSbnTnzOM/16gUa1iZRyJiyoiVNE0Tuz8sgVA3nbHFoyN0C03ezTAjG1
 LJ6ZH18VhtVmbrL0wDPDXZrcc5zBchYhmmSOaH1T+QbyXTS6grAYESlkhoerkfE1HLQo
 L01nYwGAF1inQAGNIpedm1kRI3BU+8VTU67D0O6M84WEiCMZmXZde+FKzKrJXpitxc7G
 j36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925935; x=1788530735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KTDS+bbOanujBaA6LavrEivitiq85Hyu7Sk6HDc/4Hs=;
 b=aBnqcuGrIdS5KQK/XxLJltBgmdLjYADINV13cusbPorgFwVWo/dV2EiBYy4XUFTIqA
 6WoZ0KUexXF3qzOUAlmQ9WVzKURdLoIlmvzTpNNTtwVaZksjaI9oEtbwFjgnNGSSqNxd
 fKQ6DhVXGv70t2W3Ez8sUNYgsC/+v7J9dlOwZJtnK1tPWztB7CnsUgLvkYs6Whm5985Q
 CLaYrEt7Hi4sfUXYvTpz73CLPqyIAJo41wdS/F3dg0kHY1tgaTLhkPrwkmowNuFRtIHU
 wJae/Sia6pMyaLwfGvcbMqucHLJjaLMe77mjjfB0Ii5hGMo2YxmDQlhhns7I6zHbL8+r
 7lBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrEO5IhCz1ieMhehCrHgOdntT45FRtcM62/4OwvTBMzQoR+I7OtnRtqh4/bSC4qkJapf3EYwLcN34=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nbU5ZglGPwopajCypeksJfs6xni1ekGP1q9ZPYprRdFXonC94k
 LQEP7B+xEYl5+2O+p6mFju+UzQ0sEbpZAbFXwC3dcIxh35CnXv4YL1PUsj631LkdBDBePwOR7hx
 myPm2MbfeckKxwU9EhzzcR1LSFnLs3FtVv8LDQMFaoZqLWoy16IOFRwk6SEUDSx1kS0uT6OM=
X-Gm-Gg: AR+sD13QH02k8DiDGEQzLDc3URK2EpLAGf/Oa37BFznuf0R+OJivb2JqKiBkrv0yuhi
 OC0Vt3lKlkPcrTqLB5KoeepgNb7vQJl921VTNZd5NYg5STz9lq1a3H1iabX726+YnLLhs6kd/aH
 IoTcV77kKw6sZ7SBsK9IkSCUyjVEj9+Vw+E75kj0CIJQ2LC1XRw6sZGqgu8Gf7oS6vw3faFrvH2
 ySo6Rj07HXx+uGbwYnqVx2Wecqj3IMqa9mZzW0s0rvOQF8h2ARdp2MsIxrm357JrpZlFAkA2Uyu
 aexHfQsYYJKg27m/pLY53WRtv8mfITxma6eDbNFnAuHFpH3NjrZrmh5MAaJ9zQHvcFSNb+NBRZT
 /h6qqKpumIqXWdlGiCik72d8=
X-Received: by 2002:a05:6102:2acf:b0:778:f972:32eb with SMTP id
 ada2fe7eead31-7859996dba0mr2598003137.12.1787925935060; 
 Fri, 28 Aug 2026 07:05:35 -0700 (PDT)
X-Received: by 2002:a05:6102:2acf:b0:778:f972:32eb with SMTP id
 ada2fe7eead31-7859996dba0mr2597945137.12.1787925934482; 
 Fri, 28 Aug 2026 07:05:34 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3908633f8f.20.2026.08.28.07.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:05:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:05:01 +0200
Subject: [PATCH RFC/DO NOT MERGE 03/12] drm/msm/dsi: Fix indentation of if
 block in dsi_mgr_bridge_mode_valid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-drm-msm-hdmi-eliza-v1-3-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-phy@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=798;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=tW0/V98WOWAWLqVlgzVwKvZe5FLR97Vr/8EkD1Pe00U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkZWaCzqQTDLhYUd+TYlb9MS+fCMLIHN5sEpaO
 KPln5AS7zCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapGVmgAKCRDBN2bmhouD
 16g9D/96CCnowO5YVeDTuX8794l+rCeRdeqVNKtfJ7zwdrh5WdJ1dnaBPBMQSnm/x/fVpcxwCYu
 arC0rbwF5A7wOmGm7T67qpA8GmNSqNulzSXmCVkSor9+y83n6waSu80HeiJy+iOntdvUy5hLmbO
 mjarJYL+eEfSYcMiZhIWtpuhYjg0diCrLSbHgFm1UQWm73y1MkDp/S5DsGL7C3ktzxnuZQYO2Z8
 R4tRxhdMzWCwB7HwMlV9tT6kM/Db+SG9OIj1ArPRfVso5lfCZ2sZ0ZsN8TVqxb7w4X2E2P/fBo6
 4aRTdoh22A0wJ8AxWOspRf9PxjJUiARGPpbZwUNK+T4VP0elnJpLhFtaNYdN3rbGVHA1YtLujYt
 0oAeXdDz2BNXUcoot5nAnzMSAFYgqWrXS8Hq/CyCx/hqugWNkaeSUC0epfc3iODek6SsXRzVCI7
 4cxwygFxa/SACEtV+HF+3HeeY7StL0m1q226kw/Nyzn+Ff1iYSsoH0+IORPJPH55JXT6wrHPle6
 +vxcw7ZqLXBglLtY4iBj7vKRtmfgnzmehfxap7F5BFLHv5/EO9s2pGT4faG16ueVDYg5Vi1RvZj
 SGKY58PDV4XrKY1s/2y0e8+1Dtb9hyNA+QGRx+e9DmbOKA7c3OZvRX4v8bjJPdQo5TVQvX+dAfF
 pNB23JQaNvDBvLA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: CdirtTzsloXfRup0Y_RA9XHJZ5Ynd45v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX5PpcURuVk4/h
 r105QGjxFYV3T0RaBsWb57n9WIzy9/alzM+gCXVdMYeuK0LIcS3j/tz7v7V/OR1Dsl5Dll0tCh2
 93dRnkVdIckaXvn3iwoA1uJILfEQQwbc9xcFZXcI7SpRhtJYRdV9/1t9T9uj2IwxtxYcU0EGxQq
 aE65UUWLI0+m3B2sIOEb5sB447fDRNdRend8bR6L/eRIt4kH9uv9JokKTVIPDxd/SQ8qGslrmGG
 BXGo08bJ2vygttBUbjQEzuSuItD9QBqrDwkAHMThz03IwU1/BMa20oYwx5TaN0Xas/GT1/fydZC
 8MBWWBUmP9YNX8SgvtuJ/OTbE8HVnoF+isKIYX9VyuUUurUdPsvkfqpB71POdqNl7/lPJ/YQkiG
 MiOe8QEVvp1ZhCKezDTy4tMZdTb2g+Hil1ui2ie0TIK5IMjmrpGva7JZI9KzmSQ0YYDA78Q+Ljv
 Y0ei90anmoaAOqoXJ1w==
X-Proofpoint-ORIG-GUID: CdirtTzsloXfRup0Y_RA9XHJZ5Ynd45v
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX185ehKzUc0yg
 ePajAd0NdNleRBvX9o9KKwfFWzofHSChi12rLtZPMh1rRh6M74qDYrrs9Op4VDK5OklciqPADND
 bJ9ITsXo9B0+JyWmRMeZ6XQG4C0U0TA=
X-Authority-Analysis: v=2.4 cv=RoP16imK c=1 sm=1 tr=0 ts=6a9195b0 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=mamL7KDpJlut8y4y1IgA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280122
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

Correct confusing indentation within else {} block in
dsi_mgr_bridge_mode_valid().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 959daa88b1d0..531d4ff78f56 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -429,7 +429,7 @@ static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
 		if (dev_pm_opp_get_opp_count(&pdev->dev) != 0)
 			return MODE_CLOCK_RANGE;
 	} else {
-			return MODE_ERROR;
+		return MODE_ERROR;
 	}
 
 	return msm_dsi_host_check_dsc(host, mode);

-- 
2.53.0

