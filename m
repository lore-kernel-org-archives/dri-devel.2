Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B89FA0C30
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 05:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB8910E676;
	Wed, 15 Apr 2026 05:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQTpZRvR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jwQFd2N/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3899010E676
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:43:22 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63F3CTZi030706
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rI/VDmFKtZChyz+72XqrS31+1Ai9jjzqnhk2Yjgr/4o=; b=PQTpZRvRseAAFNOQ
 3J1Bixsbz+BBc11k5tOGql4a6BHu/OPxBgcIu4Hi3NQWjcZrES5Ban3tSSUxXQru
 tduqIhUwMBc6NiqryC9k6IlDiGISNbLaeyJI8enmL3zVUgSGiPgevngRJn/Vd1nd
 KmhhFlkgG1VVbj4zNiCI8df4aRaEIgr4HwJQWssKVkSRGxp4tCUnJYgRbxgaZRn0
 3PtT2XC/39WVhxHJrWPJ7B3lKibNILnIkkJuKQUntWaqKUktVhmA+YqU7mrLD3d0
 K5ZLnhL/cjjzviKqvePTuYWlM8yB2jw3DOakz9jDmbpSKg1W77gReGsl1WCJbtI4
 WvTuPg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhkgmkh2s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:43:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c76b6db8bb2so3871662a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 22:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776231800; x=1776836600;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rI/VDmFKtZChyz+72XqrS31+1Ai9jjzqnhk2Yjgr/4o=;
 b=jwQFd2N/iKsoqAUhzctKEBY4Ipj61NNpr0f2K0DKep0SHuW1CZOTVWtvw9XLEt+dHo
 7QofFUSdIkVkd/bm9E1+CRDsPqFQgQ70vEHijnPHVjJ/rH1onY4ryfh/TqCka5H0PoOe
 wVbKlZyX8LKD7ZJOozZljFsNxb28HpZ+rr3xg/c6AmEqhmmCFXnRQy+G7JdZChm8Fdef
 egC5Iz8RcSXz9VAPlaBqFLWxe6c0QuJr8UHWR+eWmD3SM/aZLExqy4DwXU5a51RfooXb
 hxu1qs04szdV/haLEO0MVZWyDztNMIGvbSvp/KYtDvOwi/ImMeSww7rs6Nh90X7tv3s/
 gk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776231800; x=1776836600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rI/VDmFKtZChyz+72XqrS31+1Ai9jjzqnhk2Yjgr/4o=;
 b=auo5b5ENrP/WXhalxdZ8jWPIX56r7kjSQ304Kavi5SvNgfK//cPEEK7juO6mnHA5T2
 AEKZngQbCB6jG1bMG/UFL3C7A1fzAqVmUvLovLA3y15sNaXT3MYSE+AZch1SnndPz4aF
 HNywT3Wedx7wVLTZ+e05Hxi2IuMlHf+obUWwa4ccq1m6tWoxt7t2lg9GxKDjx4+mzvo4
 FQQCRd4gPvqWIXVMZw9F7ZhHupJCkdPVu0l05kPgxSwR90qdmCMiqerO5HA5mJTsRBka
 zYQJQrw/BzqlvCdFn61JmI7sh+hx5zp5RDHk+CkEpUJeKDCY7oXA0WxubBp4gOLtg9iU
 QXgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ99Z6Db6Xvv7I8XpiPZuU5ES+ICLo+IVVvR8K6+0/0SZh5vFwVjis8TFE4SbWaqDEUXxB0kpQMGbtE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQyCdDUPS7ppMjbh8JGngScU5Woi2rZaHjzMtPSySR29cSNCTd
 b5luCLXa7jSBvUPdGOEZci/gTwLDleqM0YptrA5fGHaTgOVtnKV8x9JGqXf6eYla4xVw2y/dl+I
 BuqEBjjHSHs6q1dA54pg9ytWAQw35R8GfeZVxT8kQfsgs5awvNoSKWssa7OAjIMq6xBAYz5c=
X-Gm-Gg: AeBDievSXopsPOaPtmILPiW9OU9IgkDgLYdeKC4chSCxRPW3vaVwwnMVLzT/z0YRnI4
 dprR4Bg7AS4JCvh3gswlHOn6CpmHep/KRkyehQO32C4I3N3rTjKLKfvhE3U/M7gEPLCmafxoYDA
 bANvCopbFzHKAm18AbZqLimNHzQKwwc5tQauQdPGoeQPAF5olGi+7NM0Pz0W9Q6yVi96fGiWGHp
 Ox49dwsr1nTRNyyM0LU2zaHc6e4NacBczb79PRq2tPqwAtjZfhiFWksvXuIyDlBGniu9vc1CJhu
 kgGE+tTLuYzIFjBnV/eVhkkCu5n/er2d3mnYAH2V2Z00w+1luJC7I/PnT/xV8KvOEn+OO3mM1mS
 JuiPBVNN5TW82hDmYKDcmLXP25bRl76OWyzepNSCmk5XjMHc4C+MCrY6uoyxm1A==
X-Received: by 2002:a05:6a20:a122:b0:39c:787:f17a with SMTP id
 adf61e73a8af0-39fe3fae289mr22107223637.41.1776231799740; 
 Tue, 14 Apr 2026 22:43:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:a122:b0:39c:787:f17a with SMTP id
 adf61e73a8af0-39fe3fae289mr22107185637.41.1776231799167; 
 Tue, 14 Apr 2026 22:43:19 -0700 (PDT)
Received: from [10.204.78.192] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79581a2fc2sm630150a12.21.2026.04.14.22.43.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 22:43:18 -0700 (PDT)
Message-ID: <9b69ad77-9aba-4df0-95ac-d8832f7e9f9d@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:13:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
To: Srinivas Kandagatla <srini@kernel.org>, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
 konrad.dybcio@oss.qualcomm.com
References: <20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com>
 <20260402054923.3061925-5-ekansh.gupta@oss.qualcomm.com>
 <86853aa3-4af2-4670-a58e-342877e81ef9@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <86853aa3-4af2-4670-a58e-342877e81ef9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA1MCBTYWx0ZWRfX4+l66X5MGeXx
 z/jSiizGaJy1Yf0Azv5P7r67EH1J7UEDIC1lv4/WOU3YBk4LBa+Eb6f5PwouTSUjN3XuH91a4OH
 S0zRRUXnGEm0pfmPOGadgGK8O9C/8cZ8LoPSXOnzKTd1IZ6vOGy2CaAlv8A45kX46fz8Xnw9WmQ
 bclPz+ovH8kMsgOKiu+W7dk48kSC5pYuceyle6aPbRLLHncIfCsuj3b5eIgTCYmfa+CZrNsOX3q
 ztyHb1Jz1Fk5M87r8W85+O0fzANHsTWCaWsj+FPCuJWny7e4MIHxvRziEgGYi8LIGt8be0y8KMs
 sq05rYZfyxP/kuOcWidS86CXI/elJS9Dx99hS31lwqdPE0vKmL+0uDypMriDa3pl9XD7q0LAfhq
 QUo6x2HxCWdk4D0KuMAwLZC41ptXrK4hAdY8dB0S8g+KMi7BfvxbcGbZWgzYk24De+YVbWm/emG
 coIbyUvpfzUCsAwbkvQ==
X-Proofpoint-ORIG-GUID: jwTklLoftQCdbCA6Hy01iZee6mCSvgff
X-Proofpoint-GUID: jwTklLoftQCdbCA6Hy01iZee6mCSvgff
X-Authority-Analysis: v=2.4 cv=HJLz0Itv c=1 sm=1 tr=0 ts=69df2578 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=5DFYxTXXmBTTg87Ck3YA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150050
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

On 13-04-2026 20:20, Srinivas Kandagatla wrote:
> 
> 
> On 4/2/26 5:49 AM, Ekansh Gupta wrote:
>> For any remote call to DSP, after sending an invocation message,
>> fastRPC driver waits for glink response and during this time the
>> CPU can go into low power modes. This adds latency to overall fastrpc
>> call as CPU wakeup and scheduling latencies are included. Add polling
>> mode support with which fastRPC driver will poll continuously on a
>> memory after sending a message to remote subsystem which will eliminate
>> CPU wakeup and scheduling latencies and reduce fastRPC overhead. In case
>> poll timeout happens, the call will fallback to normal RPC mode.  Poll
>> mode can be enabled by user by using FASTRPC_IOCTL_SET_OPTION ioctl
>> request with FASTRPC_POLL_MODE request id.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/misc/fastrpc.c      | 132 ++++++++++++++++++++++++++++++++++--
>>  include/uapi/misc/fastrpc.h |  10 +++
>>  2 files changed, 135 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 4363e0cc296b..25f385f4704d 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -24,6 +24,8 @@
>>  #include <linux/of_reserved_mem.h>
>>  #include <linux/bits.h>
>>  #include <linux/bitops.h>
>> +#include <linux/compiler.h>
>> +#include <linux/iopoll.h>
>>  
>>  #define ADSP_DOMAIN_ID (0)
>>  #define MDSP_DOMAIN_ID (1)
>> @@ -38,6 +40,7 @@
>>  #define FASTRPC_CTX_MAX (256)
>>  #define FASTRPC_INIT_HANDLE	1
>>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
>> +#define FASTRPC_MAX_STATIC_HANDLE (20)
> Document please.
ack
> 
>>  #define FASTRPC_CTXID_MASK GENMASK(15, 8)
>>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
>>  #define INIT_FILE_NAMELEN_MAX (128)
>> @@ -106,6 +109,12 @@
>>  
>>  #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>>  
>> +/* Poll response number from remote processor for call completion */
>> +#define FASTRPC_POLL_RESPONSE (0xdecaf)
>> +
>> +/* Polling mode timeout limit */
>> +#define FASTRPC_POLL_MAX_TIMEOUT_US (10000)
>> +
>>  struct fastrpc_phy_page {
>>  	dma_addr_t addr;	/* dma address */
>>  	u64 size;		/* size of contiguous region */
>> @@ -236,8 +245,14 @@ struct fastrpc_invoke_ctx {
>>  	u32 sc;
>>  	u64 *fdlist;
>>  	u32 *crc;
>> +	/* Poll memory that DSP updates */
>> +	u32 *poll;
>>  	u64 ctxid;
>>  	u64 msg_sz;
>> +	/* work done status flag */
>> +	bool is_work_done;
>> +	/* process updates poll memory instead of glink response */
>> +	bool is_polled;
> This looks redundant as the user context already has this info.
this is context specific flag. Not all context for a particular process
will go in polling path, so need to identify the same after sending
message to DSP.
> 
>>  	struct kref refcount;
>>  	struct list_head node; /* list of ctxs */
>>  	struct completion work;
>> @@ -308,6 +323,8 @@ struct fastrpc_user {
>>  	int client_id;
>>  	int pd;
>>  	bool is_secure_dev;
>> +	/* Flags poll mode state */
>> +	bool poll_mode;
>>  	/* Lock for lists */
>>  	spinlock_t lock;
>>  	/* lock for allocations */
>> @@ -923,7 +940,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
>>  		sizeof(struct fastrpc_invoke_buf) +
>>  		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
>>  		sizeof(u64) * FASTRPC_MAX_FDLIST +
>> -		sizeof(u32) * FASTRPC_MAX_CRCLIST;
>> +		sizeof(u32) * FASTRPC_MAX_CRCLIST +
>> +		sizeof(u32);
>>  
>>  	return size;
>>  }
>> @@ -1019,6 +1037,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>>  	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
>>  	pages = fastrpc_phy_page_start(list, ctx->nscalars);
>>  	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
>> +	ctx->poll = (u32 *)((uintptr_t)ctx->fdlist + sizeof(u64) * FASTRPC_MAX_FDLIST +
>> +			     sizeof(u32) * FASTRPC_MAX_CRCLIST);
>> +
>>  	args = (uintptr_t)ctx->buf->virt + metalen;
>>  	rlen = pkt_size - metalen;
>>  	ctx->rpra = rpra;
>> @@ -1188,6 +1209,74 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
>>  
>>  }
>>  
>> +static inline u32 fastrpc_poll_op(void *p)
>> +{
>> +	struct fastrpc_invoke_ctx *ctx = p;
>> +
>> +	dma_rmb();
>> +	return READ_ONCE(*ctx->poll);
>> +}
>> +
>> +static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	/*
>> +	 * Poll until DSP writes FASTRPC_POLL_RESPONSE into *ctx->poll
>> +	 * or until another path marks the work done.
>> +	 */
>> +	ret = read_poll_timeout_atomic(fastrpc_poll_op, val,
>> +				       (val == FASTRPC_POLL_RESPONSE) || ctx->is_work_done, 1,
>> +				       FASTRPC_POLL_MAX_TIMEOUT_US, false, ctx);
> 
> What happens if the dsp sends normal response with rpcmsg callback while
> the loop is still going on?
the condition check also carries ctx->work_done which will get set in
case DSP sends normal response, hence the polling will stop in that case.
> 
>> +
>> +	if (!ret && val == FASTRPC_POLL_RESPONSE) {
> check redundant?
could be needed in normal response case, or in case polling fails.
> 
>> +		ctx->is_work_done = true;
>> +		ctx->retval = 0;
>> +	}
>> +
>> +	if (ret == -ETIMEDOUT)
>> +		ret = -EIO;
>> +
>> +	return ret;
>> +}
>> +
>> +static inline int fastrpc_wait_for_response(struct fastrpc_invoke_ctx *ctx,
>> +					    u32 kernel)
>> +{
>> +	int err = 0;
>> +
>> +	if (kernel) {
>> +		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
>> +			err = -ETIMEDOUT;
>> +	} else {
>> +		err = wait_for_completion_interruptible(&ctx->work);
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static int fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
>> +				       u32 kernel)
>> +{
>> +	int err;
>> +
>> +	do {
>> +		if (ctx->is_polled) {
>> +			err = poll_for_remote_response(ctx);
>> +			/* If polling timed out, move to normal response mode */
>> +			if (err)
>> +				ctx->is_polled = false;
>> +		} else {
>> +			err = fastrpc_wait_for_response(ctx, kernel);
>> +			if (err)
>> +				return err;
>> +		}
>> +	} while (!ctx->is_work_done);
>> +
>> +	return 0;
>> +}
>> +
>>  static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>>  				   u32 handle, u32 sc,
>>  				   struct fastrpc_invoke_args *args)
>> @@ -1223,13 +1312,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>>  	if (err)
>>  		goto bail;
>>  
>> -	if (kernel) {
>> -		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
>> -			err = -ETIMEDOUT;
>> -	} else {
>> -		err = wait_for_completion_interruptible(&ctx->work);
>> -	}
>> +	/*
>> +	 * Set message context as polled if the call is for a user PD
>> +	 * dynamic module and user has enabled poll mode.
>> +	 */
>> +	if (handle > FASTRPC_MAX_STATIC_HANDLE && fl->pd == USER_PD && fl->poll_mode)
>> +		ctx->is_polled = true;
> 
> There seems to be some level of validation here, which is not clearly
> documented anywhere, can we add this into uapi header please.
Ack. I'll add this detail when defining FASTRPC_POLL_MODE in uapi.
> 
>>  
>> +	err = fastrpc_wait_for_completion(ctx, kernel);
>>  	if (err)
>>  		goto bail;
>>  
>> @@ -1812,6 +1902,30 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>>  	return 0;
>>  }
>>  
>> +static int fastrpc_set_option(struct fastrpc_user *fl, char __user *argp)
>> +{
>> +	struct fastrpc_ioctl_set_option opt = {0};
>> +	int i;
>> +
>> +	if (copy_from_user(&opt, argp, sizeof(opt)))
>> +		return -EFAULT;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(opt.reserved); i++) {
>> +		if (opt.reserved[i] != 0)
>> +			return -EINVAL;
>> +	}
>> +
>> +	if (opt.req != FASTRPC_POLL_MODE)
>> +		return -EINVAL;
>> +
>> +	if (opt.value)
>> +		fl->poll_mode = true;
>> +	else
>> +		fl->poll_mode = false;
>> +
>> +	return 0;
>> +}
>> +
>>  static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
>>  {
>>  	struct fastrpc_ioctl_capability cap = {0};
>> @@ -2167,6 +2281,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
>>  	case FASTRPC_IOCTL_MEM_UNMAP:
>>  		err = fastrpc_req_mem_unmap(fl, argp);
>>  		break;
>> +	case FASTRPC_IOCTL_SET_OPTION:
>> +		err = fastrpc_set_option(fl, argp);
>> +		break;
>>  	case FASTRPC_IOCTL_GET_DSP_INFO:
>>  		err = fastrpc_get_dsp_info(fl, argp);
>>  		break;
>> @@ -2518,6 +2635,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>>  	}
>>  
>>  	ctx->retval = rsp->retval;
>> +	ctx->is_work_done = true;
>>  	complete(&ctx->work);
>>  
>>  	/*
>> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
>> index c6e2925f47e6..c37e24a764ae 100644
>> --- a/include/uapi/misc/fastrpc.h
>> +++ b/include/uapi/misc/fastrpc.h
>> @@ -16,6 +16,7 @@
>>  #define FASTRPC_IOCTL_INIT_CREATE_STATIC _IOWR('R', 9, struct fastrpc_init_create_static)
>>  #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
>>  #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
>> +#define FASTRPC_IOCTL_SET_OPTION	_IOWR('R', 12, struct fastrpc_ioctl_set_option)
>>  #define FASTRPC_IOCTL_GET_DSP_INFO	_IOWR('R', 13, struct fastrpc_ioctl_capability)
>>  
>>  /**
>> @@ -67,6 +68,9 @@ enum fastrpc_proc_attr {
>>  /* Fastrpc attribute for memory protection of buffers */
>>  #define FASTRPC_ATTR_SECUREMAP	(1)
>>  
> 
>> +/* Set option request ID to enable poll mode */
> 
> Some documentation please on this feature and which PD's can use this.
ack
> 
>> +#define FASTRPC_POLL_MODE	(1)
> 
> Can we also document the values for this request?
ack
>> +
>>  struct fastrpc_invoke_args {
>>  	__u64 ptr;
>>  	__u64 length;
>> @@ -133,6 +137,12 @@ struct fastrpc_mem_unmap {
>>  	__s32 reserved[5];
>>  };
>>  
>> +struct fastrpc_ioctl_set_option {
>> +	__u32 req;	/* request id */
> Can we expand this to proper name, request_id or something?
I'll change it to request_id.

Thanks,
Ekansh
>> +	__u32 value;	/* value */
>> +	__s32 reserved[6];
>> +};
>> +
>>  struct fastrpc_ioctl_capability {
>>  	__u32 unused; /* deprecated, ignored by the kernel */
>>  	__u32 attribute_id;
> 

