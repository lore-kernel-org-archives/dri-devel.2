Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243C1CD6E5D
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84EB810F4C9;
	Tue,  2 Jun 2026 18:48:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="eQyt91Hb";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E313210F4C9
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=bQ/ShSVerF3nHBt9YMs/KOfemqRk/C2hqrvxvJUY/r4=; b=eQyt91Hb+iKzpD2z/Q5HdzC7oA
 lHgvBQlcohpqxZ+e9FUIj0hRWFQfql8KO99YeAHgK31Vaquv/H0Olqkp/OHWwyrtF2mFntCDmdkno
 8Q3IBhnsWeTsxTQsMMeM8m+cyTustAU3n9MimjOsgM+MdlN5mkD7m2H0XtixuKE/REP5E/g2C1HMb
 yu791S02UFO/PLF5zJcrILVZwy8pZmajXAK2N18QsM/itIg1V5Ioh8fk9NpZzs328yUi2LaghMX4h
 EpH1bOBKqGnUg2zQvxpv/lf7SqwiEnNuIuuzvHj2bLcQZ8PJH8RDqoZ1yOBGKJZUDZ3VWu1fY3KXY
 RkXrbA1w==;
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
Subject: Re: [PATCH v2 0/2] YUV support for VOP2 background color
Date: Tue,  2 Jun 2026 20:47:41 +0200
Message-ID: <178042605608.614111.131135337224991312.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601-vop2-bg-yuv-v2-0-e5aef1d16fec@collabora.com>
References: <20260601-vop2-bg-yuv-v2-0-e5aef1d16fec@collabora.com>
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


On Mon, 01 Jun 2026 21:00:02 +0300, Cristian Ciocaltea wrote:
> Since commit bec7cbfa7d4f ("drm/rockchip: vop2: Support setting custom
> background color") the VOP2 display controller allows configuring the
> background color of each video output port.
> 
> However, this is currently limited to RGB formats.  When operating in
> YUV overlay mode, the color must be programmed using YUV format.
> 
> [...]

Applied, thanks!

[1/2] drm/rockchip: vop2: Rename CSC_BT2020 to CSC_BT2020L
      commit: 09dfa47fc557f945871dcf279c8e687e55d3550d
[2/2] drm/rockchip: vop2: Add YUV support to background color
      commit: 28e670a0885cf2501fd51189ce7b6f5b7cacebf9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
