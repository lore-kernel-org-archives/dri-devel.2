Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2050010AB81B
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A10D10E674;
	Thu, 26 Mar 2026 19:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="LH8F33gG";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3302910E674
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 19:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=UqTxQ4+4Pepmm+b7jcLTYHrn6v3kt/yLegb5GQyalhs=; b=LH8F33gGysSTYfISC7040NDRaD
 DsLmNS1xma9eh6z+mEvhsnZUTmXRnynwKegM5QzVVxZq8Ss75LiexyIC7Z3S3SH9imRTftaDHfm/2
 LcxircO6NNZ7pjq/na0O/42/KFwgedsC93YYts7AbtX2gTNE33RyY94x89hkMS9RBHSrh4hmJNrAb
 Gj9w/BbAFUmL+PVjDUQaT5m3eS20BqWF7085khKiY6KhOG9TkeRYEpJrg9uTv1zKqGD3imK0+492c
 st1y+9uWqr5wZWApsARXySbB0SxxiY04zmsl+62vohNDC4aRJ4tZRW3FFKMmJdd8Up/df6VIfO4nG
 Ny4iJquA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org,
 Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/rockchip: cdn-dp: add missing check in
 cdn_dp_config_video()
Date: Thu, 26 Mar 2026 20:41:03 +0100
Message-ID: <177455405026.1277100.9686566905955604923.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <adf6b313-f7db-4d8f-9000-8c65446ba041@auroraos.dev>
References: <adf6b313-f7db-4d8f-9000-8c65446ba041@auroraos.dev>
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


On Fri, 30 Jan 2026 23:35:42 +0300, Sergey Shtylyov wrote:
> The result of cdn_dp_reg_write() is checked everywhere (with the error
> being logged by the callers) except one place in cdn_dp_config_video().
> Add the missing result check, bailing out early on error...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: cdn-dp: add missing check in cdn_dp_config_video()
      commit: 46c31e1604d121221167cb09380de8c7d53290b9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
