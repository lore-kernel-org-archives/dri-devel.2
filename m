Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05504606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRmKINMC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DAB910E171;
	Thu, 26 Nov 2026 11:51:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A06B6112392
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:51:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E73D44F35;
 Thu, 26 Nov 2026 11:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086F31F000E0;
 Thu, 26 Nov 2026 11:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693900;
 bh=H3Z9E5rHfYKQ7F7T1vEv8mX0/xw4Aa+nmDpDGkETgJ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bRmKINMCCuBV2agHJ6d+2aNBKM+k3/ZuVGbGYTJFttEnELvdBdXTEOEB5TdiBqp3/
 NNa3gPE7em83kHTbBgF1JOhhyKVk4jzgWy01mI5Z+SpQtuNID6faR4GpYeiMXsC9eo
 A9Hmu6E4bioGa0lNdFd/YMPWMjfReiMkkG2U3TtvKSrCyo9QgztFbkY1l46AAYIO8i
 Ng1tsoHy80kCLlvydSMp+zQNDm6DJrq743gNsfgfzBWNE0XQW6TplXWkPgzQwjnIZ5
 8beOZ/3ZMxFInSk6lKh8UAVxLIZwa69YkNLoMgUs8RpPZGwCYHfb+Pumn1VtsuGFM9
 ClE+ml32hiP1A==
Message-ID: <sashiko-outbox-235429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 36/43] drm/vkms: Introduce config for connector EDID
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-36-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-36-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:51:38 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/vkms: sleeping in RCU read-side critical section in
  vkms_conn_get_modes()
- [Medium] drm/vkms: pointer signedness mismatch in
  vkms_config_connector_get_edid()
- [Low] drm/vkms: direct __rcu pointer dereference in
  vkms_config_connector_release()
- [Low] drm/vkms: inaccurate kernel-doc for edid_enabled in
  vkms_config_connector
--

commit 2562fe9d046d1f1711056464ad1f96e4ee4649be
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for connector EDID

This commit adds RCU-protected EDID configuration to vkms_config_connector
and updates vkms_conn_get_modes() to read the configured EDID when enabled.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index fa4ca256b4b91..173e88122bcb1 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -1070,6 +1084,8 @@ static void vkms_config_connector_release(struct kr=
ef *ref)
>  		/* The config is dying and is draining us: just unlink */
>  		list_del_init(&connector_cfg->link);
>  	}
> +	if (connector_cfg->edid)
> +		call_rcu(&connector_cfg->edid->rcu, vkms_config_edid_free);
>  	kfree_rcu(connector_cfg, rcu);
>  }

[Severity: Low]
connector_cfg->edid is annotated with __rcu, so dereferencing
&connector_cfg->edid->rcu directly without rcu_dereference_protected()
triggers a Sparse noderef warning, unlike vkms_config_connector_set_edid()
below.  Also, because vkms_config_edid_free() is a module function queued
via call_rcu(), unloading the module immediately after vkms_exit() drops
default_config could race with an in-flight callback unless vkms_exit()
calls rcu_barrier() or struct vkms_config_edid embeds the data as a
flexible array freed with kfree_rcu().

[ ... ]
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vk=
ms_config.h
> index 341e0638b5087..ef8de0316b94c 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -145,6 +145,22 @@ struct vkms_config_encoder {
>  	struct drm_encoder *encoder;
>  };
> =20
> +/**
> + * struct vkms_config_edid - RCU-protected EDID data
> + *
> + * @edid: Pointer to the EDID data buffer
> + * @edid_len: Length of the EDID data
> + * @rcu: RCU head for safe freeing
> + *
> + * This struct ensures EDID data and its length are always accessed
> + * coherently by readers without requiring locks.
> + */
> +struct vkms_config_edid {
> +	const u8 *edid;
> +	unsigned int edid_len;
> +	struct rcu_head rcu;
> +};
> +
>  /**
>   * struct vkms_config_connector
>   *
> @@ -157,6 +173,8 @@ struct vkms_config_encoder {
>   *                         are the sames as ones accepted by
>   *                         drm_mode_create_hdmi_colorspace_property() and
>   *                         drm_mode_create_dp_colorspace_property()
> + * @edid_enabled: If true, create the EDID property
> + * @edid: RCU-protected EDID data. Readers must use rcu_read_lock() to a=
ccess.

[Severity: Low]
This isn't a bug, but the kernel-doc for @edid_enabled says it controls
creating the EDID property, whereas the EDID property is always attached
and edid_enabled instead controls whether vkms_conn_get_modes() exposes
the configured EDID.

[ ... ]
> +static inline const u8 *
> +vkms_config_connector_get_edid(const struct vkms_config_connector *conne=
ctor_cfg, int *len)
> +{
> +	const struct vkms_config_edid *edid =3D rcu_dereference(connector_cfg->=
edid);
> +
> +	if (edid) {
> +		*len =3D edid->edid_len;
> +		return edid->edid;
> +	}
> +
> +	*len =3D 0;
> +	return NULL;
> +}
> +
> +int vkms_config_connector_set_edid(struct vkms_config_connector *connect=
or_cfg,
> +				   const u8 *edid, unsigned int len);

[Severity: Medium]
Should the len parameter of vkms_config_connector_get_edid() be
unsigned int * instead of int *?

struct vkms_config_edid.edid_len and vkms_config_connector_set_edid() both
use unsigned int, and vkms_connector_read_block() passes &edid_len of type
unsigned int *, which triggers a -Wpointer-sign compiler warning (and a
build failure under CONFIG_WERROR=3Dy).

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> index 552d767c3976e..71a0ae15be653 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -43,13 +43,48 @@ static const struct drm_connector_funcs vkms_connecto=
r_funcs =3D {
>  	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
>  };
> =20
> +static int vkms_connector_read_block(void *context, u8 *buf, unsigned in=
t block, size_t len)
> +{
> +	struct vkms_config_connector *config =3D context;
> +	unsigned int edid_len;
> +	const u8 *edid =3D vkms_config_connector_get_edid(config, &edid_len);
> +
> +	if (block * len + len > edid_len)
> +		return 1;
> +	memcpy(buf, &edid[block * len], len);
> +	return 0;
> +}
> +
>  static int vkms_conn_get_modes(struct drm_connector *connector)
>  {
> -	int count;
> +	struct vkms_connector *vkms_connector =3D drm_connector_to_vkms_connect=
or(connector);
> +	const struct drm_edid *drm_edid =3D NULL;
> +	int count =3D 0;
> +	struct vkms_config_connector *cfg =3D vkms_config_connector_get(vkms_co=
nnector->cfg);
> +
> +	if (vkms_config_connector_get_edid_enabled(cfg)) {
> +		/*
> +		 * Hold rcu_read_lock() for the entire duration so that
> +		 * the EDID data accessed via the callback remains valid.
> +		 */
> +		rcu_read_lock();
> +		drm_edid =3D drm_edid_read_custom(connector,
> +						vkms_connector_read_block, cfg);
> +
> +		drm_edid_connector_update(connector, drm_edid);
> +
> +		count =3D drm_edid_connector_add_modes(connector);
> +
> +		drm_edid_free(drm_edid);
> +		rcu_read_unlock();

[Severity: High]
Does holding rcu_read_lock() across drm_edid_read_custom(),
drm_edid_connector_update(), and drm_edid_connector_add_modes() sleep in
an RCU read-side critical section?

All three helpers perform GFP_KERNEL allocations and acquire sleeping
mutexes: for example, drm_edid_read_custom() -> _drm_do_get_edid() takes
mutex_lock(&connector->edid_override_mutex) in drm_edid_override_get() and
allocates the EDID buffer with kmalloc(..., GFP_KERNEL).  Also, because
vkms_connector_read_block() calls vkms_config_connector_get_edid() on each
128-byte block, a concurrent vkms_config_connector_set_edid() can swap the
RCU pointer between block 0 and extension blocks, causing a torn read.
Instead of drm_edid_read_custom(), could this snapshot the buffer under
rcu_read_lock() or pass the snapshot to drm_edid_alloc() outside the RCU
read-side critical section?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D36
