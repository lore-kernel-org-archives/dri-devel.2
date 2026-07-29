Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B922C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E94C10E008;
	Wed, 29 Jul 2026 07:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SZY+xk3C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A863C10E008
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 07:17:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F825408D7;
 Wed, 29 Jul 2026 07:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306111F00A3A;
 Wed, 29 Jul 2026 07:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785309446;
 bh=vcKTh0I2lSYn5EdTqVPQ1XHW1xDK2XtabNERv8UPWJs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SZY+xk3CJfhei5xkSER8CywGOqN7Zn6HMpGCSnbk+eLXhoFEOIEg1XMdEYx44seIG
 mZ7M6TJqFOF5B6J8iJ3FgVJXmduL82ZzsqueM5Sl8sgqQDYbhdHE2FGPfHn9PCyNAE
 +indXKkLyCWeG0ISch+6Nv123peeXaL//lc1VHvNEQjfIV3nuXhaDCJuAcTapSWm3l
 RmyH1ZYal6+6rT9ep0n7pNhh7vlLpPgAuOoSpKH/InHbt7QiMOycVyTcSqDy+mVg1I
 mYDGL4X8IRLZPrNOmo22My63hWhVEqmV+1uiN2/Sjkkee3RYaULJSlN2Dfy02BVwP4
 0Upz3osXRzcVw==
Message-ID: <753a164a-c297-4357-8024-77f8579d1380@kernel.org>
Date: Wed, 29 Jul 2026 08:17:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] misc: fastrpc: Drop unhandled DSP PD exit
 notification
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260729071235.946502-1-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260729071235.946502-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 7/29/26 8:12 AM, Shawn Guo wrote:
> Newer DSP firmware implements a PD (Protection Domain) notification
> framework that sends PD state notifications upon request. The PD exit
> notification is unconditionally sent by the DSP with a fixed sentinel
> 0xABCDABCD in the context field.
> 
> fastrpc_rpmsg_callback() treats every inbound message as an invoke
> response, so the sentinel is masked and shifted like any real response
> ((0xABCDABCD & 0xFF0) >> 4 == 188) and looked up in the channel's
> context idr.
> 
> This is not merely cosmetic. In the common case idr slot 188 is empty,
> the lookup fails, and the driver only logs a spurious "No context ID
> matches response" error on every teardown. But the context idr is shared
> by every protection domain and the listener thread on the channel and is
> filled cyclically over [1, FASTRPC_CTX_MAX]. If slot 188 holds a live
> context when the sentinel arrives, the sentinel's return value is written
> into that unrelated in-flight invocation and it is completed early.
> 
> Since neither the fastrpc library nor the driver supports the DSP PD
> notification framework, it is safe to drop the PD exit notification
> before it is ever turned into a context lookup. This removes both the
> log spam and the mis-completion race. A genuine response can never be
> masked: a real context is (idr_index << 4) | pd (at most 0xFF3) and
> can never equal the sentinel.
> 
> Assisted-by: Claude:claude-opus-4-8
> Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Applied thanks,

-srini
> Resend by rebasing on Srini's fastrpc for-next branch
> 
> Changes for v2:
> - Update per Ekansh's input about PD state notification (Thanks Ekansh!)
> - Link to v1: https://lore.kernel.org/all/20260727130940.577721-1-shengchao.guo@oss.qualcomm.com/
> 
>  drivers/misc/fastrpc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a859edb75499..dd51d475a74e 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -51,6 +51,17 @@
>  /* Sequence number occupies bits 63:16 of the ctxid / message context */
>  #define FASTRPC_CTXID_SEQ_SHIFT	16
>  #define FASTRPC_CTXID_SEQ_MASK	GENMASK_ULL(63, 16)
> +
> +/*
> + * Newer DSP firmware implements a PD (Protection Domain) notification
> + * framework that sends PD state notifications upon request. The PD exit
> + * notification is unconditionally sent by the DSP with this fixed sentinel
> + * in the context field rather than the context of an outstanding invocation.
> + * Since the fastrpc driver does not support the DSP PD notification framework,
> + * this message must be dropped rather than matched against the context idr.
> + */
> +#define FASTRPC_DSP_PD_NOTIFY_CTX	0xABCDABCD
> +
>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
>  #define INIT_FILE_NAMELEN_MAX (128)
>  #define FASTRPC_DEVICE_NAME	"fastrpc"
> @@ -2710,6 +2721,14 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  	if (!cctx)
>  		return -ENODEV;
>  
> +	/*
> +	 * A PD exit notification from the DSP PD notification framework carries
> +	 * this sentinel rather than a real context. Drop it: a real context is
> +	 * (idr_index << 4) | pd and can never collide with this value.
> +	 */
> +	if (rsp->ctx == FASTRPC_DSP_PD_NOTIFY_CTX)
> +		return 0;
> +
>  	ctxid = FIELD_GET(FASTRPC_CTXID_MASK, rsp->ctx);
>  
>  	spin_lock_irqsave(&cctx->lock, flags);

