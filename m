Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ED6C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DA7892ED;
	Mon, 17 Aug 2026 17:09:49 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9DA28892ED
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:09:48 +0000 (UTC)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id ECE559200B3; Mon, 17 Aug 2026 19:09:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id E9C8192009D;
 Mon, 17 Aug 2026 18:09:47 +0100 (BST)
Date: Mon, 17 Aug 2026 18:09:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Randy Dunlap <rdunlap@infradead.org>
cc: linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev: maxine: use MODULE_LICENSE() unconditionally
In-Reply-To: <20260814184234.3013510-1-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2608171800240.14132@angie.orcam.me.uk>
References: <20260814184234.3013510-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 14 Aug 2026, Randy Dunlap wrote:

> This driver cannot be built as a loadable module so testing for
> "#ifdef MODULE" is not appropriate here.
> Also, MODULE_LICENSE() is always available.

 It might best be reordered to the end of file, cf. pmagb-b-fb.c, though 
I'm not sure if we want to be pedantic enough to do it with a separate 
change.  Anyway:

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

 NB making the driver modular ought to be trivial once this has become a 
platform device; I have converted all the TURBOchannel drivers already.  
I have hesitated poking at this one without a live specimen though.

  Maciej
