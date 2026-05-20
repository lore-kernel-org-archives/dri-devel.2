Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E92CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B77D510E59B;
	Wed, 20 May 2026 10:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pjQ/qj4g";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bTYO/I/n";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A3C10E272
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:31:32 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7qqmf1637044
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C4Dq226a3Dt2Z7umro/qS9Vqjk6BVNhNKCyQse8jmis=; b=pjQ/qj4gKU2E8o6X
 2qibpa84lOGA1z/Z+dFFT7B7z/zrylF3U7AmDFiFF3t46uxm9TbkprrRUC+SbCbF
 SLakd236sXraqXSj7DMABofbAK3hj3ey91a6s+SO486Zs5EXMgjd9nVmGSknqASY
 /GZgP92KyQzxZZviCoRsSzPyJo4hJDh5CJfymcrjAzuc1zZ9YrBjXxHuqeoxlYKN
 b9qg3n54qaATP9GQGtl+gnwknKW95d1lofsdJtdwoSMv8+FDgQ0NCJYXTd4hBrWZ
 AyTSLiApFrbpUdtp+v7lNKEx6jw/0lRLAedd4rV0E1KoCx/5ZXspveCpB2Tq/4JJ
 wyOa6g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3sc5ru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:31:31 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8353b042152so6530507b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779273091; x=1779877891;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C4Dq226a3Dt2Z7umro/qS9Vqjk6BVNhNKCyQse8jmis=;
 b=bTYO/I/nvyBnU2czCLTF+uhMAlacRAmJ2veWg0w+JEYUPGVzQcBsplRDZ5Ps5pTnMS
 hwkA8gqwbLCEvGe9seUXLY9aYhk6q3kv2Sz/Aej/Fu3N1qUSt1pMgmT1hoxxdDa7bLk9
 EyPPo0OpKR9pP0UHO+BKOVxUXnXfL8U6iGC/vT8dTHOHtMkoi4m1CNXqbN/cjxe95yAN
 qIfC0M/YRuZnbLezDiyBXekuHKO/vLXuDgG1qcX4ebt7x4uLjktrqgf51YkQm0KXq0+Z
 q3kFQdfn+x8OTkB/EqTvouwWMEzDaLQUwxpxnB19gLHBkZeVbvv+tbKomjwCQorUTyF2
 rZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779273091; x=1779877891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C4Dq226a3Dt2Z7umro/qS9Vqjk6BVNhNKCyQse8jmis=;
 b=GWnTAcVjOYg2KdLit+OFSinJC4TbGWW3eznJrD37HEvAJqCkf+MaOuHz0KMDtQB8q9
 ysoCuaiSTjNMRK5MtWps51yYLUdIZoawejlhL6V8HYSn9FBKvXwefy9Q+LYLCddt8LoS
 eCfIN0ZrnbNGCRVxSLy2XIrQg0ZnJmgYbINb28AE4xo46hUdjixatkFLFG+MtyNTQ5WJ
 WcI9jLIWcLRWjf1w6Jwl+9KT6kF62wQfkjFA35SMctaBkMJnl62nPbcc/3o8LxUHeqLx
 xXIneXeKdFyfri+ALhdfeUYgH668kp3rDSpm3Bb76QY55sAXuXjwBMheAcXUcG0FAIxN
 nSNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7Jn3v5jNzeAqNLpvO7RzZ+93ZnU+CcqwnLXBoLc6gQYpRMpCL0B+MNhpLx0FUx76GsHu0ywyPGlY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkmvXmQtv2dRQvX+HR3h+FCdpmx1hoxRnFHaZUJIM8BhYay8Oz
 ftvNfAkVaHpIo2VtyL+Uo8k6B1S+P5675VGdh5OetVBHPUhha36hBsSWZ+4cLC6AXMy2hcD/UeL
 tg6hXc7YIi/9P1bAv99s21WZq5TeDISEKgzJQ2p2YRtb/hXPPJAPUwEI8sof3LkyZonS5RDM=
X-Gm-Gg: Acq92OGWJkxIW6sw5jRgl1uflgvKQwKxqXJdYhhU3CxRhvMe+7Bjs0dktQm3c10daJk
 jDAliwc0LGn1St4hlBHRK2QKevJmIY1AQ39BuRXZyzuK9NWSZdA8xcnhYoeagRe1mvjKItawBAF
 e/KSTyn6LvJ4A0Tx5V7CbwDpDv16v0J0RKtO4pDpSGC7Li0G85LHxkjfzJafzfZEOIbj/m2QEeN
 p/zmTlqoAzTXPVF27HhBDnbbm1G2AYZMURUf2XcUjg8IPJvBsxzxIa3gHeKDrbcInruZGmQlVZE
 tF1qOsw5hBiAnyTr2XyIjCxCox5bywYYM7SgbRULiUgxxwlbvEiy9PBrMamJefuAyQTMDWmVqAG
 +ivlCY0yRovukRsF5XCH5b9Pv2R/bgijwupps1eR1ipXMSej9WyMVGC+HyawGXrpctcSQfpWecY
 GU31zp+Ar1z4kYMZHawobMXmAthoeh
X-Received: by 2002:a05:6a00:2449:b0:82f:9de6:3b2a with SMTP id
 d2e1a72fcca58-83f33c4ea4dmr24974537b3a.8.1779273090643; 
 Wed, 20 May 2026 03:31:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:2449:b0:82f:9de6:3b2a with SMTP id
 d2e1a72fcca58-83f33c4ea4dmr24974511b3a.8.1779273090151; 
 Wed, 20 May 2026 03:31:30 -0700 (PDT)
Received: from [10.133.33.114] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f196660f9sm26137010b3a.10.2026.05.20.03.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:31:29 -0700 (PDT)
Message-ID: <272690cf-ca46-4b21-a979-3c89de15747c@oss.qualcomm.com>
Date: Wed, 20 May 2026 18:31:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/39] drm/msm/dp: allow dp_ctrl stream APIs to use any
 panel passed to it
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-8-b20518dea8de@oss.qualcomm.com>
 <oughavmmvruhnehdpa4e3ptigcb4wndugxazhoeg2yed7ubvgi@aa7wtrz5s6mx>
 <09c14a80-d981-4584-b4bb-8fb2430d7a0a@oss.qualcomm.com>
 <6b6uc5lk4tsxccwyyqlp4u6sqsv3x3uyu32qmgl63rgb2m4wuz@wjcroowka3zq>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <6b6uc5lk4tsxccwyyqlp4u6sqsv3x3uyu32qmgl63rgb2m4wuz@wjcroowka3zq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEwMSBTYWx0ZWRfX9r5wuqFZKQ74
 Hq/LMUKjqT0uaOzDJ9LIvrPrBAF1IzioXkfToCpEeMxsfW5U/+I53lxx2p7o8MpMAw36E4DSJr5
 Ok7d7oqmozWUGrE9YMfzS0c8LAogcm+4zTt4s7eHqsclWHK0B2W9aar/I8INfxz8QQB31psOc9E
 sOPpd1ZUkkiuRdIgmQVCoTYjTkDk+ueYNOBn63ahGHYGyagSymQ50HVdYMvneXeOE9hBoJyH3hr
 rBjWRehAFCMTcMxSCa152Vas9glOT++c7w1ydICenkfDVBgrFULAhd2gxgAuSM9FSnjXzIAZ37T
 dQajISBmU9n7DZCilRpBooYIwIcc4ynY1JrBVHL5THs51fgOLluNKazLhfWQJJ+gKdzHU9zNGRK
 6b3kKGmx2IWO35NefXXGCBMgSFKFRjGytea4yhoLgCVums+4eIhqAz4BP317ed/y4HcFqDDfbSP
 41RxXcHfFZfVfEvtu1Q==
X-Authority-Analysis: v=2.4 cv=Oc6oyBTY c=1 sm=1 tr=0 ts=6a0d8d83 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GPxS-sztI-lhh4Ud1vIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: PWPhyvtDUGifibTvQNqvQZ5XGMXlfDFW
X-Proofpoint-ORIG-GUID: PWPhyvtDUGifibTvQNqvQZ5XGMXlfDFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200101
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



On 5/20/2026 5:24 PM, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 03:52:35PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/12/2026 1:38 AM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 10, 2026 at 05:33:43PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> Currently, the dp_ctrl stream APIs operate on their own dp_panel
>>>> which is stored inside the dp_ctrl's private struct. However with MST,
>>>> the stored panel represents the fixed link and not the sinks which
>>>> are hotplugged. Allow the stream related APIs to work on the panel
>>>> which is passed to them rather than the stored one. For SST cases,
>>>> this shall continue to use the stored dp_panel.
>>>
>>> Hmm. Why? Can't we get rid of it (in the followup patch)?
>>>
>> In MST, the stream panel is bound to the connector, but in SST the panel is
>> still stored in msm_dp_display_private and msm_dp_ctrl_private, so
>>    dropping it does not seem necessary at this point. The purpose of these
>> changes is to allow the functions to operate on the MST panel data passed in
>> per stream.
> 
> I understand the panel being stored in msm_dp_display_private. Can we
> drop it from msm_dp_ctrl_private?
> 
Dropping panel from msm_dp_ctrl_private would require adding a panel 
parameter to approximately 15 functions in dp_ctrl.c.  Would you like us 
to do that in this patch?
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.c    | 21 +++++++++++----------
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>>>>    drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>>>>    3 files changed, 13 insertions(+), 12 deletions(-)
>>>>
> 

