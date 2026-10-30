Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6FD606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVTzqGwJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977CA11269A;
	Fri, 30 Oct 2026 08:59:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724DA11269A;
 Fri, 30 Oct 2026 08:59:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A6CD76062C;
 Fri, 30 Oct 2026 08:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208AD1F000C1;
 Fri, 30 Oct 2026 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793350768;
 bh=DjsLu27sM2VRZaJxIbNKB44m9ASFAjr9VnDZ5u8MZDM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=SVTzqGwJBeZpT3gRqIJfg+Z9Ke/pbE0Lipz6xojzne2eGFibmcJTbzC8ELJ2nPZPe
 D+lB23QpMgb0inaudXC4taMNQ/VLziunT4qmXhmfHP5OYk7Glg7NpHgJIyaYOr/BJn
 VeKh1KVnUc3dat70KpJh2PdilF6lneH2Xursyyk8zBgiOVU5N4vodPOL+uZds3hyUw
 caKsA6jxaAjyMVbSzHpsHSYjaU2cBGPbeoIfHyJbPxVTvHmEZwIyMKkIgNBIBRxAIS
 AKX+scj2OWZxeCs+KLahWK/aacoSHz8LvkNq8guI/8EVFJLBHhsgo4IyOt70+77oQi
 NqLllCcdpqLGg==
Message-ID: <sashiko-outbox-190725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/gt: Use VCS instead of VECS for GuC error
 capture on Gen 12
To: "Krzysztof Karas" <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261030083948.131717-1-krzysztof.karas@intel.com>
References: <20261030083948.131717-1-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 08:59:27 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/i915/guc: invalid SFC_DONE[0..3] capture list moved to VIDEO c=
lass
- [Low] drm/i915/guc: stale VEC naming and comment on xe_lp_vec_class_regs
--

commit 6562e410f725dfa5df84099db24c4e525c8d180e
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drm/i915/gt: Use VCS instead of VECS for GuC error capture on Gen 12

This patch moves the xe_lp_vec_class_regs GuC error capture register list
containing GEN12_SFC_DONE(0..3) from GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE to
GUC_CAPTURE_LIST_CLASS_VIDEO in xe_lp_lists[].

> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c b/drivers/gpu=
/drm/i915/gt/uc/intel_guc_capture.c
> index 865b61057566d..bbf5188ae46cd 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
> @@ -187,9 +187,9 @@ static const struct __guc_mmio_reg_descr_group xe_lp_=
lists[] =3D {
>  	MAKE_REGLIST(xe_lp_global_regs, PF, GLOBAL, 0),
>  	MAKE_REGLIST(xe_lp_rc_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CL=
ASS_RENDER_COMPUTE),
>  	MAKE_REGLIST(gen8_rc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_C=
LASS_RENDER_COMPUTE),
> -	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
VIDEO),
> +	MAKE_REGLIST(xe_lp_vec_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_C=
LASS_VIDEO),

[Severity: High]
Does moving xe_lp_vec_class_regs to GUC_CAPTURE_LIST_CLASS_VIDEO shift the
partial-capture regression from VECS engines to VCS engines on Gen12+
platforms?

During ADS initialization in
guc_capture_prep_lists()->intel_guc_capture_getlist()->guc_capture_list_ini=
t(),
GUC_CAPTURE_LIST_CLASS_VIDEO is populated with xe_lp_vec_class_regs, which
statically expands COMMON_GEN12BASE_VEC with all four SFC_DONE instances:

drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c:
#define COMMON_GEN12BASE_VEC \
	{ GEN12_SFC_DONE(0),        0,      0, "SFC_DONE[0]" }, \
	{ GEN12_SFC_DONE(1),        0,      0, "SFC_DONE[1]" }, \
	{ GEN12_SFC_DONE(2),        0,      0, "SFC_DONE[2]" }, \
	{ GEN12_SFC_DONE(3),        0,      0, "SFC_DONE[3]" }

As shown in gt_record_global_regs() and err_print_gt_global() in
drivers/gpu/drm/i915/i915_gpu_error.c, each GEN12_SFC_DONE(i) instance
resides in the corresponding even VDBOX forcewake domain and only exists
when both sfc_mask and the corresponding _VCS(i * 2) engine are present:

drivers/gpu/drm/i915/i915_gpu_error.c:gt_record_global_regs() {
	...
		for (i =3D 0; i < I915_MAX_SFC; i++) {
			/*
			 * SFC_DONE resides in the VD forcewake domain, so it
			 * only exists if the corresponding VCS engine is
			 * present.
			 */
			if ((gt->_gt->info.sfc_mask & BIT(i)) =3D=3D 0 ||
			    !HAS_ENGINE(gt->_gt, _VCS(i * 2)))
				continue;

			gt->sfc_done[i] =3D
				intel_uncore_read(uncore, GEN12_SFC_DONE(i));
		}
	...
}

Across the Gen12+ platforms in drivers/gpu/drm/i915/i915_pci.c (TGL, RKL,
DG1, ADL-S, ADL-P, DG2, and MTL), VCS4 (i =3D 2, 0x1ce000) and VCS6 (i =3D =
3,
0x1cf000) do not exist, and on single-VCS platforms such as DG1 and RKL (or
fused SKUs), VCS2 (i =3D 1, 0x1cd000) does not exist either. Because
xe_lp_vec_class_regs is a static table that is not filtered by sfc_mask and
HAS_ENGINE(gt, _VCS(i * 2)), when a VCS engine hangs and triggers GuC error
capture, won't GuC fail to read the non-existent SFC_DONE instances and flag
the VIDEO capture group with GUC_STATE_CAPTURE_GROUP_TYPE_PARTIAL?

Note that in the empirical test described in the patch notes (where only the
class of the existing xe_lp_vec_class_regs entry was changed without
removing the earlier entries in xe_lp_lists[]), guc_capture_get_one_list()
scans from the beginning of reglists[] and returns the first match:

drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c:guc_capture_get_one_list() {
	...
	for (i =3D 0; reglists[i].list; ++i) {
		if (reglists[i].owner =3D=3D owner && reglists[i].type =3D=3D type &&
		    (reglists[i].engine =3D=3D id || reglists[i].type =3D=3D GUC_CAPTURE_=
LIST_TYPE_GLOBAL))
			return &reglists[i];
	}
	return NULL;
}

When the later xe_lp_vec_class_regs entry was changed to
GUC_CAPTURE_LIST_CLASS_RENDER_COMPUTE or GUC_CAPTURE_LIST_CLASS_VIDEO, the
earlier entries in xe_lp_lists[] (xe_lp_rc_class_regs for RENDER_COMPUTE and
empty_regs_list for VIDEO) matched first and shadowed xe_lp_vec_class_regs,
whereas replacing empty_regs_list directly in this patch makes
xe_lp_vec_class_regs active for GUC_CAPTURE_LIST_CLASS_VIDEO.

>  	MAKE_REGLIST(gen8_vd_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_C=
LASS_VIDEO),
> -	MAKE_REGLIST(xe_lp_vec_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_C=
LASS_VIDEOENHANCE),
> +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
VIDEOENHANCE),

[Severity: Low]
This isn't a bug, but since xe_lp_vec_class_regs is moved from
GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE to GUC_CAPTURE_LIST_CLASS_VIDEO, its
definition and comment in drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
still describe it as Video Enhancement (vec) rather than matching the vd
naming used for GUC_CAPTURE_LIST_CLASS_VIDEO:

/* XE_LP Video Enhancement Per-Class */
static const struct __guc_mmio_reg_descr xe_lp_vec_class_regs[] =3D {
	COMMON_GEN12BASE_VEC,
};

Should COMMON_GEN12BASE_VEC, xe_lp_vec_class_regs, and the accompanying
comment be updated if this list is associated with the VIDEO class?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030083948.1317=
17-1-krzysztof.karas@intel.com?part=3D1
