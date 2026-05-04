Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90EDFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 07:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F230A10E38A;
	Mon,  4 May 2026 07:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TiydHbsi";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C56B10E38A
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 07:02:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id AF8371A3500;
 Mon,  4 May 2026 07:02:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 79C0B602AC;
 Mon,  4 May 2026 07:02:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 55B9C11AD20F3; 
 Mon,  4 May 2026 09:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777878129; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WjxiqLAkyAg86tnkNqBnzm5a1eqz6HceNKNEWzwry9o=;
 b=TiydHbsijG4WOldU7rgxJlmGW5kiAPZuJf5i9dZNp3syV7rHcPLAE9In8tuBac4nC48xz3
 klNI60YAlXw1Ie8XzQvhKmzZKCIWkzJ/Cwe1Oe7QiqnCDQR+Vu/DMMTmcs3j4HlTXTV1gh
 dgL/qNEKLCe9f8KlX39K5cAgWYtE9tNqiTy4CSFauL4joLOf+9qw39Pf7K1GEQpAemgVml
 U1nalmTIcVFS09MGAx7nMHdQvB21Bh99Hnzh7EFlmb/Wi8pesSMvYtD+x6PjASV8hlCNye
 mkuHIEDcH60yrOejLHFIF73zUOyOBBZLbUYNLjktTmgvuZuP6Hr0g4w4TtRAQw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Damon Ding <damon.ding@rock-chips.com>, 
 Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260429030840.704252-1-ethantidmore06@gmail.com>
References: <20260429030840.704252-1-ethantidmore06@gmail.com>
Subject: Re: [PATCH] drm/bridge: analogix_dp: Extract error pointer from
 correct variable
Message-Id: <177787812164.79029.2717160493311648857.b4-ty@b4>
Date: Mon, 04 May 2026 09:02:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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


On Tue, 28 Apr 2026 22:08:40 -0500, Ethan Tidmore wrote:
> In devm_drm_panel_bridge_add() error path the pointer error should be
> extracted from dp->plat_data->next_bridge but instead it is extracted
> from bridge, which is a valid pointer and not part of this error path.
> 
> Extract error pointer from correct variable.
> 
> Detected by Smatch:
> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1489 analogix_dp_bind()
> warn: passing a valid pointer to 'PTR_ERR'
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: analogix_dp: Extract error pointer from correct variable
      commit: 002ef4dc52dcc1dd0eb1556cffa8f02e2e7edd51

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

