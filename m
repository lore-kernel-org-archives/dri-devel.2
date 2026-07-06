Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C24C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5796E10E042;
	Mon,  6 Jul 2026 18:29:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="ZDmPkj47";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12CB010E042
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 18:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=/Kh4IzNYBu3mW0ro+qkx1GphLLmiK1jbW6xdIlzD9hk=; b=ZDmPkj47Q+WnwI5vSuG12DHrXP
 UbiEDbs3jhb/ZSpUwvBoJkJEDSfU6ZHog56KzgcsNslm3vxvcw2A6+s1y0tGwIBd59BzOCCySIwKw
 CSVOBTeEgG7vM/F1piGu9n+rEZkp2HALe2UgYxp+cxyj0BMue88nkEoLUVgQrxDZzIytNBwIMvp+V
 XPN5oDTrolyJKP/GlbxGvHPEJQINljaEPkTCJSCQZX3ht627KjtaLAnNOXd8lnMpopGOE6CALDhqx
 K+Qf1WLHvlxDr3wyZbQIYxU2KVmeElsJZTLiVSyDelGgTcW69++dMLqVBX5SrVJahj+QFpKgMHBYR
 5slcro7g==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Diogo Silva <diogompaissilva@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] drm/rockchip: Remove dependency on DRM simple helpers
Date: Mon,  6 Jul 2026 20:29:26 +0200
Message-ID: <178336256097.417648.401412534359404316.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704-rockchip-drm-simple-v5-1-a333f527a4f9@gmail.com>
References: <20260704-rockchip-drm-simple-v5-1-a333f527a4f9@gmail.com>
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


On Sat, 04 Jul 2026 11:12:02 +0200, Diogo Silva wrote:
> Simple KMS helper are deprecated since they only add an intermediate
> layer between drivers and the atomic modesetting.
> This patch removes the drm_simple_encoder_init() helper usage in the
> rockchip drivers by open coding it and using the encoder atomic helpers
> directly. This is a step to eventually get rid of this simple KMS helper,
> once all drivers that use it have been converted.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: Remove dependency on DRM simple helpers
      commit: 640c55fc147f0202365f916a1297f62d640efa3e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
