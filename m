Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC6660A2610
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySahEcCY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D109112DD9;
	Fri,  6 Nov 2026 13:59:28 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A1F112DCF
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:59:17 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-33fb4680717so1239007eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:59:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793973557; cv=none;
 d=google.com; s=arc-20260327;
 b=IDlNdwUQR9BTyiAChl3P9jOKFBQuaacivWLZdzZLdgero2fr4+DefIxOhaM7gDZTTr
 H6thje7fvBRJUkpEUgwI4J1NLmMIUP2r6SU8Sb/ZG3BlNwt3HJ5N+57z1tYQDCfqfKiN
 WK4IbXjSlGxm4VWS7BofZb0aG9VtrD9QK2f+vRQtZIzi3Zg9UUsukYJax52+21+b2fEt
 9FuMgAzmMGNtTd9UHRKvsRQSp8Og+6ZO8OdIBdlFCsPLkVVjXB+//3i3xSvpTt1tJkuJ
 vbUz6gKGMCVS8DW49xkppftPfQZWAQ9zLxkQINYdV0FTaqeOBIixZhDFq4mWMGjx7rU3
 +vAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ysjRF7+5KAzB2nN8K3/7fs9i+z/VoJBmooPC53OWZV0=;
 fh=sclpGijqSwo8aV/fi9p3b9siZlqr0I4CiI8aLtGM4i8=;
 b=su1kuR4hUcJ1f4hLL/l5t1KyS/4uClh+BOSDvOdkUKQBq0VP47oMtE7DkgzZMHej16
 RzLHFFlE/KEy1/Zc/B4QFw0Do88naTe0Gxa8ryVhsjTVoEqgzcC6GYFKWnw4idUqFmP9
 Yj3QauB/du3a45wXVOo1qUGu3TNMebT749rNH36QtIYalSfhR/FkU/DXgSfAT33w/q33
 +XP5SDgJtbnpONOPXUObFie+Zd2siAOX3pgvPtiMceva99NEtmPUmzLQ23OKsQPEHtOD
 LSvCOF5fc5OTAQwlxO2pt7rOqzAMRtdVCsOqiuX5OX0aAGWu4XSzoi0rWevvJr3Kmcnz
 iUIA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793973557; x=1794578357; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ysjRF7+5KAzB2nN8K3/7fs9i+z/VoJBmooPC53OWZV0=;
 b=ySahEcCYB42Ff8pEHqWNfN8aZ/UBiuKI8DbKcPj49+VwxjPRM+i3SVRxbagV7U3nwf
 BO7o+P2J98JGTFVzUiQH+hy0hKRHzLiT7pWhaKtWJ+z2xf25mGGfJr7PKur2RqPTllXD
 qs4aioclQH5TxGqehgdePSnX72RZkyb1M5CGJShZJ8THmZwU0dZ0glUYBLcfM6i8WZHD
 Ej9N2mhNnPeEfVEeYlMFX5sbsHnUckBgCDYS4EAvJgGbdNMSXfdGicKFoK/NPNLc5CZe
 Noh132JWt1wLnZEzrZW7W08S7qj7IQZNL2ov5Bwi9VuaLcK+uTSxs9K7YM0aXGkRjjQk
 Oo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793973557; x=1794578357;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ysjRF7+5KAzB2nN8K3/7fs9i+z/VoJBmooPC53OWZV0=;
 b=qJjGmhoRudygSyTtYQNR60wT9IDxRv9doOdevtBAIAdmiCHuK1Li8j5Er4pkT6DT2D
 kCCOwCvGaX9SVrG5ejBALv6cWLYgzOkNO+Xf/x9LWwU98U1uIMZgb4A1w7hU7ZDNU1FJ
 yqSag+LMize7dTFppi7cXV8esPS836e66NiR8JhSylUAEp6gSm6mXp+TdOLFJbBO5mro
 kw3/S7ubTXcFsIfSUrCEqCq5uhl20X7H/7HzzIC2x0UaJLa3pqqACamQmbDpd8FxYaHl
 gl0IVv+a8fFWKbRyCAQgr5OSxVVN7Ok8xNogPGvxSjl6fdVLaoPoznthEOOhD1htek1h
 Xfrg==
X-Forwarded-Encrypted: i=1;
 AL+hErFvav5Es7m/ZV0AsDGISytTj7ACuPC0OHHUcOzDbFyyLgkaEu/VKp54g4iDAMpzQwrTV5qY+e0je8Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8U5KV+7ObsiQTs8w+Ae/01TPQnZfi0jnv3KHs/r34qbJyeQ+Lu
 tq494VqZagObfJ46iDm+saGlRO+E82JDwfA4gx41twSL2ArrCFcCPWcur+huoV82atRt4T1o+OP
 o93VwpuCBJ2rrUyP0763CZTbGrbmB3Ts=
X-Gm-Gg: AYBFou2kYjefq+6OadonneO+kgGZTIzAwfVASWD3XCojv1spXJRCrH1CfKG4qTtxaSp
 ulqhiH4V7c8f2XKvgAA2EddceyoEgzEpE8ynthfrXB5fYMkqR2IIB6G0nWSXO+OFVidPEmYGDai
 a9k6vy7edFIPZ5MGLifGxt9FKrM0CRL08BcqBxoJvWm7ObCSTXJmt+4+6s9BiMnmHbaIhMxAt83
 itqSDxhdUsb8tIbOyHSTXM/hxIUbUvl2FOAqLlJJhiPEcyakRN4gV6oMezHDPsWqvEKBE0mFZWR
 5yJV8K6W5CloHllfOfwTWOaepusBns4HibxvOQJE8LYhoGFafnq1B/FJMpvY7bWYc9H3VFAIfVY
 1LWaywI33ohnOSr4HWsEtHCOYsVENTvaDcwjcKYlB/hgRlgKGcRNSHBISbzGlk+mxPjR35gH89t
 nyTg+LPs9OsPpC5GtxzqjMl3UBPRE6ug==
X-Received: by 2002:a05:7300:8281:b0:369:f2f4:b227 with SMTP id
 5a478bee46e88-36f75b1ffd2mr2981710eec.18.1793973556636; Fri, 06 Nov 2026
 05:59:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-2-clamor95@gmail.com>
 <au3NWsXz-hg2LNr_@orome>
In-Reply-To: <au3NWsXz-hg2LNr_@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 6 Nov 2026 15:59:05 +0200
X-Gm-Features: AclHuK-j0iaOa56-THlEL2TIjiQTJ3K-OFRxGt-N5L_ts2vcZPaUDw3mRDwDbl0
Message-ID: <CAPVz0n3_oRz8aMr1W=8K7dnHhM=vuGpHjpq6+=80oXiFj5wfSg@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] drm: Add MIPI DBI bus support for MIPI DBI Type
 A and B
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15:14=
 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Nov 05, 2026 at 04:05:01PM +0200, Svyatoslav Ryhel wrote:
> [...]
> > diff --git a/drivers/gpu/drm/drm_mipi_dbi_bus.c b/drivers/gpu/drm/drm_m=
ipi_dbi_bus.c
> [...]
> > +/**
> > + * devm_mipi_dbi_device_register() - create a managed MIPI DBI device
> > + * @dev: device to tie the MIPI-DBI device lifetime to
> > + * @host: DBI host to which this device is connected
> > + * @np: device tree node associated with the panel MIPI DBI device
> > + *
> > + * This function is called by DBI host driver to create panel device.
> > + * It automatically calls mipi_dbi_device_unregister() when @dev is
> > + * unbound. It does not automatically free passed device node pointer,
> > + * it must be put manually.
> > + *
> > + * Returns:
> > + * A pointer to the newly created MIPI DBI device, or, a pointer encod=
ed
> > + * with an error.
> > + */
> > +struct mipi_dbi_device *
> > +devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_host=
 *host,
> > +                           struct device_node *np)
> > +{
> > +     struct mipi_dbi_device *dbidev;
> > +     int ret;
> > +
> > +     if (!host || !host->dev || !host->dbi || !host->dbi->command ||
> > +         !host->ops || !host->ops->attach || !host->ops->detach || !np=
)
> > +             return ERR_PTR(-EINVAL);
>
> Do we want dev->of_node to serve as a fallback for !np?
>

No we don't dev->of_node is hosts node, and np is panel node.

> > +
> > +     if (!of_device_is_available(np))
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     dbidev =3D kzalloc_obj(*dbidev);
> > +     if (!dbidev)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     if (of_node_test_and_set_flag(np, OF_POPULATED)) {
> > +             kfree(dbidev);
> > +             return ERR_PTR(-EBUSY);
> > +     }
> > +
> > +     dbidev->host =3D host;
> > +     dbidev->dbi =3D host->dbi;
> > +     device_initialize(&dbidev->dev);
> > +     dbidev->dev.parent =3D host->dev;
> > +     dbidev->dev.bus =3D &mipi_dbi_bus_type;
> > +     dbidev->dev.release =3D mipi_dbi_device_release;
> > +     device_set_node(&dbidev->dev, of_fwnode_handle(of_node_get(np)));
> > +
> > +     ret =3D dev_set_name(&dbidev->dev, "%s:%s", dev_name(host->dev), =
np->full_name);
> > +     if (ret)
> > +             goto put_device;
> > +
> > +     ret =3D device_add(&dbidev->dev);
> > +     if (ret)
> > +             goto put_device;
> > +
> > +     ret =3D devm_add_action_or_reset(dev, mipi_dbi_device_unregister,
> > +                                    &dbidev->dev);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +
> > +     return dbidev;
> > +
> > +put_device:
> > +     of_node_clear_flag(np, OF_POPULATED);
> > +     put_device(&dbidev->dev);
> > +     return ERR_PTR(ret);
> > +}
> > +EXPORT_SYMBOL_GPL(devm_mipi_dbi_device_register);
>
> Don't we need to of_node_put() here on failure? Otherwise we're leaking
> the reference that we obtained inside the device_set_node() argument.
>

This is fully repeats device_register logic of drm_mipi_dsi.c so
unless DSI framework has leak, this should be correct

> > +static int mipi_dbi_drv_remove(struct device *dev)
> > +{
> > +     struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->driver);
> > +     struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> > +
> > +     drv->remove(dbidev);
> > +
> > +     return 0;
> > +}
>
> Might as well make drv->remove() return an error and propagate that
> here.
>

Have you even checked the code? remove() callback is and should be void.

> Thierry
