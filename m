Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C78CD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 15:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C881A10F206;
	Tue,  2 Jun 2026 15:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="tCCPLV4L";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5536E10F206
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=68aw9nb4q0stqQVYhsOszbGTbnXtGY6XRboQ2RvC+iU=; b=tCCPLV4Ll3PC3M8OIZgaFAthIE
 N4sj64Ftlvbik5gdtIOilPnMMrepTmwHdG4vJF/9GPYQk8y7y7TdXDJ3W1CjMu0aEeWjCgkBQrhB3
 84YZRpYvFGuRAscZh+iZpZurJHjc9T4MykpfjxbmdiONq5XN2deFuFJOz4t+ZUFUGv0ykUHI4qW1I
 bmsr5yrU0zw099qoRUQ2EKnSI5S3qBqu0+ChxXjYwoPrTXET2tGTyNRc4iX6bj2kdeft6JFs9rn6d
 V9F6qQRZQ1SNxYlEqDR6euUuJU2GFdPAEgDon1I7ldICCqap6CsEi+oWIRuFY6rKIHFI23ESY1KuH
 orVoC48Q==;
From: Heiko Stuebner <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 Maxime Ripard <mripard@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 63/76] drm/rockchip: rk3066_hdmi: Switch to
 atomic_create_state
Date: Tue, 02 Jun 2026 17:02:54 +0200
Message-ID: <3645200.7aRn1RRit1@phil>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-63-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-63-875d828d31bc@kernel.org>
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

Am Samstag, 30. Mai 2026, 16:00:08 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Maxime Ripard:
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
>=20
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

having looked at the first parts of the series adding
the new functionality, this change looks good:

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



