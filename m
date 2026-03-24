Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9B8FEC0FE
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4AA610E62A;
	Tue, 24 Mar 2026 19:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mJEuEmU0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E7A10E485;
 Tue, 24 Mar 2026 19:37:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B4EA143250;
 Tue, 24 Mar 2026 19:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74674C19424;
 Tue, 24 Mar 2026 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774381069;
 bh=FSMbDfBQchxcTGQjhWPZ05ODXKaW0VAxUcIbKCRCGqs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=mJEuEmU0owy6a2jdKYB8/R9rQU8F4zXiwbP8QDPHGsOOTKVIgdHFju1XuLLaXdXGM
 gU30O+8h/l9fksp4pppehaocDR9Gs6i4atxEukrk2iZyv0pbnc2CoAQwdty8J8gfKr
 Qo9toOvHDQ3aEWsYoUer4AudPSFRRrpL1YVfqEvsgi1nHC/JvKja811h2dszHPexAO
 w5Y97WcTxEnQrnqPCRW+1q2639lIGViRuxE3aAm5pwhbTQh/L50cmnd2ScIThkSNFO
 TXfRixrw+17rDFz09P9ZnIrXwu9h9vuu4NM2hN9vcsZBXja3KYud5M8HAOBW2t0pjW
 ioY6iHLowdpTw==
Date: Tue, 24 Mar 2026 14:37:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/5] vgaarb: pass vga_get_uninterruptible() errors to
 userspace
Message-ID: <20260324193748.GA1149226@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307173538.763188-2-Simon.Richter@hogyros.de>
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

On Sun, Mar 08, 2026 at 02:35:34AM +0900, Simon Richter wrote:
> If VGA routing cannot be established, vga_get_uninterruptible() returns an
> error and does not increment the lock count. Pass the error on, and don't
> call vga_put() when userspace closes the handle.

I applied this, but I'm a little confused about the "don't call
vga_put() when userspace closes the handle" part.  Does that happen in
this patch and I'm just missing it?  This patch changes the "lock"
case, and the only vga_put() call I see is in the "unlock" case.

> Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
> ---
>  drivers/pci/vgaarb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index d9383bf541e7..22b2b6ebdefd 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -1134,6 +1134,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  	char kbuf[64], *curr_pos;
>  	size_t remaining = count;
>  
> +	int err;
>  	int ret_val;
>  	int i;
>  
> @@ -1165,7 +1166,11 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  			goto done;
>  		}
>  
> -		vga_get_uninterruptible(pdev, io_state);
> +		err = vga_get_uninterruptible(pdev, io_state);
> +		if (err) {
> +			ret_val = err;
> +			goto done;
> +		}
>  
>  		/* Update the client's locks lists */
>  		for (i = 0; i < MAX_USER_CARDS; i++) {
> -- 
> 2.47.3
> 
