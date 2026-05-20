Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC73CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 12:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2CC10E10E;
	Wed, 20 May 2026 12:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MLRhJku1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dF7qy3ZC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9805C10E10E
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:54:29 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9lsju267212
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +Dzs5PVghvmsHfh8+8zkBuOfRJJDmi8DS3v15nIcsg0=; b=MLRhJku1aJ3gq/oY
 mweYadyyR9zL/KTChTJ8P4QqqYv26Lvy6gpYAsML+RcW07POBE5pf9v/FQ7+cP4d
 SRn1BTNRxQy/GqsprlElfn7YLXhsuO+seP0KVIqMQ1kp2CmCibVQc3VGm37oYuny
 TSkE45EUT3FqKaUXS9zHTgLRORRipipk+S14Tz/hRhxcX5+A5yNLhc41J5ovh99g
 haXOKi4LGf9I2db+OpMES+nrRpQ5jpS9/ONAP0289OaLuaKzFyruUM0YGlrbWT9N
 Ji40TEFn1jIvxs5yOrs6mXyt2tihN567lTPiSH0wFOJqm/DN4yUh+X1tbQlXvpUC
 aCn9xw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9amxrn6a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:54:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c827c880e39so2385508a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779281668; x=1779886468;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Dzs5PVghvmsHfh8+8zkBuOfRJJDmi8DS3v15nIcsg0=;
 b=dF7qy3ZC/MhWGfISLfsTlQlKiPYs7885WwtwqNh8IT+BFdHDQT7FTJZgLhore0L6Qk
 pWTbXV4eclduNgKt0kJiwBgCyk9Pmx8yOoFtMKRc/M+pSGOovqzAWXYtXOQJIIVYi1Q8
 WrfbnlyYOqgdBFkBxn8k3AFlJ4vLNtQd9AXqMX565SROIkzQpt9wVk78xtiNv3OvjMyW
 P70HjZCVZcpTQlHD2TFy71xlyUmuB9lmtsWy6V5rP0y7BN54Im3ZO+ceSBNX9iqCUh7I
 Tkiv+OyLUlAqab6CI98G8wHUupSYZ6SPj50IK6K9TrTDXY55HoA8p+yzZk2ajIC+iO2M
 zhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779281668; x=1779886468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Dzs5PVghvmsHfh8+8zkBuOfRJJDmi8DS3v15nIcsg0=;
 b=EE+Tdk/9tHm3pLDa5anQg49H+zJh7Nc7mwduLShlbPbjkIQl3bo+6dL+d5qAo3Ndni
 HgBUvfiiUkLj5dN6Jczg9gEtrHpDfBY6Do/nupXLKTFQUak21X/qo/DuQlIHbXEimeoO
 HkpuzuMCd1MlktHHh5NYbPZ71n68f3RbipwsLvgltLATkoOUJPqElriyh0wUeV2cR5Bi
 571o/dML23a63EUs63H1hREQ4luusSIAxT4TVFWyFkFtAk6BfZDAmQuC2gNZDQw3u9uU
 /Taa1I3XR/pnkYG5i0KkgqpRM6pWtYh6q/8YZ+YiG/a/FRVbsScfb0LAWVRcH3VjLfjq
 RV9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jigJjQNpTsotyB8MCid2x5V/jYidaEbeLSaEhI/rQ9kIA2S2HVPTI5gJW+qbu2ZQu7090aGSrUiM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKWt1K6aX8mj+0vDYIZCOuU2yn+FEGwFSLvh210IvkSLQARX/D
 6XrHWiWAqBZSuHWgjpW6WVX4M2ATneFHh4gu4B4rrW6pORTivQMCO53yEXY/29tOSKFvJjwTXk7
 PR+DODI4Ig7sVJjJhEsEutXuSauJsfdF8HtoOU7Nv3ep26T52E1ftCLxhw6URlx7yMr73Wwk=
X-Gm-Gg: Acq92OFlami0Fi5FpwTjrHSN7axCXi2zkMLOhElk1yrwUcHS5LFSgr1ftwSsk6ssQRf
 J98ifrWbsZGbFO+d6piBuZbAaHwrSKerrT7SC1L13uqOxWFY9dzy7tEnJnGSGP2i4Kh2TOTpdKw
 ZttEUmxJU8s6jDnP0DTHeFar6Sh7C/KVqpmfSBdri3FhukdRdf0PLAIpBkkJGvD/dzjYV+IdW7M
 sD33ewAXUD9U/5ahMDDKzaMVmFRSZlSuMGXyuAZUCWGKPbgqaJp0z1O7PEbsmbQLAzlQJoYFPHW
 L7zxF1fxMg+OwrqwWVCTHjL4bvC1LhAzaI2q7Lg99nFltvjRiRQ+q3JZSObfUd2/yYCpZIddgnl
 0+3Jk4M3S6iS1USbpHd+R41YgomUfwKwY+kE0Lpig9HPgObDzo+o=
X-Received: by 2002:a05:6a00:4508:b0:82f:3436:42d7 with SMTP id
 d2e1a72fcca58-83f33bcc799mr24430003b3a.2.1779281667713; 
 Wed, 20 May 2026 05:54:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:4508:b0:82f:3436:42d7 with SMTP id
 d2e1a72fcca58-83f33bcc799mr24429973b3a.2.1779281667121; 
 Wed, 20 May 2026 05:54:27 -0700 (PDT)
Received: from [10.206.100.243] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19664a59sm21472794b3a.1.2026.05.20.05.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 05:54:26 -0700 (PDT)
Message-ID: <1ebc7c8a-b0de-4f25-b4dd-571909f9c67b@oss.qualcomm.com>
Date: Wed, 20 May 2026 18:24:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ILI7807S
 panel controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
References: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>
 <20260518-ili7807s-panel-v1-1-d7b048163b1c@oss.qualcomm.com>
 <ss3deh6wb4bjasig2r56bhl6opygpkid2ixztzdsegqgayuvdk@vgy4ytjzyife>
Content-Language: en-US
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
In-Reply-To: <ss3deh6wb4bjasig2r56bhl6opygpkid2ixztzdsegqgayuvdk@vgy4ytjzyife>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0NBk7mHe2aZSZ-47uJugbZZ8_eYtCsfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyNSBTYWx0ZWRfX9/VJ5/bequd4
 5Ho9hWsHMGuhJDjOhs6Lb56emVaEZkmna4jLUFdFZy0lC/lXIXw/ggXzBPpu2OBok7b3aRBQydL
 PII2PoYyv0Yi18OnIwhNtkdeR3rpPKULSs0svuogo6quW5rNjv9nfgsDZ86rv9SHN/d8ymXvI2m
 LbU7FtZjNn+C/HXJmhXSD1UnWVope+xwE/W4vdX3OjLrCcB97NX5lqeJrivJzSgS2bRlxWh//i3
 nALFtFc+3ijHn46mZy7Y1tfVcU/cyTBdwfbkyvOtXAEuTkagEgYhiRsyqGNQnVwS+0mAzvsxwTs
 BcqPfpghv76HjHr5TLo0GyXyicndegdRybzuFeC8WK8BENlesRcc9+a/aUzvuwib4uaKBrHmZbS
 fkQI8WzqBA1aTPaAZsDw+ybMDQMLeIDKdE9G0yrCOfQflbHcaSBthT50IgVlmPiKEKYA15FjHZv
 W4ilrwZen9TbghHgvkA==
X-Authority-Analysis: v=2.4 cv=TO11jVla c=1 sm=1 tr=0 ts=6a0daf04 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6rjBTs_pIWsmsDHkzHgA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 0NBk7mHe2aZSZ-47uJugbZZ8_eYtCsfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200125
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

Hi Dmitry,

On 5/18/2026 9:53 PM, Dmitry Baryshkov wrote:
> On Mon, May 18, 2026 at 04:34:12PM +0530, Arpit Saini wrote:
>> ILI7807S is a DSI display controller used to drive MIPI-DSI panels.
>> The DLC DLC0697 1080x1920 LCD panel is based on this controller.
>>
>> The panel requires a reset GPIO, backlight enable GPIO, I/O voltage
>> supply (vddi), positive LCD bias supply (avdd) and negative LCD bias
>> supply (avee). The panel operates in video burst mode with four data
>> lanes using RGB888 pixel format.
>>
>> Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
>> ---
>>   .../bindings/display/panel/ilitek,ili7807s.yaml    | 80 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  7 ++
>>   2 files changed, 87 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
>> new file mode 100644
>> index 000000000000..93c511d03c00
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
>> @@ -0,0 +1,80 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/ilitek,ili7807s.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Ilitek ILI7807S-based DSI panels
>> +
>> +maintainers:
>> +  - Arpit Saini <arpit.saini@oss.qualcomm.com>
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - dlc,dlc0697
>> +      - const: ilitek,ili7807s
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: DSI virtual channel
>> +
>> +  reset-gpios: true
>> +
>> +  backlight-en-gpios:
>> +    description: Backlight enable GPIO (active high)
> 
> Is this actual GPIO or the GPIO-controlled supply?
> 
Addressed here 
https://lore.kernel.org/all/dd065ccd-d7cb-45b5-8733-64b4f6571b3d@oss.qualcomm.com/

Thanks
Arpit


