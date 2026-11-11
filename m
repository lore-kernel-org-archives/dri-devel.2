Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B4606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z8MH9Za4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D4C10FA9B;
	Wed, 11 Nov 2026 10:44:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B600610FA9B;
 Wed, 11 Nov 2026 10:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794393879; x=1825929879;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=HiXQ/g3azUEcfe8dzHmd0ZaFrmddY0ixVLKKKhNMeBQ=;
 b=Z8MH9Za4TSJWbaLGIF7lMvjzq38PJ76w6Xx16GSZqiHCqMIIjUCchkdK
 SUVQt7H9pFcwK5EyhxmII/Wc6nTqrDyGmKm7MQ/WO4r1Shp+GORFuNtdp
 fqjRulpqR5LjYbzQmcwinJb1lTJsUpwSsLQlpeT/kzCcnrAMK1yT0VSnF
 S5I6oO4GOOmG735d9tJK45qP0UxUXoyeYfo4fD7PY5A43/MD6ETaPNhcp
 mZcdj3eXhdm12SLTijM8ZPAJ1mdfecDkeDxpEgmbIBgzUaic4+/D3fr92
 ho84lnpVim44voydf4zjWi1e3pT9ujBD49MkvI6t4E2HQEJoN5kyUB8Ib w==;
X-CSE-ConnectionGUID: qAAamDCrQ/izPd+y73UiCA==
X-CSE-MsgGUID: qpO+QwAWTKCRSrZbiUQysg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3184233"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3184233"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 02:44:39 -0800
X-CSE-ConnectionGUID: S3pxDSsHQ6GZL1WCGyS7XQ==
X-CSE-MsgGUID: ihG1NXRFSrG71rdmLCuD0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8721487"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.125])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 02:44:36 -0800
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
Subject: Re: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, tursulin@ursulin.net,
 matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
 dri-devel@lists.freedesktop.org,
 Krishna Prabhakaran <krishna.prabhakaran@intel.com>
To: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>,
 intel-gfx@lists.freedesktop.org
Date: Wed, 11 Nov 2026 12:44:33 +0200
Message-ID: <179439387311.199148.11937438921736048164@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
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

Quoting Prabhakaran, Krishna (2026-08-16 04:45:52)
> From: Krishna Prabhakaran <krishna.prabhakaran@intel.com>
>=20
> When i915 needs to make an imported dma-buf coherent for GPU access on
> non-LLC platforms, or for objects that bypass LLC, it currently calls
> wbinvd_on_all_cpus(). get_pages() runs whenever an imported buffer is
> pinned, so this triggers a whole-cache write-back and invalidate,
> broadcast by IPI to every CPU, on every execbuf submission involving an
> imported dma-buf. That stalls the entire machine for milliseconds and
> starves latency-sensitive work on unrelated cores (e.g. USB isochronous
> audio serviced on the VMM's main thread).

No bug opened for issue, no exact hardware config described, no dmesg logs.

Also, if you import a new dma-buf too frequently, probably shouldn't do
that.

> Flush only the pages that actually need it instead:
>=20
>  - If we imported one of our own dma-bufs, the backing object is
>    struct-page backed once migrated to SMEM, so flush it directly with
>    drm_clflush_sg(), exactly as we flush our other objects. This also
>    avoids re-entering the exporter through dma_buf_vmap(), which would
>    recurse into i915_gem_object_pin_map() on the source object we
>    already hold locked (and fails the igt_dmabuf_import_same_driver
>    selftest with -EBUSY).
>=20
>  - For a foreign dma-buf the sg_table is not guaranteed to be backed by
>    struct pages, and the importer has no way to tell, so drm_clflush_sg()
>    cannot be used. vmap the buffer and flush that virtual range with
>    drm_clflush_virt_range() instead: x86 uses PIPT caches, so flushing
>    one virtual alias evicts the cache lines for every alias of the same
>    physical pages. The dma_resv lock required by dma_buf_vmap() is
>    already held here via the imported object.

You're literally echoing what code does or has in comments here. We can
see the code by looking at the code.

Please try to use less LLMs and use more of your own words for describing t=
he
changes or writing comments.

Patch description could literally have been around two sentences about
reducing the amount of unnecessary flushing.

> Fall back to wbinvd only when the buffer cannot be vmapped or is backed
> by I/O memory, where there is no CPU-side range to clflush.
>=20
> Fixes: a035154da45d ("drm/i915/dmabuf: add paranoid flush-on-acquire")

Definitely no Fixes tag for what is essentially an optimization.

Regards, Joonas
