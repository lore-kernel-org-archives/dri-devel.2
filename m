Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6592DCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A3F10E4C4;
	Mon, 12 Oct 2026 06:40:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C91110E4AD
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:40:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 698EE60AA1;
 Mon, 12 Oct 2026 06:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982AE1F0089B;
 Mon, 12 Oct 2026 06:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791787237;
 bh=+hh4i2moavrGqPX1n2c2RQbAaD9fjE5awV5cn9mPTwY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fXdRBOaMG4LWZ/2UNKOjJHXzXsjEEdugfLfJYCZGs2lMAQVa2x7W+HihvaplfEacq
 7IbI+fvuLpPPZAeu2/21ZUbXm0jO8tNgsefFbWZPZeo3rryEwk7zayhX6jf9HUjtn/
 WnlFpv6C5Hv9nQSTySBgN/AnvwMVShGffMJDl5l46fP/jRWeY2csVxwP/ZyOz38yZL
 JNSQeIkRmDrZ+FBwUNp9v5FnV9/XjE3e6TZ7zHOYF3KRR6vAGspQ2jaojWVxTTURB0
 rLa5R1i+nzS0xFDtZzTUTED+qgJd/qQV+Gt/WPn8Rexq+NWIAIHFE6/zAo1JxZpRfT
 wLDQHjABJtivw==
Date: Mon, 12 Oct 2026 08:40:33 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Val Packett <val@packett.cool>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] drm/panel: add atomic state
Message-ID: <asyAObcpbFy3OeE2@houat>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="hjbswlulvbwt55yj"
Content-Disposition: inline
In-Reply-To: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--hjbswlulvbwt55yj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 0/9] drm/panel: add atomic state
MIME-Version: 1.0

On Thu, Oct 08, 2026 at 04:14:22PM +0300, Dmitry Baryshkov wrote:
> Panel drivers don't have an atomic state and so they can't handle
> additional data to be stored at the atomic_check time or to be retrieved
> at the enable/disable time. For example, it prevents panel drivers from
> supporting multiple display modes or making DSC being optional in a
> clean way. Drivers like panel-novatek-nt35950, save the connector
> pointer in get_modes() and later dereference
> connector->state->crtc->state from prepare() without holding any locks.
> The panels also have no way to reject the configuration they cann't
> handle, as it doesn't take part in the atomic check.
>=20
> The panel already embeds a drm_bridge, and the bridge has an atomic
> state which is property handled. Subclass it to provide atomic state for
> the panels. The callbacks can find the state of the other related
> objects (e.g. CRTC state to get the display mode).
>=20
> The atomic state is opt-in. A panel that doesn't implement the state
> callbacks keeps working exactly as before, with the plain bridge state,
> so there is no need to touch the existing drivers. The panels which do
> implement them can only be driven through the embedded bridge, since
> there is no commit to hand over when the host calls drm_panel_prepare()
> and friends directly. Those entry points warn and refuse to handle such
> panels. There are still a dozen of display drivers calling these
> functions, and the panels used with them can not be converted until the
> hosts are switched to the panel bridge.

I really don't think we should extend the panel API. All panels are
bridges now, consumers only care about bridges as well, and the bridges
API provides what you want already.

Why not simply turn the panel drivers we want into bridges, possibly
with a bunch of specialized helpers to manage a panel state, and call it
a day?

Maxime

--hjbswlulvbwt55yj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCasyA3QAKCRAnX84Zoj2+
ds8VAX4iLOr+i95wQQ2TEBtzi+Nu8K8umIW4GcZ4OjJ36hZ+u+qwcByShXAbYA53
8a6SJLMBgNYv/aCiJAjGcMe8sPjtzRy5XUqYsKrIHhZVX29GqIkmxtUxqNgYWrUF
Z+ps/5hToQ==
=SZYX
-----END PGP SIGNATURE-----

--hjbswlulvbwt55yj--
