Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2A71061B13
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D80D10E6D1;
	Mon, 30 Mar 2026 15:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tuqUIN84";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CAAD10E6C6
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 15:35:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 787B360054;
 Mon, 30 Mar 2026 15:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EECC4CEF7;
 Mon, 30 Mar 2026 15:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774884941;
 bh=SFWhW5IngPq2RWPWqZZkfO62PfaT7Kz3LJAdVJHZ4m0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tuqUIN84xTYo69rS0gAN1QtD1pNp+Upc/joQRZ+fi8QsZ5NSSJRnKOiEvTYjZACh4
 uTUnjJ/vFCeaOW8AwF/NxhOw6+K54bdJG4E3VMU9VQw1KkY7HsZ5JBZ1Es05gCen5E
 ez/RYJ1CnwT36J+inPaQWKulkmN73dNB7ydkd/cY=
Date: Mon, 30 Mar 2026 17:35:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, jirislaby@kernel.org, simona@ffwll.ch, sam@ravnborg.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 02/10] vt: Implement helpers for struct vc_font in source
 file
Message-ID: <2026033030-roundworm-daycare-deac@gregkh>
References: <20260327130431.59481-1-tzimmermann@suse.de>
 <20260327130431.59481-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327130431.59481-3-tzimmermann@suse.de>
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

On Fri, Mar 27, 2026 at 01:49:35PM +0100, Thomas Zimmermann wrote:
> Move the helpers vc_font_pitch() and vc_font_size() from the VT
> header file into source file. They are not called very often, so
> there's no benefit in keeping them in the headers. Also avoids
> including <liux/math.h> from the header.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/tty/vt/vt.c            | 35 ++++++++++++++++++++++++++++++++++
>  include/linux/console_struct.h | 30 ++---------------------------
>  2 files changed, 37 insertions(+), 28 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
