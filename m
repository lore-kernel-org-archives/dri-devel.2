Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA58606A333
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJIkT6GY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 769A7112900;
	Fri, 27 Nov 2026 10:09:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1D8112980
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:09:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D78C362706
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A971F0089C;
 Fri, 27 Nov 2026 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774180;
 bh=1bnXpyhB9lJIYZE0Q8eiRQh+NDZhIrUvdZwGDfeoPpo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oJIkT6GY+CyCTAa7enCCLZEET0ldh05ooqZ0Ju3hIOgoj5v9vKWUIF5NvbmqM1+HS
 U7H9LC788yMnnc0Xfn8ckZ5In4VwqA/Wvg5OLsvsDSXM+jxMqF0kD9P7t5XDsHPClF
 Nm9Ttw36QLnoyvi7bZimMKWcBxIpBIegklSmhQPqlzrCzVtiZX5Ifutcqjjw35cQRw
 KtJ2orGKgWmueB9rdBRHj5hI7SgjTOnKUIjqr6ncxH6sDPBaE5HhTKWsjoDqtdcYRs
 HRRofIEEU+/FIMhDCvfQEDXyxAYx9qImf+gO4sP9dD/a+w5Dv1An8ULDomX+m3Uh2i
 gQ3JCBzX0Gp2A==
Message-ID: <sashiko-outbox-237057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 17/36] drm/atomic-state-helper: Provide
 atomic_compare_state helpers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-state-readout-v10-17-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-17-0259582d45a8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:09:39 +0000
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
- [Medium] drm/bridge: drm_bridge_atomic_compare_priv_state() fails when
  hook is NULL
--

commit 17f7e70e0ef85d317fffb95a3dcd590ab15c611e
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic-state-helper: Provide atomic_compare_state helpers

This commit adds default atomic_sro_compare_state helpers for planes,
CRTCs, connectors, and bridges, and wires up the bridge private object
comparison callback.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 60a1ceef40c9c..5716348f35b59 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -640,6 +640,21 @@ drm_bridge_atomic_readout_priv_state(struct drm_priv=
ate_obj *obj,
>  	return 0;
>  }
> =20
> +static bool drm_bridge_atomic_compare_priv_state(struct drm_private_obj =
*obj,
> +						 struct drm_printer *p,
> +						 struct drm_private_state *a,
> +						 struct drm_private_state *b)
> +{
> +	struct drm_bridge *bridge =3D drm_priv_to_bridge(obj);
> +	struct drm_bridge_state *state_a =3D drm_priv_to_bridge_state(a);
> +	struct drm_bridge_state *state_b =3D drm_priv_to_bridge_state(b);
> +
> +	if (bridge->funcs->atomic_sro_compare_state)
> +		return bridge->funcs->atomic_sro_compare_state(bridge, p, state_a, sta=
te_b);
> +	else
> +		return false;
> +}

[Severity: Medium]
Should drm_bridge_atomic_compare_priv_state() return true when
bridge->funcs->atomic_sro_compare_state is NULL?

drm_bridge_attach() registers drm_bridge_priv_state_funcs_with_sro for a
bridge without atomic_sro_compare_state when drm_atomic_sro_status >=3D
DRM_ATOMIC_SRO_SKIP_MISSING_COMPARE.  Returning false here causes
drm_atomic_sro_readout_and_compare() to log a state mismatch warning and
fail the comparison on every blocking commit instead of skipping the
unimplemented hook.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-state-=
readout-v10-0-0259582d45a8@kernel.org?part=3D17
