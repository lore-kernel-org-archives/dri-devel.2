Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B3606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eTNraG8l;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RXKfg7WR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5659C10F549;
	Tue, 24 Nov 2026 12:08:43 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE92810F540
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:08:32 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAubPc3299720
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zmgfroj/W5wSemUmgDwZDbeD
 UsUwCbkT3iD/PNQs864=; b=eTNraG8ltmF2Q+krFAvyvdwu580BykZXcUrOC5T7
 AIyTBtKnAXXmAnr0pMJXYl0x4XCQoG9WYzTDlB+lplVM22CxC5xKp0cNvfJldJMm
 p/nYRzRUpbLDOsxZWoTUSCzYzn1EwUb8H0zq0pFIC8rhkgH8t7C0jx7FnjQ/FBON
 Xjo/yNxUGnVpY1eJ2r0K2CrZOP5IHOZtMAFzIPYsDcdBixAGkc1TRpcFk12mXXMA
 gF2CrB+L5OdA/Iah2YqN8lrhl17qihE+poo/iFMLQ9nizK+Jr3osLm2/4pH6u/A+
 6BdLm8cwT12KSwQ3le9sswgD7xBAX4CLiKV2fcj3UTMfOA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yy12mrp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:08:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2edd25534afso38181595ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 04:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795522110; x=1796126910;
 darn=lists.freedesktop.org; 
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zmgfroj/W5wSemUmgDwZDbeDUsUwCbkT3iD/PNQs864=;
 b=RXKfg7WRFbCVQHtRbr4p5cuNsLxpmE9aNVSkI2gPt7Aq1tqealfs57/TXcshueocNV
 V/IHaeHFiZ3AJ0Oc0wEKz6WF2zm8nGSBh/nXA8rW8qAA4gE7/VxBaK9pWpqvPVkSxL9J
 mMAaf0tRumG8LggchihMdAB7BrW4nWOJoELJjqQTRevutpp3krgJLXV8zTExhvt6nLg/
 u+5ucYl20StlTYZp80HUwBrPfRZ1M8BBLOyEjF9AK4sL6u4b1zq45wRW2iwAWuyWFfyN
 oKoH90OmpDlLye0FMQ9loFhBJXlb0sLi1qoqlB8y04so3BHiniFNp2sKLeLk0VWKX30L
 D/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522110; x=1796126910;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zmgfroj/W5wSemUmgDwZDbeDUsUwCbkT3iD/PNQs864=;
 b=JCGq6w+fp5VTKD+gNiIbderE0DJUaNnPq/lHhFrVKGqoAava4gVvXOaEMMwhnwy0dH
 MaWamAK4Q6dZbi5j8Gino2ZlljwxLCHdqQXK2/EcZ5oJ2I8IrfavFLQhgxnXGXB18OaN
 IA8E/UtUl6d3hpbdpBzgHOFm9H+torbWEL4BHEKzmOPPyEiNnsyh9n3MZrvP8Jo9tVgs
 nAOX/CcPlJouQOQVXQF1/sg9aqVS05vHeI9rfgPC15G/aVA51JXKDWrtkPxOBkNYEEGu
 FqBmp8VKEyLvlPZNY+w+bCVtO3GvqK5IqOtNkK/Pn38CTR2aXM5WAj/cICXkE92OJClM
 lVmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGdsk1xaR9R2qi4wF5/dOo2Enpho8fvAwa3KR/Um4QfzTLBzAg7Ep5XE9FBw3it07UdReeH6vAITBc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+3hSFV95KYkvatvKG+BO/r2INkScBeWYMDSqNnKiE2z50nTLaw
 yisLXpADmf7+yAQM8WRZNPSlzBc35UGAU/HSTgBPRFjzYU2S6AyEJh3rs4TjnIIWkl8mhdkAmvt
 l0vbT7y2Sdn+Qik6Wbhpbr05ULu0817iGcpDq/23n3JQLH3A9roeLQpA8hIkKE77LFz+BjfU=
X-Gm-Gg: AZFdTZfw6vvS8mdwDL5qsaLE+rOyxVRqbUfpG7pkYvDdftTDsR1E01jGn9V7RZbl+DV
 +iDwV1fQAApueM+4lQKBDNPw/Xu0AGpX7fOery10ubN6wF+qDufXClIEt9IWRK7vkYfdUhcZ+oP
 50BuS+9QWONUvpOxw0dIO4tYzWQ26P9IKRA4+bd/2f0lhMrt/W2Dhbu8+w/AnAWVs1qj3yFHVrb
 B+d9f6qDQgb6iOD2xM07/NVq4Xa6eXYnYXdO8561LPPQiCj9VkNBvyMDH6ht0g7h2u+tLarD2yx
 cXN8bTpFd7P676qqpQlFuaDSHtQ1/HGF/9jkwls6L+hnC8Sug8S+BnxtIyYCD1/+jfmpYBDTevH
 QExPa485UwE4nvr1PUmGYr1W1aH4ABA+03zqV3NpGHet8AnO/69pB+kfxQaFnJ5BpM3f/KyDYOl
 MuAboXEw==
X-Received: by 2002:a17:903:2c50:b0:2e9:64b9:a330 with SMTP id
 d9443c01a7336-2f03f17d2ccmr137686945ad.11.1795522110367; 
 Tue, 24 Nov 2026 04:08:30 -0800 (PST)
X-Received: by 2002:a17:903:2c50:b0:2e9:64b9:a330 with SMTP id
 d9443c01a7336-2f03f17d2ccmr137686535ad.11.1795522109754; 
 Tue, 24 Nov 2026 04:08:29 -0800 (PST)
Received: from [10.219.56.91] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f0c2091sm67598715ad.20.2026.11.24.04.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 04:08:29 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------DwTtIqtgNrN0p9HVNeUIXHzv"
Message-ID: <294b2aff-093a-48ff-9a05-eddb5b107008@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:38:25 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: Add cache maintenance for non-coherent
 platforms
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de
References: <20260916185850.3686010-1-abhinav.parihar@oss.qualcomm.com>
 <6e4d0fc2-3fe6-4dff-bdc1-b6051f3becef@oss.qualcomm.com>
Content-Language: en-US
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
In-Reply-To: <6e4d0fc2-3fe6-4dff-bdc1-b6051f3becef@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: uIs3j_uiTjFBsIo2gq1Sng7lQ5msjYo8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX9A0Ysy49bqhu
 DsZx6vlW66SHg6xWiytGVbCbvPk7ZweMhehZcbjw/+Fh8t1uNeJ6WN8kOivEL8vbCcozrKjQPcb
 QNS46jnPFA7Ho/+X4ddOSoaIxufGIJ0=
X-Authority-Analysis: v=2.4 cv=JYspPkKV c=1 sm=1 tr=0 ts=6b057e3f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9ZjMTwCrgs7x7EAb5ggA:9 a=QEXdDO2ut3YA:10
 a=I6qf9Kfdgr7YPB13L0wA:9 a=Lkb6fZi1iW2McJqm:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX1Idut5I4qvlH
 6oMEzcA1zFQqUG13C/2rAeg9wH0RAxneKfgGZ9IgWAHYnvbiO/rbOm8ieOX0BYfIidpM9tUw+El
 9EMRd16MJ7yMAYYNzzctKhBZB5jqAa2AmrLS4orv3AyfYEceYeaHf4jzoxZtk2r/Rdg3nvW7ty4
 UH3FxfGWNLcDbUTbeR9lwhE0sm0zUmgKq2WEthEvpXEyU4meMVBIPtulb0xjOfoJbzP2MhOV08m
 G7YAEJZKk/XJ8zu3EFWWIGGLnuJM1jqTfWIANCrI9OlfAt8c5t8/EgZANFUFs4eYz1mxAAcWNeO
 +oWHwVweSFpDfsV8KcrSf3YNKO4fcmLA7Ps90tLCFCsAjyAkDhasO1pjlIkRYUn9thG+3qMEvI4
 ELT4vbnoae6cudb5NTHqzFxVl1QS2nQjo/DXKz1BhnLcNZZEUHPuyHjf1budpEtOIfw9eIl+Tbq
 Yo16A6J8UZt0KtcOqsw==
X-Proofpoint-GUID: uIs3j_uiTjFBsIo2gq1Sng7lQ5msjYo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240047
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------DwTtIqtgNrN0p9HVNeUIXHzv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/14/2026 10:12 AM, Ekansh Gupta wrote:
> On 17-09-2026 00:28, Abhinav Parihar wrote:
>> Some platforms using fastrpc do not support DMA coherency on
>> HLOS. On such systems, explicit cache maintenance is
>> required to ensure data consistency for RPC argument buffers.
>>
>> Add cache maintenance for argument buffers when operating on
>> non-coherent platforms:
>> - Flush input buffers before invoking RPC to ensure CPU writes are
>>    visible to the DSP
>> - Invalidate output buffers after RPC completion to ensure DSP
>>    writes are visible to the CPU
>>
>> Introduce helper functions fastrpc_flush_args() and
>> fastrpc_inv_args() to perform the required dma-buf cache
>> operations. These are invoked only when the device is not marked
>> as DMA coherent.
>>
>> The coherency capability is determined using the "dma-coherent"
>> device tree property and stored per session context.
>>
>> This ensures correct data synchronization on platforms lacking
>> DMA coherency, while avoiding unnecessary overhead on coherent
>> systems.
>>
>> Signed-off-by: Abhinav Parihar<abhinav.parihar@oss.qualcomm.com>
>> ---
>>
>>   Patch [v1]:https://lore.kernel.org/all/20260604194811.2437567-1-abhinav.parihar@oss.qualcomm.com/
>>
>>   Changes in v2:
>>    - Fix buffer overlap handling to ensure cache maintenance is performed
>>      when input and output buffers overlap and the overlap calculation
>>      suppresses the buffer's mstart/mend range.
>>    - Add a do_cmo flag to track buffers that require cache maintenance
>>      even when their overlap range is clipped.
>>    - Invalidate output buffers before sending the RPC request, preventing
>>      stale CPU cache lines from being written back while the DSP updates
>>      the buffers.
>>    - Use DMA_FROM_DEVICE consistently for both begin_cpu_access() and
>>      end_cpu_access() when invalidating output buffers.
>>
>>   drivers/misc/fastrpc.c | 77 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 76 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index d4fac2caca86..83d04b9d2ea0 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -217,6 +217,7 @@ struct fastrpc_buf_overlap {
>>   	u64 mstart;
>>   	u64 mend;
>>   	u64 offset;
>> +	bool do_cmo;
>>   };
>>   
>>   struct fastrpc_buf {
>> @@ -292,6 +293,7 @@ struct fastrpc_session_ctx {
>>   	int sid;
>>   	bool used;
>>   	bool valid;
>> +	bool coherent;
>>   };
>>   
>>   struct fastrpc_soc_data {
>> @@ -655,7 +657,9 @@ static int olaps_cmp(const void *a, const void *b)
>>   static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
>>   {
>>   	u64 max_end = 0;
>> +	int max_raix = -1;
>>   	int i;
>> +	int inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
>>   
>>   	for (i = 0; i < ctx->nbufs; ++i) {
>>   		ctx->olaps[i].start = ctx->args[i].ptr;
>> @@ -675,6 +679,9 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
>>   			if (ctx->olaps[i].end > max_end) {
>>   				max_end = ctx->olaps[i].end;
> should you update max_raix here also?>
Ack
> 			} else {
>> +				if ((max_raix < inbufs && ctx->olaps[i].raix + 1 > inbufs) ||
>> +					(ctx->olaps[i].raix < inbufs && max_raix + 1 > inbufs))
> if ((max_raix < inbufs) != (ctx->olaps[i].raix < inbufs))
Ack
>> +					ctx->olaps[i].do_cmo = true;
>>   				ctx->olaps[i].mend = 0;
>>   				ctx->olaps[i].mstart = 0;
>>   			}
>> @@ -684,6 +691,7 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
>>   			ctx->olaps[i].mstart = ctx->olaps[i].start;
>>   			ctx->olaps[i].offset = 0;
>>   			max_end = ctx->olaps[i].end;
>> +			max_raix = ctx->olaps[i].raix;
>>   		}
>>   	}
>>   }
>> @@ -703,6 +711,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>>   
>>   	INIT_LIST_HEAD(&ctx->node);
>>   	ctx->fl = user;
>> +	ctx->sc = sc;
>>   	ctx->nscalars = REMOTE_SCALARS_LENGTH(sc);
>>   	ctx->nbufs = REMOTE_SCALARS_INBUFS(sc) +
>>   		     REMOTE_SCALARS_OUTBUFS(sc);
>> @@ -728,7 +737,6 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>>   	/* Take a reference to user, released in fastrpc_context_free() */
>>   	fastrpc_user_get(user);
>>   
>> -	ctx->sc = sc;
>>   	ctx->retval = -1;
>>   	ctx->pid = current->pid;
>>   	ctx->client_id = user->client_id;
>> @@ -1067,6 +1075,64 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
>>   	return 0;
>>   }
>>   
>> +static void fastrpc_flush_args(struct fastrpc_invoke_ctx *ctx)
>> +{
>> +	union fastrpc_remote_arg *rpra = ctx->rpra;
>> +	int i, inbufs, outbufs;
>> +
>> +	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
>> +	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
>> +
>> +	for (i = 0; i < inbufs + outbufs; ++i) {
> ctx->nbufs instead of inbufs + outbufs
Ack
>> +		int raix = ctx->olaps[i].raix;
>> +		struct fastrpc_map *map = ctx->maps[raix];
>> +
>> +		if (raix + 1 > inbufs)
>> +			continue;
>> +		if (!map || !map->buf)
>> +			continue;
>> +
>> +		if (rpra[raix].buf.len && (ctx->olaps[i].mstart || ctx->olaps[i].do_cmo)) {
>> +			dma_buf_begin_cpu_access(map->buf, DMA_TO_DEVICE);
>> +			dma_buf_end_cpu_access(map->buf, DMA_TO_DEVICE);
>> +		}
>> +	}
>> +}
>> +
>> +static void fastrpc_inv_args(struct fastrpc_invoke_ctx *ctx)
>> +{
>> +	union fastrpc_remote_arg *rpra = ctx->rpra;
>> +	int i, inbufs, outbufs;
>> +
>> +	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
>> +	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
>> +
>> +	for (i = 0; i < inbufs + outbufs; ++i) {
> ctx->nbufs>
Ack
>   +		int raix = ctx->olaps[i].raix;
>> +		struct fastrpc_map *map = ctx->maps[raix];
>> +
>> +		if (raix + 1 <= inbufs)
>> +			continue;
>> +		if (!rpra[raix].buf.len)
>> +			continue;
>> +		if (!map || !map->buf)
>> +			continue;
>> +
>> +		/*
>> +		 * Skip invalidation if the argument overlaps with the
>> +		 * RPC control header page.
>> +		 */
>> +		if (((uintptr_t)rpra & PAGE_MASK) ==
>> +			((uintptr_t)rpra[raix].buf.pv & PAGE_MASK))
> is this possible? for fd buffers, buf.pv is going to be a userspace VA
> and rpta addr is going to be a kernel VA, those cannot be equal.> +		
> continue;
Ack, removed the check as NA
>> +
>> +		if (ctx->olaps[i].mstart || ctx->olaps[i].do_cmo) {
>> +			dma_buf_begin_cpu_access(map->buf, DMA_FROM_DEVICE);
>> +			dma_buf_end_cpu_access(map->buf, DMA_FROM_DEVICE);
>> +		}
>> +	}
>> +}
>> +
>>   static struct fastrpc_invoke_buf *fastrpc_invoke_buf_start(union fastrpc_remote_arg *pra, int len)
>>   {
>>   	return (struct fastrpc_invoke_buf *)(&pra[len]);
>> @@ -1191,6 +1257,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>>   		}
>>   	}
>>   
>> +	if (!ctx->fl->sctx->coherent)
>> +		fastrpc_flush_args(ctx);
>> +
>>   	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
>>   		list[i].num = ctx->args[i].length ? 1 : 0;
>>   		list[i].pgidx = i;
>> @@ -1376,6 +1445,8 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>>   	if (err)
>>   		goto bail;
>>   
>> +	if (!fl->sctx->coherent)
>> +		fastrpc_inv_args(ctx);
>>   	/* make sure that all CPU memory writes are seen by DSP */
>>   	dma_wmb();
>>   	/* Send invoke buffer to remote dsp */
>> @@ -1396,6 +1467,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>>   
>>   	/* make sure that all memory writes by DSP are seen by CPU */
>>   	dma_rmb();
>> +	if (!fl->sctx->coherent)
>> +		fastrpc_inv_args(ctx);
>> +
>>   	/* populate all the output buffers with results */
>>   	err = fastrpc_put_args(ctx, kernel);
>>   	if (err)
>> @@ -2393,6 +2467,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>>   	sess->used = false;
>>   	sess->valid = true;
>>   	sess->dev = dev;
>> +	sess->coherent = of_property_read_bool(dev->of_node, "dma-coherent");
> see if you can use of_dma_is_coherent() instead.>  	dev_set_drvdata(dev,
> sess);
Ack, went ahead with of_dma_is_coherent
>>   	sess->sid = sid;
>>   
--------------DwTtIqtgNrN0p9HVNeUIXHzv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/14/2026 10:12 AM, Ekansh Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:6e4d0fc2-3fe6-4dff-bdc1-b6051f3becef@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">On 17-09-2026 00:28, Abhinav Parihar wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Some platforms using fastrpc do not support DMA coherency on
HLOS. On such systems, explicit cache maintenance is
required to ensure data consistency for RPC argument buffers.

Add cache maintenance for argument buffers when operating on
non-coherent platforms:
- Flush input buffers before invoking RPC to ensure CPU writes are
  visible to the DSP
- Invalidate output buffers after RPC completion to ensure DSP
  writes are visible to the CPU

Introduce helper functions fastrpc_flush_args() and
fastrpc_inv_args() to perform the required dma-buf cache
operations. These are invoked only when the device is not marked
as DMA coherent.

The coherency capability is determined using the "dma-coherent"
device tree property and stored per session context.

This ensures correct data synchronization on platforms lacking
DMA coherency, while avoiding unnecessary overhead on coherent
systems.

Signed-off-by: Abhinav Parihar <a class="moz-txt-link-rfc2396E" href="mailto:abhinav.parihar@oss.qualcomm.com">&lt;abhinav.parihar@oss.qualcomm.com&gt;</a>
---

 Patch [v1]: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20260604194811.2437567-1-abhinav.parihar@oss.qualcomm.com/">https://lore.kernel.org/all/20260604194811.2437567-1-abhinav.parihar@oss.qualcomm.com/</a>

 Changes in v2:
  - Fix buffer overlap handling to ensure cache maintenance is performed
    when input and output buffers overlap and the overlap calculation
    suppresses the buffer's mstart/mend range.
  - Add a do_cmo flag to track buffers that require cache maintenance
    even when their overlap range is clipped.
  - Invalidate output buffers before sending the RPC request, preventing
    stale CPU cache lines from being written back while the DSP updates
    the buffers.
  - Use DMA_FROM_DEVICE consistently for both begin_cpu_access() and
    end_cpu_access() when invalidating output buffers.

 drivers/misc/fastrpc.c | 77 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d4fac2caca86..83d04b9d2ea0 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -217,6 +217,7 @@ struct fastrpc_buf_overlap {
 	u64 mstart;
 	u64 mend;
 	u64 offset;
+	bool do_cmo;
 };
 
 struct fastrpc_buf {
@@ -292,6 +293,7 @@ struct fastrpc_session_ctx {
 	int sid;
 	bool used;
 	bool valid;
+	bool coherent;
 };
 
 struct fastrpc_soc_data {
@@ -655,7 +657,9 @@ static int olaps_cmp(const void *a, const void *b)
 static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 {
 	u64 max_end = 0;
+	int max_raix = -1;
 	int i;
+	int inbufs = REMOTE_SCALARS_INBUFS(ctx-&gt;sc);
 
 	for (i = 0; i &lt; ctx-&gt;nbufs; ++i) {
 		ctx-&gt;olaps[i].start = ctx-&gt;args[i].ptr;
@@ -675,6 +679,9 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 			if (ctx-&gt;olaps[i].end &gt; max_end) {
 				max_end = ctx-&gt;olaps[i].end;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">should you update max_raix here also?&gt;  </pre>
    </blockquote>
    Ack
    <blockquote type="cite"
      cite="mid:6e4d0fc2-3fe6-4dff-bdc1-b6051f3becef@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">			} else {
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+				if ((max_raix &lt; inbufs &amp;&amp; ctx-&gt;olaps[i].raix + 1 &gt; inbufs) ||
+					(ctx-&gt;olaps[i].raix &lt; inbufs &amp;&amp; max_raix + 1 &gt; inbufs))
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">if ((max_raix &lt; inbufs) != (ctx-&gt;olaps[i].raix &lt; inbufs))</pre>
    </blockquote>
    Ack
    <blockquote type="cite"
      cite="mid:6e4d0fc2-3fe6-4dff-bdc1-b6051f3becef@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+					ctx-&gt;olaps[i].do_cmo = true;
 				ctx-&gt;olaps[i].mend = 0;
 				ctx-&gt;olaps[i].mstart = 0;
 			}
@@ -684,6 +691,7 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 			ctx-&gt;olaps[i].mstart = ctx-&gt;olaps[i].start;
 			ctx-&gt;olaps[i].offset = 0;
 			max_end = ctx-&gt;olaps[i].end;
+			max_raix = ctx-&gt;olaps[i].raix;
 		}
 	}
 }
@@ -703,6 +711,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 
 	INIT_LIST_HEAD(&amp;ctx-&gt;node);
 	ctx-&gt;fl = user;
+	ctx-&gt;sc = sc;
 	ctx-&gt;nscalars = REMOTE_SCALARS_LENGTH(sc);
 	ctx-&gt;nbufs = REMOTE_SCALARS_INBUFS(sc) +
 		     REMOTE_SCALARS_OUTBUFS(sc);
@@ -728,7 +737,6 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	/* Take a reference to user, released in fastrpc_context_free() */
 	fastrpc_user_get(user);
 
-	ctx-&gt;sc = sc;
 	ctx-&gt;retval = -1;
 	ctx-&gt;pid = current-&gt;pid;
 	ctx-&gt;client_id = user-&gt;client_id;
@@ -1067,6 +1075,64 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 	return 0;
 }
 
+static void fastrpc_flush_args(struct fastrpc_invoke_ctx *ctx)
+{
+	union fastrpc_remote_arg *rpra = ctx-&gt;rpra;
+	int i, inbufs, outbufs;
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx-&gt;sc);
+	outbufs = REMOTE_SCALARS_OUTBUFS(ctx-&gt;sc);
+
+	for (i = 0; i &lt; inbufs + outbufs; ++i) {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">ctx-&gt;nbufs instead of inbufs + outbufs</pre>
    </blockquote>
    Ack
    <blockquote type="cite"
      cite="mid:6e4d0fc2-3fe6-4dff-bdc1-b6051f3becef@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+		int raix = ctx-&gt;olaps[i].raix;
+		struct fastrpc_map *map = ctx-&gt;maps[raix];
+
+		if (raix + 1 &gt; inbufs)
+			continue;
+		if (!map || !map-&gt;buf)
+			continue;
+
+		if (rpra[raix].buf.len &amp;&amp; (ctx-&gt;olaps[i].mstart || ctx-&gt;olaps[i].do_cmo)) {
+			dma_buf_begin_cpu_access(map-&gt;buf, DMA_TO_DEVICE);
+			dma_buf_end_cpu_access(map-&gt;buf, DMA_TO_DEVICE);
+		}
+	}
+}
+
+static void fastrpc_inv_args(struct fastrpc_invoke_ctx *ctx)
+{
+	union fastrpc_remote_arg *rpra = ctx-&gt;rpra;
+	int i, inbufs, outbufs;
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx-&gt;sc);
+	outbufs = REMOTE_SCALARS_OUTBUFS(ctx-&gt;sc);
+
+	for (i = 0; i &lt; inbufs + outbufs; ++i) {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">ctx-&gt;nbufs&gt;</pre>
    </blockquote>
    Ack
    <blockquote type="cite"
      cite="mid:6e4d0fc2-3fe6-4dff-bdc1-b6051f3becef@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre"> +		int raix = ctx-&gt;olaps[i].raix;
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+		struct fastrpc_map *map = ctx-&gt;maps[raix];
+
+		if (raix + 1 &lt;= inbufs)
+			continue;
+		if (!rpra[raix].buf.len)
+			continue;
+		if (!map || !map-&gt;buf)
+			continue;
+
+		/*
+		 * Skip invalidation if the argument overlaps with the
+		 * RPC control header page.
+		 */
+		if (((uintptr_t)rpra &amp; PAGE_MASK) ==
+			((uintptr_t)rpra[raix].buf.pv &amp; PAGE_MASK))
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">is this possible? for fd buffers, buf.pv is going to be a userspace VA
and rpta addr is going to be a kernel VA, those cannot be equal.&gt; +		
continue;</pre>
    </blockquote>
    Ack, removed the check as NA
    <blockquote type="cite"
      cite="mid:6e4d0fc2-3fe6-4dff-bdc1-b6051f3becef@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+		if (ctx-&gt;olaps[i].mstart || ctx-&gt;olaps[i].do_cmo) {
+			dma_buf_begin_cpu_access(map-&gt;buf, DMA_FROM_DEVICE);
+			dma_buf_end_cpu_access(map-&gt;buf, DMA_FROM_DEVICE);
+		}
+	}
+}
+
 static struct fastrpc_invoke_buf *fastrpc_invoke_buf_start(union fastrpc_remote_arg *pra, int len)
 {
 	return (struct fastrpc_invoke_buf *)(&amp;pra[len]);
@@ -1191,6 +1257,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		}
 	}
 
+	if (!ctx-&gt;fl-&gt;sctx-&gt;coherent)
+		fastrpc_flush_args(ctx);
+
 	for (i = ctx-&gt;nbufs; i &lt; ctx-&gt;nscalars; ++i) {
 		list[i].num = ctx-&gt;args[i].length ? 1 : 0;
 		list[i].pgidx = i;
@@ -1376,6 +1445,8 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
+	if (!fl-&gt;sctx-&gt;coherent)
+		fastrpc_inv_args(ctx);
 	/* make sure that all CPU memory writes are seen by DSP */
 	dma_wmb();
 	/* Send invoke buffer to remote dsp */
@@ -1396,6 +1467,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 
 	/* make sure that all memory writes by DSP are seen by CPU */
 	dma_rmb();
+	if (!fl-&gt;sctx-&gt;coherent)
+		fastrpc_inv_args(ctx);
+
 	/* populate all the output buffers with results */
 	err = fastrpc_put_args(ctx, kernel);
 	if (err)
@@ -2393,6 +2467,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	sess-&gt;used = false;
 	sess-&gt;valid = true;
 	sess-&gt;dev = dev;
+	sess-&gt;coherent = of_property_read_bool(dev-&gt;of_node, "dma-coherent");
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">see if you can use of_dma_is_coherent() instead.&gt;  	dev_set_drvdata(dev,
sess);</pre>
    </blockquote>
    Ack, went ahead with <span style="white-space: pre-wrap">of_dma_is_coherent</span>
    <blockquote type="cite"
      cite="mid:6e4d0fc2-3fe6-4dff-bdc1-b6051f3becef@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	sess-&gt;sid = sid;
 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------DwTtIqtgNrN0p9HVNeUIXHzv--
