Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD81C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D276410E742;
	Mon, 28 Sep 2026 03:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KgrgZFuZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F6110E73C;
 Mon, 28 Sep 2026 03:28:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 60E6642D71;
 Mon, 28 Sep 2026 03:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4881F00898;
 Mon, 28 Sep 2026 03:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790566098;
 bh=x5E93TzSV5UZFPjcxA8df3ePrvbelS73tqPIjXO5Dvg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KgrgZFuZd5Vc2K8Tby1QtS1cXfsoZMj7j3qCqml9arxrh6RZ0cgnY3JQmRKHGW5/+
 grtCDBvXp/rHrARc+tpIqcHkHO6+njQNCAlYoGEjoyz9AyM9QzbcoXGJdcPk//feCx
 HFaHlvUBW54eUgeqcIkAh38tKm7t72HcmzY79wYXxrJ82iq3EaJ+hyBxTC9LqLIuRz
 eozyE93xMrdARy/FsmJf2N5gdy2U66LzrscxM8SPdCh6nB9tU0YUTTdPNQSP31zJ/4
 35kOQeHnr5ZEQcwySI89lZ/UOnvM0iF7DxuuW6oykORrAjldY02Dyd4YwkNGau6qYQ
 mF2YjLLRmDX8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10] drm/i915/dg2: Add per-client control for
 Wa_22013059131
To: "Jia Yao" <jia.yao@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260928031341.2958178-1-jia.yao@intel.com>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260928031341.2958178-1-jia.yao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 03:28:17 +0000
Message-Id: <20260928032818.0F4881F00898@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/i915: missing WA_22013059131 in ctx_setparam breaks uAPI for d=
efault context
--

commit 6bbdc7d4f28ec7ac3f465eca7548193f1bf2364e
Author: Jia Yao <jia.yao@intel.com>
Subject: drm/i915/dg2: Add per-client control for Wa_22013059131

This commit introduces a new context parameter I915_CONTEXT_PARAM_WA_220130=
59131
to allow userspace to handle the SLM contention workaround itself. It track=
s the
opt-out per client and latches the value once before any context is submitt=
ed.

Link: https://github.com/intel/compute-runtime/pull/919

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/dr=
m/i915/gem/i915_gem_context.c
> index c58ffa5a8fa6f..2a9141e83936c 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
[ ... ]
> @@ -918,6 +941,15 @@ static int set_proto_ctx_param(struct drm_i915_file_=
private *fpriv,
>  			ret =3D -EINVAL;
>  		break;
> =20
> +	case I915_CONTEXT_PARAM_WA_22013059131:
> +		if (args->size)
> +			ret =3D -EINVAL;
> +		else if (!IS_DG2_G11(i915))
> +			ret =3D -ENODEV;
> +		else
> +			ret =3D set_client_wa_22013059131(fpriv, args->value);
> +		break;
> +

[Severity: High]
Does this missing implementation in ctx_setparam() break the uAPI for the
default context?

The parameter is added here in set_proto_ctx_param(), but it appears to be
missing from ctx_setparam() and i915_gem_context_getparam_ioctl().

Because the default context (id 0) is fully finalized during
i915_gem_context_open(), it is not a proto-context. When userspace attempts
to set this parameter on ctx_id =3D 0, i915_gem_context_setparam_ioctl()
routes the call to ctx_setparam() instead:

i915_gem_context_setparam_ioctl()
   ctx =3D i915_gem_context_lookup(file_priv, args->ctx_id);
   if (ctx) {
       ret =3D ctx_setparam(file_priv, ctx, args);
       ...
   }

Since ctx_setparam() lacks this new case, it will fall through to the
-EINVAL default case, which prevents userspace from configuring this
workaround on the default context as documented.

Additionally, because it is missing from i915_gem_context_getparam_ioctl(),
the new UAPI parameter is strictly write-only and impossible to query.

[ ... ]
> diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
> index 535cb68fdb5c4..a9821e2cc3a26 100644
> --- a/include/uapi/drm/i915_drm.h
> +++ b/include/uapi/drm/i915_drm.h
[ ... ]
> + * any context of the client being submitted for the first time.  A later
> + * request for the opposite value fails with -EINVAL.  Userspace that wa=
nts
> + * to opt out must therefore do so before submitting any work on this fd,
> + * including via the default context (id 0) created on open().
> + *
> + * Note: LSC_CHICKEN_BIT_0_UDW MAXREQS_PER_BANK (bits 39:37) is the
> + * other part of Wa_22013059131 and remains unconditionally programmed
> + * by the kernel regardless of this setting.  DG2-G11 only.
> + */
> +#define I915_CONTEXT_PARAM_WA_22013059131	0x10

[Severity: Low]
Can this documentation be fulfilled if the parameter is rejected for the
default context?

The documentation states that userspace can opt out via the default context
(id 0) created on open, but because the parameter is only handled for
proto-contexts, that ioctl request will fail with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928031341.2958=
178-1-jia.yao@intel.com?part=3D1
