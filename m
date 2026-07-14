Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0263CC4450A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4971210E088;
	Tue, 14 Jul 2026 16:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NpLgkyx1";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C9C10E088
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 16:44:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D8F25C2BB2C;
 Tue, 14 Jul 2026 16:44:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 17A6860346;
 Tue, 14 Jul 2026 16:44:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8F05211BD3B90; 
 Tue, 14 Jul 2026 18:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784047473; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=d5B5ZPV9+qhIoN+5rR8YuXgTr/TKM6k/1xr3NrI3/70=;
 b=NpLgkyx1FJLMvADanmmwQh1OlgXY5iL/dyXquVqQSmhC85Ba/1GzlMpy6YnaJbaof7TEfG
 vpmFm0Cm3K2XolqMNxmdPGnj8bxvNuHwZjaOm1t83KrcsEG3GqdNmkm420I5Lh/hWCFy8j
 DCcZF9W/iFDkcGVUUY32pRpcTxLPtn18ht4uA6siF7daCUgXgjFexIPci7vffWh2eG7WSs
 e76+L0nJFBDdZBJ9rzdOEove3cbKMeMH8CTNe6NWKnLFIcRn/nSyOrnz1lXg6vyHA7M/sH
 h73mOVtIlPbdfqqbUrAWUaKxKEKju4vBGWmCOibm6S5Mm2BWOtVKYswXls/nJQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Henrik Grimler <henrik@grimler.se>
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260602-exynos4-sii9234-driver-v4-0-9b2fc38e104a@grimler.se>
References: <20260602-exynos4-sii9234-driver-v4-0-9b2fc38e104a@grimler.se>
Subject: Re: (subset) [PATCH RESEND v4 0/3] drm/bridge: sii9234: use extcon
 to detect cable attachment
Message-Id: <178404746733.242094.13579113773760674255.b4-ty@b4>
Date: Tue, 14 Jul 2026 18:44:27 +0200
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


On Tue, 02 Jun 2026 20:36:47 +0200, Henrik Grimler wrote:
> This series fixes so HDMI through the sii9234 MHL chip works when
> cable is hotplugged, by making the MHL chip use extcon cable detection
> functions. Patch 3, that actually implements the extcon parts, is heavily
> inspired by commit 688838442147 ("drm/bridge/sii8620: use micro-USB
> cable detection logic to detect MHL") by Maciej Purski.
> 
> Before these changes, HDMI only worked if cable was plugged in before
> booting. If no cable was connected, then wlr-randr still showed HDMI
> as connected, with 0x0 px, which confused at least some UIs (phosh)
> and caused problems:
> https://gitlab.gnome.org/World/Phosh/phosh/-/issues/828
> 
> [...]

Applied, thanks!

[1/3] drm/bridge: sii9234: fix some typos in comments and messages
      commit: 511ee3e5f7e4e82b6a5a0f9aa16895ab9a96fd08
[2/3] drm/bridge: sii9234: use dev_err_probe where applicable
      commit: a3bbe1f4877d372da713b79764787e01306b12aa

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


