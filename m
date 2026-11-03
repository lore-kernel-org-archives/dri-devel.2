Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A35606A33D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dGQSL/xr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102DF10E189;
	Tue,  3 Nov 2026 17:11:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12E410E189
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 17:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793725901; x=1825261901;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=CjpixaBix/pua7fjqohEmpq86pzXz468uk/AW/PT3JI=;
 b=dGQSL/xryTvcivp5gtAuJRYLcS+uUWlw+mneowMvhhuvbtmbSXUtX7Bm
 ud6y+DZ/mquBqOjSzCU96FU7BA4I5xCFmDyyerD/2CSsM3fB8LhFJML+H
 Acuw8c77qUAG2QTb1VfpGsoPjzxBGFubXHp6uMO+qQtCTzpWxSX6qf5b+
 6m87y8yiwacae3YBng1noleTnKtL7Rh/CRLClNCDn3mbYd2UvNqmxSnYP
 3aY8HKWRQdlhTY7h07uKL9Hg61+BWrpkhnGgpNMHqV6fwQaNKZlnD2+l0
 NML7hkDzwg+qABh35W5Lz88ch+FegZKP2LH5qCFneSHI13BMzJ+aoMUro Q==;
X-CSE-ConnectionGUID: jJncAkV5Qw+j9zvAvWsYDw==
X-CSE-MsgGUID: VfoaCmdLR9SJI4A8b2F2cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2456408"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2456408"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:11:40 -0800
X-CSE-ConnectionGUID: 0CWh79sxQQm1faR4JnCN0Q==
X-CSE-MsgGUID: tj4reW5GTxyz4lbAe+r+zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8256618"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.193])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:11:36 -0800
Date: Tue, 3 Nov 2026 19:11:34 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, javierm@redhat.com,
 louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
 sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] drm/vblank: Restart enabling vblank timer on possible
 deadlock
Message-ID: <auoVxgQ0D1-6QEDD@intel.com>
References: <20261102143919.1672293-1-tzimmermann@suse.de>
 <auioL8zR9O5u4TCF@intel.com>
 <4212140f-fa07-4f0c-bd3a-0ae3d88b250c@suse.de>
 <aujFSzHEv5pAfHPf@intel.com>
 <ec9020b5-28bb-45a5-89d7-e64e804769de@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec9020b5-28bb-45a5-89d7-e64e804769de@suse.de>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 04:55:34PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 02.11.26 um 18:15 schrieb Ville Syrjälä:
> [...]
> > But what I'm thinking is:
> 
> I've ran a lengthy session to explore various solutions.
> 
> > - stop with the explicit cancel entirely and just rely on the
> >    timer cancelling itself
> > - try to start the timer in vblank_enable(), and if that can somehow
> >    fail because the timer is still running it should be fine because
> >    the self cancellation should anyway have been aborted
> 
> Having an old vblank timer still running while enable_vblank sets up a 
> new one can mess up the hrtimer's internal ordering. It's full of subtle 
> bugs, according to my LLM.

The hrtimer code looks like it's designed to handle this. It
first removes the old queued timer and then inserts it back
with the new expire time. And there's also locks in there.

> 
> 
> > - explicitly wait for the timer to have stoppped in drm_vblank_off()
> >    to make sure the wrong interval can't leak from one mode to
> >    another
> 
> I'll soon send out a series implementing this idea.
> 
> Best regards
> Thomas
> 
> >
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
> 

-- 
Ville Syrjälä
Intel
