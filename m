Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141F6C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3912910E37C;
	Wed, 16 Sep 2026 10:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UJQMJL9B";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36F110E37C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789555370; x=1821091370;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Kq6hnJS1LPeRAuBNKz6yxBErH2+9XipDjrF6CPyZTBQ=;
 b=UJQMJL9BP9BOM4khIF2oJg5IyD/uUXYDp9z4J46j9nmJVzPu07tstpw2
 ldK5F7CpCfXwEW2rpUyhbMly3/UChgjgT9oyPu9lDqcNDuh1+gwjhd0Yc
 uw8s8wbDD2AvOQOYbFeP5vpLSTnGBbo/bcTzIogdgu+oGpMZp7BT2oV+O
 DX15XCRVj/dkfKdqHvRozYHDlBMn5TIso3kluPUMVQp8T8FGS2+Qa2Auq
 i2eC7kG9zLfmxNKfU1TeM3yeb1+cxgIMT0nMjXON2l78uS/KSiwheAWRC
 CNb+XGSPSDqCVGMnikcHhpUF+2+1f5qMfcsYg9m8eNSVG1bfemZE6Rbce A==;
X-CSE-ConnectionGUID: p1K3Hgz6TQ2DC+F+qBsLrw==
X-CSE-MsgGUID: jEFEGt7tQWybXfYWaCdyuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100253322"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100253322"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:42:50 -0700
X-CSE-ConnectionGUID: gRbfWwABTseGunggg6ZmjA==
X-CSE-MsgGUID: p8wrbXx9RriZih2aWnZV2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272826997"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.154])
 ([10.245.244.154])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:42:47 -0700
Message-ID: <df14f0da3538cbac98384bdf538de137ea2a3278.camel@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: change TTM maintainers to Natalie and Arun
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Natalie Vock <nat@pixelcluster.dev>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <ckoenig.leichtzumerken@gmail.com>, christian.koenig@amd.com,
 ray.huang@amd.com, 	arunpravin.paneerselvam@amd.com,
 matthew.auld@intel.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 12:42:45 +0200
In-Reply-To: <5e301f2e-730c-479a-890d-7ed6044b8a1c@pixelcluster.dev>
References: <20260915154804.605772-1-christian.koenig@amd.com>
 <a3c94fcf0029e7f257a0219532d906643846ffd1.camel@linux.intel.com>
 <5e301f2e-730c-479a-890d-7ed6044b8a1c@pixelcluster.dev>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Wed, 2026-09-16 at 12:35 +0200, Natalie Vock wrote:
> Hi,
>=20
> On 9/16/26 11:44, Thomas Hellstr=C3=B6m wrote:
> > On Tue, 2026-09-15 at 17:48 +0200, Christian K=C3=B6nig wrote:
> > > The blunt reality is that I don't have time to look into patches
> > > or
> > > bugs
> > > any more as it would be necessary. The same counts for Ray.
> > >=20
> > > Natalie has been working on the dmem cgroup patches for TTM and
> > > agreed
> > > to take over looking more into TTM.
> > >=20
> > > Arun is working in my team and already maintaining AMDs VRAM
> > > backend
> > > for
> > > TTM and the underlying buddy allocator.
> > >=20
> > > Add Thomas as reviewer as well, better to have more eyes on that
> > > component.
> > >=20
> > > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > ---
> > > =C2=A0=C2=A0MAINTAINERS | 5 +++--
> > > =C2=A0=C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 5b5a4e4b35cf..b6e58a138501 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9140,10 +9140,11 @@
> > > F:	drivers/gpu/drm/drm_privacy_screen*
> > > =C2=A0=C2=A0F:	include/drm/drm_privacy_screen*
> > > =C2=A0=20
> > > =C2=A0=C2=A0DRM TTM SUBSYSTEM
> > > -M:	Christian Koenig <christian.koenig@amd.com>
> > > -M:	Huang Rui <ray.huang@amd.com>
> > > +M:	Natalie Vock <nat@pixelcluster.dev>
> > > +M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
> > > =C2=A0=C2=A0R:	Matthew Auld <matthew.auld@intel.com>
> > > =C2=A0=C2=A0R:	Matthew Brost <matthew.brost@intel.com>
> > > +R:	Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > > =C2=A0=C2=A0L:	dri-devel@lists.freedesktop.org
> > > =C2=A0=C2=A0S:	Maintained
> > > =C2=A0=C2=A0T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> >=20
> > Acked-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> >=20
> > @Natalie, @Arun Do you have a presence on dri-devel IRC? If so,
> > Nicks?
>=20
> Yes, I have the nick "pixelcluster".
>=20
> >=20
> > Also what is your stance on merging pages to TTM?
> > 1) Requiring an explicit maintainer ack, or
> > 2) an R-B from one of the reviewers/maintainers and no concerns
> > raised
> > within reasonable time?
>=20
> I think my preference would more or less be 2). That is, if for some
> reason no maintainer answers, after some time the patches should be
> ok
> to merge (but if a maintainer does explicitly ack/R-b the patch it
> can
> be merged sooner). I'll try my best to not leave patches unanswered
> so
> hopefully 2) stays a rarity :)
>=20
> > 3) drm-misc as default merge repo?
>=20
> Sure, why not? Basically like it's been so far as well, right? It
> didn't
> seem to me like the patch volume for TTM is particularly large at
> least
> so far, so something like a separate branch might not be worth the
> hassle.

Great. Thanks. Reason for the last question was more that if we want to
merge TTM patches outside of the default branch if they are required
for a driver feature, and then we always ask for ack to merge on a
different branch / repo. If we have an agreed default we typically
don't ask for a separate merge ack on that one.

/Thomas

>=20
> Best,
> Natalie
