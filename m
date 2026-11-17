Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB5606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xw5YZvP7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD68810F664;
	Tue, 17 Nov 2026 11:49:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E24110F664
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:49:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DADA61DAA;
 Tue, 17 Nov 2026 11:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E451F000C5;
 Tue, 17 Nov 2026 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794916191;
 bh=ikeUCHsj8fT7pGEWlQ3BvLYrTD78tfSy9o0vHDch4ZA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Xw5YZvP7xe2GhTdte/6s2qJRiL1n6cy3SL6+tWopJkl4lwjJ7OLqxwpBbqiLHapwV
 StOoqOkbmcGZk5di9KksHpKNYJoKIfwi1pMzRszNc5virTiPquT6U54ZzSoRXTl6dX
 16zZQ7t2ECNbGgqz1/p5tg0rVps9qG1Ln4MZmxXZ+IL3+sIj9WQVGpRzg1+EjxGyQK
 cI+5Ba7C9bdUVppDQMb8GMrOmtdGIBWwJlGqkQ8sbuQvXqcCzAgMxJv5uwP3SlzrEa
 H0fjzPcpLshLjrZczRRfkFAg0U84SjMl3yUB7CvHC7RDf+eJu8quMtrsWEbWfcSFBP
 JHreaoBCc7DvQ==
Received: from johan by xi.lan with local (Exim 4.100.1)
 (envelope-from <johan@kernel.org>) id 1xTHh6-000000049fg-25j2;
 Tue, 17 Nov 2026 12:49:48 +0100
Date: Tue, 17 Nov 2026 12:49:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] drm/panel-simple: take i2c adapter module reference
Message-ID: <avw_XKo3EzosfyIh@hovoldconsulting.com>
References: <20260716132334.1565183-1-johan@kernel.org>
 <anx_MPm2Y0RVwZ9h@hovoldconsulting.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anx_MPm2Y0RVwZ9h@hovoldconsulting.com>
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

On Wed, Aug 12, 2026 at 04:12:00PM +0200, Johan Hovold wrote:
> On Thu, Jul 16, 2026 at 03:23:34PM +0200, Johan Hovold wrote:
> > The i2c subsystem currently blocks during adapter deregistration
> > whenever there are consumers holding a reference.
> > 
> > Switch to using of_get_i2c_adapter_by_node() which also takes a
> > reference to the adapter module so that an attempt to unload the module
> > while in use fails gracefully instead of blocking uninterruptibly.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Can this one be picked up for 7.3-rc1?

This one is still not in linux-next. Can I get one more ack or whatever
is needed for this to move forward?

Also adding Doug who merged a corresponding patch for panel-edp back in
July. [1]

Johan


[1] https://lore.kernel.org/all/20260717143119.1815106-1-johan@kernel.org/
