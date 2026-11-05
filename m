Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B1606D807
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLqEjCF0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C0610E142;
	Thu,  5 Nov 2026 16:29:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 975E610E142
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:29:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 68D194021F;
 Thu,  5 Nov 2026 16:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FF61F000C1;
 Thu,  5 Nov 2026 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793896146;
 bh=FS7NzuKqhGQf8iKN0nXEvyDVzrazHLVk+Rk69F2qY8c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YLqEjCF0YJw/TvWVA08HTpJ6dMTBysOBcgX41Ce0SJttCUB7TtUYqNOEI3Nf9RVsV
 MrokDQKXscejhfwg+6WvsmmdoOfmrZqDYSobAQ3AaUQ1/8mNPn9WrXaj6LdZ0/rkR+
 dBWqlJZhUo+jFCPFPQhVXZG9Fw3ABXo7e7xoo9L0OL+7FNtSgN289AC5PVa6t2ZxSS
 U+6Wjx2Pol4F8cPg9lvPRQKXM5Tb7neUL1jsprZYeoqOEMyOOEalV+pn4Iym3iGKuz
 b4ND1UAMPNwEkwaAXLOfDgm+z1zMfy4AM8C3+3ApjQSJ4+ndRppT+m5fs46jk8kK0u
 KagYySUAsnGQQ==
Message-ID: <sashiko-outbox-199496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/27] video/hdmi: Add VTEM EMP packing
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-3-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-3-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:29:05 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] video/hdmi: hdmi_infoframe_pack_only() missing EMP support
- [Medium] video/hdmi: missing bounds and type checks in hdmi_emp_infoframe=
_vtem_pack()
- [Low] video/hdmi: missing @vtem kernel-doc entry in union hdmi_infoframe
--

commit 435f43f92e62fa2ad37ec03ba43478dd2a0e2bba
Author: Derek Foreman <derek.foreman@collabora.com>

video/hdmi: Add VTEM EMP packing

This commit adds structures and helpers to initialize, pack, and log HDMI
Video Timing Extended Metadata (VTEM) Extended Metadata Packets (EMPs) for
Variable Refresh Rate support.

> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> index 45b42f14a7503..ed9abc7ad2285 100644
> --- a/drivers/video/hdmi.c
> +++ b/drivers/video/hdmi.c
> @@ -983,6 +983,10 @@ hdmi_infoframe_pack(union hdmi_infoframe *frame,
>  		length =3D hdmi_vendor_any_infoframe_pack(&frame->vendor,
>  							buffer, size);
>  		break;
> +	case HDMI_INFOFRAME_TYPE_EMP:
> +		length =3D hdmi_emp_infoframe_vtem_pack(&frame->vtem,
> +						      buffer, size);
> +		break;
>  	default:
>  		WARN(1, "Bad infoframe type %d\n", frame->any.type);
>  		length =3D -EINVAL;

[Severity: Medium]
As reported by Sashiko on RFC [1], hdmi_infoframe_pack() handles
HDMI_INFOFRAME_TYPE_EMP, but hdmi_infoframe_pack_only() in
drivers/video/hdmi.c was not updated to handle it:

drivers/video/hdmi.c:hdmi_infoframe_pack_only() {
	switch (frame->any.type) {
	case HDMI_INFOFRAME_TYPE_AVI:
	...
	case HDMI_INFOFRAME_TYPE_VENDOR:
		length =3D hdmi_vendor_any_infoframe_pack_only(&frame->vendor,
							     buffer, size);
		break;
	default:
		WARN(1, "Bad infoframe type %d\n", frame->any.type);
		length =3D -EINVAL;
	}
}

If a driver packs an EMP infoframe stored in union hdmi_infoframe via
hdmi_infoframe_pack_only(), won't it hit the default branch, trigger the
WARN(1), and fail with -EINVAL?

Also, since hdmi_emp_infoframe_vtem_pack() does not modify its vtem
argument, should its parameter be const struct hdmi_emp_infoframe_vtem *
(or have a corresponding _pack_only helper) so hdmi_infoframe_pack_only()
can call it with a const union hdmi_infoframe *?

[ ... ]

> @@ -1919,3 +1951,66 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *fr=
ame,
>  	return ret;
>  }
>  EXPORT_SYMBOL(hdmi_infoframe_unpack);
> +
> +/**
> + * hdmi_emp_infoframe_vtem_init() - initialize an HDMI VTEM EMP
> + * @emp: HDMI VTEM EMP
> + */
> +void hdmi_emp_infoframe_vtem_init(struct hdmi_emp_infoframe_vtem *emp)
> +{
> +	memset(emp, 0, sizeof(*emp));
> +	emp->type =3D HDMI_INFOFRAME_TYPE_EMP;
> +}
> +EXPORT_SYMBOL(hdmi_emp_infoframe_vtem_init);
> +
> +/**
> + * hdmi_emp_infoframe_vtem_pack() - pack a vtem into a binary buffer
> + * @vtem: pointer to &struct hdmi_emp_infoframe_vtem to pack
> + * @buffer: pointer to pre-allocated output buffer
> + * @size: maximum size in bytes of @buffer
> + *
> + * Pack a VTEM infoframe struct into a binary buffer in a way that's sui=
table
> + * to be sent out over the wire.
> + *
> + * Returns the number of bytes packed into the binary buffer or a negati=
ve
> + * error code on failure.
> + */
> +ssize_t hdmi_emp_infoframe_vtem_pack(struct hdmi_emp_infoframe_vtem *vte=
m,
> +				     void *buffer, size_t size)
> +{
> +	u8 *ptr =3D buffer;
> +
> +	if (size < HDMI_INFOFRAME_SIZE(VTEM))
> +		return -EINVAL;
> +
> +	/* 4 bits max */
> +	if (vtem->fva_factor_m1 > 0xF)
> +		return -EINVAL;
> +
> +	memset(buffer, 0, size);
> +
> +	/* Header Data */
> +	ptr[0] =3D vtem->type;
> +	ptr[1] =3D BIT(7) | BIT(6);
> +	ptr[2] =3D 0;
> +
> +	ptr[3] =3D BIT(7) | BIT(2);
> +
> +	ptr[4] =3D 0;
> +	ptr[5] =3D 1;
> +	ptr[6] =3D 0;
> +	ptr[7] =3D 1;
> +	ptr[8] =3D 0;
> +	ptr[9] =3D 4;
> +
> +	/* This is where the VTEM part starts */
> +	ptr[10] =3D (vtem->fva_factor_m1 << 4) |
> +		  (vtem->m_const ? BIT(1) : 0) |
> +		  (vtem->game_vrr_en ? BIT(0) : 0);
> +	ptr[11] =3D vtem->base_vfront;
> +	ptr[12] =3D vtem->base_refresh_rate >> 8 & 0x3;
> +	ptr[13] =3D vtem->base_refresh_rate & 0xFF;
> +
> +	return 14;
> +}
> +EXPORT_SYMBOL(hdmi_emp_infoframe_vtem_pack);

[Severity: Medium]
As reported by Sashiko on RFC [2], hdmi_emp_infoframe_vtem_pack() checks
that vtem->fva_factor_m1 fits in 4 bits and returns -EINVAL if exceeded,
but silently masks the u16 vtem->base_refresh_rate to 10 bits when writing
ptr[12] and ptr[13] instead of rejecting values above 0x3ff. It also
writes ptr[0] =3D vtem->type without verifying that vtem->type is
HDMI_INFOFRAME_TYPE_EMP.

In the DRM HDMI state helper path added later in this series,
drm_atomic_helper_connector_hdmi_check() calls hdmi_validate_vrr(), which
returns early when new_crtc_state->vrr_enabled is false and skips its
refresh rate check, while hdmi_generate_emp_infoframe_vtem() still runs
and sets vtem->base_refresh_rate from drm_mode_vrefresh(&crtc_state->mode)
for non-VIC modes before calling hdmi_infoframe_pack().

Should hdmi_emp_infoframe_vtem_pack() validate that
vtem->base_refresh_rate <=3D 0x3ff and vtem->type =3D=3D HDMI_INFOFRAME_TYP=
E_EMP,
returning -EINVAL on invalid input rather than transmitting a truncated or
malformed packet?

> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> index b80a5ee63bb23..71e2b36896afe 100644
> --- a/include/linux/hdmi.h
> +++ b/include/linux/hdmi.h

[ ... ]

> @@ -457,6 +475,7 @@ union hdmi_infoframe {
>  	union hdmi_vendor_any_infoframe vendor;
>  	struct hdmi_audio_infoframe audio;
>  	struct hdmi_drm_infoframe drm;
> +	struct hdmi_emp_infoframe_vtem vtem;
>  };

[Severity: Low]
This isn't a runtime bug, but union hdmi_infoframe in include/linux/hdmi.h
has a kernel-doc comment block above it (included by
Documentation/gpu/drm-kms-helpers.rst):

include/linux/hdmi.h:
/**
 * union hdmi_infoframe - overall union of all abstract infoframe represent=
ations
 * @any: generic infoframe
 * @avi: avi infoframe
 * @spd: spd infoframe
 * @vendor: union of all vendor infoframes
 * @audio: audio infoframe
 * @drm: Dynamic Range and Mastering infoframe

Should an @vtem entry be added to the kernel-doc comment for union
hdmi_infoframe to avoid a scripts/kernel-doc warning during W=3D1 or
htmldocs builds?

[1] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-4-2fcd7d011646@c=
ollabora.com
[2] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-4-2fcd7d011646@c=
ollabora.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D3
