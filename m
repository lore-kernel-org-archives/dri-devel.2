Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7E3606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GwFWxfTJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 655E4112867;
	Fri, 30 Oct 2026 14:36:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A0E112872;
 Fri, 30 Oct 2026 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793370965; x=1824906965;
 h=message-id:subject:from:to:date:in-reply-to:references:
 content-transfer-encoding:mime-version;
 bh=lhZiV9jl342m7bd3J1XHS5NR0JsZNoWqpXGDe7KWea8=;
 b=GwFWxfTJ3rQs/TmhIRgT5vLh/FnRzO2jjqJvaK88kuUiyXSBZVbnbVd7
 lD799e9sRWJoETIiSn/U7gJUmHfTDgSFqxpTJNt6YyfyqotW6yBpe/ouV
 1/obasPaDm//ajA3nQ4vcUPlABv4WAbtIKvUTc/FHk8kPqW54Awp/Osc7
 6a9aIzCBIqBFjg4pEceo0xFIgbjVsKEmRBJsO/FrbACwYjK7+JND1Hk5o
 VroXoH/ifJ0SYeFmea/nABnHuyaDakVMh2THYq1RMTxNaKcAlUj93QFKo
 I4xuPoonuJYBl8kAVajPO8Oac63S5Ha0HqdhBp+370W2R6cwMNrl4wYGk g==;
X-CSE-ConnectionGUID: QAG5p+vNTOiq8Ji/ht+zOw==
X-CSE-MsgGUID: jsi5KjnxROKlerUUng4O3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2014327"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2014327"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 07:36:05 -0700
X-CSE-ConnectionGUID: 2fyfs+NJS9KCJeCAXKdlrA==
X-CSE-MsgGUID: Sx38ffhTRkCGlo0mdwx9gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5338979"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.244.72])
 ([10.245.244.72])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 07:36:04 -0700
Message-ID: <9c8d38b6de6e3680a7816029f67a150c1786dc4a.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/3] drm/xe: Bump the LRU on a successful page fault
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Date: Fri, 30 Oct 2026 15:35:51 +0100
In-Reply-To: <20261027203107.1065800-2-matthew.brost@intel.com>
References: <20261027203107.1065800-1-matthew.brost@intel.com>
 <20261027203107.1065800-2-matthew.brost@intel.com>
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

On Tue, 2026-10-27 at 13:31 -0700, Matthew Brost wrote:
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

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>



> ---
> =C2=A0drivers/gpu/drm/xe/xe_pagefault.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c
> b/drivers/gpu/drm/xe/xe_pagefault.c
> index 5247321c805e..7d363160103a 100644
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
> @@ -221,6 +223,9 @@ static int xe_pagefault_handle_vma(struct xe_gt
> *gt, struct xe_vma *vma,
> =C2=A0				xe_pagefault_set_error(pf,
> XE_PAGEFAULT_ERROR_VMA_REBIND);
> =C2=A0				break;
> =C2=A0			}
> +
> +			if (bo)
> +				ttm_bo_move_to_lru_tail(&bo->ttm);
> =C2=A0		}
> =C2=A0		xe_validation_ctx_fini(&ctx);
> =C2=A0	} while (err =3D=3D -EAGAIN);
