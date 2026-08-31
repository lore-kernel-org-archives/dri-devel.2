Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9B9C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1911710E902;
	Mon, 31 Aug 2026 14:20:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GOmLIEd3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86DC410E902
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:20:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 950B360120
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CF31F000E9;
 Mon, 31 Aug 2026 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788186026;
 bh=60Jubuaos3302/z28OZetXdSXgm95PiBtzP07vmRyJg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GOmLIEd3L/HmSfr/ESsqrRLqUpTGvLrv0K72lOlqin7h6SDscDJ9XSnXIL517W3u8
 gAGDH/YVYz/OI/q0x/S5RhaAB3kcIHaA26W2T/KUsLH0+6ixaIUoLkObum37j3HZ0O
 1myuIGjfph1Hf3G1+pY3jsngflNx+7Wx39w0FGkcLUAKYcwQXoJqxy37zBh4b+Wppt
 JV9ok8M/mu5V0xUt+xz5/SlOh7MP7Cv2GgWWr/t32jLZLoh430wTxf7CshsKmhldhQ
 u9woSmG+ivn/Uv+xD2byu8KQIXOAKE8Qy+Cqm7OLAH8JgDw2PWICW3XVLZs+dPjv0C
 JY6Bo8lk1R63A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/amdgpu: validate RAS EEPROM tbl_size
 before record count
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-69-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-69-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:20:25 +0000
Message-Id: <20260831142026.29CF31F000E9@smtp.kernel.org>
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
- [Critical] Unvalidated `first_rec_offset` from EEPROM leads to an unsigne=
d underflow in `RAS_OFFSET_TO_INDEX`, causing a massive heap buffer overflo=
w during `amdgpu_ras_eeprom_read`.
--

commit 887663ae59b09548ad94227f6b760b666b20f6c3
Author: Candice Li <candice.li@amd.com>

drm/amdgpu: validate RAS EEPROM tbl_size before record count

Corrupt EEPROM data can set tbl_size below the table header size.
Guard the RAS_NUM_RECS macros against undersized tbl_size and reset
the table during init when tbl_size is below the minimum for the table
version instead of trusting the header.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 3eb3fb55ccb05..ef4389deb24ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c

[ ... ]

> @@ -1415,11 +1418,24 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eepr=
om_control *control)
>  	switch (hdr->version) {
>  	case RAS_TABLE_VER_V2_1:
>  	case RAS_TABLE_VER_V3:
> +		if (hdr->tbl_size < RAS_TABLE_HEADER_SIZE + RAS_TABLE_V2_1_INFO_SIZE) {
> +			dev_err(adev->dev,
> +				"RAS header invalid, tbl_size %u smaller than minimum %u, resetting =
table\n",
> +				hdr->tbl_size,
> +				RAS_TABLE_HEADER_SIZE + RAS_TABLE_V2_1_INFO_SIZE);
> +			return amdgpu_ras_eeprom_reset_table(control);
> +		}
>  		control->ras_num_recs =3D RAS_NUM_RECS_V2_1(hdr);
>  		control->ras_record_offset =3D RAS_RECORD_START_V2_1;
>  		control->ras_max_record_count =3D RAS_MAX_RECORD_COUNT_V2_1;
>  		break;
>  	case RAS_TABLE_VER_V1:
> +		if (hdr->tbl_size < RAS_TABLE_HEADER_SIZE) {
> +			dev_err(adev->dev,
> +				"RAS header invalid, tbl_size %u smaller than minimum %u, resetting =
table\n",
> +				hdr->tbl_size, RAS_TABLE_HEADER_SIZE);
> +			return amdgpu_ras_eeprom_reset_table(control);
> +		}
>  		control->ras_num_recs =3D RAS_NUM_RECS(hdr);
>  		control->ras_record_offset =3D RAS_RECORD_START;
>  		control->ras_max_record_count =3D RAS_MAX_RECORD_COUNT;

[Severity: Critical]
This is a pre-existing issue, but since this patch handles validation of
corrupt EEPROM data, I wanted to point out another potential issue in this
function.

A bit further down in amdgpu_ras_eeprom_init(), first_rec_offset is used
without bounds validation:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c:amdgpu_ras_eeprom_init() {
    ...
	control->ras_fri =3D RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
    ...
}

If a corrupted or maliciously programmed EEPROM provides a first_rec_offset
that is smaller than control->ras_record_offset (e.g., 0), the unsigned
subtraction inside the RAS_OFFSET_TO_INDEX macro could underflow, assigning
a massive value to control->ras_fri.

Later, when amdgpu_ras_eeprom_read() attempts to read the records, this
underflow could propagate and cause a large heap buffer overflow:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c:amdgpu_ras_eeprom_read() {
	...
	} else {
		g0 =3D control->ras_max_record_count - control->ras_fri;
		g1 +=3D 1;
	}
	...
	res =3D __amdgpu_ras_eeprom_read(control, buf, control->ras_fri, g0);
	...
}

The variable g0 would again underflow to a massive value, which is then
passed as the num parameter to __amdgpu_ras_eeprom_read():

drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c:__amdgpu_ras_eeprom_read() {
	...
	buf_size =3D num * RAS_TABLE_RECORD_SIZE;
	res =3D amdgpu_eeprom_read(adev->pm.ras_eeprom_i2c_bus,
				 control->i2c_address +
				 RAS_INDEX_TO_OFFSET(control, fri),
				 buf, buf_size);
	...
}

The massive calculated buf_size is passed to amdgpu_eeprom_read(), which
could continuously read from the I2C bus directly into the small,
correctly-sized heap buffer, leading to memory corruption.

Could hdr->first_rec_offset be validated against control->ras_record_offset
during amdgpu_ras_eeprom_init() to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-69-sashal@kernel.org?part=3D1
