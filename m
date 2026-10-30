Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7254F606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aqDaJJll
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42E4112865;
	Fri, 30 Oct 2026 14:43:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243AD10E537;
 Fri, 30 Oct 2026 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793371404; x=1824907404;
 h=message-id:subject:from:to:date:in-reply-to:references:
 content-transfer-encoding:mime-version;
 bh=TS2Z1DGDRVlz+okBAkBjYq4Q3cwJ3DoI/+m+a5CFTfs=;
 b=aqDaJJllSrFhaeRAGPP7D39HBmjD736JDqDf5hnYrtXGsci3li24cCTj
 IkQjtq5fQSNFP09Xq6eECwubeyQlrqmIKLeOPNSFQ4u8iSKqRtB+TZJcN
 aP3pONwByaoMdR2VqC1IgfJUGmlkIGonp2sZjkZxwmo1FQ1/Fn2uVcAvI
 xZTaw8uk0bSGuQttHsk05AsltDgTjYZkQwjh705Y53R7BZgczJGF8ORFz
 fWTmqRw6CR6vrmBLiZgTgCEixlW5KtaOeHUvl2AIlaj/FHNMU3tlY8mPw
 oX+XJv8IEFYpQxCi/3VW93rwREEpc4g3hbNcPgRxY1WJ0l/4Z3Qxvr4yM A==;
X-CSE-ConnectionGUID: pg/WZMQoRmeTfMwL7eo+4w==
X-CSE-MsgGUID: xGqH9a8bSfSHpSySrpPYtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2149782"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2149782"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 07:43:23 -0700
X-CSE-ConnectionGUID: 4C0ofky2RPGrLm029Q7Iwg==
X-CSE-MsgGUID: adEgZCnWTTa4erciu/mJBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5855788"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.244.72])
 ([10.245.244.72])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 07:43:23 -0700
Message-ID: <1211707b469ac8c114590a15cf1bbb9433fc0553.camel@linux.intel.com>
Subject: Re: [PATCH v6 1/3] drm/xe: Bump the LRU on a successful page fault
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Date: Fri, 30 Oct 2026 15:43:20 +0100
In-Reply-To: <20261027224902.1085762-2-matthew.brost@intel.com>
References: <20261027224902.1085762-1-matthew.brost@intel.com>
 <20261027224902.1085762-2-matthew.brost@intel.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-10-27 at 15:49 -0700, Matthew Brost wrote:
> Servicing a page fault validates the VMA's backing store and binds
> it,
> making the BO part of the VM's active working set, but unlike exec it
> never moves anything on the TTM LRU. In fault mode, where a VM may
> run
> for a long time without a single exec, the BOs the GPU actually
> touches
> therefore drift towards the LRU head and are picked by eviction and
> by
> the shrinker ahead of genuinely cold BOs.
>=20
> Bump the BO's LRU on a successful page fault.
>=20
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> GPUs")
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Found the newer version:
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


> ---
> =C2=A0drivers/gpu/drm/xe/xe_pagefault.c | 7 +++++++
> =C2=A01 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c
> b/drivers/gpu/drm/xe/xe_pagefault.c
> index 5247321c805e..6828f81df50e 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -201,6 +201,8 @@ static int xe_pagefault_handle_vma(struct xe_gt
> *gt, struct xe_vma *vma,
> =C2=A0		xe_validation_ctx_init(&ctx, &vm->xe->val, &exec,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (struct xe_val_flags) {});
> =C2=A0		drm_exec_until_all_locked(&exec) {
> +			struct xe_bo *bo =3D xe_vma_bo(vma);
> +
> =C2=A0			err =3D xe_pagefault_begin(&exec, vma, tile-
> >mem.vram,
> =C2=A0						 needs_vram =3D=3D 1);
> =C2=A0			drm_exec_retry_on_contention(&exec);
> @@ -221,6 +223,11 @@ static int xe_pagefault_handle_vma(struct xe_gt
> *gt, struct xe_vma *vma,
> =C2=A0				xe_pagefault_set_error(pf,
> XE_PAGEFAULT_ERROR_VMA_REBIND);
> =C2=A0				break;
> =C2=A0			}
> +
> +			if (bo) {
> +				scoped_guard(spinlock, &vm->xe-
> >ttm.lru_lock)
> +					ttm_bo_move_to_lru_tail(&bo-
> >ttm);
> +			}
> =C2=A0		}
> =C2=A0		xe_validation_ctx_fini(&ctx);
> =C2=A0	} while (err =3D=3D -EAGAIN);
