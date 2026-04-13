Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F644F34C49
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FDC410E494;
	Mon, 13 Apr 2026 14:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fqTYoBAf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q9MDFZO+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5AC10E48F
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:41 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D7Tm5d3828423
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UaXfMj4md5QwxeQ+qMkZw/Ldu7dQBBhgDOqaQ8DvWT0=; b=fqTYoBAfrCO/kC+T
 2sPHKpdHTn1liOR+f50HefOGyyeG+tQxh1ytjjA//QPZjsPSeGf44V6uWPC76v/C
 VOJCr1O3f/jt8IjqqTwqUrvno4ZfZPQQl22KdMyikokhCqqoHVyk1Rzx0vIgXxD9
 HCxdAUOWn/ulJP0mwKEEt1Rj8bsMqdwuSRTN59xDQRGnbZBDOGI2w0jduV7FdELL
 YNUhu1QO6Bu6dNK7YAG6rnkpyIrQN2sB/gxAN3tr3vUVSoKw0TdVOOddtVolTQve
 f30/WZlWEGcFHSVCVFQmn6JULooEs+5vb4bolV+kR6wgcR3i2+gEG5DbhttrdFg8
 WZ2YOA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfjbpd9uw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:41 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-47545742e67so5443608b6e.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089141; x=1776693941;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UaXfMj4md5QwxeQ+qMkZw/Ldu7dQBBhgDOqaQ8DvWT0=;
 b=Q9MDFZO+ArMt43DenrC0aBY854KGUgIsCJHfXgp+sulabauUbUy/N88A4HgPkfHqW/
 Wa0zLl4IGp0Q7R6GM8ObGmQ2y2YfBoNj3EuwBPRLKd5Viq4Pz0RxJaxev9WYqF5hNlzL
 7oiVA+TRb+1pRER/NvzFowZxjeLYR6Cn+zYN4/ihtjskpb66jlMCHXXbd8gcqebIE1lv
 96Bjaof/fFJFRbaP9KLaAeyPZccUaiYR5AOzxWWlBE+H8Lh0eU+Jjjrb/4z1wgWPY5qy
 x1FghwSGzU7FE+K0WlWpl6jYR4R9yUJoVdxqbJtdp9tEqQyQ9k5U98ZQ4s/nMroiNu6L
 Ie5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089141; x=1776693941;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UaXfMj4md5QwxeQ+qMkZw/Ldu7dQBBhgDOqaQ8DvWT0=;
 b=aYLBZef71JH7AqZEK2cvxW9kKL2cOkeyhUHy4QLCVP4N7A82B0yPXyL2QyzCyQv1Pw
 Sei1clIYwBHe4aZJOCsyMtBf06NaCTLwcKoIIdTykZ58RFcV77RKdCqGRX5+OytgrYLh
 o4WmkeeSaZvN7YIX5nLIix1VwqKO7It0wGKFYgyEmhxZFSuGXaVAGNptFf+nRbBs+Svj
 QFegzMpZ27Xy7HCUD8rVpUD9hIF/8K8+3mUTqa62+zv1AePdf1ZWRy1eNaZSF0OZ1IC5
 /LoLNk1SZLX4b8QpyeJCUEgVJFSQPe+zPDCVG4F3A5WkEJicBLlKqvYFS3h/51a40eaG
 FaCA==
X-Gm-Message-State: AOJu0Yw76O6qcy/f/+L7UUUCskVgeDdmvCzFZb+p59qa+R641//lUOnz
 UEwUza7tOo8X4Bgx7xQ+FDUskZ1bIOMeZyA/hAYyneIBRBcIMy52pNe4VOvU4YlE24GQGeZmvUz
 7ydQUD5Hl7TW9+S34VHj8qXpQVIWMeOzP2Vw+frziOeg5dhzsehQcWKz3+4kD5erizvTBrkU=
X-Gm-Gg: AeBDiet7ScSB6WNy3m1dYLeO+r2QmGR93RpkT88VnyLRngbwi/4KhsT9T8v5Ubj/ZEG
 RI7H2OyxhByfzaZx2u3sCOeLtf93+MQ6aHiKiTB9vGPTIuLdq+XEDb2I6UIvD16hYhFyEUvDpp/
 e8iWbs4If1D0Vx+NjoTWMjOlZAh+Em6pCSzTiVacR6kAT1cCRNArZrT5lZB1/eDWdZOgVrYhhz7
 eOVKfIknrrDYbHfDYIw2ONw5+eq5HV7Uc5pqxpUT332RJv3wgAI1oD7ATBqA9BvabpiTRxOFP03
 SqdqqbemNtAs3b7jtifyZRBOFH0MLPwhVB6XRmC+9iUnXq+z20SDlA0648z4LJx4VOHK5eh69Pm
 qOhOaH95P9U0828OJZmrC9JYrbtPhqC0ylKs6G1rnhxbZqiLw/jH0BVlCorIPr5dmtEeCdLa3tN
 SvFBbXq/EwLU8bBSw0i0QAwd+gWTwotaa+fpg=
X-Received: by 2002:a05:6808:d4e:b0:46a:869c:b576 with SMTP id
 5614622812f47-4789ca3ab21mr6505420b6e.2.1776089140566; 
 Mon, 13 Apr 2026 07:05:40 -0700 (PDT)
X-Received: by 2002:a05:6808:d4e:b0:46a:869c:b576 with SMTP id
 5614622812f47-4789ca3ab21mr6505381b6e.2.1776089139990; 
 Mon, 13 Apr 2026 07:05:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:05:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:27 +0300
Subject: [PATCH v3 04/21] dt-bindings: display/panel: ilitek,ili9881c:
 describe Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-4-3aeb53022c32@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=00/cQNg1NYCrw4ioCag9pzQGr6M5HdXkljprZfWJ4u0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3PgmUY5/lkbIsI3ImbSCzEdVXTJ6SyLZWm/sl
 kgSU5YFD5SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4JgAKCRCLPIo+Aiko
 1UmKB/9oh53+0taG5F7WFFssDhI8P/ajRU3jHUFKe/0QWQ1xCvogfD4lBbnhtzCbZtEQNEHZ6qU
 4YH/Ywyj5vAvhqTFlanRszfGz5/eKmMHgNKn4fG7ox1IydJePfCpM4D2Y6GI5Xtc5WLvB460wz1
 YzSWjmg1YYY727QYauPvtJ4tMl9EHHgEfqr+LD66JpNnEWCSO8iBiBTWZCKMNU13/sq9xk5G+17
 98e9k3xhcSFI6zHbIihy4OIH9AVniH53PyqX4TDFfX2mlYrUT4KTfDZI6XEeI4/YfHkoJXiVi73
 YjTimH9uIqH5Dmp05lXDEccBUAYH6XsE3bNOSF4MJUvvCB1K
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=PuijqQM3 c=1 sm=1 tr=0 ts=69dcf835 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=sGmTDZJufn-iKI-mlscA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: c16t43p5MrchGBm7RgrvfCtXSiF9kYVT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfXwWve1/WZjT+s
 AJxKeIAiLotfZb5e7lK4BoSgz7x/qpxseCg83MigdoxAsV7FJrOPFJOEo2BDfemlwJceBrHnui/
 9CpMOzYDh9vQdW3bbhl9vfgAy6Zjn6J4huztTyoi2l2TGtuoW6Z7hxDUYR8fbdXSMRgEKNx8jWw
 568tqo0qh3VMfRZt9sUtWNywlHFAhV7uBXqNyAjzJyMivM2TqDlNrkx18PGbdZbvq8r+Sui8Afj
 UtMowk9R0QjOQyth3rBDZWdtz7C7kSBgpXhy2+PskHuaI0hED74UfOplRmuF0htuN5eEWlYOmeQ
 mG19I393tNF57jlfnyGHVIW2t/YUUotuMXOcHgsTp3TqVPYpcpuxkoHiaTuSzeQMRDGmEi7kQx+
 //1ZiH+qk+YyXBXYoFL8aWXebb4YG7NY5SibNMWso7Qkf23y4PkPObqty2/teIGGMMrxTqBlQXB
 ahE/qVqnPQvuSKFx0rw==
X-Proofpoint-GUID: c16t43p5MrchGBm7RgrvfCtXSiF9kYVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
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

