Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3890C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3859010F01C;
	Wed, 12 Aug 2026 14:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CZxvRrRG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB2410F01C
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:12:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 96D6C60DB6;
 Wed, 12 Aug 2026 14:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D44B1F000E9;
 Wed, 12 Aug 2026 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786543978;
 bh=h2cOF3IgNEypu9rcuwe8w2VjzCTCa5SWQVgxjUIzs1A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CZxvRrRGikZmrROcbh2rEu6xKqNYz8Q7zJtgczB1DKJgaSbkWIY42g4DkawoLhW+a
 ZoK/vf7RwBeRAycEhJvwvKV6Rpn9vWvXl56ioXdWOFPv7QrLKVSsBOc4QZaGpG3Mty
 BNQXNUHi5tImJWJxJODTSnulg0F8yonp24HPdiEZ74FcbXrDeWMdHeU5raQUf52z2I
 RKnrZsEuf4m7JRfLOs0zJb4ma8OkK4rrSjPAkxuBkYO/eKMiWd5iCizCGtq9y0+gWC
 9AcTHFQEvV97fTZbjmH0Nj3cKXnIMnjEIwehx165g+3yDoUAkPvEDTclse48Cibi5X
 qAHXHuWQxBJ9Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wu9hQ-00000000EES-0Wq4;
 Wed, 12 Aug 2026 16:12:56 +0200
Date: Wed, 12 Aug 2026 16:12:56 +0200
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/imx/tve: take i2c adapter module reference
Message-ID: <anx_aEJGbFM6Xosx@hovoldconsulting.com>
References: <20260716131937.1564892-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716131937.1564892-1-johan@kernel.org>
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

On Thu, Jul 16, 2026 at 03:19:37PM +0200, Johan Hovold wrote:
> The i2c subsystem currently blocks during adapter deregistration
> whenever there are consumers holding a reference.
> 
> Switch to using of_get_i2c_adapter_by_node() which also takes a
> reference to the adapter module so that an attempt to unload the module
> while in use fails gracefully instead of blocking uninterruptibly.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Can this one be picked up for 7.3-rc1?

Johan
