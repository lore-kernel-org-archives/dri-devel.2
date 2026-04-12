Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B22E937EF
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788E510E08E;
	Sun, 12 Apr 2026 16:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=electricworry.net header.i=@electricworry.net header.b="eSbxZMgm";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="p4yBrzhC";
	dkim-atps=neutral
X-Greylist: delayed 821 seconds by postgrey-1.36 at gabe;
 Sun, 12 Apr 2026 16:50:13 UTC
Received: from d218-9.smtp-out.eu-west-2.amazonses.com
 (d218-9.smtp-out.eu-west-2.amazonses.com [23.249.218.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C357A10E08E
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=xxcsvipqs5hvfd7f74n2i5bueyncqkjk; d=electricworry.net;
 t=1776011790;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:Date:Message-Id;
 bh=2Owhh8ay/Hkw+E9qnB8mKWylDEfKMe4CFm7D3qZvZEk=;
 b=eSbxZMgmvPACi/iZ4M6WoLQkSdDBCdcdDaTX6IuhZy9e/2PEA6m8GyxNJv7NpwL2
 Vrp04OYazCKK6uWyLlE1tklfDkH3HNO1UbH4gpUR0RbtRM991kvPvf4HctwWKHEoRJy
 HeQwsQCyDD+aKhWn48/6LyhN5k9PGAYrsO3EfixVQNuL/w+Rb1mBDwM0r0wDLm65Wl1
 xFqA5d3PtLRDR3Cr4WMK8CL50cufsQKlX48RFYx5eh+fK73YGoRv/CAVucd1fcFavx7
 6liipXY8Z6zrppkn5mLmyD5e9VtFGIv2GKqBlAcUq1timW9W0FuD3BmqRNgiu0T8qEb
 O4T7WoqrnA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=smjs5bczbyxi6u2ua6eveuxqal7joyry; d=amazonses.com; t=1776011790;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:Date:Message-Id:Feedback-ID;
 bh=2Owhh8ay/Hkw+E9qnB8mKWylDEfKMe4CFm7D3qZvZEk=;
 b=p4yBrzhC0XK9xgqDU65wcuMAmut7mRU8M8XYJYys5shtaoYD2J36sxA5xOMXuy7V
 ogdeWsk8QzmWftUPWHv3dBJJHeNK5NPf3H5pdFe/S+F/KH1ZwdFtllc3P+WVyQ1mjs1
 58Vj1Eq6RQXTAsC9YU9EaPrdduOwUrHJ7HiaSOxA=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 00/13] drm: bridge: dw_hdmi: Misc enable/disable,
 CEC and EDID cleanup
From: Bob McChesney <bob@electricworry.net>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260403185303.80748-1-jonas@kwiboo.se>
References: <20260403185303.80748-1-jonas@kwiboo.se>
Date: Sun, 12 Apr 2026 16:36:30 +0000
Message-ID: <010b019d828d48d5-7e91ae13-5255-482b-9ab9-13ba7c658d5a-000000@eu-west-2.amazonses.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776011787; l=663;
 i=bob@electricworry.net; s=20260412; h=from:subject:message-id;
 bh=2Owhh8ay/Hkw+E9qnB8mKWylDEfKMe4CFm7D3qZvZEk=;
 b=pbhBrpuvZhNHk8mohJtNg8gIXGkmbH2kTjGWQh+JeFKVyiBJLFoKcobP/qY9jrbDm4ItxfDpZ
 juLaegbKcldAYaHKSg5wiA2ML7v1Rkkur1DdY9v0COKHvXP+RAeFPqL
X-Developer-Key: i=bob@electricworry.net; a=ed25519;
 pk=CGakLk53ReX5zp/z2XgijzXWf7g5UEJMrdaP8LNZltE=
Feedback-ID: ::1.eu-west-2.gfFyncE+PRqcG/qebM3Lg+wfopUKzk5aGDEiDVENH+o=:AmazonSES
X-SES-Outgoing: 2026.04.12-23.249.218.9
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

On Fri, 03 Apr 2026 18:52:46 +0000, Jonas Karlman <jonas@kwiboo.se> wrote:
> drm: bridge: dw_hdmi: Misc enable/disable, CEC and EDID cleanup
> 
> This is a revival of an old dw-hdmi series and is the first series part
> of a new effort to upstream old LibreELEC HDMI 2.0 patches for Rockchip
> RK33xx devices.
> 
> This series ensure poweron/poweroff and CEC phys addr invalidation is
> happening under drm mode_config mutex lock, and also ensure EDID is
> updated after a HPD low voltage pulse by changing to debounce hotplug
> processing.
> 
> [...]

Tested-by: Bob McChesney <bob@electricworry.net>

-- 
Bob McChesney <bob@electricworry.net>
