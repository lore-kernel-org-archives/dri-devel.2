Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF815C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB3010E4BB;
	Wed, 16 Sep 2026 09:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hvbSLHMP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F38410E818
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789551853; x=1821087853;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=JqTORXeSNrJrC5U7anYxzVHfkMstWz5PcasAb0t9hog=;
 b=hvbSLHMP6zQIUxdpa/abQQSpQ9bzyPy93Afuxcd2faslHzwb4OEbhq49
 d3FtQ/ouHoMNXsotSvLIU01n1LRTQkvMuoEFojmcKOgZwQMHez65ft3n4
 yGfw91Yd0ndxGtxl43P0MCKZTqK/zPCqJ06lSkmW+IrzozS0qtbyiA9xd
 9yrFZTDuEx19V/4Vmuyqk9UrHZrrjxx5W6WtbSmDuZ5MhJB92PQxTluNx
 kL27r1F7ZLsYbX//2vQqklBbbC7+NYhLjD4VE9Ur9oVOHSUwTB9NTQyxF
 DRSeF6UCwpXujpjHDh8gAJwe2DFkhDZ0al4HzHlhMk5gsnviinjPVf65z w==;
X-CSE-ConnectionGUID: /2b0svmtQOa+BXwYFYJ5bw==
X-CSE-MsgGUID: dZR0FIgyRxqccV8UawogvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89680307"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89680307"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:44:13 -0700
X-CSE-ConnectionGUID: b6vXZgZNSn2g3CSM2QYyNg==
X-CSE-MsgGUID: /Z8oqPpXRxK1A2FNvWE57w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="303169290"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.154])
 ([10.245.244.154])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:44:10 -0700
Message-ID: <a3c94fcf0029e7f257a0219532d906643846ffd1.camel@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: change TTM maintainers to Natalie and Arun
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 christian.koenig@amd.com, ray.huang@amd.com, nat@pixelcluster.dev, 
 arunpravin.paneerselvam@amd.com, matthew.auld@intel.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 11:44:07 +0200
In-Reply-To: <20260915154804.605772-1-christian.koenig@amd.com>
References: <20260915154804.605772-1-christian.koenig@amd.com>
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

On Tue, 2026-09-15 at 17:48 +0200, Christian K=C3=B6nig wrote:
> The blunt reality is that I don't have time to look into patches or
> bugs
> any more as it would be necessary. The same counts for Ray.
>=20
> Natalie has been working on the dmem cgroup patches for TTM and
> agreed
> to take over looking more into TTM.
>=20
> Arun is working in my team and already maintaining AMDs VRAM backend
> for
> TTM and the underlying buddy allocator.
>=20
> Add Thomas as reviewer as well, better to have more eyes on that
> component.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
> =C2=A0MAINTAINERS | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b5a4e4b35cf..b6e58a138501 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9140,10 +9140,11 @@ F:	drivers/gpu/drm/drm_privacy_screen*
> =C2=A0F:	include/drm/drm_privacy_screen*
> =C2=A0
> =C2=A0DRM TTM SUBSYSTEM
> -M:	Christian Koenig <christian.koenig@amd.com>
> -M:	Huang Rui <ray.huang@amd.com>
> +M:	Natalie Vock <nat@pixelcluster.dev>
> +M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
> =C2=A0R:	Matthew Auld <matthew.auld@intel.com>
> =C2=A0R:	Matthew Brost <matthew.brost@intel.com>
> +R:	Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> =C2=A0L:	dri-devel@lists.freedesktop.org
> =C2=A0S:	Maintained
> =C2=A0T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

Acked-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

@Natalie, @Arun Do you have a presence on dri-devel IRC? If so, Nicks?

Also what is your stance on merging pages to TTM?=20
1) Requiring an explicit maintainer ack, or
2) an R-B from one of the reviewers/maintainers and no concerns raised
within reasonable time?
3) drm-misc as default merge repo?

Thanks,
Thomas
