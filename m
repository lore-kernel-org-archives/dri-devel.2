Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096811061B1E
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6396510E745;
	Mon, 30 Mar 2026 20:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hi8SXscp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bq9uyvX5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FD710E745
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:53:49 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UIwMj14053269
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4NMG2Us6RdtOdQH6URthKWnEZugYWrLpT5hHK0H9okE=; b=hi8SXscplMRd7i0j
 opOa0miUqPFOpcsU01HRL+wCujH+UmEMpqkXrclnduJJj6GxupX2D/zwibURTHu9
 TDNrgQ8YpdpmU0JH0bAMbn7W2TBwg1wlyc3+ygjHaEIw4TDqtLsnusut32caIxTf
 5bO+hmhu/9e60sgR/T1kcaNv8POnxUMnmVnltjbtZgz/4BPvMHD07R40tjQumFzo
 IRZfIK2HatfFSgFrFW+2K7GVgz7PkS+ICaT74zl6kZMxkOhipc3tV9ywsz97+wv/
 qKBpr1s/6+jfwmjj4KEWxLM5hx9mRCeQ+eUmL0Dbz7WsDPKhMRn9T7sNnddplSd2
 mIcuZA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7xx38bss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:53:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2471321dcso82398465ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774904028; x=1775508828;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4NMG2Us6RdtOdQH6URthKWnEZugYWrLpT5hHK0H9okE=;
 b=Bq9uyvX5iprSjfPi6rrAXoBhsxKe05WCZb+UOwP1vBOCf8m3vV0/XDXLlCo9pTn32E
 L3YQacAp0763+oKIV7vCk7RGu1EXykIzK83plYhxiuV8dZXDZBCpSZfohVFu9gq0cNrk
 mvOIAg3KhscaitSk93p+aZZO/m6IK0sLOj9MAGCdTQkfAbveysYYD4s41o1uFnnDlF58
 1rEV+ieKjcvxt3A2s9JRpxTa6HV2Kl/b8R5iAuQhCJ34JPIwraMpB1yFR88qdO3hr0L/
 z8gHT9vlrINMzZRbfMb3JyzgKBgu5lybVg8YV10+qTHuN4rlj+YZl0YMMMce4i4of+fJ
 17Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774904028; x=1775508828;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4NMG2Us6RdtOdQH6URthKWnEZugYWrLpT5hHK0H9okE=;
 b=bnlSsM7mpLSIZkeuxPoaB+i2OxjATLEGW/Ab92X3x7+nd0JLJeYIuzieP46QuWGcJH
 SXRZaXEgfLfgjV5p/QPC0RuFuajGOyNv+Rtt+PMSGrt6fPPqJSm2ciZI/zcLUVKfX6Un
 axZWv/6cW7NwJ8wjHIS1MeASYDWIZ/NvcAd4NyhlXfVtMQ3M6bAHD0QwwRuaZL4SCMCC
 gqmpcpbgM4cenpTkB7Z2N+G16XUHgj5vc9OJQ3izl5AOkQ5qy8kwqCCbVPJYOxt5bbCM
 1aBzYlcS2ImGbQ4Dn4/10lzLT4MuEFr7sgJt7Sah5KMmfUxndFnQU/sGeOA3rYf+Qz/9
 XROg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2HPGamq79UMeWgx02YwJbfOF4i58fsleD3B6Erw0tEJweRnsotWSo8o6hbvi2nUDlTreMZHSlFhE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9COBps6sXh0IEhMjrJIOEYFrtFeu99TBJvYxzhfJHabX8rzrs
 rAM0EVNOdUYxDBXN4KO424B5uXkZMAeSmSKYd2qGVNLqEBQIRbBEgIFeyTTkHd+eczf0lNtEwUI
 47Hno+rBpZ/ZTtsT52hDzZmjWh4JecR6VMIJpsJUnAs0Ctjn/VFoa5PD/L+s244c8ZumR7zE=
X-Gm-Gg: ATEYQzzla1G9gPgktQ6bWem+oLmtUzny/65L5mv2pzSAEQxy0bNHwjGNCI9d7Q9Rcyq
 DKUnsDfZ0VlLLnG/STH66pJh6Vlq9hK0ePCprGQUMegTI92wjbhAVQFH8Hfa4tkxJ7t5cvagqzo
 oOxgTARrM0JEAQ6/jbLdRU3/mP8aZPUi4d0isjC5RFEMlKDYwMuoGsQQ5YDD4GH9dQTZOj4VwKL
 Os8iMOXakUJe7A/MQX5S8HWJJCvfMXPzLfSdrT3U8n9Y3EmimQm2dsvvX4gcXjoEKNpdww7PNrl
 0HtYoY5N4mW10012CpVm5aIGon56sPIKkDHngJ99Lx14qGp0FYVIpZPX2UBGA/9IY42MVUBVatp
 0UrijYacBvJWFxkOs9k8hoXlhS6fSNDqvJrzKf3vWqSVA
X-Received: by 2002:a17:903:228e:b0:2b0:62dd:3a80 with SMTP id
 d9443c01a7336-2b0cdc28171mr154611675ad.17.1774904027874; 
 Mon, 30 Mar 2026 13:53:47 -0700 (PDT)
X-Received: by 2002:a17:903:228e:b0:2b0:62dd:3a80 with SMTP id
 d9443c01a7336-2b0cdc28171mr154611455ad.17.1774904027321; 
 Mon, 30 Mar 2026 13:53:47 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b24265aa9fsm87281055ad.20.2026.03.30.13.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 13:53:46 -0700 (PDT)
Message-ID: <fb325d6e-09c6-4cb5-b04b-ff49aa5f34d5@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:23:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] drm/msm/adreno: Coredump on GPU/GMU init failures
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-8-2b53c38d2101@oss.qualcomm.com>
 <8114a15d-510d-498d-af79-a75493a8fc71@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8114a15d-510d-498d-af79-a75493a8fc71@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ErbfbCcA c=1 sm=1 tr=0 ts=69cae2dc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=O8mXyku17EuJp1xFqKwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: nzpWmyTax9mpaXFa4fzx-hLW3vV7fuge
X-Proofpoint-GUID: nzpWmyTax9mpaXFa4fzx-hLW3vV7fuge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NiBTYWx0ZWRfX6GBI0k88Plqv
 RR/0F6GfoltjVtUlLhGcVZD2A+wdt4aKt9XD1dJvcDUZNXcVBwguMZPilnSsxNL29D5sYYVPV5X
 lbqnPYDzXWlVTOhBCZFcV2bcxruKnNFBxSxcDNItmW4RDNUr0mgW16Ady32RQacvhPK8xhZvLyP
 99aIb5AnOMiOtA6XVxd+aPvMTE8kbBmdaqXk83Ef7qivBKGaCrcthTiMNQ6JNAkP2q7nxZhB6kJ
 MkWiRTtndoGl1g+JD6wMopPf2gan+1f2pnGkfNxNjkIGuX+OOqMuQ468+BAFJEI6Te/2HCXdMFB
 0tW4c/kIs2Sbj4Hr6SPMQbDReYaUdiepLD985mNN7hWXef5ibDDW2DTMWBuQvLd61Xpd7/Tam35
 qTntd+EcneV1055LmVoXMJBgvUim22PKIDmBpzY3CYZSecjH/CgO6/dgFRNr19epb+vWkym3QDa
 PMRKND1YfUJmdxatWDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300176
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

On 3/27/2026 5:05 PM, Konrad Dybcio wrote:
> On 3/27/26 1:13 AM, Akhil P Oommen wrote:
>> Capture coredump on GPU or GMU errors during initialization to help in
>> debugging the issues. To be consistent with the locks while calling
>> msm_gpu_crashstate_capture(), call pm_runtime_get(gpu) always with
>> msm_gpu->lock.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
> 
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> @@ -391,10 +391,13 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>>  		return 0;
>>  	case MSM_PARAM_TIMESTAMP:
>>  		if (adreno_gpu->funcs->get_timestamp) {
>> +			mutex_lock(&gpu->lock);
>>  			pm_runtime_get_sync(&gpu->pdev->dev);
>> +
>>  			*value = adreno_gpu->funcs->get_timestamp(gpu);
>> -			pm_runtime_put_autosuspend(&gpu->pdev->dev);
>>  
>> +			pm_runtime_put_autosuspend(&gpu->pdev->dev);
>> +			mutex_unlock(&gpu->lock);
> 
> This is something to take care of in a separate patch, but get_sync may
> fail and then the read could crash the device (GMU may be off too)
> 
> put_autosuspend could theroetically fail too, but perhaps -edontcarethatmuch

Right. That is something we should fix everywhere separately.

-Akhil.

> 
> Konrad

