Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F5FC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 06:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE0110E156;
	Wed, 15 Jul 2026 06:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="lJ04fou+";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3623210E131
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 06:42:59 +0000 (UTC)
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id 9CE091F8DA;
 Wed, 15 Jul 2026 08:42:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1784097777;
 bh=VhX27eVj94wZ4TbZOZmAuCcKPqJuNV5Qaj379iRya4w=; h=From:To:Subject;
 b=lJ04fou+1i84Pq+5wBTGnkKE/X1Ope/n2XS+7mkCpy4DNnun6qaKWw2taEXi8gc1Z
 lemFntMKwk0+I5RDNDO0Z58ge+VfTWND2NRG0Nppczt35SiKjdHPP94flzvVQNb0Ut
 TrWwY+rraEFGqIyVkmXj85eIOhsm0mUXopISmKCJGwTe5bXKbGcd3mXAs2A39pDW9j
 LD59esS7nJ4R8fFdZYx4v78Zp+Xo8IQRGWQPSZEHu6GLwLR5DvPSCQY22g/L8o0yM8
 A9a5Xd91lAhQvv8buhnDS8dCoWADwHtRaunSV9WIyQC78jGwbzfenZIpNBa/KlenE5
 GeeNsy+1YlS+A==
Date: Wed, 15 Jul 2026 08:42:52 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/bridge: lontium-lt8912b: make read-only const
 array supply_names static
Message-ID: <20260715064252.GA40623@francesco-nb>
References: <20260714190400.194605-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190400.194605-1-colin.i.king@gmail.com>
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

On Tue, Jul 14, 2026 at 08:03:59PM +0100, Colin Ian King wrote:
> Don't populate the read-only const array supply_names on the stack
> at run time, instead make it static
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
