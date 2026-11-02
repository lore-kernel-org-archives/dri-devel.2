Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEED6083629
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fVjPD5/2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eHBaxSWo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA1010EFFC;
	Mon,  2 Nov 2026 15:26:35 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F0C610EFF8
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:26:24 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2Dp5p9894074
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 15:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NZ7uDGaJuz3784OD9oFLUOQAlulPmdnktGy1Lcp2kIQ=; b=fVjPD5/2rsrAeWny
 dY4kXttgQdcC8B2da4/JGFKlwB88zU2Wt+us18VB1OZwQ+AH7/UwypCGNuzM3nc3
 u8ZKNI3lps1ppameBkvboOCjTzKDvJsaNM2Fs9Y+I5WUxnRVPTGdCTLVJr8omCPd
 D38LG0xJBLYhh0+QZ89jL2tVARDXTPMlynaADDFK1bixIqZF3EeYyMC+9TiWlgNe
 dlBN53bF9lSLcHCNf90k+wucjcAbTG3V2V2IHUqirxUAdalbSJFoKT6zLGrafWpw
 UKeNrnd6WJcRHAT7WWuFGgb8Av267GPs51xoJ8o+nLMp4plyJtKWn5Sgl8UXvt4g
 +9EYEw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqmvsg73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 15:26:23 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eac78dbbe7so72247e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793633182; x=1794237982;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NZ7uDGaJuz3784OD9oFLUOQAlulPmdnktGy1Lcp2kIQ=;
 b=eHBaxSWo9zVjg1gZxs+AO6EUn/kV5BL8PAhZXKuFnpRDZKyrPoWFhMfxTAubMtlaRw
 kAX6eG24AtJvcUNF1IDL97n2sPr8p7UA+3teohY82tQ1JEtzsiuh/3J6KOepAUAZ4gxv
 BWBRMp44iNYXpDJwwFwmyjJW8J/pSqvRHV9bF6J7mpQ3D3GLSfvu275vn8a6c9/848UN
 M/pflCvnKO+yv4cZX/AaI2SUof1wIhF0X51g8q1/pjQ78SYegqlN1poZmipKBl7RXQ1O
 7UWhGbN2MYVrIu3uEbkmmRIDVFeiTq36lYWPoHIn/TI4JzoA0XlQ8zKzO8RMAc7XEkaV
 Izvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793633182; x=1794237982;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NZ7uDGaJuz3784OD9oFLUOQAlulPmdnktGy1Lcp2kIQ=;
 b=oDv1AJoziOjF+rFN1oDJl4D55sWesaKFZpaHMiTDdmnzsAHkiDdVoQ6SH6Pl8SiKAo
 lqVRvOJ1CkMprKweO5DCekVRkXuviEpFSvshHo26wT/EmEscRU64byOgdczooRMS1gU3
 Pk++Rx2l6Iv6CzdpC1nYVDrO1RUgrT0BgXvs++ium1kghkCnNRYHKkR/VIXfD9IzHlTN
 jMEwfMclGuW3CDqiln4hJkupAVLN/2nUgA00ftIQxYChBjnxqY0/5rKS9g9M9A741VJ9
 vi1V7QJ2Z/qo6TQZEms2m4u2e99K+Hq7eC2AZTZG/V3mJdP3+cdu3M/fdn3akr9w0DY8
 kugw==
X-Gm-Message-State: APuU4Z/igaWSGm39WPLJiStGo7qfbhth78NE/xD5wvt5i7II6C+I7nDb
 egAL89jJrdyP9BOF/XAGQLOajeBdtIaD9V3sW2xRWTX9bqMsqGebv6Gl4MLzupGf9hzsyGXuDiK
 aqMPfCHZRRf5NvyWMnFwphfIZA6GqNCt29Fd/afzO34QiTveZQDsrPyXe7hSdqONoqToNYkA=
X-Gm-Gg: AYBFou0V9oNVHz5EOz79rTpAggWU0HdwqqUuQhnroeueX63RYA0Mb96qsCi0pb8pirY
 ZfgMDJHY60qckTWbG12h95ceA6KTv3iDKjN7V/Ylk9aw+if65aF6LZEsk8CdlQsk8eKBZ+EG6em
 Nj3YYliPYHgi/5nGuBf4eiNyCeqc4FLDCSr2CgDIAAr2Bgc+VYjSjKuEziIHYuNdq/ryRCErVY3
 4cdNv07ygpAOXOiHihN8dSZZmhW8u3rprsgFnVaqp2Y6Q11Re5CwEUZ2z0w7xWGrE7JsknjSIjH
 py4MstfBPyho9jl54JRY7qkqcIybv0soRvTJTo+r5/Bzeg0QcNa73cWDbhPvYKwuL2xeEN+l4aK
 YJ8p2wbT1DlmsQ1YzIHnWoLdB5xMWDDiC29+RtKxlXyEzYTsISEkma+9UxYz+xoQaqmkFVQ==
X-Received: by 2002:ac5:cdb8:0:b0:5ce:23fe:84d8 with SMTP id
 71dfb90a1353d-5ec7562c7c4mr2941406e0c.0.1793633182140; 
 Mon, 02 Nov 2026 07:26:22 -0800 (PST)
X-Received: by 2002:ac5:cdb8:0:b0:5ce:23fe:84d8 with SMTP id
 71dfb90a1353d-5ec7562c7c4mr2941372e0c.0.1793633181338; 
 Mon, 02 Nov 2026 07:26:21 -0800 (PST)
Received: from [192.168.226.93] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebd3a2desm2237066b.10.2026.11.02.07.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 07:26:20 -0800 (PST)
Message-ID: <427972ac-130b-4e56-92b4-9d11d278d6af@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 16:26:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/msm/gem: Fix VM_BIND range check
To: rob.clark@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
 <20261101174911.25184-2-robin.clark@oss.qualcomm.com>
 <90ae1b4e-d83e-4209-9df1-7ebf778a881a@oss.qualcomm.com>
 <CACSVV012ncykN3PnXnuP+-tK51r4kJ4BUfiThcjV2JYvn_jXwQ@mail.gmail.com>
 <CACSVV01=19OWZ4i1Bc-j8m8u0+5jtfOgqPU-VfkLUQUQ_oVdmg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV01=19OWZ4i1Bc-j8m8u0+5jtfOgqPU-VfkLUQUQ_oVdmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMDQ2Fla c=1 sm=1 tr=0 ts=6ae8ab9f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=lvvAgqv1s9cMsEWjrR4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: 1yFe6s6MUYXaJ4yoYI2EWvwy48VQuQGE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MSBTYWx0ZWRfX8XXqPZ+JqR06
 JyxvjwGARMtYh2NHqNGTr2tyanZgHVB8arR5GN87tFqvnZMfrHwLvKcOEvaH6wbMWYtQvYwyr44
 w3tK4b7ECSSQjbo/aAirw9KuYeB8LnU=
X-Proofpoint-ORIG-GUID: 1yFe6s6MUYXaJ4yoYI2EWvwy48VQuQGE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MSBTYWx0ZWRfXzkjXrbfiO8cB
 lycUGNKCY40vJFwZ/9CJK5zTyWlKL/sdnx9UQPFTzuzia6XtHyEZDFqDGZROdAii5J34UcUelm8
 t+oW7amEVJlP5jT3hvyrL/VoTE/GMPf6yqrrCFZCokxZrrWZ8JSoAIPGRBTlj/qyPcNLRSpPr4C
 SXiaRIIks66LJaGKOit5a+ETAae0icfnttX/z3zTDX/IvX4IFH927Fm+dALGiZRaUDePhChFhfe
 yjWl7gDLOLuQMDreizhzo5huQ3ItIMcT4r7fgr2gzqJo2skUxqHKbg6G3lwmx6SMjAoSXJCIfut
 iG4XBjzBAbTMYVHywI3K/bq4Jou1bPOZBL4M3aM2qf8IIfJv9AJme2d9IrYNxbDk1gbFkY5D/gs
 fZ9XOjJf/u5oGW6pXyhTjMixlvbKFRBWWUv1JdRlzLZcVuXZrhzNteRTzPRhiCXHQcElNmFTC6f
 pWbZb7v8y+qAZmHcqfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020061
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 4:18 PM, Rob Clark wrote:
> On Mon, Nov 2, 2026 at 5:59 AM Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>>
>> On Mon, Nov 2, 2026 at 1:40 AM Konrad Dybcio
>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>
>>> On 11/1/26 6:49 PM, Rob Clark wrote:
>>>> Use size_add() to guard against overflow.
>>>>
>>>> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> Fixes: 3a3bef68a6c1 ("drm/msm: Fix missing VM_BIND offset/range validation")
>>>> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
>>>> ---
>>>>  drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
>>>> index f687a629629d..16b3870d5e90 100644
>>>> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
>>>> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
>>>> @@ -1118,7 +1118,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
>>>>               op->obj = obj;
>>>>               cnt++;
>>>>
>>>> -             if ((op->range + op->obj_offset) > obj->size) {
>>>> +             if (size_add(op->range, op->obj_offset) > obj->size) {
>>>
>>> GPT and Sashiko are unhappy about what this does on 32b
>>
>> Considering that we can't have >4gb BOs on 32b, I think the concerns
>> are probably unwarranted.  But yes, I do look at Sashiko's reports
> 
> Probably we should add checks that obj_offset/range are not more than SIZE_MAX?

Wouldn't hurt

Konrad
