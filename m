Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFFCFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 18:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A5410E00D;
	Mon,  4 May 2026 18:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L1xw8aKL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC49010E00D
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 18:53:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 565EF4350A;
 Mon,  4 May 2026 18:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8A6C2BCB8;
 Mon,  4 May 2026 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777920822;
 bh=VMUPvLHotG5xVtk6Co7SxW4Y31dip3x6XXbgEu8a9fc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L1xw8aKLrrWn0XepDsWxGwpRejcjOQLPMF8kG2vRgrE5JDrEFkAmpjBCSWTWAb/pa
 H6qhqvJjV1EDgIsUmjXmi7RlussvSjcJRG1/I+lQaBIGJiSLsN+AVt4xQzYJ0/oKkf
 Fns3g2gIv7e617+QY643u+fh620nAiEMw/N9v32jgzqJ+k8mQUH5jPRrcZtmkY+oCO
 yS8kJgmD2RPmsG+jsjFBm9gXuwX8W5i5UN/NlgLQtiWBC7ca5EhM6X1gmOqVljcH+0
 lKTsXD2Wd5qpQPmlxj/Js+/KSKrpIgu4Vp5ORVMBv8zut2vjWx2CsKQT87bocWruy1
 QR8AUdAt8y1aw==
Date: Mon, 4 May 2026 13:53:37 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] misc: fastrpc: Fix NULL pointer dereference in
 rpmsg callback
Message-ID: <afjprOhBhP15-2lU@baldur>
References: <20260504171701.18164-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504171701.18164-1-mukesh.ojha@oss.qualcomm.com>
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

On Mon, May 04, 2026 at 10:47:00PM +0530, Mukesh Ojha wrote:
> A NULL pointer dereference was observed on Hawi at boot when the DSP
> sends a glink message before fastrpc_rpmsg_probe() has completed
> initialization:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000178
>   pc : _raw_spin_lock_irqsave+0x34/0x8c
>   lr : fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
>   ...
>   Call trace:
>    _raw_spin_lock_irqsave+0x34/0x8c (P)
>    fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
>    qcom_glink_native_rx+0x538/0x6a4
>    qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]
> 
> The faulting address 0x178 corresponds to the lock variable inside
> struct fastrpc_channel_ctx, confirming that cctx is NULL when
> fastrpc_rpmsg_callback() attempts to take the spinlock.
> 
> There are two issues here. First, dev_set_drvdata() is called before
> spin_lock_init() and idr_init(), leaving a window where the callback
> can retrieve a valid cctx pointer but operate on an uninitialized
> spinlock. Second, the rpmsg channel becomes live as soon as the driver
> is bound, so fastrpc_rpmsg_callback() can fire before dev_set_drvdata()
> is called at all, resulting in dev_get_drvdata() returning NULL.
> 
> Fix both issues by moving all cctx initialization ahead of
> dev_set_drvdata() so the structure is fully initialized before it
> becomes visible to the callback, and add a NULL check in
> fastrpc_rpmsg_callback() as a guard against any remaining window.
> 
> Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

The fix looks good to me.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>


But I can't help wonder, what's in that message? Should we make sure to
handle it, longer term?

Regards,
Bjorn

> ---
> Changes in v2: https://lore.kernel.org/lkml/20260417200146.184425-1-mukesh.ojha@oss.qualcomm.com/
>  - Added stable mailing list and fixes tag.
> 
>  drivers/misc/fastrpc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1080f9acf70a..a1a54453bb7e 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2431,7 +2431,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  
>  	kref_init(&data->refcount);
>  
> -	dev_set_drvdata(&rpdev->dev, data);
>  	rdev->dma_mask = &data->dma_mask;
>  	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
>  	INIT_LIST_HEAD(&data->users);
> @@ -2440,6 +2439,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	idr_init(&data->ctx_idr);
>  	data->domain_id = domain_id;
>  	data->rpdev = rpdev;
> +	dev_set_drvdata(&rpdev->dev, data);
>  
>  	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
>  	if (err)
> @@ -2513,6 +2513,9 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  	if (len < sizeof(*rsp))
>  		return -EINVAL;
>  
> +	if (!cctx)
> +		return -ENODEV;
> +
>  	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
>  
>  	spin_lock_irqsave(&cctx->lock, flags);
> -- 
> 2.53.0
> 
> 
