Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE23606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mvzaWhs8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02EE210E215;
	Tue, 24 Nov 2026 23:02:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4550010E215;
 Tue, 24 Nov 2026 23:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795561356; x=1827097356;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=dtixkPrFwSI5Cayx9vn6Qh1o93tv2rY/0IRNZoDpmo8=;
 b=mvzaWhs8cifxUTxZYp22n5pbrgarpjGlcm/nGlLqbcS5xvkIPQZWGgJc
 mnVslzM4w1m4SVqABDa6nvrl83njfwY1ODMMGjABpkJFmK0FlMKc4NXsC
 iHRdZdDp/hBir2rlu2ALv5ryvG/3kyMuZjdVer1SiVeZxdwx4OsrNh0CI
 M7kHzONcDZx37J5THzNOjEYyO/jw+fc89FiepCucHbConcd1yk1PQvGEe
 bObQUsNTmdVxBai0d9GzOSZt3hqF9+QjSPSU59WZQwfjxcsV/u/eazyCG
 kskjseJgVOLTDsONhBcmrOfiPz93XVqMJftDJtjEMwBLxslLyUo5yVxHh Q==;
X-CSE-ConnectionGUID: IwC8vVJjTSCEjHAThJDuAw==
X-CSE-MsgGUID: yP/IBTBEShCzIkApII3tbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4344834"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4344834"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 15:02:35 -0800
X-CSE-ConnectionGUID: YYt7k7OMR8q6N7lIgX/dYw==
X-CSE-MsgGUID: c4OvfOsxQVCl0ZY/74YS8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11896219"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.204])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 15:02:33 -0800
Date: Wed, 25 Nov 2026 01:02:30 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/edid: Introduce
 drm_edid_get_displayid_product_id()
Message-ID: <awYXhjvZvrw3gWea@intel.com>
References: <20261124224621.6506-1-ville.syrjala@linux.intel.com>
 <20261124224621.6506-2-ville.syrjala@linux.intel.com>
 <sashiko-outbox-232161@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-232161@kernel.org>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 10:51:24PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] drm/edid: commit subject mismatches
>   drm_displayid_get_product_id()
> --
> 
> commit 4452aea3cbb2a5afd7ef8a119931282a44feb4c3
> Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> drm/edid: Introduce drm_edid_get_displayid_product_id()
> 
> This commit adds drm_displayid_get_product_id() to extract vendor and
> product identification from a DisplayID Product ID block.
> 
> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> > index a2617aa34edfc..b44c26d422171 100644
> > --- a/include/drm/drm_edid.h
> > +++ b/include/drm/drm_edid.h
> 
> [ ... ]
> 
> > @@ -484,6 +492,8 @@ int drm_edid_connector_add_modes(struct drm_connector *connector);
> >  bool drm_edid_is_digital(const struct drm_edid *drm_edid);
> >  void drm_edid_get_product_id(const struct drm_edid *drm_edid,
> >  			     struct drm_edid_product_id *id);
> > +void drm_displayid_get_product_id(const struct drm_edid *drm_edid,
> > +				  struct drm_displayid_product_id *id);
> 
> [Severity: Low]
> The commit subject names this function drm_edid_get_displayid_product_id(),
> while the commit message body and code define drm_displayid_get_product_id().
> Also, this declaration is placed in the "Interface based on struct drm_edid"
> section of include/drm/drm_edid.h, where all other functions taking a
> const struct drm_edid * use the drm_edid_ prefix.  Should the commit subject
> and exported function name be aligned?

I was going back and forth with the name and being dissatisfied
with all of them. If anyone has an opinion how we should name
these things I'm all ears.

-- 
Ville Syrjälä
Intel
