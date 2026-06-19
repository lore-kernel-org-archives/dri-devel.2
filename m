Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B8DCD98E6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 06:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E8C10E047;
	Fri, 19 Jun 2026 06:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="SPLtAE52";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3354A10E047
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 06:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=qXTF3E+HgaYjd3XnQ351L22o4q4lpEMDwJP01SjL4fk=; t=1781850251; x=1783059851; 
 b=SPLtAE5205+lOxgTZNRcBuOZ8H4sgZz/qNzcksPmSK5btwMdnDmya7weJceTkueAQkO0QeiNiyo
 O4zkxuMMk5/fP+dZ5rD3AJhwut3B2ChFEiR0wtHtZxYgZ2eaz+wVdwuhLH8q49+NEJu26RFnJD4R1
 yWsbXhWuLZNWEKZXCxPnntiTuyDcTui3+JSQb2SPaQPh1ZbJB7cGQ7wSGEDFZOPeAApXfQuOArXVT
 MID/emFr0ETCeg4uBVNt9qblE4VIr8EdujBxUeXoZ7ZxGABUQYxklvb+oQXiOOyXg6lWFbd9SH0CW
 GB9QlpsQ0m3+zTsbPBfitw/iQstVLq18Mi4Q==;
Date: Fri, 19 Jun 2026 08:23:50 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dave
 Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v3 05/13] drm/bridge: tc358762: Drop SPICMR write
Message-ID: <20260619082350.2ebc0cf7@kemnade.info>
In-Reply-To: <20260513-tc358762-fixes-v3-5-6698b55008b9@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
 <20260513-tc358762-fixes-v3-5-6698b55008b9@ideasonboard.com>
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

On Wed, 13 May 2026 16:10:14 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Drop write to SPICMR. It's unclear why the write is there, as SPI is not
> supported in the driver, and it's mostly just writing zeroes to already
> zero fields (reset defaults). None of the zero bits written disable
> anything wrt. SPI.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Comparing it with something out of tree where SPI is apparently working.
It does not touch SPIMR,

so this can clearly be dropped.
So:

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
