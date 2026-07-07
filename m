Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82F5C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B15E10E4F7;
	Tue,  7 Jul 2026 15:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z9ugK5oL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E9510E4F7
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:27:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37F6E601EB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9551F000E9;
 Tue,  7 Jul 2026 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783438050;
 bh=HMC9nU5ATpqw/ydlbhwwnFnxmTH3ecoZN8bkz29WZKs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z9ugK5oL26kxWqinFwBjKcMw+eaMy4pCpYjhlOm+6prp0KN/NGI8YN9op/VZ7U29D
 EmfXJqlc8PsWbJT3uvKIosYYLCis8DnGEkAqzNTW6P87H/1yXKwH1xctHI/BTDR/YC
 FiPSK1dTF4lweCZ2VDmXTo1k3YKt5WOI1AqP2PwZZv/ddhbYaLGzd88NWWhnQJF4Bh
 ItND67BDbNBCSpZX+nrCAGvW0geKsSjBexCVpCZNP467gJG4ekobfWWHgwWd83XruF
 JQGl5nQzhzdAqPf5kg5jhEEZ5xABORWHz8Atbp7ZWAqM1x7N1azYWleuLTWlkRYZ1J
 eZhBFnFfrdEIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/37] drm/bridge: lontium-lt8713sx: Add atomic
 bridge state handlers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-8-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-8-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:27:30 +0000
Message-Id: <20260707152730.CE9551F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Double-free of the firmware object in the error paths of firmware =
update.
- [High] Missing minimum firmware size check causes massive buffer overflow=
/underflow.
- [High] drm_atomic_private_obj_init() leaves the object in privobj_list on=
 error, and drm_bridge_attach() ignores the error, leading to crashes.
--

--- Patch [8]: [PATCH v2 08/37] drm/bridge: lontium-lt8713sx: Add atomic br=
idge state handlers ---
commit cc389f313911703ff4573192b0ab28ddca13b386
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: lontium-lt8713sx: Add atomic bridge state handlers

The lontium-lt8713sx bridge doesn't implement any enable or disable
callbacks, but is still missing the atomic state handlers. In order to
remove the legacy bridge callback support from the DRM bridge core, add the=
m.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt8713sx.c b/drivers/gpu/drm/=
bridge/lontium-lt8713sx.c
> index cee485adf5e56..4a6420b876da6 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8713sx.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8713sx.c

[ ... ]

> @@ -508,6 +509,9 @@ static const struct attribute_group *lt8713sx_attr_gr=
oups[] =3D {
>  };
> =20
>  static const struct drm_bridge_funcs lt8713sx_bridge_funcs =3D {
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.attach =3D lt8713sx_bridge_attach,
>  };

[Severity: High]
This isn't a bug introduced by this patch, but by adding .atomic_create_sta=
te
you are enabling the atomic path in drm_bridge_attach() which will now call
drm_atomic_private_obj_init().

If drm_atomic_private_obj_init() fails, it returns an error but leaves the
object in dev->mode_config.privobj_list with a NULL obj->state:

drm_atomic.c:drm_atomic_private_obj_init()
	list_add_tail(&obj->head, &dev->mode_config.privobj_list);

	state =3D obj->funcs->atomic_create_state(obj);
	if (IS_ERR(state))
		return PTR_ERR(state);

	obj->state =3D state;

Then drm_bridge_attach() ignores this return value:

drm_bridge.c:drm_bridge_attach()
	if (drm_bridge_is_atomic(bridge))
		drm_atomic_private_obj_init(bridge->dev, &bridge->base,
					    &drm_bridge_priv_state_funcs);

	return 0;

If a state dump is triggered later, drm_state_dump() iterates over
privobj_list and calls drm_atomic_private_obj_print_state(p, obj->state).
Since obj->state is NULL, this will cause a NULL pointer dereference.

Should the return value of drm_atomic_private_obj_init() be checked in
drm_bridge_attach(), and should drm_atomic_private_obj_init() remove the
object from the list on failure?

[Severity: High]
This is a pre-existing issue, but I noticed a potential double-free in the
firmware update error paths of this driver.

In lt8713sx_prepare_firmware_data():

	release_firmware(lt8713sx->fw);
	return -EINVAL;

This frees the firmware object but leaves lt8713sx->fw pointing to the freed
memory. Then the caller lt8713sx_firmware_update() handles the error:

error:
	if (lt8713sx->fw) {
		release_firmware(lt8713sx->fw);
		lt8713sx->fw =3D NULL;
	}

Could this result in a double-free of the firmware object?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential buffer overflow
in lt8713sx_prepare_firmware_data():

	memcpy(lt8713sx->fw_buffer, lt8713sx->fw->data, SZ_64K - 1);
	...
	memcpy(lt8713sx->fw_buffer + SZ_64K,
	       lt8713sx->fw->data + SZ_64K,
	       lt8713sx->fw->size - SZ_64K);

If a user provides a firmware file smaller than 64KB, would the first memcpy
read out of bounds, and would lt8713sx->fw->size - SZ_64K underflow resulti=
ng
in a massive out-of-bounds copy?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D8
