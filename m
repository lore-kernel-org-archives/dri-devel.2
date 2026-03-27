Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FFB10BA453
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 09:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C3E10ECDE;
	Fri, 27 Mar 2026 09:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JEvrsZie";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A959910ECDE
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:04:45 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id EAFB71783;
 Fri, 27 Mar 2026 10:03:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774602205;
 bh=2q+MwjaTDQlDt2HK2ksY2sRwNISOSVyw4/LbSErZ+vs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JEvrsZieYrtju8PjmnG2QOY2nPqKDNYPPc5aQBllB7bm6Z5EV6Cv345cROhB9s6yn
 RD4ATxHGt1qCLyA/qETm7cT7ovQjD1Ue4T6YecOe6pqDL6dmQxixo+V6+6j9QehYdc
 4toBc1zheMKmLGIJR/SCiZUZeUfRmZaTOqtQXTnk=
Date: Fri, 27 Mar 2026 11:04:42 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Amin <amin.gattout@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rcar-du: Convert to of_drm_find_and_get_bridge()
Message-ID: <20260327090442.GA3026673@killaraus.ideasonboard.com>
References: <20260326-bridge-v1-1-c0c44b53f7b6@gmail.com>
 <DHDEL0VTRYDP.2D45EP8E07Y08@bootlin.com>
 <20260327083404.GA2993961@killaraus.ideasonboard.com>
 <CAHfa7xXeRaGw1ADFsuT2dcqkY+KXb9w_vi4tq8G6ehOS9r7cAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHfa7xXeRaGw1ADFsuT2dcqkY+KXb9w_vi4tq8G6ehOS9r7cAA@mail.gmail.com>
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

On Fri, Mar 27, 2026 at 09:54:42AM +0100, Amin wrote:
> Hi
> 
> Thanks for the feedback. I did reference commit 7282066e55347 (Luca's
> earlier conversion) but I should have been more cautious since the
> patch I submitted was a bit too simple/"dummy".
> 
> To answer Laurent's question: I did not test this on hardware.
> I was working through the deprecated API TODO  list and made the
> mistake of treating this as a simple find-and-replace.
> 
> I'll send a v2.

Luca has already submitted a patch, see
https://lore.kernel.org/dri-devel/20260318-drm-bridge-alloc-getput-drm_of_find_bridge-4-v3-3-10f502520357@bootlin.com/

-- 
Regards,

Laurent Pinchart
