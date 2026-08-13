Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2E9C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FCF310F4C3;
	Thu, 13 Aug 2026 18:16:33 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4F0CE10E51B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:16:31 +0000 (UTC)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 965C792009C; Thu, 13 Aug 2026 20:16:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id 8FD1992009B;
 Thu, 13 Aug 2026 19:16:30 +0100 (BST)
Date: Thu, 13 Aug 2026 19:16:30 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Helge Deller <deller@gmx.de>
cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-mips@vger.kernel.org
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
In-Reply-To: <81ac11ee-772e-4024-b9e9-6a925344052c@gmx.de>
Message-ID: <alpine.DEB.2.21.2608131914280.48788@angie.orcam.me.uk>
References: <20260809234810.982500-1-rdunlap@infradead.org>
 <81ac11ee-772e-4024-b9e9-6a925344052c@gmx.de>
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

On Thu, 13 Aug 2026, Helge Deller wrote:

> > This is all ancient source code from the beginning of git time.
> > Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.
> > 
> I've added the various comments from the mail thread to the
> patch and applied the patch as-is for now.

 Given the statement of the problem as per the quotation above I don't 
think there was a need to fast-track it without giving me a chance to 
chime in.

  Maciej
