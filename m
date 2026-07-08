Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EBDC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B97DB10E580;
	Wed,  8 Jul 2026 07:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TxeYehY7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C44210E599
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 07:37:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B123043A38;
 Wed,  8 Jul 2026 07:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679801F00A3A;
 Wed,  8 Jul 2026 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783496244;
 bh=METnsMh353NYVwxoIUXaJFBqVXcVwHbYUmFAwqG/KKE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TxeYehY74YRSPnQJvNni6JzqssXJ/YvMOoKSmW5gfWTmDE1TIhSZgagzPeZiG63Bn
 eRw7dty2O0aGGqtrubbnfvAhDhPwPFTplOJ1lyK28tE6ITlE7XNuGXcKBMn0uI8KYm
 lHjOky8nEgLKStjDQ6Oh9U+Sm6pyzwhue1vo1RKwcE/2P6ZKH3ZyCKLqwTbjjpl7Sm
 Yn6m7uDjBhj5FvZYrXlKZPTIVCVVejtVsMQUgq5io+p6WB8014os5pG72gmyWu+dqI
 p3/ZnM7c9012/Q5AiP6gxdU7/B3y09AwF5oL09c9slZyb4ii6iJQGMulltxihLF7Ux
 wT2L4ycqUJaaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/pf: clear pending packet on header init failure
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708071502.722393-1-lgs201920130244@gmail.com>
References: <20260708071502.722393-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 07:37:24 +0000
Message-Id: <20260708073724.679801F00A3A@smtp.kernel.org>
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

New issues:
- [Low] The patch introduces a syntax error `rturn copied;` instead of `ret=
urn copied;`.

Pre-existing issues:
- [High] Memory leak of migration packets across aborted or repeated SAVE o=
perations.
--

--- Patch [1]: [PATCH] drm/xe/pf: clear pending packet on header init failu=
re ---
commit c2701f46b2a82f4a8b22c425cd68c28c08222f7f
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/xe/pf: clear pending packet on header init failure

This commit drops the pending packet when header initialization fails
after the header has been fully consumed. This prevents a potential
NULL pointer dereference on subsequent writes.

> diff --git a/drivers/gpu/drm/xe/xe_sriov_packet.c b/drivers/gpu/drm/xe/xe=
_sriov_packet.c
> --- a/drivers/gpu/drm/xe/xe_sriov_packet.c
> +++ b/drivers/gpu/drm/xe/xe_sriov_packet.c
[ ... ]
> @@ -332,11 +333,21 @@ ssize_t xe_sriov_packet_write_single(struct xe_devi=
ce *xe, unsigned int vfid,
> -	if ((*data)->hdr_remaining)
> +	writing_hdr =3D (*data)->hdr_remaining;
> +	if (writing_hdr)
>  		copied =3D pkt_hdr_write(*data, buf, len);
>  	else
>  		copied =3D pkt_data_write(*data, buf, len);
> =20
> +	if (copied < 0) {
> +		if (writing_hdr && !(*data)->hdr_remaining) {
> +			kfree(*data);
> +			*data =3D NULL;
> +		}
> +
> +		rturn copied;

[Severity: Low]
There is a typo here (rturn instead of return).

> +	}
> +
>  	if ((*data)->hdr_remaining =3D=3D 0 && (*data)->remaining =3D=3D 0) {
>  		ret =3D xe_sriov_pf_migration_restore_produce(xe, vfid, *data);

[Severity: High]
This is a pre-existing issue, but is it possible to leak migration packets
across aborted or repeated save operations?

If userspace initiates a VF migration save operation, aborts it without
reading all packets, and then triggers a new save, will the pointers be
overwritten without freeing the previously allocated packets?

drivers/gpu/drm/xe/xe_sriov_packet.c:pf_descriptor_init() {
    ...
    *desc =3D data;
    ...
}

drivers/gpu/drm/xe/xe_sriov_packet.c:pf_trailer_init() {
    ...
    *trailer =3D data;
    ...
}

drivers/gpu/drm/xe/xe_sriov_packet.c:pf_pending_init() {
    ...
    *data =3D NULL;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708071502.7223=
93-1-lgs201920130244@gmail.com?part=3D1
