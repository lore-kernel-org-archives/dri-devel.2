Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21384606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HKr/27UZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0B41128EF;
	Fri, 27 Nov 2026 09:07:13 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C616F1128C2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:07:07 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-386cf1041cdso4742989eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795770427; cv=none;
 d=google.com; s=arc-20260327;
 b=azaI6kUNGGR+qti0Y7LaiNyjbcdq/naUrHaevylD0uoZT7fk9y6BT2n1XKge12d0QW
 BmKBQy3eaceZwobkJ1MWSPiMrqn0y118N/BoQH57YfHb6eL5GeOZmvSLPRoEBGWvCJ2O
 mRovsyLLcXPRXuyhsehBtP6N+4EnroORV/ZjTwRi4lyiN8oljlZ+B4f8y94QxT6diea2
 vGHQblgA/BIbmDdOnTEtW+lnG5GLidetlqCoF2DBzG2p54xkhuyDjt9VFByebp38fdKB
 2AYjoTdLCGNLRquuHddqvvWnoHw2CE8xFXV5KXD/wdeKi0Kp+R8/3YnrWksq56T8Ehuk
 p7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6H4dcPiNwtNqTPtP0IJs0JFDcABvS0AB4nns+YiLCVQ=;
 fh=nDCLLlPLjGgSpizKIRKX98jcdsgG+BjO7NyBD7v5H5g=;
 b=ANxBTLJZhWot7DOqWwq37L8SEAit8pmuY1eZwcD17bWtCLFBRsDmuA6uBfylSjG9TL
 RLORT/MuvBvkEj1OdZpVkO9Qer8Sz92iiepdHpBh2/LGU2nka16JryFm3tGIOQvAvh+U
 MgenT0iuL9PRyN9DdQf1L374OiS86CmOfP4quEeeSp+J/NVO2Phe9vQheCqcOLBDSo8e
 Tas9sseb/jR+pr8cQltqqXpJ45pbdKA2vUL/IeJFjjluWmI+ekYy0RWrbKGe0lxXHQpT
 WqpxEyMtNQI+7iMbJu5U0F9SwGP+byeBz/housT6+Le5AhdEg9q38qNN+meDeMdNBazP
 xZYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795770427; x=1796375227; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6H4dcPiNwtNqTPtP0IJs0JFDcABvS0AB4nns+YiLCVQ=;
 b=HKr/27UZqagZ118cNPx8rC/68dYIvx0FaRG152g9pN+a3soPLkaBW3tmKK10QpF2Uz
 HlHicCTDgYqYkj8eYA6TJWB1XxLiWAf47CrILiymIX+F+rr4JYTzbxDRcyi4qZuhBXMb
 fm5pSzbtT2uoVvYA9q55nl1K/gijQ8/EwH4fRTVGN7yl/dv4DHFzcPI3zAgwc0Qt9zfp
 q9fXHWPXVdqfbIQg26QohN/9x6drJOwNq9SOo33iNmIL3ZkR4ZDXbuXi8vk7r1CnXyTV
 HsV52cp2o03PvYDUSl7wmMeXTvpIZprLwyXupqrNzt4aLHWVym9Y2yrhMOfj/bV6MrFZ
 bswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795770427; x=1796375227;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6H4dcPiNwtNqTPtP0IJs0JFDcABvS0AB4nns+YiLCVQ=;
 b=1J+s8AbYnnUOClxEdhc2BmH5gu9EkCbSHmXrdpIlFoVuAz7JvjMO+WxU2is+5NRA1f
 h7Z8bZNZel4GzfjDWwh+hFvYlKhFaOGdDmu8A2lSJIdiB8QWV3PtsDOtxgX09Uo9aWBj
 um6ODt0oCy4W+aC7NoPLUpdfJ+QhRIUJHales/1pOX4q0VllQr63tWD7iYKZTimL1HPb
 GTAe65BV9fLduW8xAPjNyK4ZvZX50elHEsksb7u0kN7s2IGoyeZQrzIaB4edq/ddt6J3
 Thr53gHi1hKb1xpKMeVWDjXyT6vTJ/MnDpqAmoctDJKcNIXgVLpb2ZbRKw6eteKz1sTg
 JdQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGBJFpF5SnoiLSx9aBGsE014uUr7REc0EqqZhl3JDZaaAjnsEoowRldA8aWpkyVipsb3sDYIXM9KDk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9w1JCHR7qNXl7lCUJylupu7FhkO3dCiYgn58fcuZex6v3d5Xtm
 Mg5EStQnKLH1QHw6F3iaYlNr0v+Evi3zK/LCkSKaye3Q6ovJofo9lOsojBDsGe8cf3WCWfZloW0
 brEj6RV/8NL4y2GLe8VNnW2NWndj47UE=
X-Gm-Gg: AZFdTZc4xD5QJOIdnypoQPnotlvwZrNaChuOj2YYi+q+KIP7dz6jnUFdCxJWwAE+Djf
 eT+47tO1yzQMQQuS56IZWcJKBDV5AbzBxd72E5t7mTi6aVuvEPJw8P4Jan7tkW75uWAz0oM9uBp
 1N4a3XKmCbT88GXFwi/+pFAy/CEDp0y+GmdEjSQg93q0fWp9/O7YXyu/Vs8uH/92cTfIM05Kk1M
 N6jK/dRGZ9TsyAgRHEnLgkN4HrcMO7a0LR45Pzd9EHny/6r9/F1vjvvTUE3XtoCzcEkOJij6ucr
 15ERhu7XBMzCl+mmtpbRdzQizdyFiHVMX3qRWbaJm6hWouKoQ8eOi53EZdpess7/kvZCw75jccL
 oLQNnQAyuoslIV+ajxQW5a9tiCCJTebJABJ/m0wPKeCQDnMbAQ8YY2S9mBUSkLOG97F0E4RdX7b
 bfnTTJk2pAIiXR7+FCKlV6x6E6ZKchVVrO3WDCmaDxaZ+kJXXmndM=
X-Received: by 2002:a05:7300:7c08:b0:384:3123:a0cb with SMTP id
 5a478bee46e88-3856ff5b880mr37174086eec.27.1795770426652; Fri, 27 Nov 2026
 01:07:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-2-clamor95@gmail.com>
 <tWBq0CmbQN-l5IJnxter_A@nvidia.com>
In-Reply-To: <tWBq0CmbQN-l5IJnxter_A@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 27 Nov 2026 11:06:54 +0200
X-Gm-Features: Aa3M54qofa0pqiM1Dvoc66ojfiJZlQDUZe0zEd9SwZRHvUIcdW_EA1BtcZ2GzCQ
Message-ID: <CAPVz0n2G2Bw6xyD4zYrEWNZj-SMGXLUeUFOHU6PBy_vketU_JQ@mail.gmail.com>
Subject: Re: [PATCH v8 01/12] drm: Add MIPI DBI bus support for MIPI DBI Type
 A and B
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 06:1=
6 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > The MIPI DBI bus allows modeling DBI hosts and peripherals using the Li=
nux
> > driver model. DBI hosts are registered by their respective drivers. Dur=
ing
> > registration, DBI peripherals are created from the device tree nodes
> > provided by the host.
> >
> > DBI hosts expose operations that can be used by peripheral drivers to
> > access associated devices.
> >
> > This implementation adds support for MIPI DBI Type A and Type B only.
> > Type C support existing in drm_mipi_dbi.c was not altered. The framewor=
k
> > is modeled to closely resemble the existing MIPI DSI setup for seamless
> > integration.
> >
> > Suggested-by: Mikko Perttunen <mperttunen@nvidia.com> # preliminary ske=
tch
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/Makefile           |   2 +-
> >  drivers/gpu/drm/drm_mipi_dbi_bus.c | 287 +++++++++++++++++++++++++++++
> >  include/drm/drm_mipi_dbi_bus.h     | 148 +++++++++++++++
> >  3 files changed, 436 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpu/drm/drm_mipi_dbi_bus.c
> >  create mode 100644 include/drm/drm_mipi_dbi_bus.h
> >
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 2c6bc093a923a..880f0dc930b85 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -166,7 +166,7 @@ obj-$(CONFIG_DRM_KMS_HELPER) +=3D drm_kms_helper.o
> >
> >  obj-y                        +=3D tests/
> >
> > -obj-$(CONFIG_DRM_MIPI_DBI) +=3D drm_mipi_dbi.o
> > +obj-$(CONFIG_DRM_MIPI_DBI) +=3D drm_mipi_dbi.o drm_mipi_dbi_bus.o
> >  obj-$(CONFIG_DRM_MIPI_DSI) +=3D drm_mipi_dsi.o
> >  obj-y                        +=3D arm/
> >  obj-y                        +=3D clients/
> > diff --git a/drivers/gpu/drm/drm_mipi_dbi_bus.c b/drivers/gpu/drm/drm_m=
ipi_dbi_bus.c
> > new file mode 100644
> > index 0000000000000..4b51de5bdf0b5
> > --- /dev/null
> > +++ b/drivers/gpu/drm/drm_mipi_dbi_bus.c
> > @@ -0,0 +1,287 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * MIPI DBI devices with command transport through parallel interface
> > + *
> > + * Copyright 2026 Mikko Perttunen <mperttunen@nvidia.com>
> > + * Copyright 2026 Svyatoslav Ryhel <clamor95@gmail.com>
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/slab.h>
> > +
> > +#include <drm/drm_mipi_dbi.h>
> > +#include <drm/drm_mipi_dbi_bus.h>
> > +
> > +/**
> > + * DOC: overview
> > + *
> > + * There are three MIPI DBI implementation types:
> > + *
> > + * A. Motorola 6800-type parallel bus
> > + *
> > + * B. Intel 8080-type parallel bus
> > + *
> > + * C. SPI-type with three options:
> > + *
> > + *    1. 9-bit with the Data/Command signal as the ninth bit
> > + *    2. Same as above, except it is sent as 16 bits
> > + *    3. 8-bit with the Data/Command signal as a separate D/CX pin
> > + *
> > + * This library provides a framework for MIPI Display Bus Interface (D=
BI)
> > + * compatible display controllers using Type A and Type B. This
> > + * implementation closely matches existing DSI framework behavior to
> > + * allow seamless integration.
> > + *
> > + * Type C options 1 and 3 are covered by drm_mipi_dbi.c with
> > + * mipi_dbi_spi_init().
> > + */
> > +
> > +static int mipi_dbi_match(struct device *dev, const struct device_driv=
er *driver)
> > +{
> > +     return of_driver_match_device(dev, driver);
> > +}
> > +
> > +static int mipi_dbi_uevent(const struct device *dev, struct kobj_ueven=
t_env *env)
> > +{
> > +     return of_device_uevent_modalias(dev, env);
> > +}
> > +
> > +static const struct dev_pm_ops mipi_dbi_device_pm_ops =3D {
> > +     .runtime_suspend =3D pm_generic_runtime_suspend,
> > +     .runtime_resume =3D pm_generic_runtime_resume,
> > +     .suspend =3D pm_generic_suspend,
> > +     .resume =3D pm_generic_resume,
> > +     .freeze =3D pm_generic_freeze,
> > +     .thaw =3D pm_generic_thaw,
> > +     .poweroff =3D pm_generic_poweroff,
> > +     .restore =3D pm_generic_restore,
> > +};
> > +
> > +static const struct bus_type mipi_dbi_bus_type =3D {
> > +     .name =3D "mipi-dbi",
> > +     .match =3D mipi_dbi_match,
> > +     .uevent =3D mipi_dbi_uevent,
>
> These two callbacks are just direct wrappers so I believe we should be
> able to set them to of_driver_match_device / of_device_uevent_modalias
> directly.
>

May you specify a bit more please?

> > +     .pm =3D &mipi_dbi_device_pm_ops,
>
> I think we can drop setting .pm as well. These callbacks will fall back
> to the same code (driver callbacks) if we don't set the bus PM ops.
>

Noted.

> > +};
> > +
> > +static void mipi_dbi_device_release(struct device *dev)
> > +{
> > +     of_node_put(dev->of_node);
> > +     kfree(to_mipi_dbi_device(dev));
> > +}
> > +
> > +static void mipi_dbi_device_unregister(void *data)
> > +{
> > +     struct device *dev =3D data;
> > +
> > +     of_node_clear_flag(dev->of_node, OF_POPULATED);
> > +     device_unregister(dev);
> > +}
> > +
> > +/**
> > + * devm_mipi_dbi_device_register() - create a managed peripheral MIPI =
DBI
> > + *                                Type A or B device.
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
>
> For brevity, I would just use 'an error pointer'.
>

Noted

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
> > +
> > +static void mipi_dbi_detach(void *data)
> > +{
> > +     struct mipi_dbi_device *dbidev =3D data;
> > +
> > +     dbidev->host->ops->detach(dbidev->host, dbidev);
> > +     dbidev->attached =3D false;
> > +}
> > +
> > +/**
> > + * devm_mipi_dbi_attach() - managed attach of peripheral DBI device to=
 its MIPI
> > + *                       DBI Type A or B devices.
> > + * @dev: device to tie the MIPI-DBI device lifetime to
> > + * @dbidev: DBI peripheral
>
> Add a return value description. Otherwise inevitably someone will send
> an autogenerated oneline fix to add it.
>

Noted

> > + */
> > +int devm_mipi_dbi_attach(struct device *dev, struct mipi_dbi_device *d=
bidev)
> > +{
> > +     int ret;
> > +
> > +     if (dbidev->attached)
> > +             return -EBUSY;
> > +
> > +     ret =3D dbidev->host->ops->attach(dbidev->host, dbidev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     dbidev->attached =3D true;
> > +     return devm_add_action_or_reset(dev, mipi_dbi_detach, dbidev);
> > +}
> > +EXPORT_SYMBOL_GPL(devm_mipi_dbi_attach);
> > +
> > +/**
> > + * mipi_dbi_write_buffer_multi() - mipi_dbi_command() w/ accum_err but=
 for
> > + *                              MIPI DBI Type A and B
> > + * @ctx: context for multiple DBI transactions
> > + * @cmd: command to be sent
> > + * @data: buffer containing data to be transmitted
> > + * @len: size of transmission buffer
> > + *
> > + * Acts like mipi_dbi_command() for MIPI DBI Type C but for Types A an=
d B
> > + * and deals with errors in a way that makes it convenient to make sev=
eral
> > + * calls in a row.
> > + */
> > +void mipi_dbi_write_buffer_multi(struct mipi_dbi_multi_context *ctx,
> > +                              u8 cmd, const u8 *data, size_t len)
> > +{
> > +     struct mipi_dbi_device *dbidev =3D ctx->dbidev;
> > +     struct device *dev =3D &dbidev->dev;
> > +     ssize_t ret;
>
> mipi_dbi_command_stackbuf returns an int, so this can be an int as well.
>

This is deliberately void, errors are accumulated in context. This
repeats DSI approach.

> > +
> > +     if (ctx->accum_err)
> > +             return;
> > +
> > +     ret =3D mipi_dbi_command_stackbuf(dbidev->dbi, cmd, data, len);
> > +     if (ret < 0) {
> > +             ctx->accum_err =3D ret;
> > +             dev_err(dev, "sending dcs data %*ph failed: %d\n",
> > +                     (int)len, data, ctx->accum_err);
> > +     }
> > +}
> > +EXPORT_SYMBOL(mipi_dbi_write_buffer_multi);
> > +
> > +static int mipi_dbi_drv_probe(struct device *dev)
> > +{
> > +     struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->driver);
> > +     struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> > +
> > +     return drv->probe(dbidev);
> > +}
> > +
> > +static int mipi_dbi_drv_remove(struct device *dev)
> > +{
> > +     struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->driver);
> > +     struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> > +
> > +     drv->remove(dbidev);
> > +
> > +     return 0;
> > +}
> > +
> > +static void mipi_dbi_drv_shutdown(struct device *dev)
> > +{
> > +     struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->driver);
> > +     struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> > +
> > +     drv->shutdown(dbidev);
> > +}
>
> This could be simplified slightly by making these (probe, remove,
> shutdown) bus-level callbacks (set on mipi_dbi_bus_type). Then the
> callback assignments in __mipi_dbi_driver_register are not needed. The
> 'if's do have to move into the bus-level callbacks. This also cleans up
> the remove callback return type.
>

I have added these to match DSI behavior as more established framework.

> > +
> > +/**
> > + * __mipi_dbi_driver_register() - register a driver for MIPI DBI Type =
A or B devices.
> > + * @drv: DBI driver structure
> > + * @owner: owner module
> > + *
> > + * Return: 0 on success or a negative error code on failure.
> > + */
> > +int __mipi_dbi_driver_register(struct mipi_dbi_driver *drv, struct mod=
ule *owner)
> > +{
> > +     drv->driver.bus =3D &mipi_dbi_bus_type;
> > +     drv->driver.owner =3D owner;
> > +
> > +     if (drv->probe)
> > +             drv->driver.probe =3D mipi_dbi_drv_probe;
> > +     if (drv->remove)
> > +             drv->driver.remove =3D mipi_dbi_drv_remove;
> > +     if (drv->shutdown)
> > +             drv->driver.shutdown =3D mipi_dbi_drv_shutdown;
> > +
> > +     return driver_register(&drv->driver);
> > +}
> > +EXPORT_SYMBOL_GPL(__mipi_dbi_driver_register);
> > +
> > +/**
> > + * mipi_dbi_driver_unregister() - unregister a driver for MIPI DBI Typ=
e A or B devices.
> > + * @drv: DBI driver structure
> > + */
> > +void mipi_dbi_driver_unregister(struct mipi_dbi_driver *drv)
> > +{
> > +     driver_unregister(&drv->driver);
> > +}
> > +EXPORT_SYMBOL_GPL(mipi_dbi_driver_unregister);
> > +
> > +static int __init mipi_dbi_bus_init(void)
> > +{
> > +     return bus_register(&mipi_dbi_bus_type);
> > +}
> > +subsys_initcall(mipi_dbi_bus_init);
> > +
> > +static void __exit mipi_dbi_bus_exit(void)
> > +{
> > +     bus_unregister(&mipi_dbi_bus_type);
> > +}
> > +module_exit(mipi_dbi_bus_exit);
> > +
> > +MODULE_DESCRIPTION("MIPI DBI devices with command transport through pa=
rallel interface");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/drm/drm_mipi_dbi_bus.h b/include/drm/drm_mipi_dbi_=
bus.h
> > new file mode 100644
> > index 0000000000000..6f00a8eef9c67
> > --- /dev/null
> > +++ b/include/drm/drm_mipi_dbi_bus.h
> > @@ -0,0 +1,148 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * MIPI DBI devices with command transport through parallel interface
> > + *
> > + * Copyright 2026 Mikko Perttunen <mperttunen@nvidia.com>
> > + * Copyright 2026 Svyatoslav Ryhel <clamor95@gmail.com>
> > + */
> > +
> > +#ifndef __DRM_MIPI_DBI_BUS_H__
> > +#define __DRM_MIPI_DBI_BUS_H__
> > +
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +
> > +struct device_node;
> > +struct mipi_dbi;
> > +struct mipi_dbi_device;
> > +struct mipi_dbi_host;
> > +
> > +/**
> > + * struct mipi_dbi_host_ops - DBI bus operations for MIPI DBI Type A a=
nd B.
> > + * @attach: attach DBI device to DBI host
> > + * @detach: detach DBI device from DBI host
> > + */
> > +struct mipi_dbi_host_ops {
> > +     int (*attach)(struct mipi_dbi_host *host, struct mipi_dbi_device =
*dev);
> > +     void (*detach)(struct mipi_dbi_host *host, struct mipi_dbi_device=
 *dev);
> > +};
> > +
> > +/**
> > + * struct mipi_dbi_host - DBI host device for MIPI DBI Type A and B.
> > + * @dev: driver model device node for this DBI host
> > + * @dbi: MIPI DBI interface
> > + * @ops: DBI host operations
> > + */
> > +struct mipi_dbi_host {
> > +     struct device *dev;
> > +     struct mipi_dbi *dbi;
> > +     const struct mipi_dbi_host_ops *ops;
> > +};
> > +
> > +/**
> > + * struct mipi_dbi_device - DBI peripheral device for MIPI DBI Type A =
and B.
> > + *                       This structure describes a peripheral DBI dev=
ice,
> > + *                       an endpoint for DSC commands and video data, =
and must
>
> DCS commands
>

Nodes

> > + *                       be paired with a DBI host device for MIPI DBI=
 Type A
> > + *                       and B. This layout is built to closely resemb=
le
> > + *                       the DSI framework.
> > + *
> > + *                       If your device is MIPI DBI Type C (with an SP=
I
> > + *                       control bus) and incorporates DBI within, you
> > + *                       should use the mipi_dbi_dev structure and Typ=
e C
> > + *                       framework from drm_mipi_dbi.c.
>
> I don't think we need to talk about the DSI or Type C frameworks here.
> drm_mipi_dbi.c already mentions it's for Type C.
>

I was explicit since Thierry and Maxime were very clear that
differences are not described enough.

> > + * @dev: driver model device node for this peripheral
> > + * @dbi: MIPI DBI interface
> > + * @host: DBI host for this peripheral
> > + * @attached: the DBI device has been successfully attached
> > + */
> > +struct mipi_dbi_device {
> > +     struct device dev;
> > +     struct mipi_dbi *dbi;
> > +     struct mipi_dbi_host *host;
> > +     bool attached;
> > +};
> > +
> > +/**
> > + * struct mipi_dbi_multi_context - Context to call multiple MIPI DBI f=
uncs in a row
> > + * @dbidev: Pointer to the peripheral MIPI DBI Type A and B device
> > + * @accum_err: Storage for the accumulated error over the multiple cal=
ls
> > + *          Init to 0. If a function encounters an error then the erro=
r code
> > + *          will be stored here. If you call a function and this point=
s to a
> > + *          non-zero value then the function will be a noop. This allo=
ws calling
> > + *          a function many times in a row and just checking the error=
 at the
> > + *          end to see if any of them failed.
> > + */
> > +
> > +struct mipi_dbi_multi_context {
> > +     struct mipi_dbi_device *dbidev;
> > +     int accum_err;
> > +};
> > +
> > +#define to_mipi_dbi_device(__dev)    container_of_const(__dev, struct =
mipi_dbi_device, dev)
> > +
> > +void mipi_dbi_write_buffer_multi(struct mipi_dbi_multi_context *ctx,
> > +                              u8 cmd, const u8 *data, size_t len);
> > +
> > +/**
> > + * mipi_dbi_write_seq_multi() - transmit a command with payload
> > + *
> > + * This macro will print errors for you and error handling is optimize=
d for
> > + * callers that call this multiple times in a row.
> > + *
> > + * @ctx: context for multiple DBI transactions
> > + * @cmd: command to be sent
> > + * @seq: buffer containing data to be transmitted
> > + */
> > +#define mipi_dbi_write_seq_multi(ctx, cmd, seq...)                    =
       \
> > +     do {                                                             =
       \
> > +             static const u8 d[] =3D { seq };                         =
         \
> > +             mipi_dbi_write_buffer_multi(ctx, cmd, d, ARRAY_SIZE(d)); =
       \
> > +     } while (0)
> > +
> > +struct mipi_dbi_device *
> > +devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_host=
 *host,
> > +                           struct device_node *np);
> > +int devm_mipi_dbi_attach(struct device *dev, struct mipi_dbi_device *d=
bidev);
> > +
> > +/**
> > + * struct mipi_dbi_driver - DBI driver for MIPI DBI Type A and B.
> > + * @driver: device driver model driver
> > + * @probe: callback for device binding
> > + * @remove: callback for device unbinding
> > + * @shutdown: called at shutdown time to quiesce the device
> > + */
> > +struct mipi_dbi_driver {
> > +     struct device_driver driver;
> > +     int (*probe)(struct mipi_dbi_device *dbi);
> > +     void (*remove)(struct mipi_dbi_device *dbi);
> > +     void (*shutdown)(struct mipi_dbi_device *dbi);
> > +};
> > +
> > +static inline struct mipi_dbi_driver *
> > +to_mipi_dbi_driver(struct device_driver *driver)
> > +{
> > +     return container_of(driver, struct mipi_dbi_driver, driver);
> > +}
> > +
> > +static inline void *mipi_dbi_get_drvdata(const struct mipi_dbi_device =
*dbi)
> > +{
> > +     return dev_get_drvdata(&dbi->dev);
> > +}
> > +
> > +static inline void mipi_dbi_set_drvdata(struct mipi_dbi_device *dbi, v=
oid *data)
> > +{
> > +     dev_set_drvdata(&dbi->dev, data);
> > +}
> > +
> > +int __mipi_dbi_driver_register(struct mipi_dbi_driver *drv, struct mod=
ule *owner);
> > +void mipi_dbi_driver_unregister(struct mipi_dbi_driver *drv);
> > +
> > +#define mipi_dbi_driver_register(driver) \
> > +     __mipi_dbi_driver_register(driver, THIS_MODULE)
> > +
> > +#define module_mipi_dbi_driver(__mipi_dbi_driver) \
> > +     module_driver(__mipi_dbi_driver, mipi_dbi_driver_register, \
> > +                     mipi_dbi_driver_unregister)
> > +
> > +#endif /* __DRM_MIPI_DBI_BUS__ */
>
> __DRM_MIPI_DBI_BUS_H__
>

Noted

> > --
> > 2.53.0
> >
> >
>
>
>
>
