Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B17C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D827E10E3FD;
	Thu, 27 Aug 2026 13:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="Z7Shld41";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2C010E3FD
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=8JGwotRkiWHKaCQu9jDkWstXKW98P1ozDtsr5f79/wg=; b=Z7Shld41GBbQhCCHjQgbTvoFJF
 Owu0drTeyDwirLS9U20iq62QKzXBOzCgydW+NadTXkhwPgphoPafXgihX35BMPR3cAUiDXSphWZfj
 /6Fx/At6b4ZPmhb6SiRZ1UrDSwn85ORdc464rSbEPCJASVTwn5SbEICKi747fJMfFAfK9YmsSGBA/
 nCfGBen0n0ttglnA3K2sTBP4KnvDAtoTHnAjHJPQVSMZqUbk7N6Y78bacIxe9eIvK8nGIXBU1jeRd
 ZGMd8F0Dl4TirZiGIW0hCREq/hqlpEt5kdeG8htTfM+NJ30tyFvZ57f/pZ0PwPPVRKiJY1IURD9j9
 94LQNSPQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 62/70] drm/rockchip: vop2: Convert to atomic_create_state
Date: Thu, 27 Aug 2026 15:32:01 +0200
Message-ID: <14080784.uLZWGnKmhe@phil>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-62-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-62-fb793475c05a@kernel.org>
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

Am Freitag, 21. August 2026, 16:39:38 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Maxime Ripard:
> The rockchip vop2 crtc implementation provides a custom reset hook.
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


