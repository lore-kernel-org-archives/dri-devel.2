Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84294ED7B87
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C38A310E5A9;
	Tue, 14 Apr 2026 08:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cwLUaFqW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IuaWcIfF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D87510E5A6
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 08:37:55 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63E6dv5Y1479154
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 08:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d4RCYYRDRdY5PM4k7osDGGtFZVRpfQ8OgMr9WbE+nXQ=; b=cwLUaFqWuKYwLs9S
 KMThiPB5M95mbO/nrpnHUcvVJPF+SVx4q2HlEa3ougNILvaZlyCIUrYYVVRPkTjR
 VvyoUd3XhSB5KMI7eavM8Ieb9o4LtPUWyhxEYNmqZPm6WKOlb1bxjzcrYsdo6jT4
 /bHbFpcP0YnSPTdUR4wQ8R/EdyXLwYGE/mUVQDcgkEIVZYrgSMyhxgA+gnmnZLoT
 f7KRm4aiA7gJjHxcNjdw4Ei52wzcIG5M0plrSymsJlWaEc1v7kDJpmE9XKYKXZoU
 iodt1uLIYjYhdk0aauep+fRv+KqJ1Y2iQVK7dLfcCeueQ8zmyecCLahQUjJzr4LK
 Zs9C4w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87j1txb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 08:37:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b24611696eso39812245ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 01:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776155874; x=1776760674;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d4RCYYRDRdY5PM4k7osDGGtFZVRpfQ8OgMr9WbE+nXQ=;
 b=IuaWcIfFdU9jD9iHMNFq9RM4NvF+YGS9bp4ox9XvgLnAu1YaabIyQYYfuSNZJJdwKz
 Kcebebclksweryiaheq3nb+yWD7n2JHwjMIh+zWWf1uLp1SNifMpxKYlhDMYdm+/L9RR
 g1gMIAPzwfGZXqMkcd1VRoGsbxgLHTn19oM4iypoEK9c7+e9w+GeuG/819Z7BbwgyhAP
 ksLQYMZQ0IjyusqpfqxLzPkZDI70j++zrmoFSAkGURBgb40zIoC0u7CnUOOJcp5nQflm
 nNuBTMuX9Ubwc/FZjl2unjxXKXzlkKCbE9PuOIjexF0wsiTLaGmWGsHwR/3swR7TbgSF
 yxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776155874; x=1776760674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4RCYYRDRdY5PM4k7osDGGtFZVRpfQ8OgMr9WbE+nXQ=;
 b=LVzSz5Sd4DUTB3Q4Il4typaZLplscC3gxQ1sf/2dxK2OApXNAtFRJjmyv/0/OdkRIM
 /VM0xM5U53kId8AK+BJqIlOVRIEd7CKXgKBCwrqWOJ0/BphXJHE35BPjQ4rHN6N4ruKc
 9FmX/NI3d5MGopJ1AcdSJlWAXBvvV4Oo9SrYW2TqFmALGgdgMVYXkiZDKrXZ+h+ae4Tx
 +ux80dvDsVcXNL+Iqx+2v0AlC1jDipXe+Qv+NNFeQbFw8YKA0XmY+U+vYN+laT4LMaEM
 JsFT+SsLTPtk031HrPifpm4oTU8K8gY0JtcNsLfuxC32kvgnzkz/43DEl8R8ualKfmtX
 0XGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8h3gGQPK+p3vQeqsOSWs/G0MkNF12RqlqYM5/BaTVgytoRuxGHusLMC04EXC4RGHVrcO0/BzOz938=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0HMKvZUi7itWrYEdnxIk97JqVPC10bnL/enJDvOJMji+d/RyO
 J8Rq2TP6etl8yAMRV3UgfyvvW04raq03Yz+/O9TjUmI8OOYCpU0RgLY4u25lVrZt0pspAWhpDRM
 mB+zsmtJwqv1tbfES6NYOXS7dodH8bb/C7/an/cHxzgtJJAUpr8Etwt72f0y5oMf0sK0Q7JE=
X-Gm-Gg: AeBDiesPjJ66Q/23pa9q8IbDzw+1qQoQeMHPeyu5weXXO3EJul5WdwCSpL9XH1TqriS
 bSfg6YDNDmFydHKpdYqIUc9vPFRQMgDjb4uS+7VUgELkI/VnapSn56ZJ3iQtsPQnXIBB7kKcODF
 eFrx9j5+NV9VHy1OgsdEQ4j+Dr+PL4jlyFybJRem3A0yLM5VYkSQb2fDxx9NeGKXRJY4qMPzj8S
 wxlRoh2sCfPI+sEPYuW/eIG03TUq58hM9Xwc/j/4pu6z5XwPXqJnJ3uR02E6tldwuYLqJ79gV9I
 8I0QlSWw/LwkF5W/JN5Kro/FzyFZrw7D14mLLnm3wTy5AaHRydmcr5HTmAFVH8vpRTUUXYd3+UW
 YWP24jJL80BLJUZJ6JoXSwlWiv6c0DFTWTHEatYPCdlJG7/n1aA==
X-Received: by 2002:a17:903:2f08:b0:2b2:5314:e96a with SMTP id
 d9443c01a7336-2b2d5a6de57mr179074355ad.34.1776155874013; 
 Tue, 14 Apr 2026 01:37:54 -0700 (PDT)
X-Received: by 2002:a17:903:2f08:b0:2b2:5314:e96a with SMTP id
 d9443c01a7336-2b2d5a6de57mr179074035ad.34.1776155873514; 
 Tue, 14 Apr 2026 01:37:53 -0700 (PDT)
Received: from [10.204.79.79] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4daede9sm181511365ad.14.2026.04.14.01.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 01:37:52 -0700 (PDT)
Message-ID: <651ec8a6-60e4-4b5a-bdfb-c23c69afb34f@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 14:07:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] misc: fastrpc: Move fdlist to invoke context
 structure
To: Srinivas Kandagatla <srini@kernel.org>, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
 konrad.dybcio@oss.qualcomm.com
References: <20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com>
 <20260402054923.3061925-2-ekansh.gupta@oss.qualcomm.com>
 <44d79f33-26ea-4a57-b292-74ef474fe0a9@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <44d79f33-26ea-4a57-b292-74ef474fe0a9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: W0yTDSIs21EqjGXrT4AqPsSj14UA_fLk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA3OSBTYWx0ZWRfX/ez7CiDhC4Hn
 P+DoxDujo5bP/NhtEHAnDT4Jeiq1fvEtEEtn7GHtN9BTKMk+ewKhgA7QCEmOr6Kj4a9VTlBY5Es
 4f2Hf/i1BrJkREiTB4rmw0bmD8p0qvHSwmbM32B4EHmZCQ5qKqAu2tsSMFEHDyHwaycleLzhOA1
 aw3Q37TRcBc1grrBzCBXHCmke6j5eV8Zqe67zcj7F9HI1a1iMo+D3eOVh4kNoAYe5C76yTAvuou
 Pgbk5LlJkLEjxbOjTvKSSSeK3GB6uH9EjLQfyLbsKJizgA4dW+jVFYKewdqiWQp4+vNnq7z9TVM
 gWk22vtJS4f4Yq1mh+vgtlNfBJHNuj+aeoQd4IBk3/U4DQ73e7Q8GJ3PSbuQbaRax00w11C11Y7
 WR+T0uUq8iyVH2o59CaLY2gZbNblALiXn5msBjk8L4Pn+ncRagfCtmznZhGz2EZejKaKRE1oGQf
 b7TGJ24CwUPpAteWROQ==
X-Proofpoint-ORIG-GUID: W0yTDSIs21EqjGXrT4AqPsSj14UA_fLk
X-Authority-Analysis: v=2.4 cv=DrpmPm/+ c=1 sm=1 tr=0 ts=69ddfce2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=E3m_rBUOw5yWVkgBiJUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140079
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

On 13-04-2026 19:38, Srinivas Kandagatla wrote:
> 
> 
> On 4/2/26 5:49 AM, Ekansh Gupta wrote:
>> The fdlist is currently part of the meta buffer which is set during
>> fastrpc_get_args(), this fdlist is getting recalculated during
>> fastrpc_put_args().
>>
>> Move fdlist to the invoke context structure to improve maintainability
>> and reduce redundancy. This centralizes its handling and simplifies
>> meta buffer preparation and reading logic.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/misc/fastrpc.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 47356a5d5804..11f4ae749e51 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -233,6 +233,7 @@ struct fastrpc_invoke_ctx {
>>  	int pid;
>>  	int client_id;
>>  	u32 sc;
>> +	u64 *fdlist;
>>  	u32 *crc;
>>  	u64 ctxid;
>>  	u64 msg_sz;
>> @@ -1016,6 +1017,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>>  	rpra = ctx->buf->virt;
>>  	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
>>  	pages = fastrpc_phy_page_start(list, ctx->nscalars);
>> +	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
>>  	args = (uintptr_t)ctx->buf->virt + metalen;
>>  	rlen = pkt_size - metalen;
>>  	ctx->rpra = rpra;
>> @@ -1118,18 +1120,11 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>>  	union fastrpc_remote_arg *rpra = ctx->rpra;
>>  	struct fastrpc_user *fl = ctx->fl;
>>  	struct fastrpc_map *mmap = NULL;
>> -	struct fastrpc_invoke_buf *list;
>> -	struct fastrpc_phy_page *pages;
>> -	u64 *fdlist;
>> -	int i, inbufs, outbufs, handles;
>> +	u64 *fdlist = ctx->fdlist;
> 
> fdlist is available after input , output buffers and handles.
> 
> why this is now changed to nscalars?
We can replace it as,

nscalars = inbufs + outbufs + handles


> 
> --srini
>> +	int i, inbufs;
>>  	int ret = 0;
>>  
>>  	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
>> -	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
>> -	handles = REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDLES(ctx->sc);
>> -	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
>> -	pages = fastrpc_phy_page_start(list, ctx->nscalars);
>> -	fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
>>  
>>  	for (i = inbufs; i < ctx->nbufs; ++i) {
>>  		if (!ctx->maps[i]) {
> 

