Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A2ACCF2C4
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 18:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B94210E487;
	Sat, 17 Oct 2026 18:28:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058DC10E2BE
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 18:27:53 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69HGA2nh2032723
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 18:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TWAITbXImCrceylO+fgL/eY57Gn/QhiyUD22+hfZyv4=; b=M7vIx7ExWc2o9pye
 eKt3CsFs+ybnp136gJqilL9M5ENLqK7yXZe0SOUo+HPzzeumIulM/6YzUdNCXNsf
 kMKSzA46ai9cVzgozIJsRV/Nz4mC8PJn+J9ogeLM2DILya7M1GMKx0pJoWRBJw00
 e2/2IDHP0fzvxjUH00iAWw3ZU0P6auD/60tx1H+oDjSC4xZwjzunJLBAfIxIH/QX
 4hv0d5zcnW3KnNg2hp1zk+REOwBAV3xIGq9G96XFHaLT1McjYsfQXBbEjSX9S7pz
 m8cuxCZ0AdJDgPXNv3f0Ng8y4vmzyhWP0jl9LngZ3Wmi2pG1RPoep3GTwNLWt5BS
 MwyaUw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc0kxhj7y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 18:27:52 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1665200f4c2so1218715c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792261672; x=1792866472;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TWAITbXImCrceylO+fgL/eY57Gn/QhiyUD22+hfZyv4=;
 b=Qca46mXxjnppcwn9hMoaIO/0HSeqjIeo8WJpBcsP32d3zRO3/YgWuVxFi45WhwtERc
 uBVdFZ7wrgGa64JRf842kV9SR4vQUttjm3M3BvZedPYuZ1+nWUdFzFk+7PrUM9xpIxP3
 vY7jspN6CvTPCfuwEwLigPktNQ4rKka5rBBk7jXIQ9lljXiJEjDAcFPq1I/lSCK/VEz+
 +FGCpeSbhDz4vCEDLwexSkIspGCxkuxLbsez6DyPBrcMSilNkNTS3bJH3eDNP3P2JahB
 UNzMyiRgfhDBBtmKotMN7qOwGemV9Z2tGkGf0uPgjxhR+z2E5Oyu2+0irRRHyeese+CM
 aGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792261672; x=1792866472;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TWAITbXImCrceylO+fgL/eY57Gn/QhiyUD22+hfZyv4=;
 b=MRWxbFB2bT9w6f7wgr34Hg5LR+HU2c6ok5/VX2VZKjnnV6pinqMgwycPxjjLR1i4Tm
 AHN3YhMaWvANLGR4RTVn4Oc2hsoexpxOSNrovqjMYbT7TV/BNsEssyKKBKvIzQ4NXhEe
 s3Qi7WPBL6tECnSfSrYBUdvu/tw0TWXFSgnWLXHUHpTWEauw7PRwIqh1dQBo+fueCd4l
 uYeqwHXpuOzppPEdKvRgSfBn17lRR2nz2f8NmKqfkrWZMVyKGl4s29qMrJrZwgjfBiri
 j8GYTHGL8hjZkRTO6JyXjwyGu0DI0GhFrPJPXQCOpHRefIfRynTc462mBk1ZVx9h4Lhx
 vC9A==
X-Forwarded-Encrypted: i=1;
 AKwUvByBTbpPPCcQ5Jw60li75YbY00BM344fZr4zNvZYjuaTADQFfU+rd6hEoyf/kMvIJqTaFw8nrP+QW88=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJhgM2nsJD1pjG1T7IVbwiUPdCjK91TdMmXENEQYQy1JiDJeLCI
 IE49WTdOF2NIHq8Jo/bB6UkOTpAIGSx1MtqA8U1e1fqU/9fFhz4jn8RQdEKmRhhXf12L0/DdzrN
 GcnPikWhKG8p0f8vXKJRGxabb6q98TU0vaFO6oVr/FxY8EN334RjTfYLPPmSPj/ZCZojQlac=
X-Gm-Gg: AYBFou02fhB5IN6Q913rjYmfe5MWhb3Ot9aSC8rZGzfCYmk1KReSJHywNp8uyiB7Myb
 ztxd7TchquYIgczxY5tqNi6ZAm9Tru+cJMOC2TU6Yb55A72BF3HDKsBuJ3jL7hSRM6EkLCKPQfX
 BKDNL5KLO9ED5yTUN7qCySr0hyb5ubepR7CGtX3748/6TLBEr2Rvru1/+upImeh5DanBLiNEXGu
 x25mQCY5EEzPF//3FbNombnIc9ftxAoszNs+sDHPkqo4SlecT+jbc4EWn9WVQgJJBJpLnGBlAwd
 HTyk51VwW2tx7x8sao27tqx78hz/2yqm/TKOfi+in9WYd7qTpnM+WKHSshUykiE2aGV4hC5zNgX
 YDR96r5HWPPtiNWw7gn60Zz667Zg=
X-Received: by 2002:a05:7022:3808:b0:14b:588b:c817 with SMTP id
 a92af1059eb24-1850c9d0734mr5109512c88.3.1792261671589; 
 Sat, 17 Oct 2026 11:27:51 -0700 (PDT)
X-Received: by 2002:a05:7022:3808:b0:14b:588b:c817 with SMTP id
 a92af1059eb24-1850c9d0734mr5109477c88.3.1792261671006; 
 Sat, 17 Oct 2026 11:27:51 -0700 (PDT)
Received: from [192.168.1.8] ([122.177.246.33])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75ac0fsm15887787c88.15.2026.10.17.11.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2026 11:27:50 -0700 (PDT)
Message-ID: <494411c7-cf0f-4c43-9716-14fa5dc42a8a@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 23:57:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add optional wled-supply
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 devicetree@vger.kernel.org, rajeevny@qti.qualcomm.com
References: <20260929-wled-supply-series-v1-0-75d0a83b4b00@oss.qualcomm.com>
 <20260929-wled-supply-series-v1-1-75d0a83b4b00@oss.qualcomm.com>
 <20261001-private-wooden-chachalaca-51aa57@quoll>
 <997cefa0-384c-466f-b318-077939946768@kernel.org>
 <cebrka4ya7u32ntiya42yx4txa3uryf5k2di234zm4enz3a6vy@xhily6qqmevo>
 <1cd249d8-0a26-45e4-8263-dd4a120fc89e@oss.qualcomm.com>
 <54da53e6-66db-4357-a00d-da27fb936117@linaro.org>
 <a3f1a0da-039f-43be-89a3-ecb5df28bc1d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a3f1a0da-039f-43be-89a3-ecb5df28bc1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MyBTYWx0ZWRfX1xn7DjS/nvKO
 DUNZGAmRpVVq7SZqJ2xzUu2SR0A/7FHoSCYRE999VTA/ivMAn08adkLlf2S1Q3mWWG4qYmeBIEj
 e6Fr5sG1L5L2Lp2dHDoS1FH+JzNreDI=
X-Authority-Analysis: v=2.4 cv=JpZkP84C c=1 sm=1 tr=0 ts=6ad3be28 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Gy7JURgNfp+0T9DH7I4t3Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=mqesSYQOd7982J3M3jwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MyBTYWx0ZWRfXxRg24RNCGJWr
 BcWDSFNcwZWeoQtXFKxoCCjYtbXjC7rQ2b7iJIQkM/+6eB3m5k1zP3Pz8SdCUAHrmW106jHfzZA
 LEwHK0qJ58M/6QYMNMEojeb4dhPqRZSO3cd5iQidUZsSzcWV90u//zFisD5zLYkEZG602jZbUcZ
 5NyQQnp3EXD/R9UKbAZrqbgSt1ZfpiIPPiQz/M/Yskezq6iiSsLxiH55moHqRw3ziZtOZlOoKEv
 zP0XpvGYdPNsB51s8zpjd+hUpbMFSR5SDq9GbUstarY3pHKputpa8jHXfACzM6dERGLjsAVbXYM
 62un4pE5D6ZXtLlEr8XChCrA4rDxLmkBnUp7RyZbGleIHx3s5q71Gw0aQqBvdOA1UxpCu3ikKyJ
 uT/DkpQiVfop8bO1z482EmrmTWJ1Bs5ztW6Wwm9EKM/oIRxKm4xQs1lRrA1BofpUeYtZuadVaIL
 90R+UH8JxQEfHv61cAg==
X-Proofpoint-ORIG-GUID: LZUowJjTht0zDrMcNV8MlH3obyaRI9jr
X-Proofpoint-GUID: LZUowJjTht0zDrMcNV8MlH3obyaRI9jr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170073
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



On 10/6/2026 7:52 PM, Arpit Saini wrote:
> 
> 
> On 10/2/2026 1:52 PM, Neil Armstrong wrote:
>> On 10/1/26 20:09, Arpit Saini wrote:
>>>
>>>
>>> On 10/1/2026 3:25 PM, Dmitry Baryshkov wrote:
>>>> On Thu, Oct 01, 2026 at 08:57:52AM +0200, Krzysztof Kozlowski wrote:
>>>>> On 01/10/2026 08:55, Krzysztof Kozlowski wrote:
>>>>>> On Tue, Sep 29, 2026 at 06:42:20PM +0530, Arpit Saini wrote:
>>>>>>> Some boards drive the ILI7807S panel's backlight from an external
>>>>>>> WLED driver whose enable input is wired to a GPIO, typically modeled
>>>>>>> as a fixed regulator (e.g. vreg_wled).
>>>>>>
>>>>>> You describe something else. What's fixed regulator should not matter
>>>>>> here. Which pin is it in ILI7807S?
>>>>>>
>>>>>> It seems you just want to represent GPIO with a regulator. This is just
>>>>>> confusing and typical downstream workaround.
>>>>>
>>>>> What's more, you basically REVERT the review YOU RECEIVED in v1. Really,
>>>>> just sneak the same stuff 3 months after like the review never happened.
>>>>>
>>>>> NAK
>>>>
>>>> After discussing this offline with Krzysztof. It's not a supply (my
>>>> fault), it's an LCD driver. So, the best way to handle your displaycard
>>>> seems to add a gpio-backlight, reference it from the panel and then in
>>>> the driver check for the backlight's max_brightness level. If it's 1,
>>>> then you have to send extra DCS commands to control PWM. If it's
>>>> higher, use normal backlight class controls.
>>>>
>>>
>>> Hi Dmitry, Krzysztof
>>>
>>> I have a few clarifying questions regarding the proposed approach. Please let me know if I've misunderstood anything.
>>>      panel_backlight: backlight {
>>>        compatible = "gpio-backlight";
>>>        gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
>>>        default-on;
>>>    };
>>>
>>> 1) Adding gpio-backlight and check for max_brightness level if its 1,
>>>
>>>     If we model LCD_BKLT_EN using gpio-backlight, the backlight device effectively exposes only on/off control (max_brightness = 1),
>>>     we can't support the full range of brightness i.e 0 to 16383 (0x3FFF)
>>>
>>> 2) Adding gpio-backlight and based upon max_brightness level of 1 , are you suggesting to register another
>>>     backlight device that can actually drive DCS brightness. In that case we can actually have the MIPI DCS controlled brightness
>>>
>>>     If so, wouldn't that result in two backlight devices associated with the same panel:
>>>
>>>      gpio-backlight device for enable/disable
>>>      panel backlight device for DCS brightness control
>>>       Is that the expected design?
>>
>> It's a great question because there's a large variety of how backlight is
>> implemented, and some panels can drive a PWM to an actually backlight controller
>> which uses external pwm. In this case we should model the backlight IC as
>> backlight driver with only 1 or 0 capability and use the DCS to program
>> the PWM.
>>
>> So it leads exactly to your issue. So perhaps one way would be to either:
>> - call into the gpio-backlight from the DCS callback, we may need to fix some locking issues
>> - add way to "link" backlight devices so the backlight value can be propagated
>>
>>
>> In any case the problem remains that both backlight devices will be exposed
>> to userspace, which we don't want. So additional changes will be needed.
>>
>>>
>>> 3) I previously tried modeling LCD_BKLT_EN using pinctrl states (panel_bl_en / panel_bl_suspend)
>>>     for the enable GPIO itself. However, Dmitry suggested modeling it as a regulator instead:
>>>
>>>     Link : https://lore.kernel.org/all/qkhgg5x67sijiialucvzac275zhpjrtt47a4udjpyzmgvilut5@dcrslq3ai7mc/
>>>
>>> 4) Modeled optional regulator wled-supply: a regulator that only gates the external backlight driver chip's power/enable,
>>>     with DCS remaining the sole brightness path in this current patch , the panel-himax-hx83121a.c does exactly the same.
>>>         Would this can be the preferred modeling for such panels?
> 
> Hi Neil,
> 
> Could you please help me understand why we cannot model the external WLED enable path similarly to panel-himax-hx83121a.c using an optional bl_supply?
> 
> In our case, this supply would only enable or disable the external WLED driver through LCD_BKLT_EN/GPIO91,
> while the panel’s existing MIPI DCS backlight would continue to control the brightness.
> 
> This approach would also avoid exposing a second backlight device to userspace. Would this be an acceptable way to model the ILI7807S panel?
> 
> Thanks,
> Arpit

Hi Dmitry, Krzysztof, Neil,

Could you please clarify why we cannot model the ILI7807S backlight similarly to the approach used in panel-himax-hx83121a.c?

Reference:
https://lore.kernel.org/all/20260608162622.403713-3-zhengxingda@iscas.ac.cn/

Our hardware has a similar split-control arrangement:

- The panel driver controls brightness through MIPI DCS commands.
- An external WLED driver powers the panel backlight LEDs.
- LCD_BKLT_EN / GPIO91 only enables or disables the external WLED driver.
- No separate backlight device is required for brightness control.

Therefore, could LCD_BKLT_EN be modeled as an optional bl-supply, 
with the panel driver enabling or disabling it while continuing to use DCS for brightness?

This would also avoid exposing a second backlight device to userspace. 

If this approach is not suitable, could you please clarify what differs from the accepted panel-himax-hx83121a.c model,
and advise on the preferred way to represent it ?

Thanks,
Arpit



