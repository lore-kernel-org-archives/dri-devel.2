Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C63CD6E5D
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 19:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 129EC10F523;
	Tue,  2 Jun 2026 19:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="XYPp70Bu";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9D010F523
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=gu1c3uquHuuEbbbF+ownzXg8e3d3QwLSqMpB9MeHIIA=; b=XYPp70BuKKW9wSNmqWd7MIIQNw
 lFj6XDcvGDvWIgMiEmJsNhjElQDuviLiFtH8H4mAsm9YEWN/2CeuYpfvAIANaG4/WiR4kI9Ynwdeq
 IIaOSg1HFTkXej+5IURSwgfUm9mDRWrSRtoW1O+u+rrp5ZV22CaktYXNYcFdQRRFx80Pl21kD+KdM
 rvflqpOblScLA9QltdFuacmqyauYhvKpVpIpP2NcqGk7yGRehYRDKxrixj7zzhJM7D0dsE90OcFRP
 CUZksaa8blHHWwCfKknPF6KpuU11BOP3RDNwxlCisHjcFIknyboYGQLco147erohB8wzRDeuCgEqd
 dgtzUNjA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Rockchip DRM use-after-free & null-ptr-deref fixes
Date: Tue,  2 Jun 2026 21:31:43 +0200
Message-ID: <178042869904.638042.16054419218883756618.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601-drm-rk-fixes-v4-0-c3f3f123e1da@collabora.com>
References: <20260601-drm-rk-fixes-v4-0-c3f3f123e1da@collabora.com>
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


On Mon, 01 Jun 2026 19:13:43 +0300, Cristian Ciocaltea wrote:
> The first three patches in the series are fixes for use-after-free &
> null-ptr-deref related issues found in dw_dp and inno-hdmi Rockchip DRM
> drivers.
> 
> The following three patches provide a few minor improvements to dw_dp
> and dw_hdmi_qp, while the remaining two address use-after-free and
> memory allocation in DW DP core library.
> 
> [...]

Applied, thanks!

[1/3] drm/bridge: synopsys: dw-dp: Support unregistering the AUX channel
      commit: ed04e8e2307f35b3d8d49a554faf5e72d3d224e6
[2/3] drm/rockchip: dw_dp: Add missing newline in dev_err_probe() message
      commit: 0a01412178047bf3ff351c7e75d373e411072a87
[3/3] drm/rockchip: dw_dp: Release core resources
      commit: cc6d7aca2f37a1525a94ef97eb3ce361732c876c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
