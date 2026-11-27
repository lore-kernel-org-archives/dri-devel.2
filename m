Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C3606A330
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBk08Ha5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA911129A4;
	Fri, 27 Nov 2026 10:15:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17EBA1129A9
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:15:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4244C627BC
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4981F0089C;
 Fri, 27 Nov 2026 10:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774532;
 bh=3DxCTWsx2xNGwik4L5rEHBfwyjktueBSxlTvJT+2pGQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hBk08Ha5FL9XE3OrFTttsgV4b2ydaOoYPEE9/SNxt4rFHxlo4NkjyzqF7tk4x0xt1
 +8EzqhIMMt+yvP8NU3pRwrWiZ5iSwYYHRZAnrsmWdeZdV8cbev+ZzFekyZVJXK6klZ
 isZuIkTTnM7kXp4LoNZGvlYFCDWEW9/M12LIdYrP2NPG8SK49LxecW0RGr/wrDjU75
 oLc41yJ6CtsNzTJtiy2VijF95QgrTlMNX7dVt2+DyEHiebxAdIWH1COfFcUtSPkyXv
 78DSmXL7koaSJJK11x00tlleTNHgjtFD2ksZDs7Rzngz9iA4vYgZ4GNklbcNatnpfC
 A5mF2aBuhBHVg==
Message-ID: <sashiko-outbox-237074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 29/36] drm/tidss: kms: Hook up hardware state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-state-readout-v10-29-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-29-0259582d45a8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:15:32 +0000
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
- [Medium] drm/tidss: unchecked tidss_runtime_get() in
  tidss_crtc_readout_state()
--

commit 7c02053e6a9ffe7daf7c01542d46afe0038e03e1
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: kms: Hook up hardware state readout

This commit wires up the atomic state readout helper callbacks in
mode_config_funcs and mode_config_helper_funcs to enable hardware state
readout for the tidss driver.

> diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/ti=
dss_kms.c
> index fd7bb2c88931d..32e11e36627db 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.c
> +++ b/drivers/gpu/drm/tidss/tidss_kms.c
[ ... ]
> @@ -64,7 +66,9 @@ static void tidss_atomic_commit_tail(struct drm_atomic_=
commit *old_state)
>  }
> =20
>  static const struct drm_mode_config_helper_funcs mode_config_helper_func=
s =3D {
> -	.atomic_commit_tail =3D tidss_atomic_commit_tail,
> +	.atomic_commit_tail	=3D tidss_atomic_commit_tail,
> +	.atomic_sro_build_state =3D drm_atomic_helper_sro_build_state,
> +	.atomic_sro_install_state =3D drm_atomic_helper_sro_install_state,
>  };

[Severity: Medium]
Does enabling drm_atomic_helper_sro_build_state() expose an unchecked
tidss_runtime_get() in tidss_crtc_readout_state()?

drivers/gpu/drm/tidss/tidss_crtc.c:tidss_crtc_readout_state() {
	...
	tidss_runtime_get(tidss);

	if (!dispc_vp_is_enabled(dispc, tcrtc->hw_videoport))
		goto out;
	...
out:
	tidss_runtime_put(tidss);
	return 0;
}

tidss_runtime_get() wraps pm_runtime_resume_and_get(), which drops the
runtime PM reference on error.  Unlike tidss_crtc_install_state() and
tidss_plane_atomic_readout_state(), tidss_crtc_readout_state() ignores a
negative return value, reads DISPC registers while the device is still
suspended, and calls tidss_runtime_put() on exit, underflowing the
runtime PM usage count.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-state-=
readout-v10-0-0259582d45a8@kernel.org?part=3D29
