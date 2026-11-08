Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C548606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.a=rsa-sha256 header.s=fe-953a8a3ca9 header.b=ibqBwFDu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42CE310E122;
	Sun,  8 Nov 2026 17:31:33 +0000 (UTC)
X-Greylist: delayed 310 seconds by postgrey-1.36 at gabe;
 Sun, 08 Nov 2026 17:31:27 UTC
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC1010E122
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 17:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Cc: To: From: Subject: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1794159086;
 bh=hemgZh0VCBkKkqRpdHvkov2TkhHbiZ6AzcSNbOBw6T0=;
 b=ibqBwFDuc5NwVdo7qAdWyCnHbdi6G4KaYCV1k3dWpxGAy2c8qs1UzXp8Bi5CXI7tjbJQusjOx
 mz9GgjPsoPR0jRlPX7Vyufjx/lSvq1UVok/umr4taPSvpBKnIx1PTL6p2kPUn/Hmr92jE9FiI33
 hhniyrOoTNmFoAvFAcO0syJPdI2+AFbrmkN7rTS7FHqqcD1NZ8UBneeFbfm7E0KakSI95GORqNW
 w+dlyYdHqcrtIL5+FyDmwlCE+tmtdFZa6fAvMt/cN6aAAn10udRUfFfWvkTUmQ6wmWxHXVlzoGG
 mqHYFBcQ7CXQWDL47Ktq4YSmwHAxICou1ZEgIb/IC9nw==
X-Forward-Email-ID: 6af0b0b4af4d9019958770cd
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.13
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Sun, 08 Nov 2026 12:26:10 -0500
Message-Id: <DMQ07CEZJVG0.230CONY47IYFZ@ubuntu.com>
Subject: Re: [PATCH 0/3] drm: remove drmm_of_get_bridge()
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Sasha Finkelstein"
 <k@chaosmail.tech>, "Janne Grunau" <j@jannau.net>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Dmitry Baryshkov" <lumag@kernel.org>
Cc: "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <asahi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com>
In-Reply-To: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 6, 2026 at 11:17 AM EST, Luca Ceresoli wrote:
> drmm_of_get_bridge() is deprecated. By now it is just a complicated wrapp=
er
> to of_drm_get_bridge_by_endpoint(), and it does not implement bridge
> refcounting. Replace the only user and remove it.
>
> =3D=3D Grand plan
>
> This is part of the work to support hotplug of DRM bridges.
>
> Here's the work breakdown (=E2=9E=9C marks the current series):
>
>  1. =E2=9E=9C add refcounting to DRM bridges struct drm_bridge,
>       based on devm_drm_bridge_alloc()
>     A. =E2=9C=94 add new alloc API and refcounting (v6.16)
>     B. =E2=9C=94 convert all bridge drivers to new API (v6.17)
>     C. =E2=9C=94 kunit tests (v6.17)
>     D. =E2=9C=94 add get/put to drm_bridge_add/remove() + attach/detach()
>          and warn on old allocation pattern (v6.17)
>     E. =E2=9E=9C add get/put on drm_bridge accessors
>        1. =E2=9C=94 drm_bridge_chain_get_first_bridge(), add cleanup acti=
on (v6.18)
>        2. =E2=9C=94 drm_bridge_get_prev_bridge() (v6.18)
>        3. =E2=9C=94 drm_bridge_get_next_bridge() (v6.19)
>        4. =E2=9C=94 drm_for_each_bridge_in_chain() (v6.19)
>        5. =E2=9C=94 drm_bridge_connector_init (v6.19)
>        6. =E2=9C=94 protect encoder bridge chain with a mutex (v7.2)
>        7. =E2=9C=94 of_drm_find_bridge
>           a. =E2=9C=94 add of_drm_get_bridge() (v7.0),
>                convert basic direct users (v7.0-v7.1)
>           b. =E2=9C=94 convert direct of_drm_get_bridge() users, part 2 (=
v7.0)
>           c. =E2=9C=94 convert direct of_drm_get_bridge() users, part 3 (=
v7.0)
>           d. =E2=9C=94 convert direct of_drm_get_bridge() users, part 4 (=
v7.1-v7.2)
>           e. =E2=9C=94 bridge-only drm_of_find_panel_or_bridge() users (v=
7.2)
>        8. =E2=9E=9C panel_bridge lifetime
>           a. =E2=9C=94 cleanup DRM_PANEL in bridge drivers (v7.4)
> 	  b. =E2=9C=94 embed a drm_bridge in every drm_panel (v7.4)
> 	  c. =E2=9C=94 remove *_of_get_bridge(): non-OF drivers (v7.5)
> 	  d. =E2=9E=9C remove drmm_of_get_bridge()
> 	  e.   remove devm_drm_of_get_bridge()
>        9. =E2=9C=94 enforce drm_bridge_add before drm_bridge_attach (v6.1=
9)
>     F. =E2=9C=94 debugfs improvements
>        1. =E2=9C=94 add top-level 'bridges' file (v6.16)
>        2. =E2=9C=94 show refcount and list lingering bridges (v6.19)
>  2. =E2=9C=94 handle gracefully atomic updates during bridge removal
>     A. =E2=9C=94 Add drm_bridge_enter/exit() to protect device resources =
(v7.0)
>     B. =E2=9C=94 Add drm_bridge_clear_and_put() (v7.1)
>  3. =E2=9C=95 DSI host-device driver interaction
>  4. =E2=9C=94 removing the need for the "always-disconnected" connector
>  5. =E2=9C=94 Migrate i.MX LCDIF driver to bridge-connector (v7.2)
>  6. =E2=80=A6 DRM bridge hotplug
>     A. =E2=80=A6 Bridge hotplug management in the DRM core
>        1. =E2=9C=94 bridge-connector: attach encoder to the connector (v7=
.2)
>        2. =E2=80=A6 drm bridge hotplug
>     B.   Device tree description
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Luca Ceresoli (3):
>       drm: adp: stop using deprecated drmm_of_get_bridge()
>       drm/panel: remove drmm_of_get_bridge()
>       drm/todo: remove drmm_of_get_bridge()
>
>  Documentation/gpu/todo.rst    |  1 -
>  drivers/gpu/drm/adp/adp_drv.c | 13 +++++++++----
>  drivers/gpu/drm/drm_panel.c   | 40 -------------------------------------=
---
>  include/drm/drm_panel.h       | 10 ----------
>  4 files changed, 9 insertions(+), 55 deletions(-)
> ---
> base-commit: 4524052b65a75166c1c557921c786bd82302de13
> change-id: 20261106-drm-panel_bridge-remove-drmm_of_get_bridge-791bd0f0ad=
97
>
> Best regards,
> -- =20
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Looks good

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
