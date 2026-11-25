Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660F606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RtY3rSzi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B24F510E86A;
	Wed, 25 Nov 2026 10:14:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2989E10E86A
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795601683; x=1827137683;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=dTu7nQvatqpgXj9AzDc4jgoXS905m6bwfqi4OHSfyo4=;
 b=RtY3rSziFD2bQsAmd5e8VRKo0QEm7VurPnlKA46t9HcHJ3Gv29Zyl9j4
 68LW66VNkC4UEDEClGlTinn6pV1nk6RxJ87piVNkdyCqoaeYWFUxnYuj8
 sDFU+Nu6f8teguSrE5xK+93/bd2VCYFbnQEA7mmHO9jygE06oycK5Sdo7
 +ClhjaTzqk+RpH8JCJkbn4MGEWtG8wCVRNcTOfMxLiiOVRHOF1ffHXOfp
 otIyCG9wgrx91johqqKZRzI0QRQwPY5iA4tIBeH1nqgiw0me3aZllzwk1
 +WWasPX7e8n9qHjN4JSyFpDSui1uWN0mLupFnWfKFljDl0gyZzF/0VVM+ Q==;
X-CSE-ConnectionGUID: fcGKqJpJQ4iI+DqHeUlD3g==
X-CSE-MsgGUID: Ahl0alPsTYO6Y9LnlXf2ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4488158"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4488158"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 02:14:43 -0800
X-CSE-ConnectionGUID: lDcscIMqRhOeZF6FN422nw==
X-CSE-MsgGUID: xpgseFCXQnWbAyBs3wVw7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="13500075"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.244.74])
 ([10.245.244.74])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 02:14:42 -0800
Message-ID: <114377fd4c275215e40c3991bb935b8c41aa3d36.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] drm/ttm: fix excessive idle memory retention
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>,
 nat@pixelcluster.dev, 	arunpravin.paneerselvam@amd.com
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com, 
 matthew.brost@intel.com
Date: Wed, 25 Nov 2026 11:14:39 +0100
In-Reply-To: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
References: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eduardo,

On Tue, 2026-11-24 at 19:28 -0300, Eduardo P. Gomez wrote:
> I started looking into this after my Intel Xe desktop with 32 GiB of
> RAM
> would eventually freeze following repeated graphics allocations (A
> test
> program allocated around 12 GiB without freeing up). In a
> separate test, a standalone kernel module exercised the TTM page pool
> directly. On unpatched 7.4-rc4 in a single-node QEMU guest, 768 MiB
> remained in the pool 60s after the module returned its pages.

This series fails to explain why this is necessary? That is, why
doesn't the TTM pool shrinker reclaim the pages on memory pressure,
which is the way this is intended to work?

Thanks,
Thomas



>=20
> Patch 1 adds a 5s timeout after the last page return. It can
> stand on its own and drains the idle pool. In QEMU, the pool was
> empty
> at the eight-second sample. The trade-off is that the next burst may
> have to allocate and prepare those pages again.
>=20
> Patch 2 builds on the timeout and keeps a 128 MiB reserve per NUMA
> node
> to reduce that trade-off. With both patches, the same 768 MiB test
> left
> 128 MiB in the pool at the 8s and 60s samples. The
> shrinker can still reclaim the reserve under memory pressure.
>=20
> In a separate QEMU benchmark with a 750ms timeout, the median time to
> allocate 128 MiB after expiry was 185ms after a full drain and 0.45ms
> with the reserve. A 768 MiB request took 1.13s after a full drain and
> 0.95s with the reserve. The unpatched kernel kept the entire pool and
> reused those 768 MiB in about 2ms. These tests measure idle retention
> and allocation latency in QEMU.
>=20
> The test files can be downloaded at
> https://codeberg.org/EduApps-CDG/linux-ttm-pool.
> It includes 2 C files (one for test and another for benchmark), my
> logs,
> some build/test helping bash scripts and the compiled binary I'm
> using
> on my machine right now.
>=20
> Feedback and change requests are welcome.
>=20
> Eduardo P. Gomez (2):
> =C2=A0 drm/ttm: reclaim pooled pages after a period of inactivity
> =C2=A0 drm/ttm: retain a reserve during idle pool reclaim
>=20
> =C2=A0drivers/gpu/drm/ttm/ttm_pool.c | 92 +++++++++++++++++++++++++++++++=
-
> --
> =C2=A01 file changed, 85 insertions(+), 7 deletions(-)
>=20
>=20
> base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
