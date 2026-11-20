Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC8606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcLNzbhZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E64F4112A53;
	Fri, 20 Nov 2026 13:25:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57971112A4B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:25:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 11CF544868
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B7E1F000C0;
 Fri, 20 Nov 2026 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795181135;
 bh=rWpoEcRjt6vGHDn0M8Rd4JU0/6Vs/0kY/Ay58un/Qyo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YcLNzbhZI5hADZYgetDNIu1vMZ6+CiUgK5ILvR556LqO8N8LwnA3I5VZTKQ7SeqZT
 B+OF6CExkXShFxsdFsB92wBlDAtdyCx/hPxpVzl5UOOfFpRF7QdYN2GEqwwv0flW8D
 JO/I+qeXV30Q/mVoZ21NRUOfzdr5QPTZgPX4qNFPnIqmAsMsFrOVNDOYu7/DVNDc3C
 /xL2o1E2xNS9q7LRTkcESiwq1KXKyJWOmyIUhpd6WI+2lGaWJejzvHMAdgaOQ3ppU/
 b7smDzJqZLu0VYjEslToPjbhUJEUO8zmHg4+WOKQJazNU3iJQhgO+VnBREfCaBWMS7
 eR0+Rrh6Rrqcg==
Message-ID: <sashiko-outbox-225227@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 34/42] drm/tidss: kms: Hook up hardware state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-drm-state-readout-v9-34-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-34-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:25:34 +0000
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

commit 056d6b442f1d4a5e8f743bf80ec001d68148711b
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: kms: Hook up hardware state readout

This commit wires up the mode_config and mode_config_helper state readout
callbacks so the KMS core invokes the tidss driver's per-object readout
hooks.

> diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/ti=
dss_kms.c
> index 9d9cd19906306..77294fe34df0a 100644
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
Can wiring up drm_atomic_helper_sro_build_state() read DISPC registers
while unclocked and underflow the runtime PM usage count if
tidss_runtime_get() fails in tidss_crtc_readout_state()?

drivers/gpu/drm/tidss/tidss_crtc.c:tidss_crtc_readout_state() {
    ...
	tidss_runtime_get(tidss);

	if (!dispc_vp_is_enabled(dispc, tcrtc->hw_videoport))
		goto out;
    ...
out:
	tidss_runtime_put(tidss);
	return 0;
    ...
}

tidss_runtime_get() wraps pm_runtime_resume_and_get(), which already drops
the runtime PM reference on failure.  Unlike tidss_crtc_install_state()
and tidss_plane_atomic_readout_state(), tidss_crtc_readout_state()
introduced in commit "drm/tidss: crtc: Implement hardware state readout"
does not check the return value of tidss_runtime_get(), so on resume
failure it proceeds to read MMIO registers via dispc_vp_is_enabled() and
unconditionally calls tidss_runtime_put().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-drm-state-=
readout-v9-0-a67c2b45b8ec@kernel.org?part=3D34
