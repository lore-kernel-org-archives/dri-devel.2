Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13A0FF8850
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 03:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024E810E0A9;
	Mon, 27 Apr 2026 03:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0LFeon8X";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FA210E0A9
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 03:50:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A01DF406FB;
 Mon, 27 Apr 2026 03:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78220C19425;
 Mon, 27 Apr 2026 03:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1777261842;
 bh=RcfcXYW51t/iPmoV3lUxNMrLOCattsjAxUBYfK9egwc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0LFeon8XBN13MkmFgs2gk5N+prfbdNSiceYH6PjhANwxwMrn38zO5MiOIPTNEbMns
 vjrl/aHaE1cSIz+CmelXxLVd16SfWPDuwr5FQu7yOJaygIwnmlkPFOUFpMdhJpUWH2
 iMm+mzttg0g1b2FnB744Xq/hiF+4wntZKZsGUap8=
Date: Sun, 26 Apr 2026 21:20:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sachin Kumar <sachinkumar905846@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: clarify TODO comment in fbtft-core
Message-ID: <2026042631-resolved-outline-2946@gregkh>
References: <CAHp75VeFZ7PDV_tT8tDibQk-VPkFFHsxiAHOAx-9Xp0N1ijvAQ@mail.gmail.com>
 <20260417093303.33670-1-sachinkumar905846@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417093303.33670-1-sachinkumar905846@gmail.com>
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

On Fri, Apr 17, 2026 at 03:03:03PM +0530, Sachin Kumar wrote:
> Improve wording of a TODO comment to better describe the
> intended optimization. The comment now clearly states that
> only the changed display area should be updated instead of
> refreshing the entire screen.
> 
> Signed-off-by: Sachin Kumar <sachinkumar905846@gmail.com>
> ---
> v3:
> - add missing changelog for previous version
> - simplify TODO comment to match kernel style
> 
>  drivers/staging/fbtft/fbtft-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index f427c0914..cff838955 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -414,7 +414,7 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
>  {
>  	struct fbtft_par *par = info->par;
>  
> -	/* TODO: only mark changed area update all for now */
> +	/* TODO: update only changed area, not entire display */
>  	par->fbtftops.mkdirty(info, -1, 0);
>  }
>  
> -- 
> 2.43.0
> 

Does not apply to the tree anymore :(
