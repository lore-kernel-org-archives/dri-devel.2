Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34804606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=pNopCd7a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D80112057;
	Thu, 12 Nov 2026 11:35:36 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D83111205F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 11:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=EPcJkEv6Mv9K5uRm29JHqDQ1ukD6n2G1FK8ZkT2iuVE=; t=1794483330; x=1795692930; 
 b=pNopCd7aEcQePAHtBVy0ItsecQEi4/+l0qKMO16LM/ATY8L20sbfcGwsxQ6u1wt1cTKU0KTn0CR
 evnlTUSmVdUkRvri6Z6nnL+BvtEtO/sSDFOEpavNc2wVdWNIjBKcsen0j6CXFlRAcpmR5+h+mb5bh
 jvED9eTL0CiXlaKBuD/cJKWc3G/Bmej6DicDEw2j3TAcbxTBdJhYPk0sxtGpenQ4zXV58oXFam5lJ
 IY/iklt5HlUUY5mTteoYrI5fXbdiqwH3f/QdmASs1C+mUB3teFTMuknJh4e9/0iI7HVe88wiVxUF3
 cyZBDA6MsfEHL84/HbsF5Td3bff6EFUq4BsA==;
Date: Thu, 12 Nov 2026 12:35:22 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
 hns@goldelico.com, linux-kernel@vger.kernel.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2] drm/omap: dss: fix handling deferrals
Message-ID: <20261112123522.09ef73fd@kemnade.info>
In-Reply-To: <e93d1911-a6d9-4256-a2cb-cd2d6112a4c0@ideasonboard.com>
References: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
 <e93d1911-a6d9-4256-a2cb-cd2d6112a4c0@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 12:25:20 +0200
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Hi,
> 
> On 11/11/2026 23:14, Andreas Kemnade wrote:
> > Forward the error given by of_drm_get_bridge_by_endpoint() if it is
> > EPROBE_DEFER to ensure output gets initialized later when available.
> > 
> > On GTA04/OMAP3 no display was found, but it appeared after doing
> > rmmod omapdrm ; modprobe omapdrm
> > 
> > Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v2:
> > - do not use the error goto
> > - Link to v1: https://patch.msgid.link/20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info
> > ---
> >   drivers/gpu/drm/omapdrm/dss/output.c | 3 +++
> >   1 file changed, 3 insertions(+)  
> 
> Thanks, I'll push to drm-misc-next.
> 
Isn't it drm-misc-fixes? This issue is new in v7.4-rc1.

Regards,
Andreas

>   Tomi
> 
> > diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
> > index 36d37deac8026..b5cef5093a883 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/output.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> > @@ -24,6 +24,9 @@ int omapdss_device_init_output(struct omap_dss_device *out,
> >   
> >   	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
> >   	if (IS_ERR(bridge)) {
> > +		if (PTR_ERR(bridge) == -EPROBE_DEFER)
> > +			return PTR_ERR(bridge);
> > +
> >   		dev_dbg(out->dev, "failed to find video sink\n");
> >   		return 0;
> >   	}
> > 
> > ---
> > base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> > change-id: 20261111-gta04-drm-regression-fix-f7ef51c66ed3
> > 
> > Best regards,
> > --
> > Andreas Kemnade <andreas@kemnade.info>
> >   
> 
> 
> 

