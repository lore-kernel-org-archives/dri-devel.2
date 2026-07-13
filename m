Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A69AC44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8101F10E877;
	Mon, 13 Jul 2026 08:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UXyMzKec";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16A310E875
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:54:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 345DE600FC;
 Mon, 13 Jul 2026 08:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5F81F000E9;
 Mon, 13 Jul 2026 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783932865;
 bh=Dc3ldH8WKQOjoqDRMdsgukNkoLTfPjmP/BLzsng3n/g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UXyMzKecjIUUDT1DsQrkzf0giXJI15AD3kjCCtD4fWync4LL8FFlo6SHqeRQRhWuo
 iIDhKhCIi5XhNJvRop8uLukWykpGqyXEqC6EUfLZ1WfFy85WHBRgUV12QXLyYLBkUc
 +cHc1zfa8L7SYyJrfXKKs+EjuRC/5YIdpWQoRMBNGc4gUnpgAdEOBQxqzloFa7w7Aw
 d75VC0HBQtkfyu4nhHJWIes/n87Rya86GXGlUeiO5RDfT86ILlfFSjM2Lux7E7fJwa
 JpAEh3ZqmRb6mOU+3DUiuH3YtN1DmlcGh6LdnBPh7MgzMh4hKV3tg8Don0lTze/9Pg
 kuT+k0k4gBeCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/4] drm/xe/xe_ras: Do not Review, compilation only.
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713083939.251872-7-mallesh.koujalagi@intel.com>
References: <20260713083939.251872-6-mallesh.koujalagi@intel.com>
 <20260713083939.251872-7-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:54:25 +0000
Message-Id: <20260713085425.BF5F81F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Hardware/firmware error payload structures use non-portable C bi=
tfields and host-native integer types instead of explicitly sized little-en=
dian types.
- [Low] The newly added function `handle_soc_internal_errors` is marked as =
`__maybe_unused`, has no callers, and contains incomplete PUNIT error handl=
ing.
--

--- Patch [1]: [PATCH v10 1/4] drm/xe/xe_ras: Do not Review, compilation on=
ly. ---
commit 8b53e475734bf697402ee545f94eb93bf4f28f2b
Author: Riana Tauro <riana.tauro@intel.com>

drm/xe/xe_ras: Do not Review, compilation only.
   =20
DO NOT REVIEW. COMPILATION ONLY
This patch is from https://patchwork.freedesktop.org/series/160482/
Added only for Compilation.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 74d5016d9ffe7..3d39bb95e94d6 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
[ ... ]
> @@ -193,6 +194,48 @@ static void ras_usp_aer_init(struct xe_device *xe)
>  	dev_dbg(&usp->dev, "Uncorrectable Internal Errors downgraded and unmask=
ed\n");
>  }
> =20
> +static __maybe_unused enum xe_ras_recovery_action
> +handle_soc_internal_errors(struct xe_device *xe,
> +			   struct xe_ras_error_array *arr)

[Severity: Low]
Does this introduce dead, incomplete code into the tree?

This function is marked __maybe_unused, has no callers, and contains an
incomplete PUNIT error handling TODO below.

> +{
> +	struct xe_ras_soc_error *info =3D (void *)arr->details;
> +	struct xe_ras_soc_error_source *source =3D &info->source;

[Severity: Medium]
Can this cause misinterpretation of firmware error messages on big-endian
architectures?

This code reads firmware values via the bitfield struct without endianness
conversion. The hardware/firmware error payload structures are defined using
non-portable C bitfields and host-native integer types instead of explicitly
sized little-endian types.

Using C bitfields inside __packed structs for hardware/firmware interface
definitions relies on compiler-specific bit-packing rules. Explicitly sized
little-endian types (e.g., __le32) and bitwise macros (like FIELD_GET())
should probably be used to parse these hardware structures.

> +	struct xe_ras_error_class *counter =3D &arr->counter;
> +
> +	if (source->csc) {
> +		struct xe_ras_csc_error *csc_error =3D (void *)info->details;
[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ra=
s_types.h
> index 6688e11f57a86..3c165096ea20c 100644
> --- a/drivers/gpu/drm/xe/xe_ras_types.h
> +++ b/drivers/gpu/drm/xe/xe_ras_types.h
[ ... ]
> +/**
> + * struct xe_ras_soc_error_source - Source of SoC error
> + */
> +struct xe_ras_soc_error_source {
> +	/** @csc: CSC */
> +	u32 csc:1;
> +	/** @ieh: IEH (Integrated Error Handler) */
> +	u32 ieh:1;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved:30;
> +} __packed;

[Severity: Medium]
Will this bitfield layout work correctly across different architectures?

This struct defines hardware/firmware error source flags using brittle C
bitfields. As noted above, relying on compiler-specific bit-packing inside
__packed structs for hardware interfaces can lead to issues.

[ ... ]
> +/**
> + * struct xe_ras_ieh_error - SoC IEH (Integrated Error Handler) error de=
tails
> + */
> +struct xe_ras_ieh_error {
> +	/** @ieh_instance: IEH instance */
> +	u32 ieh_instance:2;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved:30;
> +	/** @global_error_status: Global error status */
> +	u32 global_error_status;
> +	/** @local_error_status: Local error status */
> +	u32 local_error_status;
> +	/** @gerr_mask: Global error mask */
> +	u32 gerr_mask;
> +	/** @info: Additional information */
> +	u32 info[10];
> +} __packed;

[Severity: Medium]
Could this bitfield layout be problematic for similar reasons?

This struct defines hardware/firmware IEH error layout using C bitfields and
host-native types instead of explicitly sized little-endian types.

>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713083939.2518=
72-6-mallesh.koujalagi@intel.com?part=3D1
