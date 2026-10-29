Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC8606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfJSQshx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0E91123A4;
	Thu, 29 Oct 2026 15:03:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63FD4112390
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:03:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2C3760219
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4130A1F01825;
 Thu, 29 Oct 2026 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793286208;
 bh=PzHnd//43ugYduCLk0TZonVsouUifb0pqSNzoJiNCQE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XfJSQshxdAaIdgc3pIfxY5+LKsk73meWhr0v0pX8QM/49GYie5ymz4jc3ctyKNNFT
 DFpjtXpTKnyauirRuc96xk4mdwAJrvxoBpLc50tEFGkMZtDlSX0FC0yLb3OFOqgieF
 RacC9uAjhkHpRU0MexMDlJOyxNM2Xx7svF239uC14xiPyoQUIc1vM2jgylcMn+UIle
 Z5bVal39aSQXtXN0WU69dcGpMhPb/B1lHESRYuGuRBIlCy9ryG/kFupQxI7/cNJ9Ny
 3PRvsQLl7sb6SJ7HJJfHRKmiHe2Ctu70my4tYfnvCu/jcjjJg68jfc3kjftI4LBYIo
 IUzb+K4jAGn1g==
Message-ID: <sashiko-outbox-189570@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 27/31] accel: ethosu: Validate OFM transpose
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-ethosu-fixes-v4-27-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-27-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:03:27 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] accel: ethosu: missing NHCWB16 format rejection when OFM trans=
pose is enabled
--

commit aeae30d6b3e02156421eb2fa71edc03fce2b6adf
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Validate OFM transpose

This commit adds validation and dimension permutation for Ethos-U85 output
feature map (OFM) transposition in the command stream validator.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 04c0de8336cd1..fe6bf1a2f8cb2 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c

[ ... ]

> @@ -1000,8 +1054,19 @@ static int ethosu_gem_cmdstream_copy_and_validate(=
struct drm_device *ddev,
>  		case NPU_SET_OFM_PRECISION:
>  			if (((param >> 6) & 0x3) > 1)
>  				return -EINVAL;
> -			if (!ethosu_is_u65(edev) && (param & GENMASK(13, 11)))
> -				return -EINVAL;
> +			if (!ethosu_is_u65(edev)) {
> +				u32 transpose =3D FIELD_GET(NPU_OFM_TRANSPOSE_MASK, param);
> +
> +				switch (transpose) {
> +				case 4:
> +				case 5:
> +					return -EINVAL;
> +				}
> +				if (transpose && ((param >> 1) & 0x3) =3D=3D 3)
> +					return -EINVAL;
> +				if ((param >> 14) =3D=3D 2 && transpose)
> +					return -EINVAL;
> +			}
>  			st.ofm.precision =3D param;
>  			break;

[Severity: Critical]
Should ethosu_gem_cmdstream_copy_and_validate() also reject non-zero
transpose when the activation format in NPU_SET_OFM_PRECISION is NHCWB16
(((param >> 6) & 0x3) =3D=3D 1)?

On Ethos-U85, OFM transposition is only valid with the linear NHWC format.
If a command stream specifies both NHCWB16 (((param >> 6) & 0x3) =3D=3D 1) =
and
a non-zero transpose in NPU_SET_OFM_PRECISION:

1. feat_matrix_size() -> feat_matrix_permute() permutes x, y, and c into
   the transposed coordinates.

2. feat_matrix_length() -> feat_matrix_validate() checks:

	format =3D (fm->precision >> 6) & 0x3;
	stride_cmd =3D feat_matrix_base_cmd(type) + (format ? 6 : 4);
	if (!cmd_state_reg_is_set(st, stride_cmd))
		return -EINVAL;

   which only requires NPU_SET_OFM_STRIDE_C to be set when format is 1,
   leaving NPU_SET_OFM_STRIDE_X unvalidated.

3. feat_matrix_length() then computes the region size using the NHCWB16
   brick address calculation on the already-permuted x and c coordinates:

	case 1: //nhcwb16:
		element_size =3D BIT((fm->precision >> (ofm ? 1 : 2)) & 0x3);

		/* NHCWB16 accesses the complete final channel brick. */
		if (check_mul_overflow(c / 16, (u64)fm->stride_c, &offset) ||
		    check_add_overflow(addr, offset, &addr) ||
		    check_mul_overflow(16 * x + 15, element_size, &offset) ||
		    check_add_overflow(addr, offset, &addr))
			return U64_MAX;
		break;

Can this cause feat_matrix_length() to underestimate
info->region_size[fm->region] (for example, by permuting a large width into
c while fm->stride_c is 0) and allow out-of-bounds DMA writes past the end
of the GEM buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-ethosu-fix=
es-v4-0-4aa25e22578e@kernel.org?part=3D27
