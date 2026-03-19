Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F71E1090223
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF93210E97B;
	Thu, 19 Mar 2026 13:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BI0UppmV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94FEA10E97B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 13:20:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CF79D60097;
 Thu, 19 Mar 2026 13:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31898C19424;
 Thu, 19 Mar 2026 13:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773926433;
 bh=dFNCoB+OTvypkD2hCF907kjKiuMgY6mxgJCx8Z225YA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BI0UppmVh84xRnAWlYINgjL7AZ7lNQoaH2vDgf0QBYu8//8cFiCyQ4bboJ1iOoM1t
 g46xh446UX82uh5A62oLhHKD1M8sKTxg6Iqg+2IR6qOxcz43p3txdzxvG3e9vz2xOt
 +h+P26qnUtlMtLNRET348B+eO2vK4rCDO8TXj7S8peeYRXFHn81FYyKGbKg8eGTBny
 IXbG4A53ecwF9x4ZSkCAu45fpZi7BOZ3nf0vBgI99zha4HeSIIV1T/uLVEL1FsRx38
 K2t5U4UeebwSUYHs0ym1n5aGyyKWLPsl9m2nzvkC8y1leBqPT9tnx8OXRRYYw+72+k
 MNJirhQemJLYQ==
Date: Thu, 19 Mar 2026 14:20:30 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 01/14] drm/atomic: Document atomic state lifetime
Message-ID: <20260319-analytic-purring-kittiwake-ca04fa@houat>
References: <20260310-drm-mode-config-init-v1-0-de7397c8e1cf@kernel.org>
 <20260310-drm-mode-config-init-v1-1-de7397c8e1cf@kernel.org>
 <b0d9aee3-46c1-486d-9516-43ee23658f40@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ekgjblyw25gmfu6n"
Content-Disposition: inline
In-Reply-To: <b0d9aee3-46c1-486d-9516-43ee23658f40@ideasonboard.com>
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


--ekgjblyw25gmfu6n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/14] drm/atomic: Document atomic state lifetime
MIME-Version: 1.0

Hi Tomi,

Thanks for your review

On Wed, Mar 11, 2026 at 08:44:24AM +0200, Tomi Valkeinen wrote:
> > + *
> > + *     At that point, &struct drm_atomic_state stores three state
> > + *     pointers for that particular entity: the old, new, and existing
> > + *     (called "state") states. The old state is the state currently
> > + *     active in the hardware, which is either the one initialized by
> > + *     reset() or a newer one if a commit has been made. The new state
> > + *     is the state we just allocated and we might eventually commit to
> > + *     the hardware. The existing state points to the state we'll
> > + *     eventually have to free when the drm_atomic_state will be
> > + *     destroyed, but points to the new state for now.
>=20
> From this, I don't understand the difference between the old state and
> the existing state. And if the existing state is the one we'll free,
> isn't that the old state, not new state? Oh, is the existing state a
> state we have to free when the drm_atomic_state would is freed? And at
> this point the new state is the one, as it's not committed?

Thanks for pointing it out, I need to update this part. state is never
the active one, because drm_atomic_state disappears(ish) when the new
state is committed and thus, by the time an object state is active,
there's no drm_atomic_state to hold it anymore.

When a new drm_atomic_state is allocated, and we call
drm_atomic_get_$OBJECT_state, old state is filled with the current
active state, new state is filled with a copy of it we can modify.

The third pointer (that used to be called state) points to the state we
need to destroy if we destroy drm_atomic_state. Before atomic_commit,
it's the new state we didn't commit (probably to do an atomic_check).
After atomic_commit, the new state has become the active state, and we
need to destroy the old state (the state that got replaced). That
pointer is now called state_to_destroy which should be more obvious.

> > + *     state pointer (&drm_crtc.state or similar) to point to the new
> > + *     state, and the existing states will now point to the old states,
> > + *     that used to be active but isn't anymore.
>=20
> "aren't"
>=20
> I think I understand this, but... It kind of brings in a new state
> concept, "active state".

The active state is never really held by drm_atomic_state but by
drm_$OBJECT->state. drm_atomic_state is really more of an update
description (so something that might eventually become active) rather
than the actual active state.

Maxime

--ekgjblyw25gmfu6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCabv4FgAKCRAnX84Zoj2+
dlQsAYDR7vzmTwt1JEEv/HF8KAR9NNmfn3X6jRBwoBEB/S50xkW90weJ8uOC4KkW
Bf35htABgLyQ4IYaMs06JFIkUjAQGwanCw9lq/ykEJohuZQeKiHG0wJ3tzCNJ1zE
CE9cOqGIyQ==
=7bK3
-----END PGP SIGNATURE-----

--ekgjblyw25gmfu6n--
