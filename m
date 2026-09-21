Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBEDC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBB410E041;
	Mon, 21 Sep 2026 09:33:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hrLhf1Ru";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9FF10E041
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:33:41 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id CEA38C2460F;
 Mon, 21 Sep 2026 09:34:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BC4F760339;
 Mon, 21 Sep 2026 09:33:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DC4DA1032918A; 
 Mon, 21 Sep 2026 11:33:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789983214; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=XM4HQGrBz4+OFGrobuvy0488Z0TdUTFMNFt2LRu3OzE=;
 b=hrLhf1Ru73t9aY8LochvALjZfDluturyQZxYk4k9vHEIPBORNadNTLun13Ur1AXjMSWiCc
 s+WxQh8VBnuTNaum264n9T4ux6ASk60kXbWq+LbpY2vsPX+6zoQ+DB0O+yezTycrc3lJOa
 IZ4MM5kQsy1wFsn/7rr2Cn/Ur9FlLqhhwRLcxQmwnti740tVOpUkMxnD9uyla1v4CegBqs
 wBAXn8rGJmBk5BCKc7dH75gY+zrxeVLwcDnWDpnDsf6tIUBbcLahr3OJ5Lsduex0yqHkjI
 +JbXkXXtukWs0wTTWzz4AYYrGOdL6P0grTSyidzBqkd1HcC4aL/idgVrPcQKQw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 kees@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20260908172213.446608-1-andreas@kemnade.info>
References: <20260908172213.446608-1-andreas@kemnade.info>
Subject: Re: [PATCH] drm/omap: dsi: print errors with device prefix
Message-Id: <178998320945.177649.15427813145319109633.b4-ty@b4>
Date: Mon, 21 Sep 2026 11:33:29 +0200
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


On Tue, 08 Sep 2026 19:22:13 +0200, Andreas Kemnade wrote:
> There are two dsi controllers on OMAP4/5. If both are in use, messages
> without device prefix have no indication which controller they are coming
> from. That makes debugging harder.
> Replace DSSERR/DBG macros with dev_-prefixed print functions where
> the device is reliably accessible.
> Also replace function names by %s ... __func__ constructs and remove
> some debug outputs to satisfy checkpatch.
> 
> [...]

Applied, thanks!

[1/1] drm/omap: dsi: print errors with device prefix
      commit: af8296450df7678c94ae03054887639e3d4d35de

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


