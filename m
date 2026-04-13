Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DE4F34C54
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3543910E493;
	Mon, 13 Apr 2026 14:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dS7kjxdF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DC/Vtmo5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C85C10E48F
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:41 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DB17HQ542922
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2x5lTfFSzhFGUpvlbYeEl+bXq1HLvTyRTgCgvYE/a3w=; b=dS7kjxdF3PZEKm0A
 sn85rVQZLfoWAfMoUoNnivArqgEwhdE947Yy4/MlM0nITN0fEMU341LDmz8By+1F
 StR/h7W7ZLlM8x1n3F5bFmQxa7mmPkK4H3uwhZXoPhrGWzmjXDuDC4MCNIIu4iBN
 CtC3n4Ov8VcJ9fHG/jSNccU6j95TdcRu6Zu+d+lLXPvWAQVQzYjjghqF4mHk0pnJ
 oftKwEEMYXPcozrvrvO6SI/jDWRMcLhSf3a6N1Y35qJ1GMxgPd8oN98NtPnTWuzC
 B8aiZorR5MhI/8myJ9caLY8n4NfuDy9LmA5/BCOYOWaUaqLgZQA9A9NwswYm89K+
 llqcgg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfwnv0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:40 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-46ff0cb3a36so5822565b6e.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089139; x=1776693939;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2x5lTfFSzhFGUpvlbYeEl+bXq1HLvTyRTgCgvYE/a3w=;
 b=DC/Vtmo5ZYc5XqwkYisVHRPQJBL2ybj6gbPl1Q32SrkhEDnKfx2F5gWiPzacuYIaD4
 OAPCIjpV/aywhLMt2sQPkC5GASxm5Ofd2fuC4SDLTWnYmKFQc0EuljE9aj43hY0EFwgs
 Jcm0xYKX5YA3+qFLzYcCRjkWuK2t9+UfY/Fj9suRRiIERlz9b708OueUeKDvPJaU+KNU
 mdA9bFqZ9lZyVChLfXUo6RT/exQzsNgNEo9x2mtbyOyJ3kR1lQVFm8+v5HxGQ5zSlpTM
 IMpEyL75qC0NiWpNochAEvCUBd9O6AoLZ64/gTDee19RMv/Vk8g0cmo8bK0d8TAAgenI
 Dx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089139; x=1776693939;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2x5lTfFSzhFGUpvlbYeEl+bXq1HLvTyRTgCgvYE/a3w=;
 b=sb4mHka9VA3tERpn0EAQHWoMJUANYLd0DJYmOlUXAbfGcHBUatw7S2bZtiwJVm6ImX
 8XvI7x/2tb+Ab9pDAHmj9mMEy4nBVUrwjFma59nFVpmQmmdx82ZGDDvvdmwWWiWkTfsB
 Pc5o8egIdAkuhrADJGxl77zn14YtdirBNta/0oTZ+/cnR/edVbUUsvVs3qbGRDmFGyKe
 9CoyoVkdiFhH9uM3DlgDVCIo6zsNOAd49KyhGULaE8XAJH75cPq606X77rgkY5Ncb1l3
 jITcFHKVLd5K+gEFhPMVEPkeBfvOVNhNXrQuSQ8WpVS2rouYD9k5KiJybK+M2mMnOChm
 4R+A==
X-Gm-Message-State: AOJu0YyhUECwqQ7PgywIiDvROV1AH4SbQg+I7JQKlTdd9HsyXJd5iMMv
 0zHJPaMAi0w7p40ye+ErGAOqkdVV4xI4N8v+lmwygST2ygOjSQvNewjNwcdQgycqTvAcEPanhNv
 AiPPQi9tw1TsAcWTG3wCcp98WBZZjlaVx/NXI+rHl/ktvw2cqZiYbEbjmsS28yBUo5YTe21IGNg
 KIVgE=
X-Gm-Gg: AeBDieuz/43ilLCDfVOM5F+FRyhXPatvOpGzGIHN9k7k9YCHUIOcqLiFF8bvTRXzv/L
 tvDp8/WE+QjnrbZhE1hs4Lq4eRF5k6y0H3lEiVECbBzGD5LW1/Da9s2r81UFTMlcl0BL5i+lfQM
 dt+lrv8jlK1Jq3bPOKcT8RwZ1lbFdmcNILTkNTtY91Mu4oUgaQuAFn1v7savCaTQY6jcHwbtD5x
 bYmyPqicHY/XtymGQw1umnIeo8+GI1KtZZ4GHwiEgwGmuvY0k+LTpfIhYNmwv7auNW0bg3WPD8w
 xHKKvYP2LUFTy0KkiQ7w2Rzn8VGyGdo4CyMcObEGhYLG8Fz1MuaN6EpfX/8g9xQMYdq4s49EZKP
 fpUJ1CTAVYY2an8IFZHu+/wsFiTxffJG+NqU1Koe2UVG8iNSbKbU+z9MrQP0wdqcHACKZIXZBsK
 Y2XrULEi1cUQ9uRZc+dYfx1MOjSL2ech+2u3A=
X-Received: by 2002:a05:6808:6902:b0:45c:95ab:bce3 with SMTP id
 5614622812f47-478a0808fb3mr7049810b6e.46.1776089138846; 
 Mon, 13 Apr 2026 07:05:38 -0700 (PDT)
X-Received: by 2002:a05:6808:6902:b0:45c:95ab:bce3 with SMTP id
 5614622812f47-478a0808fb3mr7049765b6e.46.1776089138303; 
 Mon, 13 Apr 2026 07:05:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:05:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:26 +0300
Subject: [PATCH v3 03/21] dt-bindings: display/panel: jadard,jd9365da-h3:
 describe Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-3-3aeb53022c32@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=N8CKm/X1r0MFwLfZruus26Jh9rArudtbcfuT15AgEuo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3PgmtV2U4qkj8T0cpHphotJKmtI4IJGeFafmg
 qO3OLzIPsuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4JgAKCRCLPIo+Aiko
 1UT8B/4q0xvq6ZwlObUFBLEhkHWQvegj9dvxQI7ZoiM+0M/GVuHpOSQ8lRveP/WDfIhcWYJNntK
 6A/lRe1kyNm3I9jUDhoS81pgt83FbET5h6itAm3CglrlTuldKzBv+3SyepEjZOloFYJQuFBKqdX
 tohASKSEEOie4+7VJcc7846HlFbreFEhlaeayc8hFpUPI8KK8S2yf+4smFhahr2zTEaIL8cMbEY
 PWP3pJBMQ+tKzPi7+jcL4oE79WhHp63HSuGhdq9sUiqETHjb9HrQQ3KndGCbdDxWlonuDLJLr//
 b+kb+Kao5L0jK7kKHxEENGAd6gIuUOwuTvcJ2Sr511VzueIU
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: qdXq4sYG3ZLK4MkPc53gjvmFFIyWN3Ja
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69dcf834 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=3ozaZGYpt45I3yT0zMEA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: qdXq4sYG3ZLK4MkPc53gjvmFFIyWN3Ja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfXx0SzMUT/h55e
 XtESSLTVFpAuax1RdYYM15HwtYDm0UFBVNptIy6DCLBO+BbufTbe3Con7LXADq7El7TLDf5wYEd
 +2Sf8O4wFtPOhebmdaaGX1B10z4+igDVSsGKYc9aE3BtIK4sIzhdsiwwJ56UuTVRoyiFZmWCpW6
 09IqX96UDPdNKWMuujhda1YJGIFhCMEC87OwveBW4AupF1SoCAJ1tcuv7e90+nxxa3Uq3z/jMYK
 btNYeZtN77+8/X7NB0YrGeB0duOCGduL8F8AI9ddjLMAc+zBb2fQm3CQIX+GHi5jXNLNA1XNcBg
 qAQiFqlN/gzrtALsci2pHWZ0afHDzfXGPj2PpTAwfE9gveLq9cobGyPgOffQokTDWPvgks4sC7M
 9tDLzX7eRW2qLWE+oiBjBBMp2JTeB+b8XXc6PLHsUBH4jQOImyNUOvzxfKmPdYzyMtd+eRqSvl2
 0z10kXhvFaxgcnRjiAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
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

Describe Waveshare DSI panels which use JD9365 as a panel controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
index e39efb44ed42..4eae802de9fd 100644
--- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
+++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
@@ -24,6 +24,12 @@ properties:
           - radxa,display-10hd-ad001
           - radxa,display-8hd-ad002
           - taiguanck,xti05101-01a
+          - waveshare,3.4-dsi-touch-c
+          - waveshare,4.0-dsi-touch-c
+          - waveshare,8.0-dsi-touch-a
+          - waveshare,9.0-dsi-touch-b
+          - waveshare,10.1-dsi-touch-a
+          - waveshare,10.1-dsi-touch-b
       - const: jadard,jd9365da-h3
 
   reg:

-- 
2.47.3

