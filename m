Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6036072DC2
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SwYez2F7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9167210E29A;
	Mon, 16 Nov 2026 11:18:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC5210E29A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:18:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5D3264E415DE;
 Mon, 16 Nov 2026 11:18:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1E2666023F;
 Mon, 16 Nov 2026 11:18:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1D9F011BC00CB; Mon, 16 Nov 2026 12:18:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794827926; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dktc9lc+Bf7CsFmPizG4GZLduM0R6qpdkcP/3gu+EEE=;
 b=SwYez2F7X4olubYZ3QgDwgCQFJA25xgFhJqRhpBSP4o6vAQJswZtzhTlgXVima26nl2ujJ
 hdgAaKRrYWYUnlp6gQ11CuZdQ2rpg3BhD5TtbJEoPhAkoXwFCxGgNwXrq/2UnLSWYe+Ne/
 ZdUUFg7kM/khXPCOafpLTGx13V/7FWyAS4kFbtKk2C1fC0uG6EFnUFn9f2bBQ6CMgQvaFM
 Z8EC6PAXcds7g/kDLUa1R9IyqC1KTXQp/ECjcJuKgeb0Q+MTFl0bsMl+Y5Z6WCW02/JuI0
 XFLJ+f64DgdLdet2hlBlz3NqBk+2j5PfkODrnsoio3QrjUkmaroJLsvcIQjD6g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261030163254.3175671-1-laurentiu.palcu@oss.nxp.com>
References: <20261030163254.3175671-1-laurentiu.palcu@oss.nxp.com>
Subject: Re: [PATCH] drm/bridge: fsl-ldb: Remove panel naming and use
 scoped device_node cleanup
Message-Id: <179482792078.118378.10625483248086042386.b4-ty@b4>
Date: Mon, 16 Nov 2026 12:18:40 +0100
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 30 Oct 2026 16:32:52 +0000, Laurentiu Palcu wrote:
> The remote endpoint node is not necessarily a panel, so drop the "panel"
> naming and refer to the next bridge instead. Update the error message
> printed when no output port is connected.
> 
> While at it, convert the device_node handling in fsl_ldb_probe() to use
> the __free(device_node) cleanup helper. Since remote1 and remote2 now
> stay valid until the function returns, pass the selected one directly to
> of_drm_find_and_get_bridge() and drop the extra panel_node reference.
> Do the same for the dual-link port1/port2 lookups.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: fsl-ldb: Remove panel naming and use scoped device_node cleanup
      commit: 16c31b960788c1cee1bf9e8b115cda8b4643cb39

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


