Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F22606B5B6
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lwGoNPc9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FE111201B;
	Thu, 12 Nov 2026 11:23:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99FD611201B;
 Thu, 12 Nov 2026 11:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794482594; x=1826018594;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=oCEXJdSBu0sBqVwfe6KtgmmsBeajZYHo1Sigs6B7iTE=;
 b=lwGoNPc9fGDZQORy0TGEgKOJxZLdCZSsOTs1NwEz2YPH0wHmhUyL06H0
 8D2BeT2b6pQyeTLBUgsF3IkPHDMv8OG6QCjIxqNd9ss86tGEe5X7/0Bs/
 j++hb6OD3QVzEDmzfkQdfaA9hN3PX+VLT0J6zL4j2lhTZB4X9szssX7TN
 STgZerRi4sI1dUbb67wK/iVIOEN9C/5ILZQubaZQ7W4JS6dxDAJSBaQHi
 luJP77tI3CpMmHqQXZXv6YkBdSHxEarZumJPfrwRGAC2qQpBRIauOmroL
 aLpsuha+1W3utPHQCX6kHae43Ng6th9a4l1qDWwLK/5GB7GTyAlCJ3REQ g==;
X-CSE-ConnectionGUID: P861hUO8Ta2FkS/RjBzVVA==
X-CSE-MsgGUID: ys75R2eAQaWYi4JN9E0C7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3165223"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3165223"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 03:23:13 -0800
X-CSE-ConnectionGUID: B15s/dr8S7KJdnCUZFC03A==
X-CSE-MsgGUID: WcjnfbjuSOel+AblYf8HvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8949302"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.169])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 03:23:11 -0800
Message-ID: <dae37984a779ec00c72497ca7bf116dd38b3da43.camel@linux.intel.com>
Subject: Re: [PATCH v2] drm/i915/gt: Adjust usage of SFC_DONE registers on
 Gen 12
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Andi Shyti
 <andi.shyti@linux.intel.com>,  Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Thu, 12 Nov 2026 12:23:08 +0100
In-Reply-To: <20261105071426.1159739-1-krzysztof.karas@intel.com>
References: <20261105071426.1159739-1-krzysztof.karas@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
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

Hi Krzysztof,

On Thu, 2026-11-05 at 07:14 +0000, Krzysztof Karas wrote:
> Initial, empty XE_LPD register list for Video-Enhance class was
> introduced in [1] until [2] filled it out with debug SFC_DONE
> entries, but it was never explained in any of those commits why
> using those registers for VECS class specifically was chosen.
> Furthermore, currently, it is seen as a regression [3].
>=20
> Currently, gem_exec_capture@capture@vecs0-smem runs report
> partial captures on DG1, DG2 and MTL [4].
> SFC_DONE resides in the VD forcewake domain and is available
> only when the corresponding VCS engine is present (explanation
> from [5]), but XE_LP capture table currently associates these
> registers with VIDEOENHANCE.
>=20
> Furthermore, GuC firmware supports SFC_DONE registers in error
> capture only for MTL platforms, DG1/DG2 are not included, which
> was confirmed with experimentation and offline discussion with
> GuC side.

Since that's highly GuC related, I think you should also Cc: / ask for=C2=
=A0
review someone from=C2=A0GuC integration developers team directly, e.g.,=C2=
=A0
Daniele=C2=A0Ceraolo Spurio,=C2=A0Alan Previn or Umesh Nerlige Ramappa, may=
be
others,=C2=A0not=C2=A0only i915 core.

Thanks,
Janusz

>=20
> Make a new list of register lists for MTL and use SFC_DONE
> entries only when that platform is detected. For DG1/DG2 pass
> an empty list for VECS class.
>=20
> [1] commit 24492514ccbd
>     ("drm/i915/guc: Update GuC ADS size for error capture lists")
> [2] commit 8b72c21618de
>     ("drm/i915/guc: Add XE_LP static registers for GuC error capture.")
> [3] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16904
> [4] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?testfilter=3Digt@=
gem_exec_capture@capture@vecs0-smem
> [5] commit 24d032e2359e
>     ("drm/i915: Only access SFC_DONE when media domain is not fused off")
>=20
> Fixes: 8b72c21618de ("drm/i915/guc: Add XE_LP static registers for GuC er=
ror capture.")
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v2:
>  * Changed commit title (was "drm/i915/gt: Use VCS instead of
>    VECS for GuC error capture on Gen 12") and commit
>    description;
>  * Enabled SFC_DONE on MTL's VCS engines and disabled these
>    registers on DG1/DG2;
>  * Added a new list for MTL;
>  * Renamed relevant objects vec -> vc.
>=20
> I could not verify when exactly the issue started happening,
> because:
> A) all recent reports are red on DG1, DG2 and MTL,
> B) checking for "partial-capture" in IGT [6] was introduced way
>    later than the driver code asking for SFC_DONE registers.
> I assume it has been present for at least a few months, if not
> from the very beginning.
>=20
> [6] commit 93d3b0e28d7d
>     ("tests/intel/gem_exec_capture: Check for partial register captures")
> ---
>  .../gpu/drm/i915/gt/uc/intel_guc_capture.c    | 33 +++++++++++++++----
>  1 file changed, 27 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c b/drivers/gpu=
/drm/i915/gt/uc/intel_guc_capture.c
> index 865b61057566..88e6d706210c 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
> @@ -88,7 +88,7 @@
>  	{ GEN12_SC_INSTDONE_EXTRA,  0,      0, "GEN12_SC_INSTDONE_EXTRA" }, \
>  	{ GEN12_SC_INSTDONE_EXTRA2, 0,      0, "GEN12_SC_INSTDONE_EXTRA2" }
> =20
> -#define COMMON_GEN12BASE_VEC \
> +#define COMMON_GEN12BASE_VC \
>  	{ GEN12_SFC_DONE(0),        0,      0, "SFC_DONE[0]" }, \
>  	{ GEN12_SFC_DONE(1),        0,      0, "SFC_DONE[1]" }, \
>  	{ GEN12_SFC_DONE(2),        0,      0, "SFC_DONE[2]" }, \
> @@ -117,9 +117,9 @@ static const struct __guc_mmio_reg_descr gen8_vd_inst=
_regs[] =3D {
>  	COMMON_BASE_ENGINE_INSTANCE,
>  };
> =20
> -/* XE_LP Video Enhancement Per-Class */
> -static const struct __guc_mmio_reg_descr xe_lp_vec_class_regs[] =3D {
> -	COMMON_GEN12BASE_VEC,
> +/* XE_LP Video Per-Class */
> +static const struct __guc_mmio_reg_descr xe_lp_vc_class_regs[] =3D {
> +	COMMON_GEN12BASE_VC,
>  };
> =20
>  /* GEN8+ Video Enhancement Per-Engine-Instance */
> @@ -189,7 +189,22 @@ static const struct __guc_mmio_reg_descr_group xe_lp=
_lists[] =3D {
>  	MAKE_REGLIST(gen8_rc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_C=
LASS_RENDER_COMPUTE),
>  	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
VIDEO),
>  	MAKE_REGLIST(gen8_vd_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_C=
LASS_VIDEO),
> -	MAKE_REGLIST(xe_lp_vec_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_C=
LASS_VIDEOENHANCE),
> +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
VIDEOENHANCE),
> +	MAKE_REGLIST(gen8_vec_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_=
CLASS_VIDEOENHANCE),
> +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
BLITTER),
> +	MAKE_REGLIST(gen8_blt_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_=
CLASS_BLITTER),
> +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
GSC_OTHER),
> +	MAKE_REGLIST(xe_lp_gsc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST=
_CLASS_GSC_OTHER),
> +	{}
> +};
> +
> +static const struct __guc_mmio_reg_descr_group mtl_lists[] =3D {
> +	MAKE_REGLIST(xe_lp_global_regs, PF, GLOBAL, 0),
> +	MAKE_REGLIST(xe_lp_rc_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CL=
ASS_RENDER_COMPUTE),
> +	MAKE_REGLIST(gen8_rc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_C=
LASS_RENDER_COMPUTE),
> +	MAKE_REGLIST(xe_lp_vc_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CL=
ASS_VIDEO),
> +	MAKE_REGLIST(gen8_vd_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_C=
LASS_VIDEO),
> +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
VIDEOENHANCE),
>  	MAKE_REGLIST(gen8_vec_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_=
CLASS_VIDEOENHANCE),
>  	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
BLITTER),
>  	MAKE_REGLIST(gen8_blt_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_=
CLASS_BLITTER),
> @@ -354,7 +369,13 @@ guc_capture_get_device_reglist(struct intel_guc *guc=
)
>  	struct drm_i915_private *i915 =3D guc_to_i915(guc);
>  	const struct __guc_mmio_reg_descr_group *lists;
> =20
> -	if (GRAPHICS_VER(i915) >=3D 12)
> +	if (IS_METEORLAKE(i915))
> +		/**
> +		 * MTL is the only member of Gen 12 with SFC_DONE registers supported =
by
> +		 * error capture in GuC firmware, so use a separate list of registers =
there.
> +		 */
> +		lists =3D mtl_lists;
> +	else if (GRAPHICS_VER(i915) >=3D 12)
>  		lists =3D xe_lp_lists;
>  	else
>  		lists =3D gen8_lists;
