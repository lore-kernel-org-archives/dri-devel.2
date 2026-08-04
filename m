Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBB6C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B86F10E9A9;
	Tue,  4 Aug 2026 10:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lsoPdNaX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE1B10E150
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:27:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6222342E95;
 Tue,  4 Aug 2026 10:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64F11F000E9;
 Tue,  4 Aug 2026 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785839262;
 bh=mhydXuZ0P/jB+Dnx798J7rPr03QAXfWzLNLr7V1SIxI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lsoPdNaXUlsfqz7UfgwU+ZMgr/6KDAceznab0gwDgzVaKuMrgJEOaANWLsQV99Wxf
 jKco7XWbLNJBMZrnHErxszpx/cpJiGCzDqdYNnGSuGMmUhDrGG5SY++GDS1Rg2CX5h
 toHGyStz7CAQiXBYV4wj6NTAkNdSN3rygKuG/Jaf1iFHPTiF+s0FkvS7DvxWlwE/Bg
 WsUigQfZclO2iwOvA2Gx0Yid04mYgpuSQLO8XcmJkO6TMcDMZdui6kzaxIA1BLDJil
 PvgAWb8DV5KSKLz3//ytJhVbkgFx1Uk1NjDg+GcrCvnQaWH5c3cuQMbBTIbwb3KRbc
 nDKAMAi8GGD0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/4] firmware: coreboot: Add CFR firmware attributes
 driver
To: "Sean Rhodes" <sean@starlabs.systems>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <4022650144cca8c242c6507825b29988adb6ac69.1785838269.git.sean@starlabs.systems>
References: <cover.1785838269.git.sean@starlabs.systems>
 <4022650144cca8c242c6507825b29988adb6ac69.1785838269.git.sean@starlabs.systems>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:27:40 +0000
Message-Id: <20260804102741.D64F11F000E9@smtp.kernel.org>
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
- [Medium] Memory leak of enum label string when it contains invalid charac=
ters.
--

--- Patch [4]: [PATCH v11 4/4] firmware: coreboot: Add CFR firmware attribu=
tes driver ---
commit ea61591b8dd6ac619938eac5285db7c41217e27e
Author: Sean Rhodes <sean@starlabs.systems>

firmware: coreboot: Add CFR firmware attributes driver

This commit adds a firmware-attributes driver for the coreboot CFR table
entry to describe firmware setup options. It exposes runtime EFI
variable-backed boolean, enum, and integer settings through sysfs.

Link: https://doc.coreboot.org/drivers/cfr.html
Link: https://doc.coreboot.org/drivers/cfr_internal.html

> diff --git a/drivers/firmware/coreboot/coreboot-cfr.c b/drivers/firmware/=
coreboot/coreboot-cfr.c
> new file mode 100644
> index 0000000000000..1dfb2d29046b6
> --- /dev/null
> +++ b/drivers/firmware/coreboot/coreboot-cfr.c
[ ... ]
> +static int coreboot_cfr_copy_enum_values(struct coreboot_cfr_setting *se=
tting,
> +					 const void *base, size_t len)
> +{
[ ... ]
> +	for (;;) {
> +		entry =3D coreboot_cfr_next_entry(&iterator);
[ ... ]
> +		value =3D &setting->values[setting->n_values];
> +		value->label =3D coreboot_cfr_string_dup(label);
> +		if (!value->label)
> +			return -ENOMEM;
> +		if (!coreboot_cfr_string_is_valid_label(value->label))
> +			return -EINVAL;

[Severity: Medium]
Does this code leak the newly allocated value->label string?

When coreboot_cfr_string_is_valid_label() fails and returns -EINVAL,
setting->n_values has not been incremented yet. If the caller then cleans up
the error by calling coreboot_cfr_free_setting(), the cleanup loop:

static void coreboot_cfr_free_setting(struct coreboot_cfr_setting *setting)
{
	unsigned int i;

	for (i =3D 0; i < setting->n_values; i++)
		kfree(setting->values[i].label);
	...

will skip freeing the string that was just allocated because setting->n_val=
ues
does not include it yet. Should kfree() be called on value->label before
returning -EINVAL here?

> +
> +		value->value =3D enum_value->value;
> +		setting->n_values++;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785838269.gi=
t.sean@starlabs.systems?part=3D4
