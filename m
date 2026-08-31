Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01174C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE1810EBA9;
	Tue,  1 Sep 2026 07:37:39 +0000 (UTC)
Received: from mail.muc.de (mail.muc.de [193.149.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD3810E912
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:45:27 +0000 (UTC)
Received: (qmail 5865 invoked by uid 3782); 31 Aug 2026 16:45:24 +0200
Received: from muc.de (pd953ad31.dip0.t-ipconnect.de [217.83.173.49]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Mon, 31 Aug 2026 16:45:24 +0200
Received: (qmail 37064 invoked by uid 1000); 31 Aug 2026 14:45:23 -0000
Date: Mon, 31 Aug 2026 14:45:23 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: vt: Enlarge the framebuffer glyph size from 16 to 32 bits
Message-ID: <apWTg6mNZrdBm2-D@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
 <apGc4y8ApYWh4Yr4@MAC.fritz.box>
 <2026082938-spray-shimmer-9389@gregkh>
 <apLvO-8YJmQG7T0Z@MAC.fritz.box>
 <7c199c7f-d89b-48ca-a777-85585d2eb624@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c199c7f-d89b-48ca-a777-85585d2eb624@suse.de>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

Hello!

On Mon, Aug 31, 2026 at 08:20:10 +0200, Thomas Zimmermann wrote:
> Hi

> Am 29.08.26 um 16:39 schrieb Alan Mackenzie:

> >> This has nothing to do with KDE or Gnome, if you have issues with those
> >> projects, please take it up with them and contribute to them to resolve
> >> those issues.  I know they can always use the help.

> > My point is that the kernel's console is rock solid and dependable.

> That is a bold statement.

I've been using the console for around 28 years, now.  I don't recall it
crashing at all.  My current font and keyboard files are in exactly the
same form as they were 28 years ago.  These formats are stable and
dependable.

> I've spend the last years working on related code (fbcon) and it
> mostly feels dated and unmaintained. Our prime implementation (again
> fbcon) has been de-facto unmaintained for years.  We recently had
> contributors who are pushing the ioctls semantics and found bugs in
> fbcon for a number of corner cases.

Something like:

commit ef7656e85f1a4400999625cd398b655517368e7e
Author: Zizhi Wo <wozizhi@huawei.com>
Date:   Wed Jul 29 10:12:04 2026 +0800

    fbdev: Fix out-of-bounds access when rotating console after font resize

> > Things like kmscon are subject to the vagaries of fashion.

> >>> As is clear, I think the console's limitations should be eliminated.

> >> And the rest of us feel the kernel console's code should be eliminated
> >> entirely, when ever possible :)

> > The rest of you don't appear to be console users.  It's easy to advocate
> > for removal when you don't use it yourself.

> FTR I'm not at all interested in eliminating the kernel's console.

Other people, in particular Greg KH, have said this is the current aim.
I'm worried for myself.  It is far from clear that there is a suitable
replacement for the kernel's console, and its elimination could easily
happen without that replacement.  I suppose I could always (laboriously)
maintain the console for myself personally.  Or there's always the BSDs.
I just don't know what I'd do.

> But there are must-have features and nice-to-have features. IMHO for
> the kernel console i18n really belongs in the later category.

It's 2026, four decades after VGA was the latest thing, and Unicode
support is merely a nice-to-have?

> Best regards
> Thomas

> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)

-- 
Alan Mackenzie (Nuremberg, Germany).
