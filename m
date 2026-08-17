Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4180FC5DF77
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95BB510E32E;
	Mon, 17 Aug 2026 16:57:18 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0888810E32E
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 16:57:17 +0000 (UTC)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 6E3D39200C0; Mon, 17 Aug 2026 18:57:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id 6A8FD9200BB;
 Mon, 17 Aug 2026 17:57:16 +0100 (BST)
Date: Mon, 17 Aug 2026 17:57:16 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Randy Dunlap <rdunlap@infradead.org>
cc: linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/03] fbdev: maxine: elide an unused function
In-Reply-To: <20260813232934.2718291-3-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2608171757050.14132@angie.orcam.me.uk>
References: <20260813232934.2718291-1-rdunlap@infradead.org>
 <20260813232934.2718291-3-rdunlap@infradead.org>
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

On Thu, 13 Aug 2026, Randy Dunlap wrote:

> maxinefb_ims332_read_register() is not used, but since it describes a
> hardware interface, leave it in the source file as documentation
> and surround it inside an #if 0/#endif block.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
