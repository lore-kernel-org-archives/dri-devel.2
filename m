Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A9ECD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 16:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E0310E80A;
	Mon, 18 May 2026 16:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l37PBrSh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DkYtGwUk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A2310E80A
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:23:30 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IG73a82091132
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=gyj20zFPQU0YdpUQ3SEBwQ7T
 +Hy4BwpnqNdcqHAgNN4=; b=l37PBrShjS/DftgrLAos7X9eXE0g7oM0XSWc+ijq
 ShHRDXQmEQbtv+4yvYBK0Nff+8PvYOtf8bBzEht1ptdcrfJ92hkUsJ7EN3sbg3IW
 0eZK/oUjUWpbPUgTa0PSEnxVcH+d7F1OTh6oGqi/2JXh8sSF9dqWUtBrak8O8dq+
 J0Wjma729XVBOzE07bVZ3Gyv8U0lSoRtVll6h1gg59fpGl7EIIlEV+2DFQSpMBLW
 JTRhrj8aJm5r2WEk+VQJS+MPqe1tJHdaACzj4+e8wyIeY3TBLyyYR4aVLmrE1LWa
 IDCUhfwqvmqIOxkwucEr8i9M+4PSxJV/lekhFvKRNLVf+g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e80rphg1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:23:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50faf575af4so72069761cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779121409; x=1779726209;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gyj20zFPQU0YdpUQ3SEBwQ7T+Hy4BwpnqNdcqHAgNN4=;
 b=DkYtGwUkt3W/5981LyuIri/O1B5P2FL357DVw+XAn6GhX47G1HoUMgOByFwwcMbfQM
 mc61Zbe5nN1B7OXxq6+f+KctBFJC6X45zSK8EghJYpmoAqD/jHTh9bA4nOvfVQEq0r6N
 st0xhnPY9sgz45uNhxuh5bVr2ubnL1VFIonmdGvc7IbPpmJ6vJdt6U7iEKYlZW1UbBGw
 ARCTrcMY/uR3C575cVjRMlfap6Wt1WD3UZdlr0o/6pw8syRDndzDQOCsXH1r1ooP78hP
 zarRwysKXNY4Z4aye6j7EtR593EyAHOqGV85KKNdK+s3q26ubYTiOhCYLWDbb8A7N2QX
 TWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779121409; x=1779726209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyj20zFPQU0YdpUQ3SEBwQ7T+Hy4BwpnqNdcqHAgNN4=;
 b=lariMSdySWnvpMMDiYNlUuFBs0dwl5JvcexkN76Bbr99HdcU8A+gVyRd6sIC89wooX
 WJySKJVEZP2s/K6DWPcbzfNj3R/Avu6GGMZN18hb9TuNBdrjpSvy7nGZI+0Nbme2aUck
 TB/K71xWsLgmJGGUWNoIuB/W++bo2XdOJ1m1b88e03d6Mqe7Eg6qOG/bkic1Fv+XCXms
 io9Ju8f61NIKQf7jD1ReSNLrWroaL5u7pmmOJk8umW2mTc6HdNLJJrqxcXbtPLaDou12
 GkKt0ooZOwv3wsECLa5SSJqb0d4EOfVyWyP49PhHn4fn9XBF5EfF4Ly2qerwuh8/ZAIx
 YbbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9G6iYH8GaVZTv6fiwcF9U/o5r60riDdaP4MPvJAWb4x6cQdRzEoa3U/hJbTXwbBrVlW7FJMfVzZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yylcahq6WhXEEPtybkVaZfqCIPJWOlW/AGRI03nOwWUDB95JxCi
 R8Zz2jnFEX3ypl0qJk0Gvu3rabgOHtHPxK2UtrW+iVCVdbobsAfKqHM10bUvkdE8JG9NwtvpIOn
 gFDVifOQoNq2/xwD6fnxhiP7D3obHzRQugj/Do8MyYE4XjN3eCWrcsqYy57joh5M9YC4z5Ds=
X-Gm-Gg: Acq92OFXZeoMCyUd8PU7Zx9+9AZiw+p7K3548vVpgo/sMQ5eqK/cU7U/RVkRyQ0vX7d
 kYhiC9xpXoNELOFw2s9tmnhHw00MTDhOpuB6Bq/f58wcyQyKXfapGCsJ900QO/+gEPo3T7LsLxc
 jxsAIByqVHQx0EUNSSkLK5QyXw3dWtKcBVC3kk1J4sgPF/TcNxhtee3RaaQYvBiqvHIjEkbMHl0
 7ESUr7ndq/5C8WQ79cEI32tbYHuEQo6vW/Dd1E1YN45eU0LggP9SDYIXIWl0nnnxRL6Y05DfmvG
 0Y6dCQ8PdzCy265b89VMDu6oKTUeTezmXZDcBp8+iJ/vD/RngqMuabKyl2LZxS/KAry85lAQqJh
 Zk/Tl0PzpAf74YtriGJjdbV3QEUoWNgiSku1ftU+hrGc1LUyN2/aorSeO0oMKX+DvJA7H8EX1BT
 y0+r8scPEoFPap0C5D6ai7WjpFdpBLeB1Drf/8UHXMb+2E3g==
X-Received: by 2002:a05:622a:2614:b0:50f:bb54:d3d2 with SMTP id
 d75a77b69052e-5165a22f4admr198883901cf.51.1779121409070; 
 Mon, 18 May 2026 09:23:29 -0700 (PDT)
X-Received: by 2002:a05:622a:2614:b0:50f:bb54:d3d2 with SMTP id
 d75a77b69052e-5165a22f4admr198883411cf.51.1779121408560; 
 Mon, 18 May 2026 09:23:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc12asm3425637e87.42.2026.05.18.09.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:23:27 -0700 (PDT)
Date: Mon, 18 May 2026 19:23:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arpit Saini <arpit.saini@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Ayushi Makhija <ayushi.makhija@oss.qualcomm.com>,
 quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ILI7807S
 panel controller
Message-ID: <ss3deh6wb4bjasig2r56bhl6opygpkid2ixztzdsegqgayuvdk@vgy4ytjzyife>
References: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>
 <20260518-ili7807s-panel-v1-1-d7b048163b1c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-ili7807s-panel-v1-1-d7b048163b1c@oss.qualcomm.com>
X-Proofpoint-GUID: n4k5e7LHsTOMseFeWR4RUhYwv-MTgcgV
X-Proofpoint-ORIG-GUID: n4k5e7LHsTOMseFeWR4RUhYwv-MTgcgV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2MCBTYWx0ZWRfX51oY08G+2Gq/
 zWt/rANBGLzPyDGOxYz8KARtdCCWHhlJsj5alDXGQ5z5G4StvpEZkohGTuB6TJ57acMbFoUW6sw
 nHC3vs7ZiI6Nb2KaTX9eodsIpPBgceazOenYs768JdBRwr5OhCXhb7aAehWEUNUjCVMvNBDeaBG
 1EpxVLqW4XFun58iQs3UFDx8dzSVLTcgiurTAjslR76S1xfHDiVxLm8heDju5u2eWj0u4ks/sG9
 Un37ugORAwumDrLc0LrIlBJFabZPWh//iENBxndRbnY7zFQdC0K61l0nb52nKJHAJDNePNg0ZZA
 ZbKErNmCsLM16wlQwSCLiH5zl7sD5iNHB6fkiw62dvCOffHHcDSmN96DKabypnP33OJ0W78NiGq
 5wTjbRZPFx871ItYABi05N3GOoBc5jxk4jKELXDPpYINTo7UIyrfHTrAIH23OG+JRds5Gx9deYB
 NsQ/DzZbvlG6PXhFxhw==
X-Authority-Analysis: v=2.4 cv=ecMNubEH c=1 sm=1 tr=0 ts=6a0b3d01 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=tXmTSpkHiUSfUerXbTcA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180160
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

On Mon, May 18, 2026 at 04:34:12PM +0530, Arpit Saini wrote:
> ILI7807S is a DSI display controller used to drive MIPI-DSI panels.
> The DLC DLC0697 1080x1920 LCD panel is based on this controller.
> 
> The panel requires a reset GPIO, backlight enable GPIO, I/O voltage
> supply (vddi), positive LCD bias supply (avdd) and negative LCD bias
> supply (avee). The panel operates in video burst mode with four data
> lanes using RGB888 pixel format.
> 
> Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
> ---
>  .../bindings/display/panel/ilitek,ili7807s.yaml    | 80 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
> new file mode 100644
> index 000000000000..93c511d03c00
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/ilitek,ili7807s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ilitek ILI7807S-based DSI panels
> +
> +maintainers:
> +  - Arpit Saini <arpit.saini@oss.qualcomm.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - dlc,dlc0697
> +      - const: ilitek,ili7807s
> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  reset-gpios: true
> +
> +  backlight-en-gpios:
> +    description: Backlight enable GPIO (active high)

Is this actual GPIO or the GPIO-controlled supply?

> +
> +  vddi-supply:
> +    description: I/O voltage supply (1.8V)
> +
> +  avdd-supply:
> +    description: Positive LCD bias supply (AVDD), typically +5.5V
> +      (range 4.5V to 6.3V)
> +
> +  avee-supply:
> +    description: Negative LCD bias supply (AVEE), typically -5.5V
> +      (range -6.3V to -4.5V)
> +

-- 
With best wishes
Dmitry
