Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0671CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 14:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC99910E021;
	Tue,  6 Oct 2026 14:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I2OWmxG8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KknvI86q";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D058310E021
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 14:22:17 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696EBFSU693297
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 14:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 97a5UrakWAv4t3YGKHHug98oReETYUquuDQhepwEIdI=; b=I2OWmxG8O1Rt6zSV
 /eIcwM7Rcf+CyvQpRPiD305IfJe/pKH70ZmxHzDQvNtQ4dNM7fDf3GLJ2I6D980q
 zVGsNgH1+OgEc7i5sBnIV60Pc7dl2p2jV1FZAZ7cdcwRh/hD3CL7JP7aVIvfCB5V
 Lw4KvgKEBdwgiQujLc+GLhQ5e9ybWtTd3kgEALI9b8wFdzcRqXO8pm9ujDJCQsoH
 CbGG0dBJCHMYr4UJQLIhjheX5/6YMseayCfVGvG1npJpRB7fPPAmHaktnxa9AF+M
 9ZK77TFjubwNavBuOA1AszipHGasAxxlR2gN0Em4OfDq1oa1onRsDX7LUBmwE76S
 D06NUA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xdu90y5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 14:22:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8884a02ee85so3075206b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791296535; x=1791901335;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=97a5UrakWAv4t3YGKHHug98oReETYUquuDQhepwEIdI=;
 b=KknvI86qMpV87qY06mwcrh7NpCwjwaiZMZbFqj7HwWTYh45lQ+nlwtCYq1x4YiM+xT
 fUXk6CDvs5rvTOVt+SrgJEPaIOEixiI1y7Pbkt2joQ/y5AIwyFPaMS8X/zx8gBZ8dfGa
 uKddr8jN7ks50u5LMMXsW/A37x+mKjpFkbdBjZbI1nMRKm1AcYdXYhoAQCvkjGJp2zzN
 /XmRKsZxC8cRlHJpx63L2h97JNA4ejTQTJIbyAD6eywus1NmqGOBfCRysmJCuM380G6r
 1+Jw31xZEknbegcHb3bpmIoA8ILl/Ihx0pjRWMLtztpB3Wj3HBg96E0xgTdguUUvWAMu
 nCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791296535; x=1791901335;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=97a5UrakWAv4t3YGKHHug98oReETYUquuDQhepwEIdI=;
 b=0NYYFchZGKVp4JkQnJTtdxbcVMaAHGGsYW2c6sRWOMLL+eG5VxvDpxylnB14c9HHWU
 tdEtAypL67YlAyOVJnwdxWA8uoWe+SkSFmvpXDYQTw5S8r9ehfPT+XJtL/IsqB/5S4H7
 i+egY7Fcwk3kMO5bd2gKCzoQgal8NMwwvPi/acIF6Jb+I/vDcpGfbapoQH/YQ9kjE+Az
 cogOaJs6kDQgWsUkGQtqH+drqIrzQ36uNLl8/OPo/2Yv3NkWFEIr+N/hF4IfpiJpoXiW
 +1+FPVAvkqviNkDk3CfTfOGeEEYBjJ5m6k0S2q5Yeyu/TP+gOlFgphc145lwF2Z+HQcV
 V9qw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAWsDSBqqLpJBfDCX1Szq9AwJuWxsqIayQP4n++tB+pqdl5YfdYBVlIPri6nuYPTSWAgm+QpVbneY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kprY7KN4EWJPWFEXairr3o3nbDEcAoLMwQh1qQspTcKH6Fg//1
 TkEY6sxmatO5lyq77MKbdLj/uNms7cSd5c8tSS02bTYaTJZ3JTZB5CYuv47bPlKN207cMRp8d7N
 LazSEZdBsrsQ39CVqqVP6dxYLVuyHPYBu/i0Etoz7UhI0tF7GXv/7adbV12qWpSV0UPmF06fy39
 uDpb4=
X-Gm-Gg: AYBFou2UmpGQ4AoDULnacF4yubYOMRXKlKb6NPYMb2RPbBZ06tqfzvQrsH097mjzyMc
 80V3HWwgbpLYd7PjmAcGk135NtnjCC88IrN/mtadYVhBx1shFdRX1WGRQEvowb8OdtZlPZpoKj/
 TX1Ni4WNaJRExNUo3dA/Sfq/dG3NcaZaNzLflZZSIw19wwkXCoR6xF49zrVQgGyDpavq8V0Tyu+
 9KP/vFTz6Hmb2Y92N9NAtbYJWQ8elzjFL0VwavOx9AKYRmTw6Rk7Kuvq1xa3Y39gln3H7ZVZTet
 IRBSRneEA37lnOMVnJOzQfJhUN0wTCUjsa6/zx5RgxWvn4i5Ld+ebvq6BChlQ+cbDu5yNUBfMwH
 xUQglCRIKpoR3aeTyUONaIqCREmo=
X-Received: by 2002:a05:6a00:2e07:b0:886:9eb2:a9aa with SMTP id
 d2e1a72fcca58-890dbb8c48emr1339033b3a.6.1791296535288; 
 Tue, 06 Oct 2026 07:22:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e07:b0:886:9eb2:a9aa with SMTP id
 d2e1a72fcca58-890dbb8c48emr1338997b3a.6.1791296534698; 
 Tue, 06 Oct 2026 07:22:14 -0700 (PDT)
Received: from [10.206.96.212] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88b0968b995sm5077532b3a.4.2026.10.06.07.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 07:22:14 -0700 (PDT)
Message-ID: <a3f1a0da-039f-43be-89a3-ecb5df28bc1d@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 19:52:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add optional wled-supply
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
Content-Language: en-US
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
In-Reply-To: <54da53e6-66db-4357-a00d-da27fb936117@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NyBTYWx0ZWRfX1hkFL3kknKiI
 WVKc2xM+GyJioEGr/FpW9AsKW9HWZB8x1FIWIYRR3xcvlESUQPGbrWvk8wd/opjd86FOW9r4IWB
 aPxbur6Op1UtlRBp+nxT/dbtWORHcsY=
X-Authority-Analysis: v=2.4 cv=NshE4MdJ c=1 sm=1 tr=0 ts=6ac50418 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oPQ4ZL9H7VA3A5lk3HYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: JHyJnrAL1nUcsGLW5-2MTAS19B_oOBMS
X-Proofpoint-ORIG-GUID: JHyJnrAL1nUcsGLW5-2MTAS19B_oOBMS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NyBTYWx0ZWRfX+GsFzpR/wsaN
 3keZxr5P6cAVzMeT30yzAUPYDD7Bc48VIn1KaGJVXpzj0to1MQTO9JboJo2iL6aZgWBkJfcju7O
 agKF4edHsgyt80T2hJ3poQqJ1LX/MEYJmsxB+OhGEDeJwbRwFtJloooSeAi2MDpB/xm6Jd0prdb
 M7DPWt+IuW7fYh9n+YCcdS1CyATm4q9tvY7eshtl0uDXrW+Ds1ib4VwATv9Iysx23JQi8/ujuZE
 dPb6wpx7roKGP6dws+IKL3pioLkcThDcTWwQWXEvSsNNCUfBjfjeAcGaSmOcbEAegLQbK2FVrR5
 LyAa/7Bfz5Dvuc2reQS3pJvyzBwqCW43iCJgOQz8ARcSW6PySNYUO9y1QLYVFdQ0SP34Vjgbssb
 RF3QkgnkGoGd0KMnAvxw/m3f8u0ey+VHLGsziFJ7LWclodZz6ap84htP24r3egtT7ympLjTbtMw
 8+rJjWvfoj1gjlODKkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060057
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



On 10/2/2026 1:52 PM, Neil Armstrong wrote:
> On 10/1/26 20:09, Arpit Saini wrote:
>>
>>
>> On 10/1/2026 3:25 PM, Dmitry Baryshkov wrote:
>>> On Thu, Oct 01, 2026 at 08:57:52AM +0200, Krzysztof Kozlowski wrote:
>>>> On 01/10/2026 08:55, Krzysztof Kozlowski wrote:
>>>>> On Tue, Sep 29, 2026 at 06:42:20PM +0530, Arpit Saini wrote:
>>>>>> Some boards drive the ILI7807S panel's backlight from an external
>>>>>> WLED driver whose enable input is wired to a GPIO, typically modeled
>>>>>> as a fixed regulator (e.g. vreg_wled).
>>>>>
>>>>> You describe something else. What's fixed regulator should not matter
>>>>> here. Which pin is it in ILI7807S?
>>>>>
>>>>> It seems you just want to represent GPIO with a regulator. This is just
>>>>> confusing and typical downstream workaround.
>>>>
>>>> What's more, you basically REVERT the review YOU RECEIVED in v1. Really,
>>>> just sneak the same stuff 3 months after like the review never happened.
>>>>
>>>> NAK
>>>
>>> After discussing this offline with Krzysztof. It's not a supply (my
>>> fault), it's an LCD driver. So, the best way to handle your displaycard
>>> seems to add a gpio-backlight, reference it from the panel and then in
>>> the driver check for the backlight's max_brightness level. If it's 1,
>>> then you have to send extra DCS commands to control PWM. If it's
>>> higher, use normal backlight class controls.
>>>
>>
>> Hi Dmitry, Krzysztof
>>
>> I have a few clarifying questions regarding the proposed approach. Please let me know if I've misunderstood anything.
>>      panel_backlight: backlight {
>>        compatible = "gpio-backlight";
>>        gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
>>        default-on;
>>    };
>>
>> 1) Adding gpio-backlight and check for max_brightness level if its 1,
>>
>>     If we model LCD_BKLT_EN using gpio-backlight, the backlight device effectively exposes only on/off control (max_brightness = 1),
>>     we can't support the full range of brightness i.e 0 to 16383 (0x3FFF)
>>
>> 2) Adding gpio-backlight and based upon max_brightness level of 1 , are you suggesting to register another
>>     backlight device that can actually drive DCS brightness. In that case we can actually have the MIPI DCS controlled brightness
>>
>>     If so, wouldn't that result in two backlight devices associated with the same panel:
>>
>>      gpio-backlight device for enable/disable
>>      panel backlight device for DCS brightness control
>>       Is that the expected design?
> 
> It's a great question because there's a large variety of how backlight is
> implemented, and some panels can drive a PWM to an actually backlight controller
> which uses external pwm. In this case we should model the backlight IC as
> backlight driver with only 1 or 0 capability and use the DCS to program
> the PWM.
> 
> So it leads exactly to your issue. So perhaps one way would be to either:
> - call into the gpio-backlight from the DCS callback, we may need to fix some locking issues
> - add way to "link" backlight devices so the backlight value can be propagated
> 
> 
> In any case the problem remains that both backlight devices will be exposed
> to userspace, which we don't want. So additional changes will be needed.
> 
>>
>> 3) I previously tried modeling LCD_BKLT_EN using pinctrl states (panel_bl_en / panel_bl_suspend)
>>     for the enable GPIO itself. However, Dmitry suggested modeling it as a regulator instead:
>>
>>     Link : https://lore.kernel.org/all/qkhgg5x67sijiialucvzac275zhpjrtt47a4udjpyzmgvilut5@dcrslq3ai7mc/
>>
>> 4) Modeled optional regulator wled-supply: a regulator that only gates the external backlight driver chip's power/enable,
>>     with DCS remaining the sole brightness path in this current patch , the panel-himax-hx83121a.c does exactly the same.
>>         Would this can be the preferred modeling for such panels?

Hi Neil,

Could you please help me understand why we cannot model the external WLED enable path similarly to panel-himax-hx83121a.c using an optional bl_supply?

In our case, this supply would only enable or disable the external WLED driver through LCD_BKLT_EN/GPIO91,
while the panel’s existing MIPI DCS backlight would continue to control the brightness.

This approach would also avoid exposing a second backlight device to userspace. Would this be an acceptable way to model the ILI7807S panel?

Thanks,
Arpit
>>
>> Please refer to this Hardware diagram I explained earlier ,
>> Link : https://lore.kernel.org/all/bade420c-aeb8-4bdd-b0cf-3ade17b21c18@oss.qualcomm.com/
>>
>>
>> Please let me know your suggestions.
>>
>> Thanks,
>> Arpit
>>
>>
>>    
>>    
> 

