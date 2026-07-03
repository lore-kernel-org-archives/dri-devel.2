Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99329C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C4010E40B;
	Fri,  3 Jul 2026 16:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="vXqXyB8C";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837F210E3E1
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=rNbF08GXHHkdtUl1DIYbHQ0Soe9t0ceox8KRTBKsKsE=; b=vXqXyB8CG+bIwjsVzqaGTKeIFk
 UXh/idy0JOl4BRMwxQ5vwJEXhC14bhL5wnaXdniCBs1Fjy0sSdmy5HvE0qtD4BVGYe5OVBnWQ1DTN
 Fg5b6dc0UoJP0hjWjnxRAr/ApnwiFcSKNRKRKEc8x33NzQ5Nh0nhzr7u6qHTMtt5IlbSLuTHp8AZL
 qPQ2hsuHiQz1y2beO6zxfNZtbOkqUAbkkOBNQK0I5IOQSHTJd+UjeKsylupS5RvbFfFFvRO/Y1afL
 +DwO4/+S4I36CMedt8nbZagh2ft8+lw9Nf8bk8/m5vs3m+fvsrC/8FLU/3l8exUwTeJNqbbxQZCa6
 e0A8kVqw==;
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
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Fix PE/VS value shift
 mismatch during link training
Date: Fri,  3 Jul 2026 18:58:09 +0200
Message-ID: <178309788492.33219.12979716555386430078.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623023506.309858-1-damon.ding@rock-chips.com>
References: <20260623023506.309858-1-damon.ding@rock-chips.com>
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


On Tue, 23 Jun 2026 10:35:06 +0800, Damon Ding wrote:
> VS/PE values returned by drm_dp_get_adjust_request_voltage() and
> drm_dp_get_adjust_request_pre_emphasis() are already encoded to their
> native DPCD register bit positions. However, DPCD_VOLTAGE_SWING_SET /
> DPCD_PRE_EMPHASIS_SET macros perform an extra internal shift. Feeding
> the raw offset-bearing values directly leads to overlapping bitfields
> and invalid lane training configuration, causing link training failures
> and black screen.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: analogix_dp: Fix PE/VS value shift mismatch during link training
      commit: 6bb8898f702385d363dc2c513a1efa62807f8068

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
