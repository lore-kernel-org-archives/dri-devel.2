Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16180C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B7310F01C;
	Thu, 27 Aug 2026 13:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="rOivDsEN";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998D010E3FD
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=vJotwYLVTTd7E25BPLW3hIqQUafjuUGEm5hC3B0d5Y0=; b=rOivDsENxxv4zLEMzxJjXX9P9+
 hiwqwXFl0kDa+K6pC1wCGYNr8h7aOiZCKsXlZwnOerdbEH15ezeV/bC0Qmr2E5kdBqf7Ml9VhCRgW
 ALVBoo9/O2KknxkKt0N/ndrLEzmP65Ah+vGVIWKlSYBMZ0fUI53xXZ7NUQQ1rOyyW3OKcKX+1dqOk
 XfIL+/AhQqNqzqKxvancYUVSzlRe93ypIG3KbihC0GlsSE1JArYVeZgDqYqPiwOj1hUJIjOS8vUVF
 ozU5JiFr1tg1rv7V3P1aqLxdaKQQ0B1viZDhNEcv+se1lzMPC4masLU+CFROZKOIscZmMggvhzvjm
 RTOyBbeA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 61/70] drm/rockchip: vop: Convert to atomic_create_state
Date: Thu, 27 Aug 2026 15:32:06 +0200
Message-ID: <3059456.e9J7NaK4W3@phil>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-61-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-61-fb793475c05a@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Freitag, 21. August 2026, 16:39:37 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Maxime Ripard:
> The rockchip vop crtc implementation provides a custom reset hook.
> However, this hook only allocates the state, initializes it with
> __drm_atomic_helper_crtc_reset(), and frees the previous state. It
> does not perform any hardware reset.
>=20
> Since this is exactly what the atomic_create_state hook is meant to
> do, minus the old state cleanup which the caller handles, convert the
> implementation to use atomic_create_state with
> __drm_atomic_helper_crtc_state_init() instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


