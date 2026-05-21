Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B33CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC5C10F296;
	Thu, 21 May 2026 08:53:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="PFgyvUoy";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1481E10F296
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=lIANK9NUM9W+87JOtkW8OhYgCqMdUmArmDFCwLaPCiw=; b=PFgyvUoyIkbP3WD+JgXrWZQrWW
 OjhoPOCwzYv8Yr/GgLBgRZJrTkSVWgyNtXcUjle2DKCWgrHd96KFDmoHdwvR7/fWBKylOnc2Vvxz8
 9EUEs7jFB4m34Qr5fMs6TET5gSkQne8opF3KS4jTyB8kCrerm4vKIbRWV+Su6KvlpF2rlmCEK0NFw
 eEqEl/gCzS5gVBpBn5jq2M8l0XzBnb3Lc0qD/QvljmJXbh64Kp6LJMsPi3P4HejVKB1DB6OQe+Wyu
 ZOXQtNHg5lMTYqjgaC+9NpSbisrgpr9jN/v7Ts4lD6MH5Z8Wuhr/QCxA14GKXIira9dcOLTxhO1hO
 aWBkHI8w==;
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Andy Yan <andy.yan@rock-chips.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Daniel Stone <daniels@collabora.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/8] drm/bridge: dw-hdmi-qp: Use the common TMDS char
 rate constant
Date: Thu, 21 May 2026 10:53:08 +0200
Message-ID: <9954706.gsGJI6kyIV@phil>
In-Reply-To: <20260520144424.1633354-4-javierm@redhat.com>
References: <20260520144424.1633354-1-javierm@redhat.com>
 <20260520144424.1633354-4-javierm@redhat.com>
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

Am Mittwoch, 20. Mai 2026, 16:43:39 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Javier Martinez Canillas:
> Replace the driver local HDMI14_MAX_TMDSCLK define with the shared
> constant defined in the <linux/hdmi.h> header.
>=20
> The local define incorrectly referenced HDMI 1.4, but the 340 MHz
> maximum TMDS character rate was actually introduced in HDMI 1.3.
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


