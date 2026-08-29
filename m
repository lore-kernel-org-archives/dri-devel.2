Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395C6C61DBE
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 12:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D435510E0BA;
	Sat, 29 Aug 2026 12:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NmxNPYHH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D0110E0BA
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 12:08:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C6FF404D7;
 Sat, 29 Aug 2026 12:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BAD1F000E9;
 Sat, 29 Aug 2026 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1788005285;
 bh=ys9sRKbgEpc5JxVtcfwGv4NRd6EIcf1du2RYoL+jQgQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NmxNPYHH9C+VyW/6yjXarFBxkmWittKOqczKtopSFHjUu7RNdtA0Vn4VZlV01MpzE
 HpF1Wp/O2vLeJWJGbuAWVcngR0otVdt759/9esMjn73f4hK+Anxer6AdwwZfzhi9yT
 XkgrUIwWhe609SKpK6scBf5lzVWfBevDRJA4Bdzc=
Date: Sat, 29 Aug 2026 14:06:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Mackenzie <acm@muc.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Patch 9/9]: vt: Misc changes, e.g. to #include directives
Message-ID: <2026082918-hungry-disk-c472@gregkh>
References: <apCEDM2sWv_M354-@MAC.fritz.box> <apCI6JhoH5D7ss34@MAC.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCI6JhoH5D7ss34@MAC.fritz.box>
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

On Thu, Aug 27, 2026 at 06:58:48PM +0000, Alan Mackenzie wrote:
> vt: 32b glyph: 9. Misc changes, e.g. to #include directives
> 
> Rearrange some #include directives, add some clarifying
> comments, and some code changes which didn't fit elsewhere.

But you need to list those code changes and why you are making them, and
the #include stuff should be it's own patch, right?

And why this:

> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 13f4e48b4142..18affdb3c7c5 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -48,6 +48,8 @@ static struct vc_selection {
>  	.start = -1,
>  };
>  
> +static unsigned int size_row;
> +
>  /* clear_selection, highlight and highlight_pointer can be called
>     from interrupt (via scrollback/front) */
>  
> @@ -340,6 +342,7 @@ static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
>  {
>  	int ps, pe;
>  
> +	size_row = vc->vc_size_row;
>  	poke_blanked_console();
>  
>  	if (v->sel_mode == TIOCL_SELCLEAR) {


You set a local variable that is never actually used anywhere?

This feels very very odd, especially as the "last" patch in the series.

greg k-h
