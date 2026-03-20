Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E40109318F
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 08:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE17010EAA5;
	Fri, 20 Mar 2026 08:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LjZWbuTP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B6810EA94;
 Fri, 20 Mar 2026 08:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773996238; x=1805532238;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=1rw9i7NlqT3/rN995n1JSVjmmaDOEDPJ70JUAbq4uto=;
 b=LjZWbuTP/CFd/XXBksD6B7/b5Xlkm/ydIzjj2ab3ah+b70YcRi+43YXo
 52078C9uv4GP1NoBjhY3Rq1+VsLOcd3Egln3qqUyILjmsQvxAlx6Y8pAB
 4alx5/w2TfAxS1hjYDmdDrm1PAUOaxiv6kU4RZfZnTt9HMogYqZALCNeU
 9pSEaIzddUt+DmtZofu0Us0nmr1+dw1a9Qe3ck3IZPQ8HEtSOif5h3vFu
 Wex3WUYO7MHZ7NXlR0Buafoc0/sD8iSTzJUjwk3MxuEWdgh4UVaoNSE8j
 3g2s4t1vSX4KpnYkb6cWj9hEaVq5EXVRa8NABlk3SlrkDnxPmE+SihCrL g==;
X-CSE-ConnectionGUID: /ZvWNBJRTreopnUfJS/hRg==
X-CSE-MsgGUID: WYAcj9vTQUq4xeu+AFumJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75044115"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="75044115"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 01:43:58 -0700
X-CSE-ConnectionGUID: 0UAu0tkrQPOK/VU4bs2lOQ==
X-CSE-MsgGUID: 0TPMnp4sS7Wu9L2e7kCxLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="223211629"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.69])
 ([10.245.245.69])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 01:43:56 -0700
Message-ID: <ea41cd920d4acdcb2c2e5e4ad081209fb5fbe07b.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/3] drm/ttm: Improve the TTM operation context
 gfp_retry_mayfail behaviour
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Matthew Auld
 <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org
Date: Fri, 20 Mar 2026 09:43:53 +0100
In-Reply-To: <09f9a8ce-231e-4bb1-b95f-8dff8060d042@amd.com>
References: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
 <dbb22727c88887375737f5a837b245ca22bed988.camel@linux.intel.com>
 <237c24790679ebf668bf1d38155ac8888d211028.camel@linux.intel.com>
 <09f9a8ce-231e-4bb1-b95f-8dff8060d042@amd.com>
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

On Fri, 2026-03-20 at 09:42 +0100, Christian K=C3=B6nig wrote:
> Sorry for the delay. Feel free to add my Acked-by.
>=20
> Regards,
> Christian.

Thx!

/Thomas


>=20
> On 3/19/26 20:30, Thomas Hellstr=C3=B6m wrote:
> > Hi!
> >=20
> > Since Sima was OK with this series and I believe the changes are
> > completely non-controversial, I'll go ahead and merge this tomorrow
> > through drm-misc-next.
> >=20
> > Thanks,
> > Thomas
> >=20
> >=20
> > On Wed, 2026-03-18 at 15:50 +0100, Thomas Hellstr=C3=B6m wrote:
> > > @Christian, Ack to merge these?
> > >=20
> > > Thanks,
> > > Thomas
> > >=20
> > >=20
> > > On Tue, 2026-03-17 at 15:18 +0100, Thomas Hellstr=C3=B6m wrote:
> > > > Two small patches around the gfp_retry_mayfail behaviour, and
> > > > one patch to improve associated kerneldoc.
> > > >=20
> > > > Patch 1 ensures we don't spam the kernel log on allocation
> > > > failures.
> > > >=20
> > > > Patch 2 extends the gfp_retry_mayfail to swap readback.
> > > >=20
> > > > Patch 3 Improves on the associated kerneldocs.
> > > >=20
> > > > v2:
> > > > - Add patch 3. (Sima).
> > > >=20
> > > > Thomas Hellstr=C3=B6m (3):
> > > > =C2=A0 drm/ttm: Don't spam the log on buffer object backing store
> > > > allocation
> > > > =C2=A0=C2=A0=C2=A0 failure
> > > > =C2=A0 drm/ttm: Avoid invoking the OOM killer when reading back
> > > > swapped
> > > > =C2=A0=C2=A0=C2=A0 content
> > > > =C2=A0 drm/ttm: Update the struct ttm_operation_ctx kerneldoc
> > > >=20
> > > > =C2=A0drivers/gpu/drm/ttm/ttm_backup.c |=C2=A0 6 ++++--
> > > > =C2=A0drivers/gpu/drm/ttm/ttm_pool.c=C2=A0=C2=A0 |=C2=A0 7 +++++--
> > > > =C2=A0include/drm/ttm/ttm_backup.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
2 +-
> > > > =C2=A0include/drm/ttm/ttm_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 28 +++++++++++++++++++-----
> > > > ----
> > > > =C2=A04 files changed, 29 insertions(+), 14 deletions(-)
