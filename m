Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA28EC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258D810EC35;
	Tue, 22 Sep 2026 10:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TzFLh9ua";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0F410E6C1;
 Tue, 22 Sep 2026 10:28:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 44A48400E8;
 Tue, 22 Sep 2026 10:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000E41F000FF;
 Tue, 22 Sep 2026 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790072883;
 bh=Jy5kGophIVujwoeUqnqMDz6m+cBQGP+RWjzN4gWBIAg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TzFLh9uauEdkfkvAAzB99FhpI8LbmE3Eb0zCWLOEc+luZK4sYMW7PuwqE15scXhaL
 ml730tiAjWbJUOsjlvCDnh2uU92Xrj+NsF90tN6R3PbUQpBU7NcHsPSAmPQHccPywj
 gM4rwGwuHhpPecRvbVlQvHk/62xvOnvYtpMGBEW3KoFNNz5TUAzkw1s+FXpoWT5jMg
 jxWtA7wrMl9QHgoHyiilXvzDRivbfqfX67znxTJH0fhGiJq2Nh2T9qHF9/rr95gPH5
 1enLVtPJdVsxUL/da0kII/OpNJ6KcLJNwIJI+PWqNmRUQtofX6WxHy22C0khjB+iPt
 MSd91lzA0ZIaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/15] drm/xe: Protect device I/O with DRM device SRCU
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260922101721.1583542-5-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
 <20260922101721.1583542-5-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:28:02 +0000
Message-Id: <20260922102803.000E41F000FF@smtp.kernel.org>
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
- [High] drm/xe: hardware forcewake drop outside IO protection in send_tlb_=
inval_ggtt()
--

commit e9f023cf84d9700d7a5ded726d95cff381241557
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe: Protect device I/O with DRM device SRCU

This commit introduces wrappers around DRM device SRCU to protect device
I/O operations. It blocks new access during PCI recovery or when the
device is wedged, and drains existing hardware users to safely isolate
the device.

> diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/xe/x=
e_guc_tlb_inval.c
> --- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c

[ ... ]

> @@ -86,8 +84,13 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval *tl=
b_inval, u32 seqno)
>  	} else if (xe_device_uc_enabled(xe)) {
>  		struct xe_mmio *mmio =3D &gt->mmio;
> =20
> -		if (IS_SRIOV_VF(xe))
> +		if (xe_device_io_get(xe, &io_idx))
> +			return -ECANCELED;
> +
> +		if (IS_SRIOV_VF(xe)) {
> +			xe_device_io_put(io_idx);
>  			return -ECANCELED;
> +		}
> =20
>  		CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FW_GT);
>  		if (xe->info.platform =3D=3D XE_PVC || GRAPHICS_VER(xe) >=3D 20) {
> @@ -99,6 +102,8 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval *tl=
b_inval, u32 seqno)
>  			xe_mmio_write32(mmio, GUC_TLB_INV_CR,
>  					GUC_TLB_INV_CR_INVALIDATE);
>  		}
> +
> +		xe_device_io_put(io_idx);

[Severity: High]
Does this code drop the I/O protection before the scoped forcewake destruct=
or
runs?

The CLASS(xe_force_wake, fw_ref) macro creates a scoped guard whose destruc=
tor
executes when leaving the block. Because xe_device_io_put(io_idx) is called
explicitly right before the closing brace, the I/O protection is released
before the forcewake destructor runs.

If PCI error recovery or wedge isolation disables the device immediately af=
ter
xe_device_io_put() returns, the automatically executing fw_ref destructor w=
ill
perform MMIO writes on a disabled device. This could trigger a PCI Advanced
Error Reporting (AER) fault and crash the system.

>  	}
> =20
>  	return -ECANCELED;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922101721.1583=
542-1-arvind.yadav@intel.com?part=3D4
