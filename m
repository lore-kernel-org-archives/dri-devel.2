Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40C1CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2899710E272;
	Wed, 20 May 2026 10:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UVlUXvyY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFAF10E0F3;
 Wed, 20 May 2026 10:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779273586; x=1810809586;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eUHiWHdMbcMjdbFC/ml9hfj6eOgpoWIDrHGgBD9VobU=;
 b=UVlUXvyYg61l27jTspUEKKcCf/H4r/gTq+i9ToKUcspcJLJJPH3fbK93
 fUiTKx/lo5pupLYciq405C442qOttLHpw0im5zgohHKsL1TFd8jyh9YAh
 lpsNQf4L1yKx10YdZSYZAWTT4NdjlG7m8AGmcJO0XtuQM67q4uIqfu1a5
 6rjfLfvwLdOF/y1gW7smsJwS4zn9hRyOw6SqkgGxySOVcle3bpSY6hIB6
 JokiBd7YyeC8HTapUXATWDrFb3yhvFgBwTcOZeDVQ3GAeUKgoIbQ5GZuK
 F7ti2EFpayfwobyxQ6SFktozJ+YBeeLPsSTRFFetggQky0Snb2I5LLvsA A==;
X-CSE-ConnectionGUID: cGJz2aT2SRi0noPth8Gtew==
X-CSE-MsgGUID: qLiOFda9RJOC0To4Hq8w9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="102845327"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="102845327"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:39:46 -0700
X-CSE-ConnectionGUID: Y5XtTuW4QHiM0nD4GafOtw==
X-CSE-MsgGUID: upJKWnHLQKWxxmesNQlb8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="244422210"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:39:44 -0700
Date: Wed, 20 May 2026 12:39:40 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, rodrigo.vivi@intel.com,
 maarten@lankhorst.se, airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org
Subject: Re: [PATCH v1 3/3] drm/xe/drm_ras: Add per node cleanup action
Message-ID: <ag2PbIWctfd6yRTw@black.igk.intel.com>
References: <20260514202839.1888688-1-raag.jadav@intel.com>
 <20260514202839.1888688-4-raag.jadav@intel.com>
 <5d52d3dd-2154-48e2-b849-0ca2aa74fb13@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d52d3dd-2154-48e2-b849-0ca2aa74fb13@intel.com>
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

On Wed, May 20, 2026 at 12:53:52PM +0530, Tauro, Riana wrote:
> On 5/15/2026 1:58 AM, Raag Jadav wrote:
> > cleanup_node_param() is not registered in case of counter allocation
> > failure, which results in stale memory of previous node that isn't
> > cleaned up on unwind.
> 
> It is registered.
> 
> ret = assign_node_params(xe, node, i);
> if (ret)
>     cleanup_node_param(ras, i);

Is that also true for previous node params (in case second node
registration fails)?

> >   Add per node cleanup action which guarantees
> > cleanup on unwind and also simplifies the cleanup logic.
> > 
> > Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_drm_ras.c | 42 +++++++++++++--------------------
> >   1 file changed, 17 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> > index 89640ffb1c33..40abde29a26f 100644
> > --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> > +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> > @@ -131,14 +131,20 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
> >   	return 0;
> >   }
> > -static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_error_severity severity)
> > +static void cleanup_node_param(struct drm_ras_node *node)
> >   {
> > -	struct drm_ras_node *node = &ras->node[severity];
> > -
> >   	kfree(node->device_name);
> >   	node->device_name = NULL;
> >   }
> > +static void cleanup_node(struct drm_device *drm, void *arg)
> > +{
> > +	struct drm_ras_node *node = arg;
> > +
> > +	drm_ras_node_unregister(node);
> > +	cleanup_node_param(node);
> > +}
> > +
> >   static int register_nodes(struct xe_device *xe)
> >   {
> >   	struct xe_drm_ras *ras = &xe->ras;
> > @@ -150,13 +156,19 @@ static int register_nodes(struct xe_device *xe)
> >   		ret = assign_node_params(xe, node, i);
> >   		if (ret) {
> > -			cleanup_node_param(ras, i);
> > +			cleanup_node_param(node);
> 
> At this point drm_ras node is not registered.

Yes, and I don't believe we're attempting to unregister here :)

> >   			return ret;
> >   		}
> >   		ret = drm_ras_node_register(node);
> >   		if (ret) {
> > -			cleanup_node_param(ras, i);
> > +			cleanup_node_param(node);
> 
> Ditto

Ditto.

Raag

> > +			return ret;
> > +		}
> > +
> > +		ret = drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
> > +		if (ret) {
> > +			cleanup_node(&xe->drm, node);
> >   			return ret;
> >   		}
> >   	}
> > @@ -164,20 +176,6 @@ static int register_nodes(struct xe_device *xe)
> >   	return 0;
> >   }
> > -static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
> > -{
> > -	struct xe_device *xe = arg;
> > -	struct xe_drm_ras *ras = &xe->ras;
> > -	int i;
> > -
> > -	for_each_error_severity(i) {
> > -		struct drm_ras_node *node = &ras->node[i];
> > -
> > -		drm_ras_node_unregister(node);
> > -		cleanup_node_param(ras, i);
> > -	}
> > -}
> > -
> >   /**
> >    * xe_drm_ras_init() - Initialize DRM RAS
> >    * @xe: xe device instance
> > @@ -204,11 +202,5 @@ int xe_drm_ras_init(struct xe_device *xe)
> >   		return err;
> >   	}
> > -	err = drmm_add_action_or_reset(&xe->drm, xe_drm_ras_unregister_nodes, xe);
> > -	if (err) {
> > -		drm_err(&xe->drm, "Failed to add action for Xe DRM RAS (%pe)\n", ERR_PTR(err));
> > -		return err;
> > -	}
> > -
> >   	return 0;
> >   }
