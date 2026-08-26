Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAF2C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0472710EC30;
	Wed, 26 Aug 2026 07:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BQRCnF7d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ju+C6Xc4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1158410EC30
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:49:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6RiiE3783746
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k+ow9xkAE9f8Iw4EUWsQR6aXbP6OXWNdIHYU2Fe8tkM=; b=BQRCnF7dQIkrA2WH
 LEjmgO1Nw6Wmkpx21GAAHSgmyv7T7PeYd3nUMgfHC3e2iwOSRkdSyBrP7DhfNJsI
 7aTR93uEPWt0FH4wJyz3BI/936gsf4Dd2WnyvL9sI/mpqQefei+GubIi5GzT52kr
 yGH+clTh9eqh1K7M/wut0AsVwdYzrFQFp7MARyWNLlYprGnH8hOaamJXN80hvv9e
 k4eBVa1uQGNfthU3hF2UnhHE1vCyd512caoOJSAU7YOWj5c088CM+7naewrJOpHL
 Zy+pBdCZh4aFQkGstfWSJ+klqyIiyx7PAWzd/MZ80pf6ZuCUxgnYPh++oHe+hmOZ
 4LmcgQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9s9g8qvd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:49:10 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84e048a801dso1116431b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 00:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787730549; x=1788335349;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k+ow9xkAE9f8Iw4EUWsQR6aXbP6OXWNdIHYU2Fe8tkM=;
 b=Ju+C6Xc4nJ/floifW8x+dDeo43HTDw42ynFQmTvPMyvdFWnu14cDliSKzpQOuokJkR
 UdhP7MAOJU0fKPEE+NSXLmu5fww4yEAkLLcYmHpilEjdZjfSQlWdK0ibFdeF6BLUvoRS
 0XqjAVlpX97tzPypMyXmQEoKDGaGYwClP2C3hYJVGay5zRTJkiLwC0Kc3tr0sV0kOWNh
 lhr/izIrsa3c3qIPyWbM8VWNo76vEZxz5CDEY2KqQIhB1sZNObXg6gsOIrXalr5FP0rL
 qmttkI4bDldz/afzM0vdtKAs5WqJ1qAZ6gy/NxUTr4Wk1sXhIu5DnfUR6okYwy18PpJO
 s1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730549; x=1788335349;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k+ow9xkAE9f8Iw4EUWsQR6aXbP6OXWNdIHYU2Fe8tkM=;
 b=LLb970gV8jSv6nBV8CkWlC8FdwqMhQv0ZNhy2WrR5eXI5qoR4Cc7sJY/MI3P9a4bpX
 iZqQ0iXJPT+9UqSATh2lwjq3JRbMwk6XeNC0uo8ku8Idas1bpi9C7ZtC4KpoMzs+uuOP
 s/si5Kw6Uconm2XeR+bnxKlfZz4lvChVmMA/2lfgCFNceAFialo/VlPMSx+IwlN3kdjD
 GTlUWqMejJb8d8JWZH7juH76qFyQ3XvA3340ih08gqcfDRkR7+njRjcxacDn4JlAP0hn
 qOJT3bYZggzg3ZbMp/j+f9LqGxAnKeMwo4wi1OjcpDKN3rYhGbwWO/IPqPtcrii50I5W
 R80g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRjj9nb+T5Di5D2dxtgsOsrajUAX2XK69HTyhPYOvEAEmRmH6T/jVDCqoiSQLl7FXw5+ZFmX6aQ3I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nDtFIf3cJN/92NQmJ2X9s+a4qYIzX7TA1BlX4IR0tCfhgevdOn
 5EWmHVAPY9XIMlbHKaSnJSwIcBCWeiKHB/4isYwfVbShSCAotqegxq4SyD5nxlEUdqjfTA8cjQa
 mTq1Jzx9R+zXgnJg4CSnszy5Ue+4fYMWeikqDO+tUKv0SdvNNTjViIZP3bnACpTmh1li21cQ=
X-Gm-Gg: AR+sD12Zz8+cInAIOzKBDzC/vkOKyYCK+cVrpa89fLMaN8PDdn66lSsoEFwSezleox0
 5tz822sDPC4p5bdfut7aEKDJvIS8QDPxKQmj71mAvEjAmrKVJqoaCdFeTwYzQFQGglV0HoNWpL7
 yM4M77AcFrdOud5HEPfWE/0Lwb+FYwB8cTN2OF9M6MyoAJVQSPbtqx/1kOGsJ6i0aqRts8ZF0Ya
 p1HSM23rgscrSZxfJpcm+u8yYb0YXkybQ39YMPaQgPyu1AlgWq+1f3c9jVaoU7P/HKlk9acnzu1
 iNuneIwPl5Q+oDU1Pz1qME8ArWVTA9JYt6Ca9IN2tduy7cjm8orE7GI6dtQlEbwGcflyFu/NDrf
 qz7vSbCdGKlsjSYIMwFnXIrIAh+X+yTbHX5xfeMIAEKRU8kQXoWdpI9S0Is4ZcUEevxlD8Cfl
X-Received: by 2002:a05:6a00:390c:b0:84e:b7ed:7d50 with SMTP id
 d2e1a72fcca58-853755c3b2dmr8288505b3a.16.1787730549095; 
 Wed, 26 Aug 2026 00:49:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:390c:b0:84e:b7ed:7d50 with SMTP id
 d2e1a72fcca58-853755c3b2dmr8288408b3a.16.1787730548632; 
 Wed, 26 Aug 2026 00:49:08 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cd8a41esm588474b3a.29.2026.08.26.00.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 00:49:08 -0700 (PDT)
Message-ID: <4958551f-c65c-43ca-8cfb-c76fbfca5f2c@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:49:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 14/25] drm/msm/dp: Mark the SST bridge
 disconnected when mst is active
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-14-2ed6aee1867a@oss.qualcomm.com>
 <g2irqebm46aiuyp344wg3zjdzn2qn7q74bvppcgmveaoj2ndtn@mng6dqinykmm>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <g2irqebm46aiuyp344wg3zjdzn2qn7q74bvppcgmveaoj2ndtn@mng6dqinykmm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iRUscq3n1jwaEWFMnaogbAdn1lD3jxQi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX5Qafz1UtesxF
 8JZJz6jOu3DtSxbz1jSpLvClOYI2JxSLLD7VqMQKJOHlO59AOwTR1XcSQXHASO3n9pqXP1GIpeK
 r3X0TnJpBiWIEcKMvgvRAjdLjKUTDz6w3p9a2FjgE6IWepRHiBqvdphnGHKhQDGJlWNJKYeGWpN
 tuYww8rc7CvIqt2tH+lACWTJTgdeKay1Zf5TPqO3fNmrBxXs9f0HuVtJGIq+V07Z+snbaj1PWEf
 WhYg/hjtt7e7miXgoFkQYHQBsUEC4sMGje5hzQVSOvBZiwl+kQJDqwIMpaAyqaV1kR8GG9HuQce
 pYM2Gc1rzhf9GtCn2/WXkehmHdUZXhWsaYnG3Ylv9gU6FKObpgTaD5m9hXf4n0GykfHUKMpCeza
 9Kas85EWbCOfAmFnXg76Pd/P+SZATxMxRKFPotZGUV6GYdk5QZzzscWqwgrRTNsF2d6KZ52AT+X
 JkWvuFTZpaIhTzb+CWQ==
X-Authority-Analysis: v=2.4 cv=Xfq5Co55 c=1 sm=1 tr=0 ts=6a8e9a76 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pmlfr3f6Yr8kXvQmqdUA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX5cj3ymLxGIA0
 +AY7zvLbckp/HUjS4A44tdn5XhVeovZawrV8NPsBY95D7n73jBq0u4YVsEGkfno7bhscPKK2ThR
 GCxLdPytraaP7fwDWCRFjhy/yqIr3u8=
X-Proofpoint-ORIG-GUID: iRUscq3n1jwaEWFMnaogbAdn1lD3jxQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260063
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



On 7/13/2026 5:00 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:35PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> The bridge detect function is only applicable for SST. In MST mode,
>> connector detection is handled by MST bridges. Skips detection for the
>> SST bridge when MST is active.
> 
> Please mention that it matches the state of other platforms.
> 
Got it.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index d0081ea9f5cd..5786e598a406 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -910,6 +910,9 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
>>   
>>   	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>>   
>> +	if (dp->mst_active)
>> +		return status;
>> +
>>   	guard(mutex)(&priv->plugged_lock);
>>   	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
>>   	if (ret) {
>> @@ -955,6 +958,10 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
>>   			status = connector_status_disconnected;
>>   	}
>>   
>> +	/* skip for MST */
>> +	if (priv->max_stream > 1 && drm_dp_read_mst_cap(priv->aux, dpcd))
>> +		status = connector_status_disconnected;
> 
> Hmm, should it only be marked as disconnected after we switch to the MST
> mode? When is the switch happening?
> 
This condition is intended to handle the DP boot-up case, where detect() 
runs before notify(), meaning mst_active is still false when we reach 
this point. In the normal plug/unplug flow, notify() runs first.

I think this should be split into two patches. Adding this check only 
makes sense once MST is actually functional; otherwise, it risks 
breaking SST.
>> +
>>   end:
>>   	/*
>>   	 * If we detected the DPRX, leave the controller on so that it doesn't
>>
>> -- 
>> 2.43.0
>>
> 

