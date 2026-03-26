Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AC410A1E60
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C0310E23E;
	Thu, 26 Mar 2026 10:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ChaVQKRN";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5CB010E23E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 10:38:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id EF6701A2FFD;
 Thu, 26 Mar 2026 10:38:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B62CF5FDEB;
 Thu, 26 Mar 2026 10:38:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E21D310451B73; Thu, 26 Mar 2026 11:38:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774521487; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=4TcKMqkw32b/izwSGy63mafwnLUjMjrZaZbnKnBwOC0=;
 b=ChaVQKRNXgY9ALfrinBqARfc1pb2cjVbWjRaj4sCJq2q5Mzc9qsQb1HeYRcXoMtFQbDru2
 rCoGZtEnpy7LcOQ0AfLN7sxBbGa/EtyT/M1myFZ+/FbK6HYDpjbkqCTNATZa34Ez1zj63V
 5szVQRl+lfDUU02KxFCN0v1XB2UX2HUZNLDN2hg4/eSL/k3ftn5pJC/77EKSyd7Yvv8USz
 99hGYfDPX2D5L50Wb+TDB9Y/pO7AEjf5F0uNO7oZSxW71QIkXx6e4sIst+PvD3rql+bT+L
 KJ5x1rsvCrSI6ioLExRwix0G3xAwg4tKm5vIi3efpERC8Ld1y3zHPuUnYhsHqw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Liu Ying <victor.liu@nxp.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260318-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v3-1-147fea581279@nxp.com>
References: <20260318-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v3-1-147fea581279@nxp.com>
Subject: Re: [PATCH v3] drm/bridge: Fix refcount shown via debugfs for
 encoder_bridges_show()
Message-Id: <177452148270.778037.5313332185342216724.b4-ty@b4>
Date: Thu, 26 Mar 2026 11:38:02 +0100
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


On Wed, 18 Mar 2026 13:26:05 +0800, Liu Ying wrote:
> A typical bridge refcount value is 3 after a bridge chain is formed:
> - devm_drm_bridge_alloc() initializes the refcount value to be 1.
> - drm_bridge_add() gets an additional reference hence 2.
> - drm_bridge_attach() gets the third reference hence 3.
> 
> This typical refcount value aligns with allbridges_show()'s behaviour.
> However, since encoder_bridges_show() uses
> drm_for_each_bridge_in_chain_scoped() to automatically get/put the
> bridge reference while iterating, a bogus reference is accidentally
> got when showing the wrong typical refcount value as 4 to users via
> debugfs.  Fix this by caching the refcount value returned from
> kref_read() while iterating and explicitly decreasing the cached
> refcount value by 1 before showing it to users.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: Fix refcount shown via debugfs for encoder_bridges_show()
      commit: f078634c184a9b5ccaa056e8b8d6cd32f7bff1b6

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

