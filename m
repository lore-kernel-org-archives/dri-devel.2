Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D7606A322
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=FWKqAYDJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E60A10EA04;
	Tue, 20 Oct 2026 10:46:59 +0000 (UTC)
X-Greylist: delayed 481 seconds by postgrey-1.36 at gabe;
 Tue, 20 Oct 2026 10:46:52 UTC
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE8B10EA04
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792493210; x=1793098010; i=markus.elfring@web.de;
 bh=xxhdn2OVUJtF2HEE/DiJItd1DbzLWHnmnzj0M802xSc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FWKqAYDJ6W+PfwjXFX9ztG+/5M74jGHiAWkmdQOeFiuLySi3mvMWuQvA6/NeLG+Z
 4W6xFDg6bkrl/i6P/9kvQgriR1mBjM9KAFPoALx+2RXk3YM1dwQj96v8Odfovko77
 K6WV61fyefZuSdZDXbZ+s+9woFjj9KnEEZSxPPBNVAFX9uQvzzgusm8TG9KIl4sPq
 +7Ups0KsRl3jeHeVCnaaVhSq1PeXiss09sIfI18xbCx93uCRk3s05ZEekrLldeq83
 IwosUdWBdnvtuMmTYe2lC9pm4Q6tvIzoOUk5r5Cv/R/zYaT6kN4xL7cy179rqKUXm
 hVsdHmEK8CWlwAx5Gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CQh-1wZqhE44Ob-011DnT; Tue, 20
 Oct 2026 12:32:54 +0200
Message-ID: <312bd510-03ca-402c-aba7-d1c60188f926@web.de>
Date: Tue, 20 Oct 2026 12:32:38 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Nishanth Menon <nm@ti.com>,
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Tero Kristo <kristo@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LiangCheng Wang <zaq14760@gmail.com>
References: <20261019213726.4145532-11-devarsht@ti.com>
Subject: Re: [PATCH v3 10/14] drm/solomon: ssd16xx: Expose session management
 as plane properties
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261019213726.4145532-11-devarsht@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AAJarhhkiBAz2y4aW+ppvNMAXpTP4N19qIpvKPnuVgBlNGYQOEH
 4vxBCVgmwIR4tF5K665MQ4Lqf/GG0wTGeraUFqyRh5NveRun+RODho46Hc9TlPB4uH9dU6L
 2hgWjFO8mUPhg7FhFoD3rEWitidBEQn6rpLZZH+MJj2xqh3G1XyyfZd3pzWQqeSUpfY5bTL
 X9YYt5W9w45IOSv5E9O6A==
UI-OutboundReport: notjunk:1;M01:P0:LTqw6dkj5dQ=;m1/t4jkIl4zEx1EKTm0WuHma84Y
 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
 iKCqYt9XYUgEa1H+aLmnWtUwrm8S7ZBInCCcdk=
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E2=80=A6
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c
=E2=80=A6
> @@ -1619,6 +1725,8 @@ static void ssd16xx_plane_atomic_update(struct drm=
_plane *plane,
>  	drm_dbg(&device->drm, "plane_atomic_update: calling fb_dirty rect=3D(%=
d,%d)-(%d,%d)\n",
>  		rect.x1, rect.y1, rect.x2, rect.y2);
> =20
> +	mutex_lock(&device->lock);
> +
=E2=80=A6
@@ -1693,6 +1800,8 @@ static void ssd16xx_plane_atomic_update(struct drm_p=
lane *plane,
>  		device->border_waveform_pending =3D true;
>  	}
> =20
> +	mutex_unlock(&device->lock);
> +
>  	pm_runtime_mark_last_busy(device->drm.dev);
=E2=80=A6

How do you think about to apply scoped lock guards?
https://elixir.bootlin.com/linux/v7.3/source/include/linux/cleanup.h#L332-=
L335

Regards,
Markus
