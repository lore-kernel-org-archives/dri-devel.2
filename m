Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BA606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsjxaxPx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A4F810E7BA;
	Mon, 16 Nov 2026 00:51:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02CFB10E7BA
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 00:51:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A551625D9;
 Mon, 16 Nov 2026 00:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83C11F000C7;
 Mon, 16 Nov 2026 00:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794790289;
 bh=LUSLjfnp5TqRZRnw5R5Q+hAEcOAQAbhF6INh8GwohFM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lsjxaxPx7h534VLITV1qkGvb/Lu7j7wSrUh6viDw0GCQt903nlBbLvnMeSgCozt7i
 RQucOy1/k2tCScpx3BRRMOdittRfta259aMwPiGcq4FKZVMG0kxv07Ody9feEO3DYt
 KXZ4pYkkmKDHMC8i/CIO/lumPKzMiDfl9xQZZdmOlUHtccxHN17HG2Nu6wxdPaMASq
 +X76HCageW+rWCbsJNvnGwGLq8s+QHsDPwKHkccYHUMDHuMpDs+MvE6+cwRUhF/3Hu
 ySSnV18LWOq8j16KJWRs6+DI1yW+9L/RxBfYuLz9q7q0T0djuwmKfmvXafChL+tl8T
 Y7W5uOq5LaAhg==
Message-ID: <sashiko-outbox-215973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] drm: client: add splash client
To: =?utf-8?b?TcOgeGltIFBlZHJhemEgUGFkaWxsYQ==?= <maximpedraza@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Ard Biesheuvel" <ardb@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Helge Deller" <deller@gmx.de>,
 "Peter Jones" <pjones@redhat.com>
Cc: "Francesco Valla" <francesco@valla.it>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>,
 "Javier Martinez Canillas" <javierm@redhat.com>, "Jocelyn
 Falempe" <jfalempe@redhat.com>, "Sam Ravnborg" <sam@ravnborg.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-efi@vger.kernel.org
In-Reply-To: <20261116002156.1027726-5-maximpedraza@gmail.com>
References: <20261116002156.1027726-1-maximpedraza@gmail.com>
 <20261116002156.1027726-5-maximpedraza@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:51:28 +0000
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
- [Medium] drm/client: splash: stale modeset kept when probe finds no
  connectors
--

commit fb1584c86189774bc202b28de7ab532767373aff
Author: Francesco Valla <francesco@valla.it>

drm: client: add splash client

This commit adds an in-kernel DRM client that displays a solid background
color, an EFI BGRT logo, or a BMP firmware image until userspace takes
over the display.

> diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clien=
ts/drm_splash.c
> new file mode 100644
> index 0000000000000..d54cf628cf17b
> --- /dev/null
> +++ b/drivers/gpu/drm/clients/drm_splash.c
> @@ -0,0 +1,1032 @@

[ ... ]

> +static int drm_splash_init_client(struct drm_splash *splash)
> +{
> +	struct drm_client_dev *client =3D &splash->client;
> +	struct drm_mode_set *modeset;
> +	unsigned int fb_count =3D 0;
> +	unsigned int i, k;
> +	int err =3D -ENODEV;
> +
> +	if (drm_client_modeset_probe(client, 0, 0))
> +		return -EIO;
> +
> +	mutex_lock(&client->modeset_mutex);
> +
> +	/*
> +	 * Collect one scanout per usable modeset, or per tile group. Each
> +	 * scanout records the modesets it feeds by their position in the
> +	 * list, so that the second pass below can find them again whatever
> +	 * was skipped in between.
> +	 */
> +	i =3D 0;
> +	drm_client_for_each_modeset(modeset, client) {
> +		struct drm_splash_scanout *tmp;
> +		struct drm_splash_scanout *scanout;
> +		unsigned int idx =3D i++;
> +		u32 format;
> +		int id;
> +
> +		if (WARN_ON_ONCE(idx >=3D 32))
> +			break;
> +
> +		/* Skip modesets without a mode */
> +		if (!modeset->mode)
> +			continue;
> +
> +		id =3D drm_splash_tile_group_id(modeset->connectors[0]);

[ ... ]

> +	/*
> +	 * And point every modeset at the buffer of its scanout. One left
> +	 * without, whatever the reason, is switched off: a mode without a
> +	 * framebuffer fails the commit, and with it every other output.
> +	 * Never the old one: a probe without connectors leaves it there.
> +	 */
> +	i =3D 0;
> +	drm_client_for_each_modeset(modeset, client) {
> +		unsigned int idx =3D i++;
> +
> +		modeset->fb =3D NULL;
> +		for (k =3D 0; idx < 32 && k < splash->n_scanout; k++) {
> +			struct drm_splash_scanout *scanout =3D &splash->scanout[k];
> +
> +			if (scanout->buffer && (scanout->modesets & BIT(idx))) {
> +				modeset->fb =3D scanout->buffer->fb;
> +				break;
> +			}
> +		}
> +
> +		if (!modeset->fb)
> +			drm_splash_modeset_off(client->dev, modeset);
> +	}

[ ... ]

> +static void drm_splash_rebuild(struct drm_splash *splash)
> +{
> +	struct drm_client_dev *client =3D &splash->client;
> +	int ret;
> +
> +	/*
> +	 * Every hotplug starts over, with the outputs there are now. The
> +	 * scanouts on screen stay there until the work or restore has
> +	 * committed the new ones; with some still waiting for that, the
> +	 * current ones were never committed and can go.
> +	 */
> +	if (splash->old_scanout) {
> +		drm_splash_free_scanout(client);
> +	} else {
> +		splash->old_scanout =3D splash->scanout;
> +		splash->n_old_scanout =3D splash->n_scanout;
> +		splash->scanout =3D NULL;
> +		splash->n_scanout =3D 0;
> +	}
> +
> +	ret =3D drm_splash_init_client(splash);

[Severity: Medium]
Does drm_splash_init_client() rebuild and commit a stale modeset when all
connectors are removed?

After a commit clears splash->old_scanout, drm_splash_rebuild() moves
splash->scanout to splash->old_scanout without calling
drm_splash_free_scanout(), leaving client->modesets populated.  If
all dynamic connectors (such as DP MST outputs) have been removed,
drm_client_modeset_probe() returns 0 before calling
drm_client_modeset_release():

drivers/gpu/drm/drm_client_modeset.c:drm_client_modeset_probe() {
	...
	if (!connector_count)
		return 0;
	...
	drm_client_modeset_release(client);
}

Because the old modeset->mode and modeset->connectors[0] remain in place,
the first loop in drm_splash_init_client() sees modeset->mode !=3D NULL,
reads the stale modeset->connectors[0], and creates a new scanout and dumb
buffer for the removed output, so the final loop sets modeset->fb to the
new buffer instead of calling drm_splash_modeset_off().

Clearing client->modesets with drm_splash_modeset_off() in the else branch
of drm_splash_rebuild() before probing would avoid reusing the old
modeset state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116002156.1027=
726-1-maximpedraza@gmail.com?part=3D4
