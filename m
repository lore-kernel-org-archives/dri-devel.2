Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DB7F8D74A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D6A10E1FC;
	Thu, 16 Apr 2026 13:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9rspaF8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i0ihAxUB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD1410E1FC
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 13:58:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G8HVaG862172
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 13:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jHBtOeE993tOe4SQEGWOa66fcOQQwR2SMB1ef/T4B24=; b=T9rspaF8R0SZil75
 HY97ZECGrLlbajeihis5MBFzGZ7QHWWNY6aoXdToB722VTHWkkBMCfJSV098dayf
 uNyHr5QF2WQ0BgAs+5cr6QtecSD/RTQZrk6zi6D3285HLMYUCLs27EBukHo/wdo2
 FuOLwWQojaOqdykzsicLzxLK9EpwDgPyr5K5LmYQCm/cbxUDQXCeTbAVZCQk+Zd4
 A07b7drLsboilUnDNyiy+I+wSXB4Bb4LQLQh8jRq184MT1I773sKZ7H4ORu+uqkG
 N/X8IgDAnPOZnimvqXajHqjSWYiAqT0oa2dMF3VqGMy8Z+fj/l3Y8mZe8klebgP+
 idpd0A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djd0ec4w3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 13:58:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35fbaada2f3so8910636a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 06:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776347896; x=1776952696;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jHBtOeE993tOe4SQEGWOa66fcOQQwR2SMB1ef/T4B24=;
 b=i0ihAxUB4WXop83q+gpcbCbg+BPNmSPkFgT1NbZ8tOgo/+8i0167gaQIJRnSrkoF9n
 1oli6qK6HCll69O/CAuhRZETvCkRVV39lL3V1zp/TtfI9suxEM5Pon1fz0njXR9DHdDx
 MuXnUjLzMVXY0PC03WPHq4sowO9/87ZF3LYdodnejidNtSdGLGGy4ebkV6+TiILA/pNq
 /29DAYbLWsSsuHS84XGymIjKAQAN7CyuZlSQ5ucUYlVc9b412MTW8OYrDbSS53jBTi+Q
 Gnt31ovBk1/DX5qH5MQwF3KCT2hx4nTRtquHu3/LiLyzv+JlZFOBXWAowU5QKJWTpmxg
 GFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776347896; x=1776952696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jHBtOeE993tOe4SQEGWOa66fcOQQwR2SMB1ef/T4B24=;
 b=bqCJX/ZjXu/cQevg2OhdD56vpTdWWLqInMobvHuNqe/qHtDJYTvQd6Z/V4nUiZ43rS
 ak9se08hsKCs1XGK0J0bQKvQrjYOj0eTcxCAjEKaVthk6Mq+LB7f1WW/5hx9DDlIjgMW
 m8vb1AWyeEocqHjBSX/M89hlCgFYVoLYzWYqH+Y/6x8oEOKd8gp///gvPhORTW8BlWuT
 sTv4PQf/EhOFTGiBZUCmJBGXlGEFIRsjccXEvVxIJysLnQ+UZjyPm/SO8kiAgWxijvNU
 tYn6t5d16P20G1/RWVnGOm6f1VympKuq/tHwYSODcG/XlnsWc/+uQosj57sfvosIolSL
 xBdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Kd83qTN7FvEd/J4Faf1h13FbXZflvHeqZ/YUB7dOY6NtAWDvv0L4SyL3JFDrcu3fUU8Bte1mHOO0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4UvI3C97qW4/m1ASg6GVyVNMVYRErS6MAkZtyIjWu+Z47Z0LN
 xnp9SG7a4GuEoDQhiEr/schbt+DAw3tq4xCCi31ec9Pg/IH4RR+WomnUlkfrF7sXhne02PXiwD/
 QcNVvaQyEV7kVnokYWUefT05uSNC8GpFU84RksoGDjtoTCqj818aaUuayOotMRK0kkrI/Zo0=
X-Gm-Gg: AeBDiesVNxwbJkDgYE0fqtrSiT0D/pFSFsvFIcN/t4nDuoDVg+ImadvXFV/e3ev4A+8
 nVNEZ6n3FEkeFfjJIjBkLVNSoLUQfK1SX+FSnDSOr9wl7rUjZKZYCcQzC1z63jXWVaSTAdup1K9
 oKGUCzREA0Em+DlQCG9b1KSUekUxfqDYdGMsYntXRoYdklXOAKbrS4RsoUh6JWMTNVRru63qwy2
 jAMaigja4uAnAXnDsa6LFUn9mH8t0iLmkiEaEpBmWoEmb18qDzRGUXO0vuWJjQtrNqRduMFadPN
 W+sLLFnWWXbyNBQ3IJcOXP0lEXdi81cRJnm8e36/61kd2HIpSEfGj52uzdcriITu4AmgKKcT1Hc
 zteBXfA5IU5C8a4rcmG0aNAZCoEoai+JTAWBC9Sd1C4fiCHXdxVvYVs0BPvnlhvM=
X-Received: by 2002:a17:90a:e7c1:b0:35f:b987:4dac with SMTP id
 98e67ed59e1d1-35fb9875138mr16866747a91.12.1776347896053; 
 Thu, 16 Apr 2026 06:58:16 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c1:b0:35f:b987:4dac with SMTP id
 98e67ed59e1d1-35fb9875138mr16866724a91.12.1776347895362; 
 Thu, 16 Apr 2026 06:58:15 -0700 (PDT)
Received: from [192.168.1.10] ([122.164.36.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fd075882dsm2699163a91.3.2026.04.16.06.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 06:58:14 -0700 (PDT)
Message-ID: <90c2f6d5-21cd-4ba1-86e4-458100c8f830@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 19:28:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
To: Luben Tuikov <ltuikov89@gmail.com>, srini@kernel.org,
 linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 andersson@kernel.org
References: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
 <20260415112530.4083240-5-ekansh.gupta@oss.qualcomm.com>
 <8dc8c094-63ab-4f9c-867a-96b615dff2cf@gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <8dc8c094-63ab-4f9c-867a-96b615dff2cf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xbis0y2OLNnAyJqcCGkHcJaCRz9X_aku
X-Proofpoint-ORIG-GUID: xbis0y2OLNnAyJqcCGkHcJaCRz9X_aku
X-Authority-Analysis: v=2.4 cv=GP441ONK c=1 sm=1 tr=0 ts=69e0eaf9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=XANuBpsXGvULjGEGCPeV4Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5r13Z1IhC2nsk_t_lv4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEzNCBTYWx0ZWRfX6OHWvwqrnkzx
 /bIFCD9qd1f9DmUDRsitr2gZ6ekyQIqA7HKRf1+7JuOY1uxPG+tHlQUomzBJ+fm2qpDW0oDsG/5
 ZBRAbMIohXpB5HcfgOlFyH/WXJXOMEMLK1jl3FjZ4MhxhD476uGt26GzYCZRPY4tXane1QTZFqG
 Mh2wmS5gz0grYbx/OTk10GuayoxzlokMriGNbzU8syao6o0tnFtCv5Qf6tq9kLz7dAAL5FAwKam
 833QUw37G7H/vDqtEAEDVIvDAT/lj1wM+3AdtvGT70WUCGRYNgweFBq08Z0bJvl7xLnlgzeV9Xq
 yfBiOH/hflnXvJ+jDq7Z04YMRSyF9mxA/4MEDyhzvtXbjnutTeTEOl9GLqkt5ui9M4yvUhdCa0n
 qmEoHE9n7G3thrTrvw0IQPFlUE0P+A12sYU+7nMgvNQPVGVCLxk2vY3t2hgbRLHiPUJbzkfwAzz
 0ccJLypr3gu0OjwhGVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160134
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

On 16-04-2026 13:47, Luben Tuikov wrote:
> Hi Ekansh,
> 
> Good work. A couple of notes below:
> 
> On 2026-04-15 07:25, Ekansh Gupta wrote:
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
>>  drivers/misc/fastrpc.c      | 137 ++++++++++++++++++++++++++++++++++--
>>  include/uapi/misc/fastrpc.h |  25 +++++++
>>  2 files changed, 155 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index c4a3547a5c7f..5311a4ba4bb7 100644
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
>> @@ -38,6 +40,12 @@
>>  #define FASTRPC_CTX_MAX (256)
>>  #define FASTRPC_INIT_HANDLE	1
>>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
>> +/*
>> + * Maximum handle value for static handles.
>> + * Static handles are pre-defined, fixed numeric values statically assigned
>> + * in the IDL file or FastRPC framework.
>> + */
>> +#define FASTRPC_MAX_STATIC_HANDLE (20)
>>  #define FASTRPC_CTXID_MASK GENMASK(15, 8)
>>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
>>  #define INIT_FILE_NAMELEN_MAX (128)
>> @@ -106,6 +114,12 @@
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
>> @@ -236,8 +250,14 @@ struct fastrpc_invoke_ctx {
>>  	u32 sc;
>>  	u64 *fdlist;
>>  	u32 *crc;
>> +	/* Poll memory that DSP updates */
>> +	u32 *poll;
> 
> Perhaps "poll_addr"? "poll" seems just too generic.
ack
> 
>>  	u64 ctxid;
>>  	u64 msg_sz;
>> +	/* work done status flag */
>> +	bool is_work_done;
>> +	/* process updates poll memory instead of glink response */
>> +	bool is_polled;
>>  	struct kref refcount;
>>  	struct list_head node; /* list of ctxs */
>>  	struct completion work;
>> @@ -308,6 +328,8 @@ struct fastrpc_user {
>>  	int client_id;
>>  	int pd;
>>  	bool is_secure_dev;
>> +	/* Flags poll mode state */
>> +	bool poll_mode;
>>  	/* Lock for lists */
>>  	spinlock_t lock;
>>  	/* lock for allocations */
>> @@ -923,7 +945,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
>>  		sizeof(struct fastrpc_invoke_buf) +
>>  		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
>>  		sizeof(u64) * FASTRPC_MAX_FDLIST +
>> -		sizeof(u32) * FASTRPC_MAX_CRCLIST;
>> +		sizeof(u32) * FASTRPC_MAX_CRCLIST +
>> +		sizeof(u32);
>>  
>>  	return size;
>>  }
>> @@ -1019,6 +1042,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>>  	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
>>  	pages = fastrpc_phy_page_start(list, ctx->nscalars);
>>  	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
>> +	ctx->poll = (u32 *)((uintptr_t)ctx->fdlist + sizeof(u64) * FASTRPC_MAX_FDLIST +
>> +			     sizeof(u32) * FASTRPC_MAX_CRCLIST);
>> +
>>  	args = (uintptr_t)ctx->buf->virt + metalen;
>>  	rlen = pkt_size - metalen;
>>  	ctx->rpra = rpra;
>> @@ -1188,6 +1214,74 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
>>  
>>  }
>>  
>> +static inline u32 fastrpc_poll_op(void *p)
>> +{
>> +	struct fastrpc_invoke_ctx *ctx = p;
>> +
>> +	dma_rmb();
>> +	return READ_ONCE(*ctx->poll);
> 
> I think you're better off using readl() here, but see my comment below, which obviates this function.
> 
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
> Is there any reason you're not using readl_poll_timeout_atomic() as documented in linux/iopoll.h?
> Does readl() not satisfy the read operation in fastrpc_poll_op()?
I didn't check this, I'll try this out.
> 
> How can ctx->is_work_done be updated here? Perhaps you just want to use "val == FASTRPC_POLL_RESPONSE" as a condition here...
That is to handle the possibility that normal response comes while the
polling is ongoing. In that case, the call will get completed by
fastrpc_rpmsg_callback.
> 
>> +
>> +	if (!ret && val == FASTRPC_POLL_RESPONSE) {
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
> 
> What is "kernel" and why is it a u32 when it is used as a "bool"? Perhaps a better name can be had?
This reflects kernel message. As of now, just propagated the same that
is used across the driver, maybe can address this as a separate patch.
> 
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
> 
> Perhaps you want to also check "err" here to make the exit condition more explicit. (The invariant in do-while loops is generally directly determined by something within the loop and generally not implicit.)
The reason to not keep "err" check is because the call should fallback
to normal response(fastrpc_wait_for_response()) in case
poll_for_remote_response() fails.
> 
> Is it possible that in poll_for_remote_response() you get 0 as a poll result and val is not equal to FASTRCPC_POLL_RESPONSE? In such a case, this may hang. (Is a hang desired here?)
That's actually a good point, let me try making it more robust, this
condition might get encountered in case normal response is sent instead
of poll memory update.
> 
> Is it possible that if polling is enabled, then you want to poll only once, and if unsuccessful, or successful but "!work_done", then transition to fastrpc_wait_for_response() and return, without looping? (since polling is looping after all...)
This is correct, the intention is the poll until it returns, continue if
successful and fallback to normal response if unsuccessful.
> 
>> +
>> +	return 0;
> 
> "err" is always initialized so you can return "err" here if you exit with "err" as part of the exit condition. (And if you add "!err &&" in the loop invariant, then you don't need (if (err) return err;) after "fastrpc_wait_for_response()").
I'll be keeping this unchanged if I don't end up adding "!err &&" check
here, as err is always going to be zero here as suggested in earlier
version[1].

Thanks, Luben, for taking the time to review this change and for
providing insightful comments.

[1]
https://lore.kernel.org/all/wipphezpxtuuxtwhpwamsmvhwgwuesexmy5ev5pcqb65vov5kz@vuzzyyqnu7ci/
> 

