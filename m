Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F867CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 19:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A0F10F547;
	Tue,  2 Jun 2026 19:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="HdXi8Byx";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C15310F547
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 19:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=gKB9x1tpiuLUEeBus3o7GudY3/h5ARry57xES+ML00Q=; b=HdXi8ByxbzTxRwmizh/1mOWD7f
 R7+X+vJ0h22fusPLEAc7dw2I6ZLJwoa0OEIR7bdKR6Y5ckQAKeGa+rsioN4vDsrRkKb28LHCDa3nu
 NTvYxBYtuKDgY01PhsOJ7hSJhSzeJlNAe1jNWCXuuNMf4iw1nGv91eyIBWAFtQsdsftVgMPGGknSv
 Be8q/PHO6neaPACJD/YNS9a//hsxBL9BIOMznhyD7C6fKY1MOteI6SK1jurYcxic65eU/EAU+JWUd
 HzJQe1o+82DSbvWJP9+j9LSq6W3gHqNUEm/YmMPQBhvKCvr84cq6T/QLh4PJRS/MzODe+SqaFi6bv
 ID89T8fw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/rockchip: vop2: Fix layer cfg done timeout on
 multi-output setups
Date: Tue,  2 Jun 2026 21:44:19 +0200
Message-ID: <178042945330.650189.17239358036514651129.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260504-vop2-layer-cfg-tmout-v1-0-730226a7331e@collabora.com>
References: <20260504-vop2-layer-cfg-tmout-v1-0-730226a7331e@collabora.com>
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


On Mon, 04 May 2026 21:23:58 +0300, Cristian Ciocaltea wrote:
> On RK3588/RK3568 boards with multiple active display outputs, start/stop
> transitions may trigger a timeout during overlay layer configuration:
> 
>   rockchip-drm display-subsystem: [drm] *ERROR* wait layer cfg done timeout
> 
> The shared OVL_LAYER_SEL and OVL_PORT_SEL shadow registers are committed
> to the active configuration at the vsync of whichever Video Port is
> selected by LAYERSEL_REGDONE_SEL.  When two Video Ports race through
> atomic commits, rk3568_vop2_setup_layer_mixer() has two issues that
> cause the wait to poll for a value the hardware might not be able to
> produce.
> 
> [...]

Applied, thanks!

[1/5] drm/rockchip: vop2: Fix wrong wait target in layer cfg done check
      commit: 9f5670802df085ad343146561e69bac43e9905d2
[2/5] drm/rockchip: vop2: Wait for layer cfg done before switching LAYERSEL_REGDONE_SEL
      commit: d1ad644e572c0647ad8428439eafea0aacfccf9e
[3/5] drm/rockchip: vop2: Delay old_{layer|port}_sel updates in setup_layer_mixer()
      commit: 6a2f7339191b652f7ff998595df90987b33c3fda
[4/5] drm/rockchip: vop2: Drop redundant zero-init in setup_layer_mixer()
      commit: bc5ffd6fc30cc52983d95fbe8783bb4233db6f86
[5/5] drm/rockchip: vop2: Use vop2->old_layer_sel directly in wait_for_layer_cfg_done()
      commit: dc3de97433db03157ba6f87b6494ff1ad416a5a8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
