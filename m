Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208DB60A2603
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilURff78
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C0A112A4A;
	Fri, 20 Nov 2026 13:17:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B65112A4A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:17:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49DEB6252F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ECF1F000CF;
 Fri, 20 Nov 2026 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180666;
 bh=MrMFv/yh7/dUZi1KfC+DA8KGXRB7+8ecXUZuNXUwR2s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ilURff78u40Bh8Jlk5lkJOBZQmZSz4zGCiJkwuHmakp3EGEKOeGVuzRD03/rZnxGz
 I9cLbKkpZ/Opxx1ZwQuYwYF9zZ9HWY0PfoZSQPCn2krIeb/apgXWhL5wKAW4f72eRi
 v4gb4WQbdgp4oK098IuynvyOd7bx3izVySfnFPO1uVghN5aHoGSDs/W6pyIRZAUeNL
 6lLURsMxAr9po7ZiWBo5qMuvTuYPUS5mu2y8TTDzKKBFJYDPIT7kCyIz0IAwpZS3N5
 VRrIzz3TdBOM5P0n4rnfaSXQoFHZusQiCdRQX6Eh45eE7mkx5322uid2fjS/qp21bR
 F7Ask8FBSF2JA==
Message-ID: <sashiko-outbox-225216@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 22/42] drm/atomic_helper: Compare actual and readout
 states once the commit is done
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-drm-state-readout-v9-22-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-22-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:17:46 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/bridge: drm_bridge_attach() disables readout if compare
  hook is unset
- [Low] drm/atomic_sro: duplicated line in DOC: overview comment
--

commit 00233166cd25376785bc177974713d5ccca22687
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_helper: Compare actual and readout states once the commit is done

This commit introduces atomic_sro_compare_state callbacks for KMS objects
and adds drm_atomic_sro_readout_and_compare() to read back and compare
hardware state against the committed state after blocking atomic commits.

> diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm=
/drm_atomic_state_readout.c
> index 3e50b0796cbec..4b6512ef1aae7 100644
> --- a/drivers/gpu/drm/drm_atomic_state_readout.c
> +++ b/drivers/gpu/drm/drm_atomic_state_readout.c
> @@ -26,7 +26,7 @@
>   * firmware already configured the display, the first userspace
>   * modeset can be skipped when the requested mode matches.
>   *
> - * The SRO lifecycle has two phases. The first phase is the readout
> + * The SRO lifecycle has three phases. The first phase is the readout
>   * itself: at driver registration time, each KMS object (CRTCs, planes,
>   * connectors, bridges, private objects) has its
>   * atomic_sro_readout_state hook called to populate a
> @@ -46,7 +46,17 @@
>   * state active, such as power domains, clocks, or interrupts. This hook
>   * cannot fail.
>   *
> - * Drivers integrate with SRO by implementing the readout hooks in their
> + * The third phase is the comparison. Because getting access to every
> + * firmware variation is hard, and most firmware setups will be fairly
> + * basic, the framework also provides a way to verify the readout
> + * implementation during normal operation. After every blocking commit,
> + * the framework reads out a fresh state from hardware and compares it
> + * to the committed state using the atomic_sro_compare_state hooks. Any
> + * mismatch is reported, which allows to catch readout bugs without
> + * needing specific firmware configurations.
> + *
> + * Drivers integrate with SRO by implementing the readout and compare
> + * hooks in their object funcs vtables and setting the
>   * object funcs vtables and setting the
>   * &drm_mode_config_funcs.atomic_sro_readout_state,
>   * &drm_mode_config_helper_funcs.atomic_sro_install_state, and

[Severity: Low]
This isn't a bug, but "object funcs vtables and setting the" is duplicated
in the overview comment.

[ ... ]

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 868558a09f951..fe9b535d02bd5 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -798,7 +798,8 @@ int drm_bridge_attach(struct drm_encoder *encoder, st=
ruct drm_bridge *bridge,
>  	}
> =20
>  	if (bridge->funcs &&
> -	    bridge->funcs->atomic_sro_readout_state)
> +	    bridge->funcs->atomic_sro_readout_state &&
> +	    bridge->funcs->atomic_sro_compare_state)
>  		ret =3D drm_atomic_private_obj_init(bridge->dev, &bridge->base,
>  						  bridge->name,
>  						  &drm_bridge_priv_state_funcs_with_sro);

[Severity: Medium]
Does requiring bridge->funcs->atomic_sro_compare_state here break bridge
state readout when atomic_readout is set to
DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE or
DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT?

If a bridge implements atomic_sro_readout_state without
atomic_sro_compare_state, drm_bridge_attach() falls back to
drm_bridge_priv_state_funcs, which leaves
privobj->funcs->atomic_sro_readout_state and
privobj->funcs->atomic_sro_install_state NULL.
drm_atomic_sro_can_readout() then rejects the device under
DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE, and
drm_atomic_helper_sro_readout_bridge_state() skips the bridge's readout
hook under DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT.

Also, at this point in the series, drm_bridge_priv_state_funcs_with_sro
does not yet set .atomic_sro_compare_state (wired in the later commit
"drm/atomic-state-helper: Provide atomic_compare_state helpers"), so
drm_atomic_sro_can_compare() returns false under
DRM_ATOMIC_READOUT_ENABLED for any device with an attached bridge until
that commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-drm-state-=
readout-v9-0-a67c2b45b8ec@kernel.org?part=3D22
