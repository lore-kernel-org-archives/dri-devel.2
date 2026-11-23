Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1E606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FDlwG7aK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A4310E75E;
	Mon, 23 Nov 2026 08:49:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068EC10E75A;
 Mon, 23 Nov 2026 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795423759; x=1826959759;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=VDqfNAPy2JKnA+2i2Uf52316VUmvieSrk/qcFA0i+U0=;
 b=FDlwG7aKlpogFc1ouf7kqgg6+lIBnioH8icTS6/KL6FpEXpBXrHhSQta
 smgeit2pFDbiVpY3fGl1TcsD2bBEAzWrr+Api3BGWHBa1SB8KqCjWt+c4
 nTeemvm03mzlAJs/FZuZ+JkLxELzCTKzpqkNoN5DKnNptHM+rH/7yvh/5
 8OVm6df60rFPpd61OHOthR0yOu1kjOWnHsNdFWcq+XrxeRAjiNFIIJAlF
 G2CqJPJ7+fF00M0PnoDQKdMh98s5J4AxHYbazvY7S1jBzkr+wr5D3wrhx
 8DhSIgwWC9P1YkUidXCrtvzEr0U+3uX2RbU19c4SyE2NYDrm8kmsUs1bf Q==;
X-CSE-ConnectionGUID: Yw9rJDtKRGC6SjqiBdCuHw==
X-CSE-MsgGUID: tG6IAUJ/T3KePNGFS288mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4124630"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4124630"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 00:49:19 -0800
X-CSE-ConnectionGUID: 53nR6vN8RIOQLC9WAMKPyQ==
X-CSE-MsgGUID: M+4leTqeQEeILi+di3OUFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11582492"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.224])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 00:49:16 -0800
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261121071713.335337-1-haoxiang_li2024@163.com>
References: <20261121071713.335337-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH v2] drm/i915/vma: Fix a memory leak in i915_vma_pin_ww()
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>,
 Andi Shyti <andi.shyti@linux.intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, airlied@gmail.com,
 andi.shyti@kernel.org, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 simona@ffwll.ch, tursulin@ursulin.net
Date: Mon, 23 Nov 2026 10:49:12 +0200
Message-ID: <179542375283.27957.3540837456636790784@jlahtine-mobl>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Quoting Haoxiang Li (2026-11-21 09:17:13)
> The memory allocated by i915_vma_work() is not freed if
> i915_gem_object_get_moving_fence() fails. Change the
> goto label to do so.

That's better.

You still did not touch the title of the patch, however.
If feedback is given to you, do not submit a new version
without confirming that you addressed all parts of it.
Consider this the last notice before getting ignored.

What you have is a memory leak on error path without any
assessment about if that error path is possible to hit.

Please realize your LLM is very eager to over-state
the impact of any findings. It's your responsibility to
understand the impact and write the commit description
and title accordingly.

> Fixes: 8ec5c0006c50 ("Merge tag 'drm-intel-next-2022-05-20' of git://anon=
git.freedesktop.org/drm/drm-intel into drm-intel-gt-next")

You should just re-create the merge conflict and check which
two patches conflicted. While it's within possibility that
the merge commit itself summoned the error handling code
from thin air as a trivial 'git blame' might show. It's not
very likely, so needs to be looked into.

Regards, Joonas

> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
> Changes in v2:
>  - Modify the commit message. Thanks, Andi!
> ---
>  drivers/gpu/drm/i915/i915_vma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_=
vma.c
> index 16782d8579a8..4ba1c9ea5ecb 100644
> --- a/drivers/gpu/drm/i915/i915_vma.c
> +++ b/drivers/gpu/drm/i915/i915_vma.c
> @@ -1470,7 +1470,7 @@ int i915_vma_pin_ww(struct i915_vma *vma, struct i9=
15_gem_ww_ctx *ww,
> =20
>                 err =3D i915_gem_object_get_moving_fence(vma->obj, &movin=
g);
>                 if (err)
> -                       goto err_rpm;
> +                       goto err_fence;
> =20
>                 dma_fence_work_chain(&work->base, moving);
> =20
> --=20
> 2.25.1
>
