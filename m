Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BEFC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A48810E243;
	Fri,  3 Jul 2026 16:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="zDl8No2t";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC03310E243
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 16:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=7iwZHYbjEtrHvPPYcrJqyDlxjyGE6USuPnhVgCbNYsg=; b=zDl8No2tUqR1tMY/CgayOP53tr
 mJWIovy7v9YUo4t1Y1YUNZ7fwnJ7CrAaY5eUXaxpcZkO8uzV1G79Mvc6lRBYjeHnZaU9frcbDgcxv
 TorDEcIAwln6lxCXraTTEXvwTQXdPFYX4ipNLAoWqxzHLjstYWJJwrzi1vaKE7cmzRodNhfzrpR9k
 byqeEVzPcIrkdZrP2WNR8Jf4bqt8p2I4g/mVR/uf6kIGz0IuZ+zmXiiXCpjAUbhlg6VGpdmFHlDCk
 9NkkoEpDaU9ZKGC2rLLuK6zGw98T5W9lKFYrs2HDwafI4fup9PKIRbb/75LfvX19aHi9UQs2xUsoE
 20NlNq5g==;
From: Heiko Stuebner <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Damon Ding <damon.ding@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Vicente Bergas <vicencb@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/bridge: analogix_dp: Apply standard DP training
 delay helpers
Date: Fri,  3 Jul 2026 18:57:53 +0200
Message-ID: <178309782891.32809.4103467583344237133.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623075207.320603-1-damon.ding@rock-chips.com>
References: <20260623075207.320603-1-damon.ding@rock-chips.com>
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


On Tue, 23 Jun 2026 15:52:07 +0800, Damon Ding wrote:
> Replace hardcoded fixed usleep_range() delays during clock recovery and
> channel equalization with drm_dp_link_train_clock_recovery_delay()
> and drm_dp_link_train_channel_eq_delay() helpers.
> 
> The original fixed delays are only valid for the case where bit[6:0] of
> DPCD TRAINING_AUX_RD_INTERVAL(0000Eh) is 0x00, while core helpers apply
> spec-compliant timings matching actual receiver capability values.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: analogix_dp: Apply standard DP training delay helpers
      commit: 337038d31c59d405b89efa7b28fd230273f997ad

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
