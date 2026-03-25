Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513B5106B519
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACAB10E6CB;
	Wed, 25 Mar 2026 12:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XWnkBaRC";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C2F10E6CB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:23:01 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7CF9B4E42734;
 Wed, 25 Mar 2026 12:23:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3CD47601E2;
 Wed, 25 Mar 2026 12:23:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9A6A0104507E3; Wed, 25 Mar 2026 13:22:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774441379; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=wuCz0GdIr7yZdR4yjkAeYjkNxYt5/3jdcNGj4qHSjeQ=;
 b=XWnkBaRCtyUD64fsnPnojIWJ89n/Sv06DLENg1pw1de2uMbyb5Sbe29Bxwdh6e3jJWfYOn
 XSUgPQcLfbKJZHPEjpliYSy3Xwqq+0GCfdvrGWD61+79FuOt/DBpFA80lHICbyQGxVIZLR
 25iQKdouiu+nxc0qQDFWuBmVQnFUOdZ8nBzjeD3vz3TwHeP2RgwF25ZX8LHTHx8nva+n15
 xRlzNYxVvWOxaVGWdNoe2T5Eycb0CjKH9M6qGAAEVDpkuldOg7FSGAuigj99OrX8HdvkQZ
 b+MTYvFSNZirhM+m7Rdh6gP1wcr0A7JRc+o4OfW0AdvvTfMlsae5AFe9UMLE1w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Damon Ding <damon.ding@rock-chips.com>
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 dmitry.baryshkov@oss.qualcomm.com, dianders@chromium.org, 
 m.szyprowski@samsung.com, andy.yan@rock-chips.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251111022103.1350183-1-damon.ding@rock-chips.com>
References: <20251111022103.1350183-1-damon.ding@rock-chips.com>
Subject: Re: [RESEND v3] drm/bridge: analogix_dp: Reuse
 &link_train.training_lane[] to set DPCD DP_TRAINING_LANEx_SET
Message-Id: <177444137415.545932.15016514091922031299.b4-ty@b4>
Date: Wed, 25 Mar 2026 13:22:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Last-TLS-Session-Version: TLSv1.3
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


On Tue, 11 Nov 2025 10:21:03 +0800, Damon Ding wrote:
> In analogix_dp_link_start(), &link_train.training_lane[] is used to
> set phy PE/VS configurations, and buf[] is initialized with the same
> values to set DPCD DP_TRAINING_LANEx_SET.
> 
> It makes sense to reuse &link_train.training_lane[] to set DPCD
> DP_TRAINING_LANEx_SET, which can remove the redundant assignments
> and make codes more concise.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: analogix_dp: Reuse &link_train.training_lane[] to set DPCD DP_TRAINING_LANEx_SET
      commit: 05d09e7f28c8f6e39c54d79fd96643f6faf5dbee

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

