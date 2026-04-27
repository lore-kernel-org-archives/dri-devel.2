Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C92AFF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC59610E745;
	Mon, 27 Apr 2026 13:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fUFooig8";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7973310E745
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:02:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0708D1A3442;
 Mon, 27 Apr 2026 13:02:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C8AE0600D1;
 Mon, 27 Apr 2026 13:02:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 08AF31072804C; 
 Mon, 27 Apr 2026 15:02:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777294972; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qbMw18GFEx8URm/DbOiBVp5PfU4iGmIruW8mcWdN3pc=;
 b=fUFooig8D8oNsqb+BM0OIXTMOO9nyVLT7DCsDHhSzYsOxqTeS/EZ9de48bVE/r1hyXdqvJ
 h49GIiYYaeIILSD6qg5ybnbsR+3VuKKPK3dp/dnx/4YkKUjksPOHCwWfHtw1zGQ54RkMs0
 l/au7S4cQ/rSW8ryJe7b+8jPckGcR5f6mfpVcL5AIzWhlITWq95VjcCQxSQbOTwKy5QMJU
 Ng4Hbvo9T//Ww/qtya2ljnCba/gKEZ0oizVPc//pivIMlnp2uBrZTrSNbuOEabWVjbku/z
 AqraOJoA0kuN4xiHJyrGnPZXYhQJaqGPRGuMPuEDYpIpAhXNURJh+QpxGXLtlA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 15:02:49 +0200
Message-Id: <DI3YHHC57ZD8.4FCLYJZ8YU19@bootlin.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Myeonghun Pak" <mhun512@gmail.com>, "Alain Volmat"
 <alain.volmat@foss.st.com>, "Raphael Gallais-Pou" <rgallaispou@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/sti: hda: Fix bridge leak on component_add() failure
X-Mailer: aerc 0.20.1
References: <20260424121206.14558-1-mhun512@gmail.com>
In-Reply-To: <20260424121206.14558-1-mhun512@gmail.com>
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

Hello Myeonghun,

On Fri Apr 24, 2026 at 2:11 PM CEST, Myeonghun Pak wrote:
> sti_hda_probe() registers its bridge before adding the component. If
> component_add() fails, probe returns the error directly and leaves the
> bridge registered.
>
> The remove callback unregisters the bridge, but remove is only called
> after a successful probe. Remove the bridge locally when component_add()
> fails so the probe error path matches the successful-probe remove path.
>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Duplicate of [0]?

[0] https://lore.kernel.org/all/20260423200622.325076-1-osama.abdelkader@gm=
ail.com/

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
