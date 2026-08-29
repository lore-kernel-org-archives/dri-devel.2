Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F15C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B455810E688;
	Mon, 31 Aug 2026 07:00:05 +0000 (UTC)
Received: from mail.muc.de (mail.muc.de [193.149.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6222B10E0A9
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 14:39:59 +0000 (UTC)
Received: (qmail 42254 invoked by uid 3782); 29 Aug 2026 16:39:57 +0200
Received: from muc.de (p4fe15d93.dip0.t-ipconnect.de [79.225.93.147]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Sat, 29 Aug 2026 16:39:56 +0200
Received: (qmail 57602 invoked by uid 1000); 29 Aug 2026 14:39:55 -0000
Date: Sat, 29 Aug 2026 14:39:55 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: vt: Enlarge the framebuffer glyph size from 16 to 32 bits
Message-ID: <apLvO-8YJmQG7T0Z@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
 <apGc4y8ApYWh4Yr4@MAC.fritz.box>
 <2026082938-spray-shimmer-9389@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026082938-spray-shimmer-9389@gregkh>
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

On Sat, Aug 29, 2026 at 14:09:52 +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 28, 2026 at 02:36:19PM +0000, Alan Mackenzie wrote:
> > On Fri, Aug 28, 2026 at 08:12:16 +0200, Thomas Zimmermann wrote:
> > > Hi

> > > Am 27.08.26 um 20:38 schrieb Alan Mackenzie:
> > > > vt: Enlarge the framebuffer glyph size from 16 to 32 bits.

> > > > This allows:
> > > >    o - More than 256/512 distinct half-width glyphs (in fact, up to 2^21).
> > > >    o - Unicode code points >0xffff (outside the Basic Multilingual Plane).
> > > >    o - Coloured glyphs (as before).

> > > But what is the use case here? We have excellent support for text and 
> > > font rendering in graphical userspace for I18N and L10N.

> > GUIs are sub-optimal for pure text work.  A full screen terminal is
> > wanted.  The current preeminent user space terminal, kmscon, appears to
> > lack the refinements of many decades development of the kernel's
> > console.

> What is missing from kmscon that the kernel currently supports?

<Alt>-<Fn>, for a start.  Also the facility to enter an arbitrary Unicode
code point by holding down <AltGr> and typing the hex code on the numeric
keypad.  There are probably other things, too.

> Why not just make it feature-equal there, and then make these
> additional changes there as well?

I suspect the politics involved would be more difficult than here, and
I'm not good at politics.  kmscon is controlled by Redhat, and they have
a reputation for dismissing third party suggestions and patches rather
than integrating them.

But it's not just a matter of adding features.  The kernel console is an
elegant system.  You just have to add entries in /etc/inittab, select a
keyboard, select a font (all mostly done at system installation) and
that's it.  kmscon is anything but elegant.  It has something like 75
command line options, and a configuration file is virtually mandatory.

kmscon has no documentation for its keyboard system, nothing to compare
with Andries Brouwer's keymaps man page.  It uses xkb.  I remember
searching for xkb doc around 10 years ago and found nothing systematic.
Just a very helpful tutorial, which enabled me to  make my changes.

I don't think it's got doc for its various font systems either.  It might
well be that you need to use a GUI to make font changes.  That is not a
Good Thing.

> As others have said, we don't want to add new features to the in-kernel
> console mode due to all of the reasons the patch review has shown on
> this series already (i.e. complex interactions that end up making the
> system broken.)  This is best all done in userspace, where a bug there
> will not cause these same problems, right?

From the user's point of view, a bug in either will render his computer
unusable.

Have you considered that the code in kmscon might not be any better than
that in the kernel's console?  I've no evidence either way.

> > Support for blind users exists in the kernel's console.  I don't know
> > how good it is, as I don't (yet) need to use it.

> But others use it, so we can't break that, and the fact that you ignored
> those codepaths here makes me very worried.

Hey, give me a chance!  One thing at a time.  I didn't ignore that code,
I noted (in two Kconfig's) that it would also need attention, and I
blocked it out safely when CONFIG_FB_GLYPH_21BIT was set.

It may well be (I'm not sure) that these facilities for the blind are an
integral part of the kernel's console.  That would be a good reason not
to remove it from the kernel.

> > > In contrast, the kernel's text-mode support is limited and a hotbed for 
> > > bugs. IMHO we shouldn't add features, but try to simplify that code base.

> > >From a user's point of view, the kernel's console is rock solid and
> > dependable; it doesn't crash, and its interfaces don't suddenly change
> > with the latest release of KDE or Gnome or whatever.

> This has nothing to do with KDE or Gnome, if you have issues with those
> projects, please take it up with them and contribute to them to resolve
> those issues.  I know they can always use the help.

My point is that the kernel's console is rock solid and dependable.
Things like kmscon are subject to the vagaries of fashion.

> > As is clear, I think the console's limitations should be eliminated.

> And the rest of us feel the kernel console's code should be eliminated
> entirely, when ever possible :)

The rest of you don't appear to be console users.  It's easy to advocate
for removal when you don't use it yourself.

> thanks,

> greg k-h

-- 
Alan Mackenzie (Nuremberg, Germany).
