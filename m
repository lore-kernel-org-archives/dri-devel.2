Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC0A606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fRtFVIzo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED55010E2E0;
	Wed, 28 Oct 2026 12:46:20 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC2810E2E0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 12:46:14 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-3514b90bb89so1766187eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 05:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793191574; cv=none;
 d=google.com; s=arc-20260327;
 b=UqmyNQM2v2/3MgyQab952GCu6naC0wnRnj0Hmj2Oimi+0fiFal+HvmvHq23Cmfbjsf
 3IaNmq7TFVk/7nRRXaZV95hWNvbRNBC/RvnUmUm8H2m2zlNyADS4d76LJcjrsG4UD8tW
 nSzprwFw2AAYsVC+MbKI9eBW+O07eEI/qJYlBFkdhxxSOj23zWCaA0TXBWZBIX2lmpwv
 HEJ7aeq14tB/wr+2m2FIH3ikVGvYq7tsjQ/RYTCF3SJTjotDCSE+HXxLZ6KzkJea6QGm
 8b+0EU4F7i86MLKj/m6YGUQZxBZXxdN6TmTjqZRcrIo49f6y9tA4R+0ocbqozSZHsghL
 ENcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pr+Qh9RwQ2EtytMAMXYpVvXWO/lPy5jLS4bDF48/ePg=;
 fh=xMDgjmsSI0o/+fg8+NzREO38qLLLxESuKlcdnqYZbCY=;
 b=km3dyroPJmJEZBBrZTAZaGqy71D1JrgbN6J9wXWxbZ8K8idpgrTo2SThcMWx8KuUlC
 terBYzZ1R3rZDbTA1zkyAOe8KtWhAudpF0c44r+sjPhwuoqzmu/m6H+yjinKzW+jgpx2
 PD0AHByK9GNIHw4ijOXUt9a1e8U5Oy5KNMh6dShQw4z2L8pQp7h7nzFAJOc7nq8+HgTN
 H1AqrlVzR6wj/KSJMT6GtsprYuDH7oaC5mohVyD0QZtaUtMdOAYRsdyVBlbuEsuLV8yD
 9IIQhjZtKsoQwXSqHJ9NiDP59cPhaoZ0VpsC/p9YZRn+yqbYV+Qsxe2DXPDEKE+Z7FQg
 6Dmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793191574; x=1793796374; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pr+Qh9RwQ2EtytMAMXYpVvXWO/lPy5jLS4bDF48/ePg=;
 b=fRtFVIzoNhIavRM+qUGL7Bc48VNC3ARJqwXLb6Ogz3QctJZV+OB4qFmI+Adf5FrU6I
 uiHUuI6eclBFHSMlXwTsmtLYZSJfUL7Ly8+pc6ZFLLya8ztG52jALX0h2wX29/c9soQx
 PMteQ+uVog5Cd81pPFCqJEPcf6xX/wdy5rhPa5tlhIKarpfB8jEaMX9VfAKQiEVCnKGx
 WylYZIu1xCmaDLUFSkb0X/IRdzDVIt6R9fmXi8N7SukQKioBzLmLSZuH8JiA8tBNmabj
 dOibPEpE89aMuUVNBvkwya8it8uAvFolveEcBdmufdEXMahyazC8qIBkU1CK4f6yvtuy
 A4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793191574; x=1793796374;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pr+Qh9RwQ2EtytMAMXYpVvXWO/lPy5jLS4bDF48/ePg=;
 b=CMPRLA/wLvZEMoO9PaMHxXtiMmA4Tb3rc+W/2eQF/dCk2XrIZYi1rHW7DgGttH0vF7
 z9UjPM4uMzzrkIg5ZYTIwowVlYGgIDOUzfan/Pvhm9E+Cp106sj9wRMOgtBsIJ/srBDv
 koHs7+45bFevX/k02wcAmA8Pia6nLjQoYmkx8+h3hEPusz9Sm2ctenIAXkNNjx/1+2dM
 bpVgv5YhMu0+oNg8SNDTt0yY+ClkOt9G337Dl9+ANcFfOGo/L4Q+KK1X++gc4LySB+c+
 lGbyF7ven1vekOgLRHhLpxr+72qcN94dysNz0RT6EqYB3iysE2fjGMM5XfvtkcM1BWn5
 SIFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwq4qKlb0rMiKlCo1XJIWHuprLQnvEUECSyyQPPPoUJbyU2+pcuh6VP8f8s6nE+REWdg46gel9R9qE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKSun8xAAhTX6tRzlxQ2cwcZVI/VnCLPUFUTh3NvMgv0Ays+QbO
 Jn79u1vb7uybJYkYHyG0WERLVdq9WgBxKpVOgX3HlGjploCbwCRWue7mC097J3MGRyX/2vvMtzJ
 vvvUqmuIK/ReEu9d8gxmpIKlEF4SThrg=
X-Gm-Gg: AYBFou1/plT7ehBcCqzJSHp0KjL8OAUwDDlatNSFtQoUKBWqS+W04DvqPohDHq2u9Ha
 jxjSrwenlFSdSGNUldbSShIqY2I7TBiKZHw2/Fd+r6Ko73+guQENekrk2qm80Y4uEPefV80fthK
 b58M4HUR9GEPxzNGbJzRmXmYDRZNS8oAG3VjHWF4yBSGbIPw9KX3qDNrJfP5QjmzjD+3mJjCeHa
 ooM9lsM7+rzfBaR3S012D4XtQ1Yi09GBjOroTn6l9Ko9WctVhG01pPPSRxgNhpngKIkQQgM78mI
 0UYMbAPrlbv/D20R/UFLcurKC3dtEQiz5qF2FG7TWLPodJ/naoCQwG/p5wEIZKUjIDkE+tf8ezs
 wF9Uo+JVl1CILM4ECO5JtGrru5xzDxtxlHwFJIXvoo5SRqUVf8FDAwBocx0uH/GHMWNrgxA==
X-Received: by 2002:a05:693c:83c3:20b0:369:f182:8e99 with SMTP id
 5a478bee46e88-36a20114838mr3697076eec.35.1793191573518; Wed, 28 Oct 2026
 05:46:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022132259.240717-1-clamor95@gmail.com>
 <0g7damfVTZ2r6s4H0kv6Lg@nvidia.com>
 <CAPVz0n1G0cDuUj7WRfj9YRgvMSd0sqSCjnir2p=QxUGu5BWTXQ@mail.gmail.com>
 <gXWEBbhSRWKBIHUcDXZu7w@nvidia.com>
In-Reply-To: <gXWEBbhSRWKBIHUcDXZu7w@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 28 Oct 2026 14:46:01 +0200
X-Gm-Features: AclHuK_z6xlcnPRnX5tVTskqs4cNcLBGx7AePFeqnVIxnyi6sGqea_4KfJ43bfE
Message-ID: <CAPVz0n3PeDm3X+hwP_yMhZPk22-gRL0+vFRj5J7QsyUhcAahtw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] drm/tegra: Add support for 8-bit CPU interface
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D1=81=D1=80, 28 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 03:3=
5 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sunday, October 25, 2026 5:51=E2=80=AFPM Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 25 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
03:46 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Friday, October 23, 2026 11:14=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > > =D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 11:26 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > =D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =
=D0=BE 10:53 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > > > > >
> > > > ...
> > > > > > > +MODULE_ALIAS("platform:tegra-dbi");
> > > > > > > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > > > > > > +MODULE_DESCRIPTION("Nvidia Tegra20/30 MIPI-DBI Type B driver=
");
> > > > > > > +MODULE_LICENSE("GPL");
> > > > > >
> > > > > > No separate platform driver or device. If a separate struct dev=
ice is
> > > > > > needed for some technical purpose, we need to create a minimal =
separate
> > > > > > virtual device, but unless there is a strong reason to have tha=
t we
> > > > > > should be fine with just the dc device.
> > > > > >
> > > > > > Thank you
> > > > > > Mikko
> > > > > >
> > > > >
> > > > > ATM, I use bridge framework to describe interface and I am attach=
ing
> > > > > it to RGB since it basically uses RGB to transfer video data. It =
works
> > > > > pretty nice so far.
> > > > >
> > > > > You propose to replicate how RGB works just for DBI?
> > > > >
> > > >
> > > > One of the reasons I used separate pdev was to be able get mipi_dbi
> > > > from it using dev_get_drvdata() from patent (dbi bridge in this cas=
e).
> > > > DBI framework seems to not have a way to pass it in any other way,
> > > > unless you know smth I don't.
> > >
> > > Right, I think using a bridge is fine; passing the mipi_dbi interface=
 is
> > > properly done in other ways. The direct parent devdata link is a bit =
of
> > > a "poor man's bus", and sometimes it breaks down, such as here.
> > >
> > > MIPI DBI is comparable to MIPI DSI -- both have a hardware channel th=
at
> > > sends both pixel data and commands. I think we should follow DSI's
> > > example and have a DBI bus and devices while keeping it as simple as
> > > possible.
> > >
> > > The DC driver would register a DBI host and the panel would bind as a
> > > DBI device. The DC driver can then supply the mipi_dbi object in a fi=
eld
> > > of the mipi_dbi_device.
> > >
> > > This is a bit more complicated than a parent devdata pointer but much
> > > cleaner, and follows the existing DSI pattern.
> > >
> >
> > I understand your intentions, but ATM kernel lacks any DBI type B
> > framework. No hosts, ho devices, noting granular. Implementing
> > everything just not worth my time to support 2 panels of device based
> > on Tegra 20. And I am talking not about time to actually implement
> > this in the code, but to upstream. DSI framework is huge, copying even
> > part of it to wrap legacy DBI interface and ustreaming it does not
> > worth hassle. And yes, I am a poor man, I use a parent devdata bus.
>
> I sketched out the bus implementation and I really don't think it's that
> complicated -- about 200 lines in total. See below. If there turn out to
> be issues we can put an equivalent into drm/tegra/.
>
> -- drm_mipi_dbi_bus.c
>
> /* MIPI DBI devices with command transport through parallel interface */
>
> #include <linux/err.h>
> #include <linux/init.h>
> #include <linux/of.h>
> #include <linux/of_device.h>
> #include <linux/slab.h>
>
> #include <drm/drm_mipi_dbi.h>
> #include <drm/drm_mipi_dbi_bus.h>
>
> static int mipi_dbi_match(struct device *dev, const struct device_driver =
*driver)
> {
>         return of_driver_match_device(dev, driver);
> }
>
> static int mipi_dbi_uevent(const struct device *dev, struct kobj_uevent_e=
nv *env)
> {
>         return of_device_uevent_modalias(dev, env);
> }
>
> static const struct bus_type mipi_dbi_bus_type =3D {
>         .name =3D "mipi-dbi",
>         .match =3D mipi_dbi_match,
>         .uevent =3D mipi_dbi_uevent,
> };
>
> static void mipi_dbi_device_release(struct device *dev)
> {
>         of_node_put(dev->of_node);
>         kfree(to_mipi_dbi_device(dev));
> }
>
> static void mipi_dbi_device_unregister(void *data)
> {
>         struct device *dev =3D data;
>
>         of_node_clear_flag(dev->of_node, OF_POPULATED);
>         device_unregister(dev);
> }
>
> /* called by dbi host driver to create panel device */
> struct mipi_dbi_device *
> devm_mipi_dbi_device_register(struct mipi_dbi_host *host, struct device_n=
ode *np)
> {
>         struct mipi_dbi_device *dbidev;
>         int ret;
>
>         if (!host || !host->dev || !host->dbi || !host->dbi->command ||
>             !host->ops || !host->ops->attach || !host->ops->detach || !np=
)
>                 return ERR_PTR(-EINVAL);
>
>         if (!of_device_is_available(np))
>                 return ERR_PTR(-ENODEV);
>
>         dbidev =3D kzalloc_obj(*dbidev);
>         if (!dbidev)
>                 return ERR_PTR(-ENOMEM);
>
>         if (of_node_test_and_set_flag(np, OF_POPULATED)) {
>                 kfree(dbidev);
>                 return ERR_PTR(-EBUSY);
>         }
>
>         dbidev->host =3D host;
>         dbidev->dbi =3D host->dbi;
>         device_initialize(&dbidev->dev);
>         dbidev->dev.parent =3D host->dev;
>         dbidev->dev.bus =3D &mipi_dbi_bus_type;
>         dbidev->dev.release =3D mipi_dbi_device_release;
>         device_set_node(&dbidev->dev, of_fwnode_handle(of_node_get(np)));
>
>         ret =3D dev_set_name(&dbidev->dev, "%s:%s", dev_name(host->dev), =
np->full_name);
>         if (ret)
>                 goto put_device;
>
>         ret =3D device_add(&dbidev->dev);
>         if (ret)
>                 goto put_device;
>
>         ret =3D devm_add_action_or_reset(host->dev, mipi_dbi_device_unreg=
ister,
>                                        &dbidev->dev);
>         if (ret)
>                 return ERR_PTR(ret);
>
>         return dbidev;
>
> put_device:
>         of_node_clear_flag(np, OF_POPULATED);
>         put_device(&dbidev->dev);
>         return ERR_PTR(ret);
> }
> EXPORT_SYMBOL_GPL(devm_mipi_dbi_device_register);
>
> static void mipi_dbi_detach(void *data)
> {
>         struct mipi_dbi_device *dev =3D data;
>
>         dev->host->ops->detach(dev->host, dev);
>         dev->attached =3D false;
> }
>
> /* called by panel on probe completion to attach to dbi host */
> int devm_mipi_dbi_attach(struct mipi_dbi_device *dev)
> {
>         int ret;
>
>         if (dev->attached)
>                 return -EBUSY;
>
>         ret =3D dev->host->ops->attach(dev->host, dev);
>         if (ret)
>                 return ret;
>
>         dev->attached =3D true;
>         return devm_add_action_or_reset(&dev->dev, mipi_dbi_detach, dev);
> }
> EXPORT_SYMBOL_GPL(devm_mipi_dbi_attach);
>
> int __mipi_dbi_driver_register(struct device_driver *driver, struct modul=
e *owner)
> {
>         driver->owner =3D owner;
>         driver->bus =3D &mipi_dbi_bus_type;
>
>         return driver_register(driver);
> }
> EXPORT_SYMBOL_GPL(__mipi_dbi_driver_register);
>
> void mipi_dbi_driver_unregister(struct device_driver *driver)
> {
>         driver_unregister(driver);
> }
> EXPORT_SYMBOL_GPL(mipi_dbi_driver_unregister);
>
> static int __init mipi_dbi_bus_init(void)
> {
>         return bus_register(&mipi_dbi_bus_type);
> }
> subsys_initcall(mipi_dbi_bus_init);
>
> static void __exit mipi_dbi_bus_exit(void)
> {
>         bus_unregister(&mipi_dbi_bus_type);
> }
> module_exit(mipi_dbi_bus_exit);
>
> -- drm_mipi_dbi_bus.h
>
> #ifndef __DRM_MIPI_DBI_BUS_H__
> #define __DRM_MIPI_DBI_BUS_H__
>
> #include <linux/device.h>
> #include <linux/module.h>
>
> struct device_node;
> struct mipi_dbi;
> struct mipi_dbi_device;
> struct mipi_dbi_host;
>
> struct mipi_dbi_host_ops {
>         int (*attach)(struct mipi_dbi_host *host, struct mipi_dbi_device =
*dev);
>         void (*detach)(struct mipi_dbi_host *host, struct mipi_dbi_device=
 *dev);
> };
>
> struct mipi_dbi_host {
>         struct device *dev;
>         struct mipi_dbi *dbi;
>         const struct mipi_dbi_host_ops *ops;
> };
>
> struct mipi_dbi_device {
>         struct device dev;
>         struct mipi_dbi *dbi;
>         struct mipi_dbi_host *host;
>         bool attached;
> };
>
> static inline struct mipi_dbi_device *to_mipi_dbi_device(struct device *d=
ev)
> {
>         return container_of(dev, struct mipi_dbi_device, dev);
> }
>
> struct mipi_dbi_device *
> devm_mipi_dbi_device_register(struct mipi_dbi_host *host, struct device_n=
ode *np);
> int devm_mipi_dbi_attach(struct mipi_dbi_device *dev);
>
> int __mipi_dbi_driver_register(struct device_driver *driver, struct modul=
e *owner);
> void mipi_dbi_driver_unregister(struct device_driver *driver);
>
> #define mipi_dbi_driver_register(driver) \
>         __mipi_dbi_driver_register(driver, THIS_MODULE)
>
> #define module_mipi_dbi_driver(driver) \
>         module_driver(driver, mipi_dbi_driver_register, mipi_dbi_driver_u=
nregister)
>
> #endif
>

Looks promising. I will give it a try.
