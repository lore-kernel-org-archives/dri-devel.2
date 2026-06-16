Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129FDCD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 20:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5D610E2B0;
	Tue, 16 Jun 2026 20:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XEXLy31l";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105F510E83E
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 20:49:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5C7D81A3968;
 Tue, 16 Jun 2026 20:49:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2E7CC601A9;
 Tue, 16 Jun 2026 20:49:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C1003106C98C2; 
 Tue, 16 Jun 2026 22:49:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781642971; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7Eui/SfYzi/oFPq69ipv4n7Fj92PEiDHaS+DH76kYnU=;
 b=XEXLy31lo9imNEKfOH1PhdHy/XaM1SFi9ELcUxf+qVLuV5uje3plC6HziA25zhrZYH4f0K
 T+Cac6joOd8fAiSMr5Jb8lEpZk2RRiz45d0glP73Ck+zg+w0Xn0UPDApmMxI+tar/Y8aTZ
 4LeB0+Kzz4t2fQ5JB2TMCpAb8ob1rhg+HVpmDft6nHFrzlAcUEhU7Xun6kcuC8drqFrPb4
 5DTmVOhnR7JVx4C7ABhlHUG3b67+7OhbcC2b75jMVCj0i9/dsamSsUq5OcaEr0JO41jDAy
 25u+Gnad9UYco3GNXwL+dFmn6AlW/wlw5vzSKXvsqkBbr6YjN7n7qYvlO/4HqQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 alexander.stein@ew.tq-group.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260527085736.920390-1-tessolveupstream@gmail.com>
References: <20260527085736.920390-1-tessolveupstream@gmail.com>
Subject: Re: (subset) [PATCH v4 0/2] drm: bridge: ti-sn65dsi83: Fix DSI
 mode flags for stable LVDS output
Message-Id: <178164296717.254857.3522055507948798930.b4-ty@b4>
Date: Tue, 16 Jun 2026 22:49:27 +0200
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


On Wed, 27 May 2026 14:27:34 +0530, Sudarshan Shetty wrote:
> 
> This patch refines dual-link LVDS support in the SN65DSI83/84
> DSI-to-LVDS bridge driver.
> 
> Recent upstream changes added support for dual-link LVDS timing
> adjustments and related fixes:
>  - Halving horizontal timing parameters
>  - Test pattern handling adjustments
>  - DSI clock range correction
> 
> [...]

Applied, thanks!

[1/2] drm: bridge: ti-sn65dsi83: Remove NO_HFP and NO_HBP mode flags for LVDS stability
      commit: 4af021a977735420e8fe18d64bef18ad0608d981

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


