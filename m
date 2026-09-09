Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7670AC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8862D10F04B;
	Wed,  9 Sep 2026 09:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mOq8ErS2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF2510F046;
 Wed,  9 Sep 2026 09:22:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D16DC60207;
 Wed,  9 Sep 2026 09:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E156A1F00A3A;
 Wed,  9 Sep 2026 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788945722;
 bh=v53rzWyS13XTz69Dwg/DhTgxsIt2jqdB9b+1/3rZChc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mOq8ErS2hNxgK0ov2PCtLDXn9jYA5B/pm0j81J4vaxkdsOyH7l+Ql+hFiks1Zofg1
 WlQOwGainPvluwc3ycqmQieNHVffk2rplWRS8ojfNERm7kkhj12YSTj6jW6SQbClN5
 ktWHVyRh7IM6OI1ELXaQCsr8YsQm0QsbrsQDGPzRqT14bFF4sWnbmUBYKcf03amwUn
 d33t/EVxXSUG67PJ5UUWqf+NrZcmH3mddV0rYvYGQgmDTBoEPGq94+DrEt7I1XKtqB
 WzLv5mo2E2Cp/mCTylP6WqXfV1YBVZ0Xn83yesJG9w7b0pfy3IE06tU8G9LvGqU9RK
 km/QbrN1R/e5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/14] drm/panic: Restrict to primary planes
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, gary@garyguo.net,
 "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 "Eugenio
 Perez" <eperezma@redhat.com>, intel-xe@lists.freedesktop.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com,
 intel-gfx@lists.freedesktop.org, Frank.Li@kernel.org,
 linux-hyperv@vger.kernel.org
In-Reply-To: <20260909085826.64529-11-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:22:01 +0000
Message-Id: <20260909092201.E156A1F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> Restrict panic handling to primary displays. Overlays and cursors
> should not display panic output. If there are exceptions, they can
> be registered by the driver itself.
>=20
> v3:
> - also update drm_panic_is_enabled() (Sashiko)
> - still do some testing when unregistering (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D10

