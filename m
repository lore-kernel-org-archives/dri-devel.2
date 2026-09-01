Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7631C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1033D10F41F;
	Thu,  3 Sep 2026 07:34:05 +0000 (UTC)
Received: from mail.muc.de (mail.muc.de [193.149.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664DB10E3DF
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:14:47 +0000 (UTC)
Received: (qmail 81104 invoked by uid 3782); 1 Sep 2026 13:14:45 +0200
Received: from muc.de (p4fe15c70.dip0.t-ipconnect.de [79.225.92.112]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Tue, 01 Sep 2026 13:14:44 +0200
Received: (qmail 6890 invoked by uid 1000); 1 Sep 2026 11:14:43 -0000
Date: Tue, 1 Sep 2026 11:14:43 +0000
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: vt: Enlarge the framebuffer glyph size from 16 to 32 bits
Message-ID: <apazo2RIHiEAtpNN@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
 <apGc4y8ApYWh4Yr4@MAC.fritz.box>
 <2026082938-spray-shimmer-9389@gregkh>
 <apLvO-8YJmQG7T0Z@MAC.fritz.box>
 <7c199c7f-d89b-48ca-a777-85585d2eb624@suse.de>
 <apWTg6mNZrdBm2-D@MAC.fritz.box>
 <ae1ae01a-677e-4c51-bf9a-ebe7b2e91e4f@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1ae01a-677e-4c51-bf9a-ebe7b2e91e4f@gmx.de>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

On Mon, Aug 31, 2026 at 19:21:30 +0200, Helge Deller wrote:
> On 8/31/26 16:45, Alan Mackenzie wrote:
> > On Mon, Aug 31, 2026 at 08:20:10 +0200, Thomas Zimmermann wrote:
> >> Am 29.08.26 um 16:39 schrieb Alan Mackenzie:

[ .... ]

> > I've been using the console for around 28 years, now.  I don't recall it
> > crashing at all.  My current font and keyboard files are in exactly the
> > same form as they were 28 years ago.  These formats are stable and
> > dependable.

> >> I've spend the last years working on related code (fbcon) and it
> >> mostly feels dated and unmaintained. Our prime implementation (again
> >> fbcon) has been de-facto unmaintained for years.  We recently had
> >> contributors who are pushing the ioctls semantics and found bugs in
> >> fbcon for a number of corner cases.

[ .... ]

> >> FTR I'm not at all interested in eliminating the kernel's console.

> > Other people, in particular Greg KH, have said this is the current aim.
> > I'm worried for myself.  It is far from clear that there is a suitable
> > replacement for the kernel's console, and its elimination could easily
> > happen without that replacement.  I suppose I could always (laboriously)
> > maintain the console for myself personally.  Or there's always the BSDs.
> > I just don't know what I'd do.

> Alan, I really appreciate your efforts to enhance the kernel console code!
> And I'm not interested to eliminate the kernel console either.

> >> But there are must-have features and nice-to-have features. IMHO for
> >> the kernel console i18n really belongs in the later category.

> > It's 2026, four decades after VGA was the latest thing, and Unicode
> > support is merely a nice-to-have?

> No. IMHO Unicode support would be great.

Thank you, indeed!  That's cheering to hear.

> Thanks!
> Helge

-- 
Alan Mackenzie (Nuremberg, Germany).
