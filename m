Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7906BCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 12:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C6210E5B4;
	Wed, 20 May 2026 12:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xf1JjL31";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N+GcanYg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D0710E5B4
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:41:12 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7ApF22984433
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LwsVm+YOh5jnyc4/SA6T4mh8Ap3/phALbTKY3f+nmlg=; b=Xf1JjL31MWue/lap
 J3Ws9trMgWZt8XbPO78iNZlRqn26iOEER487KxS7KsamPJydejXjubIlKlZiPyj5
 d6NnTouIhl6dqnjJvpfhzyZ8Bi7YKEdMzq0DGRahBXKs/P/voFpazjMzKP53enGX
 a9F7MVs8jQ5jIAH24T1u97eqWQ9JjEFdD5xmondmAs4b9Ye4iYajUL2KG3RU03IP
 f4Na1mFim2YJPTgGAVwlcil36Kw7xqx27Py6sGKvjYYAlyqjl9bH0YuytO6aeIVv
 ioOdnXx43qvfl9liAQJWlSQWJL6iquvj4VjjZlJE+zyLbPSfgSutCzdSUyQ3oLhX
 ju0daw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t4tp7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:41:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-365fc4636bbso10533319a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 05:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779280871; x=1779885671;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LwsVm+YOh5jnyc4/SA6T4mh8Ap3/phALbTKY3f+nmlg=;
 b=N+GcanYglTJY0hCmHG9SR/FZnUd1tEqzJurpB6TJdlmFvyhTwNTYoY0S3upN3pUlNz
 eHAkXaB4xJYcGAoDzHSw8fqXMBC5OEJGiW4stutZz+cykXnfHi8QMXKUMu7SvI9M2Te6
 3x0m4nbVlHcIsajM3eu4o/+NK10qdmA94s4YPa+GzNhAHJvuopuj4ZsRgorZMpbcEiR2
 0z1PLXISgBuzMzpMC0qn4dSJroTSl1d2oLsN63efwWW39CUj0bV1k+3rOuRXfGWv6Je2
 fvpR+5hJ54oEwDDyOFrghepiAvtVaqLom3FStyQpB4mXypGrhVFoz6UYexy1hw8Nc7Nf
 tqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779280871; x=1779885671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LwsVm+YOh5jnyc4/SA6T4mh8Ap3/phALbTKY3f+nmlg=;
 b=M3I8+Yfb44Pp5h9ZizQ/Pyu5ImkNRNuMbAZ/vOGg1gRfT84dZ3Jgal/wn/4naTQCl9
 Dn43kaHyFTjWmK4Cg5bHV+saAAAX5V31qBK99/myvQfTcb4yYviGTFGqbUg1n/f39tBx
 cGYWEroRwtcTqdyXw9UNky3EKqUViUBWwD7qqvMKR6hSgVEJKUxegZ5AMC45wNfU36wK
 /AtS24paKqi6ZDoSX1ga5MUyieB+JROmNZurv/9kC8iUDqHf5VWp4LPAFVQDp02/VUB0
 WIDT+0h+0WEgoPVwXY/PlkVu1O4/ijN/MTo+/PmojaHTGgM/RNMV5p1V5RAcAbG4JxOo
 cNZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9COQRKvbeyX4+yXED0pjLp8iR2DS3nZ/kBr6JaPQkqOvSOwmb8yFP+B31uf6VX3phlsfX+PNhZlaU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyR7oVQKiaIPCcXozuKlz99Xhznd9Vaw49CFTn61kaIdn54frNq
 SNTTirED1JhD7TWwzieP5cmb7Ajro9ctNOI6+DmCj25Byi3FSr4EFH4ZvT7WZNxBX5zHq50Uv4b
 zZRgh5RwRJ2zQtgI96np38BqA105Rarf3bwPuWUk4V7qnbwDCA7w1PWXNAbMsLLPgh+xBsZE=
X-Gm-Gg: Acq92OGH2IoW7v/54DUj5A6GwQmPdSIJKn6ZurbowbmiZHvZ9U9sPOGfgzgabiv4rqE
 FYnAMWunZlsyKATbyHd7j9D/uAIHmpf3Y7BF6YHn1h+0femfZvR/cfDPHfS6cLqpMniXbHkXPE3
 qjQv7CkLKLKAjGn9j8U9rrU0mf1uRCCCtqct53xvCfFskguehv54r3Ia93YBYcO4115l8+uKZrx
 CYp1KTkHBefav2lc3CAQ20QoZdkZ7SwnNaOGC3B+9gVgc2gTtgCi8lcLj9OmG+9Hq+DaWe8L7u3
 zKQ88fJJT+BKwsbQnKzuM060y+W3eVGza7jkX+iwqnzCRu8yWb/kf/Psn24Ej6CDADOtI2dRKaC
 yA+F3B/A4s+WR/StOt06RT95Sz2GcHetd2y6Mt87jMQ/aM488chA=
X-Received: by 2002:a17:90a:51e6:b0:369:932a:2b6d with SMTP id
 98e67ed59e1d1-369932a2fa4mr10930265a91.6.1779280870555; 
 Wed, 20 May 2026 05:41:10 -0700 (PDT)
X-Received: by 2002:a17:90a:51e6:b0:369:932a:2b6d with SMTP id
 98e67ed59e1d1-369932a2fa4mr10930248a91.6.1779280869950; 
 Wed, 20 May 2026 05:41:09 -0700 (PDT)
Received: from [10.206.100.243] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36968dae27bsm15522213a91.1.2026.05.20.05.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 05:41:09 -0700 (PDT)
Message-ID: <dd065ccd-d7cb-45b5-8733-64b4f6571b3d@oss.qualcomm.com>
Date: Wed, 20 May 2026 18:10:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ILI7807S
 panel controller
To: Krzysztof Kozlowski <krzk@kernel.org>, dmitry.baryshkov@oss.qualcomm.com
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
 Ayushi Makhija <ayushi.makhija@oss.qualcomm.com>, rajeevny@qti.qualcomm.com
References: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>
 <20260518-ili7807s-panel-v1-1-d7b048163b1c@oss.qualcomm.com>
 <20260519-curly-courageous-sturgeon-2facfe@quoll>
Content-Language: en-US
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
In-Reply-To: <20260519-curly-courageous-sturgeon-2facfe@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BOCDalQG c=1 sm=1 tr=0 ts=6a0dabe7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=ERuXJlKj0EQyFFk6GMsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: cV412Y9Nc6O8BhLbeGjKR4ndIFMwAxez
X-Proofpoint-GUID: cV412Y9Nc6O8BhLbeGjKR4ndIFMwAxez
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMiBTYWx0ZWRfXxw2j+tab0PzM
 NuL7JpF15xcTzpPKAQXsvKmx8rUrKsaTzXG98+Wr2Qhm8Tmu43HCAqBWXvJigEE6NEXlxz4/4Jr
 T7IngfQtBRme9MKYCE/VeuHLPd+M1NluPq/yGbR0jxoryaB0NjNqpZvB9t9CBfx1jhoWN+A8Qr8
 PW/Iq6G3xx8xXt3Dj5ZWFgmyRR69O1SY0pmbx8uRNz+JYh4i8Fr1uVfdf0rFu+VXWVDIruhALl7
 uqQV+Txb0Bdt52y+d+Hs1ncKz3QYqpVqa1hmZwxNut7bR8zih56DMlucR8oZA7NiY5I3Kp/U+fS
 liUJdUuNs4viN+XZOASmxMMI/EPKRNZYwZORL4c9a8uHCn5DaTcQq6WnzIpmREblDK1rsSkROCX
 WSJMb3W9NtMEtS36ph5LYP33wfAjJW+AmQeFmqWyGx3dp3MpFh3mndwcEdWwjlwtfDM63ctDoQ1
 D3nSHxjGosM8I1nBo9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200122
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

Hi Krzysztof , Dmitry

On 5/19/2026 4:02 PM, Krzysztof Kozlowski wrote:
> On Mon, May 18, 2026 at 04:34:12PM +0530, Arpit Saini wrote:
>> ILI7807S is a DSI display controller used to drive MIPI-DSI panels.
>> The DLC DLC0697 1080x1920 LCD panel is based on this controller.
>>
>> The panel requires a reset GPIO, backlight enable GPIO, I/O voltage
> 
> If panel requires it, so should the binding.
> 
Ack, I will update.
> ...
> 
>> +  reg:
>> +    maxItems: 1
>> +    description: DSI virtual channel
>> +
>> +  reset-gpios: true
>> +
>> +  backlight-en-gpios:
>> +    description: Backlight enable GPIO (active high)
> 
> What is the name of the pin in ili7807s device?
> 
Display daughter card has WLED driver as well as LCD bias driver.

The WLED driver's Enable is coming from WLED_P1_EN and PWM is coming 
from LCD_CABC output of the panel.

DISPLAY0_BACKLIGHT_ENABLE (GPIO 91) of ITP baseband card ==> WLED_P1_EN 
of Display Daughter Card (DC)

In the display daughter card of Shikra ITP platform, we are not using 
the external PWM for WLED driver. But connected the CABC output of the 
panel to the WLED driver. Backlight update is happening using MIPI DCS 
command which is driving the CABC output (i.e., PWM for WLED).

Because of above HW configuration, we need to enable the MIPI DCS 
brightness update on this panel. The below command of 
dlc0697_init_sequence() is enabling this.
mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x24);


After checking this, I realized that this panel can be used without the 
DCS backlight as well when it's using PWM based backlight control.

I can add `has_dcs_backlight`  in panel_desc and set it true for 
dlc0697. I will update bindings and add backlight as optional property.

Currently "backlight-en" as optional. I will fix the commit text as 
Krzysztof pointed out and update the commit text to get add more clarity.

please let me know if you have any comments.
>> +
>> +  vddi-supply:
>> +    description: I/O voltage supply (1.8V)
>> +
>> +  avdd-supply:
>> +    description: Positive LCD bias supply (AVDD), typically +5.5V
>> +      (range 4.5V to 6.3V)
>> +
>> +  avee-supply:
>> +    description: Negative LCD bias supply (AVEE), typically -5.5V
>> +      (range -6.3V to -4.5V)
>> +
>> +  port: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reset-gpios
>> +  - vddi-supply
>> +  - avdd-supply
>> +  - avee-supply
>> +  - port
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    dsi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        panel@0 {
>> +            compatible = "dlc,dlc0697", "ilitek,ili7807s";
>> +            reg = <0>;
>> +
>> +            reset-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
>> +            backlight-en-gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
>> +
>> +            vddi-supply = <&pm4125_l15>;
>> +            avdd-supply = <&avdd>;
>> +            avee-supply = <&avee>;
>> +
>> +            port {
>> +                panel_in: endpoint {
>> +                    remote-endpoint = <&dsi0_out>;
>> +                };
>> +            };
>> +        };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 26060e51c067..529aed669401 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7941,6 +7941,13 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
>>   F:	drivers/gpu/drm/bridge/chipone-icn6211.c
>>   
>> +DRM DRIVER FOR ILITEK ILI7807S DSI PANEL
>> +M:	Arpit Saini <arpit.saini@oss.qualcomm.com>
>> +S:	Maintained
>> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> 
> Drop, unless you handle patches for this driver.
Ack, I will update.
> 
>> +F:	Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
>> +F:	drivers/gpu/drm/panel/panel-ilitek-ili7807s.c
> 
> Drop, no such file at this point.
Ack, I will update.
> 
> Best regards,
> Krzysztof
> 

