Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325A0EDB7F2
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905AD10E3D2;
	Tue,  7 Apr 2026 10:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jlzVi8cI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dCAQ6VLv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 951DA10E3D2
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 10:46:52 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376nWNe3402362
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 10:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JAlbLe1GjjncBGVwCi12NAldhq0Ds7PE++mMLbJ18So=; b=jlzVi8cIY+L3gtTL
 DXJpAHOnhEWX+hfuRi07G5jwjT4ISNK817KzMXa2ILAWijMQILoldH5XGfknJRSy
 0PfygyUvMQM6ZIe8t1SpQjfnTRH8Q+daenS7SGUHjoifvGe48eJqcZZrxkb7/iRV
 Ty6MKhybCzTR7Bd6GBbzxi3ZXwLpjpgGw/kORQ/hj6rYK+2WhX9IXFawDZsDhVpc
 8n8EGU11y663oMexyflsSt7tRo1FTLcSdDn2xnj22OQueHBVI4PLE559tzsGXkX4
 PRqULxWQUUS7EMEJCDqPzhbqlmQlwrVRZI/Jm4QnR9x6k+2asHWQGlzRXDqOCD0x
 RkqzcQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhtb2k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 10:46:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d6bf346adso75714311cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 03:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775558811; x=1776163611;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JAlbLe1GjjncBGVwCi12NAldhq0Ds7PE++mMLbJ18So=;
 b=dCAQ6VLvP9rCPlgunW+jRHHCANkM//R1AChkioLchOkmUSQiu3tBsn36zKnOzDjeUC
 Ri0/PAg0M558PDBcjkfyezGlaFQxaJOhcOPooXBM4fwyUcejg/qmNcOATHpGG4PdV396
 CP4dbLP2L4aQ65Wj+4Z5jwHYa8GVmCBizLCK8qnc4Q6OmmYKB9Oqn14TG/ouZQaCYeaS
 +Y1ew4DkgD80UNvOkpPCtx/ndO0wKZYxkwGA7yz0228326bZEZ/k9RkA1HexH+f0qBzr
 qaBYKQemALkdsrXVnUYRpw8Tg+l+r4ob7CgA2tCs5r8hwJ2CPGLjd+8fLFaZGfTFMLqf
 TGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775558811; x=1776163611;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAlbLe1GjjncBGVwCi12NAldhq0Ds7PE++mMLbJ18So=;
 b=oOBlDgi4WAOnEuAE0x+exYLJqEHq1PdK6ZCmwq0upsI7r3VGKD6KnctJ3oiDJPo29D
 uzcKemBvNBheB+tRpLOzr6lXIqYopzQSXT0iRM7Q1wr1yfP1ZdphdzWxTF6eWJ+QpeED
 jg3UEFgdUh9snrsu0c14kPtzVLc4MHwEOiUV6eVqNlcxvW5Ce94vtKT35SM32A58dh/T
 CCoSuqv1EXf9muj3CuDFfYeqr5fZ27WMM6M/uZwGENx8Mt1Yq+wloLGb3rp5glstx9Mk
 oKuWtGXqZhUen+EhqDRCiUxpdNQmwCLuuFe2epS9OxvMSyKbdg8t2MFgjXjVPElZItqR
 Jwrg==
X-Gm-Message-State: AOJu0YwJllWFnvZahwJgs1QxnHCd/HRnmFDq3fTwTS7wu0QvDSBOlYXU
 uMNByhgmxl2fH9UgLFtmFtCkhDHC+rTop1me1RuKybiF2kG+Bp/QR7lNcgAjUObyTe1NAf3+FE5
 LIgkQIffNKwjFW6BXFj96qPHFQyzTlPnc0dLZrOGf4rVrqB4uxx8fk+vST2MdiE5a+m1hnRM=
X-Gm-Gg: AeBDievKAsUFZdXr3oQh1Rg5fP9+a0uw8ctYsuRgXIRbWk670QPTtJ/yOsSaB03fBWU
 8SYsZ2V75YB3opeC0DWJjmePaplEBHqz9Kzdm06y1tHGshK//Xv3syk/jQayW+kzrkRRoqv9q5H
 k9679x89r8L3CM/X5rQwD3dHOp5qiLqxGmYh5E8Ld1E4ZkCrwCd9KYNyp6oiU/D+SI6i87O5505
 tKxQHovLEiSHpi9tu+gQ4b3LFgsF0c2jLMI3miGL/d5X9fPdzcQv3t9V75cj8/5yKfPu1K0NQH/
 o2DpHK0A9gC/5Z+NCiuabWg6/Ulua6XWh7KI+8Q4LUEzLsBWivSthV/um6Z9VzYkR+DrJiOI28b
 YMTcIHhsr+Rvyx7f+/bu64yaCa8Q9d59tBDUrRwfY0tcgQm1v
X-Received: by 2002:a05:622a:684d:10b0:509:1a36:6ad9 with SMTP id
 d75a77b69052e-50d629c3819mr185805791cf.30.1775558811147; 
 Tue, 07 Apr 2026 03:46:51 -0700 (PDT)
X-Received: by 2002:a05:622a:684d:10b0:509:1a36:6ad9 with SMTP id
 d75a77b69052e-50d629c3819mr185805421cf.30.1775558810617; 
 Tue, 07 Apr 2026 03:46:50 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e52a0sm47139435f8f.30.2026.04.07.03.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 03:46:49 -0700 (PDT)
Message-ID: <feb13e02-e6f9-4b46-8944-1444999eb478@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 12:46:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] dt-bindings: display/panel: ilitek,ili9881c:
 describe Waveshare panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
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
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-4-5e9119b5a014@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260401-waveshare-dsi-touch-v1-4-5e9119b5a014@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwMCBTYWx0ZWRfX9CXpfOlrC7BZ
 J0fIxReirOSS+gpC+dcELHvtTPvl0Z6o4ypAexv4eoxFTNqcD4kvNtMwocK6vX+tyB/EVZ3kWyy
 yhMC8j2ju+bukJAaoUe4k+hJSy82UNFbxPZBdJPXY+zyaVx7gAjXdaeY9pNOvA9apW/Dy2yppON
 xwJH+++bOuP8XzWoI2wJkj1eF6vjmm5PUoEbsMnz1/ESy+5G51DjtRBl7HAPk/wQuxGFS3PUtWT
 AXU4L1U6Dyo9qja/MzFZIMzO8eqfEfjYjN3BiBcUa34hTB0QkWvg+hvX6KLBxOmxvmGNhcYrRzo
 g70VBy/O0EeCKb5gA2Sr/VVyIBf6oqxXAQFq4+Jm+GwP3iPn9b1gYv3I5aiTc4+z1A5NjP4PSqj
 oSdIaDcn/91f8Ata87UXjIxTKCHRv1/Z4aJwUMuMignq0HI1vnerdKxWN1CseqE2UezOyilhEMk
 NIxZcsoOfxr5hRdZNEQ==
X-Proofpoint-GUID: wMu2U5W-l_VSjbBD422UKzwgZaUyeiH1
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4e09b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=oEhWa5UVeuFdW5Zz-UcA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: wMu2U5W-l_VSjbBD422UKzwgZaUyeiH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070100
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

On 01/04/2026 09:26, Dmitry Baryshkov wrote:
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
> index d979701a00a8..42e35986fbf6 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
> @@ -24,6 +24,7 @@ properties:
>            - raspberrypi,dsi-7inch
>            - startek,kd050hdfia020
>            - tdo,tl050hdv35
> +          - waveshare,7.0-dsi-touch-a
>            - wanchanglong,w552946aaa

One more thing, this looks misplace/unsorted.

Best regards,
Krzysztof

