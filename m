Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC67606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZpHKs6M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE2810F54F;
	Tue, 27 Oct 2026 14:19:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9E310F54F
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:19:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 94171404D3;
 Tue, 27 Oct 2026 14:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F47A1F01825;
 Tue, 27 Oct 2026 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793110765;
 bh=7/NdGXk0k60OCRY68KdH4xp2hlhwawdysfR3zWz9V1A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iZpHKs6MD1Ry7jDWlY/8RakHDmD5WLaBdBPWMObp9lB0j5R8QS2WYSPl870YSLmNZ
 FhdS+33xKqt52caITpF/YgoPvz6Gs8XY5lbdlFsTB2eotSDf+9EnyyM+zI7p1quTF5
 lueXsD3tFhy0kFxFVNEUgKXWY7QmXolEPWQYtRIhr42yAjrzg75xbj6hZd6KfO4hFO
 ax4TJDzgFxYrajArfqJIWfTjjs/3Vv4FTxg123lSEkNuvcGhvWZPixFInv9a1mXwYS
 N7EHV6lo6Pqvk2eF0iXoVq6r6LtpVXhYZ9lRqNuGDlQpgJfdpv3B1GMjWL7ytW3B+n
 NXfkr7+jXqjUg==
Message-ID: <sashiko-outbox-186719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/15] drm: client: add splash client
To: =?utf-8?b?TcOgeGltIFBlZHJhemEgUGFkaWxsYQ==?= <maximpedraza@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Helge
 Deller" <deller@gmx.de>, "Peter Jones" <pjones@redhat.com>
Cc: "Francesco Valla" <francesco@valla.it>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>,
 "Javier Martinez Canillas" <javierm@redhat.com>, "Jocelyn
 Falempe" <jfalempe@redhat.com>, "Sam Ravnborg" <sam@ravnborg.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org
In-Reply-To: <20261027135342.2003632-5-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
 <20261027135342.2003632-5-maximpedraza@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:19:23 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/client: splash: deferred restore during suspend skipped when=
 n_scanout is 0
--

commit e78c6d64f4fdb91cb45b16a96f7a38008255ec63
Author: Francesco Valla <francesco@valla.it>

drm: client: add splash client

This commit adds a DRM splash client capable of displaying an EFI BGRT logo,
a firmware-loaded 24bpp uncompressed BMP image, or a solid background color.
The client draws from a work item, handles hotplug events while keeping the
previous scanouts on screen until new ones are committed, and defers drawing
and restore commits while the device is suspended.

> diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clien=
ts/drm_splash.c
> new file mode 100644
> index 0000000000000..337c7160c4a1b
> --- /dev/null
> +++ b/drivers/gpu/drm/clients/drm_splash.c
> @@ -0,0 +1,976 @@

[ ... ]

> +static void drm_splash_work(struct work_struct *work)
> +{
> +	struct drm_splash *splash =3D container_of(work, struct drm_splash, wor=
k);
> +	struct drm_client_dev *client =3D &splash->client;
> +	const u8 *img_data =3D NULL;
> +	size_t img_data_len =3D 0;
> +	bool img_loaded;
> +	unsigned int i;
> +	int ret;
> +
> +	guard(mutex)(&splash->lock);
> +
> +	/*
> +	 * Not while the device sleeps, not even drawing, which flushes the
>	 * buffers to the hardware: resume queues the work again
> +	 */
> +	if (splash->suspended) {
> +		splash->work_skipped =3D true;
> +		return;
> +	}
> +
> +	if (!splash->n_scanout)
> +		return;

[ ... ]

> +	ret =3D drm_client_modeset_commit(client);
> +	if (ret) {
> +		/* What a hotplug replaced is still on screen: it stays */
> +		drm_dbg(client->dev, "splash: commit: %d\n", ret);
> +		return;
> +	}
> +
> +	/* Whatever a hotplug replaced is no longer on screen */
> +	drm_splash_delete_scanouts(&splash->old_scanout, &splash->n_old_scanout=
);
> +}

[ ... ]

> +/* An output without a buffer has no mode either: the commit switches it=
 off */
> +static int drm_splash_client_restore(struct drm_client_dev *client, bool=
 force)
> +{
> +	struct drm_splash *splash =3D client_to_drm_splash(client);
> +	int ret;
> +
> +	guard(mutex)(&splash->lock);
> +
> +	/* Not while the device sleeps: resume runs the work, which commits */
> +	if (splash->suspended) {
> +		splash->work_skipped =3D true;
> +		return 0;
> +	}
> +
> +	if (force)
> +		ret =3D drm_client_modeset_commit_locked(client);
> +	else
> +		ret =3D drm_client_modeset_commit(client);
> +
> +	/* Whatever a hotplug replaced is no longer on screen */
> +	if (!ret)
> +		drm_splash_delete_scanouts(&splash->old_scanout,
> +					   &splash->n_old_scanout);
> +
> +	return ret;
> +}

[Severity: Medium]
In drivers/gpu/drm/clients/drm_splash.c, can a restore deferred during
suspend be skipped on resume when splash->n_scanout is 0, or lose the force
flag?

If a hotplug event finds no usable modesets or fails buffer allocation,
drm_splash_client_hotplug() moves the previously active scanouts to
splash->old_scanout and calls drm_splash_free_scanout(), which clears
client->modesets via drm_splash_modeset_off() and leaves splash->n_scanout
at 0.

If drm_splash_client_restore() is then called while splash->suspended is
true (for example, via drm_lastclose() when a userspace master closes its
DRM file descriptor), it sets splash->work_skipped =3D true and returns 0,
relying on drm_splash_client_resume() to queue drm_splash_work() to perform
the commit.

However, when drm_splash_work() runs on resume, it checks:

	if (!splash->n_scanout)
		return;

and returns before calling drm_client_modeset_commit(client) and
drm_splash_delete_scanouts(&splash->old_scanout, &splash->n_old_scanout).
Wouldn't this leave the disabled modesets uncommitted and splash->old_scano=
ut
unfreed?

Additionally, if drm_splash_client_restore(client, true) is called while
suspended, the force argument is not recorded, so drm_splash_work() will
call drm_client_modeset_commit() instead of
drm_client_modeset_commit_locked() and fail with -EBUSY if a DRM master is
still active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027135342.2003=
632-1-maximpedraza@gmail.com?part=3D4
