Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8922C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F1F910E679;
	Mon, 31 Aug 2026 07:00:04 +0000 (UTC)
Received: from mail.muc.de (mail.muc.de [193.149.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509E910E0A9
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 13:34:03 +0000 (UTC)
Received: (qmail 94718 invoked by uid 3782); 29 Aug 2026 15:34:00 +0200
Received: from muc.de (p4fe15d93.dip0.t-ipconnect.de [79.225.93.147]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Sat, 29 Aug 2026 15:34:00 +0200
Received: (qmail 56993 invoked by uid 1000); 29 Aug 2026 13:33:59 -0000
Date: Sat, 29 Aug 2026 13:33:59 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Patch 3/9]: Replace scr_readw/writew by scr_readg/writeg, etc
Message-ID: <apLfx9oqYaa36oyn@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box> <apCGKUotSUZLvngV@MAC.fritz.box>
 <2026082934-irrigate-tastiness-c4ff@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026082934-irrigate-tastiness-c4ff@gregkh>
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

On Sat, Aug 29, 2026 at 14:11:00 +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 27, 2026 at 06:47:05PM +0000, Alan Mackenzie wrote:

> > vt: 32b glyph: 3. replace scr_readw/writew by scr_readg/writeg, etc.

> I don't understand these lines in your patches, where are they from and
> what are they for?

scr_readg and scr_writeg read and write an entire glyph, regardless of
whether that glyph is 16-bit or 32-bit.  The latter is determined by the
setting of CONFIG_FB_GLYPH_21BIT.

This is the main complication in these patches; having to cope with both
sizes of glyph, for backward compatibility, rather than just switching
to 32-bit glyphs.

> thanks,

> greg k-h

-- 
Alan Mackenzie (Nuremberg, Germany).
