Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836AACA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D095210E31A;
	Thu,  1 Oct 2026 08:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gl5pnPY+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8700E10E31A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 08:59:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1330240495;
 Thu,  1 Oct 2026 08:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAB41F000FF;
 Thu,  1 Oct 2026 08:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1790845189;
 bh=Qg3Weja5Q3oGkvaEMHZcYe3F1qNOpQXxAR+re6VwDN8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gl5pnPY+TWiY33etkY/VLoSqJeVD9QLK0rsqIaNNfIAimk3hMzn9h76h8D1uWGR7o
 BY04wSAeIwXRDh2vbBdvHd8XgWI9TbS8KiGhjF86utpbCQU6Au3x8vva3DV7M8iE2c
 to1hZK/Ch63Zr+LGAfxBRkCQ0ahopfB7pjd+856g=
Date: Thu, 1 Oct 2026 10:59:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, jirislaby@kernel.org, simona@ffwll.ch,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-serial@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 1/5] vt: Add cursor-size helpers
Message-ID: <2026100134-handwork-detoxify-6888@gregkh>
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928085724.41660-2-tzimmermann@suse.de>
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

On Mon, Sep 28, 2026 at 10:55:24AM +0200, Thomas Zimmermann wrote:
> Cursors in the VT subsystem are blocks within a character cell that are
> filled with the foreground color. The new helpers vc_cursor_start() and
> vc_cursor_end() return the scanlines in which the cursor block starts rsp.
> ends. This is compatible with VGA hardware.
> 
> In terms of cursor design, the new cursor-size helpers follow established
> styles in fbcon. The only exception is in underline cursors for fonts with
> a size larger than 10. The underlining dash is now one pixel closer to
> the font-glyph data, so that the cursor looks less detached. This follows
> the style used by vgacon.
> 
> Users control the cursor size with the vt module's parameter cur_default
> or with the ESC sequence \e[?Nc, where N is the cursor-size constant. In
> case of an invalid setting, the new helpers fall back to cur_default and
> then underline cursors; in this order.
> 
> Similar code in vgacon and fbcon ignores the cursor's default size stored
> in vt.cur_default. The consoles default to full-block cursors, while vt
> defaults to underline cursors. VGA BIOSes also tend to use underline by.
> default. Upon initialization vt applies its default to the console, but
> each console might fall back to it own default. For example, running the
> ESC code from above with the invalid constant of 8 magically flips the
> cursor from underline to block size on vgacon. Another call with N set
> to 0 (i.e., default) magically flips it back to underlyine. Making
> underline the new default everywhere harmonizes vt, fbcon and most VGA
> BIOSes.
> 
> v3:
> - mention user interfaces to control cursor size in commit message (GregKH)
> - elaborate defaults (GregKH)
> - move retry logic into helper
> - handle CUR_DEF
> v2:
> - export non-font interface for vgacon
> - avoid interference from concurrent user space (Sashiko)
> - fix function docs (Sashiko)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Helge Deller <deller@gmx.de>
> ---
>  drivers/tty/vt/vt.c            | 104 +++++++++++++++++++++++++++++++++
>  include/linux/console_struct.h |   7 +++
>  2 files changed, 111 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
