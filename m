Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6556606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=cniGzmE+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF4A11204E;
	Thu, 12 Nov 2026 11:52:00 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B66A11204E
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 11:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=6R6toNBIUivUY49SbPVzsOWR13YYc6Q05DyfYkrwtKU=; t=1794484313; x=1795693913; 
 b=cniGzmE+25N9X2sA/uYDlYLwz/EWH+6FGO6plR0+hN2mjiUg+0mMokWdjYlyKJUQ8xKkKju0Oqc
 BKSYyP95uJGJvmeARf6uzNxTE4PVQJz7hbo5SPeBp8NKlDvMf7pgbSe1q/uasZJ6NTL6WiAO/+5FU
 fhUL7Y/bG/tzPXPqQj610IIbgXumbblTRPdKKQ2GTqMjDzmqLtMG+LVJJ35biunxKwzy1J6S9A4QN
 ptpiIFGX2tw7rJakG1CBdcIhMADvuvFR6FUu3Lv5nySgCekcokBcXVrNtEX50VT1fqr/yBg0yDjue
 cXoEhtPhknkYzZ47pYKsm5JTexN4Ry/WNONA==;
Date: Thu, 12 Nov 2026 12:51:48 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
 <hns@goldelico.com>, <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Subject: Re: [PATCH] drm/omap: dss: fix handling deferrals
Message-ID: <20261112125148.23235dec@kemnade.info>
In-Reply-To: <DMSHYXQ01R6O.3F13LZ51TUPCP@bootlin.com>
References: <20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info>
 <33f63eaf-42a0-4b3f-a21c-3752436d07b4@ideasonboard.com>
 <DMSHYXQ01R6O.3F13LZ51TUPCP@bootlin.com>
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

On Wed, 11 Nov 2026 16:46:51 +0100
"Luca Ceresoli" <luca.ceresoli@bootlin.com> wrote:

> Hello Andreas,
> 
> On Wed Nov 11, 2026 at 3:56 PM CET, Tomi Valkeinen wrote:
> > Hi,
> >
> > On 11/11/2026 14:22, Andreas Kemnade wrote:  
> >> Forward the error given by of_drm_get_bridge_by_endpoint() if it is
> >> EPROBE_DEFER to ensure output gets initialized later when available.
> >>
> >> On GTA04/OMAP3 no display was found, but it appeared after doing
> >> rmmod omapdrm ; modprobe omapdrm
> >>
> >> Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")  
> 
> Ouch, sorry about breaking this driver. To my excuse the old code removed
> by b7e9b93fc8ecf was (ans still is) pretty obscure.
> 
> >> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >> ---
> >>   drivers/gpu/drm/omapdrm/dss/output.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
> >> index 36d37deac8026..220ed7e003080 100644
> >> --- a/drivers/gpu/drm/omapdrm/dss/output.c
> >> +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> >> @@ -24,6 +24,11 @@ int omapdss_device_init_output(struct omap_dss_device *out,
> >>
> >>   	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
> >>   	if (IS_ERR(bridge)) {
> >> +		if (PTR_ERR(bridge) == -EPROBE_DEFER) {
> >> +			ret = PTR_ERR(bridge);
> >> +			goto error;
> >> +		}
> >> +  
> > Shouldn't we just return PTR_ERR(bridge) here? The error label will call
> > omapdss_device_cleanup_output(), which cleans up things set up later in
> > this function.  
> 
> Indeed.
> 
> 
> Additionally, by looking at the omapdss_device_init_output() code right
> now, the goto-based error management appears:
> 
>  1. unnecessarily complicated: only one goto for only one line of rollback
>     code
> 
>  2. potentially wrong, or at least doing too much, because
>     omapdss_device_cleanup_output() does two things:
> 
>       a. drm_bridge_put(out->next_bridge): but when goto is invoked the
>          out->next_bridge pointer has not been touched yet
>          (I assume we should not touch the refcount in this case)
> 
>       b. drm_bridge_put(out->bridge): unneeded because the goto is inside
>          an 'if (!out->bridge)', thus there is no reference at all to put
> 
> Do you agree with these findings?
> 
of_drm_get_bridge_by_endpoint never returns NULL (indicated by Sashiko).
So we have dead code there anyways. So the patch is dead code elimination
and not fixing bugs.

Regards,
Andreas
