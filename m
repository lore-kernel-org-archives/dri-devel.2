Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23223606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auRCJl/E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BAE10E78D;
	Wed,  4 Nov 2026 06:18:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 607B610F9B5;
 Wed,  4 Nov 2026 06:18:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D399860DA2;
 Wed,  4 Nov 2026 06:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03B11F000C1;
 Wed,  4 Nov 2026 06:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793773087;
 bh=6/yfRhPcdasAXeCYxCK7Gbe/TNcSbSf4ZuUMV3o/rPg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=auRCJl/EnM4TT0CkabaLgVB0NAGS1Zk+qqHa3/FK1a/bXSO81tILeopu4IQiGN2r0
 K4hho/CdVH+xbGItwPh3Q8iXgLo8uVTnZhRTyHeGCsX1a1HbobMY/Bb35VYOhldZkA
 13JZbTQt9S2GbTzIzWGYjyUS/Wl51awE92o9+psSOSrXP+guO2MfQuk7EIjejFJ8Lx
 T7vbHiMeOg5o6/YbQxORmDToRVwh2jaopt8deFA/NMcM0Lc5WQEsSUKtZiisfZxIzF
 NKjDftpHMrUjd96+NPaBY0GNSQ89/7HCGzU9xOFIRzjrKKu1gmaji8G2gdaL17xm/j
 N/ppVOmLDrdOA==
Message-ID: <sashiko-outbox-196749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 11/12] Documentation/mm/hmm: document migration
 through hmm_range_fault()
To: mpenttil@redhat.com, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, "David
 Hildenbrand" <david@kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Balbir Singh" <balbirs@nvidia.com>, "Zi Yan" <ziy@nvidia.com>,
 "Matthew Brost" <matthew.brost@intel.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@suse.cz>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Lyude Paul" <lyude@redhat.com>, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20261103061629.972669-12-mpenttil@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
 <20261103061629.972669-12-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:18:06 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm/hmm: incomplete error rollback steps for migrate_hmm_range_setup=
() in docs
--

commit 908a5d19d6ca6398929f82b830d122f054aa64a3
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

Documentation/mm/hmm: document migration through hmm_range_fault()

This commit documents the MIGRATE_VMA_FAULT and MIGRATE_VMA_WRITE flags for
migrate_vma_setup(), as well as driving the migration collection phase
directly from hmm_range_fault() via HMM_PFN_REQ_MIGRATE and
migrate_hmm_range_setup().

> diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
> index fc1b8dc198250..914ef6bfe8486 100644
> --- a/Documentation/mm/hmm.rst
> +++ b/Documentation/mm/hmm.rst

[ ... ]

> @@ -427,6 +434,44 @@ between device driver specific code and shared commo=
n code:
> =20
>     The lock can now be released.
> =20
> +Migration collection through hmm_range_fault()
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[ ... ]

> +After hmm_range_fault() returns, the driver calls::
> +
> +    void migrate_hmm_range_setup(struct hmm_range *range);
> +
> +to translate ``range->hmm_pfns`` into ``migrate->src[]`` (``migrate->dst=
[]`` is
> +zeroed) and initialize ``migrate->cpages`` and ``migrate->npages``. From=
 here on
> +the ``range->migrate`` struct is ready for the rest of the flow (steps 3
> +onwards), i.e. migrate_vma_pages() and migrate_vma_finalize(). This shou=
ld be
> +called even on error, since hmm_range_fault() may have collected part of=
 the
> +range before failing.

[Severity: Low]
Could this wording be clarified regarding what needs to be called when
hmm_range_fault() returns an error?

In mm/migrate_device.c, migrate_hmm_range_setup() only translates
range->hmm_pfns into migrate->src[], zeroes migrate->dst[], initializes
migrate->cpages and migrate->npages, and calls migrate_vma_unmap(). Calling
migrate_hmm_range_setup() alone on error would leave migration PTEs install=
ed
and leave collected folios isolated from the LRU, locked, and with elevated
reference counts.

On the other hand, if "This" is read as referring to the rest of the flow
(steps 3 onwards), step 3 in Documentation/mm/hmm.rst instructs the driver =
to
allocate destination pages, copy source pages, and populate migrate->dst[],
which would commit the partial migration rather than aborting it.

As described in the kernel-doc for hmm_range_fault() in mm/hmm.c:

 * On any other error, or when abandoning a retry, the caller must call
 * migrate_hmm_range_setup(), migrate_vma_pages() with no valid destination
 * entries, and migrate_vma_finalize() to abort the partial migration.

Should this paragraph explicitly state that on error the driver must call
migrate_hmm_range_setup(), skip step 3 so migrate->dst[] remains zeroed, and
still call migrate_vma_pages() and migrate_vma_finalize() to restore the
original PTEs and release the folio locks and references?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103061629.9726=
69-1-mpenttil@redhat.com?part=3D11
