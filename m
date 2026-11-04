Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0A606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TLlQ6ZKv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F097D10FB12;
	Wed,  4 Nov 2026 10:59:04 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D76D10FB19;
 Wed,  4 Nov 2026 10:58:59 +0000 (UTC)
Received: from [IPv6:::1] (ptz.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::77])
 (Authenticated sender: lst@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EE5752008B9;
 Wed, 04 Nov 2026 11:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1793789938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZFGF4yVK8CasvOvAXi/K/IhB8egqk0MRd0U/7JM4nI=;
 b=TLlQ6ZKvu6bXMiiyckpsPoVyhjyUb3xv7sKk4zj8QfNRV58YyZqR4MBdrR/cY1k1zA7hdQ
 uKDGpM56BoeZ//CrB2JXnAgK7ilFxaYcgYSmhYdDm6S8bQ/+fHVtS/f3s+0fE2cXUUfc9W
 jV4LiNVQgEk9LEDbUBybPA84WQiY6xyuPvvd8t8/bx/iwsrENROeKYdnlYuEwLgo8qeOWU
 6uVta/ZX1eNY0gr+ue9goAn1CWOIa9pwDGx9oGjJeLkiNvzJkn49v4PEe9Kc7wJhziLrm4
 xeWHR3q+XSgTS0Rk/wKyxdCN/7Hy74B+hh088Hinkpm+SbibTkZAhFPqXtvkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1793789938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZFGF4yVK8CasvOvAXi/K/IhB8egqk0MRd0U/7JM4nI=;
 b=R1jiyD1hstnR1F9AVO7KSV5iL0G0U/obkKEufsN7hXhAVXr0/ElCasNPA1UTHusDYKNJYY
 pieUChCofcGko+EIj35+uf9gqkVJXm8Xm7uFigkNICre+1U2AeNYZI+xbfN7FOpwQFqrHH
 CsdX6QKoJrHTv4N1vbvX57jjipfX6cR/V3OzpNNPSQFzXFjAbWpuFYQFhnvDYdV1x7g5T7
 Mc/UfLoS/o/b0GZdxKWJzSQG6foQI6883dql5DB0hhoHtFlnIWmKfXWNqM5rACptO3lVVJ
 s36Raux9NSxWMgLXBvLjzJGt8h/HfE37J3pk6BquVaj8v9yI0+Lvj+cpDgTHHg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=lst@pengutronix.de smtp.mailfrom=l.stach@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793789938; a=rsa-sha256;
 cv=none;
 b=Jqu7Cv3wg03x/46cig9MB5ofn6u8liJyLUhcMrPmM8KpDDiFKpLLZ0ueHOctlDa/7w/wMl
 6GtAdfXZ7kk3oFgy8Eba+EDFxcQ27mkhKCs0Qbj2FCzC28n5wR2WKLDHu5d0VEzKIdxOhO
 qdlFFklqag6fMhT+RxsWeyli+XrkXJRPYuWBqgzFiLeSrDlCba/JNNpOiedZAyQn+9kz2e
 QFml4f26Ar/MjKN5syonIjCBxpjk/JRe1uQvCVx2eUWziOZb+GbwrJc1L+8F/Y4OlLoID5
 o0zfL1KpnBtDAYmbmsoZxUjzRHpkQl6Kp821g+4uQUfWc2zePSyFlF35LE26hg==
Message-ID: <b6999d67d14772a9b3b90e3cce84d96551e9d63d.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Fix NULL dereference on unbind without PPU
 flop reset
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
 <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Gert Wollny <gert.wollny@collabora.com>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>, 
 stable@vger.kernel.org
Date: Wed, 04 Nov 2026 11:58:57 +0100
In-Reply-To: <20261102-etnaviv-unbind-flop-fix-v1-1-588fd16f6768@igalia.com>
References: <20261102-etnaviv-unbind-flop-fix-v1-1-588fd16f6768@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Montag, dem 02.11.2026 um 11:38 +0100 schrieb Christian Gmeiner:
> From: Christian Gmeiner <cgmeiner@igalia.com>
>=20
> flop_reset_data_ppu is only allocated on GPUs that need the PPU flop
> reset. However, etnaviv_unbind(..) frees it unconditionally, and
> etnaviv_cmdbuf_free(..) dereferences cmdbuf->suballoc before checking
> whether cmdbuf is NULL.
>=20
> As a result, unloading the driver on GPUs that do not need the PPU
> flop reset causes a NULL pointer dereference at address 0.
>=20
> Fixes: 85ba57ad88cf ("drm/etnaviv: Add PPU flop reset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 08aca9035fc1..ec1352c1b09f 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -601,8 +601,10 @@ static void etnaviv_unbind(struct device *dev)
> =20
>  	component_unbind_all(dev, drm);
> =20
> -	etnaviv_cmdbuf_free(priv->flop_reset_data_ppu);
> -	kfree(priv->flop_reset_data_ppu);
> +	if (priv->flop_reset_data_ppu) {
> +		etnaviv_cmdbuf_free(priv->flop_reset_data_ppu);
> +		kfree(priv->flop_reset_data_ppu);
> +	}
> =20
>  	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
> =20
>=20
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-etnaviv-unbind-flop-fix-5c77f75de45f
>=20
> Best regards,
