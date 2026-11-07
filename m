Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC8606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0hx2Ff4f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5730D10E29F;
	Sat,  7 Nov 2026 13:54:46 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B5D10E29F
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 13:54:40 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-36cad25b8b0so2554802eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 05:54:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794059679; cv=none;
 d=google.com; s=arc-20260327;
 b=mIBbGfaR6w8UgZtlK4ZSqf58cCFqEBMEHdIoyR/KzxcbZIesRjGo8Z5bJYUJbFY5yL
 nKWi9h4u1nIkprEcGO1e5J0buCe/uwjRxOwrd9xiTrhC1hmXV+p1teJSOWiTTxik5CCD
 QLrHnEsZ3Pha1bezXwLswk8t0BLFUO4doqtsgG2H//TS5evq9Ep2203FdNQZR5ALSu0/
 yBgdgQctkFBLxCwaDhdX0sryxBD6u2eQMq03ljkcc8gqROO5nOAdNpgmzM/2AIyS6bha
 qvXC/K0tjbSRlj4Dg27z4nk1KIxMa6/5pI1of/l9ra2ny2xJWolfRBw5gu/8QiUe2y8x
 5Aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FK8JE1SvDX09qdFmWuC9l/vzgGLFtTsZ/4jIxUqIKUw=;
 fh=FqNNtCO2k92pj5VD+M/Qvp0czmsdGUunTEDx7tuasKs=;
 b=PHGJOGT9J7FQz5sx58wgWeAIFBJI3sUqTSNF8vgxCHl6HgQ5FDygVa9Yc6j9H+Fk6Q
 dLcSj17bsRhRwqXB3n6DVVwIbmas1W142qAeZFtzfe6E8GG2ph66quwBB+vtoOWWaR3L
 BDEKjuPJYJGo9g0Pe1tb/GHg5LtmxmdDqAiZ7uYnWDNRQzOtyTG2mhAJRh4sVzjwgyK2
 58e7Evto/iNQxn4VLI2AKsUBK3YHetkIHTL/7VJaO5ZwuKxHlrO0MfQfPYX05U2iA/2u
 6jkg7ME5Z/VHNceIliUeSPVzhZVJjuBJ21d+Q6kgrWjoSZcdRHipMVVRDHpJ7mi9KaRD
 i7vg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794059679; x=1794664479; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FK8JE1SvDX09qdFmWuC9l/vzgGLFtTsZ/4jIxUqIKUw=;
 b=0hx2Ff4fdHYvfEEy0Z8P7JDjlQ++m75RXRvYuoYUzZ80pexkv1MSicE3PAE6Ch39jG
 sJfEOHpxjeUDFEcEFlZuPM9IAPKsP8RXxJpHZbU/G3/XOlUFyFxEf8inwsc3bP8a0Ekz
 XbimsWg5aK70fGQZAsB4Fs3H2S3DXe5c2/q60gZavUZqZOHEzc+9mMPrr/RcW1xb8z3H
 AKS30pNZ7euT7D8KQd+YzMj6TMrhahWKMVgmBIyzdAH104gdf3pTHLdvplxUjqKOdusz
 3DuxDo0MzjhOtc14c/XHYKMej58sBOcEp4heBlS2K5MIoscNZeu44jnYCbKfTBaZCKEY
 kKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794059679; x=1794664479;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FK8JE1SvDX09qdFmWuC9l/vzgGLFtTsZ/4jIxUqIKUw=;
 b=lgMxNeoheN6tPZoJbfDLDHW5ab+C/zW5R6IPkMg55EDEm4FAZThZhV6R+qDCxOA7md
 CEOi3tR8HNEViDiislCQOxs40IFu1lBPunRMAUmSnq5DNA+sK6cWTJfvwArNCyc2R/cr
 T65faFS7xYWUXP578hbnc4atSp6DNrdXXmSUFLWgMrKG8vpDc6VSF6aFT1YXv1ehdEcz
 WfNtZWOXg4bj9iWvtxEji8Zh5HSUny4zyOQauzZkzOXc6501jfE6g635IXXPAU2AfcdD
 JxkraygQmwNyFUozgSYHyhTO0KwzSa2GS4ebMr8drPk30RywQ2aoWsNfKsFUCxvanFmU
 0W2A==
X-Forwarded-Encrypted: i=1;
 AL+hErFhGiptpPT3X8kQJD+fkVH4qElN4/d3Knh1uSdyGFaiLT1K8bBueQXACN3NWcPbe2qK0D2kjGDBV5E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8qtWhPKkREWGTLVIMVGp+Dx1CjaXjJfiIPIKPd86DM2i00b3KE
 wzugWosMd5fm1kfJ8i+7M1CnWkPGTPiVo4Vdr7bgIpkiPw1pvMaOnBjmvFPH47MsWmH1wp4Up08
 jXUMmoDAxYXVA/VLGrmqykZSMw9Acg40=
X-Gm-Gg: AYBFou1xtOa+0KbKsnkOzGS6wv7ki1dCtKs9gv3A7Bp2ljBPY1ht39W1BtwkhUSlejF
 PYfpK2TDh2NwzhLVylKobrau6UWHBJa4slXkg+bvOeWeSkgf8v9kuNHTsuJOIeZ75bksr3kjBvt
 zo3av5FHAgMhrbD4BXmS+VxYgjwAdGi54IjtiEh+e3vFdvfgClfLurdPNluKZZvUkUFn4qYbkhp
 BT17t5PU88EW1Cmq9PbyMYEYNALbBS52rAPmc6A5fsPQKSLwWo56PtGxLmCe4q+3+R2QmYn+hbe
 7LeS8ekU/4o+8qqniXgTA7s75ica6cAQa7OVHgivG7d2BZrRUsHTfm3l3eNo5X2470OsDGEBKa3
 x8RlIi0ff1ACN/ZHD0X490xe+AkzQ+h9LxPcYmNCYH5aNiZRKsMNlDjSnfY/T9o+1QWmoYdNm6s
 xtaOXic8hLuhwS/cu0StYh/WCilk+5cg==
X-Received: by 2002:a05:7300:ed13:b0:370:121a:b2f with SMTP id
 5a478bee46e88-370121a13b0mr8606853eec.11.1794059679071; Sat, 07 Nov 2026
 05:54:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-2-clamor95@gmail.com>
 <au3NWsXz-hg2LNr_@orome>
 <CAPVz0n3_oRz8aMr1W=8K7dnHhM=vuGpHjpq6+=80oXiFj5wfSg@mail.gmail.com>
 <au3telUE9A43PDWv@orome>
In-Reply-To: <au3telUE9A43PDWv@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 7 Nov 2026 15:54:27 +0200
X-Gm-Features: AclHuK8lORI9v0DJ7PzJIhwANBCoAngQBMqPQ00GdlIqFV0vGLKb_MHLVYVyoL8
Message-ID: <CAPVz0n0z36TnRJ87itGALHLUvNQJ7+NoOAKdhU=PyKpJhB8WFg@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] drm: Add MIPI DBI bus support for MIPI DBI Type
 A and B
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
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

=D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:19=
 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Nov 06, 2026 at 03:59:05PM +0200, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 1=
5:14 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, Nov 05, 2026 at 04:05:01PM +0200, Svyatoslav Ryhel wrote:
> > > [...]
> > > > diff --git a/drivers/gpu/drm/drm_mipi_dbi_bus.c b/drivers/gpu/drm/d=
rm_mipi_dbi_bus.c
> > > [...]
> > > > +/**
> > > > + * devm_mipi_dbi_device_register() - create a managed MIPI DBI dev=
ice
> > > > + * @dev: device to tie the MIPI-DBI device lifetime to
> > > > + * @host: DBI host to which this device is connected
> > > > + * @np: device tree node associated with the panel MIPI DBI device
> > > > + *
> > > > + * This function is called by DBI host driver to create panel devi=
ce.
> > > > + * It automatically calls mipi_dbi_device_unregister() when @dev i=
s
> > > > + * unbound. It does not automatically free passed device node poin=
ter,
> > > > + * it must be put manually.
> > > > + *
> > > > + * Returns:
> > > > + * A pointer to the newly created MIPI DBI device, or, a pointer e=
ncoded
> > > > + * with an error.
> > > > + */
> > > > +struct mipi_dbi_device *
> > > > +devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_=
host *host,
> > > > +                           struct device_node *np)
> > > > +{
> > > > +     struct mipi_dbi_device *dbidev;
> > > > +     int ret;
> > > > +
> > > > +     if (!host || !host->dev || !host->dbi || !host->dbi->command =
||
> > > > +         !host->ops || !host->ops->attach || !host->ops->detach ||=
 !np)
> > > > +             return ERR_PTR(-EINVAL);
> > >
> > > Do we want dev->of_node to serve as a fallback for !np?
> > >
> >
> > No we don't dev->of_node is hosts node, and np is panel node.
>
> Fair enough. The parameter name is a bit generic, but I guess if you
> read the documentation it becomes clearer what it means.
>
> > > > +
> > > > +     if (!of_device_is_available(np))
> > > > +             return ERR_PTR(-ENODEV);
> > > > +
> > > > +     dbidev =3D kzalloc_obj(*dbidev);
> > > > +     if (!dbidev)
> > > > +             return ERR_PTR(-ENOMEM);
> > > > +
> > > > +     if (of_node_test_and_set_flag(np, OF_POPULATED)) {
> > > > +             kfree(dbidev);
> > > > +             return ERR_PTR(-EBUSY);
> > > > +     }
> > > > +
> > > > +     dbidev->host =3D host;
> > > > +     dbidev->dbi =3D host->dbi;
> > > > +     device_initialize(&dbidev->dev);
> > > > +     dbidev->dev.parent =3D host->dev;
> > > > +     dbidev->dev.bus =3D &mipi_dbi_bus_type;
> > > > +     dbidev->dev.release =3D mipi_dbi_device_release;
> > > > +     device_set_node(&dbidev->dev, of_fwnode_handle(of_node_get(np=
)));
> > > > +
> > > > +     ret =3D dev_set_name(&dbidev->dev, "%s:%s", dev_name(host->de=
v), np->full_name);
> > > > +     if (ret)
> > > > +             goto put_device;
> > > > +
> > > > +     ret =3D device_add(&dbidev->dev);
> > > > +     if (ret)
> > > > +             goto put_device;
> > > > +
> > > > +     ret =3D devm_add_action_or_reset(dev, mipi_dbi_device_unregis=
ter,
> > > > +                                    &dbidev->dev);
> > > > +     if (ret)
> > > > +             return ERR_PTR(ret);
> > > > +
> > > > +     return dbidev;
> > > > +
> > > > +put_device:
> > > > +     of_node_clear_flag(np, OF_POPULATED);
> > > > +     put_device(&dbidev->dev);
> > > > +     return ERR_PTR(ret);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(devm_mipi_dbi_device_register);
> > >
> > > Don't we need to of_node_put() here on failure? Otherwise we're leaki=
ng
> > > the reference that we obtained inside the device_set_node() argument.
> > >
> >
> > This is fully repeats device_register logic of drm_mipi_dsi.c so
> > unless DSI framework has leak, this should be correct
>
> Nobody said that drm_mipi_dsi.c is correct. I'm reviewing this patch and
> it seems like it's wrong. If drm_mipi_dsi.c does the same thing it
> probably is wrong, too.
>

May anyone from DRM maintainers clarify this please. I would like to
know if I need to change here anything. Thank you.

> > > > +static int mipi_dbi_drv_remove(struct device *dev)
> > > > +{
> > > > +     struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->drive=
r);
> > > > +     struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> > > > +
> > > > +     drv->remove(dbidev);
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > Might as well make drv->remove() return an error and propagate that
> > > here.
> > >
> >
> > Have you even checked the code? remove() callback is and should be void=
.
>
> I don't know what you're trying to say here. Yes I can see that the
> remove callback returns void. My point is that device_driver.remove does
> *not* return void and since this is merely a wrapper around it for DBI
> it could also just return int for symmetry.
>
> But there's also continuous work trying to convert all driver remove
> callbacks to return void, so that's eventually going to get "fixed" here
> anyway, so might as well leave it like this.
>
> Thierry
