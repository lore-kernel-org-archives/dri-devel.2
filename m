Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F95606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TYFxG5n6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AFjnnMo6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE7110E854;
	Wed, 25 Nov 2026 05:44:28 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A722210E854
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 05:44:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP2AtXd1342482
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 05:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d50YBDexfWNXkmWBY2bUEk+sxddsIUsz8wpZa3CLErI=; b=TYFxG5n6btKCtIl0
 lpOvG1TxFDPYMj4mxSJv6HQ09C1KNUQLcliOz+c4czOxR9UJ0SIWlt+th5w/+QRQ
 FAQcoq/jg05+nVlhkaxJxj8qhp9JCtrOulqVboYqEAk0Y30fR+92tAos9RXl4DQs
 u6UOH00BxelCD32ViaSShOyOPQoD0qJPZcVieOc4LJMMAToNDLYS5Zoy5hEbXl1G
 PiIjmsP1DUHXebc/eAQiq6jcYmne/SnTB5r7zVF/7DPN+AtFxLSX7AlCqXE1zgLa
 qz0Q8FqHK2xyn+LN0xdTLgsDSb96BkYuJ/3Han4ZkhTpYcA4xtweMGlzFr3QgJTm
 ZGS3nw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5nu68tq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 05:44:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b40b011aa4so6476961a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 21:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795585456; x=1796190256;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d50YBDexfWNXkmWBY2bUEk+sxddsIUsz8wpZa3CLErI=;
 b=AFjnnMo6el24rhbLt3GLk97cUHbMbr6aFAw+2oj3XIgwQQaEJP8+GxtyQRaJBrppJW
 TRLPi16dfIhn672qE/tMqmAcrfi9njlK1INKRp53yrDx7RWRqSHUailnfTOzBvr4ZE1I
 3WqcaYzzA/CI/KloVtBGZWIaNe8XpfNNyBZoCcKQUWoMK9pOY1KWdYzcoEhnMYRb8rjU
 g+sErmiz6NQUBMlFm4Vo3uH7tCt/lVXt1On0khHGpgDY+IItC1YbjuOQjWXnAsp9Uz/w
 0g/KRjTr4l2epqApqV2BA6SSMYcK5BradE9YsyLtT7uqDPYXpPNH5jQ8SDucukrvHFmN
 tiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795585456; x=1796190256;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d50YBDexfWNXkmWBY2bUEk+sxddsIUsz8wpZa3CLErI=;
 b=h0ScooVn4q3YM1YvQSpnLZcVJo2YUxI/f5kNg6gWGotsRaoA7X5CzN3ZJrcBoLgL6Y
 9WJSExQS8RtxITQLLyPpnk0Gdv2Ozg0+nPjXhm7ntkBB/yVrcXiaOaz7LLgGl+g9qPBj
 IkzH1DDGDsuoEgpJ0A5bVDQF3G92ay8+ZkNBf4BnvGHDG4scuM7A/F2iNjbre6HhRbmU
 4xJYQ0nACZ09m/W8CG2BBnZVuj0mo4HAqb6U4x3QNlwTyj15d0pX+r/An9ncYy/w2FPe
 3qMBXyUPVGQ99j9mc/6/emYZ7bp4R2zzlpTzsjPwy3pG1ER2mDG5qQTehHjbbTMh8niW
 3ufg==
X-Forwarded-Encrypted: i=1;
 AL+hErHkXiPuQw0BzEOIdphVD/LXCkv3t4/qTcw8WHuPp8MfgPLXPNJNsQj9E1uxiwBq/bsnWJ7PI14j8bY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8GbGBEF9zSE0Ao+Y4rltm459KkMCVvr1R5OwllubRx1nNba6n6
 2mgwx0A3HorWuEwZHfGd6R9FbgwKvCH0AlLiKmSq85ZyEoC+s1ZWSSSGJy/nITZ2+Ovy2qo2eub
 ROewwBJXkV7zC+RHNsNLLY/9/slrpRF7vyT0ArTeHD5H7uNgSRoHDUpHZsHzE3LKa3qQJpY0=
X-Gm-Gg: AZFdTZfz8MRJzyU9xbtlCfc0BkNPEhahueZDaS3RJHhS52HuuwC55TcyrHnfiympGS6
 nsnXGmdkDh1JC4z8Ogtl6KJCaUuvxwOSlfMYVXvQ8DEOm+88Uanr7EFs1bqd8Op+Lp9IDEjRRlZ
 sGRDlhRe9XmEx2GSfkJgO1V3m8bHVo5e+kTatiWQRRUSYwFqz1tumC+hQgccja5hsnRuz8WpUNs
 9uo9RPnCpF0luaZMUjqBeK4wm/N4NC49ov8KoQ1JKENFgJ+kktiMtU4cdSfH65gsKiqmqQqVScI
 x+WEW0gL3757KZcvG4yw6PzGQRxpXNE25MPBaQHG8iavdbjyuF3vd5ptpUIPRCd3l9Npn4fxnvH
 SepFNqmUJaTS5moizNZClbYUpcDrBMhj4hA7E8B4886s/6+weREudledDjbFy+P4KvTOn+/3VoM
 xd
X-Received: by 2002:a17:90b:2f8f:b0:3ac:9f24:44be with SMTP id
 98e67ed59e1d1-3b41c92a3dbmr16789514a91.29.1795585456080; 
 Tue, 24 Nov 2026 21:44:16 -0800 (PST)
X-Received: by 2002:a17:90b:2f8f:b0:3ac:9f24:44be with SMTP id
 98e67ed59e1d1-3b41c92a3dbmr16789490a91.29.1795585455568; 
 Tue, 24 Nov 2026 21:44:15 -0800 (PST)
Received: from [10.206.96.212] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b420e1307csm24869843a91.7.2026.11.24.21.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 21:44:15 -0800 (PST)
Message-ID: <956d1f06-d13a-4f5f-a7cf-cabefbafca99@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:14:08 +0530
X-Archived-By: <archiver.kernel.org>
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
 <494411c7-cf0f-4c43-9716-14fa5dc42a8a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <494411c7-cf0f-4c43-9716-14fa5dc42a8a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8LiSeVL9Xl4ww670z8WUOHDr_QxCnYdo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyMiBTYWx0ZWRfX4qamVE8JWnL/
 kT7iGArTqzyIOjPF++rJwFCVWZ0a5vGCHRmSDW+idOUOWSIbmYbjiEdRqtxKUhXw0iEqNv+ykeC
 3UQquoq5fH+GjjHFJD/yVB331KGgsrQ=
X-Proofpoint-GUID: 8LiSeVL9Xl4ww670z8WUOHDr_QxCnYdo
X-Authority-Analysis: v=2.4 cv=Vra2kO2n c=1 sm=1 tr=0 ts=6b0675b0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=5_7aImml_y_2oAff7DkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyMiBTYWx0ZWRfXw4pR8CP9/tV3
 aoAuGMniCoaRkELf0hSPMMvqNkzrXuePGKxjH1w6x6r2N51D3GzSuCCtjwdFvxzsMsb0J7fA2I5
 t6IvbxYzZ9d26N7L5x+g7jgCdtUBa9qsVcG/xu2iylRytmj+7+nwUMNdDJWKuwXuySmoFnoIagh
 r9yLTM5HBdyGAoqagzDWKjj6VZ3E/SdWIk/j63I7YVF7wvF8HYhnKMW/+Koi1yT2P7eEZZw+CJ1
 B+cPZTD6EAXQSmODWrafR3mMhM6IMfibIY41rRItmODPga21NIqEbMiKV21tvAyLa0MBGkfGqsc
 i2/6rgbKbaCAThA0dEE1MaK1xEVB3noQ1k6NimbM04zkzI8dxcDgQfYI+zZTImbWz5RH1U46a5U
 CZ5/AZHAj4o0Y18xPcB3JLBZfBYIaTKM58apQfY6QYDWqcY3gKCcR6QzIUqiEUtqcKQSoZmiWkK
 0WT1fp9E4DDNen3we0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250022
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/17/2026 11:57 PM, Arpit Saini wrote:
> 
> 
> On 10/6/2026 7:52 PM, Arpit Saini wrote:
>>
>>
>> On 10/2/2026 1:52 PM, Neil Armstrong wrote:
>>> On 10/1/26 20:09, Arpit Saini wrote:
>>>>
>>>>
>>>> On 10/1/2026 3:25 PM, Dmitry Baryshkov wrote:
>>>>> On Thu, Oct 01, 2026 at 08:57:52AM +0200, Krzysztof Kozlowski wrote:
>>>>>> On 01/10/2026 08:55, Krzysztof Kozlowski wrote:
>>>>>>> On Tue, Sep 29, 2026 at 06:42:20PM +0530, Arpit Saini wrote:
>>>>>>>> Some boards drive the ILI7807S panel's backlight from an external
>>>>>>>> WLED driver whose enable input is wired to a GPIO, typically modeled
>>>>>>>> as a fixed regulator (e.g. vreg_wled).
>>>>>>>
>>>>>>> You describe something else. What's fixed regulator should not matter
>>>>>>> here. Which pin is it in ILI7807S?
>>>>>>>
>>>>>>> It seems you just want to represent GPIO with a regulator. This is just
>>>>>>> confusing and typical downstream workaround.
>>>>>>
>>>>>> What's more, you basically REVERT the review YOU RECEIVED in v1. Really,
>>>>>> just sneak the same stuff 3 months after like the review never happened.
>>>>>>
>>>>>> NAK
>>>>>
>>>>> After discussing this offline with Krzysztof. It's not a supply (my
>>>>> fault), it's an LCD driver. So, the best way to handle your displaycard
>>>>> seems to add a gpio-backlight, reference it from the panel and then in
>>>>> the driver check for the backlight's max_brightness level. If it's 1,
>>>>> then you have to send extra DCS commands to control PWM. If it's
>>>>> higher, use normal backlight class controls.
>>>>>
>>>>
>>>> Hi Dmitry, Krzysztof
>>>>
>>>> I have a few clarifying questions regarding the proposed approach. Please let me know if I've misunderstood anything.
>>>>      panel_backlight: backlight {
>>>>        compatible = "gpio-backlight";
>>>>        gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
>>>>        default-on;
>>>>    };
>>>>
>>>> 1) Adding gpio-backlight and check for max_brightness level if its 1,
>>>>
>>>>     If we model LCD_BKLT_EN using gpio-backlight, the backlight device effectively exposes only on/off control (max_brightness = 1),
>>>>     we can't support the full range of brightness i.e 0 to 16383 (0x3FFF)
>>>>
>>>> 2) Adding gpio-backlight and based upon max_brightness level of 1 , are you suggesting to register another
>>>>     backlight device that can actually drive DCS brightness. In that case we can actually have the MIPI DCS controlled brightness
>>>>
>>>>     If so, wouldn't that result in two backlight devices associated with the same panel:
>>>>
>>>>      gpio-backlight device for enable/disable
>>>>      panel backlight device for DCS brightness control
>>>>       Is that the expected design?
>>>
>>> It's a great question because there's a large variety of how backlight is
>>> implemented, and some panels can drive a PWM to an actually backlight controller
>>> which uses external pwm. In this case we should model the backlight IC as
>>> backlight driver with only 1 or 0 capability and use the DCS to program
>>> the PWM.
>>>
>>> So it leads exactly to your issue. So perhaps one way would be to either:
>>> - call into the gpio-backlight from the DCS callback, we may need to fix some locking issues
>>> - add way to "link" backlight devices so the backlight value can be propagated
>>>
>>>
>>> In any case the problem remains that both backlight devices will be exposed
>>> to userspace, which we don't want. So additional changes will be needed.
>>>
>>>>
>>>> 3) I previously tried modeling LCD_BKLT_EN using pinctrl states (panel_bl_en / panel_bl_suspend)
>>>>     for the enable GPIO itself. However, Dmitry suggested modeling it as a regulator instead:
>>>>
>>>>     Link : https://lore.kernel.org/all/qkhgg5x67sijiialucvzac275zhpjrtt47a4udjpyzmgvilut5@dcrslq3ai7mc/
>>>>
>>>> 4) Modeled optional regulator wled-supply: a regulator that only gates the external backlight driver chip's power/enable,
>>>>     with DCS remaining the sole brightness path in this current patch , the panel-himax-hx83121a.c does exactly the same.
>>>>         Would this can be the preferred modeling for such panels?
>>
>> Hi Neil,
>>
>> Could you please help me understand why we cannot model the external WLED enable path similarly to panel-himax-hx83121a.c using an optional bl_supply?
>>
>> In our case, this supply would only enable or disable the external WLED driver through LCD_BKLT_EN/GPIO91,
>> while the panel’s existing MIPI DCS backlight would continue to control the brightness.
>>
>> This approach would also avoid exposing a second backlight device to userspace. Would this be an acceptable way to model the ILI7807S panel?
>>
>> Thanks,
>> Arpit
> 
> Hi Dmitry, Krzysztof, Neil,
> 
> Could you please clarify why we cannot model the ILI7807S backlight similarly to the approach used in panel-himax-hx83121a.c?
> 
> Reference:
> https://lore.kernel.org/all/20260608162622.403713-3-zhengxingda@iscas.ac.cn/
> 
> Our hardware has a similar split-control arrangement:
> 
> - The panel driver controls brightness through MIPI DCS commands.
> - An external WLED driver powers the panel backlight LEDs.
> - LCD_BKLT_EN / GPIO91 only enables or disables the external WLED driver.
> - No separate backlight device is required for brightness control.
> 
> Therefore, could LCD_BKLT_EN be modeled as an optional bl-supply, 
> with the panel driver enabling or disabling it while continuing to use DCS for brightness?
> 
> This would also avoid exposing a second backlight device to userspace. 
> 
> If this approach is not suitable, could you please clarify what differs from the accepted panel-himax-hx83121a.c model,
> and advise on the preferred way to represent it ?
> 
> Thanks,
> Arpit

Hi Dmitry, Krzysztof, Neil,

A gentle follow-up on the backlight modeling discussion below. 

I understand the concern that using a separate gpio-backlight could expose a second backlight device,
and that additional changes might be needed to avoid that.

Could you help me understand why the external WLED enable path here cannot be modeled similarly to panel-himax-hx83121a.c, 
using an optional bl-supply? 

In this design, the supply would only enable or disable the external WLED driver through LCD_BKLT_EN/GPIO91; 
brightness would remain controlled through MIPI DCS, with no separate backlight device for brightness.

If that approach is not suitable, could you please advise what differs from the panel-himax-hx83121a.c case and 
what model you would recommend? I’m happy to revise the series based on your guidance.

Thanks,
Arpit

