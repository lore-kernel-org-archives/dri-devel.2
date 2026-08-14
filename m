Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02CDC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E85110E492;
	Fri, 14 Aug 2026 08:17:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hj03Bjhm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC1A10E492
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 08:17:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 337C343303;
 Fri, 14 Aug 2026 08:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB7D1F000E9;
 Fri, 14 Aug 2026 08:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786695436;
 bh=usM3qXsMmTILRYfMI3HWBsUNaN6t6/G7Zurdz3PDKgM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hj03BjhmxILlvkYIl0WJxgLY2651INPc5QkNBSoVSZiewJajUld17+7MtT/actnoD
 I7wwQEDYv+YXURnvYLVn5d8xeby7RD7eqporRlR44eh3zFhoPofdAVoswAnK6WYIGx
 FxUJYf54+LeQvE39kZc7e+o4qamGSm9ZmjbNs+muwpzHa6exCVveLRCgGtyb9zfi13
 NyD4AHnQkOokyF0ieARGq9mgM4OqbGwtZOAv33gHf5Vrs+H6FVU8G6l72sy8NrngHb
 NeeBv3SNi/dHq5g5a9LBBrfQBexvlSXBM69XtkOZAyuXX5V8r5KmMvBt0cfiRK6Ptz
 15ZIstzq/w5qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/nouveau: validate legacy BIT table bounds
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814080335.22263-1-pengpeng@iscas.ac.cn>
References: <20260814080335.22263-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 08:17:11 +0000
Message-Id: <20260814081715.DEB7D1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Nested VBIOS table pointers parsed from BIT payloads lack bounds c=
hecks before dereference.
--

--- Patch [1]: [PATCH v2] drm/nouveau: validate legacy BIT table bounds ---
commit 3d3dd9aae1a602cb536b23bfafdac9694396793b
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/nouveau: validate legacy BIT table bounds

The legacy BIT parser finds the BIT signature and then reads the
entry shape and entry array directly from the VBIOS image. The signature
does not prove that the complete header, entry array or referenced table
payload fits in the image.

Validate each extent before use. Preserve the legacy zero-offset meaning
for zero-length entries, but reject non-empty entries with a null or
out-of-range offset.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nou=
veau/nouveau_bios.c
> index 38032bb958262..a4ef62928ba3d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bios.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
> @@ -972,24 +972,39 @@ bit_table(struct drm_device *dev, u8 id, struct bit=
_entry *bit)
[ ... ]
> +			offset =3D bit->offset;
> +			if ((bit->length && !offset) || offset > bios->length ||
> +			    bit->length > bios->length - offset)
> +				return -EINVAL;
> +

[Severity: High]
This isn't a bug introduced by this patch, but since we are hardening VBIOS
parsing here, are there other nested VBIOS table pointers parsed from BIT
payloads that lack bounds checks before dereference?

For example, in parse_bit_A_tbl_entry(), load_table_ptr is extracted and
used directly without checking if it exceeds bios->length:

drivers/gpu/drm/nouveau/nouveau_bios.c:parse_bit_A_tbl_entry() {
	...
	load_table_ptr =3D ROM16(bios->data[bitentry->offset]);

	if (load_table_ptr =3D=3D 0x0) {
		NV_DEBUG(drm, "Pointer to BIT loadval table invalid\n");
		return -EINVAL;
	}

	version =3D bios->data[load_table_ptr];
	...
}

Similarly, in parse_fp_mode_table(), fptablepointer is used as an offset
without validating against bios->length:

drivers/gpu/drm/nouveau/nouveau_bios.c:parse_fp_mode_table() {
	...
	fptable =3D &bios->data[bios->fp.fptablepointer];
	fptable_ver =3D fptable[0];
	...
}

Could these out-of-bounds reads cause a kernel panic if they access unmapped
memory pages, especially if a malicious hardware device provides a crafted
VBIOS?

>  			bit->data =3D ROMPTR(dev, entry[4]);
>  			return 0;
>  		}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814080335.2226=
3-1-pengpeng@iscas.ac.cn?part=3D1
