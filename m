Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C760A2619
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D86EFEVr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99E311268B;
	Thu, 19 Nov 2026 18:03:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1431126B3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 18:03:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2740447538;
 Thu, 19 Nov 2026 18:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9A51F000CD;
 Thu, 19 Nov 2026 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795111395;
 bh=WfNp269qSRTYdyFZb33AO8G57nZw5BQB8j9hQphUqtM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D86EFEVrT1VAwdCOlILnTcVczjgTtwFNifeDeAD0zwKHjnL0N7VTcNn7IvmKHK6d5
 lVawEZkSufwJR+FN15FDKx2hDu3kahh5ooYiEVt0/3zC8RODfuWu0EmB1VtOu0QTZu
 qT4IAXuGlBKySCSaKYWD/AhrTJV2t2DchupgI6Uis6TxySaU3tqh0FzOjk4fD8CCGZ
 AedGbIzCD6SkadCZ+qz/CASCtgjQm+EklVtor3mz/hiFmLIS0Q2C1aLj0MRv5Ka041
 zjwc8E4qoZiapD4ZOgZp7hpSSOl4XoV4K1jxTBJmp4eLYMXflf2BhKtk7q2SUEhTxK
 YID3LuVl+IYYQ==
Message-ID: <sashiko-outbox-223750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] drm/sun4i: Reject fractional source coordinates
 without scaler
To: "Jernej Skrabec" <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261119175437.2520400-2-jernej.skrabec@gmail.com>
References: <20261119175437.2520400-1-jernej.skrabec@gmail.com>
 <20261119175437.2520400-2-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:03:14 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/sun4i: missing Fixes trailer for fractional source
  coordinate check
--

commit 6372f45de588428ede3ebc1410bcfe779db4f206
Author: Jernej Skrabec <jernej.skrabec@gmail.com>

> drm/sun4i: Reject fractional source coordinates without scaler
>
> The layer code programs the scaler whenever the source rectangle has a
> fractional offset, since only the scaler can apply a sub-pixel phase.
> drm_atomic_helper_check_plane_state() with DRM_PLANE_NO_SCALING doesn't
> catch that: it only compares the scaling factor, which may still be
> exactly 1.0 with fractional source coordinates.
>
> Channels without a scaler would thus have the non-existent scaler
> programmed instead of an error being returned. Reject fractional source
> coordinates on such channels.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

[Severity: Low]
This fixes the scaling check introduced when hardware scaling support was
added to DE2.  Should this include:

  Fixes: b862a648de3b ("drm/sun4i: Add support for HW scaling to DE2")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119175437.2520=
400-1-jernej.skrabec@gmail.com?part=3D1
