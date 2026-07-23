Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF692C531F7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B1110E370;
	Thu, 23 Jul 2026 14:31:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="AA8UzdYL";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08BB610E370
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 14:31:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2E3B54E40F09;
 Thu, 23 Jul 2026 14:31:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D9257602B8;
 Thu, 23 Jul 2026 14:31:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A53B611C10F99; 
 Thu, 23 Jul 2026 16:31:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784817089; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ocN49ueX0HbZZG0bnb6GaDiiqIIaTdwnLyaLATSZp4Y=;
 b=AA8UzdYLWNQSLrNZOSd+WMJ77p4BDQqruHQ9ol5A4RXOxPmpZAOe+tUZatjfUjslLtk33/
 XCL6G7kyal79oJtUtGYgeguyEAIw9WcVJQ4mVVV0rv8tX37VIr986bESvNO8d6FaTQBTmr
 FR/nwJ0gOjhu1vL0eMhL7VF/G+JP6c2CGkqeQmxH2/FXCEosQc0zFuk1/juqrCFaOJmpTQ
 mTWasAh7b3I0UV2hwILND8uFjAXmdoy/BP38ctWaYZzKclDLE4QQL7tthlATH03jxgRqed
 7JMmYGxuz+oQEvVuCu+gzO7JFdx6GRzJzXjdrno8Ete7f40J9ESUyGG5AchP6w==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/10] drm/bridge: Remove redundant error messages on
 IRQ request failure
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Damon Ding <damon.ding@rock-chips.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Harikrishna Shenoy <h-shenoy@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Kees Cook <kees@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260723131649.134127-1-panchuang@vivo.com>
References: <20260723131649.134127-1-panchuang@vivo.com>
Date: Thu, 23 Jul 2026 16:30:59 +0200
Message-Id: <178481705931.250308.3468984153003724124.b4-review@b4>
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

On Thu, 23 Jul 2026 21:16:32 +0800, Pan Chuang <panchuang@vivo.com> wrote:
> drm/bridge: Remove redundant error messages on IRQ request failure
> 
> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()") added automatic error logging to
> devm_request_threaded_irq() and devm_request_any_context_irq()
> via the new devm_request_result() helper, which prints device
> name, IRQ number, handler functions, and error code on failure.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

