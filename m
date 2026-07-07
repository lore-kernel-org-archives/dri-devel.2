Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086EBC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E04010E4F5;
	Tue,  7 Jul 2026 15:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mWOeqBh+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACC28930B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:26:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06960600C3;
 Tue,  7 Jul 2026 15:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410AD1F000E9;
 Tue,  7 Jul 2026 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783437973;
 bh=MZ56DDrZ444AnzoDnctarAM6nsaXJcoaH8VJdC05tTg=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=mWOeqBh+cvwgYCKLrNp7nIO0QQXbUmqfZniCfZdCn5+Oji4sKSuNR1J+w7vVCBdcq
 2k8gcSlM1O/Pprwvg1LasA5neLSuED4xGfSzCuowaF5FhGWTCJIsQppVLcX4I9Xqq5
 roM8eMWJqvjEq1Nl6Olaw4OHS7+91TyZznzEaWshp/ike2A7znuccp/uymjM3j+xTW
 96OSAvT4PrRYpNGs3Je26/M0sYPxUaQoG9EJQ8d5olFNaUG+Vd22o0md8LExK9cWJp
 8dbtKgKTxSWwiwchg6TrLx50JuQ9F6layshtYor+CMfQRsS2a6F1yJjnLV5Aj+LiZU
 mKoi5ook/o2UQ==
Message-ID: <4d3e7b8e441404aaece9c3572b4b8722@kernel.org>
Date: Tue, 07 Jul 2026 15:26:11 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v8 08/39] drm/display: hdmi: Advertise SCDC source
 version when scrambling
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-8-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-8-d79890d00b6a@collabora.com>
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

On Thu, 2 Jul 2026 17:46:21 +0300, Cristian Ciocaltea wrote:
> The HDMI 2.0 spec advises that compliant Source devices report their
> SCDC version in the Source Version register.  Do so when enabling
> scrambling by calling drm_scdc_set_source_version().
> 
> Failures are non-fatal: SCDC version negotiation is purely informational
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
