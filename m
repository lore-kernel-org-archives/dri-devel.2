Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F1CFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 18:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E038610E3F2;
	Mon,  4 May 2026 18:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tYnOJMGy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3368010E3F2
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 18:54:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 631156001A;
 Mon,  4 May 2026 18:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E3AC2BCB8;
 Mon,  4 May 2026 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777920853;
 bh=dy5/55QBdeydztrFJq5mNMnljqTizOtwp3CZd2/hRmk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tYnOJMGyLY6GnbhKSxQI3if2bRfT23sQId4QsjcB6hEd2SI5L5ptm6JErN7L1w/I2
 yR6nwRtw9k+ctpWUK30Oef6NYZjW6LpB5yNX+O8DM2WOFvZTdqaOR9bBPf6z6P/vCU
 hetQqKXCOUC/jEnGplIrwbcZdIzqk7b+8ALehxzIlm3fSnGWgsKxzl2F4hQWQZBOce
 O1Lzk78XGDoE7Hy71480HESZlxbdyfE9huHYn8o6zTJc9myX2uznn92yNOQAtC05th
 FlgpsFVop3KdRkzUELptY5E9fgaBo0Jwk2uqwSQ5jtV2e/ln9eT4G1R+9S0Fk0uURq
 76Yw2Y0XqXiOQ==
Date: Mon, 4 May 2026 13:54:08 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] misc: fastrpc: Move prints outside spinlock in
 fastrpc_cb_probe
Message-ID: <afjrOx44kOHmmm66@baldur>
References: <20260504171701.18164-1-mukesh.ojha@oss.qualcomm.com>
 <20260504171701.18164-2-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504171701.18164-2-mukesh.ojha@oss.qualcomm.com>
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

On Mon, May 04, 2026 at 10:47:01PM +0530, Mukesh Ojha wrote:
> dev_err() and dev_info() were called while holding a spinlock with
> IRQs disabled, which is incorrect as printk can be slow and should
> not be called in atomic context.
> 
> Move the dev_err() for the FASTRPC_MAX_SESSIONS check to after the
> spinlock is released, and save the return value of of_property_read_u32()
> to print dev_info() after the lock is dropped. Minor variable style
> correction in probe function.
> 

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
> Changes in v2:
>  - New change.
> 
>  drivers/misc/fastrpc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a1a54453bb7e..d169dea961f0 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2197,19 +2197,22 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int i, sessions = 0;
>  	unsigned long flags;
> -	int rc;
>  	u32 dma_bits;
> +	u32 sid = 0;
> +	int rc;
>  
>  	cctx = dev_get_drvdata(dev->parent);
>  	if (!cctx)
>  		return -EINVAL;
>  
>  	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
> +	if (of_property_read_u32(dev->of_node, "reg", &sid))
> +		dev_info(dev, "FastRPC Session ID not specified in DT\n");
>  
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
> -		dev_err(&pdev->dev, "too many sessions\n");
>  		spin_unlock_irqrestore(&cctx->lock, flags);
> +		dev_err(&pdev->dev, "too many sessions\n");
>  		return -ENOSPC;
>  	}
>  	dma_bits = cctx->soc_data->dma_addr_bits_default;
> @@ -2218,13 +2221,11 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	sess->valid = true;
>  	sess->dev = dev;
>  	dev_set_drvdata(dev, sess);
> +	sess->sid = sid;
>  
>  	if (cctx->domain_id == CDSP_DOMAIN_ID)
>  		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
>  
> -	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
> -		dev_info(dev, "FastRPC Session ID not specified in DT\n");
> -
>  	if (sessions > 0) {
>  		struct fastrpc_session_ctx *dup_sess;
>  
> -- 
> 2.53.0
> 
> 
