Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2E1CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179C610ED4B;
	Wed, 20 May 2026 10:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XDzhwGWd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57AB10ED4B;
 Wed, 20 May 2026 10:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779273421; x=1810809421;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=YHhT1zawAxLpF/+gpXRLZWVPjG4ZkiS659MyfYt66CE=;
 b=XDzhwGWdt2kE61lX1qf/dMmYfUOklAAee4u6uM6imork05xIW1Ee6qNm
 fl5GdJdl9OWrgkLOtE8QI16PmU0cpNa1mDX1HyKQ8dNjPJqH2nD8g8joj
 5sPy5FC0PTRvHRg8FNAM5weRrLNQk4DeBTyHSX6RWeSBefpNQj8386VVN
 b59x4VdIKgx1CTFeadzXAvhagFRxi62H+5VIT/uDke5aFKK/bTOICr/G7
 +kvS9NPf7YL2ofOkNNqODBpGuacCTAwO02iElLXME3KzVOZYmI6b+KfMz
 BQpZN4cf7L9bw4bA55cynmkz0k+ByAR8Pozf24Z6ngyLt5ejn8Q8E02wS g==;
X-CSE-ConnectionGUID: jnU3jmzySMGiEQnDTp0sjw==
X-CSE-MsgGUID: HZjBCRGvRByOtxidfd3H+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="67696238"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="67696238"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:36:59 -0700
X-CSE-ConnectionGUID: E5YR7U2QSYipsVTRRPEB3g==
X-CSE-MsgGUID: ExrKOdGTR1SPe9bFtgZCiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="237137989"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:36:57 -0700
Date: Wed, 20 May 2026 12:36:54 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, rodrigo.vivi@intel.com,
 maarten@lankhorst.se, airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org
Subject: Re: [PATCH v1 2/3] drm/xe/drm_ras: Make counter allocation drm managed
Message-ID: <ag2OxgNBjSde2a7J@black.igk.intel.com>
References: <20260514202839.1888688-1-raag.jadav@intel.com>
 <20260514202839.1888688-3-raag.jadav@intel.com>
 <ef067007-b928-4130-8e25-1c4f5afb5833@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef067007-b928-4130-8e25-1c4f5afb5833@intel.com>
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

On Wed, May 20, 2026 at 03:21:49PM +0530, Tauro, Riana wrote:
> On 5/15/2026 1:58 AM, Raag Jadav wrote:
> > cleanup_node_param() is not registered in case of counter allocation
> > failure, which results in stale memory of previous node that isn't
> > cleaned up on unwind. Fix this using drm managed allocation, which is
> > guaranteed to be cleaned up on unwind.
> > 
> > Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_drm_ras.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> > index c21c8b428de6..89640ffb1c33 100644
> > --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> > +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> > @@ -80,7 +80,7 @@ static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *x
> >   	struct xe_drm_ras_counter *counter;
> >   	int i;
> > -	counter = kcalloc(DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
> > +	counter = drmm_kcalloc(&xe->drm, DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
> >   	if (!counter)
> >   		return ERR_PTR(-ENOMEM);
> 
> The intention was to clean up nodes  if there is a failure, to prevent
> memory
> from  persisting throughout the drm device lifecycle. We actually discussed
> this offline  afair.
> 
> So there was a change from from v5 to v6 in the initial patch [v6,2/5]
> drm/xe/xe_drm_ras: Add support for XE DRM RAS - Patchwork
> <https://patchwork.freedesktop.org/patch/704873/?series=155188&rev=6>

Yes, the idea was to prevent the driver from updating stale counter
(which isn't exposed to the user). But rethinking about it now, this
can be achieved by simply keeping info as NULL I guess?

Raag

> > @@ -135,9 +135,6 @@ static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_err
> >   {
> >   	struct drm_ras_node *node = &ras->node[severity];
> > -	kfree(ras->info[severity]);
> > -	ras->info[severity] = NULL;
> > -
> >   	kfree(node->device_name);
> >   	node->device_name = NULL;
> >   }
