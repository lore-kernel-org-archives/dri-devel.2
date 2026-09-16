Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044DDC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B1610E02C;
	Wed, 16 Sep 2026 10:47:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ISv5IFDB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB8C10E02C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:47:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C491A43C5C;
 Wed, 16 Sep 2026 10:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBD31F000FF;
 Wed, 16 Sep 2026 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789555663;
 bh=Jp0cbie7YDWSaXQwCxGETgcW9G4X5JnpVkswG4+zZ6c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ISv5IFDB2X5BlJjYFLkxtUEkJcRAZy//H4DK28XWMd8z1SsPH3E8kuTVfGK7AuNnp
 PrfQVGnoHeFdShNnkSsYhTQioTO5hCbUD0RD4C4hXbeNSmm3o6085J4h8nIA6z5z3f
 QYGgg8qbhqEzcMFd6YOxrThsd9kcQ2X5Cw2RD6OthwJ2aqpIXEnHv5gYO0ZSGZ+hk5
 OzmEIvcX/0dlg7QSS49sOD8Rq5hxev95tUIOACpvQLVZJLGOj8iPaoQl/x1Q3GYNmo
 PQD3KQX5MOhNueINWE/mLBQDZB6l7wVqv6flK7WKWJGcGwRvQ/7xbHaWLh3fsfmNPE
 mvla690DGTFYQ==
Date: Wed, 16 Sep 2026 11:47:40 +0100
From: Lee Jones <lee@kernel.org>
To: Ruslan Vagner <rusya92266@gmail.com>
Cc: dri-devel@lists.freedesktop.org, danielt@kernel.org
Subject: Re: [PATCH] backlight: ktd253: fix comment typo
Message-ID: <20260916104740.GO11487@google.com>
References: <CAF9RqJ64goBHhq3aC_FeGuzcRv2z1fRUyYL5hE=HPN7MsAw7RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF9RqJ64goBHhq3aC_FeGuzcRv2z1fRUyYL5hE=HPN7MsAw7RA@mail.gmail.com>
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

On Tue, 15 Sep 2026, Ruslan Vagner wrote:

> Fix the spelling in comments. No functional change.

Please expand on the subject line and the commit message.

What are you correcting helps?

This may sound pernickety, but it's important for some workflows that
subject lines are unique.  If someone fixes another typo in this file
and uses the same subject line, those workflows fail.

> Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
> ---
>  drivers/video/backlight/ktd253-backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/ktd253-backlight.c
> b/drivers/video/backlight/ktd253-backlight.c
> index 327b4ee75254..f2c5527d02e0 100644
> --- a/drivers/video/backlight/ktd253-backlight.c
> +++ b/drivers/video/backlight/ktd253-backlight.c
> @@ -53,7 +53,7 @@ static int ktd253_backlight_stepdown(struct
> ktd253_backlight *ktd253)
>  	 *
>  	 * Architectures do not always support ndelay() and we will get a few us
>  	 * instead. If we get to a critical time limit an interrupt has likely
> -	 * occured in the low part of the loop and we need to restart from the
> +	 * occurred in the low part of the loop and we need to restart from the
>  	 * top so we have the backlight in a known state.
>  	 */
>  	u64 ns;
> -- 
> 2.54.0.windows.1

-- 
Lee Jones
