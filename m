Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDB7C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A914610E6A5;
	Mon, 31 Aug 2026 07:00:32 +0000 (UTC)
Received: from mail.muc.de (mail.muc.de [193.149.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF40689BF4
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 11:51:24 +0000 (UTC)
Received: (qmail 17902 invoked by uid 3782); 29 Aug 2026 13:51:22 +0200
Received: from muc.de (p4fe15d93.dip0.t-ipconnect.de [79.225.93.147]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Sat, 29 Aug 2026 13:51:21 +0200
Received: (qmail 56114 invoked by uid 1000); 29 Aug 2026 11:51:20 -0000
Date: Sat, 29 Aug 2026 11:51:20 +0000
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Simona Vetter <simona@ffwll.ch>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [Patch 1/9]: Make consolemap.c handle Unicode planes outside BMP
Message-ID: <apLHuOHMjO5OzX9E@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box> <apCFLI0ga-DG-HRN@MAC.fritz.box>
 <d1437839-5a08-46d9-b40d-83faae7b19c9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1437839-5a08-46d9-b40d-83faae7b19c9@kernel.org>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

Thanks for trying the patch out.

On Fri, Aug 28, 2026 at 06:57:04 +0200, Jiri Slaby wrote:
> On 27. 08. 26, 20:42, Alan Mackenzie wrote:
> > vt: 32b glyph: 1. Make consolemap.c handle Unicode planes outside BMP

> > For this, add a fourth layer "planes" onto the sparse map in
> > this file.  Also handle glyph numbers up to 2^21 rather than
> > 256/512.  Move the conversion between __user and kernel data
> > from consolemap.c to vt_ioctl.c.

> > Signed-off-by: Alan Mackenzie <acm@muc.de>

> > diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> > index 3fa89a2dbeba..2f695d97f0eb 100644
> > --- a/drivers/tty/vt/consolemap.c
> > +++ b/drivers/tty/vt/consolemap.c
> > @@ -34,11 +34,11 @@
> >   #include <linux/tty.h>
> >   #include <linux/uaccess.h>
> >   #include <linux/console.h>
> > -#include <linux/consolemap.h>
> >   #include <linux/vt_kern.h>
> > +#include <linux/consolemap.h>

> Why do you do this?

That's a remnant of a struggle to put in new declarations such that the
kernel would build at all.  I've just tried restoring the original order
of the #includes for consolemap.h and vt_kern.h, and it builds equally
well.  So that change could/should be undone.

> >   #include <linux/string.h>

> > -static unsigned short translations[][E_TABSZ] = {
> > +static u1632 translations[][E_TABSZ] = {

> This breaks the build at this point, right?

I'm assuming your error message was "symbol u1632 undeclared".  I don't
understand yet what's happened here.  u1632 gets declared in
consolemap.h, so should be avaiable throughout consolemap.c.

> u1632 is a bad name though.

Possibly.  It's the best I could come up with, given it should be concise
and thus not cause a lot of refilling of the source code.  I'm not sure
what would be better instead of u1632.

> See also what Sashiko thinks:
> https://sashiko.dev/#/patchset/apCEDM2sWv_M354-%40MAC.fritz.box

Sashiko has pointed out a number of errors I'll need to fix.  I got nine
emails directly from it.

> thanks,
> -- 
> js
> suse labs

-- 
Alan Mackenzie (Nuremberg, Germany).
