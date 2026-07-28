Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0C8C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A196710E315;
	Tue, 28 Jul 2026 18:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KgXkh7pO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C5B110E315
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:47:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB97D41569;
 Tue, 28 Jul 2026 18:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578181F00A3D;
 Tue, 28 Jul 2026 18:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785264445;
 bh=sIgBXWAgy5+Rb4okKcQ4yNCSt2WVwdkY6PGwlJVsZ0g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KgXkh7pOWSarIxmLI1PbLZtI3fmyw+UErNMz/jyUBflYfuwROG/fSA/anN3NXp0A1
 I+3EkymFDO3ttK9+Sce/yr4YQVq8dfSThmwpfONp3s/uIAb7J5edmiemsytUnsrH1G
 OJmDbrxSdUn111h0Wm1jHy3XHYjdD3pdtxFHpg/OTA5NQoxWvxBl8htVdWF4EvR+Nq
 OovD06PUkOVbc1WzBdXbqlZO19U/sDYffwCIjvZCwUvejjB2P6W35NhgBp2mWCgCIq
 K0YxUzz/cOA26UfGQA3Y0MpIJBFgOUQQgVV9svShEVbXxYphtHQQzlMlWg52wL08uG
 Cq263Xj71o6Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/7] drm/tyr: add parser for firmware binary
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260728-fw-boot-b4-v10-6-9187aefa3f2f@collabora.com>
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
 <20260728-fw-boot-b4-v10-6-9187aefa3f2f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 18:47:24 +0000
Message-Id: <20260728184725.578181F00A3D@smtp.kernel.org>
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
- [Medium] Missing validation that the firmware section data size does not =
exceed the virtual address mapping size.
- [Low] Crate-local imports in the `fw` module are not sorted alphabeticall=
y.
--

--- Patch [6]: [PATCH v10 6/7] drm/tyr: add parser for firmware binary ---
commit 2d4004e4d7f81ddd626b7391da06ddfa0d78eb29
Author: Daniel Almeida <daniel.almeida@collabora.com>

drm/tyr: add parser for firmware binary
   =20
This commit adds a parser for the Mali CSF GPU firmware binary format. It
extracts section metadata, validates the basic firmware structure and
alignment, and ignores protected-mode sections.

> diff --git a/drivers/gpu/drm/tyr/fw/parser.rs b/drivers/gpu/drm/tyr/fw/pa=
rser.rs
> new file mode 100644
> index 0000000000000..c4d0ad1d7899d
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw/parser.rs
[ ... ]
> +use crate::{
> +    fw::{
> +        CacheMode,
> +        SectionFlags,
> +        CSF_MCU_SHARED_REGION_START, //

[Severity: Low]
This isn't a bug, but the Rust coding guidelines require nested imports to =
be=20
sorted alphabetically. CSF_MCU_SHARED_REGION_START should be listed before
SectionFlags.

> +    },
> +    vm::{
> +        VmFlag,
> +        VmMapFlags, //
> +    }, //
> +};
[ ... ]
> +    fn parse_section_entry(
> +        entry_cursor: &mut Cursor<'_>,
> +        firmware_size: usize,
> +    ) -> Result<Option<ParsedSection>> {
> +        let section_hdr: SectionHeader =3D SectionHeader::new(entry_curs=
or)?;
> +
> +        if section_hdr.data.end < section_hdr.data.start {

[Severity: Medium]
Does this code need to ensure the initialization data size doesn't exceed t=
he
destination virtual address mapping size?

If a malformed firmware binary is provided where the data length
(data.end - data.start) is greater than the virtual address length
(va.end - va.start), could this lead to out-of-bounds writes when a firmware
loader uses the virtual address size for memory allocation but copies the
initialization data based on the binary data size?

> +            dev_err!(
> +                entry_cursor.dev,
> +                "Firmware corrupted, data.end < data.start (0x{:x} < 0x{=
:x})",
> +                section_hdr.data.end,
> +                section_hdr.data.start
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        if section_hdr.data.end as usize > firmware_size {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-fw-boot-b4=
-v10-0-9187aefa3f2f@collabora.com?part=3D6
