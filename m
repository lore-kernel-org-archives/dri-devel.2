Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299C9C982D0
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 07:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FA210E1E8;
	Sun, 20 Sep 2026 07:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z5PR/uUu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3D910E1E8
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 07:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789891107; x=1821427107;
 h=message-id:subject:from:to:cc:in-reply-to:references:
 content-transfer-encoding:mime-version:date;
 bh=KOXK+o2G2gHE2Us6HrzG5xy4fAPI4zxkTHPO/AxMwhw=;
 b=Z5PR/uUuk1yyUiJWyBsf+iaF3cdGVWMxxz06sME0suGLQapY5bd5dbos
 iJIoepXOf8GbSk1292HYi/iUNoi+irVS7LoYfjRMh+bCoZqPkBF9fp0On
 03lZ0nwbDR0N87Z4FACK0lmDjzHMMJ/WEogsCruVHvEIIysgFD3pa7M0X
 x+syGDYRP56CBKXeU6U7aoIE8vaQ+iRTVeQBW7NBiqNSL0xvGyKVKVieN
 K/NvrFOxMlKHPY/iIVJPcRVTyjeowqBpyd0rv8KVIMiPucvwlfJkxueVw
 3+qTQ747o2+A65JfHn92g2cArem9PmgLTXg+EFk1LaMZ1RrteN/ucL51B g==;
X-CSE-ConnectionGUID: 3rh2P6EcSomTObql9he4tA==
X-CSE-MsgGUID: y+qHMJWhTlC5Yc8pOiX/nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="100995503"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="100995503"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 00:58:26 -0700
X-CSE-ConnectionGUID: rMJR/O46QlSaxKYvWq20rg==
X-CSE-MsgGUID: EM7vkLlOTw6Oq5RYB3tdzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3239618"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.80])
 ([10.245.244.80])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 00:58:24 -0700
Message-ID: <28c15950733eb5a26133858dc0d70276fb5c8d41.camel@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: change TTM maintainers to Natalie and Arun
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 christian.koenig@amd.com, ray.huang@amd.com, nat@pixelcluster.dev, 
 matthew.auld@intel.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <d55151eb-4b81-41c7-927e-96635c1f6b7f@amd.com>
References: <20260915154804.605772-1-christian.koenig@amd.com>
 <a3c94fcf0029e7f257a0219532d906643846ffd1.camel@linux.intel.com>
 <d55151eb-4b81-41c7-927e-96635c1f6b7f@amd.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date: Thu, 17 Sep 2026 08:04:38 +0200
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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

On Wed, 2026-09-16 at 16:58 +0530, Arunpravin Paneer Selvam wrote:
>=20
>=20
> On 9/16/2026 3:14 PM, Thomas Hellstr=C3=B6m wrote:
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
> > Acked-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> >=20
> > @Natalie, @Arun Do you have a presence on dri-devel IRC? If so,
> > Nicks?
> >=20
> > Also what is your stance on merging pages to TTM?
> > 1) Requiring an explicit maintainer ack, or
> > 2) an R-B from one of the reviewers/maintainers and no concerns
> > raised
> > within reasonable time?
> > 3) drm-misc as default merge repo?
> Hi Thomas,
>=20
> I am not currently on dri-devel IRC, but I will set up an OFTC
> account=20
> and follow up with my nick shortly.
>=20
> Regarding the merge process, my preference would also be option 2,
> i.e.=20
> a Reviewed-by from one of the reviewers/maintainers with no concerns=20
> raised within a reasonable timeframe.
> For larger or more significant changes, I think a closer maintainer=20
> review before merging would be good.
> I will also try my best to review patches on time so this rarely
> happens.
>=20
> Using drm-misc as the default merge repository sounds good to me as
> well.

Thanks, Arun,
/Thomas


>=20
> Thanks,
> Arun.
> >=20
> > Thanks,
> > Thomas
