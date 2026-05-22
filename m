Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47A7CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 12:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF5610F596;
	Fri, 22 May 2026 12:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KbPyYICb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z2pTne3X";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3EB10F596
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:06:58 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M733HU1298195
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RuC4SrN5QXHeOndDmUz76nUGZQ7L7HnziVS8PNaqBls=; b=KbPyYICbkw/yR81+
 kcwtkJE+EFGBR52L0V90LzQMV7Dkug0zN9yHQZfqVwW9Ub0TEst1+DfitJg4ckm/
 ifKTLg3d3eF3cGq8BuJpzAAxlpbLZsgDC3ctoCOslSF6G5O/wkbppwBHWfPxgEDc
 wBJ0T1qhJLQK7ImPXTQ4DVUY6xBGInUn/iaT3V9uhU7JyW4jSea8rDC9aurry9ya
 T5OiqUQnm4poTl7B9BzJNB8PShzzRKdx2DJR5EZNJFtAP71xkqtGMfiR/2rX4rRl
 UlQZ+79o9ZPtqb+UTGNj+kKHAA6YJnXh4CmyP8X1kdA71OjQLNPy4fzEg9YzjW0t
 mPrcoQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaah0aubj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:06:58 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-95687296dbcso322189241.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779451617; x=1780056417;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RuC4SrN5QXHeOndDmUz76nUGZQ7L7HnziVS8PNaqBls=;
 b=Z2pTne3Xjonzuzq+CFnFBJ4YSrCt/6Nd7xYkkNqHURcxjYYEoESdtvq2gvIihKi1JR
 hMNiDoPZ2H28DWYFF+cqJutNz7fKk1dZD5Ml2qACuAcAeyRt/gPgEmAIlKtMSWjoWAgX
 p94X/rk7qq9ovg0rTO2fU9q4aOU59MbGK0OZciNLVC/YJNDlMs6+ASx6svH4Lml5Gic0
 J2AjYOc9IcYvXK0HcyWYqYxLKEFkQx4Ee9/QGJBn/mjUY7ZRwZUxg2yF2lVN6s9Q7jj5
 TXkiZTM598xbgl+4cH6yXsKgZY07/n1tsJJ4JWtaAHPTc1taeGtw4laf25ujOkB49xvV
 JdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779451617; x=1780056417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RuC4SrN5QXHeOndDmUz76nUGZQ7L7HnziVS8PNaqBls=;
 b=Qy1uCSqnAAFwRm3JGEyJXRXX+zd/wPUY+CkLIaQ/V1LhL9lpxlJYEkzuRYX1FHiVe3
 LuFTtkuBYCeOMzhTJfet84+0Xr53OcrDixayPexv5vX263FvBsPnsZU7rDAtLDFn7je9
 /mNW4F78NkUgeFFPQ3OtcTF7m9+QN9eEdxfAVLMCKA+8WqQh9/2wW+hkij/WjDnzDNrj
 2JfjNU29Z5IJCd7cM/epBVT+SGUAHu/KO/RexjwkAL+1p/BOi/GKgxxrKgiedfFYrQfr
 DlkyYk70asgBsyznukdOwZ71IWhVCf9rqIO1p+5ODmigEEQNnE2+tdvq47C6KIA8+rMp
 00QQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RJHGio3R5fGIc5OLaMUlpYorZxcFREysS76JAAnzqsJyddGzXAx3sDJreMzSH5tudETk/dycqU+w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4iQBYuvfphIuGa5Pm44mWwPm16A4b6GnschNRc1ZmLLYQ/S64
 GYzc2NdALHgjaOnfAL7KCvT793tHiG8EsGHxLUQQmP7QZLrKlSCm1/N2XYQOTtRv1+SsHwb1Q5Y
 buerrTHr8icaXYkIHb/bWgk7lycdaoLqD4p696jj+i4vF+RMOJOg+tKA+4iLEqbRrfhHm7aw=
X-Gm-Gg: Acq92OFEwpszu2VdRSZCrhbfGyUh1C/qD3jy/XkYJ8x1pTTp8RzfyopTjYyP7YNdVOs
 QuXVuj1DYPXERxghMs8nH9vTZIAG4WwuI+PZklJ/+FGA5fNHe2VWzcqqW2sQBx7IZvqdHjTZjLk
 3geIWPsyV1Qy726zApLOic4+acE6+o7FA1GLqFjRnlqf2DtAVbSAx79UCpKbmbmT7mya3WO5G49
 0ude+shbo46BD3qqRi+utEt6AXGx7XAjEF+vMMn0n+uxMLBiDZCF6tF6RXg1zQD5xLnR7uMMT+5
 GxpQMd24hIRgU0ESNL56r7VzjgvtImVe3Uy33pha0hsg133h6/Bn8dJeoqUwFdG/44OcmWpz6nG
 AXfrrOGMC7pMxwuPQe+t4dvwgjMkdZyAprEd6mpwh4aOrfQ==
X-Received: by 2002:a05:6102:12ce:b0:631:2a09:94c0 with SMTP id
 ada2fe7eead31-67c704cc2f0mr493734137.2.1779451617109; 
 Fri, 22 May 2026 05:06:57 -0700 (PDT)
X-Received: by 2002:a05:6102:12ce:b0:631:2a09:94c0 with SMTP id
 ada2fe7eead31-67c704cc2f0mr493706137.2.1779451616558; 
 Fri, 22 May 2026 05:06:56 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc62d3f21sm47749466b.44.2026.05.22.05.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 05:06:55 -0700 (PDT)
Message-ID: <fd4f87d3-6c3b-4171-ac19-7ba28a899dd0@oss.qualcomm.com>
Date: Fri, 22 May 2026 14:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] drm/msm/dp: clear EDID on display unplug
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-10-0c8450737d64@oss.qualcomm.com>
 <93327e80-c4fa-464c-90d2-26a7b08b2ea9@oss.qualcomm.com>
 <kpx6hqics3odr66whpatyr4q3onj3sbm3bmoesr27u4up5wrcd@irdyyavhfvo5>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <kpx6hqics3odr66whpatyr4q3onj3sbm3bmoesr27u4up5wrcd@irdyyavhfvo5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEyMSBTYWx0ZWRfXzEtSD5j8/rej
 HMC/EbrD0QFqlhEiz71ziM6Kv09tXsy7PCxw8WtGO3F5NAY/T7HrTAG0976FJU0mOlPhtQRuJ+O
 YsX51UHeXC9zeL4W2GkU9UB76gk05kLSBkh4Mu1wo7TlxKuH8NR4qLy8bL5e+APfMpYnAsW4CjM
 rOu3lTtZHulWd5nMotuN+MbZ+g+PmIv4YMpckQ3G6usYpurrje4xnOq6gKAslHdb5Ig0dYbqiUy
 984IoHuWh7+NChf9ks3Acb2a3FDT4QI+y8vC3K45yJlh3NmMXtUTN2Y6mxLnNQJBRTjdnTJQjgR
 +tmaX+BQlQZMcDuV/TrkU2XJ8c940gAs32DhrS1MonvmulY/DcJvKG82wSBqDUuiYadqfZBex0N
 zqQKjb1i5Xa27dMwBPyO+LXgp0tviFRzCSI/VV1hr6EiB9sk3NQxcssrCBi+MzcROJaaiR7eaiJ
 4v0Ykl/SU9x/rY8lcvw==
X-Proofpoint-GUID: q_5B1XuVI-H6fxA9W654j0UfbObbf3Wr
X-Authority-Analysis: v=2.4 cv=LNdWhpW9 c=1 sm=1 tr=0 ts=6a1046e2 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=t_vVken9Fv9OD4yO6SUA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: q_5B1XuVI-H6fxA9W654j0UfbObbf3Wr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220121
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

On 5/22/26 2:02 PM, Dmitry Baryshkov wrote:
> On Fri, May 22, 2026 at 01:49:50PM +0200, Konrad Dybcio wrote:
>> On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
>>> Currently the driver only updates the EDID when it detects a connected
>>> monitor, which results in the connector still listing outdated modes
>>> even after the display is unplugged. Set connector's EDID to NULL on
>>> unplug to clear the list of modes.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>>  drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
>>>  drivers/gpu/drm/msm/dp/dp_panel.c   | 8 ++++++++
>>>  drivers/gpu/drm/msm/dp/dp_panel.h   | 2 ++
>>>  3 files changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>> index 0a38957ea901..5c6a24ec140d 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>> @@ -447,6 +447,10 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
>>>  		return 0;
>>>  	}
>>>  
>>> +	/* Don't forget modes for eDP */
>>> +	if (!dp->msm_dp_display.is_edp)
>>> +		msm_dp_panel_unplugged(dp->panel, dp->msm_dp_display.connector);
>>
>> Is there a change some ""funny"" panels decide to output a new EDID blob
>> after a "proper"/custom reset sequence (e.g. to remove limitations
>> presented to the DPTX at the UEFI display init stage?)
> 
> The panels don't know if it is a UEFI init or a normal reset. EDID
> changes require a long HPD pulse anyway.

I was wondering about the possibility of the panels effectively having
a side-channel for absolutely proprietary configuration. But your last
sentence makes me believe even that shouldn't be an issue

Konrad
