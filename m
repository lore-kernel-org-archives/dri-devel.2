Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2E606D826
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=O/lH5k+V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BED110F30E;
	Mon,  9 Nov 2026 14:21:21 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC0510F2FB
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=NNQc4AZF/LOIBNx2K85deaaBLDBCMdMGjAS1ywWnU7w=;
 b=O/lH5k+VUVlZQwONhSgPDSiyFD/i2B0rVGBD7EWDyli31fC6kK4vSeUh
 g/IKenfltNbFs9KPk88cbPfWLXbprdd4aLQ9CAqex8ws/AujfXtg6jz4G
 roHBWB7Wvdp5EVn5rB8gEgtAe3vL8HkO999NHo8qDmv3U1OjZ8nqV6y3P I=;
X-CSE-ConnectionGUID: B7hJjYGQS3q6NVmBi67wHQ==
X-CSE-MsgGUID: 7YknnplXTiaHyH4b32XI2A==
Authentication-Results: mail2-relais-roc.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,203,1787004000"; d="scan'208";a="304586840"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:21:11 +0100
Date: Mon, 9 Nov 2026 15:21:11 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Shivani Patel <patelshivani2283@gmail.com>
cc: outreachy@lists.linux.dev, Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix spelling mistake "writte" -> "written"
In-Reply-To: <20261109133731.66016-1-patelshivani2283@gmail.com>
Message-ID: <e235fcb8-c0fd-1e63-eddf-41efd70c7c4@inria.fr>
References: <20261109133731.66016-1-patelshivani2283@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, 9 Nov 2026, Shivani Patel wrote:

> Correct spelling mistake in comment ("writte" -> "written").
>
> Signed-off-by: Shivani Patel <patelshivani2283@gmail.com>

Someone else has already submitted that patch.  Please check the mailing
list archive before submitting patches.

julia

> ---
>  drivers/staging/fbtft/fb_st7789v.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> index 861a15414..c4db681eb 100644
> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c
> @@ -221,7 +221,7 @@ static int init_display(struct fbtft_par *par)
>   * write_vmem() - write data to display.
>   * @par: FBTFT parameter object.
>   * @offset: offset from screen_buffer.
> - * @len: the length of data to be writte.
> + * @len: the length of data to be written.
>   *
>   * Return: 0 on success, or a negative error code otherwise.
>   */
> --
> 2.50.1 (Apple Git-155)
>
>
>
