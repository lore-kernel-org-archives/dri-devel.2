Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66D6CD98D2
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 08:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0B110ED1D;
	Sat, 13 Jun 2026 08:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.b="t1JQej0W";
	dkim-atps=neutral
X-Greylist: delayed 1977 seconds by postgrey-1.36 at gabe;
 Sat, 13 Jun 2026 08:27:20 UTC
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B578F10ED1D
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 08:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=jKr6D0QomrXndRUM0kTG+EY+S4tjgLHhIqD9NsgnK+8=; b=t1JQej0WP+uA8ctP2eqhWVi1Is
 LeuVqI1nI9iXHR4N/INYtri+j+tIdmlqT4EkBrOU3Ce1Em93h+QmJJbRKjwrY5demAueHPaxODGZR
 cYJ8Kz2w+JQ05eZcbqQGQhCSMyq2adyC36CpTQ+s4EzOGjaG492rjErQubowflSnI2xE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1wYJC4-007RtV-20; Sat, 13 Jun 2026 09:54:16 +0200
Date: Sat, 13 Jun 2026 09:54:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gabriel Ramos Barbosa Mota <maguraa53@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, deller@gmx.de,
 fero@drama.obuda.kando.hu, netdev@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net and video: remove legacy 16-bit and non-x86
 hardware drivers
Message-ID: <d66c7e93-b39a-4e79-b047-528e094b51d6@lunn.ch>
References: <20260613033138.601841-1-maguraa53@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613033138.601841-1-maguraa53@gmail.com>
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

You need to commit message to justify why these should be removed.

Also, please remove each driver one by one, so that if there are
users, it is easier to revert.

Please also look at the discussion about these MAC drivers over the
last couple of months. We discussed removing some of them, but they
still have users, and one of them gained a new Maintainer.

    Andrew

---
pw-bot: cr
