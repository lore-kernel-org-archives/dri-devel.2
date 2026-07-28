Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13133C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66AF510EAC9;
	Wed, 29 Jul 2026 07:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="PPvRyX8S";
	dkim-atps=neutral
X-Greylist: delayed 2405 seconds by postgrey-1.36 at gabe;
 Wed, 29 Jul 2026 07:23:53 UTC
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD82610EAC9
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 07:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=In-Reply-To:References:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=u7mFonr551F9VYPr/lHHsnNE6ZPOkdA8vxn4kpv/EKI=; t=1785309833; x=1786519433; 
 b=PPvRyX8SfBLLN5WVXCD2QlJPZDG8LcRJ9zmad1axYCTOUCuP43IDLmyaUhgkwIuPhO6SsL3edNQ
 JT1ZmEqcsBqBFJsuFAvCm5k4p+pnNDwZbd94rtEMCJrWmDPwF3iDCxocRLUWztROxYUKlZTat60Be
 At+pZ4AuiU3uhdsr3H8u2TGDh2F24pfcOJctoPw0DOGvDwAoJM7uIu3vwmCpELJgalfc3VQHO4vb+
 gb8grK+0zUtFokDpljgXI0o6fm7TuEChFtVDCYuc7Abbk2Fq6zUAM3L9uGoVvGIxNVlYPHu5hIg2c
 78NwKCdJIPNYGFG8yc6tTV7KIdFl4BnHyWQA==;
Date: Tue, 28 Jul 2026 20:36:09 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/connector: check if destroy function exist
Message-ID: <amj2mUdABXd3XW9G@akepd>
References: <20260702191453.611070-1-andreas@kemnade.info>
 <44557a30-dc86-409a-b430-2b4db151843b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44557a30-dc86-409a-b430-2b4db151843b@suse.de>
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

On Fri, Jul 03, 2026 at 09:09:46AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 02.07.26 um 21:14 schrieb Andreas Kemnade:
> > Connectors might have not resources needed to be manually freed.
> > E.g. the drm_bridge_connector does not have such a callback.
> > 
> > Fixes: c12907be57b1 ("drm/bridge-connector: switch to using drmm allocations")
> 
> This patch uses drmm_connector_init() for the cleanup, which is a mis-design
> IMHO.  Rather than calling drm_connector_cleanup(), it should call
> connector->funcs->destroy, which then points to drm_connector_cleanup. This
> would make the whole thing more useful and not require fixups (like this
> one) elsewhere in the code. Just just my 2cts.
> 
That just sounds like a revert to me. But maybe I misunterstand your comment
> Best regards
> Thomas
> 
> 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   drivers/gpu/drm/drm_connector.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index 47dc53c4a738..d2dfc6e8f7d0 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -198,7 +198,9 @@ static void drm_connector_free(struct kref *kref)
> >   	struct drm_device *dev = connector->dev;
> >   	drm_mode_object_unregister(dev, &connector->base);
> > -	connector->funcs->destroy(connector);
> > +
> > +	if (connector->funcs->destroy)
> > +		connector->funcs->destroy(connector);
> >   }
> >   void drm_connector_free_work_fn(struct work_struct *work)
> > @@ -216,7 +218,9 @@ void drm_connector_free_work_fn(struct work_struct *work)
> >   	llist_for_each_entry_safe(connector, n, freed, free_node) {
> >   		drm_mode_object_unregister(dev, &connector->base);
> > -		connector->funcs->destroy(connector);
> > +
> > +		if (connector->funcs->destroy)
> > +			connector->funcs->destroy(connector);
> >   	}
> >   }
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> 
> 
> 
