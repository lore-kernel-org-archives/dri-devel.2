Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06514F9936C
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32A5510E34C;
	Thu, 23 Apr 2026 11:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l3yN+WKn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AD610E34C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 11:04:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 333E3405DB;
 Thu, 23 Apr 2026 11:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EEFC2BCAF;
 Thu, 23 Apr 2026 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776942283;
 bh=sITD6K4FM8fY6kaB689jIXYDNw7WiVsPLgQ9oVT+7Ow=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l3yN+WKnKz2vRHRRxclqvbHVJRdnSWyUNNljCbc92bJtvovBqeez+ME4L1TWhtxBY
 0TCnWz+HtOp6cGJKfGYOWXnbL6Jb8LFTixSmBliy3bH4hhyoYruqttbJsFoB/rcco7
 50LYgV7S6P4EY6gEX4oWDZrlAchzVsE4IpCKsmHqb9VIO/P1Awxx4oWIPJi+p1GhNN
 WscBjqENZNopsALF0gpAGkgF+c6D4I6WOEZXhZov4mMUs0V0IjerDG0SRc1GOB4yaP
 lfnVtnT3UBVZrEv5nwMbkHYG1ff6TwRrMlaqHFqtFnU+z71TAmlG17KL5z6wQJ54JQ
 DLRiRPxdHPEhA==
Date: Thu, 23 Apr 2026 13:04:40 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 00/28] drm: Implement state readout support
Message-ID: <20260423-wealthy-moth-of-youth-0858a5@houat>
References: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
 <28caaa3e416c13af6745fedb213dc6eed29feb46@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="cpuxzjj3qscfryao"
Content-Disposition: inline
In-Reply-To: <28caaa3e416c13af6745fedb213dc6eed29feb46@intel.com>
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


--cpuxzjj3qscfryao
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/28] drm: Implement state readout support
MIME-Version: 1.0

Hi Jani,

On Thu, Apr 23, 2026 at 01:50:59PM +0300, Jani Nikula wrote:
> On Thu, 23 Apr 2026, Maxime Ripard <mripard@kernel.org> wrote:
> > Here's a series that implement what i915 calls "fastboot", ie,
> > initializing the initial KMS state from the hardware state at boot, to
> > skip the first modeset if the firmware already set up the display.
>=20
> FWIW, in i915 we also use the state readout for atomic commit
> verification. Write software state to hardware, read hardware state
> back, compare with the original state, complain if there's a difference.

I know, and this series implement it as well. Is there anything you
wanted to point out in particular?

Maxime

--cpuxzjj3qscfryao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaen8xwAKCRAnX84Zoj2+
dsEMAYDvmjLDDxSj8+fBFa7maFJJtCLHx+F0Z1oM4J+KGRXAbF3c/321x/yAqXq3
B0EAylgBgKm07c6iuR/ivpcsvzMSwbM/JvVQ9TcPX7K55LVrU+h8VnN2QfOkdJaT
cZGsmE+z5w==
=f4Da
-----END PGP SIGNATURE-----

--cpuxzjj3qscfryao--
