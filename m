Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BE1CC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5786010E0E7;
	Wed, 14 Oct 2026 04:43:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B641810E0E7
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:43:01 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DMVCkU3103937
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9K3cbdb7dFzpqCr6C1BNZjsMaePAgKuPmBno8+Ephi4=; b=iMtg+E714UVPUI52
 b1D/C3M/dbkGmWbv/g2rz5tue+k4RIOEG4lnLOIo/RzQlcHI6z3w3PVxThYerX5C
 MGpyNWnocd4jHJ8vpou2RA0U2CwRNIaOOdf9CAZKWqZ8N1rjEQbqvnoj7yTds8Qv
 aPDC+efYvYZc69IbEvvExDPnAT6dOq8JZvrhPNLcdhXqR0WPM3MnqAJtbOnQUblS
 Wp2BDuF/jjIYCpAaVK3PnuWI4wUhrREGP54l+eNHQUwtVTGocT/dxLvsZ7MZbt04
 ym/JnljrtuLHyQ/gRV4l+Km7tdrU49p7/SZagv7baw1VAcdPjlelTZI0188hvJFT
 RcmCzA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9wgt1487-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:43:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35a04491c56so657482eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791952979; x=1792557779;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9K3cbdb7dFzpqCr6C1BNZjsMaePAgKuPmBno8+Ephi4=;
 b=EeHEk/H0yRhxtkATjUSKR4KRyx5InN3xLAIiis9gOG1n7QWFgsI28pBc8IIP5+UU02
 AHxYW7n8BmYUxyOHWCWnJL6oyIzyxlPCh5+ldYd0sDt61e1SnDvF5cmNHe4DS8hQgt2e
 gC3cklD00om4A4nsVwDAP+y0DK00Q6VRuYC6MGMTMPP5uyQEBMdtxEqG+tGrWfPA6R2n
 zvGtRtfIOS5BAW1Fq6CmJuQU4sIDLz9HvUrDzJwEGMkHmQCZwlsIweJ0WuPBuyV+F/jP
 ljZHFtRwZFRQsr74Z/zda6Yi/l+qdsBtmsYMFAyeWlW5M7G/8S/JCoxRswfxKnHYO4J6
 itUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791952980; x=1792557780;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9K3cbdb7dFzpqCr6C1BNZjsMaePAgKuPmBno8+Ephi4=;
 b=NymO52UqekxcW4eVy3GpxK4ckA0EIiQj+bwN9epD8ELWl+bVtwa9xlbrYdVVs58UQR
 aN9rvL5HT0bzF82Hifag0YQy8u6NXSxNjCkJE3butz1k+UO/iw/h0/5Ocb+1mcqLv13W
 rnwLlgvquemKA4+ytsOpyWDZWAQSicDb1kql4Hjddo9EH+aS946vCI9IbPOVZOo2nIXD
 Nq0YXPwVnDo00BAt7vZkgMSRjkOFPGZp+CKbrL8ZVih6j3DG18FicWmP2Czlmtv5SIdB
 d7xxZxK4znMWzp8zQnG7IquocKp/pDBpPR6xa/Qmsj2fuQTopmq4R9ExzKTxBVaUY3Td
 kDbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlhfo/dEiB+5r4svQ7hTsgL6vzQdOEfzNG0ZWD4kON4LHy8KQ08tM+RiP/BeTfOfjn9H3jvcU+fnI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIrMpXOTyxGy2Y8gDU7S7DKGMT/hzQmNbWCVxueXPcoA9JEKgNS
 UE0ZWKVgV0Bt/pNgnvfL02YmLucCWAeq/4oADhS62kJ8pzDeUgYtfinlrM6WJExR+AcDPpm4ZsU
 GTGA3uIdSoouhUTdeL9arUw3n+MWtf+epNGESqXJ1hqI6EopFm+IBXqjtdtyDrVoKw0M4WO0=
X-Gm-Gg: AYBFou2k1S/+dTPK+x+Zi8W5sj2Rw52zvwKZgA+w5UV0KLaF+Oh0UabXLoNxtf3czU0
 h69vCbK9fz0VqsHLR/EVHKG07BcQHO2dFNBw3dvf+gIGNFE2OrAn7TQKCsR0syFbc1315ql/orJ
 CfplQtXIC8JFlgxcBQc6XIk5CGwgDcFw3RPkO/CNzM8m4p+q0BpGgDhhKdrxs1KVwxhb9umftGE
 PJs0rbG+TP47/laX1YvG1TVoEG5f9AgGUeiibGHtNp45IO3fd61+HfHfs5JhEC0uBDhrAGAyde8
 sdOeE/VgzItHLmNoifv3K/X79pZraswUB2UJ4w8HUEoAOnashHLnPb9odIreUKnNUQwW6gu/vDm
 pP6IVRkVjqzq5R5W7Gf8tK/PodsE0
X-Received: by 2002:a05:7300:c87:b0:33e:61ab:8309 with SMTP id
 5a478bee46e88-3537b291a93mr28294717eec.23.1791952979284; 
 Tue, 13 Oct 2026 21:42:59 -0700 (PDT)
X-Received: by 2002:a05:7300:c87:b0:33e:61ab:8309 with SMTP id
 5a478bee46e88-3537b291a93mr28294648eec.23.1791952978467; 
 Tue, 13 Oct 2026 21:42:58 -0700 (PDT)
Received: from [10.219.56.188] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35c89429484sm11541995eec.23.2026.10.13.21.42.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 21:42:58 -0700 (PDT)
Message-ID: <6e4d0fc2-3fe6-4dff-bdc1-b6051f3becef@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 10:12:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: Add cache maintenance for non-coherent
 platforms
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de
References: <20260916185850.3686010-1-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260916185850.3686010-1-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfXy4sQl8LasoNl
 MCMUogUrZFPMd3rMyolA7sAV6Ciq5o7/bLditXKMEiJbbgAUtZ7N8KwC+OHU9LjjSP2EvXZbpio
 GaSlDtumxsRC8t8/askXJby/tIFa5FZq8IGZmW2IcK1Gng94po3b4i3VzKBL81KBT5xu0UyiTzI
 x9qoRn/6otVn17+ADhDLInz1zDrnElm27PjxNyg1wW/9PzrTX/OO6qsgTRzuaQPDxmDCTC6rget
 rt3ID+dfyY22jBepVGF4Sqb+o2cZmYyWuNeDVYaPEBSQ0hhX7JEZsrcjx5SgJMCSteWudukDneF
 Aw8KBfKkwJ2gYrqJAmfYMLWl33qsuP+SNOpitdgdSXjteKDwPVC7OZ2zDf3bzDxHyy7cgbbvV4Y
 RZsaYgHtvbl3sM8TXm53teDgjP2VZdslH3mJznaNAGuo43gW3rGCXOFrztiRuHduNUyoaxVs8tM
 +zQPr7oKM38TMuETsAA==
X-Authority-Analysis: v=2.4 cv=Jp1kP84C c=1 sm=1 tr=0 ts=6acf0854 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=J77KH-JWTt9_r89aEeUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: C403BXeKATZRs5Ci0iMiMZXmkXcrTyQm
X-Proofpoint-ORIG-GUID: C403BXeKATZRs5Ci0iMiMZXmkXcrTyQm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfXwgoCVQN47DTh
 8dpg1gTGoOvKzoAYJ7HSyfB5bNa4LNSAe0Rf1y5/Euu+tR+ykfruPCZmKOvnjJdM30Nsds4w2+u
 +YEQ/oJVCsdvFUq7yQO4CVnOAWmF+Y8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140018
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

On 17-09-2026 00:28, Abhinav Parihar wrote:
> Some platforms using fastrpc do not support DMA coherency on
> HLOS. On such systems, explicit cache maintenance is
> required to ensure data consistency for RPC argument buffers.
> 
> Add cache maintenance for argument buffers when operating on
> non-coherent platforms:
> - Flush input buffers before invoking RPC to ensure CPU writes are
>   visible to the DSP
> - Invalidate output buffers after RPC completion to ensure DSP
>   writes are visible to the CPU
> 
> Introduce helper functions fastrpc_flush_args() and
> fastrpc_inv_args() to perform the required dma-buf cache
> operations. These are invoked only when the device is not marked
> as DMA coherent.
> 
> The coherency capability is determined using the "dma-coherent"
> device tree property and stored per session context.
> 
> This ensures correct data synchronization on platforms lacking
> DMA coherency, while avoiding unnecessary overhead on coherent
> systems.
> 
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---
> 
>  Patch [v1]: https://lore.kernel.org/all/20260604194811.2437567-1-abhinav.parihar@oss.qualcomm.com/
> 
>  Changes in v2:
>   - Fix buffer overlap handling to ensure cache maintenance is performed
>     when input and output buffers overlap and the overlap calculation
>     suppresses the buffer's mstart/mend range.
>   - Add a do_cmo flag to track buffers that require cache maintenance
>     even when their overlap range is clipped.
>   - Invalidate output buffers before sending the RPC request, preventing
>     stale CPU cache lines from being written back while the DSP updates
>     the buffers.
>   - Use DMA_FROM_DEVICE consistently for both begin_cpu_access() and
>     end_cpu_access() when invalidating output buffers.
> 
>  drivers/misc/fastrpc.c | 77 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d4fac2caca86..83d04b9d2ea0 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -217,6 +217,7 @@ struct fastrpc_buf_overlap {
>  	u64 mstart;
>  	u64 mend;
>  	u64 offset;
> +	bool do_cmo;
>  };
>  
>  struct fastrpc_buf {
> @@ -292,6 +293,7 @@ struct fastrpc_session_ctx {
>  	int sid;
>  	bool used;
>  	bool valid;
> +	bool coherent;
>  };
>  
>  struct fastrpc_soc_data {
> @@ -655,7 +657,9 @@ static int olaps_cmp(const void *a, const void *b)
>  static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
>  {
>  	u64 max_end = 0;
> +	int max_raix = -1;
>  	int i;
> +	int inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
>  
>  	for (i = 0; i < ctx->nbufs; ++i) {
>  		ctx->olaps[i].start = ctx->args[i].ptr;
> @@ -675,6 +679,9 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
>  			if (ctx->olaps[i].end > max_end) {
>  				max_end = ctx->olaps[i].end;
should you update max_raix here also?>  			} else {
> +				if ((max_raix < inbufs && ctx->olaps[i].raix + 1 > inbufs) ||
> +					(ctx->olaps[i].raix < inbufs && max_raix + 1 > inbufs))
if ((max_raix < inbufs) != (ctx->olaps[i].raix < inbufs))
> +					ctx->olaps[i].do_cmo = true;
>  				ctx->olaps[i].mend = 0;
>  				ctx->olaps[i].mstart = 0;
>  			}
> @@ -684,6 +691,7 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
>  			ctx->olaps[i].mstart = ctx->olaps[i].start;
>  			ctx->olaps[i].offset = 0;
>  			max_end = ctx->olaps[i].end;
> +			max_raix = ctx->olaps[i].raix;
>  		}
>  	}
>  }
> @@ -703,6 +711,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>  
>  	INIT_LIST_HEAD(&ctx->node);
>  	ctx->fl = user;
> +	ctx->sc = sc;
>  	ctx->nscalars = REMOTE_SCALARS_LENGTH(sc);
>  	ctx->nbufs = REMOTE_SCALARS_INBUFS(sc) +
>  		     REMOTE_SCALARS_OUTBUFS(sc);
> @@ -728,7 +737,6 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>  	/* Take a reference to user, released in fastrpc_context_free() */
>  	fastrpc_user_get(user);
>  
> -	ctx->sc = sc;
>  	ctx->retval = -1;
>  	ctx->pid = current->pid;
>  	ctx->client_id = user->client_id;
> @@ -1067,6 +1075,64 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
>  	return 0;
>  }
>  
> +static void fastrpc_flush_args(struct fastrpc_invoke_ctx *ctx)
> +{
> +	union fastrpc_remote_arg *rpra = ctx->rpra;
> +	int i, inbufs, outbufs;
> +
> +	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
> +	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
> +
> +	for (i = 0; i < inbufs + outbufs; ++i) {
ctx->nbufs instead of inbufs + outbufs
> +		int raix = ctx->olaps[i].raix;
> +		struct fastrpc_map *map = ctx->maps[raix];
> +
> +		if (raix + 1 > inbufs)
> +			continue;
> +		if (!map || !map->buf)
> +			continue;
> +
> +		if (rpra[raix].buf.len && (ctx->olaps[i].mstart || ctx->olaps[i].do_cmo)) {
> +			dma_buf_begin_cpu_access(map->buf, DMA_TO_DEVICE);
> +			dma_buf_end_cpu_access(map->buf, DMA_TO_DEVICE);
> +		}
> +	}
> +}
> +
> +static void fastrpc_inv_args(struct fastrpc_invoke_ctx *ctx)
> +{
> +	union fastrpc_remote_arg *rpra = ctx->rpra;
> +	int i, inbufs, outbufs;
> +
> +	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
> +	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
> +
> +	for (i = 0; i < inbufs + outbufs; ++i) {
ctx->nbufs> +		int raix = ctx->olaps[i].raix;
> +		struct fastrpc_map *map = ctx->maps[raix];
> +
> +		if (raix + 1 <= inbufs)
> +			continue;
> +		if (!rpra[raix].buf.len)
> +			continue;
> +		if (!map || !map->buf)
> +			continue;
> +
> +		/*
> +		 * Skip invalidation if the argument overlaps with the
> +		 * RPC control header page.
> +		 */
> +		if (((uintptr_t)rpra & PAGE_MASK) ==
> +			((uintptr_t)rpra[raix].buf.pv & PAGE_MASK))
is this possible? for fd buffers, buf.pv is going to be a userspace VA
and rpta addr is going to be a kernel VA, those cannot be equal.> +		
continue;
> +
> +		if (ctx->olaps[i].mstart || ctx->olaps[i].do_cmo) {
> +			dma_buf_begin_cpu_access(map->buf, DMA_FROM_DEVICE);
> +			dma_buf_end_cpu_access(map->buf, DMA_FROM_DEVICE);
> +		}
> +	}
> +}
> +
>  static struct fastrpc_invoke_buf *fastrpc_invoke_buf_start(union fastrpc_remote_arg *pra, int len)
>  {
>  	return (struct fastrpc_invoke_buf *)(&pra[len]);
> @@ -1191,6 +1257,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>  		}
>  	}
>  
> +	if (!ctx->fl->sctx->coherent)
> +		fastrpc_flush_args(ctx);
> +
>  	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
>  		list[i].num = ctx->args[i].length ? 1 : 0;
>  		list[i].pgidx = i;
> @@ -1376,6 +1445,8 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>  	if (err)
>  		goto bail;
>  
> +	if (!fl->sctx->coherent)
> +		fastrpc_inv_args(ctx);
>  	/* make sure that all CPU memory writes are seen by DSP */
>  	dma_wmb();
>  	/* Send invoke buffer to remote dsp */
> @@ -1396,6 +1467,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>  
>  	/* make sure that all memory writes by DSP are seen by CPU */
>  	dma_rmb();
> +	if (!fl->sctx->coherent)
> +		fastrpc_inv_args(ctx);
> +
>  	/* populate all the output buffers with results */
>  	err = fastrpc_put_args(ctx, kernel);
>  	if (err)
> @@ -2393,6 +2467,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	sess->used = false;
>  	sess->valid = true;
>  	sess->dev = dev;
> +	sess->coherent = of_property_read_bool(dev->of_node, "dma-coherent");
see if you can use of_dma_is_coherent() instead.>  	dev_set_drvdata(dev,
sess);
>  	sess->sid = sid;
>  

