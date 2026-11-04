Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93975607168A
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wbGQOm3k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CE810E05E;
	Wed,  4 Nov 2026 17:57:01 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA2510E05E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:56:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1D8961A1454;
 Wed,  4 Nov 2026 17:56:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E3F2460770;
 Wed,  4 Nov 2026 17:56:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BA09A10329205; Wed,  4 Nov 2026 18:56:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793815008; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=pomOHAapQUnvxNXGyGq+ejBOj6+SbEhIie1BBI6hGCU=;
 b=wbGQOm3kU4XlqaXfMkG1e3oCPliNudbNeC7c8QJJrIVQE3yNuu4nf7/aKsBgokmzUv5Z6a
 t4Hhl5QJdio4PV9FwUAk1dQhLisRTb6M42a1/DXvIDqSoegKlYK+HxO8FlIAnZV+LkNVn+
 G+TJxn7X3hF3B6DpnE6Cmcxhd5oAq6n5SDLxB/2Ys+PrvcCXvFpAXDZIwsuymr93HmSgb4
 7roIicJBWVoE5Mpc/poKxuuJ7+o9BfIr3iru2jXcYrY/41WRTW8/FZe1rqLi2kxhSbl1NU
 qjXos/5K6rnlme+Fnf63NZh/TZJ9qLsCpc/mh3yfHi65MJdhTlmqyTqaUun+Kw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:56:41 +0100
Message-Id: <DMMMCJHUT8EL.1L6VS1X1K2BQE@bootlin.com>
Subject: Re: [PATCH] drm/bridge: fsl-ldb: Remove panel naming and use scoped
 device_node cleanup
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261030163254.3175671-1-laurentiu.palcu@oss.nxp.com>
In-Reply-To: <20261030163254.3175671-1-laurentiu.palcu@oss.nxp.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 30, 2026 at 5:32 PM CET, Laurentiu Palcu wrote:
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
> No functional change intended, other than the updated error message.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

I wanted to test this patch but it does not apply on current
drm-misc-next. Can you rebase and resend it?

BTW the content looks good, so if you only do trivial changes in v2 you can=
 add:

+Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
