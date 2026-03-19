Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301731091911
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6818B10E09E;
	Thu, 19 Mar 2026 19:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KyDb+l+q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD35210E072;
 Thu, 19 Mar 2026 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773948648; x=1805484648;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=JA15s9L5b/UidGU7nVs7/kijN7/N7gM6691MPf3Uklo=;
 b=KyDb+l+q7hCvWtPsJEq6gIen3UG0CSJ5aATuztzNOKw/jFK5/+/r/Gea
 M1TMNCJ7DKQuF0RS3Y8ee430Xv6vCl3A3OfSQmngWUjpIE8lhmoGOii8z
 pO64Xa2CIHBbRZvaURUGUzbY+rnmeEHHPhrJgm5y33i3fMphT3ujDg+iO
 I41U7JDG/epzb5fI9HfCN87r9RHUTGwTbi5BqDL+kXQcrqbPsAZ69te63
 5M5zwnlSoAcT7vQ6XOIvOoOssrTGyLRZuXqlFX5Gfy1zc1ndNfNrQkg0J
 2Rx4JZ16Ehc1Y80CAZ8ROoVC+0Uq4+frrAJSUvkP4bLg10OuGhMjLJ9ls w==;
X-CSE-ConnectionGUID: nprW+psLSb+3BnmJl4vueg==
X-CSE-MsgGUID: kJavoaeIRkOtrsDg4y93HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74943376"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="74943376"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 12:30:47 -0700
X-CSE-ConnectionGUID: xo4GfhXrT4a4R1kY4y6sxQ==
X-CSE-MsgGUID: ygv9u1FsQSOXf1Z4nwL8cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="253544923"
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.244.165])
 ([10.245.244.165])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 12:30:46 -0700
Message-ID: <237c24790679ebf668bf1d38155ac8888d211028.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/3] drm/ttm: Improve the TTM operation context
 gfp_retry_mayfail behaviour
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>, Matthew Auld
 <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org
Date: Thu, 19 Mar 2026 20:30:43 +0100
In-Reply-To: <dbb22727c88887375737f5a837b245ca22bed988.camel@linux.intel.com>
References: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
 <dbb22727c88887375737f5a837b245ca22bed988.camel@linux.intel.com>
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

Hi!

Since Sima was OK with this series and I believe the changes are
completely non-controversial, I'll go ahead and merge this tomorrow
through drm-misc-next.

Thanks,
Thomas


On Wed, 2026-03-18 at 15:50 +0100, Thomas Hellstr=C3=B6m wrote:
> @Christian, Ack to merge these?
>=20
> Thanks,
> Thomas
>=20
>=20
> On Tue, 2026-03-17 at 15:18 +0100, Thomas Hellstr=C3=B6m wrote:
> > Two small patches around the gfp_retry_mayfail behaviour, and
> > one patch to improve associated kerneldoc.
> >=20
> > Patch 1 ensures we don't spam the kernel log on allocation
> > failures.
> >=20
> > Patch 2 extends the gfp_retry_mayfail to swap readback.
> >=20
> > Patch 3 Improves on the associated kerneldocs.
> >=20
> > v2:
> > - Add patch 3. (Sima).
> >=20
> > Thomas Hellstr=C3=B6m (3):
> > =C2=A0 drm/ttm: Don't spam the log on buffer object backing store
> > allocation
> > =C2=A0=C2=A0=C2=A0 failure
> > =C2=A0 drm/ttm: Avoid invoking the OOM killer when reading back swapped
> > =C2=A0=C2=A0=C2=A0 content
> > =C2=A0 drm/ttm: Update the struct ttm_operation_ctx kerneldoc
> >=20
> > =C2=A0drivers/gpu/drm/ttm/ttm_backup.c |=C2=A0 6 ++++--
> > =C2=A0drivers/gpu/drm/ttm/ttm_pool.c=C2=A0=C2=A0 |=C2=A0 7 +++++--
> > =C2=A0include/drm/ttm/ttm_backup.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0include/drm/ttm/ttm_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 28 +++++++++++++++++++---------
> > =C2=A04 files changed, 29 insertions(+), 14 deletions(-)
