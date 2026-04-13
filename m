Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E0BF34C55
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2230810E48D;
	Mon, 13 Apr 2026 14:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWFSDb+5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZXMZZY1e";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9471F10E48D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:38 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DDmUGo1497833
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EJIKpujoigVEaBknrd4/meAnaGYzGS9Xs4bjoKjmIO8=; b=PWFSDb+59IiXJL3Y
 Dd3+l2neFoQ+LBWhsNZ5z8zvVuvKa42FFYMzza32bbeBaVmVIrjt0hAvtOSDkzKz
 oMdSeSnvQWkLG0n0tLkPpUjvsh4+TrNBMpCm63pn22Q14U9XZGboTpexQDU+S0Gm
 BFpxERNMc0yQBvLVwcWGMvzNGBL3klGUNuZk4s7McYJODLlAzZj+A7eJotoH0k6T
 xrtF5jAiUpB0hzOmDpDODIP1SsY0ZlEyKGpL0dybA6z5B0C/UurQHgSZrKpQqsjm
 RoOhvbxSMOAou9ax3HQ0dtbf5Kdf/w16Ux1ywxWHb/j3C+QG2l4joeZ4etqGLtyT
 g1p6qQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh1pk82u0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:37 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-45a8cdc7e01so5307658b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089137; x=1776693937;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EJIKpujoigVEaBknrd4/meAnaGYzGS9Xs4bjoKjmIO8=;
 b=ZXMZZY1e696/W5H4rYpqYrp9TC66fp0JCgmp8IsD7i2XHCfwLHVISwh7w1c5z4ZeZL
 R9bLowp20z3DNtxNEm/5vzaN3tjXPu7uc65oNc4p0j7udXainFXQykFvry3di7DZ0ZAM
 L9RvnCa3SiPorI9fsiNY8SgjUaYoj3UdKl1gv/A7uymnayQ9il+tZliTwoxN6HHKsiKN
 KFp7fk7RUDF4bjkP0pUiPGh/jjs80F2AE3tjOrQdkZeuTNY0DAJCe+GWo+OpZKZR0xNE
 JcBCM+c10iWTJiNLeY5rR5t1qksqvDX3mIUs8D4hrEj5+iU8pCTP90yePcH+mfISU8Kf
 Gu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089137; x=1776693937;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EJIKpujoigVEaBknrd4/meAnaGYzGS9Xs4bjoKjmIO8=;
 b=pAADpnYfFUVprkhyBd+Z12xkkKnkD6vTQ1ST7gBUmRYBnbLNNXgF96wFmSxGgfiuif
 ezK52Nnn2RjBBS/2NlGsM1y2DTfPEnG1noMsrpyu2SXSYcb/EBEXoBPbnVA/6nR6eEGm
 ZEk2GbPm9fbIsm3vXMnihZbSHTChAYiv9tk2OHI95do+2gVUomy3Yf0M0C3899evr4Ip
 5K+NeAA1CSNiOPs4gc+RXTrCj6ltiGpLVIV3zTtUKrV8eorJqWB3T1Ju4LLS7MOSDyC5
 EnlEmMRTRTc+ONwrqLR/YAkIC0nyL8pDUQInnvpWJ0Ff7iLSBGrtEyuHSu2fe6A5TERQ
 z6qg==
X-Gm-Message-State: AOJu0YzlI9p4lT2fdm2Eim4BVvA5OcggWZRU6nHZ/F/fsbTjiOcUQ0CN
 dMHtVJl+MniYsxB8n6mPG3UW7z2l0DKkYZ2OoWBOHYQV0A/91P6plrrfQuky9DqtQBTrEGIfrXS
 Q7vUpTAl1njXdb90Ao2CzD8fNct4I6Mv58RHKDp3cU7exc8/v4hDzy4w7x225de69O1AD0rk=
X-Gm-Gg: AeBDietbmQuN5W0izcDYuYoMzCwX606rTVS9POFjr3TaF8HMmRFyc/8FaFZZivynd06
 aKm+Wn+w1s+05YlkJYLG/qIDrycwkHABG9V47s7SYAIWfyd8J0l37HDUOSQUj6yPfY0ez17L1YH
 HtJKaQri3O3xB7sxDAxG69LZKs5V1M9Ka+3zWwLrW8Km6v5kpKNsXoEZqwcLGPM4rVbGDYba2LE
 D79w+GsKAseSPDZG6h5mDVrnsP4o9nVWbAJRcD+2hEDl65AV5CulsTyidfL197EvKR+N9Z/jrh9
 zi95fMjyHVhYsytBZ108kBw9jfd701ZsRtCx6QgrCa+xyG4s2bhGcLQAxySbol5U2bL3jqWiEYM
 ZP3zEdk4j7VSKqiviKWRsNUuhdUh0tBFwa68ilWEvrYNdDNfE64tO2LP/0ntqdxM1UW+w0OIyil
 WYnOIrssjMWe+lKLvLh1MymcOCNA8TvLcRu+g=
X-Received: by 2002:a05:6808:518e:b0:462:aa0f:4375 with SMTP id
 5614622812f47-4789f20b19fmr6692747b6e.39.1776089136939; 
 Mon, 13 Apr 2026 07:05:36 -0700 (PDT)
X-Received: by 2002:a05:6808:518e:b0:462:aa0f:4375 with SMTP id
 5614622812f47-4789f20b19fmr6692695b6e.39.1776089136463; 
 Mon, 13 Apr 2026 07:05:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:05:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:25 +0300
Subject: [PATCH v3 02/21] dt-bindings: display/panel: himax,hx8394:
 describe Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-2-3aeb53022c32@oss.qualcomm.com>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=b6lJFQy4133z0QDWI8Z8xZQHGNeBu8+YH/BZ7Z2AGmc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3PgmIKJDbaJv9dSV7hV2tc76PBOML/r0GSj5F
 qL/vUHV8LeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4JgAKCRCLPIo+Aiko
 1SbGB/4hfXLcVYqX7VE6XHazXmPGrasJ6tcL/wypAthBWUhjrNl8jBb9lv1J0jFmAEgng9lmMBd
 8KVdC8F9BGVazj8lT3khDUMphrSzH2xrUA7R0MB5isGInE2HiTfU7l0LcFKmP6Pf2mvy3mc7A4V
 cKipRgxdl/zKgz1+Be1tuUrU2H+JIhNCPqWn2CmpzgS9Sc5HcHmPqjLuzsQ+AGhSqba2hTB2Ui9
 p7vRCWHjyehi6qr5QeTcpc/7lPDPVxkOXKG3q4GSc/x0LR6jYpX+dglMPz3ZT7T2mcTR+erOfZy
 YB6TqxW0NdPMw+54/yqGruhCmcFR79yIZqnfJB6LV/DP4lVE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 7dRhX602678H6UILUzOTGdSkEywLRpi8
X-Proofpoint-GUID: 7dRhX602678H6UILUzOTGdSkEywLRpi8
X-Authority-Analysis: v=2.4 cv=BoitB4X5 c=1 sm=1 tr=0 ts=69dcf831 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=0AHfZW8JlnlOAyLNbMwA:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfXzHmMkatRrOPu
 U6MzoS9dHFhuIynwRQZ+P8lo0XcLnE3BySUY76Bo8F7sE1zoIswM60yme+wVKBgP1eaGik52CCF
 TKQadNwMaZhYcjPtHMGbeqTPjuzzBIH8Jul1qbKxfTOa5Om8Wcmrm/KlcFgGiO4/tZxSjD+gGR1
 q5fBAMVb1fQwD5hrg8Sa4twgHhloM2mn7XOvZtWathu55HnaGYqmWIwokVn9xW962L9IIz+SstE
 A0IxpjIf1r1v5+DU5Iju2E7Pa13BrKLEcvRucZK+M0Pgkuqov4+nSLo31f/QaVO/X07rDQEedRw
 CT3+efYoYFpOF15nD8xZBJDcM3pjjHT6L0/jTBiYLNc0KJ0N6AA6LFmQLmWwBnRZbdMfMepeMkR
 rOBYB28bL/FQkMS7az3SxR3f9qE/FoF6DaKhlvk10kFF01G6wIAg+OlGCFWGvi2TxQ+umm8Tw0i
 qPkNCqWSHU9zqfkzGhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130138
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

Describe Waveshare 5" and 5" DSI panels which use HX9365-E as a panel
controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
index 84e840e0224f..83c343b02835 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -23,6 +23,8 @@ properties:
               - hannstar,hsd060bhw4
               - microchip,ac40t08a-mipi-panel
               - powkiddy,x55-panel
+              - waveshare,5.0-dsi-touch-a
+              - waveshare,5.5-dsi-touch-a
           - const: himax,hx8394
       - items:
           - enum:

-- 
2.47.3

