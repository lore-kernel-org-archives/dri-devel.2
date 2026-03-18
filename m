Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1F2103E190
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCFC10E09C;
	Wed, 18 Mar 2026 14:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="boNsBytO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26B9B10E048;
 Wed, 18 Mar 2026 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773845464; x=1805381464;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=3jWky9SQ4SM/F9lJa0B31L8pDrxgXdicWnreEI/t2kc=;
 b=boNsBytOJsXYPgfoThG602VFWRiKpgSLHSzfsnQHP460Ub8narJ34Svc
 0/Nx0BucnZnuGRw5k3nJliPob9o8M1v+1qXMqPg/wNx3qNagikzu7mqbx
 HW1vCmWcOA/Rlg31jka2uViTEwzUjUIvmQvYyBVqNvIrEO6qR8VtWJsEP
 uwHRM1d+ogQxNGiF4NRgglyVBnPfP+cjYkm2kuRx+7vqh5AJzb8H0gzSS
 7E7p3GIrS7TGKI2RkXJrEpZRBddcaaGJnSu2bfI3ofuulMleYPtb8dnVf
 v4gE+vsvH6uYBvNu6nPjvXuTEiWGNTzjm9V6gxv0xHuMHTx/U5CsFLG4n g==;
X-CSE-ConnectionGUID: 1NZwG0K1Q16CSlvAaGptaw==
X-CSE-MsgGUID: zdgOEdw3TQeY9cs2h42PJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78807706"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="78807706"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 07:51:04 -0700
X-CSE-ConnectionGUID: JJovyAoRTqmuh88G4BksXQ==
X-CSE-MsgGUID: uzqby84yQOC+mlmoCbs9nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="221723578"
Received: from vpanait-mobl.ger.corp.intel.com (HELO [10.245.244.19])
 ([10.245.244.19])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 07:51:02 -0700
Message-ID: <dbb22727c88887375737f5a837b245ca22bed988.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/3] drm/ttm: Improve the TTM operation context
 gfp_retry_mayfail behaviour
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>, Matthew Auld
 <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org
Date: Wed, 18 Mar 2026 15:50:59 +0100
In-Reply-To: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
References: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
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

@Christian, Ack to merge these?

Thanks,
Thomas


On Tue, 2026-03-17 at 15:18 +0100, Thomas Hellstr=C3=B6m wrote:
> Two small patches around the gfp_retry_mayfail behaviour, and
> one patch to improve associated kerneldoc.
>=20
> Patch 1 ensures we don't spam the kernel log on allocation failures.
>=20
> Patch 2 extends the gfp_retry_mayfail to swap readback.
>=20
> Patch 3 Improves on the associated kerneldocs.
>=20
> v2:
> - Add patch 3. (Sima).
>=20
> Thomas Hellstr=C3=B6m (3):
> =C2=A0 drm/ttm: Don't spam the log on buffer object backing store
> allocation
> =C2=A0=C2=A0=C2=A0 failure
> =C2=A0 drm/ttm: Avoid invoking the OOM killer when reading back swapped
> =C2=A0=C2=A0=C2=A0 content
> =C2=A0 drm/ttm: Update the struct ttm_operation_ctx kerneldoc
>=20
> =C2=A0drivers/gpu/drm/ttm/ttm_backup.c |=C2=A0 6 ++++--
> =C2=A0drivers/gpu/drm/ttm/ttm_pool.c=C2=A0=C2=A0 |=C2=A0 7 +++++--
> =C2=A0include/drm/ttm/ttm_backup.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0include/drm/ttm/ttm_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 28 +++++++++++++++++++---------
> =C2=A04 files changed, 29 insertions(+), 14 deletions(-)
