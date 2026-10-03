Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A3ECA5FEC
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7309210E93E;
	Sat,  3 Oct 2026 17:56:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KSluAIY1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D77E10E93E
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:56:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 940E160DA3;
 Sat,  3 Oct 2026 17:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245AE1F0089B;
 Sat,  3 Oct 2026 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050180;
 bh=73/rz23PogBRV/7yykNRlJYRFeXCxc/ylqxUAmYO5UY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KSluAIY17rUf41glsPg1xK0OJSTz+26i5x6n8X3rpUY6vIhH8vlmu4+mmRsSMy7gg
 aGOVQukEJTrbp9UWAoFOTnEFpyyYfVae99EAC34Rfksn+8ljDKuHh2L8cuzE50uRP/
 xqQE1FdLoVA7g8iF/d+lPh7auQXJm6JHbxRHZ6kv3GZRnThO8q5KWca0YyL4nLuNMh
 IHm9zXl7Irl3FBzO7RcMx3vaCP2WVH5OFp26hvW6f/75tifQ3d8++7nEDDHo9fdIEe
 2wc2QvVpXcJGNnZFSg+GSzC+SAfxOt5B9ZQHswEIz27pPc3tr0YBy0LqPnSTnUaz9w
 MqNSzdqjXaznw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v2 1/2] drm: add edid_overridden flag to
 drm_connector
To: =?utf-8?b?Sm9oYW5uZXMgV8O8bGxlcg==?= <johanneswueller@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003161525.23600-2-johanneswueller@gmail.com>
References: <20261003161525.23600-1-johanneswueller@gmail.com>
 <20261003161525.23600-2-johanneswueller@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:19 +0000
Message-Id: <20261003175620.245AE1F0089B@smtp.kernel.org>
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
- [Medium] drm: edid_overridden flag not set in fallback override path
--

commit e2139c9168877ee02f537cbf19084a0d24c136be
Author: Johannes W=C3=BCller <johanneswueller@gmail.com>

drm: add edid_overridden flag to drm_connector

When an EDID override is in effect, the physical connector may not
match reported capabilities. Adds a drm_connector flag that allows
drivers to detect such mismatches.

> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 42f4e41c459fd..9ea6f5f19131f 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2424,6 +2424,7 @@ static struct edid *_drm_do_get_edid(struct drm_con=
nector *connector,
>  	struct edid *edid, *new;
>  	size_t alloc_size =3D EDID_LENGTH;
> =20
> +	connector->edid_overridden =3D false;
>  	override =3D drm_edid_override_get(connector);
>  	if (override) {
>  		alloc_size =3D override->size;
> @@ -2431,6 +2432,7 @@ static struct edid *_drm_do_get_edid(struct drm_con=
nector *connector,
>  		drm_edid_free(override);
>  		if (!edid)
>  			return NULL;
> +		connector->edid_overridden =3D true;

[Severity: Medium]
Does this new flag also need to be set when falling back to an override EDID
after a failed DDC probe?

If an EDID override is provided but the physical DDC probe fails (e.g. due =
to
broken DDC lines), drm_helper_probe_get_modes() skips reading the EDID and
falls back to drm_edid_override_connector_update(). This fallback applies t=
he
override but appears to miss setting this new flag:

drivers/gpu/drm/drm_edid.c:drm_edid_override_connector_update() {
	const struct drm_edid *override;
	int num_modes =3D 0;

	override =3D drm_edid_override_get(connector);
	if (override) {
		if (drm_edid_connector_update(connector, override) =3D=3D 0)
			num_modes =3D drm_edid_connector_add_modes(connector);

		drm_edid_free(override);
	...
}

If a driver relies on this flag to apply HDMI signal type workarounds, could
this cause it to read a false value and fail to apply the necessary quirks?

>  		goto ok;
>  	}
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003161525.2360=
0-1-johanneswueller@gmail.com?part=3D1
