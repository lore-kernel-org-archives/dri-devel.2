Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232E9C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E5EA10E0F3;
	Thu, 30 Jul 2026 04:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dyunrh/Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VcTbxATm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB2110E0F3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:34:22 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U3wihA3875033
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5cdk8Yiwk/sa/VglH2VfCbyGGThIsIyvwEWETM1Y7xE=; b=Dyunrh/Y+P34Hnu3
 pvJ94Myn6z4uODclHr02s9/iGWbx0YZtS8ghl5C2tNRandRpGBRMFWTGZ1j9BhbF
 q9qrKhq+ujcOkClOwVxMQpZrhnWjPB3XFc/FazkMIZ1olv+ZjtSd+VKifB3zKIMP
 DaEHqFtFRO7+9QTfpyMOBPwZhKuruorg0QKlZ5ynZSeMRTvJOPBKfc8upP74L2qe
 Mu86Sylht6SPu+kCrRvjUp9RmQJqqnP/ZuxmjxfDkDmGf+dPTa4WFFTb8cC9ekHw
 1lgUNg0vEoP+unpZeiXvHP0TzsypJtYBgAoB5Ktnh7xLgqu0ZsmfZGspMBrYb8Ms
 LIT7Lg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqy6c83r9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:34:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e6d253330so165637a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 21:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785386060; x=1785990860;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5cdk8Yiwk/sa/VglH2VfCbyGGThIsIyvwEWETM1Y7xE=;
 b=VcTbxATmsG2BCJmVx8MXPtOMPUuhPebCiWpssfmeyxJEU+DbHx/M8lT6rD4SsShD47
 qtBJDZPPH5fNVv9/xibiZHi/DR3JQwmZo48eMjbYSErI4NY24u/HbKpE54Y/y/nQebb6
 TQyuFEdLAeKMoG+nV8DxSzV6NcGmTYRNyPNdlehqhm5dO7S5DPnOte5j+yX0L7jaAYRZ
 d96Axfd2dnz0IVXHY6/8B8seYj7t6GeeWbLXjijI4lEnttqZIFvkce71rZEWZ0Z1LNn0
 ip/ibGID1Enk6Y4OF5KLAys0wmVSX6rwTRUKbRjfV3gDvZFVCTztbFNiy9qDrjS0294+
 VIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785386060; x=1785990860;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5cdk8Yiwk/sa/VglH2VfCbyGGThIsIyvwEWETM1Y7xE=;
 b=piVR26ZxwUcaZqF75HVf7ZXZpzsxUgRVa8zZtwE5OOFPa1L57lAmDVPf4SpD8uNiJw
 AmLdjJHAFAhxBquuuc3pMOIWigHATYkRAt/u1QbhpkdSS/JWifCUVp7p5sg1ZSZRkcXl
 c0uO8SqbYZ3VJ8HdbPSmlxUE4FG1d3K8EYZAOLCm5tQo9HFj9JRvtQHcMIaSZsUzey3b
 zLyZAWq+4VVAeNjulphrp+/OecxKbdldcCQRUHzzS+CqjsSij6zdb9POEzWxWIgk1PjX
 in8I0aOsd18QmJ4hjgOJlRgwcPUTpiTzFIPytiFc6lU/dQpgnfu1kECsNqSHZN3fDbwt
 BlvA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqv6WF84tlVD7xA5JA3kK1pRYBROoGAbUyM4v20KqCh8mFnMiLjQRaiqZMOazmr56VHrJQ4A/0uwcc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDXLmUvrptNCQrNVIpZLU3OcC9l5H/G5+Ta7ubAteaNUtfiTcH
 zOit7dBAos7yCNf0GcIMs0BdkIQOD3NBX7DOEOUBt0U1t2livTwjuePONdBWPahSLICXX8Kfbua
 YNNXfyT+v6QDB4jUOePfR+iNXr1NOsd728lUASva7s6kegJ/KJgUZmMlVSvc8KXxzDDSV3dE=
X-Gm-Gg: AR+sD10JyqPEQ5koznCmypEdJJPoMS0FmcRrxwdpTsSwQAPsKTjwJXZw0iIYvYWKGNt
 KHvVSjzB2k4ZVJOnfZbPQDvr2+jW+VQVLmhWWAg3IPIE68sijfG/UNTT1t9W+LRixJ4sVxh5dur
 41RV+H3X9H2c4JvkM1ZzhHW5B1q/z4oG6mjyqtW2/4eRwJzGJqmXqcWQ9rk51iDbJBYfRadkNuA
 h1uEaQcdHQP327iDFRL1swewtS/0s+8dzB6xHopL8ArWSLNJIh/6JiRMUrewEByPQ8vWmd93Wwv
 HNt6r0XJ7xXmd4sewYOidYGdagYqEeBH6AAD/HV0Gb5Cgt4C4StB6zvOQtjcgNUXKYK1Y5w6Msg
 yR1Z+78uC8wSUL8SIk3xy95SK8xhBPA==
X-Received: by 2002:a17:90b:3908:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-38f9d3e383fmr498570a91.8.1785386059827; 
 Wed, 29 Jul 2026 21:34:19 -0700 (PDT)
X-Received: by 2002:a17:90b:3908:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-38f9d3e383fmr498546a91.8.1785386058885; 
 Wed, 29 Jul 2026 21:34:18 -0700 (PDT)
Received: from [10.204.78.242] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dd42a9sm19203723eec.30.2026.07.29.21.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 21:34:18 -0700 (PDT)
Message-ID: <889c46b2-6c6e-4119-b748-a1d5706c276b@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 10:04:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
To: Jianping Li <jianping.li@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ling Xu <quic_lxu5@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, quic_chennak@quicinc.com, stable@kernel.org
References: <20260716113254.570-1-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260716113254.570-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ycKgdKg7ERCZ5wnzeBG-bj8AwmDb2rZh
X-Proofpoint-ORIG-GUID: ycKgdKg7ERCZ5wnzeBG-bj8AwmDb2rZh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAyNyBTYWx0ZWRfXyR8QGygjrWmu
 oc5DuQBbiO6AEPLTSnXbYdSYEYEM8+oNHlnPN4VS1WFsqn6ZfW/D/NiU1oEEH0/LYV0B7qhOJ+p
 x2k5nwU2PVg5Ud+lj2Af169OIZd/2KxWA2KX3xqzgOWB+q20SuM07azA9cKJw+329oLPfHYhWvV
 3d9xuRUccJx4y96Q7Vndw96+VMGwABR6dS5hQJi5owxMlg6FSQE2Rs6UIy1/NjHa2WJ9dTi4v7r
 x2njEq5TpNcOI6JMurS5dM6OpYKTESUiudl/1brjyrp1EqnO4Bni+28d+LdacaaqfNYGryo5YX4
 KvFLEbGVQT5lUbUeE9Jjm6mk+8IQFkb/zNiYZlrWHLesx2xIW+UEmQEZLcEY+wQ6meXEVzA7tbk
 hsx4vOUIP00E+CN0NffkZ01OgRZuLQmUxAXm6Vi4Ew/ZcAYirWhWHZCfD+y64eX6TWFchu/+UG9
 qcedfmaKcnVNUwAgF+Q==
X-Authority-Analysis: v=2.4 cv=Wtkb99fv c=1 sm=1 tr=0 ts=6a6ad44d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pdARdrlki2Vdj_-LtegA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAyNyBTYWx0ZWRfX86Gpq6CmU60G
 CqgLBOs5Z4jyEE9AiGFhqNMoixB0lGNvVPd46CD3LVEnA3oQIZ5ICj18J+kf6A1x3xpVifsuS6C
 u3TKw0oxB2Mz+CHDYGpMTUceaAmQE9k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300027
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

On 16-07-2026 17:02, Jianping Li wrote:
> DMA handles passed as invoke arguments (scalars beyond nbufs) may refer
> to the same dma_buf fd as an input/output buffer argument. Taking an
> extra reference for such DMA handle maps leads to duplicate mappings and
> an unbalanced reference count, since DMA handle maps are released
> separately when the DSP returns the fd through the fdlist.
> 
> Fix this by not taking an extra reference for DMA handle arguments
> (take_ref = false) and tagging them with FASTRPC_MAP_DMA_HANDLE. As
> these maps are borrowed references, fastrpc_get_args() re-validates the
> map via fastrpc_map_lookup() before dereferencing it, so it is not used
> after being freed. fastrpc_put_args() only releases maps flagged as
> FASTRPC_MAP_DMA_HANDLE and clears the flag to guarantee the map is freed
> exactly once.
> 
> Also reject FASTRPC_MAP_DMA_HANDLE in fastrpc_req_mem_map(), since such
> handles are already mapped implicitly during the remote invoke call and
> must not be mapped again through the explicit MEM_MAP path.
> 
> Fixes: 10df039834f84 ("misc: fastrpc: Skip reference for DMA handles")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
> Patch [v1]: https://lore.kernel.org/all/20260625080832.17477-1-jianping.li@oss.qualcomm.com/
> 
> Changes in v2:
> - Rework the commit message to describe the DMA handle reference and
>   lifetime problem more precisely.
> - Introduce a new FASTRPC_MAP_DMA_HANDLE uapi flag and a 'flags' field
>   in struct fastrpc_map to explicitly tag DMA handle maps, instead of
>   relying only on the nbufs boundary / take_ref.
> - Plumb an mflags argument through fastrpc_map_create() and
>   fastrpc_map_attach() so DMA handle maps are tagged at creation time.
> - Re-validate the borrowed map in fastrpc_get_args() via
>   fastrpc_map_lookup() before dereferencing it, to avoid a
>   use-after-free when the map was created with take_ref = false.
> - In fastrpc_put_args(), only release maps tagged FASTRPC_MAP_DMA_HANDLE
>   and clear the flag afterwards, so such maps are freed exactly once.
> - Reject FASTRPC_MAP_DMA_HANDLE in fastrpc_req_mem_map(), since these
>   handles are already mapped implicitly during the remote invoke and
>   must not be mapped again through the explicit MEM_MAP path.
> ---
>  drivers/misc/fastrpc.c      | 56 ++++++++++++++++++++++++++-----------
>  include/uapi/misc/fastrpc.h |  2 ++
>  2 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d86e79134c68..fa8c58a97e35 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -223,6 +223,7 @@ struct fastrpc_map {
>  	u64 len;
>  	u64 raddr;
>  	u32 attr;
> +	u32 flags;
>  	struct kref refcount;
>  };
>  
> @@ -833,7 +834,7 @@ static dma_addr_t fastrpc_compute_dma_addr(struct fastrpc_user *fl, dma_addr_t s
>  }
>  
>  static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
> -			      u64 len, u32 attr, struct fastrpc_map **ppmap)
> +			      u64 len, u32 attr, struct fastrpc_map **ppmap, int mflags)
>  {
>  	struct fastrpc_session_ctx *sess = fl->sctx;
>  	struct fastrpc_map *map = NULL;
> @@ -850,6 +851,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
>  
>  	map->fl = fl;
>  	map->fd = fd;
> +	map->flags = mflags;
>  	map->buf = dma_buf_get(fd);
>  	if (IS_ERR(map->buf)) {
>  		err = PTR_ERR(map->buf);
> @@ -924,13 +926,13 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
>  	return err;
>  }
>  
> -static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
> -			      u64 len, u32 attr, struct fastrpc_map **ppmap)
> +static int fastrpc_map_create(struct fastrpc_user *fl, int fd, u64 len, u32 attr,
> +			      struct fastrpc_map **ppmap, bool take_ref, int mflags)
>  {
> -	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
> +	if (!fastrpc_map_lookup(fl, fd, ppmap, take_ref))
>  		return 0;
>  
> -	return fastrpc_map_attach(fl, fd, len, attr, ppmap);
> +	return fastrpc_map_attach(fl, fd, len, attr, ppmap, mflags);
>  }
>  
>  /*
> @@ -1000,23 +1002,25 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
>  	int i, err;
>  
>  	for (i = 0; i < ctx->nscalars; ++i) {
> +		bool take_ref = i < ctx->nbufs;
> +		int mflags = 0;
>  
>  		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1 ||
>  		    ctx->args[i].length == 0)
>  			continue;
>  
> -		if (i < ctx->nbufs)
> -			err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
> -				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
> -		else
> -			err = fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
> -				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
> +		/* Set the DMA handle mapping flag for DMA handles */
> +		if (i >= ctx->nbufs)
> +			mflags = FASTRPC_MAP_DMA_HANDLE;
> +
> +		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd, ctx->args[i].length,
> +					 ctx->args[i].attr, &ctx->maps[i], take_ref, mflags);
>  		if (err) {
>  			dev_err(dev, "Error Creating map %d\n", err);
>  			return -EINVAL;
>  		}
> -
>  	}
> +
>  	return 0;
>  }
>  
> @@ -1144,6 +1148,16 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>  		list[i].num = ctx->args[i].length ? 1 : 0;
>  		list[i].pgidx = i;
>  		if (ctx->maps[i]) {
> +			/* It is possible that map is created with
> +			 * mflags FASTRPC_MAP_DMA_HANDLE and take_ref
> +			 * is false. Check if map still exists or is
> +			 * being freed as take_ref is false
> +			 */
> +			if (fastrpc_map_lookup(ctx->fl, ctx->args[i].fd,
> +					       &ctx->maps[i], false)) {
> +				ctx->maps[i] = NULL;
> +				return -EINVAL;
> +			}
if map is created by R1 call with DMA handle flag, when any inbuf/outbuf
carries the same fd for R2 call, wouldn't the refcount get increased as
part of fastrpc_create_maps()? So if the refcount is already increased
there, why do you need to have a check here?>  			pages[i].addr =
ctx->maps[i]->dma_addr;
>  			pages[i].size = ctx->maps[i]->size;
>  		}
> @@ -1200,8 +1214,13 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>  	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
>  		if (!fdlist[i])
>  			break;
> -		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
> +		/* Validate the map flags for DMA handles and skip freeing map if invalid */
> +		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false) &&
> +		    mmap->flags == FASTRPC_MAP_DMA_HANDLE) {
> +			/* Allow DMA handle maps to free only once */
> +			mmap->flags = 0;
flags are getting updated without any locks, this is considering that
DSP can updated a particular fd on fdlist only once. Can you add this
information here?>  			fastrpc_map_put(mmap);
> +		}
>  	}
>  
>  	return ret;
> @@ -1511,7 +1530,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>  	fl->pd = USER_PD;
>  
>  	if (init.filelen && init.filefd) {
> -		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
> +		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map, true, 0);
>  		if (err)
>  			goto err;
>  	}
> @@ -2107,9 +2126,14 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
>  
>  	if (copy_from_user(&req, argp, sizeof(req)))
>  		return -EFAULT;
> -
> +	/*
> +	 * Prevent mapping backward compatible DMA handles here, as they are
> +	 * already mapped in the remote call.
> +	 */
> +	if (req.flags == FASTRPC_MAP_DMA_HANDLE)
> +		return -EINVAL;
>  	/* create SMMU mapping */
> -	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map);
> +	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map, true, 0);
>  	if (err) {
>  		dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
>  		return err;
> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
> index c6e2925f47e6..142ddaeed85f 100644
> --- a/include/uapi/misc/fastrpc.h
> +++ b/include/uapi/misc/fastrpc.h
> @@ -44,6 +44,8 @@ enum fastrpc_map_flags {
>  	FASTRPC_MAP_FD = 2,
>  	FASTRPC_MAP_FD_DELAYED,
>  	FASTRPC_MAP_FD_NOMAP = 16,
> +	/* Map the DMA handle in the invoke call for backward compatibility */
> +	FASTRPC_MAP_DMA_HANDLE = 0x20000,
>  	FASTRPC_MAP_MAX,
>  };
>  

