Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B5BC88E4A
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0204410F560;
	Fri, 11 Sep 2026 11:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CVcAvFv6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hn6/L7pt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCEC10F560
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:42:00 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BAqB4M074198
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kh1ZaKFFAWBr4fjzHz54y8tVqiq5bHMizSTx+63Udl0=; b=CVcAvFv6AJ9cWXzm
 9wSO7Jy4nFq8pQV22eZndKTO97I1SYEvCM002m5VCFCuKqacQhHixMZL2j/Z6+Vz
 wVSS35wldyuErUXhI3TudRGdiV50E84Rbta/pKngtw1Db5+P53+RM+CaHgesmHmK
 Q0rRNN0Kk5oNUX73qmppvHL8Dycev+VCiv4kF9W6GBNJlsBXkyjJJWsH9wu2Eyw4
 xOe1yLBCNQmuqlxQ4HLRaeCvnALwuJVI1ZRAKhm4Ee3S6vrLUtCQkuM75cYu1cVP
 4fxOniVDSvxaxbyBkjIku+0qk7NF0U2HFUrduSG/8v/hHFc3Nmaq/EAGZq7F230a
 FgJTtQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm5q42qr3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:41:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc21bc2923fso970860a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789126918; x=1789731718;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kh1ZaKFFAWBr4fjzHz54y8tVqiq5bHMizSTx+63Udl0=;
 b=hn6/L7ptOXPV3T7qglXcc5fUCqkBXiXE3BU39HwWb9vEj2f4DmtKwtK1Re1r4VFyZP
 7/Fc8up6sSpLKbLroqjuqzRZ+B+28hcW+9X0dcGvi+EffDXq6uQCy6KgYKKKaMoMf5DN
 +98uvF1mb5EsKG2jCaA0YGLi2TUhF6+ECzC0e0Zp2KJQA1eIeuhGiZRcE/jUpJKipMp5
 EVffD/G89Bgm7ZxCS9nnJmHUcPmvYRyLLWJ/wjPBPI4192VyOZR+1O+b4it3bOV/3Gw8
 bDWu0EQWuAVBa9ZTL9jV7CrXIUzAED65o//tz4jw9jFIdKaK+qLGbbtUd+19S4HsjcD0
 iYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789126918; x=1789731718;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kh1ZaKFFAWBr4fjzHz54y8tVqiq5bHMizSTx+63Udl0=;
 b=NoZsidbR6sfwvj8HLzHYHhFKzHckOSJ7xzutHHrY9fZZwCNMKG51MYg2yhp7omyFI4
 zYEdh6yRe4tQa+J87YFpzZK7MRTB8RQ1KvHRyBOxiSW5pmApqzq7kf4QwSBXL9CXBK9k
 teHJmzsFmYkLCc75pLWpSqoQPI1d9gYZNEJrd+wZIRyS9mZxgKzhCKQdTsdiVZKtkUhP
 8N5UHh2JcW0wv4ogO6EooskTNTWVFeKj6K0za6io/Wff1sv37UQBD4G4HGyZr9wkZFlk
 bGoqHGb2KcF9LHeaLcpFHAC/AtxTkS1UcxR0IV26egq4j+ds3YSCYTSPtGA0stbwANqi
 7zkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDAdeY466IGt292jfZK7gG4UVezne22UlfXw0MxuIMMvgRN1noZOIThUqpYeNPgQYSLWb9ytFaI2U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lC8+Liw4NklFEkkGJLLa6HvjJSkwmtA5SDPGLb89yfoKKGv7Yw
 8LMX1dwS5dvarjYp/fkXWzDTSdtRY0PmF1YTtSF9u51ooCZeuA2z4pDWXcSQgwXVRsY9pypOTfc
 TmBxMkdtB+nKYgBx7IfunPD7EUpo/XGYLRyYM0xgGCCRzJJRB2lzeRlEN8T3CSqzu3Wd08UY=
X-Gm-Gg: AYBFou1UjMnpa8H+Y6MP12C3uPpN7pxkeQ5GEDR5/nnaTlVgFUYVwfg320IpiUNNX5O
 YF0a7pdL6vfqcbgq31ijPtlhJuXIUDUmbMvBBskbsOKeGh0Kf+VgwAvxTjucVCZApGauY5xq1h8
 kIita91RBCOEIt5u6UT8wyDMx/vA0L+Rm7BwO5FIeVG72zsDQX+DsnhErLEQRTxAsFjxI4qxvxT
 XcUNhgQn22Bb/5M6jOCvgTiDrJuO8KutIGiBfcii4YG/E7EcPZWdq4+Bl65aLEDkf6ASvyqSGL8
 8sRG87tWg03suiUBhl9HuqyUuhKS78B9TXNJENcpS41ftnZy/kcmxRA3KGcHclPs4AatDLwApus
 QA6e8g0Pa9ZSwomEdSailONcSwrsb
X-Received: by 2002:a17:90b:2b44:b0:398:bd37:6a49 with SMTP id
 98e67ed59e1d1-39d9c1bf032mr6519785a91.12.1789126918256; 
 Fri, 11 Sep 2026 04:41:58 -0700 (PDT)
X-Received: by 2002:a17:90b:2b44:b0:398:bd37:6a49 with SMTP id
 98e67ed59e1d1-39d9c1bf032mr6519719a91.12.1789126917768; 
 Fri, 11 Sep 2026 04:41:57 -0700 (PDT)
Received: from [10.218.24.45] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e5182fsm6041150eec.9.2026.09.11.04.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 04:41:57 -0700 (PDT)
Message-ID: <b10cb8de-638f-48bc-9880-edecf35e4659@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:11:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] misc: fastrpc: avoid duplicate DMA mappings in
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
References: <20260805060940.41414-1-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260805060940.41414-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vCxhoGPKF4t6kM19DDfe0tMcoP4xmO2R
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE2NCBTYWx0ZWRfX8yL4rbIh1mMP
 XJjclyfyzLp9+7F2tazXLRt+zV/66RchbiPiW22jv9KJuxVDuZDbFcW1Y7f5tSwteZ0r71Am+lO
 2O6kX0jyqUWBM9ajqZFPaNPcl8EhKPo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE2NCBTYWx0ZWRfXynF3gWQZB+Kz
 jFDhh2RiVbEIVORnS7UbXUa0R+Mxq4ghaYgjEom7LscN2/ocRwSjzMietCWyQI02W923JUa0+qP
 MNANqbRSMVRBFUZIHv2lyARtY2xuUyGvqYTLwIfxLxqyG74ZexO04Y4ZEW68Ybfi60nfHEKTxXy
 kHKLMaUzEY92BnqCHCJgPsWqQxM5ZaphYjNYNvwNHdDAt4DMKBR+WzMrrJWLuQRaoxA2dJLET6t
 BNw2hjG9idlddH9iWTYcWPJI6JpabqryeiRgz1zRhHD7kA423gnguy43wKqlGbDax54ec7s73S+
 xONOjZnxcC7+CsjNcJhO+KLuB/yYRqZA3lP2RpTfXgSJL4G8ts/RHHCCYDq5+uhs7HaMLOaq3dO
 1Q0fKUy7gRXAe9sK3Xg/yvErLpoj2oqB8gk6db0VKr+dVpt2quObXVH3MjDl83dBaK1j/cO1SrV
 WRW3gfISB6vNO23e0AA==
X-Proofpoint-ORIG-GUID: vCxhoGPKF4t6kM19DDfe0tMcoP4xmO2R
X-Authority-Analysis: v=2.4 cv=Wsa+otfv c=1 sm=1 tr=0 ts=6aa3e907 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pdARdrlki2Vdj_-LtegA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110164
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

On 05-08-2026 11:39, Jianping Li wrote:
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
> 
> Patch [v2]: https://lore.kernel.org/all/20260716113254.570-1-jianping.li@oss.qualcomm.com/
> 
> Changes in v3:
> - No functional changes.
> - fastrpc_put_args(): document that clearing map->flags without a lock
>   is safe because the DSP reports a given fd in the fdlist only once,
>   so no concurrent fastrpc_put_args() can race on the same map's flags.
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
> 
> ---
>  drivers/misc/fastrpc.c      | 60 +++++++++++++++++++++++++++----------
>  include/uapi/misc/fastrpc.h |  2 ++
>  2 files changed, 46 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 90fd669636ec..8c98c8af6084 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -253,6 +253,7 @@ struct fastrpc_map {
>  	u64 len;
>  	u64 raddr;
>  	u32 attr;
> +	u32 flags;
>  	struct kref refcount;
>  };
>  
> @@ -879,7 +880,7 @@ static dma_addr_t fastrpc_compute_dma_addr(struct fastrpc_user *fl, dma_addr_t s
>  }
>  
>  static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
> -			      u64 len, u32 attr, struct fastrpc_map **ppmap)
> +			      u64 len, u32 attr, struct fastrpc_map **ppmap, int mflags)
>  {
>  	struct fastrpc_session_ctx *sess = fl->sctx;
>  	struct fastrpc_map *map = NULL;
> @@ -896,6 +897,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
>  
>  	map->fl = fl;
>  	map->fd = fd;
> +	map->flags = mflags;
>  	map->buf = dma_buf_get(fd);
>  	if (IS_ERR(map->buf)) {
>  		err = PTR_ERR(map->buf);
> @@ -970,13 +972,13 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
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
> @@ -1047,23 +1049,25 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
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
> @@ -1195,6 +1199,16 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
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
>  			pages[i].addr = ctx->maps[i]->dma_addr;
>  			pages[i].size = ctx->maps[i]->size;
>  		}
> @@ -1244,8 +1258,17 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>  	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
>  		if (!fdlist[i])
>  			break;
> -		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
> +		/*
> +		 * DMA handle maps are released when the DSP returns the corresponding fd in
> +		 * fdlist. The DSP is expected to return a specific fd only once in fdlist,
> +		 * so no two fastrpc_put_args() paths should clear the DMA_HANDLE flag for
> +		 * the same map concurrently.
> +		 */
> +		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false) &&
> +		    mmap->flags == FASTRPC_MAP_DMA_HANDLE) {
> +			mmap->flags = 0;
>  			fastrpc_map_put(mmap);
> +		}
>  	}
>  
>  	return ret;
> @@ -1621,7 +1644,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>  	fl->pd = USER_PD;
>  
>  	if (init.filelen && init.filefd) {
> -		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
> +		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map, true, 0);
>  		if (err)
>  			goto err;
>  	}
> @@ -2246,9 +2269,14 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
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
> index ba1ea5ed426c..c04749bf4f96 100644
> --- a/include/uapi/misc/fastrpc.h
> +++ b/include/uapi/misc/fastrpc.h
> @@ -45,6 +45,8 @@ enum fastrpc_map_flags {
>  	FASTRPC_MAP_FD = 2,
>  	FASTRPC_MAP_FD_DELAYED,
>  	FASTRPC_MAP_FD_NOMAP = 16,
> +	/* Map the DMA handle in the invoke call for backward compatibility */
> +	FASTRPC_MAP_DMA_HANDLE = 0x20000,
was having a looks again at this, user is never passing this flag,
should we have this in uapi? I think you can move this in kernel as it
is set and used by kernel.>  	FASTRPC_MAP_MAX,
>  };
>  

