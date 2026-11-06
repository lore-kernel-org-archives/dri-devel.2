Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DF4606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8yMCtCb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18AA110E0BA;
	Fri,  6 Nov 2026 13:31:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA9710E0BA
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:31:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74346605D7
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C8D1F008BC;
 Fri,  6 Nov 2026 13:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971909;
 bh=f5r5VGvAVydmCdGnx+WSqWShJBs4kIcn/1cnA2dgmks=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l8yMCtCbwgERgxLt7EQ1OzXxN/iPtAk72YbCcn54yR5dRy2s8oT2+2wN+lmf+5mmG
 J4An1RvIXonOgGvxze3nNh3U56ZHItGx6hMmN2H+bXsIaumYw9RUxNJjp10ExcMuHS
 H1oLAkSTeALDAjsMYVpRmCRfwLyAse7esY03Yn4NDaz6tBJ7KxDjpJX7QdopsTdKSa
 lw4pVB5+ggHRGvmsxHpmzD5v5VlnxzEj+xAz+2uTw9sy7L+OsO/OgSjyyZwNzw2IXy
 w2b6yh8MNRMc/oUr++WY4As6rYpSGD1aNBUhNnSR2PIq6JLsW7ikFtYe/mClmxcplN
 7N9hP5+G2P5uA==
Message-ID: <sashiko-outbox-201463@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/39] drm/atomic_sro: Create kernel parameter to
 force or disable readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-14-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-14-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:31:48 +0000
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
- [Low] drm/atomic_sro: missing linux/types.h include in
  drm_atomic_state_readout.h
--

commit dc962b96e1dce7bf194a4cf4ec09437eb2d463c9
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Create kernel parameter to force or disable readout

This commit adds the drm.atomic_readout module parameter and
drm_atomic_sro_device_can_readout() to control KMS atomic hardware state
readout.

> diff --git a/include/drm/drm_atomic_state_readout.h b/include/drm/drm_ato=
mic_state_readout.h
> index 5a9333a057964..955e2de9d5b1d 100644
> --- a/include/drm/drm_atomic_state_readout.h
> +++ b/include/drm/drm_atomic_state_readout.h
> @@ -15,6 +15,15 @@ struct drm_printer;
>  struct drm_private_obj;
>  struct drm_private_state;
> =20
> +enum drm_atomic_readout_status {
> +	DRM_ATOMIC_READOUT_DISABLED =3D 0,
> +	DRM_ATOMIC_READOUT_ENABLED,
> +	DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE,
> +	DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT,
> +};
> +
> +bool drm_atomic_sro_device_can_readout(struct drm_device *dev);

[Severity: Low]
Does include/drm/drm_atomic_state_readout.h need to include
<linux/types.h> for bool?

Without it, building with CONFIG_DRM_HEADER_TEST=3Dy fails when compiling
drm_atomic_state_readout.hdrtest standalone.  A later patch in the series,
commit "drm/atomic_helper: Compare actual and readout states once the
commit is done", adds #include <linux/types.h>, so moving that include
into this patch would keep bisection working across the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D14
