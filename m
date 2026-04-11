Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ED8F3ED4C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C8510E1D2;
	Sat, 11 Apr 2026 12:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9S4tiow";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GfCMKx8N";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECC8910E1D2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:58 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B41MIp3377142
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yu5MwmsD6H0oMm1hsBHM+snwkT5wJGW0nrEZxLfZo1A=; b=E9S4tiowfZFoDsAp
 TLO9fEv9u+ITc+ygALNIqMhaKy1la1Ow1HP6qBjM9i/YtoZk25SA+3LDsgEGPMrE
 fu1Y4Ccpe2Imp8T9yfLh1yZL8JIhKpILf1aQdtIm376xRFxaVsMU/KDgH9LqUlB/
 wKnWGwTYFbn5j9Aep1382T2gSsLjcSoTiyoVJQkAkxRoSqX/mOzbCLWvE8eBtCAF
 qMcwrwM6nK2/I95RGk79RFxBP6PJhwIdi/DdawWJb2g48H7ePaiy0oP28iSyuW/z
 x/KzbyRoWIlX/lKvNEwBth8Xo+dwrMgQEYrkZcbtmCc164bB9TaHBDe5KZUjkilz
 fYcAiQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkrnfh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d68dbb77bso19111011cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909457; x=1776514257;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yu5MwmsD6H0oMm1hsBHM+snwkT5wJGW0nrEZxLfZo1A=;
 b=GfCMKx8NbqYkx9WPWS9klEaHHpbWx8ksfRAH1JmmOOFHCbeYyUobusWlmNA2NkqcCk
 9BVt+aA3dPrwiJBzuXkqOJ8x2xKaSPR0BPm6qdy71m7WXrCYVFlKUmJtksQCULXdYxDV
 oq+xxRc4XG5vh+T+eWSZs+TWnMp4P/VLPPvtnlpKe7TQjDmie9qNRxijcgCUjfggpQvt
 X3RhGzqSsCku770kJeH1X3kHtmJZYLUzVYR1029tlXUyhlorLBH1PohTlEBjC7fgxv9v
 fSWHnT2VVracDHruswg6HdIx7/n4dTzR+1+4riqmGBbMSHm3d7Hv1hSvi2uAiskWmY7f
 MUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909457; x=1776514257;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Yu5MwmsD6H0oMm1hsBHM+snwkT5wJGW0nrEZxLfZo1A=;
 b=Wad1MkSNkOTJa4yzyRwoXVTp34Frtr5qSjMjsjzaYnnK8jLd4FmM8f5gKtwkUXZ3qB
 pGd3hr9KVcmzlQX/6+wP/s5/2Qnq/zmRT6GrfkGCUCVb3RC8dsWYeM4JQgf3KGmQX91G
 NaSD5+kXppNwdgQ9sP6fnekxb0ydxEZY7rdbwKe2FBy2nLm/mh1S4JNYEh+bMUd/MsFe
 nTXmv/AijUgrE0rXC1QBDwyW4z+RZX0eUEPCc3wnDFvpCVQik8LEN70sTDly6gvgn+eZ
 qBeKalgOUDuBZdn+GVceu4qcEZBwTF6gCT/70qfOS2SGwv0UpWlt/5RzUkPveMTu2eiO
 G1QQ==
X-Gm-Message-State: AOJu0Yy0FHvqEmOhgj/DdrGiy/W2j4ITWvD37muMPaj4Bd+e04OXrd8f
 EEpjaeCOhZWaXEnzq70XL/QCb8GL+cGWlgH66Tdjls07DRD3bUBTic6g3yuZqFuEKD0/gzFnT1W
 NwPB7SL5lsWDo1NMEuxvXXmZEYR5PuckAjfUxmWLFw2WsOOx57Y09GtEZhoBXy2Fh0igixQQ=
X-Gm-Gg: AeBDieteZjc8wxFcRd/zEc/fpZFRMyOAtij9siaoN0x7FQogkt427ci68Ae+owsLsAZ
 yC1+wqUtIzlwlGfabaYxKGs65b4scc/JgIeGPgSOcJAfOH5hNmZV9nhSdzUjMrP771fIRTIIZEI
 QaoDVPUnzCAnmYRIYalCWW7fqCzS4rMliV1Aj+LfPiH0jn8TP+oVDwQKZNtA5h/x5bDyNNkF9OQ
 QC/C2o79ndyY7iNypf9n4NsSe69xawbO1yv3RfE5vi9jVQPbizlRobAXkcdDPT2bKEQ3JK6fbQC
 h9QkZM70jPwlaIm0xUEuNqEA+kdB2IM8vFOaYYdTNUlJksgZ5UtYDGLqZ791ZIkSU5bU+mYIAxj
 3qxd2nrEOyCtyhE6mPOuV0VMXl2UnVYCriKX7IJVJy7e+ROuFiFtUKai7DEK6RsSNEhI0HA9d4w
 RtTQD6q89z/ZQJx26Z72yrOpxslUcDc/y6hHA=
X-Received: by 2002:ac8:7d86:0:b0:50b:4c84:67ab with SMTP id
 d75a77b69052e-50dd5b0ff39mr103408761cf.17.1775909457500; 
 Sat, 11 Apr 2026 05:10:57 -0700 (PDT)
X-Received: by 2002:ac8:7d86:0:b0:50b:4c84:67ab with SMTP id
 d75a77b69052e-50dd5b0ff39mr103408311cf.17.1775909457072; 
 Sat, 11 Apr 2026 05:10:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:10:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:24 +0300
Subject: [PATCH v2 04/21] dt-bindings: display/panel: ilitek,ili9881c:
 describe Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-4-75cdbeac5156@oss.qualcomm.com>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9BUAPXzA40V6xuiE1cTes3j3rjDbHWpL9QzXZmTLuNE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpFbocrGiN7ZBRTZM2TGbU+Z/32ClbWSrbxz
 BeQ+4Z1pWyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RQAKCRCLPIo+Aiko
 1aj5B/0c1m3T5bLh6t/sQxLI2Yj3c6WRggvJBal9skVpbLz1FZi2u7tP6Pm0K3KLzfuK4q2tbbz
 d0jX0pNWROKJx3ah5RXtsUQH8AwxudUdqkbZMp6Vaf053o29bwAt20NwyjmWiHl6K+bFYniIn9T
 TeaDNTCFYmoHzMZJ5isZuYJIKSyEIGbD93xrVoqqeieuOXmW1MNiWnys/Z6dMnSQC/WCTH3dSv5
 fXOMRELsG4AhrxY5HDMwE4mmcOOksaj/DoqB7PDhKoNJQb+12av1ioJHhjnTAb8B6xf9dwrQr/t
 Zx72oVVLteFTwZcqDFUgCnNWskT0rT/wKsg2znbtKB+xQTF5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69da3a52 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=sGmTDZJufn-iKI-mlscA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX5uzvr2qGqiBx
 qZ9+9wE4MaeZFrg483EnUuhpESQh+MG3bvH0fIUm+RsklUYcxOVrW6kj9IcGwAseRJmVgV4CQ7b
 OAPqmKqzdQ6e6rUW957Ft4qC430aY3MIpk41POvLRJ2v2eYCGMC1wzGe5v5IIgnoT8OHhdSBFWA
 hmvR/pwwXAgQUnsrsxuVS9DRSjhIl2SFzmg2mRgNYW8p1bjJsX8GL47wPBeKPbuvCleduFd15i3
 ZlZDFz6B/7WCFFdmiZyQiGX6sF4ZxwItFFR7nlqoK1g0spfJZbMuv1xnVPGb29u1Ci2Kb8+4oiT
 jp7npt/Uja2pZu/Bcz9cO7QP5xH5mv8gZHuEKlXM/PK1O5Bjlj9TxOzuOLlMYwoljxqA/+d3y3G
 w+DqFAecZQHgQK8bKZnphhlKcTkCTUdHunFV6RNTpzUNVRsNW47wj6yHc18iPqA2WaGSqe1mXrX
 HB3SAV47/t3rrJaMXdw==
X-Proofpoint-ORIG-GUID: FpjWSbtPjIBrAHEkORI5DWhjf6CMPHJ_
X-Proofpoint-GUID: FpjWSbtPjIBrAHEkORI5DWhjf6CMPHJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110102
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

