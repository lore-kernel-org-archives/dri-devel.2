Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FE7C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536B810E156;
	Wed,  9 Sep 2026 14:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z7QMs4Ri";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E1010E156
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 14:28:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4ABCB43CF2;
 Wed,  9 Sep 2026 14:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FED01F00A3A;
 Wed,  9 Sep 2026 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788964126;
 bh=oj01JFfB6AavahYppTc9T4EaPEzdF+98Q38ewNDpUTY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Z7QMs4RiqWS030pqfJQFKcD4kpDjcDp9BD5a+akwoYLqcUihHv+wSZ6QhT0us4Ivx
 na8itMh1dn35cgoDZE7Z6YvcVVOtBzcXk9tDFNZs6aaQFijXwVCnTmpplCq3jQrp69
 Zm0FQd/eFwcb2/eXBhnoPHXpIEtOl58BkbyXyLiZLpzsqLzBcyLOu8bF69rvZIZcU7
 HoeL79Z/qDBO3qBe/fQnhB5yOR1wgneYTr9XlTk/T5lqf4IBT5Xpyg5aQSMY3IkQ11
 tstkpmU9RfUkygK+f1e+l4DfhNj4l46RU299qS29x4XBWbzJ1ZhHeTlajAMluRH4Gl
 /KdgW/jOcGFxw==
Date: Wed, 9 Sep 2026 16:28:42 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Albert Esteve <aesteve@redhat.com>,
 Anusha Srivatsa <asrivats@redhat.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
Message-ID: <aqFsTzyf1YbQkh6W@houat>
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-5-2ab8ee24538e@bootlin.com>
 <678ddef7e56703d9adffff5c490d4857af515343@intel.com>
 <aqEqx0zBQgmUgwqL@houat>
 <3efb06a30baae6ba1bfcf2be449bf207a30f674d@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="xvg2t2buvlbvtces"
Content-Disposition: inline
In-Reply-To: <3efb06a30baae6ba1bfcf2be449bf207a30f674d@intel.com>
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


--xvg2t2buvlbvtces
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
MIME-Version: 1.0

On Wed, Sep 09, 2026 at 05:02:58PM +0300, Jani Nikula wrote:
> On Wed, 09 Sep 2026, Maxime Ripard <mripard@kernel.org> wrote:
> > I really wish i915 was at least *trying* to fit within the larger model
> > basically everybody else uses. I understand that it's a large
> > undertaking and regression prone and everything, but I'm also concerned
> > about having the "we can't because of i915" or "supported by everybody
> > else but i915" on a regular basis now.
>=20
> Okay, let's hear it, please name a few things where i915 is alone in
> doing something bonkers that amd, radeon, nouveau also don't do, and
> what would be the changes that would bring i915 closer to everybody
> else?

Where did I say "bonkers"?

But since you're asking, because it doesn't implement .reset, we had that
conversation this week for

https://lore.kernel.org/r/20260908-drm-reset-state-flag-v3-0-905570f387a4@k=
ernel.org

Maxime

--xvg2t2buvlbvtces
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqFtDwAKCRAnX84Zoj2+
doBSAX46K8ejTapIIYk/SeycKWdQwI0tlzsXrMG+ZW7UOhK2h/7KaVEyj4ZDsGjK
dz9VoPgBfAiC3uX8Vw2zw6OMzOZKaidwZ1GSyeGkNSFBaiRnGT6VYthRJkFjw6Kp
CxhOEjtOwg==
=l7Kh
-----END PGP SIGNATURE-----

--xvg2t2buvlbvtces--
