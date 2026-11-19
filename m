Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21981606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkBwclon
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237D510FDCA;
	Thu, 19 Nov 2026 07:53:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85CA10FDBD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:51:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 67121430DF;
 Thu, 19 Nov 2026 07:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495471F000C5;
 Thu, 19 Nov 2026 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795074708;
 bh=uWbT9SL84xs5jBjXDDyUhjNSR3AIBmd7V8WgJgh/Hd0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IkBwclonItyJFZAOm7Za5D5OICIeFoxsHHrC9JhMLZuPA3JWyF9X2iZGlFCed96rn
 ED7M87IG1txhxnfoMK6Zx8Rkeri/d63KrpRqyPDY4iwScRRFxWGI9TuNkA+jto1Wcz
 3YaVOWwacOvjVzsnzd2Nf2ZUu5JItgr15Azkce/r7qQa6fPb1O63f1JyjQhQg1RH31
 PZkz8yw8ZOhB5V9B9cOAzhDySWkg4qa6zO2lLX+7onOIZhKFBGczB76EcuXDdY6qVV
 pIhMDUroHLnGaoHwnW9ZBlTL5BaGoNSCkdkQleL7LzA+kV8octV315QnQaXcLbUUAW
 Sz/mNJfVnDIIw==
Received: from johan by xi.lan with local (Exim 4.100.1)
 (envelope-from <johan@kernel.org>) id 1xTwvp-000000056Th-2wpQ;
 Thu, 19 Nov 2026 08:51:45 +0100
Date: Thu, 19 Nov 2026 08:51:45 +0100
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/imx/tve: take i2c adapter module reference
Message-ID: <av6qkTiuZoPTteMs@hovoldconsulting.com>
References: <20260716131937.1564892-1-johan@kernel.org>
 <anx_aEJGbFM6Xosx@hovoldconsulting.com>
 <ar5Z1TjIceCl-EdS@hovoldconsulting.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar5Z1TjIceCl-EdS@hovoldconsulting.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 01, 2026 at 03:02:13PM +0200, Johan Hovold wrote:
> On Wed, Aug 12, 2026 at 04:12:56PM +0200, Johan Hovold wrote:
> > On Thu, Jul 16, 2026 at 03:19:37PM +0200, Johan Hovold wrote:
> > > The i2c subsystem currently blocks during adapter deregistration
> > > whenever there are consumers holding a reference.
> > > 
> > > Switch to using of_get_i2c_adapter_by_node() which also takes a
> > > reference to the adapter module so that an attempt to unload the module
> > > while in use fails gracefully instead of blocking uninterruptibly.
> > > 
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > 
> > Can this one be picked up for 7.3-rc1?
> 
> Again, can someone please pick this one up?

It's been four months, can someone please pick this one up?

Johan
