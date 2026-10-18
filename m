Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F2ACCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 18:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD6210E15A;
	Sun, 18 Oct 2026 18:18:11 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C1110E100
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 18:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=ErZB2ZZ3XmQhb+Taa2wj1GmXp8EN7dNa3whRakTKL+M=; t=1792347483; x=1793557083; 
 b=QEv0AMsQK6axyet8agjBGEPrfNOcOreKJu/1GyMe2fREvzgR1dU4FmQeGlvrjwLopyGzivCyDcn
 YlsaSoeyBVtNpmuU4zQnbKcsQ6z6twNF+ezlQTM0IO6Gz+3jbluDunCpRPBFDFPSaWxXyGAdpZGgG
 HXzjIER6gPVi42kYItM0WWhOvUj1rbt3JLI8X6bljYj11nP5/i1EmBxD7EzKfjkzb9Wb7wBKsbmWQ
 XFrjsRlTSSV8GVXvWJeZhGN7YF+SKckGT+kwKQmIrdqqiWnVFthMhiaAZ+ot1wXuyZYmph52BaWvc
 CXjE9xjNUYyOr5TLpw46TI6L+sRjIsszPE1A==;
Date: Sun, 18 Oct 2026 20:17:47 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, hns@goldelico.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] drm: panel: Add support for Epson Moverio BT
 200 display
Message-ID: <20261018201747.0f1280f3@kemnade.info>
In-Reply-To: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
References: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 22 Sep 2026 08:16:57 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> This series depends on
> https://lore.kernel.org/lkml/20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com/.
> That series is still v7.2 based, but this needs -next material, to work.
> It compiles on -rc.
> 
just of of couriosity: I got no Sashiko mails here. So really nothing to
complain here?

Regards,
Andreas
