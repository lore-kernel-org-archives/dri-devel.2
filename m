Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5697C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF6710ED0C;
	Tue, 14 Jul 2026 11:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="aF6qsUhi";
	dkim-atps=neutral
Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com
 [115.124.28.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3911D10ED0C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1784029609; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=i7cCoPUbrub6B12htwmRFp15EcZoaERECpcXhtYclkw=;
 b=aF6qsUhiByEak0U7SqIvoofkvKtKL8CQLp4o+QJvC1QLtRWk45OSkqZmhozSWGcl0lHgVw5e3Srzj9tO3L7luveTAr4/x/kQ38ANsmHsiukKDPPREWhae+J3jLFS2mvqh1aGv+uNZDa2FcE2bbIajwj/cAwAohcElOjUqtl2/tK3TbCGBE2/y278Z+CaETsab8STOhk0h7DpCPl7xgTYaThhjy2wradmgUPeHtYDF1ejGgqDCb2kM4Bbpa0qaSFgejK1qXYt3ARtqNuuA07yYt2Tt0KW9muBLVxPJob8noyigdRKbAuJb+rMWa2gDTpjrc1RAbL/x5GuBfe8KGxttQ==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07437065|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0130186-0.00169102-0.98529;
 FP=3418604069976786166|1|1|1|0|-1|-1|-1; HT=maildocker-contentspam033040074035;
 MF=syyang@lontium.com; NM=1; PH=DS; RN=1; RT=1; SR=0;
 TI=SMTPD_---.iL3g-fD_1784029606; 
Received: from mail-oi1-f178.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.iL3g-fD_1784029606 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 14 Jul 2026 19:46:47 +0800
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-491bc1d4e6bso2903992b6e.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 04:46:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9pA9jPwHK5AhDBHFdwDWVviHPxkcgBazFxaQC71ZIFLi2xRnUNVpd65k+zvzAcMRTHG0ldwHTPwZI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytGvZjecRKVt1Qo41W/hto06pk9btDXEXAzzdVBX54X4m4DCS3
 CmLAyXOcPm9U0wpnyBHB+ONBTMkCvGSM9tokGh94X3tYVJu2K9Ulj2kUVP4h+RupuaZTE3JXb90
 aLe1xDLasgsh1LZGhqWuUpYAbA9ELcwc=
X-Received: by 2002:a05:6808:1b99:b0:4a3:d383:b3ea with SMTP id
 5614622812f47-4a47a5e054dmr1059263b6e.27.1784029605960; Tue, 14 Jul 2026
 04:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260714105828.2763677-1-syyang@lontium.com>
 <20260714105828.2763677-3-syyang@lontium.com>
 <20260714111639.53ED11F000E9@smtp.kernel.org>
In-Reply-To: <20260714111639.53ED11F000E9@smtp.kernel.org>
From: Sunyun Yang <syyang@lontium.com>
Date: Tue, 14 Jul 2026 19:46:33 +0800
X-Gmail-Original-Message-ID: <CAFQXuNbYfMQO9EHm9Ym2ZPzHohNbkas9ThvLQmj=NLEe1bhi+A@mail.gmail.com>
X-Gm-Features: AUfX_myp2kzOEm1DUx7Y224QGA5tgUgrUe_G0ESXBpXArFi_gt7X8ykS3UZ2jeU
Message-ID: <CAFQXuNbYfMQO9EHm9Ym2ZPzHohNbkas9ThvLQmj=NLEe1bhi+A@mail.gmail.com>
Subject: Re: [PATCH v16 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI
 bridge
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, conor+dt@kernel.org
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

<sashiko-bot@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=8814=E6=97=A5=E5=91=
=A8=E4=BA=8C 19:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] Dynamic devm allocation and bridge registration in DSI host atta=
ch/detach causes devres leaks and list corruption.
> - [High] Asynchronous workqueue dereferences dangling `bridge.dev` if the=
 DRM display controller unbinds.
> - [Medium] Failure to clear `output_bridge` in `dsi_host_detach` prevents=
 panel re-attachment.
> - [Low] Mutating `pre_enable_prev_first` of a downstream bridge object vi=
olates subsystem API layering.
> - [Low] Unsynchronized reads of `lt7911exc->removed` in the asynchronous =
workqueue.
> --
>
> --- Patch [2]: [PATCH v16 2/2] drm/bridge: Add Lontium LT7911EXC eDP to M=
IPI DSI bridge ---
> commit f0896e2dbabe50d3cbe793868df9c6d4afd6db5f
> Author: Sunyun Yang <syyang@lontium.com>
>
> drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge
>
> This commit adds support for the Lontium LT7911EXC bridge chip, which
> converts eDP input to MIPI DSI output. It implements firmware upgrades,
> GPIO reset handling, and DSI host interface attachment.
>
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/d=
rm/bridge/lontium-lt7911exc.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
>
> [ ... ]
>
> > @@ -344,14 +344,14 @@ static void lt7911exc_firmware_upgrade_work(struc=
t work_struct *work)
> > +{
> > +     struct lt7911exc *lt7911exc =3D container_of(work, struct lt7911e=
xc, work);
> > +     struct device *dev =3D lt7911exc->dev;
> > +     const struct firmware *fw;
> > +     u8 *buffer;
> > +     size_t total_size =3D FW_SIZE - 4;
> > +     u32 crc32, version;
> > +     int ret;
> > +
> > +     mutex_lock(&lt7911exc->upgrade_lock);
> > +     if (lt7911exc->removed)
>
> [Severity: Low]
> Should this read of the removed flag be protected by the ocm_lock? It
> appears this can be evaluated concurrently with driver removal since the
> lock isn't held here.
>

Valid point. Will fix by protecting the initial removed check with ocm_lock=
:
mutex_lock(&lt7911exc->upgrade_lock);
scoped_guard(mutex, &lt7911exc->ocm_lock) {
      if (lt7911exc->removed)
          goto out_unlock_upgrade;
}

> > +             goto out_unlock_upgrade;
> > +
>
> [ ... ]
>
> > +out_unlock_upgrade:
> > +     scoped_guard(mutex, &lt7911exc->ocm_lock) {
> > +             if (!lt7911exc->removed)
> > +                     lt7911exc->upgrade =3D false;
> > +     }
> > +
> > +     /* Notify DRM to re-trigger modeset after firmware upgrade */
> > +     if (!lt7911exc->removed && lt7911exc->bridge.dev)
> > +             drm_kms_helper_hotplug_event(lt7911exc->bridge.dev);
>
> [Severity: High]
> Could this dereference a freed drm_device if the upstream DRM display
> controller unbinds before the firmware upgrade completes?
>
> The I2C device has a lifecycle independent of the DRM display controller.
> If the upstream DRM driver is unloaded, the drm_device is destroyed, but
> the I2C device remains, leaving bridge.dev populated but dangling.
>
> If a sysfs write triggers this asynchronous workqueue in that window,
> it looks like it will pass a freed pointer to drm_kms_helper_hotplug_even=
t().
>
This is a known limitation of the DRM bridge framework, not specific
to this driver. drm_bridge_remove() does not clear bridge.dev, and
there is no mechanism to bind the bridge lifecycle to the drm_device
lifecycle. All bridge drivers that call drm_kms_helper_hotplug_event()
share this risk. A proper fix requires framework-level support for
bridge-to-drm_device lifetime tracking. Additionally, this scenario
requires root sysfs access to trigger firmware upgrade while
simultaneously unloading the DRM driver, which is an administrator
operation outside normal usage.

> > +
> > +     mutex_unlock(&lt7911exc->upgrade_lock);
> > +}
>
> [ ... ]
>
> > +static int lt7911exc_dsi_host_attach(struct mipi_dsi_host *host, struc=
t mipi_dsi_device *dev)
> > +{
> > +     struct lt7911exc *lt7911exc =3D dsi_host_to_lt7911exc(host);
> > +     struct drm_bridge *bridge;
> > +
> > +     /* currently do not support connecting several DSI devices to the=
 same host */
> > +     if (lt7911exc->output_bridge)
> > +             return -EBUSY;
> > +
> > +     if (dev->lanes > 4) {
> > +             dev_err(lt7911exc->dev, "unsupported number of data lanes=
(%u)\n", dev->lanes);
> > +             return -EINVAL;
> > +     }
> > +
> > +     bridge =3D devm_drm_of_get_bridge(lt7911exc->dev, host->dev->of_n=
ode, 1, 0);
>
> [Severity: High]
> Is it safe to dynamically allocate devm memory during panel attach?
>
> If the downstream panel driver is repeatedly unbound and rebound by a
> local administrator, this will repeatedly allocate devres memory without
> freeing it, causing a memory leak.
>
This is a false positive. The -EBUSY guard at the top of
lt7911exc_dsi_host_attach() prevents re-attach when output_bridge is
already set. After the first successful attach, any panel rebind
attempt is rejected before reaching devm_drm_of_get_bridge() or
drm_bridge_add(), so no devres leak or list corruption can occur. This
follows the same pattern used in cdns-dsi-core.c (cdns_dsi_attach,
line 1052).

> > +     if (IS_ERR(bridge)) {
> > +             dev_err(lt7911exc->dev, "failed to add DSI device\n");
> > +             return PTR_ERR(bridge);
> > +     }
> > +
> > +     lt7911exc->output_bridge =3D bridge;
> > +
> > +     /*
> > +      * Force panel-first enable order: the DSI output stream (0xe0b0)
> > +      * must not be enabled before the panel is powered on.
> > +      * This override is safe because LT7911EXC's transfer() is a stub=
 =E2=80=94
> > +      * panel DCS commands are silently discarded and panel init is do=
ne
> > +      * by the chip's internal firmware. The panel driver's
> > +      * prepare_prev_first preference is therefore irrelevant here.
> > +      */
> > +     lt7911exc->output_bridge->pre_enable_prev_first =3D false;
>
> [Severity: Low]
> Is it acceptable to modify the state of a downstream bridge object
> that is owned and managed by another driver? Doing so bypasses the
> subsystem API layering.
>

This override is a hardware constraint. The DSI output stream
(register 0xe0b0) must be enabled after the panel is powered on. The
override is safe because transfer() is a stub =E2=80=94 panel DCS commands =
are
silently discarded and panel initialization is handled entirely by the
chip's internal firmware. The panel driver's prepare_prev_first
preference is therefore irrelevant for this chip. The comment above
the assignment documents this rationale.

> > +
> > +     drm_bridge_add(&lt7911exc->bridge);
>
> [Severity: High]
> Does this corrupt the global bridge list if the panel driver is rebound?
>
> When the downstream panel unbinds, lt7911exc_dsi_host_detach() calls
> drm_bridge_remove(), which moves the bridge to the bridge_lingering_list
> and destroys its mutexes.
>
> If the panel binds again, this drm_bridge_add() will be called on the sam=
e
> bridge structure, invoking list_add_tail() on a node that is already trac=
ked
> in the lingering list.
>

This is a false positive. The -EBUSY guard at the top of
lt7911exc_dsi_host_attach() prevents re-attach when output_bridge is
already set. After the first successful attach, any panel rebind
attempt is rejected before reaching devm_drm_of_get_bridge() or
drm_bridge_add(), so no devres leak or list corruption can occur. This
follows the same pattern used in cdns-dsi-core.c (cdns_dsi_attach,
line 1052).

> > +
> > +     return 0;
> > +}
> > +
> > +static int lt7911exc_dsi_host_detach(struct mipi_dsi_host *host, struc=
t mipi_dsi_device *dev)
> > +{
> > +     struct lt7911exc *lt7911exc =3D dsi_host_to_lt7911exc(host);
> > +
> > +     drm_bridge_remove(&lt7911exc->bridge);
>
> [Severity: Medium]
> Does this prevent the panel from re-attaching later?
>
> The detach function does not set lt7911exc->output_bridge back to NULL.
> If the downstream panel driver tries to attach again,
> lt7911exc_dsi_host_attach() will check if output_bridge is set and return
> -EBUSY, leaving the display pipeline permanently broken until the bridge
> driver is reloaded.
>
This is intentional and consistent with cdns-dsi-core.c, where
cdns_dsi_detach() (line 1082-1091) does not clear output->dev either.
Clearing output_bridge would allow re-attach, which would call
devm_drm_of_get_bridge() again and leak the previous devm allocation.
The DRM bridge framework does not currently support dynamic
reconfiguration of the bridge chain. Panel rebind is not supported;
reloading the bridge driver is required, matching the upstream
convention.

> > +
> > +     return 0;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714105828.27=
63677-1-syyang@lontium.com?part=3D2
