Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBB5C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5E210E1C1;
	Mon, 21 Sep 2026 09:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cXz9wXrl";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815BE10E1C1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:09:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1926E1A0F78;
 Mon, 21 Sep 2026 09:09:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DF36360339;
 Mon, 21 Sep 2026 09:09:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A4AD01032918E; 
 Mon, 21 Sep 2026 11:09:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789981770; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gtewFrFoLI46IIrkL35plATPEcqBACBHV+ul81kZFSU=;
 b=cXz9wXrlOGUl3ndYbo+mmrZ0yX9qtyAQy2hzLflJbyzuK02fEsHXyfIg18KSJQQm0cS6B2
 UPREV+GDJVI0DIbKjz8VSluidzD+RnWMZvxhOCPszOg9+d0PsbsoQ49yT/knebrIZYTpH1
 0wWaslpyICzBgKYCq7xDrutvECbOtm06RqtV9zQNfgKb6/w7DZEohsD7bWb7PeVl1M5WLN
 WOR5EBUg34QMMTfhmjxWVfK9hm9QXDrbVz29tI/dgRP1+YG8R8k8rT6T7hyfkEOdjOZxVt
 OXBbdmcZV8+oBGlETjQbfdpRDzH03uo4WUntnaUdCNNoneSaY1Oqc/UXlYJK4A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: inki.dae@samsung.com, jagan@amarulasolutions.com, 
 m.szyprowski@samsung.com, Li Youhong <dayou5941@163.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Li Youhong <liyouhong@kylinos.cn>
In-Reply-To: <20260904014958.1572918-1-dayou5941@163.com>
References: <20260904014958.1572918-1-dayou5941@163.com>
Subject: Re: [PATCH v2] drm/bridge: samsung-dsim: fix TE GPIO lifetime for
 host attach
Message-Id: <178998176147.99293.14109429375573506716.b4-ty@b4>
Date: Mon, 21 Sep 2026 11:09:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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


On Fri, 04 Sep 2026 09:49:58 +0800, Li Youhong wrote:
> When the Exynos DSI driver was generalized into samsung-dsim, the TE
> GPIO acquisition was switched from gpiod_get_optional() to
> devm_gpiod_get_optional() while keeping the matching gpiod_put() calls.
> That combination is wrong for a managed descriptor.
> 
> However, dropping the puts and keeping the managed get is also wrong:
> samsung_dsim_register_te_irq() runs from the DSI host attach callback,
> and host detach/reattach can happen without destroying the device that
> owns the managed action. A second attach would then request the GPIO
> again without having released it.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: samsung-dsim: fix TE GPIO lifetime for host attach
      commit: ada667890773e033d2f40dc94176e3beb930b516

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


