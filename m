Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB9DC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52DF10EF12;
	Wed, 15 Jul 2026 07:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="jgpWWQCK";
	dkim-atps=neutral
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com
 [115.124.28.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C1D510EF03
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1784101392; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=fYczancSDpXTTTTzNgOct5Z1D1AO/aaqYRYfDjK901E=;
 b=jgpWWQCKcSwIZ/cRjLBcQQqq8wKYozX4Oqi/v5RmYXygPoxV5jPCbeV0D5lcU/9oyUdFmNh0+hlZnU9Lp55vRClGZtuxkNBq+AJ13hmQUsg8TJgS4Hkm4hUdZnujDQZxUuJ3b9N6NVdrGosARVnIZTwuSs2cQLbDI0FKyULk6zp7PS66zAIEdkeGQTcHhWSj5KRcAKtRdXSTJBG/ViTBvdLRpH+ULmCnbfhEGzcrZtbjWl3seZRXYLjEed57rdQjEE/ov+Lng6vwF+ulm+HgwuN8f8hjYOTSn2fWu01bSXceXjfHEwFRqeali4VxB9whNFrIyGNJH6wHWWkhaMqf2g==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436262|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0027374-0.000409488-0.996853;
 FP=3276738345256568050|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037025160;
 MF=syyang@lontium.com; NM=1; PH=DS; RN=1; RT=1; SR=0;
 TI=SMTPD_---.iLj66k9_1784101388; 
Received: from mail-ot1-f45.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.iLj66k9_1784101388 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 15 Jul 2026 15:43:09 +0800
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7eb787dec99so3161181a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 00:43:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4BKyQEEBPyMZ8hjRz/ZHK5x8ebUbYv4VkeHRogtsmu7TTyM+wU6yZ43kTiVwf9y/BcQyqBAs1n28=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0mZ6StzeIh6Iq5yU2NN5guCtPnOjb2vgQJsCaElWwWqjolhqi
 VyubVcMRa8yovA9Tsr3Qk4seY4M7Zaqpc19FNvrTTEm+TZvJU50EIaIn9LnI8qtLsf7Yejq9ODU
 4vACr3cGsUoyD3+9G8NkucrRCoKTrF+w=
X-Received: by 2002:a05:6808:1986:b0:4a4:68a9:5f04 with SMTP id
 5614622812f47-4a495ff24eemr1298337b6e.27.1784101387714; Wed, 15 Jul 2026
 00:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260715015438.2770155-1-syyang@lontium.com>
 <20260715015438.2770155-3-syyang@lontium.com>
 <20260715020616.B73771F000E9@smtp.kernel.org>
In-Reply-To: <20260715020616.B73771F000E9@smtp.kernel.org>
From: Sunyun Yang <syyang@lontium.com>
Date: Wed, 15 Jul 2026 15:42:55 +0800
X-Gmail-Original-Message-ID: <CAFQXuNZdwNxbAsnK7P4zs0eZnm4pN+6kKkO-aP6Q_higPEW-yg@mail.gmail.com>
X-Gm-Features: AUfX_mxYgF1LKb3HBSUHlun9wnYnCA6QN_5HsLuDULVayA3SKvsDowqxL49a2q4
Message-ID: <CAFQXuNZdwNxbAsnK7P4zs0eZnm4pN+6kKkO-aP6Q_higPEW-yg@mail.gmail.com>
Subject: Re: [PATCH v17 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI
 bridge
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

<sashiko-bot@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=8815=E6=97=A5=E5=91=
=A8=E4=B8=89 10:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] Missing cleanup of `output_bridge` in `mipi_dsi_host_detach` pre=
vents DSI device rebinds and causes use-after-free.

Intentional design, consistent with cdns-dsi-core.c cdns_dsi_detach()
(lines 1082-1091) which does not clear output->dev. Clearing
output_bridge would allow re-attach, causing devm_drm_of_get_bridge()
to allocate new devres without freeing the previous one, resulting in
a real memory leak. The DRM bridge framework does not support dynamic
bridge chain reconfiguration. No use-after-free: the -EBUSY guard
returns before dereferencing output_bridge, and bridge_attach is not
called by the SoC encoder after drm_bridge_remove().

> - [High] Sysfs attribute `lt7911exc_firmware` is accessible before the dr=
iver has finished initialization in `probe`, leading to a kernel panic.

False positive. The driver core creates dev_groups sysfs attributes
AFTER probe() returns successfully. In drivers/base/dd.c
really_probe(), call_driver_probe() (line 706) executes before
device_add_groups(dev, drv->dev_groups) (line 725). By the time the
sysfs file is visible to userspace, all mutexes, workqueue, and regmap
are fully initialized. There is no window where userspace can access
the sysfs attribute before initialization completes.

> - [High] Asynchronous firmware upgrade worker accesses `bridge.dev` witho=
ut holding a reference, causing a Use-After-Free if the DRM display control=
ler unbinds.

This is a known DRM bridge framework limitation, not specific to this
driver. drm_bridge_remove() does not clear bridge.dev, so all bridge
drivers calling drm_kms_helper_hotplug_event() share this risk. A
proper fix requires framework-level bridge-to-drm_device lifetime
tracking. Triggering requires root sysfs access to start firmware
upgrade while simultaneously unbinding the DRM master driver =E2=80=94 an
administrator operation outside normal usage.

> - [Medium] Driver illegitimately mutates the state of a downstream bridge=
 object by explicitly modifying `pre_enable_prev_first`.

Hardware constraint. The DSI output stream (register 0xe0b0) must be
enabled after the panel is powered on. The override is safe because
transfer() is a stub =E2=80=94 panel DCS commands are silently discarded an=
d
panel initialization is handled entirely by the chip's internal
firmware. The panel driver's prepare_prev_first preference is
therefore irrelevant for this chip. The comment above the assignment
documents this rationale.

> - [Low] The `lt7911exc->removed` flag is read without a lock or memory ba=
rrier in the firmware upgrade work, leading to a data race.

Valid.

> --
>
> --- Patch [2]: [PATCH v17 2/2] drm/bridge: Add Lontium LT7911EXC eDP to M=
IPI DSI bridge ---
> commit f9cec7dee2928b841f4104ddf68c1ebfeffba41a
> Author: Sunyun Yang <syyang@lontium.com>
>
> drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge
>
> Add support for the Lontium LT7911EXC bridge chip, which converts
> eDP input to MIPI DSI output using an internal firmware-controlled
> pipeline.
>
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/d=
rm/bridge/lontium-lt7911exc.c
> > new file mode 100644
> > index 0000000000000..5b7a184e96194
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
>
> [ ... ]
>
> > @@ -458,6 +458,25 @@ static void lt7911exc_firmware_upgrade_work(struct=
 work_struct *work)
> >  out_mcu_run:
> >       scoped_guard(mutex, &lt7911exc->ocm_lock)
> >               lt7911exc_inside_mcu_run(lt7911exc);
> >
> >  out_release_fw:
> >       release_firmware(fw);
> >
> >  out_unlock_upgrade:
> >       scoped_guard(mutex, &lt7911exc->ocm_lock) {
> >               if (!lt7911exc->removed)
> >                       lt7911exc->upgrade =3D false;
> >       }
> >
> >       /* Notify DRM to re-trigger modeset after firmware upgrade */
> >       if (!lt7911exc->removed && lt7911exc->bridge.dev)
>
> [Severity: Low]
> Is there a data race on the removed flag here?
>
> The lt7911exc->removed flag is set under ocm_lock in lt7911exc_remove(), =
but
> it is read here outside of any lock or memory barrier.
>
> While cancel_work_sync() in the remove path prevents a logical use-after-=
free,
> could this still trigger unmarked data race warnings from KCSAN?
>
> [Severity: High]
> Can this code trigger a use-after-free if the DRM display controller unbi=
nds?
>
> The firmware upgrade work accesses bridge.dev asynchronously. The bridge.=
dev
> pointer is assigned when the DRM master attaches, but the I2C bridge driv=
er
> holds no reference to it.
>
> If a user starts a firmware upgrade via sysfs and then unbinds the DRM
> master driver before the async work completes, the drm_device is freed.
>
> Does this leave a dangling pointer that the worker will then dereference =
in
> drm_kms_helper_hotplug_event()?
>
> >               drm_kms_helper_hotplug_event(lt7911exc->bridge.dev);
> >
> >       mutex_unlock(&lt7911exc->upgrade_lock);
> >  }
>
> [ ... ]
>
> > @@ -515,10 +515,31 @@ static int lt7911exc_dsi_host_attach(struct mipi_=
dsi_host *host, struct mipi_dsi_device *dev)
> >       lt7911exc->output_bridge =3D bridge;
> >
> >       /*
> >        * Force panel-first enable order: the DSI output stream (0xe0b0)
> >        * must not be enabled before the panel is powered on.
> >        * This override is safe because LT7911EXC's transfer() is a stub=
 =E2=80=94
> >        * panel DCS commands are silently discarded and panel init is do=
ne
> >        * by the chip's internal firmware. The panel driver's
> >        * prepare_prev_first preference is therefore irrelevant here.
> >        */
> >       lt7911exc->output_bridge->pre_enable_prev_first =3D false;
>
> [Severity: Medium]
> Is it safe to explicitly mutate the state of a downstream bridge object?
>
> The downstream bridge object belongs to the panel driver. Overriding its
> pre_enable_prev_first flag violates object ownership and could disrupt th=
e
> panel's expected power-on sequence.
>
> Could this cause the panel to fail to power on correctly?
>
> >
> >       drm_bridge_add(&lt7911exc->bridge);
> >
> >       return 0;
> >  }
> >
> >  static int lt7911exc_dsi_host_detach(struct mipi_dsi_host *host, struc=
t mipi_dsi_device *dev)
> >  {
> >       struct lt7911exc *lt7911exc =3D dsi_host_to_lt7911exc(host);
> >
> >       drm_bridge_remove(&lt7911exc->bridge);
> >
> >       return 0;
> >  }
>
> [Severity: High]
> Does this missing cleanup prevent DSI device rebinds and cause a
> use-after-free?
>
> In lt7911exc_dsi_host_attach(), output_bridge is initialized, but it is n=
ever
> cleared back to NULL in this detach function.
>
> If the downstream DSI panel is unbound via sysfs, the old wrapper remains=
,
> pointing to a freed panel.
>
> If the panel is subsequently rebound, the check for output_bridge in
> lt7911exc_dsi_host_attach() will falsely trigger and return -EBUSY,
> permanently breaking the display pipeline. Should output_bridge be set to
> NULL here?
>
> [ ... ]
>
> > @@ -662,11 +662,20 @@ static int lt7911exc_probe(struct i2c_client *cli=
ent)
> >       lt7911exc =3D devm_drm_bridge_alloc(dev, struct lt7911exc, bridge=
, &lt7911exc_bridge_funcs);
> >       if (IS_ERR(lt7911exc))
> >               return dev_err_probe(dev, PTR_ERR(lt7911exc), "drm bridge=
 alloc failed.\n");
> >
> >       dev_set_drvdata(dev, lt7911exc);
> >
> >       lt7911exc->dev =3D dev;
> >       lt7911exc->upgrade =3D false;
> >       lt7911exc->removed =3D false;
> >
> >       ret =3D devm_mutex_init(dev, &lt7911exc->ocm_lock);
>
> [Severity: High]
> Could a concurrent sysfs write during probe trigger a kernel panic?
>
> Because lt7911exc_attr_groups is attached via driver.dev_groups, the driv=
er
> core creates the sysfs files before probe() runs.
>
> Here, dev_set_drvdata() exposes the struct before ocm_lock, upgrade_lock,
> and the work struct are initialized.
>
> If a user writes to the sysfs file during this window,
> lt7911exc_firmware_store() will retrieve the partially initialized struct=
 and
> attempt to lock the uninitialized mutex. Should the drvdata be set after
> initialization is complete?
>
> >       if (ret)
> >               return dev_err_probe(dev, ret, "failed to init mutex\n");
> >
> >       ret =3D devm_mutex_init(dev, &lt7911exc->upgrade_lock);
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715015438.27=
70155-1-syyang@lontium.com?part=3D2
