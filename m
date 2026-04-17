Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6526F99C69
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 23:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B4DC10EAD6;
	Fri, 17 Apr 2026 23:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M6VdFk92";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qa6fAECR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B1910EAD6
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:31 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4hTk2669968
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UaXfMj4md5QwxeQ+qMkZw/Ldu7dQBBhgDOqaQ8DvWT0=; b=M6VdFk920NS+avqG
 GjTn/q0E1gYwG1uy/SDwcfo+AIsrrw5nkLAYe6Y6ePj/7zw/p4ojqxZvjIF0IIfL
 enG1wyz+BBCThgAwiD5yYr3L6Smiq6Ig1Eaxj8M+fr4445d9tf1jGdxUL43qAHa/
 y0hIVodbpU4Lzz/uckFim3hFtIhUhg/YASf3F4VRzwIRjITuD6vEhK6USBeF/avx
 DccxkncHRf7TqK0AqEN/H+ZT6HjpeUUdsUJ5X+mbn7SPgHAi3mW3XP9gEe+LUM9l
 IXzh2mLJvJRaDreN5pFXAsbBbxzNv8ETzW61NR9L4NE4WTSFfqgmPq3gJpH2pnKn
 hAv8JA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkaxcv1ap-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50da31af14cso34899761cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776467790; x=1777072590;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UaXfMj4md5QwxeQ+qMkZw/Ldu7dQBBhgDOqaQ8DvWT0=;
 b=Qa6fAECRYSDqwm04RakOs7EvjE1+2hkCQFxNmaT5sdopozEQse363u6aBMzLbB2oHU
 6gLgEcl/8Tq8VSmxkXWDKg1bytfU5g5NPSNNeYz5dlVtOeuTxD4r/MYOMJo72N0Y8Zkt
 Pw3T9omeDbCLX1LGIkL875IUfGln19hku8Ofip8E6zZlI99ii5/j5kQefMfDLFNzHDim
 FtpgdeeosaFPqaUSEaSFIo4iYk7bsVx2JphwCQfTH9RIbpvq2nI11RjTAZsHZW5iJ4V+
 dfFQk5guMc0tQdyIuTv2i/XcR/sfOJhtIzeprsvP4ulQSMZ8iQ5yM6kWJvhA/XsOVn1U
 hu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776467790; x=1777072590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UaXfMj4md5QwxeQ+qMkZw/Ldu7dQBBhgDOqaQ8DvWT0=;
 b=k/tArnMGQ1ka/nTFqR4GZUINviu0vn4B+wiscuG/tjHcmldFInsFLCfPUEqKlfz6Hr
 ZLRnWu6Z8e1xr3+yqkMAmTqyattdbQqBxQkIuPngSfZGlCOI7mx0p3mMo7FjUzKFPq0c
 Cmme5tdgg6YPITM385rgz/epmeky/qqZ3jR89xVRAuYMFfSeITS2CX2vgc10Cx2JmE/L
 laTT+rEBf4TRykh/11HhFqCyTiAAesLXC3S4Kd6DD9iwwkia8BHBdfnOBHk3kFx/JfjW
 dNwAEyULh/emckIyEpy5TFJg3EP6Mt749k6iLnk+dw6UIvUjx4Gd78HhsdsYyVjISzGO
 KINw==
X-Gm-Message-State: AOJu0YyOSkcUzwbb/qxyudzX7A0fpxiNL4p7T8CpOb0ttpwYiBlW9Hxn
 uSLU7pFmZU0A7QknLx3wOL1k+xsBqNFe0B+sw4o4ELzHWt6FPPDVSgq3RFFjoWyaOSKIr44fdBo
 Np4MZgKAwF6c7E9yYJO74xGB8wOaNRfBDLnEyBPEKIDyfHFnwQzuDqbHrszH2mpoY9efT05I=
X-Gm-Gg: AeBDiesmN/1yWIfSi9digU/rG9wqqu+yFwOJ52W0Fmta45d1j/PaI+37/cEF1mqR4l3
 LcaJh9c1EU7+vuqs/rULpUrP5nPwRZdxhOQ5orhkkxTay+rNTyU/2shqtD+9TLlBGSG4pHyYYQo
 giFVKl+SjTzMiCsUVsSYCj8SdoJJh+1JROJcd92XtXEyJ/jw2uSHPTkY+0L6UHEpvA5PWqgaN/N
 J8QYk7U8ikWsp3vfokxFYObB/VAEAP0SWdYZDTOswDfEHEaY17dDDyvf4sTVr1bPP5VrS/MbFBf
 Fw36Oanq11RkbcycktbKwEfRtFnHnT+kFJeVsMgBNOioP7PNsho6B4mnFI8gGCG8/HAgssx8UOo
 ZuFGWC86lixjhqQDAdwrNRYsv91wg2nzBY0awPJUJNXt1gfFEaxGQvVeg2eKxUCUmeyITYRjfaI
 NjERdDE+CqTEDq9ctA/YPWiVCtqsvtQwZnE4jx40JN5pFRZQ==
X-Received: by 2002:a05:622a:a06:b0:509:3141:312c with SMTP id
 d75a77b69052e-50e36c39df8mr75420661cf.40.1776467789949; 
 Fri, 17 Apr 2026 16:16:29 -0700 (PDT)
X-Received: by 2002:a05:622a:a06:b0:509:3141:312c with SMTP id
 d75a77b69052e-50e36c39df8mr75420261cf.40.1776467789530; 
 Fri, 17 Apr 2026 16:16:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad12asm815695e87.1.2026.04.17.16.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 16:16:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 18 Apr 2026 02:16:20 +0300
Subject: [PATCH v4 1/4] dt-bindings: display/panel: ilitek,ili9881c:
 describe Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-waveshare-dsi-touch-v4-1-b249f3e702bd@oss.qualcomm.com>
References: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
In-Reply-To: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=00/cQNg1NYCrw4ioCag9pzQGr6M5HdXkljprZfWJ4u0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp4r9I3pRwfKe7m7I0xhk+TZMgKAV07C9sH2XED
 p3U2kOs/rmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaeK/SAAKCRCLPIo+Aiko
 1RMzCACS8ny///gSx5KtGdFeNzfsEAXWQCiN7UvY7WbiiTv9uAFzhoF2rhcpMq4hUP8XOkBXV+Z
 aM9Yr2dA7CM5gMEaE7ULarGlYjsr1tgxPn/foPrOGssvxvkkIBhhspHuw9SFU4MVMx/wgDc7DPN
 XLl9k4rrBa5setOah1P+peF4XISgxSE3uBKrJGLNS/37do+cbIaQS2muEdNT3dDUse+cK8Ce/B7
 g3J+EBrojUaK+ersgFWQ/Gj69UXHyrDaRQGepkvaKafWYgcHSVCzMkjmrxaAXHyvqTRFHiqsNVV
 ogHgfLXUwdYqX+/WT2ZuBEA2sxYGC8fE+mRkWYrLG3QZBbo2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=JcqMa0KV c=1 sm=1 tr=0 ts=69e2bf4e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=sGmTDZJufn-iKI-mlscA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIzMSBTYWx0ZWRfX9AT/tMsOWi57
 aS4aWBSoPsFc7FfO6qYEJbsfO9t7qk0ajzIOg7yFUUdaf3agib+3encX7pVKl8sWmIymiEodqvd
 Pz20aVtc72sh4yt01uh+X/lPXkuTpwi0ZJkNKqFSTeg0IEHtDg86jDRRuIKPh04HldZ1fvMmKrD
 8A7jGSmXqM40BCKRdAUO7vPZhBj4prc7w6fPwsCK89I1vxB9a6V4k0d1Q6gNf5oqMpvO+i5xSgU
 GYHDOQRIzVyELVHRXO+/3guglgazLUZsE5nDW4CQ7v1Nq+OoPCZAcx35j5Q+eBxg0fc8pzrDmD4
 cEOmy4JPexVjsO+qbhpnaPj2z1uB/S+ZNOUQhFkqfusqM/90iiBaiOJWKt2p5qxOyYqFJ4nxCt8
 6iRxrF7Alj9fDYo53Y2pD2ENvqU1EM85Uw0W0Md/ihyPv8fCEr6L+uyVVw5/gLdYSK15ZH0idH/
 QrlhDvXfkwUzMfwA7Yg==
X-Proofpoint-GUID: JTrGzQwEJRXHd4x3S8lheeh6IlujwRYk
X-Proofpoint-ORIG-GUID: JTrGzQwEJRXHd4x3S8lheeh6IlujwRYk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170231
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

Describe Waveshare 7" DSI panel which uses ILI9881 as a panel
controller. This panel requires two voltags supplies, so add separate
iovcc supply.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index d979701a00a8..42e35986fbf6 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -24,6 +24,7 @@ properties:
           - raspberrypi,dsi-7inch
           - startek,kd050hdfia020
           - tdo,tl050hdv35
+          - waveshare,7.0-dsi-touch-a
           - wanchanglong,w552946aaa
           - wanchanglong,w552946aba
       - const: ilitek,ili9881c
@@ -34,6 +35,7 @@ properties:
   backlight: true
   port: true
   power-supply: true
+  iovcc-supply: true
   reset-gpios: true
   rotation: true
 

-- 
2.47.3

