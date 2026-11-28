Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52136606A31F
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tIfaUA/d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B9810E133;
	Sat, 28 Nov 2026 07:34:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C5010E133
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 07:34:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECA8F6022E;
 Sat, 28 Nov 2026 07:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F361F00893;
 Sat, 28 Nov 2026 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1795851263;
 bh=pQ5uqYUTt69pvlirMD5f0Jz3I14uJXUx+jsS7NcKyfM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=tIfaUA/dc8Fw16Y2o713NlL3rfwGuIj7u2MO0/XN7mw8/gAuO/p6+RHMG0STxcs+R
 EALkIwJc+zjQtmf+8nUwdOFgz74IIY+e574FKThjUNhuhugdeG8C5s1+IgM5wJ710a
 1jKVr1IfTRNR7t1qbmFYsqBJjUv3aIK0hP5nDBiY=
Date: Sat, 28 Nov 2026 08:34:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: akafelixab@gmail.com
Cc: Andy Shevchenko <andy@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_tinylcd: align arguments with open
 parenthesis
Message-ID: <2026112807-risk-saloon-83e0@gregkh>
References: <20261127-fbtft-align-v1-1-92de6f92ebe8@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127-fbtft-align-v1-1-92de6f92ebe8@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 07:16:55PM -0500, Felix Huang via B4 Relay wrote:
> From: Felix Huang <akafelixab@gmail.com>
> 
> Align multi-line function call arguments with the opening parenthesis
> to adhere to the Linux kernel coding style and fix checkpatch.pl
> alignment checks.
> 
> Signed-off-by: Felix Huang <akafelixab@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index afa8f1c74..d58b12472 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

Nope, look at the archives for why we keep rejecting this :)
