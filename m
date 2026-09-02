Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FCEC624D6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CCBD10E04F;
	Wed,  2 Sep 2026 16:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1Rs45NW2";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484A410E04F
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 16:42:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A334C1A1972;
 Wed,  2 Sep 2026 16:42:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6E0BE6053C;
 Wed,  2 Sep 2026 16:42:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0CEBA11C79C04; 
 Wed,  2 Sep 2026 18:42:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788367348; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=rDUBEK3MGggx0/ed+dJrd4a8xpH6EkMgFmnA5of609g=;
 b=1Rs45NW23JLM5afFIEG1uUtnBxW6NIf58AOOl86G2ryJzasMoAI15d6gqcbOqMgfCkYE9v
 xKZJ7f4O/hCA4nseIVlktmNvbg+sz+TT13a9TwMiNHL+IBkHh/CEFQJNSVyN5rknJo315+
 uyXxukiZBfXg6amOGIm9f+zUG3+MLccKslD8MebYPAqlhb8B5Cgm4pyOVf7+1jIfiu0Auo
 lEKno+kpHQlUHqOobbZI7RbuBrO7UfDYEQfOXW/q3mT+aV9NhRYrmRCabMkHooYx4JTtRb
 wpys26+UohsfNaJeG0w8M/EdThqrOhvDM358KOgG27uzMBQ9ntTR9hqIG76kmw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <20260812152535.82238-1-osama.abdelkader@gmail.com>
References: <20260812152535.82238-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH v4 5/6] drm/panel: Use managed helpers in display
 vendor panels
Message-Id: <178836734466.906849.11891939856337750875.b4-ty@b4>
Date: Wed, 02 Sep 2026 18:42:24 +0200
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


On Wed, 12 Aug 2026 17:25:33 +0200, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach and panel add helpers in display vendor
> panel drivers and drop the corresponding manual detach and panel remove
> calls from remove paths.

Applied, thanks!

[5/6] drm/panel: Use managed helpers in display vendor panels
      commit: a2419a3e63274fcd34c83c94d3730f1b3aa8d2ad

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


