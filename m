Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016D7C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6057C10EFF7;
	Wed, 23 Sep 2026 12:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2aCZeGO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B21D10EFFB
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:57:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1976240313;
 Wed, 23 Sep 2026 12:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314F91F000FF;
 Wed, 23 Sep 2026 12:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1790168251;
 bh=XLTp0wewpuY118fys5W1b0y8r0H8Q0XPdv/ybcdCmY4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=R2aCZeGOoimhy9ZsjHPyt7Tpj+VMRwM/K3DC6CHB4j/Gs+JUUEn87XvT95QYtpf3M
 rZrnwM/DXu/9MMSTjWJIVD7qgO71fbB+5Lym+nUxL3QGJfJsJJ6vXiuEVXo7gtAX8x
 1CpDdnq9Zv3XetVJM+tgJDKWIIgsTknGhuK1DDxA=
Date: Wed, 23 Sep 2026 14:57:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, jirislaby@kernel.org, simona@ffwll.ch,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-serial@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 1/5] vt: Add cursor-size helpers
Message-ID: <2026092347-try-railroad-7b00@gregkh>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
 <20260915123304.1027277-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915123304.1027277-2-tzimmermann@suse.de>
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

On Tue, Sep 15, 2026 at 02:29:12PM +0200, Thomas Zimmermann wrote:
> Cursors in the VT subsystem are blocks within a character cell that are
> filled with the foreground color. The new helpers vc_cursor_start() and
> vc_cursor_end() return the scanlines in which the cursor block starts rsp.
> ends. This is compatible with VGA hardware
> 
> In terms of cursor design, the new cursor-size helpers follow established
> styles in fbcon. The only exception is in underline cursors for fonts with
> a size larger than 10. The underlining dash is now one pixel closer to
> the font-glyph data, so that the cursor looks less detached. This follows
> the style used by vgacon.
> 
> Similar code in vgacon and fbcon ignores the cursor's default size stored
> in vt.cur_default. The consoles default to full-block cursors, while vt
> defaults to underline cursors. The new helper fall back to cur_default and
> then underline cursors; in this order.
> 
> v2:
> - export non-font interface for vgacon
> - avoid interference from concurrent user space (Sashiko)
> - fix function docs (Sashiko)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Helge Deller <deller@gmx.de>
> ---
>  drivers/tty/vt/vt.c            | 93 ++++++++++++++++++++++++++++++++++
>  include/linux/console_struct.h |  7 +++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 57edf37495a8..5d2583cd6e79 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -71,6 +71,7 @@
>   * by Adam Tla/lka <atlka@pg.gda.pl>, Aug 2006
>   */
>  
> +#include <linux/compiler.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/sched/signal.h>
> @@ -264,6 +265,98 @@ unsigned int vc_font_size(const struct vc_font *font)
>  }
>  EXPORT_SYMBOL_GPL(vc_font_size);
>  
> +/*
> + * Cursors
> + */
> +
> +/**
> + * vc_cursor_start - Calculates the cursor's first scanline within a character cell
> + * @cell_height: The overall height of the character cell
> + * @cursor_size: The size constant of cursor pattern
> + *
> + * The parameter @cell_height is the height of the character cell as
> + * displayed by the console. The argument given in @cursor_size is one
> + * of the CUR_ constants, as stored in struct @vc_data.vc_cursor_type.
> + * For unknown values, the helper draws the default cursor or an underline
> + * dash.
> + *
> + * Returns:
> + * The index of the cursor's first scanline within the character cell
> + */
> +unsigned int vc_cursor_start(unsigned int cell_height, unsigned int cursor_size)
> +{
> +	const unsigned int cursor_default_size = CUR_SIZE(READ_ONCE(cur_default));
> +
> +retry:
> +	switch (cursor_size) {
> +	case CUR_NONE:
> +		return cell_height;
> +	case CUR_UNDERLINE:
> +		if (cell_height < 10)
> +			return cell_height - 1;
> +		else
> +			return cell_height - 3;
> +	case CUR_LOWER_THIRD:
> +		return cell_height - cell_height / 3;
> +	case CUR_LOWER_HALF:
> +		return cell_height - cell_height / 2;
> +	case CUR_TWO_THIRDS:
> +		return cell_height - (cell_height * 2) / 3;
> +	case CUR_BLOCK:
> +		return 0;
> +	default:
> +		pr_warn_once("Unknown cursor %u\n", cursor_size);

Can userspace trigger this?  If not, who can?

> +		if (cursor_size != cursor_default_size)
> +			cursor_size = cursor_default_size;
> +		else
> +			cursor_size = CUR_UNDERLINE;

Why underline as a default?

thanks,

greg k-h
