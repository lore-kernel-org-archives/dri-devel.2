Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9BEC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 922E110F246;
	Thu,  2 Jul 2026 08:44:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXOHK9ek";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R3YIQDpv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7486010F246
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 08:44:05 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6627UDpJ3965252
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 08:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Iqb43rGi0YNDdCvsKO8e7oyCe1ZkrH5pxWX7o9Wo7qA=; b=WXOHK9ekTmFJgtdo
 V7tMlxdMTUzrpb3tlSe8uNUTBtKsC13TgM6GUuf87fmO9EgOUZGzUHvzExHX/hyq
 JLVgvfn8UvKOKipjsBwz+dYgvoScFgMFeYK+6pGX70l522p9V1M/frLBQjIbrnOL
 6P8+9z62LtI16mSgSRAAfKQLUzgFEzapO+oUHlbU8djLBaJmi3QFJ9/p3v+qRjbh
 HqyqLAuXiODMNOZYNy0ZSXPRl1rPAuAAiFkswlcxLA7C9JzKx8Tyabat0MbV1QEy
 KlO1CMHoJ/jXATAgKaYFKBOv4cMb5Y/jv71yn6qt/5WySne3VrxC7IdyC5pnb/4e
 2radxw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc09mh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 08:44:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c804e38c65so32065055ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 01:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782981843; x=1783586643;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iqb43rGi0YNDdCvsKO8e7oyCe1ZkrH5pxWX7o9Wo7qA=;
 b=R3YIQDpvJt/Hx9WqX3CAS7ww68lvsPG9r+yyxlYHBT8JO7QwrhLloncHK6ociGOoNb
 iqCbvE1ZN57+YijsWOoG3oEBSdVWG3gQwsJYG/ln4c59s72iLn6gMICwBZgjQNZxvhPf
 Yt2emGfZYKQmH7j0Q8ITU7BkkLKhldyAnaiXkV+QiOYv5IsPCg2dV7oXd6khYIgY4d0M
 1SSmeJXeztNUFVqeEP6YcCDd3gkD92EPlz5p9rbw/xEe3IqU5LRIG8jDLAkkrchkijpw
 4uXlylnXJhb9I5zYl/QWV6sbyLaBIGZm1swCcFMvJB80B8v7uiM70Rwplrgan67k5F3g
 NSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981843; x=1783586643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iqb43rGi0YNDdCvsKO8e7oyCe1ZkrH5pxWX7o9Wo7qA=;
 b=K7Vw9EPMUIqARSuABDarV9E1yoEs4hf/XIGfMRxGcioE8OvdaQJR7GXatAoiJ0cZ5F
 vO9Ay8QIlW0P66UWuBBw9Y0F4A1Qn91fOFEn1di4AapLl55qmXUJwDyDCRW2F5/QLMkz
 0cT0efom2JFxSdpAyotZfnsc3GscuShxfVNSChIhiRtg59zBI2vgMVMlRCgfZqRgGMfN
 KTHmJG34lV/haNjmvtWopeh1C80DU8RxUp1veiAFbYCD+xH7pSEM20wgtKzZz8YTVpLf
 qe1+sqSqzwtTem9fPCvWtMgntSbVAisFMlGGNWbZU5C4P/pIQ/1iO2T1KIz4J9BzgPZF
 uHLA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqVY1OiM7xY6fqipTNJGn0TmEPYT9nI2DM3M7GEgS6K1sKh5IutdLZuiIFDCWyHfU82XVFG/30jos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFmKUwyB5k2gS90gXej31kvXag5xWfZunee6Fmb4jL9gm4V2V6
 IUuXxgHet+J3FgnNvI9P8pz2qIVb2Xwplnm1SiubWUwhxY1NUm+Kz/Gsgbt4h52RVS3YjgPpEgq
 iRWf00FRm7/P/GmEgjpURH+u2hZFpwFboxw9hwnrPukWIl+8krNgTpr6y4ijuGaseQqaLbGk=
X-Gm-Gg: AfdE7cnefSEWbO/61zz/rxTBO1aIrsAdHDIAnuKR9MkXlMtbAudOXnparjf/9W5vYtk
 CUJibzDes3C5KB78hrLVEDEx6cs5rqEKi3YZiHd5cJ4qxB7nPQMa48Zo5CP5n4r6wwbh+OXZ1Dr
 s/hQdX2KpJpr/S3fvffVmDFeQEd1QMfDgdvftLpYVsluL0d/dEMaGb5z9BLD490nlrew9KHg5NV
 7ansKOZe9q7gs3nlrEQatuhLwlcvNqiWCsy02GC33EtqS+BWjagylrT8mcKFurKz6XDPeG5Pakj
 IvRmPIZkQVzWTC7gQczquudJ+p9NKK5iEg9T1PEMr7kbhhpkIJ6I20teqmubxdP1SoCMlsZaFRD
 JbSSLC4zK2zhhhVThamjCFUMIaHZdnhiIAmqXIlNe45O4sw==
X-Received: by 2002:a17:903:4b50:b0:2c9:97a7:3277 with SMTP id
 d9443c01a7336-2ca7e8adaafmr57776815ad.40.1782981843020; 
 Thu, 02 Jul 2026 01:44:03 -0700 (PDT)
X-Received: by 2002:a17:903:4b50:b0:2c9:97a7:3277 with SMTP id
 d9443c01a7336-2ca7e8adaafmr57776525ad.40.1782981842418; 
 Thu, 02 Jul 2026 01:44:02 -0700 (PDT)
Received: from [10.151.55.41] ([152.59.198.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a9fda23sm10229555ad.67.2026.07.02.01.43.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 01:44:02 -0700 (PDT)
Message-ID: <d817c5ac-79d0-43a6-ba78-e26d3ca474cc@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:13:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Srinivas Kandagatla <srini@kernel.org>,
 Jianping Li <jianping.li@oss.qualcomm.com>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
References: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
 <20260609025938.457-4-jianping.li@oss.qualcomm.com>
 <cca276af-3e6a-44d3-a1b6-c2bc401a28cc@kernel.org>
 <a79182b2-2582-4c77-a859-b4d013b700f3@oss.qualcomm.com>
 <51bad771-aa21-4394-8243-2fa7f275cb36@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <51bad771-aa21-4394-8243-2fa7f275cb36@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pCFnPTnKpaAZoIMLcacmYWevWFa2v0PS
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a4624d4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=9m3hvakvPwWhOvli1bnDMA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=HOC0WB5RhlNe5Vyk8xEA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4OSBTYWx0ZWRfX8LEJLZ7fl4JT
 UuGsJgJ6vEnwagiYL5TU288PTugF4Pkuaf+0ILRtYBF6VsXnAweAWLuNxC7lrF/LEuyvot4FbwP
 LjDwvlOGxX5h1ThR9Z3/enkVN/0FxGejxZWGV3wnTGwV6Swk+AONc3l7GiGXy0mZq0cyAyIQTT0
 aExc0KtsJxPsiN5Nq+Hfyp0vIvF/dvxU/YbOrptEqWS9JOAD/jvDbh+e1xWShr1Ng/pqnLNAAK+
 QFRa6n+xBCMgjYQkylDt9S+R572nsalKZL5AUiFP2hd38e0Uh64r+RoTpgvI9YiQFdmR7lduzpa
 ahvA+KtrZmrWWDz+sQSy5W97woxV+CM8c397tKG6k82Tp5qjt9vEAU7j2pJLBalol1E/9RUmIT5
 qdJcsY+iTkjfhARLXcB10sEwKWbqaoMLTeA4YUu9zSYAAxtpXNs+RnT7Ye4vfOWBcDiAb3qMH0P
 9TDH7iFZc1r8fL9+jJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4OSBTYWx0ZWRfX3S2c+cj8x2LQ
 GUttcFwACvXesh71Up6XLo1YDnmXiNG9tzpkKETdFAGK2jzcYHQas23paEe8zKB4qMWq83q1TNg
 z6/E+m9rdnE3VcVZP7qqypSYPab/PBc=
X-Proofpoint-GUID: pCFnPTnKpaAZoIMLcacmYWevWFa2v0PS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020089
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

On 02-07-2026 12:16, Srinivas Kandagatla wrote:
> 
> 
> On 7/2/26 5:02 AM, Ekansh Gupta wrote:
>>>> @@ -1409,8 +1395,17 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>>>  	args[1].length = inbuf.namelen;
>>>>  	args[1].fd = -1;
>>>>  
>>>> -	pages[0].addr = fl->cctx->remote_heap->dma_addr;
>>>> -	pages[0].size = fl->cctx->remote_heap->size;
>>>> +	spin_lock_irqsave(&cctx->lock, flags);
>>>> +	if (!cctx->audio_init_mem) {
>>>> +		pages[0].addr = cctx->remote_heap->dma_addr;
>>>> +		pages[0].size = cctx->remote_heap->size;
>>>> +		cctx->audio_init_mem = true;
>>>> +		inbuf.pageslen = 1;
>>>> +	} else {
>>>> +		pages[0].addr = 0;
>>>> +		pages[0].size = 0;
>>> What is the expected behavoiur in this case?
>> Audio daemon is expected to take the memory information to DSP audio PD
>> only the first time it goes and attaches there.
>>
>> This is the case where daemon was killed but audio PD session is still
>> running. In such cases, daemon is not expected to take any memory
>> information to audio PD as the earlier shared information is already
>> there with audio PD which it is using irrespective of daemon state.>
> Wow, this behavior is not documented or pl consider adding a comment
> here, Can we not query the dsp before creating new audiopd service?
Agree with your point about documentation, maybe Jianping can add the
information.

audio PD is generally not aware/affected by the state of daemon
process(other than the reverse request break) and there is no such query
supported to see if the audio PD already has the memory information.>
> 
> Does it make sense to attach instead of creating?
Calling it attach as PD creation is not done by the daemon, PD is
statically created upon DSP boot-up, the daemon just acts as a listener
for that PD to take up reverse fastrpc request.>
> --srini
> 
>>>> +	}
>>>> +	spin_unlock_irqrestore(&cctx->lock, flags);
>>>>  
>>>>  	args[2].ptr = (u64)(uintptr_t) pages;
>>>>  	args[2].length = sizeof(*pages);
> 

