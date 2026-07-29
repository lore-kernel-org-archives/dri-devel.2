Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746FFC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18F410E642;
	Wed, 29 Jul 2026 03:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="L+dC/3mT";
	dkim-atps=neutral
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com
 [115.124.28.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E572F10E367
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1785296101; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=k7VwVkAKQFvSFkLIdRRiaolxBH7EiBeMHwqNFyEaDy4=;
 b=L+dC/3mTU9wCNgR7lffXBKYiJ+hkAL60F/NZHMXRyxqOdKblSDYymyMmMFLfTqPPNAoLnfq3CMp9APCByzo/ES0q1jHwpcaixtVUjQuC5hy4MAc5ah9Htj7BhP6+QYvdngb580CWuGZXTDsKi9WjWOd+h7iBRkqoyewU2Q+H1Ou2TZ4ud5LPE1QIpsjKmjeBuo9dfEsYCoH5ZNFHgx9q6PlfSSjYTHoUKm9y4xaf32iKUmMzvUbkdfkNEyuXw4cFI+1KHUd4wPYumnQiclTKla2s6pqF4H4P9uBBNWlk5cTPZ5p6cDRSIpazARA0eLeZT6Fa4Xs5u2yYgk06Czb1EA==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.123664-0.000959467-0.875377;
 FP=18352584145431578136|1|1|2|0|-1|-1|-1;
 HT=maildocker-contentspam033037028158; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.iY2EGRT_1785296099; 
Received: from mail-oa1-f53.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.iY2EGRT_1785296099 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 29 Jul 2026 11:35:00 +0800
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-44cb057311bso254302fac.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 20:35:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1pyGe24unZc7/29XFDQqe1ZTL5bq8PCq31vcwmuWbxS4gerTAcdxBEdlBIgT4VebM7wW49DDitRs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxoh4//GG4NPFlrEwVV6T+L052rlsdFlSSzmamTBzaTSr5IS0O6
 LXzVobTjD2GmDHnaQ4bavXzgLwTK+ON0ahrUd+I5buLibPNogfe9yh7gRPCFEGL2KG0yL0W1IXK
 1cWga6D7QSXpXTG9+sGQcqmO0Tyf6Y+k=
X-Received: by 2002:a05:6808:3197:b0:4a3:cf5a:d18c with SMTP id
 5614622812f47-4ad5bc0b463mr3143906b6e.33.1785296098753; Tue, 28 Jul 2026
 20:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260715015438.2770155-1-syyang@lontium.com>
 <20260715015438.2770155-3-syyang@lontium.com>
 <b57ijnpvbayerjqcv5lfoawgtmuahnhhupfso6bxa5in3j6efq@cq3sgg7yv3bh>
In-Reply-To: <b57ijnpvbayerjqcv5lfoawgtmuahnhhupfso6bxa5in3j6efq@cq3sgg7yv3bh>
From: Sunyun Yang <syyang@lontium.com>
Date: Wed, 29 Jul 2026 11:34:45 +0800
X-Gmail-Original-Message-ID: <CAFQXuNYU8WZyM7uiSwQCdLYzw1ei3vGJHiSPPvx_z0FzSLSveg@mail.gmail.com>
X-Gm-Features: AUfX_mxOLLO3F70739p0PIgycYzCDffgBtUb8MgscRkv6c-rvOa-KzqyWu7BI6I
Message-ID: <CAFQXuNYU8WZyM7uiSwQCdLYzw1ei3vGJHiSPPvx_z0FzSLSveg@mail.gmail.com>
Subject: Re: [PATCH v17 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI
 bridge
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com, rlyu@lontium.com, 
 xbpeng@lontium.com, qdchen@lontium.com, llzhang@lontium.com, 
 hfxia@lontium.com
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
7=E6=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C 17:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jul 15, 2026 at 09:54:38AM +0800, syyang@lontium.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > Add support for the Lontium LT7911EXC bridge chip, which converts
> > eDP input to MIPI DSI output using an internal firmware-controlled
> > pipeline.
> >
> > The driver provides:
> > - DRM bridge integration for eDP-to-DSI routing
> > - MIPI DSI host interface for downstream panel attachment
> > - Firmware upgrade mechanism over I2C (erase/program/verify)
> > - GPIO-based reset and regulator management
> >
> > Display timing and MIPI DCS packet generation are handled by the chip
> > firmware and are not configured by the driver.
> >
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > ---
> > +static void lt7911exc_reset(struct lt7911exc *lt7911exc)
> > +{
> > +     /* Assert reset pin: logical 1 -> physical state low (Reset Activ=
e) */
>
> Redundant comment.
>
we will remove  this comment  in next version.

> > +     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
> > +     usleep_range(5000, 6000);
> > +
> > +     /* Deassert reset pin: logical 0 -> physical state high (Run stat=
e) */
>
> This one too.
>
we will remove  this comment  in next version.

> > +     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
> > +     msleep(400);
> > +}
> > +
>
> [...]
>
> > +static void lt7911exc_firmware_upgrade_work(struct work_struct *work)
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
> > +
> > +     scoped_guard(mutex, &lt7911exc->ocm_lock) {
> > +             if (lt7911exc->removed)
> > +                     goto out_unlock_upgrade;
> > +     }
> > +
> > +     ret =3D request_firmware(&fw, FW_FILE, dev);
> > +     if (ret) {
> > +             dev_err(dev, "failed to load '%s'\n", FW_FILE);
> > +             goto out_unlock_upgrade;
> > +     }
> > +
> > +     if (fw->size > total_size) {
> > +             dev_err(dev, "firmware too large (%zu > %zu)\n", fw->size=
, total_size);
> > +             goto out_release_fw;
> > +     }
> > +
> > +     buffer =3D kvmalloc(total_size, GFP_KERNEL);
> > +     if (!buffer)
> > +             goto out_release_fw;
> > +
> > +     memset(buffer, 0xff, total_size);
> > +     memcpy(buffer, fw->data, fw->size);
>
> memcpy(buffer, fw->data, fw->size);
> memset(buffer + fw->size, 0xff, total_size - fw->size);
>
we will fix.

>
> > +     crc32 =3D cal_crc32_custom(buffer, total_size);
> > +     kvfree(buffer);
> > +
> > +     lt7911exc_reset(lt7911exc);
> > +
> > +     scoped_guard(mutex, &lt7911exc->ocm_lock) {
> > +             ret =3D lt7911exc_inside_mcu_stop(lt7911exc);
>
> Move guard() into the function.
>
we will fix.

> > +     }
> > +     if (ret)
> > +             goto out_release_fw;
> > +
> > +     ret =3D lt7911exc_block_erase(lt7911exc);
> > +     if (ret) {
> > +             dev_err(dev, "failed to block erase.\n");
> > +             goto out_mcu_run;
> > +     }
> > +
> > +     ret =3D lt7911exc_write_data(lt7911exc, fw, 0);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to write firmware data\n");
> > +             goto out_mcu_run;
> > +     }
> > +
> > +     ret =3D lt7911exc_write_crc(lt7911exc, crc32, FW_SIZE - 4);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to write firmware crc\n");
> > +             goto out_mcu_run;
> > +     }
> > +
> > +     lt7911exc_reset(lt7911exc);
> > +
> > +     ret =3D lt7911exc_upgrade_result(lt7911exc, crc32);
> > +     if (ret)
> > +             dev_err(dev, "firmware verification failed\n");
> > +
> > +     /*
> > +      * Always restore MCU to running state: flash is already erased,
> > +      * leaving MCU stopped would render the chip completely unusable.
> > +      */
> > +     scoped_guard(mutex, &lt7911exc->ocm_lock) {
> > +             ret =3D lt7911exc_inside_mcu_run(lt7911exc);
>
> Move guard() into the run function.
>
we will fix.

> > +             if (!ret) {
> > +                     ret =3D lt7911exc_read_version(lt7911exc, &versio=
n);
>
> Why is ihis being executed under the OCM lock?
>

fw_version =3D version need  OCM lock, and we will fix ocm lock code.


> > +                     if (!ret)
> > +                             lt7911exc->fw_version =3D version;
> > +             }
> > +     }
> > +
> > +     if (ret)
> > +             dev_err(dev, "failed to read version after upgrade\n");
> > +
> > +     goto out_release_fw;
> > +
> > +out_mcu_run:
> > +     scoped_guard(mutex, &lt7911exc->ocm_lock)
> > +             lt7911exc_inside_mcu_run(lt7911exc);
> > +
> > +out_release_fw:
> > +     release_firmware(fw);
>
> release_firmware() could have happened long ago, after copying the
> buffer.
>
we will fix

> > +
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
> drm_bridge_hpd_notify(), outside of the lock.
>
we will fix

> > +
> > +     mutex_unlock(&lt7911exc->upgrade_lock);
> > +}
> > +
> > +static void lt7911exc_atomic_pre_enable(struct drm_bridge *bridge, str=
uct drm_atomic_commit *state)
> > +{
> > +     struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> > +     struct device *dev =3D lt7911exc->dev;
> > +     int ret;
> > +
> > +     guard(mutex)(&lt7911exc->ocm_lock);
> > +
> > +     if (!lt7911exc->upgrade) {
>
> Why? Can't you just use a lock to prevent DRM vs firmware upgrade races.
>

The upgrade process takes about 10 seconds. Using only the OCM lock,
the AI bot believes it would block the DRM modeset path and cause
timeouts.
The upgrade flag provides a non-blocking check: DRM operations return
immediately during upgrade rather than waiting.

Our design intent is that firmware upgrades are only performed during
debugging =E2=80=94 once the firmware is working properly, upgrades won't
happen in normal operation.
I believe the AI bot's concern can be ignored. I would like to use a
single OCM lock to reduce driver complexity. Dmitry, do you think
using a single OCM lock is acceptable?


> > +             ret =3D regmap_write(lt7911exc->regmap, 0xe0b0, 0x01);
>
> What will enable the output if bridge was upgrading during
> atomic_pre_enable?

The output is not enabled during upgrade. atomic_pre_enable returns
early when upgrade=3Dtrue. After upgrade completes,
upgrade=3Dfalse and calls drm_bridge_hpd_notify() to trigger a new
modeset, which re-enters atomic_pre_enable and writes 0xe0b0 to enable
the output.


>
> > +             if (ret)
> > +                     dev_err(dev, "failed to enable mipi output stream=
\n");
> > +     }
> > +}
> > +
> > +static void lt7911exc_atomic_post_disable(struct drm_bridge *bridge,
> > +                                       struct drm_atomic_commit *state=
)
> > +{
> > +     struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> > +     struct device *dev =3D lt7911exc->dev;
> > +     int ret;
> > +
> > +     guard(mutex)(&lt7911exc->ocm_lock);
> > +
> > +     if (!lt7911exc->upgrade) {
> > +             ret =3D regmap_write(lt7911exc->regmap, 0xe0b0, 0x00);
> > +             if (ret)
> > +                     dev_err(dev, "failed to disable mipi output strea=
m\n");
> > +     }
> > +}
> > +
> > +static int lt7911exc_bridge_attach(struct drm_bridge *bridge,
> > +                                struct drm_encoder *encoder,
> > +                                enum drm_bridge_attach_flags flags)
> > +{
> > +     struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> > +
> > +     if (!drm_core_check_feature(bridge->dev, DRIVER_ATOMIC)) {
> > +             dev_err(lt7911exc->dev, "needs atomic updates support\n")=
;
> > +             return -ENOTSUPP;
> > +     }
>
> I'd say, it's redundant.
>
 we will fix.

> > +
> > +     return drm_bridge_attach(encoder, lt7911exc->output_bridge, bridg=
e, flags);
> > +}
> > +
> > +static const struct drm_bridge_funcs lt7911exc_bridge_funcs =3D {
> > +     .attach =3D lt7911exc_bridge_attach,
> > +     .atomic_pre_enable =3D lt7911exc_atomic_pre_enable,
> > +     .atomic_post_disable =3D lt7911exc_atomic_post_disable,
> > +     .atomic_reset =3D drm_atomic_helper_bridge_reset,
> > +     .atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_st=
ate,
> > +     .atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> > +};
> > +
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
> > +     if (IS_ERR(bridge)) {
> > +             dev_err(lt7911exc->dev, "failed to add DSI device\n");
> > +             return PTR_ERR(bridge);
> > +     }
> > +
> > +     lt7911exc->output_bridge =3D bridge;
>
> Follow what other drivers are doing. Please store the next bridge in
> drm_bridge::next_bridge. It saves you from manual handling of its
> refcounts.
>

we will fix

> > +
> > +     /*
> > +      * Force panel-first enable order: the DSI output stream (0xe0b0)
> > +      * must not be enabled before the panel is powered on.
> > +      * This override is safe because LT7911EXC's transfer() is a stub=
 =E2=80=94
> > +      * panel DCS commands are silently discarded and panel init is do=
ne
>
> Is it a hardware limitation or something which is not yet implemented in
> the driver?
>
This is a hardware limitation. The LT7911EXC contains an internal MCU
that runs its own firmware, which is responsible for all panel
initialization sequences. The DSI link is owned and managed by the
chip's internal firmware. Linux-side DCS commands cannot be forwarded
to the actual DSI bus =E2=80=94 the transfer() callback accepts the message
and reports success solely to prevent the panel driver from aborting
its init sequence. Actual panel initialization is performed entirely
by the chip's internal firmware after the chip comes out of reset.



> > +      * by the chip's internal firmware. The panel driver's
> > +      * prepare_prev_first preference is therefore irrelevant here.
> > +      */
>
> Do you have an actual issue with one of the panels? The overall logic
> should be to let the panels decide whether it needs to setup anything
> before the DSI output stream comes up. If there are any issues, they
> should be fixed on the DSI host side.
>

Thank you for the suggestion. We will move the DSI output stream
enable from atomic_pre_enable to atomic_enable. Since atomic_enable is
called after all pre_enable callbacks complete (regardless of
pre_enable_prev_first), the panel is guaranteed to be ready before the
DSI output stream is enabled. The pre_enable_prev_first override will
be removed, and the panel's ordering preference will be fully
respected.

> > +     lt7911exc->output_bridge->pre_enable_prev_first =3D false;
> > +
> > +     drm_bridge_add(&lt7911exc->bridge);
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
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * LT7911EXC's internal MCU owns the DSI link and handles all panel
> > + * initialization. The host transfer() is a no-op sink: accept the
>
> How does it know panel init commands? What about the panels which use
> DCS commands to setup brightness?
>

The panel initialization commands need to be embedded into the
firmware code. When register 0xe0b0 is written with 0x01, the firmware
outputs the MIPI DSI initialization commands. =E2=80=94 (hardware limitatio=
n)

The brightness information is incorporated into the firmware code
according to the defined convention. The chip provides registers to
control brightness using the agreed-upon brightness values.



> > + * message and report it as sent so the panel driver does not abort
> > + * its init sequence. Actual DSI transmission is done by chip firmware=
.
> > + */
> > +static ssize_t lt7911exc_dsi_host_transfer(struct mipi_dsi_host *host,
> > +                                        const struct mipi_dsi_msg *msg=
)
> > +{
> > +     struct lt7911exc *lt7911exc =3D dsi_host_to_lt7911exc(host);
> > +
> > +     if (msg->rx_len) {
> > +             dev_warn(lt7911exc->dev, "MIPI rx is not supported\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     switch (msg->type) {
> > +     case MIPI_DSI_DCS_SHORT_WRITE:
> > +     case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
> > +     case MIPI_DSI_DCS_LONG_WRITE:
> > +     case MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM:
> > +     case MIPI_DSI_GENERIC_SHORT_WRITE_1_PARAM:
> > +     case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
> > +     case MIPI_DSI_GENERIC_LONG_WRITE:
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     guard(mutex)(&lt7911exc->ocm_lock);
> > +
> > +     if (lt7911exc->upgrade)
> > +             return -EBUSY;
> > +
> > +     return msg->tx_len;
> > +}
> > +
> > +static const struct mipi_dsi_host_ops lt7911exc_dsi_host_ops =3D {
> > +     .attach =3D lt7911exc_dsi_host_attach,
> > +     .detach =3D lt7911exc_dsi_host_detach,
> > +     .transfer =3D lt7911exc_dsi_host_transfer,
> > +};
> > +
>
> --
> With best wishes
> Dmitry
