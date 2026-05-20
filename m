Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3292CCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5429110EFDB;
	Wed, 20 May 2026 10:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NP9aFQw4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nf4+mbQa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 176CF10EFDA
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:09:16 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K73UZK1237958
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NHGk75E7eLjI45U2CcQdvR/hLoIhsg/8fuLIwG1HhaA=; b=NP9aFQw4fm7IcsSa
 7k1Isziv6H8wTtRzJXcuXUraxzQO1VdOLxkI0UQ5TU/SfGRBiUPFtqFLJyWZXRYZ
 CJc2BlyunsZIRto49X/TBtv+rpgpdy7EckCK7QXGWxuGEwlL+DW1l7QrsvB2lKUR
 ED2A7gWTr1bFSYTmxmRG+ijju0qhJc6MS6IAnQhAY/E7mwwj6G7yjrOF6cFRaqv/
 GwKGrSc3wnkB0AckkKZ66KpTx1OdiCivqDWZ+0toBNuYjf9+J+fWuyoX8TJZhb43
 7JeW/fgg1u56BsZfc5o6Ijko2HTlyMdhGt82ALB9Fc3IwAiJQrOfmaGmp/il91kd
 JYzsyA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3sv9fc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:09:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-835423c69ffso2510501b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779271755; x=1779876555;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHGk75E7eLjI45U2CcQdvR/hLoIhsg/8fuLIwG1HhaA=;
 b=Nf4+mbQaWUmVsfNUnREj3UvFKJ3RS457sWLpjfL+oK+ocQ6ksFQrO0eeDieEc8gk9v
 cV/kZptwwUuLp28OdXS6ham7WfI579U1Kunz9xOIJyysWa4D4OyRpvMeVA6zawmuKt88
 7qnyRTg7JxH4LIIULq9jnXgxoynnH08z8A61lreDZ4q8JNrSFoxrePOY/29gjQtykqyE
 nzCmAeK/me+3Kg4U0Sy/YKBkGCfDtJYS3tGsNkQoM0r4h0HLZjNQs4eidD7druWMQ9A7
 ixqXIzHeFhgBo9UWdbeRA+sg6JrvrerjS62TRM6yPw0EOSldKPAsAjlo/eGFB1R8URkU
 QB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779271755; x=1779876555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NHGk75E7eLjI45U2CcQdvR/hLoIhsg/8fuLIwG1HhaA=;
 b=WCzQSBPIcJzO6lI/jl9NYlZHyCgVJnmQblXrN+qmixwbTfmQURyig1e70P4BE9NUXA
 NjQI1r3CQznVQ0sXNAMysuF1UrXTtEQV0Hdh6E69SvAwwzm8/R1VIlB9AJuW5dNMbXdj
 TrbAFZVttQYomfwFCw0n0J2rF1rpud0ASevrN457fHSM7Wm8kENFKXKwpVfQD/sa69SJ
 uUm6mh/aa/LIKXDzU7sAs6M9bOQozHHm7VHIrkv69iDF+oif5IFl0U/uAydDfFXdyeTe
 zozw7qMNVEwXp6Ej57AObbqgOhcU4RSdsHG3krOt+aJp7GPLLqWiUWlmXo+ED9AjGuYF
 U50Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VC9iDkXyldaJgbvd1kLqrM7WdnsVxrz76bHwb71M7io90l6/EAYqxEzwMPkc8PDFvxwcgLVm/+9M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDuJywg4xXKqOC+5RMno7ZgHM5LafFPdhOzX+xeVEoUJ5cqCcs
 NidrbTnhe4IM43Qpv20aQhXODi4hG5DSxt8ZKGHzV/gCalM3kP/jC7yhlREWsgUiESJIQNPCPLI
 /WMMw5HF5I178HiYAUToH99YQzzr76+0rZ6Tdkn46JlDq6+WU33RoT6HHNVSCTkBwkDxCkB0=
X-Gm-Gg: Acq92OFzUAvjg8TsdHGWxnp7Qy1GpmrOvlvSdbAmzoUgXUBR0oDMTmcT3XtwxkhQ6Rn
 yjpCtjgqvV3LW7vhA8TUfDrNGkTNjvHccCR2y7z2hSdJvVCmERpKqufB+sDaCyC2u+HWXDlnqEA
 8J+LoSt1IGBUqYBocDdKsnT/zym7Ua49PoyD3HC+y0uY5NTH11Ze21vi3TlQqRwcGUt8acGjTYe
 VYin02F/WE7p5ZbpdLQU/UAB90Ivl0ESOZYq38RTJuk9CsUXgyh7DTVjOSRkPfMgh9uPJuYnJUZ
 r6B3sQhx5Df5wvMwzgVZxAHGF6QVfeLuPy+SQILE2TmmzckhoUb2xY9F/53HNFb4ESvhtImFxFc
 67ltG+f1YHLmsSaee5dOzLX3OibW9LZLLpLDzEa5FLFHfBE379tdu8foIaL+OVxLB6bm/un3brZ
 yVpD5RnWuF/gUbZa9nhA==
X-Received: by 2002:a05:6a00:12cf:b0:82a:1529:2b4f with SMTP id
 d2e1a72fcca58-83f33d20555mr24402851b3a.44.1779271754719; 
 Wed, 20 May 2026 03:09:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:12cf:b0:82a:1529:2b4f with SMTP id
 d2e1a72fcca58-83f33d20555mr24402810b3a.44.1779271754119; 
 Wed, 20 May 2026 03:09:14 -0700 (PDT)
Received: from [10.133.33.114] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5b296sm19190671b3a.32.2026.05.20.03.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:09:13 -0700 (PDT)
Message-ID: <06243b67-27a0-4ab0-ab31-8d4d6a555a57@oss.qualcomm.com>
Date: Wed, 20 May 2026 18:09:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/39] drm/msm/dp: remove cached drm_edid from panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-1-b20518dea8de@oss.qualcomm.com>
 <7cnjdge435t55s5vf66fkjfmkz7jvcbbax2uuismyc74mv4eia@toe2vu2folqa>
 <b02965b1-3805-4ac0-8772-aa832f192756@oss.qualcomm.com>
 <k477w6qrrqugfjnnzj4h7f54ahehgpws2xfjgcyewqsakplnzl@e5wj4aqwax7g>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <k477w6qrrqugfjnnzj4h7f54ahehgpws2xfjgcyewqsakplnzl@e5wj4aqwax7g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fpPvisE7cCSCzqisXlqkmu-yT_TCRh8z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA5NyBTYWx0ZWRfX/gKboQORm+Qw
 lqKvXA7znug2ORgWcqGC0nB6qw4ixtyREPAr3JgP8s2e8jarmpNaHiSVIdEG8MVNqnZLz/Uwv1g
 cI0QRR5ERNFp60fGsjGZr3yLRS7OD1TWh0tDpR0b2mmkWWVa/5xb/UkE5bS3vALhQjuHzQZguzt
 m9/5nyMqWM042QDA13sVwZYqJYzZLZ8B5OtD/Dmz5CtUtAJm/+ri7HK8pPvPsVRBjK/PGIM1MJ2
 WkI+y+K0qXnv/+6LSB1p4x9/wHIDN+5fyb8NmbQjA5hLtHA4RDkmQQN14AwUqu/uBRWIg7/bO/P
 R96hf9+3EaY7j62NhXCGiWZo/VhceUMdD2YXmGBGAsn6pUpkdkjL5MdUs63T6OXdTLaKj2OJO7p
 qYlUtPhkcJUIuQaouDQBZryBMb++w6YSMfUhKGv7cz/4yvJATOGqeljgElRQ/EcXN08UBatzSU1
 UhOSd3wWsloIRJCk+Pg==
X-Proofpoint-ORIG-GUID: fpPvisE7cCSCzqisXlqkmu-yT_TCRh8z
X-Authority-Analysis: v=2.4 cv=SNhykuvH c=1 sm=1 tr=0 ts=6a0d884b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=i31FdzyQ29aSgmU6y3EA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200097
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



On 5/20/2026 5:22 PM, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 03:27:00PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/10/2026 9:52 PM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 10, 2026 at 05:33:36PM +0800, Yongxing Mou wrote:
>>>> The cached drm_edid seems unnecessary here. Use the drm_edid pointer
>>>> directly in the plug stage instead of caching it. Remove the cached
>>>> drm_edid and the corresponding oneliner to simplify the code.
>>>>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++-------
>>>>    drivers/gpu/drm/msm/dp/dp_panel.c   | 57 ++++---------------------------------
>>>>    drivers/gpu/drm/msm/dp/dp_panel.h   | 13 +++------
>>>>    3 files changed, 26 insertions(+), 71 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> index 5c6a24ec140d..e28cc1bbb5b1 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> @@ -268,6 +268,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>>>    	const struct drm_display_info *info = &connector->display_info;
>>>>    	int rc = 0;
>>>>    	u8 dpcd[DP_RECEIVER_CAP_SIZE];
>>>> +	const struct drm_edid *drm_edid;
>>>>    	rc = drm_dp_read_dpcd_caps(dp->aux, dpcd);
>>>>    	if (rc)
>>>> @@ -275,10 +276,20 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>>>    	dp->link->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
>>>> -	rc = msm_dp_panel_read_sink_caps(dp->panel, connector);
>>>> +	rc = msm_dp_panel_read_link_caps(dp->panel, connector);
>>>>    	if (rc)
>>>>    		goto end;
>>>> +	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
>>>
>>> Where is it free?
>>>
>> Ohh, i miss it, will update next version
>>>> +	drm_edid_connector_update(connector, drm_edid);
>>>> +
>>>> +	if (!drm_edid) {
>>>> +		DRM_ERROR("panel edid read failed\n");
>>>> +		/* check edid read fail is due to unplug */
>>>> +		if (!msm_dp_aux_is_link_connected(dp->aux))
>>>
>>> Does this work for USB-C AltMode usecase?
>>>
>> For USB-C DP, i think it always TRUE, here should already existed before
>> this patch..
> 
> I'd expect the answer without the 'i think' part.
> 
Sorry.Add log and tested.  For  USB-C AltMode usecase 
msm_dp_aux_is_link_connected() always return 0.
>>>> +			return -ETIMEDOUT;
>>>> +	}
>>>> +
>>>>    	msm_dp_link_process_request(dp->link);
>>>>    	if (!dp->msm_dp_display.is_edp)
>>>
>>
> 

