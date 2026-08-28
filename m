Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4165EC624C2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8920010E6A3;
	Mon, 31 Aug 2026 07:00:32 +0000 (UTC)
Received: from mail.muc.de (mail.muc.de [193.149.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F8910E50E
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:36:23 +0000 (UTC)
Received: (qmail 81510 invoked by uid 3782); 28 Aug 2026 16:36:21 +0200
Received: from muc.de (p4fe15a47.dip0.t-ipconnect.de [79.225.90.71]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Fri, 28 Aug 2026 16:36:20 +0200
Received: (qmail 56479 invoked by uid 1000); 28 Aug 2026 14:36:19 -0000
Date: Fri, 28 Aug 2026 14:36:19 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: vt: Enlarge the framebuffer glyph size from 16 to 32 bits
Message-ID: <apGc4y8ApYWh4Yr4@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
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

On Fri, Aug 28, 2026 at 08:12:16 +0200, Thomas Zimmermann wrote:
> Hi

> Am 27.08.26 um 20:38 schrieb Alan Mackenzie:
> > vt: Enlarge the framebuffer glyph size from 16 to 32 bits.

> > This allows:
> >    o - More than 256/512 distinct half-width glyphs (in fact, up to 2^21).
> >    o - Unicode code points >0xffff (outside the Basic Multilingual Plane).
> >    o - Coloured glyphs (as before).

> But what is the use case here? We have excellent support for text and 
> font rendering in graphical userspace for I18N and L10N.

GUIs are sub-optimal for pure text work.  A full screen terminal is
wanted.  The current preeminent user space terminal, kmscon, appears to
lack the refinements of many decades development of the kernel's
console.

Support for blind users exists in the kernel's console.  I don't know
how good it is, as I don't (yet) need to use it.

> In contrast, the kernel's text-mode support is limited and a hotbed for 
> bugs. IMHO we shouldn't add features, but try to simplify that code base.

From a user's point of view, the kernel's console is rock solid and
dependable; it doesn't crash, and its interfaces don't suddenly change
with the latest release of KDE or Gnome or whatever.

As is clear, I think the console's limitations should be eliminated.

> Best regards
> Thomas

-- 
Alan Mackenzie (Nuremberg, Germany).
