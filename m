Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66953CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB6510E9D2;
	Wed, 10 Jun 2026 14:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HZ1GKVSg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ACA510E9D2
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:32:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A16F5600AA;
 Wed, 10 Jun 2026 14:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324C21F00893;
 Wed, 10 Jun 2026 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781101978;
 bh=ViGOb2fl+sAzOD6FGQGxdXwTKdPgEZLZCjelynbrcGs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HZ1GKVSgG4WyGNznQFAbvuRZooiAUUG0s23uDfmpxJrZswF3WPnXB7MdZ2Of2iFsf
 TzDFPiKHfWEbV8cRxyd8+UdsY9OYz7fIZ9Vg4JqJrYqjI8FL4IeOjUuI35n7pDRqS7
 APpQSwIDjYFzRKiK35X9SDiYFD56qmc9D2Y92a/XFPwm46kVV8/sOhIdklsgmftncs
 M5X88yC9nHJuAzdYHKfMyXB5ADtZU6uEXZcEVFQMrTrke+ndL8iY5W+ofgfvACI8Ok
 miPhEJ9BLfxdOfAhID5ARwoTij1iPTB0YLLqVmUwxRR94wnHsx1/U5Y1oJUJkBvibI
 mUgCH6I8QqTzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/displayid: fix Tiled Display Topology ID size
To: "Jani Nikula" <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610141549.555605-1-jani.nikula@intel.com>
References: <20260610141549.555605-1-jani.nikula@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:32:57 +0000
Message-Id: <20260610143258.324C21F00893@smtp.kernel.org>
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
- [High] Missing payload size validation in `drm_parse_tiled_block` allows =
an out-of-bounds read of the EDID buffer when parsing malformed DisplayID t=
iled display blocks.
--

commit 3a0b5d7c7c564335f99c7d692448de9241f67bbd
Author: Jani Nikula <jani.nikula@intel.com>

drm/displayid: fix Tiled Display Topology ID size

This commit updates the Tiled Display Topology ID size from 8 to 9 bytes
in the DRM subsystem structures.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 3fa4d2082cd72..11646453aaac9 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
[ ... ]
> @@ -3579,14 +3579,14 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
>   * tile group or NULL if not found.
>   */
>  struct drm_tile_group *drm_mode_get_tile_group(struct drm_device *dev,
> -					       const char topology[8])
> +					       const char topology_id[9])
>  {
>  	struct drm_tile_group *tg;
>  	int id;
> =20
>  	mutex_lock(&dev->mode_config.idr_mutex);
>  	idr_for_each_entry(&dev->mode_config.tile_idr, tg, id) {
> -		if (!memcmp(tg->group_data, topology, 8)) {
> +		if (!memcmp(tg->group_data, topology_id, sizeof(tg->group_data))) {

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to an
out-of-bounds read of the EDID buffer when parsing malformed DisplayID tiled
display blocks?

Looking at drm_parse_tiled_block() in drivers/gpu/drm/drm_edid.c, the gener=
ic
block is cast to a displayid_tiled_block without validating that the payload
size (block->num_bytes) is large enough:

drivers/gpu/drm/drm_edid.c:drm_parse_tiled_block() {
    ...
    const struct displayid_tiled_block *tile =3D
        (struct displayid_tiled_block *)block;
    ...
    tg =3D drm_mode_get_tile_group(connector->dev, tile->topology_id);
}

If a malformed EDID provides a tiled block with a short length near the end
of the allocated EDID buffer, comparing 9 bytes here (or copying them down =
in
drm_mode_create_tile_group()) might read past the bounds of the EDID buffer.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610141549.5556=
05-1-jani.nikula@intel.com?part=3D1
