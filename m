Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40221F34C55
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DA710E475;
	Mon, 13 Apr 2026 14:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pbax5HqT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NpIqu7XR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B399610E474
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:35 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DDnXWp480921
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ETYWoaJyM9VmKmVawKGSIxoRtEFEsHcnX/Tz5qCocnY=; b=Pbax5HqTfBq1+LlO
 1BWoF/86j20IrHCfAzT9p2qahh2qmCBs90qBzVOV8zqvFdV+mMRZyTwdy8dsJbAt
 xXQMDOsQSKZrtcd1IemvCWJGA7sbZqC4kIe7ZcXynR2ShxEYon83ykAQdRXubmHG
 c2ENnYz63Fk9Cd2acd+9V/lyg65plIbJINdnBbPHLbdayn2ddaAR9GjpJy+vzMCv
 6cxjI3pJpmnIwI7QNfv+M6nEHIvsKKUSAM9yFBDIWdwEM7a5pDo+G+EbfKLO9TE1
 s1Tbn2PFz0uaM22ekn5bv8J7OqEtKz6iKEFanOALDWZJrVzQpiPkQvcY9MRmWX7D
 WnK91Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dguuj9dkc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:35 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-463a075e177so2498833b6e.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089134; x=1776693934;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ETYWoaJyM9VmKmVawKGSIxoRtEFEsHcnX/Tz5qCocnY=;
 b=NpIqu7XRFtYPL84pckGniiPi9bwFvqSE9SKM4QBsy7TDM4CbDRtlRyazjYWyPiW9SX
 FC2UEK8w4mlaQRV3MUdIjO0aGJFWnnPZ8mPhEM8QxA/Z88xfXGH5tpH0KGRoWrnx53kz
 P6Bvh0cyYnPgtm27g7Tof74xizPBMFTkNuTp0iehSvTPNz1PquBG5BigBs143cZzCoCV
 Aa2zHzgm1B5bHxQIkzVaa+Q4lRcCd8pmHYHrzIezFQ0KgKzVXxzrOZF9f9yeHNbqX05L
 iirFRWX7+5jRV7j7ncV16B2Z04/2LnJBwHki+s+USMrFUJ1OWchIbm3paig4prLAnEsc
 RyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089134; x=1776693934;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ETYWoaJyM9VmKmVawKGSIxoRtEFEsHcnX/Tz5qCocnY=;
 b=sSrrcMVkaN23O2Dn6hJdYE8rY4bFCO9uQakj34mIy4ldvKWBqgnVg/oKDoVjXhjjqf
 GqzA4cSEMTIpdJAyIJYe9QBx5u5svuJ5oztaH2rsiD5fPGTxnuKbypQOBB4kqqpBbUwC
 TAWf0FmDxIvRwJtybTf6c2Fi3+Z2fe32i6euLCNGekU61xF2yoJxs/hrnhXDfn8+DJfR
 qFSDNuooAVdWAz1cp+HD4yl5Y8I6F2JyZEydEe8tSB3iLeuRDo5rCUUzQQ6/rBNxngVL
 yaOaFypaxLzlRA3TqyiEF4H4th4EUYQlTjNK7zf1kiMaKfYpbWqvbNMGksBi8ZwRvnr4
 1qhA==
X-Gm-Message-State: AOJu0YzrInDiVoWcZqqKY3FJHDT4WmGZ0RbZ6+ERvse4rX+BvSV0sRuY
 ZxlWSimWZdnhYk6swSf9Pd4b9aNWd+zie8JI2+t7P9mdbdJnc+6xK/kOxpP36S4q0EtsmI0sNfF
 xt83DlmIwLkZBemEBiPVeHGG5B7/XLwfv3pDzl9RBq3pJJOMb0Qc1FXSHoSEzUi0DGiT+6zw=
X-Gm-Gg: AeBDieuP77Ve4fK0Tl6423OVbmdrxet6izkNQfsK8QQKXiLd0np1hk0S1Zfom1bBEOW
 i0LArL/Kzu2xDgob/VrLAl47C3GCpVNJPxrMOOG240zjJtiIbArLBrSDdPbPbn23dhf94/O/sqG
 503+3OJ0iVOc2VsconVeXYkQQJiAs4u/fVPm0AGaTA3tE3m19A5A+cJzkeZFldPy9zqsA5LM8WF
 zYD9e70xoh4reOEdXMiJnDlAlqTnRcPzsJVVAUXaCCw5+AJX1CWw9NQyORd7mf1uYlD/rPXM4ub
 fdtqbMhkpsGALrAjEoroCGzwIvwYzw/7QUABFYTPCEeDBYdIQoiR+aS8vNvMufup290L4aL2dMf
 SUEhP1sh8O/lpTWXqqpUxQ6ttOpjTG60PJaDa2eAgssSSyj8rmzW+6DN/h8eXwl0CujInoQkXfO
 /99e5VGaZGwfGz6uKZVlN8vNiP/POgGuPE1gM=
X-Received: by 2002:a05:6808:1a21:b0:450:c321:d50d with SMTP id
 5614622812f47-4789f00d969mr6635798b6e.40.1776089134129; 
 Mon, 13 Apr 2026 07:05:34 -0700 (PDT)
X-Received: by 2002:a05:6808:1a21:b0:450:c321:d50d with SMTP id
 5614622812f47-4789f00d969mr6635751b6e.40.1776089133568; 
 Mon, 13 Apr 2026 07:05:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:05:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:24 +0300
Subject: [PATCH v3 01/21] dt-bindings: display/panel: himax,hx83102:
 describe Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-1-3aeb53022c32@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=USkwXBfci9sIWJW06UXbOmxrqKMlrITA2EN65WJiKAk=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+adH2qTEyKmMidc23X2r2bzfcMv0+Meuflv8pYOyfoS9
 Ys/f350J6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmsv07B8PcF1GcW687Pjkk
 1afjxLqNSdojItIo33LrNZ6tab95d12J4mE4kGa6ttjTIq+jMEF1p0OFrFxiRZF5ksvlrDe7v3w
 Wrv3vyR1tf13v/tLqkMfl6y8UT17xWMXYP27WL497An+4Jr/oXvN3S/g9Hj+eep2QH90WIs6GKz
 38Nk+Z1vB5g1ygkHrMdFYxpbN1Bl75/70vsCmZpXm/YTc+s/Mia0+/Y4r4VdbttfPdlqq3Be6as
 /nzTJerX1td1lh/4c6TL7mdO6tdx9wqoblrjcnRaG3326eTjGzPBz3t7BKYXOckNdU/yO3ugnWL
 DdNdNS9mrRNdqn+qRvtGct5CbpkDr42jcw6pb9ZT4t4KAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfX9vIRRJ3QB0YW
 yGfvGa1BRsEU1yUEnVQ3xIZ9MT0EafORf/uSPH2AK9GUxjsAHAqwwEz1ECggLnp2/NiOT11nuEH
 h6OxY0ykZpOdBJnDpdkVbb7JbqHZi1n3NR0EQpS7HMvQKQ/6saztdvMFKyesNMUO/b0ZXDjUKSg
 iG+W43p4XTiz8b2RfD+bCB5VM4HoKD5xDL2pTqD5qveGmDxkkvnsgjc0t5j7YqN4lwKZlO1onzP
 lrNYyRrIf7rpDQXoTYOTPZ8Z25Ct1vvqPGVhO2E/v0X6ymvcp4Yh5Kucn0I5eUnRUwvo+0okZpn
 fv04eJ8Zj5rhQz0bBAj/oLOi21Z5s4Qh2CwB/gQudJ76TPE3mfBbE0UQKzRCRHsrzMHqL+TbUIC
 zaUY9e30p0b+qldggNMXI2mo++AhijlvVtpT8wBu2kurui+0HEuhDMMX8pcfWhh6E0bfp5ipldX
 l5d3CYjrrlF9IaDW6qg==
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=69dcf82f cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=dDwtKCuX-g0vR4_aJEQA:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: Df40nfBOPWxjMrigopYeYtsU1075uktb
X-Proofpoint-ORIG-GUID: Df40nfBOPWxjMrigopYeYtsU1075uktb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
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

Describe Waveshare 12.3-DSI-TOUCH-A panel which allegedly uses HX83102
as a panel controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
index 66404b425af3..7667428bf9a8 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -30,6 +30,8 @@ properties:
           - starry,2082109qfh040022-50e
           # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
           - starry,himax83102-j02
+          # Waveshare 12.3-DSI-TOUCH-A panel
+          - waveshare,12.3-dsi-touch-a
       - const: himax,hx83102
 
   reg:

-- 
2.47.3

