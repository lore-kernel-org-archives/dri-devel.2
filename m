Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABDC606A332
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ayra6ale
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81140112A44;
	Fri, 20 Nov 2026 13:17:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F257E112A44
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:17:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3A4A4573F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7671F000C4;
 Fri, 20 Nov 2026 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180643;
 bh=T+tJIhhYFVAY0aR6v0PjtaTQYu++jqjXBTtqfDqlcE4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ayra6aleOZ+SSyYxnPaZrBP3Tlz0kFmQvNX+PaljIeLG4e2cpJdgbinTtFMYErhEl
 AxmX+84+zRgZBE6vvhP/MBDtLcDz/rYB0N10dv0jYTSILNh5h6/bm7hTZv+uVTNWBu
 8Mvq9x+cjasKBRalb8KMCEanZhRZ05z7bykZyY2QVz7FPmwuDjGIRWo6fkSIPrsaMi
 E+CIedkRrK+McMLAFIYzKcshhhkGI8oNc5UctZ+sln0WEdTIhcTN/KoSCPKd6ryM0F
 BBl/iivfCn0eEgD4jNKDHXYWXJMvIZTR5+u3BCgduU48ACdbyNGh0YSTa97JFVDK3i
 Hovi+kQWGAJ+g==
Message-ID: <sashiko-outbox-225214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 19/42] drm/atomic_sro: Provide helpers to implement
 hardware state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-drm-state-readout-v9-19-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-19-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:17:22 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/atomic_sro: out-of-bounds write in
  drm_atomic_sro_set_connector_state()
--

commit b5d5ae4218e75eb40be891ff0550153b170b927a
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Provide helpers to implement hardware state readout

This commit adds helpers to read out hardware state across KMS objects,
build a drm_atomic_sro_state container, and install the read-out states.

> diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/=
gpu/drm/drm_atomic_state_readout_helper.c
> new file mode 100644
> index 0000000000000..f290d2fe5496e
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c

[ ... ]

> +static int
> +drm_atomic_helper_sro_readout_connector_state(struct drm_device *dev,
> +					      struct drm_atomic_sro_state *state,
> +					      struct drm_connector *connector)
> +{
> +	const struct drm_connector_funcs *conn_funcs =3D connector->funcs;
> +	struct drm_connector_state *conn_state;
> +	int ret;
> +
> +	if (!conn_funcs->atomic_sro_readout_state) {
> +		/*
> +		 * Missing readout implementations are only allowed
> +		 * when drm.atomic_readout skips them, but the object
> +		 * still needs a valid state: fall back to a pristine
> +		 * state, like drm_mode_config_create_state() would.
> +		 */
> +		drm_warn(dev, "No connector readout implementation.");
> +
> +		conn_state =3D conn_funcs->atomic_create_state(connector);
> +		if (drm_WARN_ON(dev, IS_ERR(conn_state)))
> +			return PTR_ERR(conn_state);
> +
> +		drm_atomic_sro_set_connector_state(state, connector, conn_state);
> +		return 0;
> +	}
> +
> +	drm_dbg_kms(dev, "Initializing connector %s state.\n",
> +		    connector->name);
> +
> +	conn_state =3D conn_funcs->atomic_create_state(connector);
> +	if (drm_WARN_ON(dev, IS_ERR(conn_state)))
> +		return PTR_ERR(conn_state);
> +
> +	ret =3D conn_funcs->atomic_sro_readout_state(connector, state,
> +						   conn_state);
> +	if (ret) {
> +		drm_dbg_kms(dev, "Connector %s readout failed: %pe\n",
> +			    connector->name, ERR_PTR(ret));
> +		conn_funcs->atomic_destroy_state(connector, conn_state);
> +		return ret;
> +	}
> +
> +	drm_atomic_sro_set_connector_state(state, connector, conn_state);
> +
> +	return 0;
> +}

[ ... ]

> +int
> +drm_atomic_helper_sro_readout_connectors_state(struct drm_device *dev,
> +					       struct drm_atomic_sro_state *state,
> +					       struct drm_atomic_commit *commit)
> +{
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_connector *connector;
> +	int ret;
> +
> +	might_alloc(GFP_KERNEL);
> +
> +	if (commit)
> +		return drm_atomic_helper_sro_readout_commit_connectors_state(dev, stat=
e, commit);
> +
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		ret =3D drm_atomic_helper_sro_readout_connector_state(dev, state, conn=
ector);

[Severity: Medium]
Can this write out of bounds of state->connectors[] if a dynamic connector
is registered after drm_atomic_sro_state_alloc()?

drm_atomic_sro_state_alloc() sizes state->connectors to
state->max_connector_index + 1, and the kerneldoc for max_connector_index
notes that connectors registered afterwards have no entry in
state->connectors.  However, drm_connector_dynamic_register() adds new
connectors under config->connector_list_lock without taking modeset locks.
If a DP MST hotplug worker registers a connector between
drm_atomic_sro_state_alloc() and
drm_atomic_helper_sro_readout_connectors_state(), the connector list
iterator visits it with drm_connector_index(connector) >
state->max_connector_index, and drm_atomic_sro_set_connector_state()
writes past the end of state->connectors[]:

drivers/gpu/drm/drm_atomic_state_readout.c:drm_atomic_sro_set_connector_sta=
te() {
	unsigned int index =3D drm_connector_index(conn);

	drm_connector_get(conn);
	state->connectors[index].ptr =3D conn;
	state->connectors[index].state =3D conn_state;
    ...
}

Because drm_atomic_helper_sro_install_state() and
drm_atomic_sro_state_free() only iterate up to state->max_connector_index,
this also leaks the connector reference and conn_state.  Should
drm_atomic_helper_sro_readout_connector_state() skip connectors with
drm_connector_index(connector) > state->max_connector_index?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-drm-state-=
readout-v9-0-a67c2b45b8ec@kernel.org?part=3D19
