Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC675C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C64610E1D1;
	Thu,  3 Sep 2026 14:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="GjRQ17cT";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7268410E1D1
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=HDphPTZasBW/m6rqPKWNWdlcoSOfg9Wv3BLKy1YJmFk=; b=GjRQ17cTZGJyO9RseyyaQA+rJ2
 KFNRg9yVF0nvIwkEzkEfH5NFEWW8acQDmuKl1f6q6vQ7hOzImiIke6iL7hFX1C+f6tBGJf+Ol2V+d
 VuOnEMMB3JdoROXdxAxA/ilFfkTGkMt8LL6JoSRAgFSTaGoLP9VoY6dqRK2TiMGA4r07hJDy8Mvll
 cmXc0yGIA/VDpi2tfF4vsdgfV8buO5SyDx3nPWjAxOJ9Laa3Hc30GvLHcbbVE2PXOKlVadljZYaIr
 whRPifETlbniKBgzN9KMCSWvw6CT6YutHQB62x/U6kYBr/SDQuhUBOZ4Jgb59PjyzScnJ1Ql0JJlj
 77ooFAow==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Yudi Yang <2000jedi@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: analogix_dp: bound endpoint name formatting
Date: Thu,  3 Sep 2026 16:12:03 +0200
Message-ID: <178844472024.2481528.12971315442057669333.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901195511.2761251-1-2000jedi@gmail.com>
References: <20260901195511.2761251-1-2000jedi@gmail.com>
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


On Tue, 01 Sep 2026 14:55:11 -0500, Yudi Yang wrote:
> rockchip_dp_drm_encoder_enable() uses sprintf() to format a device tree
> path into a 32-byte stack buffer. Device tree paths are not limited to
> this size, so a sufficiently long path can overflow the buffer.
> 
> Use snprintf() with the destination size to truncate the generated name
> and keep the writes within bounds.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: analogix_dp: bound endpoint name formatting
      commit: bc69439d983cc491cc86e01fafc1deb94e1bb85e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
