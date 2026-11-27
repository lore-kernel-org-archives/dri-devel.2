Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ABD606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzGR4jyR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0253011299A;
	Fri, 27 Nov 2026 10:15:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12DC11213B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:15:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5031740BA7
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB4A1F00893;
 Fri, 27 Nov 2026 10:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774526;
 bh=zEdqG83gtizEbOAFRCRmxqAFxiDRJhq9C6eJPh2/Jos=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DzGR4jyRnOYYkP/9/Um4fyefGtuK2j5ukplg8Cb1G2eb2aS0WEXpTzq5bWagXgLyg
 tQvyxPeYrOE8xGzIS7ZtIVesP3v7MkxNnCWT1boDi6nkBC8ndJNqafQ+3qhCxQ9ioH
 WZMSAk0Mfj3Ui0Xh/PdZnJHS5lHYNCW+akjhjHSShibUhx048LAFy2KAwhqNDY0yju
 dVjJI80f9+DhStW3aGsjtacosUnHJe5d1e2B48eEZ1balHOk5gzvv5MsnhijXf9JGM
 rg2f0XfJFJJgILoQ6+bkE+ulkpx5Edzm9vNJmG1em/A40J4dItDbAYuTRzXtu9ffOA
 2PfIkKy5ko+ew==
Message-ID: <sashiko-outbox-237072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 27/36] drm/tidss: crtc: Implement hardware state
 readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-state-readout-v10-27-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-27-0259582d45a8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:15:24 +0000
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

commit 27f832761d364d1ee42dec3bb9847c031048e245
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: crtc: Implement hardware state readout

This commit implements the CRTC atomic state readout, installation, and
comparison callbacks for tidss so that video ports left running by
firmware can be adopted at probe time.

> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/t=
idss_crtc.c
> index d2664bda53a99..c72194e93bde1 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
[ ... ]
> @@ -372,6 +376,131 @@ static struct drm_crtc_state *tidss_crtc_create_sta=
te(struct drm_crtc *crtc)
>  	return &tstate->base;
>  }
> =20
> +static int tidss_crtc_readout_state(struct drm_crtc *crtc,
> +				    struct drm_atomic_sro_state *state,
> +				    struct drm_crtc_state *crtc_state)
> +{
> +	struct drm_device *ddev =3D crtc->dev;
> +	struct tidss_device *tidss =3D to_tidss(ddev);
> +	struct dispc_device *dispc =3D tidss->dispc;
> +	struct tidss_crtc_state *tstate =3D to_tidss_crtc_state(crtc_state);
> +	struct tidss_crtc *tcrtc =3D
> +		to_tidss_crtc(crtc);
> +	struct drm_display_mode mode =3D {};
> +	int ret;
> +
> +	tidss_runtime_get(tidss);
> +
> +	if (!dispc_vp_is_enabled(dispc, tcrtc->hw_videoport))
> +		goto out;

[Severity: Medium]
Should tidss_crtc_readout_state() check the return value of
tidss_runtime_get(tidss), as tidss_crtc_install_state() does below?

tidss_runtime_get() wraps pm_runtime_resume_and_get(), which drops the
runtime PM reference when it returns a negative error code.  If resume
fails, continuing will read DISPC registers while the device is suspended
and then unconditionally call tidss_runtime_put(tidss) on exit,
underflowing the runtime PM usage counter.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-state-=
readout-v10-0-0259582d45a8@kernel.org?part=3D27
