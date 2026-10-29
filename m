Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F8606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lo+rlYqb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D1C5112081;
	Thu, 29 Oct 2026 08:05:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD96112090
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:05:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B8EF743422
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FE71F01825;
 Thu, 29 Oct 2026 08:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793261123;
 bh=k4qQBxJNMxgWUIXbJIVey9fAVAa8VOTEANftBKYyk6s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Lo+rlYqbHcyBvL/oTraRz2+6M0XlPGlW9Fy/U1s8tXhR0rd1QDmKopSY4d9Y11i6m
 qigVJHag9qGskZZZpQDt1ZnbpBmDd0efI2kz3J4f0MLmBwPHt1cNlj0otsAffZoxJH
 yKEyOGmgwwtusEFZlpR9UnIbrITwy1zKjdlEzFpvnwSGCrT7hH2eTGGGhpsiyYTu4w
 T3A76AXdlkO330hX1NR7XfuPjtDz/dhCKp5v73i2WXxBji0aYZ/zjh3sSL4+u+G1hZ
 AujgP5iMQNMs9PpUBCIwAErS8WzrwQ8ZTCViCjkoKCekae+qz9tcp2LmgUR3rnx+lv
 DvLEm8WvDVDTQ==
Message-ID: <sashiko-outbox-188945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 20/34] drm/atomic_helper: Compare actual and readout
 states once the commit is done
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-20-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-20-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:05:23 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/atomic_sro: partial commit readout triggers WARN_ON(!conn_st=
ate) in bridge readout
--

commit baa08bb6dbe7a515f8de48108d95e19b64d5be4d
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_helper: Compare actual and readout states once the commit is done

This commit adds the atomic_sro_compare_state hook across KMS objects and
introduces drm_atomic_sro_readout_and_compare(), which is called from
commit_tail() after blocking commits to read out hardware state and compare
it against the committed state.

> diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm=
/drm_atomic_state_readout.c
> index 2c17fa09c5f08..f29d127f99f81 100644
> --- a/drivers/gpu/drm/drm_atomic_state_readout.c
> +++ b/drivers/gpu/drm/drm_atomic_state_readout.c

[ ... ]

> +bool drm_atomic_sro_readout_and_compare(struct drm_atomic_commit *commit)
> +{
> +	struct drm_device *dev =3D commit->dev;
> +	const struct drm_mode_config_helper_funcs *funcs =3D
> +		dev->mode_config.helper_private;
> +	struct drm_printer p =3D drm_err_printer(dev, NULL);
> +	struct drm_private_state *new_obj_state;
> +	struct drm_private_obj *obj;
> +	struct drm_plane_state *new_plane_state;
> +	struct drm_plane *plane;
> +	struct drm_crtc_state *new_crtc_state;
> +	struct drm_crtc *crtc;
> +	struct drm_connector_state *new_conn_state;
> +	struct drm_connector *conn;
> +	struct drm_atomic_sro_state *readout_state;
> +	unsigned int i;
> +	bool identical =3D true;
> +
> +	might_alloc(GFP_KERNEL);
> +
> +	if (!drm_atomic_sro_device_can_readout(dev))
> +		return true;
> +
> +	readout_state =3D funcs->atomic_sro_build_state(dev, commit);
> +	if (WARN_ON(IS_ERR(readout_state)))
> +		return false;

[Severity: Medium]
When commit_tail() calls drm_atomic_sro_readout_and_compare() for a blocking
commit that only includes a subset of connectors on a multi-connector device
with bridges, won't funcs->atomic_sro_build_state(dev, commit) trigger a
WARN_ON(!conn_state) in find_connector_state_for_encoder()?

When commit is non-NULL, drm_atomic_helper_sro_readout_connectors_state()
calls drm_atomic_helper_sro_readout_commit_connectors_state() in
drivers/gpu/drm/drm_atomic_state_readout_helper.c, which only populates
readout_state for connectors present in commit:

	for_each_new_connector_in_state(commit, connector, new_connector_state, i)=
 {
		ret =3D drm_atomic_helper_sro_readout_connector_state(dev, state, connect=
or);
		if (ret)
			return ret;
	}

Any other connector on dev has NULL state in readout_state.

Then drm_atomic_helper_sro_readout_bridges_state() calls
drm_atomic_helper_sro_readout_commit_bridges_state(), which walks the bridge
chains of old_conn_state->best_encoder and new_conn_state->best_encoder and
invokes drm_bridge_atomic_readout_priv_state() ->
find_connector_state_for_encoder() in drivers/gpu/drm/drm_bridge.c:

	drm_for_each_connector_iter(connector, &conn_iter) {
		struct drm_connector_state *conn_state =3D
			drm_atomic_sro_get_connector_state(state, connector);

		if (WARN_ON(!conn_state))
			continue;

		if (encoder =3D=3D conn_state->best_encoder) {
			drm_connector_list_iter_end(&conn_iter);
			return conn_state;
		}
	}

Because find_connector_state_for_encoder() iterates over all connectors on
the device, visiting any connector not included in commit (either an
uncommitted connector preceding the active connector in the connector list,
or any uncommitted connector when disabling a connector so old_encoder is no
longer routed to any connector) hits WARN_ON(!conn_state).

Also, when a commit disables a connector, drm_atomic_helper_check_modeset()
adds old_conn_state->best_encoder's bridges to commit by duplicating their
previous active bridge state, whereas drm_bridge_atomic_readout_priv_state()
leaves the readout bridge state as a pristine default state when
find_connector_state_for_encoder(state, old_encoder) returns NULL. Won't
that cause drm_atomic_sro_readout_and_compare() to report a false mismatch
on the bridge private object state when a connector is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D20
