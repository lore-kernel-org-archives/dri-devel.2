Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CB7C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C23310EC18;
	Tue,  7 Jul 2026 11:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ezf84Llt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC8F10EC18
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 11:54:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5AB86001D;
 Tue,  7 Jul 2026 11:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9521F000E9;
 Tue,  7 Jul 2026 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783425259;
 bh=cde7EGjkh7kZ2OJwc7zRN79PZ5XA/VInzcgH4bhaDrg=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=ezf84LltunYnZKSTsB2qmEJ2qWujDFbhkA42F2bLhEmhhnh9Y6HSYoOzp2qiv7vre
 tDXXy0o1XQTf6kEAEwnIF5sIxcGNihM56PnAsn8PdyHUJJtcb86/G7pdQIvPOmA/tP
 SQrwiOZKJizTMhUgccccFv0+vo/ltwzJZe+BdZHYWp1752AlTgI3dXt8qEQ7q+FsdL
 xE9MfmijT8Epfv+tULWPTK4CRp2vSgMJkDHTKrwIBRUfBZWROOF2+LRIIs9pej76X2
 wHU/fnLFcvZGkP+4nstYRB+Cnv/gXXGKElo0SFTheFtFAaF+ey1Ws/w9F844T19oIB
 8RAFlX9YKZuTA==
Message-ID: <4db33012cf6f1251614bfefb67017e3c@kernel.org>
Date: Tue, 07 Jul 2026 11:54:16 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v8 01/39] video/hdmi: Introduce HDMI version enum
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-1-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-1-d79890d00b6a@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Andy Yan" <andy.yan@rock-chips.com>, "Daniel
 Stone" <daniels@collabora.com>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "David
 Airlie" <airlied@gmail.com>, =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
 "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, 
 =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Raspberry
 Pi Kernel Maintenance" <kernel-list@raspberrypi.com>,
 "Robert Foss" <rfoss@kernel.org>, "Sandy
 Huang" <hjc@rock-chips.com>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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

On Thu, 2 Jul 2026 17:46:14 +0300, Cristian Ciocaltea wrote:
> Add an enum to represent HDMI specification versions.  This will be used
> by upcoming changes to associate HDMI connectors and bridges with a
> maximum supported version and to simplify handling of version-dependent
> features.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
