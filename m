Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21527C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551D810E1B7;
	Thu,  3 Sep 2026 16:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="f62wACns";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6C410E1B7
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=0F2j0b3N5nABk+G76sOWdFQNdQLNUEsOfL8WiePX1eU=; b=f62wACnsBJRZajkD5HjKr+au6x
 g/J41+y8dRpjPLFdC3+6o5J0eTXoKedc8Wd4OZkPPP4d6bvf00zXXWKZrSkf1+13SK5zl4G//t/0f
 +qA5mDF/uFAVm0e7SodRu3Fil+dYJ8mfxw+Z6SnBbYIPuekFphYJ+NvA0EC78LmEDQHnrx9IhErg4
 vRhKxaF9U9/jPQRoGVaEkI0rr4qChRrBwsgND8F2iEha9/uaFvr7dNJwUXcjQvuOqkLXIyYWeDq2w
 s9mwTh1BWr7eiDXBXIPiJqJiga6YLmBcvvh0j+B+/MY6KDZX4gYLrZQgjtmuQ7Rkw/b5PpAFAKata
 Py3kjq/Q==;
From: Heiko Stuebner <heiko@sntech.de>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Simon Wright <simon@symple.nz>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andy Yan <andy.yan@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Algea Cao <algea.cao@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge: dw-hdmi-qp: use drm_hdmi_acr_get_n_cts()
 helper for audio N/CTS
Date: Thu,  3 Sep 2026 18:09:14 +0200
Message-ID: <178845174737.2601151.16427479820258337465.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <86fcf349-0a7a-4618-9001-612371b0f71b@symple.nz>
References: <86fcf349-0a7a-4618-9001-612371b0f71b@symple.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Thu, 21 May 2026 19:36:47 +1200, Simon Wright wrote:
> dw_hdmi_qp_set_sample_rate() open-coded its own N and CTS lookup
> tables and search/compute helpers, but it lacked the out-of-table
> CTS fallback needed by strict HDMI sinks at TMDS rates not in the
> table.  The original LG G3 OLED audio mute (linux-rockchip 070633)
> was caused by dw_hdmi_qp_find_cts() returning 0 at 185.625 MHz,
> leaving AUDPKT_ACR_CTS_OVR_EN clear and falling back to the
> controller's internal CTS auto-measurement, which produces incorrect
> timing on the wire at out-of-table rates.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: dw-hdmi-qp: use drm_hdmi_acr_get_n_cts() helper for audio N/CTS
      commit: a9f09b5ea0c3db1e2d4c0f8d3ebdd612d8aa0366

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
