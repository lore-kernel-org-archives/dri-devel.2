Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB3BCD5BD2
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 10:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C3710E48E;
	Tue, 26 May 2026 10:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h6DAze2G";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HpWEtT1y";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A329E10E48E
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 10:34:17 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q5PqnU079206
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 10:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M6rrwvTxF7kpNlbgbAaNRd9qzBWBl+jhGHIIgmLXSLM=; b=h6DAze2G1t7voQ+I
 3q65s89rrWntoHB5fhr5aJ2BjUPY12d4DnktScZv7z9KFW40LAsfTK7obOjiIPfg
 tyhkXjZKWid28CNg8JkLL9l2lXEUtxIUnmP4NDJd2FTE6tU14bHjnknFWCWSInm7
 FeeaD56RHAkHo96hI+gPA0mLZWy6wME0CkZmh4duwRag4n25N03ypyquGwV0tntB
 2jqJnZMvU7sEhz8Rgq2QLpodBW3JnykLzO0y/NyfXlI516x+2BjtNxDQ7yyBrL2j
 vyeo8pBmLjf+2cU9+F1SE+w6BXv4gHUeV0DEae8Tj3jerLvaOoXwaEONXj0IsoPd
 dslUjA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckmac8km-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 10:34:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bd04e4fe3dso44138645ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779791656; x=1780396456;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M6rrwvTxF7kpNlbgbAaNRd9qzBWBl+jhGHIIgmLXSLM=;
 b=HpWEtT1yDEk7u+vqOEBz4rOgt+l6pZ7KBUk//QxRe8QcL8xf9FqAm3LrHw8FXA+nsu
 LUUTvpcqoQC3sJ2g9WJx+H1M3zmyuqJTAwKlM1t1Kv6Udwau7BLrByqn2PJv0ToWxC4H
 AiACf98MijgzKuabH0BYMySVGOIj3LJDWrx/AzLHPgpK6dAp6wJ70S81WER5JZq1dYGb
 FqLGLXHMbHwATfCSbcjcGSnB7esAOBahjV5Y4vFyZ/T5OPxJIIkxonrrxj3zVUb4BqsJ
 P93B1aDbdt24vBNmlv3/Ynq7GE1oWlJlTBz5ZGkmnhVf+J/5X4zuBb/pMNTKcmGWbl8g
 ESEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779791656; x=1780396456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M6rrwvTxF7kpNlbgbAaNRd9qzBWBl+jhGHIIgmLXSLM=;
 b=AIa8O1za1SiHmwqD2FBZlBn48OOXoIftVRZzw6cMJcTG6BDkCSlnj6tfFkZIm1GcYg
 2ctjFReJ8MVMLarDxyFQSaZQqbcT91VU77c2+yEiQPjtvQa5OdZDKh7wguPfeFnft+71
 vVpN++qmSKMHtqJYP+vr4tRy1RcfkCMOMw9vCk1qnrbT1iRwinkckp8skLgaIfu9N/dp
 eAIfIFV4gJqJo0M2HRsjagMGtRW705y0qbYOtsDMZvfViWZbdMHOolsh/UpPnRgvuIPo
 w6OVOv34yA3Ooknjk3RUA9Kfi24P/GdYTaxkjRPXP3Gk7LiVtnNdN+ea3cwL9Wc63N2I
 wqVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PGztLkGNhqx+XbTRAEWMUC8sBNPw7h8mA7mA2zV6NmNysZxr3fOiXzMqHDd3v1KlxvWm972Fhq+0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjMwNcIqiyvJcEmgP7+5iUnebmTtywgwKS7zbmIRrAr3HJJ/MP
 X0Y9Clu1xeZ0arnDXe5U4ZFs3Fvsqzs86m4FwLBLZqpVkvXRDqKItw4RtsZrf8OTGFAeMTMJSfu
 iI46OXtAfs8PIb8jyvXeZ/z5L5TkCC0OpAQCFyNU/Qq5fFxd12hE3KmE6KdVLBNV7wEuw0WM=
X-Gm-Gg: Acq92OG2Pc7yO2+XhsCGG3c2LXTWzVm4oO+Mif7dxCf/ixBNAQn+4ReBkuMZeVhn49c
 E8CgJserqqZCwIHCr+lQYAvWk0LuYrm6JIGSGaB90R0YpkzZYP9Tx0TAE6D3a33U4QxGSCrzi3P
 S56M0CxAhDWEbXB7v2SrAJSW9ms39I/o/ZFHC9R9PfgiIo9N0Gyn+36WW/8hTFndj7A7XizYWk9
 MBcAinV+03qfdF8s5YJnF5ieapPVIqIOyxIipa5Klm2z/LsogX5yjyA7GCnVjr2wfIS/3JmxupQ
 ju1RFaHoCYpx+qYeXSn+FVSf9XxBytnp5Qg/qHq/mi0WexdN4e9bbTPoWkAeDNbQCi7u5ZCvPbQ
 nFY/yEFd0mKW1BL8rczwfjFUKha/9JUtuyQoLLE7bepTIbgUTlOg=
X-Received: by 2002:a17:902:d489:b0:2ba:6ca2:bca with SMTP id
 d9443c01a7336-2beb0680e99mr203240935ad.26.1779791656213; 
 Tue, 26 May 2026 03:34:16 -0700 (PDT)
X-Received: by 2002:a17:902:d489:b0:2ba:6ca2:bca with SMTP id
 d9443c01a7336-2beb0680e99mr203240575ad.26.1779791655684; 
 Tue, 26 May 2026 03:34:15 -0700 (PDT)
Received: from [10.206.100.243] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56e090fsm131331095ad.34.2026.05.26.03.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 03:34:15 -0700 (PDT)
Message-ID: <a5313752-17ef-4d00-9f61-7717e4f06982@oss.qualcomm.com>
Date: Tue, 26 May 2026 16:02:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ILI7807S
 panel controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
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
 <dd065ccd-d7cb-45b5-8733-64b4f6571b3d@oss.qualcomm.com>
 <yn7rwuguaqliovlyukcj2olxby7zerv57na3jf2pgbke5zgahk@aasd4ojwdy2u>
Content-Language: en-US
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
In-Reply-To: <yn7rwuguaqliovlyukcj2olxby7zerv57na3jf2pgbke5zgahk@aasd4ojwdy2u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a157728 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=IV4c8OSHAAAA:8 a=QqSZzXjYCKH221ueLxIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=Q6n48rkgcAvIKCAITAMI:22
X-Proofpoint-ORIG-GUID: sn1r1FGOl1ZkNLCMpNR8Tl95jCH0LibH
X-Proofpoint-GUID: sn1r1FGOl1ZkNLCMpNR8Tl95jCH0LibH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5MiBTYWx0ZWRfX1j6JoAJ2Agst
 n4apGPSxiB2h1Y2RqvIVX2nI3DACmFQ3rGkvOesbF+wxFJiFjkCd+GEDafkaRGbcDp1RnBqlDJW
 aAT8g8GYd8Lfrxgkxc9kZfCtGRKtWc0+vi4bm3794BBZKLDcRX96PIsdI0zHQ8ndjDQQJPnysTZ
 Cj5hEXfdKQRRdcludc1cDIYoNmQsQOoZRKU/Ms1FfI5+WfcmHdmSzEJzl9pxHKdayeurcOpaNeN
 5YRvxFddFw+cPsjULAkHAahBTsbpSPmoy909UmTCwi6K16l/zbt6l6Ebtb1Ph/VhSmuDxHRp2hO
 91flzXp75BXy/vz5JmM21JeF/F1YNCr2pU+t5K/StnrTVjiZvKyTzrsCe5MJqLDjXGxYDY2qu6H
 66LQAe8+UYdbBbQ/AxrrhtoGIN8o9l9QSvmoMRa1dSdGFBv2wmCMxjVA6KqUTbBooJiHS8SwrML
 G8/c9gqu6M/YH02077w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260092
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

On 5/20/2026 6:56 PM, Dmitry Baryshkov wrote:
> On Wed, May 20, 2026 at 06:10:57PM +0530, Arpit Saini wrote:
>> Hi Krzysztof , Dmitry
>>
>> On 5/19/2026 4:02 PM, Krzysztof Kozlowski wrote:
>>> On Mon, May 18, 2026 at 04:34:12PM +0530, Arpit Saini wrote:
>>>> ILI7807S is a DSI display controller used to drive MIPI-DSI panels.
>>>> The DLC DLC0697 1080x1920 LCD panel is based on this controller.
> 
> I can't find this panel on the DLC website. Do you have a pointer to the
> product page?
> 
https://v4.cecdn.yun300.cn/100001_2012175013/DLC0697AAL21MF-1.pdf
>>>>
>>>> The panel requires a reset GPIO, backlight enable GPIO, I/O voltage
>>>
>>> If panel requires it, so should the binding.
>>>
>> Ack, I will update.
>>> ...
>>>
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +    description: DSI virtual channel
>>>> +
>>>> +  reset-gpios: true
>>>> +
>>>> +  backlight-en-gpios:
>>>> +    description: Backlight enable GPIO (active high)
>>>
>>> What is the name of the pin in ili7807s device?
>>>
>> Display daughter card has WLED driver as well as LCD bias driver.
> 
> What is the display daughter card here? Is it a Qualcomm board or is it
> a part of the panel?
> 
> Also you wrote a lot of text, but you didn't really answer either of the
> quesitons. Is there a GPIO on the panel connector that enables the
> backlight? If not, this is some external supply on your (assumingly)
> daughter card. And it should be modelled accordingly.
> 
>>
>> The WLED driver's Enable is coming from WLED_P1_EN and PWM is coming from
>> LCD_CABC output of the panel.
>>
>> DISPLAY0_BACKLIGHT_ENABLE (GPIO 91) of ITP baseband card ==> WLED_P1_EN of
>> Display Daughter Card (DC)
>>
>> In the display daughter card of Shikra ITP platform, we are not using the
>> external PWM for WLED driver. But connected the CABC output of the panel to
>> the WLED driver. Backlight update is happening using MIPI DCS command which
>> is driving the CABC output (i.e., PWM for WLED).
>>
>> Because of above HW configuration, we need to enable the MIPI DCS brightness
>> update on this panel. The below command of dlc0697_init_sequence() is
>> enabling this.
>> mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x24);
> 
> So, this should be then dependent on the presence of the backlight in
> the DT. Either it is a panel-internal one, or an external one.
> 
>>
>>
>> After checking this, I realized that this panel can be used without the DCS
>> backlight as well when it's using PWM based backlight control.
>>
>> I can add `has_dcs_backlight`  in panel_desc and set it true for dlc0697. I
>> will update bindings and add backlight as optional property.
> 
> Why? Use backlight property instead. It's already there. Anyway, you
> really, really need to describe the panel in the bidings. Not your
> daughter card.
> 
This `has_dcs_backlight` in panel_desc will serves both the purpose, as 
for our current platform constraint , we need to create our own backlight.
But this panel can be used without the DCS
backlight as well when it's using PWM based backlight control.

So in this case I need to implement the backlight as implemented in 
panel-novatek-nt36523.c, panel-himax-hx83121a.c.

with this implementation ,I will remove the backlight from the dt-bindings.

Please let me know,if I am missing something.

Thanks,
Arpit


