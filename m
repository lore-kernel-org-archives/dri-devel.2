Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2226BCD6E5D
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 20:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9AA10F5F2;
	Tue,  2 Jun 2026 20:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="ta8xCYHu";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDFD10F5F2
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 20:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=MNDCAtsijCw9J9wcBE3eUlKSvCKY8bQfE21VGId3hiM=; b=ta8xCYHuXu7jocMGavMXuf2400
 PVwmrvXaUN+x39ZkkQmP2MyQtfRd4IcdQpvx7M36gsvUdEQvFr/RpF6bao4xJuhMTfGEaw6ikqa6O
 SstWykMf6vQ9D1ssOOvNNQ1L4r1dmvC5KDZIsIEOjlMlh4BSmkUkzzoh2n6X2YdmGuVRgiz2bZeSF
 YqQahAS6z3KTn09i+B4N4jYske4aqj1Mvqx4C1mmuZIwlY8kS9qFp16W/rQVvuBPhB+D8yJnJPYvH
 HFu01cZPD/EWTOHLarAHd6Po9UV0Is/vPsZqYycBZbIhqRrcop8+mHuixJzLj5k2Jv8S+OMOU4td2
 juVm+AIw==;
From: Heiko Stuebner <heiko@sntech.de>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Damon Ding <damon.ding@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 dmitry.baryshkov@oss.qualcomm.com, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/bridge: analogix_dp: Convert status check
 functions to bool
Date: Tue,  2 Jun 2026 22:39:06 +0200
Message-ID: <178043273747.699871.4838311540218337301.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521102716.1373519-1-damon.ding@rock-chips.com>
References: <20260521102716.1373519-1-damon.ding@rock-chips.com>
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


On Thu, 21 May 2026 18:27:16 +0800, Damon Ding wrote:
> Convert analogix_dp_is_slave_video_stream_clock_on() and
> analogix_dp_is_video_stream_on() from int to bool return type.
> 
> This makes the code more readable and aligns with kernel best
> practices for boolean status checks, while simplifying the
> callers by removing unnecessary "== 0" comparisons.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: analogix_dp: Convert status check functions to bool
      commit: f88b35d79a4b403676b1222b1c28b2daafae2980

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
