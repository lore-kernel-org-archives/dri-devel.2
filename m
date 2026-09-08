Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9F2C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F41410EA69;
	Tue,  8 Sep 2026 07:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nOVR+D3X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VXh/R5HD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC70810EA69
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:11:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LiKf950259
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 07:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E0C2reVv1oSwnphcZX04pJknqbbG7msmctVikhe2z4c=; b=nOVR+D3Xa5S6DRd/
 1KKeE1mxAIPGXaULM90bjkDTDUbgxkoD1yEXL0wk37gs0zdkGEAoJGyIVS0WymQc
 hmK/V/7joRSlL5pOpdf0XjslTgJrvK/CSu+sBFOhYKn20Ubl5opN32dWaqRd+UbG
 t64JIm8tpLVVxc9P3aL5ycaTh+XSlOFprqrIYmpiyxlBYZvOYzgpZ2xHeQe8Wrlp
 /joKRVRy2fN/fcXg19D7A36CRr5fJkH//8yhdb+zGkxCiLMWlwSN8V30CODCBhcl
 FWYzMCs42c7Ratjzm18VRve6iOeDpos+dqdv4mj+Zw/uMRgFLevq+n39R2M/Uxrs
 m6Tbcg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcrp89ax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:11:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ec3146553so1025349885a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788851466; x=1789456266;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E0C2reVv1oSwnphcZX04pJknqbbG7msmctVikhe2z4c=;
 b=VXh/R5HD6V2TXEe3MiosYsIEzHufBzFCoXwvnsipKu0TwmMGUJdKRf6EsRFCAeUnB8
 7HC9F764ssKuE1mEEUqoVwM97vqr6hxJypVTn7Gphb/RP0ItoAT+JXki/wKC+/Ily8BW
 k3fMse+XqYf62z26x9g3WVAkG+EDlyJW6P0XLDO5T4VfUJlUDjQUqSObny+Zw+LgnUPF
 aGnjywXHWRL8Z5hKFFex+Zq8NsHohzNuG1WEP49Unm/4WB8G/zSw1yQrSor5DqshMbvT
 5OI/wEOkdLxEJDga278bC5Gp1q6c+YWFKaIQAeRDj4zz5yQa2IOKOu3v2qsIR4AYdT7q
 MFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851466; x=1789456266;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E0C2reVv1oSwnphcZX04pJknqbbG7msmctVikhe2z4c=;
 b=rfxuioiUi9VcXDampaCTAwkW78IzXKzfukVlMRvr8cxHBUw/qnhr2RCvK7SU+KVgE8
 uRHTvXGvQ/rruT1hYd6tQ//jIj+TUHv/fRV1waSCOqY898FwU+OiYE+PaEd8d2u1QNm/
 6vSBfH5XKmSK86xzZ6rYl7p2Tqd5KGHxc/Q4vrtG+xoYFQ5Xa/Nr9kiQ4sYB1l3LLMup
 H0uw7xIFNJNhGGrwQxV3Jrk9CH05lGetNs5WF7k++n2MePbnEXap4QIYdtPTs9UU5rva
 kExRM7zObMPBk0ylaA9UMQJdmEMDVpNQvGE51WDehVuSFaB9dYWRwLitrplDSuF711wS
 gyzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZ1ghwsxsWigRV9lvGTcew/3p4Ql/N5T000dFjXJobsgO5q1XJQJwG5IVcx0wHkIdgRLgC7qafgQI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k5vGf6R2L4b3f3QGD8Ya2xCTBNk3jncfGnPn32RELc7PBFyhq0
 a0VC+G+IkvuYRDo8zUVZNrZ5Mv8a67CUKy3sngu7rswRMpuxpdV5ns60bnJqtJqJWJ6MnoeY2/c
 DVex0IqHARChTBuJQpNvyMlwo8j2DYBu/Dgcmh+Nd/E1Cd5yD9ZkANm+Ylddy9AZOssg6/Sc=
X-Gm-Gg: AYBFou2+u4k8fwR3Qvg5qCJ8MSvnaL4o7iQG58Y2ctinkI7EiKfdCMVPs001yBAOXit
 iCT7DzDpFM3yDKKtWZ5wojM2ztsvm6KNnFZzvWs5Q2KX8U5toOtqPN5WZzZ8+ARkSfm4kabDe4b
 C73JsBiR0jaWa9dZS1ztTTPK04nGlouzQtdYCheixixew5LIwtUhPWeg7EkdyuykjhT2398+5lx
 BOCtOZ/cVaqenTlSVLeBlX6zMf6mshV+CjikMrbQrKEej8gBy8I00jO4CQmQ7DdAlnOcL16OPze
 Stc3IgnFkk+sLh3obIA9baG2Z30nZVGPIpZ15WHkO6jbtEKUwrlOBxctzj1VSy2igERQReWBeY5
 hliZbeNbKAeTdGlBNSH1xz0Y=
X-Received: by 2002:a05:620a:1a06:b0:932:fcb4:4d0b with SMTP id
 af79cd13be357-939806da006mr2798142785a.24.1788851466273; 
 Tue, 08 Sep 2026 00:11:06 -0700 (PDT)
X-Received: by 2002:a05:620a:1a06:b0:932:fcb4:4d0b with SMTP id
 af79cd13be357-939806da006mr2798137885a.24.1788851465895; 
 Tue, 08 Sep 2026 00:11:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm453173805e9.1.2026.09.08.00.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 00:11:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 09:10:44 +0200
Subject: [PATCH v3 4/7] drm/msm/hdmi_bridge: Drop redundant initialization
 in msm_hdmi_bridge_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-4-dcf8956878ca@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=DVXNSz/QqITCQAR3c9vgiIReGo6sp1REqUL1NIZWtK4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqn7T6ccwdo8OoNNuiJLkAwQshlOHv5IiHfaTkw
 avBRqliwh2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap+0+gAKCRDBN2bmhouD
 1yBND/4q44Xvc48hMxu1pda3s+T5mew5AFxVcvM0Vnhayn/pLc/O3Br0Ly/OcFOuJebwixVWGk4
 tXe06Yq8vc6IB9NNzOZJS1mAhYdpECWPENX4auSJ3R6quDLguKJUNNsduorlxRQRJ4Xj4GnBNRK
 OlkzZqTCEy9TY7HrbZ9jCRawrXhczzP1E86LNgV7hzXmTbydYHkYpZce+CXDgaEhoLsgexnT3Qx
 rNsufGslZHQhaX/mlfuutiCkcYj7mz0BRpVLu+BlFKMp4p8eractYTD4jkaUsUtkt5lUrszwdP8
 Y9bckC/HX5zPbpepFNoyWjPAnR0jDGsGWS7Ey9Q5OqpbpQPLDDH4+lQMlEEKiCdIaXYY3AAJdjJ
 XT7Uu5Y7TnMeUtMJGniF9J3lyCP6ShkwHJbxpchJueFdIG4JRTgwk/c/5bdoR1XdG8Kj7NGR+DG
 odpCkiZLllzBdcAFbMtmjHLLOkDkSRszbSw1c9USEwVOOWPKHiDstrrcwVM4t5QEYYNGQ3Y8EK/
 YoClYAQACSCPEsv2u+pfAYhE8MJJSuFXsN1At847Xk1vH3/BKfg8tznJuX2FZmrRXhW48Vk4pAj
 9XxyQs/YNWh54LNI8aGgUEtT/gEQr3z5XfEd5iPSwX5DuasRf/5SxuUIuECa1uFhhzf9OZIROCb
 kcxfrWQx4C86GIQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=UfRhjqSN c=1 sm=1 tr=0 ts=6a9fb50b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=RZP3y24nY_lDZDhlvS4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: jqLyIht-fkEsYvwz4ALb-5EzY3A47faJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX4jmRz6rr5Hh3
 VxJAgEyr5P80O3ZZ4zbDVOBL0P1yOJJpN+F9SkwDMHS+6MXWGvs/7QTAU3arYuSFHFgjlh18m/D
 thpkh1vXtiv7jkCuJor0qxJefTj3zBfhaQxOqd60iYcTAb/Klqt3ZDQf4qBFZhcxQ9NhquLrtwf
 pqrTjt4/5Giiz8trSiV1AjxkTQ3lK0yVgugGt2wgLX2SxePfTkaVvbGdZW+ku+qvDk38AY90Ic+
 bZvDeBnv/139LRxGxlbX1tkIc9mj+0me0pfXJRnPBF/wNlPX03RikOntCb8LpXtZECHonBN3keH
 rSu+6UI4zTaYCxr+IAAYcfoq0oSWqvm50na5Z6wQ3ECAcCpomwTYSsyNTkMeDoWnKqGa1MCQgE/
 EhA5ksSoTK6qKz7rfJU/SrdQJcCU/jkZO/qNFkEB0IGyhSfcqPOmL8xsBSgaQj7AuwyDKQopt56
 vDDnGt3VOKk6rpLoi8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX+1oVAV2tIK0K
 edIKM9yV3xRfWpUOrOk9cE4DkOvzAUtftoHAChC563BhhGgqLr+rb4QpDNxyFeKkya5OVkH3Tch
 Ojg6OLa6Elm1V27a4jHCVX76HkSUEQg=
X-Proofpoint-GUID: jqLyIht-fkEsYvwz4ALb-5EzY3A47faJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080072
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

Local 'struct drm_bridge *bridge' variable is assigned in ~13th line of
the function, before any first use, thus explicit NULL initialization is
not necessary.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 1860605850c9..49587927e8a5 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -484,7 +484,7 @@ msm_hdmi_hotplug_work(struct work_struct *work)
 /* initialize bridge */
 int msm_hdmi_bridge_init(struct hdmi *hdmi)
 {
-	struct drm_bridge *bridge = NULL;
+	struct drm_bridge *bridge;
 	struct hdmi_bridge *hdmi_bridge;
 	int ret;
 

-- 
2.53.0

