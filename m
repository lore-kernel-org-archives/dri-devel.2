Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AD5C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA4510E389;
	Thu, 16 Jul 2026 17:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g9t/Ctlw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB16810E389
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 17:24:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DAA440B8F;
 Thu, 16 Jul 2026 17:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E611F000E9;
 Thu, 16 Jul 2026 17:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784222658;
 bh=f8vvUrBsPbpWspxf7LTimq8/Zv2qDAlb9d+T2fHatwY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g9t/Ctlwo2e85yAawXGoWRS5Lkia2rw8j/GDJn/yoPWrEyzL2KH/vNXbTGkkfmZkL
 it1jaRIzql1sIQTcFzH/nOvpLSQD1V0AiFSK30J0WfKyuGDGWyHAPFydVQ+HGQ2jLC
 w9lB4GohZGLElH5eTV8GZF3/Lo5TcI95zuSPSQJ3HQHA51WAk6yKKULK9wGMPnByKD
 xZD/AAf/FBmkvYAiPEIloP2HSpcZpBb5cjKqC2OolEW+mRJIebGrhjb4loAwm/6I5T
 mS7k4MEazA7xwxAUQFnvLCUNKeFt01CEy1gCm7UhZxo3xRMBjOMostnxx4KuDn7Cmb
 HONRiAyVIupqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] configfs: Constify configfs_bin_attribute
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260716-configfs-const-base-v1-4-c545a4053cb5@weissschuh.net>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
 <20260716-configfs-const-base-v1-4-c545a4053cb5@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 17:24:17 +0000
Message-Id: <20260716172418.43E611F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The configfs documentation was not updated to reflect the new `cons=
t` signature of `ct_bin_attrs` in `struct config_item_type`.

Pre-existing issues:
- [High] acpi_table_aml_write lacks validation for minimum payload size and=
 NULL data, leading to a NULL pointer dereference or heap out-of-bounds rea=
d.
- [High] tsm_report_inblob_write passes a NULL pointer to memcpy when handl=
ing a zero-length write.
--

--- Patch [4]: [PATCH 4/6] configfs: Constify configfs_bin_attribute ---
commit 8e0989136bf4a701a307f8ac9e6579f1dbe58c67
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

configfs: Constify configfs_bin_attribute

The configfs_bin_attribute structures defined by driver are never
modified. Make them const.

As there are only two users of these attributes, adapt them in the same
commit to avoid a phased transition.

> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index 12ffec7958031..6071699c71655 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -91,7 +91,7 @@ static ssize_t acpi_table_aml_read(struct config_item *=
cfg,
> =20
>  CONFIGFS_BIN_ATTR(acpi_table_, aml, NULL, MAX_ACPI_TABLE_SIZE);
> =20
> -static struct configfs_bin_attribute *acpi_table_bin_attrs[] =3D {
> +static const struct configfs_bin_attribute *const acpi_table_bin_attrs[]=
 =3D {
>  	&acpi_table_attr_aml,

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issue
in acpi_table_aml_write() which is associated with this attribute.

If a user with write access to the configfs aml attribute performs a 0-byte
write (e.g., write(fd, buf, 0)), configfs_bin_write_iter() sets
write_in_progress but leaves bin_buffer as NULL. On file close,
acpi_table_aml_write() is invoked with data =3D NULL and size =3D 0.

The function then immediately dereferences header->length:

	struct acpi_table_header *header =3D data;
	...
	if (header->length !=3D size) {

This causes a NULL pointer dereference. Additionally, writing a crafted 8-b=
yte
payload can bypass the header->length !=3D size check (if the payload's len=
gth
field is 8), leading to an undersized allocation and out-of-bounds read.

Does acpi_table_aml_write() need validation for minimum payload size and NU=
LL
data?

>  	NULL,
>  };

[ ... ]

> diff --git a/drivers/virt/coco/guest/report.c b/drivers/virt/coco/guest/r=
eport.c
> index 96e89ddf49896..ad400fbe53f01 100644
> --- a/drivers/virt/coco/guest/report.c
> +++ b/drivers/virt/coco/guest/report.c
> @@ -356,7 +356,7 @@ static struct configfs_attribute *tsm_report_attrs[] =
=3D {
>  	NULL,
>  };
> =20
> -static struct configfs_bin_attribute *tsm_report_bin_attrs[] =3D {
> +static const struct configfs_bin_attribute *const tsm_report_bin_attrs[]=
 =3D {
>  	[TSM_REPORT_INBLOB] =3D &tsm_report_attr_inblob,

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issue
in tsm_report_inblob_write() which is associated with this attribute.

A zero-length write to the inblob attribute sets write_in_progress in
configfs without allocating bin_buffer. Upon file release,
tsm_report_inblob_write() is called with buf =3D NULL and count =3D 0.

The function then executes:

	memcpy(report->desc.inblob, buf, count);

which resolves to memcpy(..., NULL, 0). This is strictly undefined behavior
in C and can trigger a UBSAN trap, panicking the kernel if panic_on_warn is
enabled.

Does tsm_report_inblob_write() need to check for a zero-length write and NU=
LL
buffer before calling memcpy()?

>  	[TSM_REPORT_OUTBLOB] =3D &tsm_report_attr_outblob,
>  	[TSM_REPORT_AUXBLOB] =3D &tsm_report_attr_auxblob,

[ ... ]

> diff --git a/include/linux/configfs.h b/include/linux/configfs.h
> index 5d3fc8822a1d3..eff2fb22ab700 100644
> --- a/include/linux/configfs.h
> +++ b/include/linux/configfs.h
> @@ -67,7 +67,7 @@ struct config_item_type {
>  	const struct configfs_item_operations	*ct_item_ops;
>  	const struct configfs_group_operations	*ct_group_ops;
>  	struct configfs_attribute		**ct_attrs;
> -	struct configfs_bin_attribute		**ct_bin_attrs;
> +	const struct configfs_bin_attribute	*const *ct_bin_attrs;
>  };

[Severity: Low]
Does Documentation/filesystems/configfs.rst need to be updated to reflect
the new const signature of ct_bin_attrs in struct config_item_type? It
currently documents the old non-const pointer array type.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-configfs-c=
onst-base-v1-0-c545a4053cb5@weissschuh.net?part=3D4
