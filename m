Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5DEC531D0
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 01:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B8E10E4DC;
	Tue, 28 Jul 2026 01:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="oIazvP6v";
	dkim-atps=neutral
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com
 [115.124.28.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8520610E4DC
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 01:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1785203787; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=btoJiOPsUVfo47Moa2+oUkXjgzA7cBay9j867/GfjAM=;
 b=oIazvP6vrdWjbOcvZQyVCAD2ODU9SaafIocNOtgigECP977UrOjoEScj9L9iG8dDDAQWTL1wATM8xpag4jvWrs2FWJgS7hWOjOxyJmTzWMc+vm8My3kZg/eL/55qpKFPC17EDJfvn5BBKstKtLEnRr8qCZkDC/2i18e9bnIthcIa1Sohb8uDiTGqJmFCbi+Nu3e6qfO/XWMUU8uETb6AlG1oEUNpLPzmM8lErJHh/jL3O4FeRKu4MTcKCry6oliFu3R9RipmzyA9EycF1MfFLMvRtsJWahVBSnxviOVFyuQK41kdJd11TWfxAwuIwhpVCpNbYqMYMzhIOXd4zBK4dQ==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00519428-0.000164768-0.994641;
 FP=7600231310795989564|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037022039;
 MF=syyang@lontium.com; NM=1; PH=DS; RN=1; RT=1; SR=0;
 TI=SMTPD_---.iWtrsdU_1785203785; 
Received: from mail-oa1-f42.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.iWtrsdU_1785203785 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 28 Jul 2026 09:56:26 +0800
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-44cedfaab6bso1234689fac.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:56:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpK4xzLHFAu4GbSXWPS+bKPllFFeza97gTVrkWSwRDjqD6bSDRfO2st0r/UjiaNkzRsjSaTAo9YUWg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoTTYYdml/DwjQ+oRnpPAu8Ti0wmE56PdzDQAdP8Kz1XnmdshJ
 YroVQkUMCUMlqYdR4Ji0M0avEbhLaRSzkf+PU5hBw0nX5s80Y4vOjT9iliw6e3hzilkdCJkn9/d
 Wqa9LoCJqlsaW2UVOpx8NT6PHMW9AeSA=
X-Received: by 2002:a05:6808:bc7:b0:4a4:c608:508e with SMTP id
 5614622812f47-4ad5bb7e10amr310540b6e.33.1785203783225; Mon, 27 Jul 2026
 18:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260715015438.2770155-1-syyang@lontium.com>
 <tfkg2cjn4uznzy57rpkqwan26sduqzptnb7uwsucfboz37wz7k@rukuu36mozif>
In-Reply-To: <tfkg2cjn4uznzy57rpkqwan26sduqzptnb7uwsucfboz37wz7k@rukuu36mozif>
From: Sunyun Yang <syyang@lontium.com>
Date: Tue, 28 Jul 2026 09:56:11 +0800
X-Gmail-Original-Message-ID: <CAFQXuNazLnXOr+qRug4De8W3U932aG9LVRVWgkHAE=ALSQ+ZGA@mail.gmail.com>
X-Gm-Features: AUfX_mwXF6Wl4DcHRu_-nHExxGI0ohrKy6ryHOen7Lny0Cvjy6-McAcxCqeEqfY
Message-ID: <CAFQXuNazLnXOr+qRug4De8W3U932aG9LVRVWgkHAE=ALSQ+ZGA@mail.gmail.com>
Subject: Re: [PATCH v17 0/2] Add Lontium LT7911EXC eDP to MIPI DSI bridge
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
7=E6=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C 09:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jul 15, 2026 at 09:54:36AM +0800, syyang@lontium.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > The LT7911EXC is an I2C-controlled bridge that receives eDP1.4
> > and output mipi dsi. This series introduces:
> >
> > - A device tree binding YAML file describing the hardware
> > - A new DRM bridge driver implementing the basic functionality
> >
> > Signed-off-by: Sunyun Yang<syyang@lontium.com>
> > ---
> > Change in v17:
> > - dt-binding:
> > - drm/bridge:
> >  1. [High] devm leak and list corruption on panel rebind               =
                                   [sashiko-bot]
> >            False positive. The -EBUSY guard at the top of host_attach()=
 (line 527) rejects re-attach
> >            when output_bridge is already set, so neither devm_drm_of_ge=
t_bridge() nor drm_bridge_add()
> >            is reached on panel rebind.
>
> This is not a changelog. Don't mix replies, with the changes in the
> patches.
>
In the driver code, when I reply to the issues raised by the AI bot,
the AI bot does not respond to me.
In subsequent submissions, can I simply not reply to the AI bot's
questions and only modify the issues that are useful for the driver?

> >  2. [High] Dangling bridge.dev pointer                                 =
                                    [sashiko-bot]
> >            DRM bridge framework limitation. drm_bridge_remove() does no=
t clear bridge.dev. All bridge
> >            drivers using drm_kms_helper_hotplug_event() share this risk=
. Requires framework-level fix.
> >            Triggering needs root sysfs access plus DRM driver unload si=
multaneously.
> >  3. [Medium] output_bridge not cleared prevents re-attach              =
                                     [sashiko-bot]
> >            Intentional. Same as cdns-dsi-core.c cdns_dsi_detach(). Clea=
ring would
> >            cause devm_drm_of_get_bridge() to leak on re-attach. DRM bri=
dge framework does not support
> >            dynamic chain reconfiguration. Panel rebind requires host dr=
iver reload.
> >  4. [Low] Mutating downstream bridge's pre_enable_prev_first           =
                                     [sashiko-bot]
> >           Hardware constraint. DSI stream (0xe0b0) must be enabled afte=
r panel power-on. Safe because
> >           transfer() is a stub =E2=80=94 DCS commands are discarded, pa=
nel init is done by chip firmware.
> >           Comment documents the rationale.
> >  5. [Low] Unsynchronized removed read                                  =
                                  [sashiko-bot]
> >           Fixed. Now protected by ocm_lock (lines 372-375).
> > - Link to v16: https://lore.kernel.org/all/20260714105828.2763677-1-syy=
ang@lontium.com/
> >
> > Change in v16:
> > - dt-binding:
> >  1. [Low] Use standard generic DT node name
> >           Renamed mipi-bridge@41 to bridge@41 per Devicetree spec for s=
tandard generic names.                 [sashiko-bot]
> > - drm/bridge:
> >  1. [High] Prevent devm_drm_of_get_bridge() devres leak in host_attach
> >            Added -EBUSY guard to reject re-attach, preventing devm memo=
ry leak and use-after-free on          [sashiko-bot]
> >            panel unbind/rebind.
> >  2. [High] Fix double drm_bridge_remove() in lt7911exc_remove()        =
                                       [sashiko-bot]
> >            Removed the flawed list_empty() check that caused a second d=
rm_bridge_remove() call,
> >            leading to double mutex_destroy() and use-after-free.
> >  3. [High] Clear upgrade flag before hotplug event                     =
                                       [sashiko-bot]
> >            Reordered to clear upgrade =3D false before drm_kms_helper_h=
otplug_event(), preventing modesets from
> >            silently skipping hardware enable (0xe0b0) and causing black=
 screen.
> >  4. [Medium] Document pre_enable_prev_first override                   =
                                        [sashiko-bot]
> >              Added comment explaining the hardware constraint: DSI stre=
am must be enabled after panel power-on.
> >              The override is safe because transfer() is a stub =E2=80=
=94 DCS commands are discarded and panel init is
> >              handled by chip firmware.
> >  5. [Medium] Guard hotplug with removed flag                           =
                                         [sashiko-bot]
> >              Added !lt7911exc->removed check to prevent hotplug events =
during device removal.
> >  6. [High] Use local variable for error handling                       =
                                         [sashiko-bot]
> >            Introduced local bridge variable for IS_ERR()/PTR_ERR() chec=
ks, ensuring output_bridge stays NULL on
> >            failure so -EPROBE_DEFER retries are not blocked by the -EBU=
SY guard.
> > - Link to v15: https://lore.kernel.org/all/20260714064822.2753289-1-syy=
ang@lontium.com/
> >
> > Change in v15:
> > - dt-binding:
> > - drm/bridge:
> >  1. Remove the Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qual=
comm.com> tag.
> >  2. Adjust the design architecture of the chip's MIPI host and bridge.
> >  3. remove devm_drm_panel_bridge_add_typed and drm_of_find_panel_or_bri=
dge
> >  4. Use REGCACHE_NONE to avoid cache inconsistency due to internal MCU =
modifying registers asynchronously
> > - Link to v14: https://lore.kernel.org/all/20260529112928.873766-1-syya=
ng@lontium.com/
> >
> > Change in v14:
> > - dt-binding:
> > - drm/bridge:
> >  1. [High] AB-BA / self-deadlock between the bridge's ocm_lock and DRM =
modeset                             [sashiko-bot]
> >     locks during hotplug notification. - fixed
> >  2. [High] Freeing the panel bridge in lt7911exc_dsi_host_detach while =
it is still
> >     attached to the DRM bridge chain causes a Use-After-Free. - fixed
> > - Link to v13: https://lore.kernel.org/lkml/20260529094547.869919-1-syy=
ang@lontium.com/
> >
> > Change in v13:
> > - dt-binding:
> > - drm/bridge:
> >  1. [High] Dangling pointer created during MIPI DSI host detach if the =
downstream                           [sashiko-bot]
> >            device is a bridge rather than a panel. - fixed
> >  2. [High] Firmware upgrade CRC mismatch due to unpadded partial page w=
rites.
> >            - hardware erases the entire flash area into a default state=
 of 0xff. When doing
> >              a partial page short write=EF=BC=8Cthe total unwritten res=
idual bytes on the physical
> >              flash sector inherently retain their 0xff state. Therefore=
, no modification is required.
> >  3. [High] Firmware upgrade workqueue accesses `bridge.dev` without ens=
uring the DRM device is alive,
> >            leading to a Use-After-Free. - fixed
> >  4. [High] Regmap page selector cache desynchronization after device re=
set causes firmware upgrade
> >            commands to be routed to the wrong register page. - fixed
> > - Link to v12: https://lore.kernel.org/lkml/20260525010545.9470-1-syyan=
g@lontium.com/
> >
> > Change in v12:
> > - dt-binding:
> > - drm/bridge:
> >  1. Move the cleanup work of drm_panel_bridge_remove() forward into lt7=
911exc_dsi_host_detach().                        [sashiko-bot]
> >  2. Do not hold any lock during lt7911exc_reset().
> > - Link to v11: https://lore.kernel.org/lkml/20260522015735.2833-1-syyan=
g@lontium.com/
> >
> > Change in v11:
> > - dt-binding:
> > - drm/bridge:
> >  1. Removed Reviewed-by, we would appreciate it if the maintainer could=
 help review this.
> >  2. Use devm_gpiod_get(,, GPIOD_OUT_HIGH) to fix the reset GPIO backpow=
ering issue.                                       [sashiko-bot]
> >  3. Fixed Use-After-Free vulnerability due to dynamic DRM bridge remova=
l in DSI detach callback.
> >  4. Fixed Use-After-Free of regmap during DRM teardown because firmware=
 upgrade worker defeats removal safeguard.
> >  5. Fixed firmware upgrade performs a hardware reset, causing silent lo=
ss of DRM state and a blank screen.
> >  6. Use of kmalloc for a 64KB software buffer is susceptible to memory =
fragmentation failures - Fix by using kvmalloc
> >  7. Use the 'lt7911exc->ocm_lock' mutex and the 'lt7911exc->upgrade' fl=
ag to resolve the race condition between
> >     DRM atomic modeset and firmware upgrade.
> >  8. Use the 'lt7911exc->upgrade_lock' mutex to prevent redundant upgrad=
es.
> >  9. Use the 'lt7911exc->removed' flag to prevent the driver from being =
triggered to upgrade during the unload process.
> > - Link to v10: https://lore.kernel.org/lkml/20260519135816.26996-1-syya=
ng@lontium.com/
> >
> > Change in v10:
> > - dt-binding:
> > - drm/bridge:
> >  1. Fixed the firmware upgrade error paths to always clear the upgrade
> >     flag before returning, including firmware size validation failures
> >     and allocation failures.                                           =
                     [sashiko-bot]
> >  2. Added proper locking in lt7911exc_atomic_pre_enable() and
> >     lt7911exc_atomic_post_disable() to serialize register accesses with=
 the
> >     firmware upgrade flow and avoid concurrent I2C transactions.
> >  3. Added an exclusivity check in lt7911exc_dsi_host_attach() to reject=
 multiple
> >     downstream attachments and prevent repeated drm_bridge_add() calls =
and panel bridge leaks.
> >  4. Reworked lt7911exc_firmware_store() to use mutex_trylock() so concu=
rrent sysfs writers
> >     immediately return -EBUSY instead of blocking behind an active firm=
ware upgrade.
> >  5. Updated the remove path to prevent new firmware upgrade work from b=
eing queued after
> >     device removal by setting the upgrade state before cancelling the w=
orker.
> > - Link to v9: https://lore.kernel.org/lkml/20260519105019.22622-1-syyan=
g@lontium.com/
> >
> > Change in v9:
> > - dt-binding:
> > - drm/bridge:
> >  1. DSI transfer callback returns success for reads without populating =
                       [sashiko-bot]
> >     the receive buffer, leaking uninitialized memory. - fixed it by
> >     implementing  a strict whitelist mechanism.
> >  2. DSI transfer callback polls for eDP video readiness before the
> >     upstream encoder is enabled, guaranteeing a timeout. - removed
> >  3. The driver attempts I2C transfers while the hardware is held in
> >     physical reset. - fixed
> >  4. Missing DRM_MIPI_DSI Kconfig dependency causes linker errors. - fix=
ed
> >  5. request_firmware is called while holding the hardware lock and
> >     halting the MCU, risking a system pipeline stall. - fixed
> >  6. Sleeping functions are called from atomic context in the DRM bridge=
 callbacks. - fixed
> >  7. lt7911exc_dsi_host_transfer bypasses the required MCU hardware halt=
 sequence. - fixed by
> >     internal firmware controls the panel initialization sequence and ha=
ndles all MIPI
> >     DSI command transmission.
> > - Link to v8: https://lore.kernel.org/lkml/20260515080934.9870-1-syyang=
@lontium.com/
> >
> > Change in v8:
> > - dt-binding:
> > - drm/bridge:
> >  1. Protect firmware upgrade and DRM bridge callback paths with ocm_loc=
k.          [sashiko-bot]
> >  2. Remove the hardware reset from the remove callback, and ensure that
> >     all hardware reset operations are protected by ocm_lock.
> >  3. crc reconstruction explicitly casts each byte to u32 before shiftin=
g
> >  4. The display configuration is handled by the firmware, and the MIPI
> >     DSI host registration issue has been fixed.
> >  5. The batch register read/write operations have already been updated
> >     to include return value checking.
> >  6. The dev_err_probe() used outside of probe context has been fixed.
> > - Link to v7: https://lore.kernel.org/lkml/20260512064013.40066-1-syyan=
g@lontium.com/
> >
> > Change in v7:
> > - dt-binding:
> >  1. fix commit message typos(Receiver=E3=80=81signal)                  =
          [sashiko-bot]
> >  2. remove the ambiguity caused by "signal/dual".
> > - drm/bridge:
> >  1. using devm_regulator_get_enable avoids power leaks.                =
   [sashiko-bot]
> >  2. set reset gpio is low after cutting off power in lt7911exc_remove f=
unction, avoid backpowering.
> >  3. synchronous request_firmware() call cause a permanent probe failure=
 if the driver is built-in,
> >     probe executes before the root filesystem is mounted, which would c=
ause this to fail with -ENOENT,
> >     we have removed this functionality. Use trigger to upgrade.
> >  4. add `depends on I2C` and `select REGMAP_I2C` in Kconfig.
> >  5. add return value of `devm_drm_bridge_add()` in `probe()`.
> >  6. add directly header files (linux/slab.h, linux/delay.h, linux/regul=
ator/consumer.h)
> > - Link to v6: https://lore.kernel.org/lkml/20260508134702.4713-1-syyang=
@lontium.com/
> >
> > Change in v6:
> > - dt-binding:
> > - drm/bridge:
> >  1. use #define FW_FILE  "Lontium/lt7911exc_fw.bin" to match linux-firm=
ware
> > - Link to v5: https://lore.kernel.org/lkml/20260506013153.2240-1-syyang=
@lontium.com/
> >
> > Change in v5:
> > - dt-binding:
> > - drm/bridge:
> >  1. Change "mipi" to "mipi dsi" in the commit message.     [Dmitry]
> >  2. Change "eDP/MIPI" to "eDP/MIPI DSI" in Kconfig.
> > - Link to v4: https://lore.kernel.org/lkml/20260430094612.3408174-1-syy=
ang@lontium.com/
> >
> > Change in v4:
> > - dt-binding:
> >  1. Fix the missing spaces on the "subject".             [Krzysztof]
> >  2. Fix the error descriptions for port@0 and port@1.
> > - drm/bridge:
> > - Link to v3: https://lore.kernel.org/lkml/20260429040541.3404116-1-syy=
ang@lontium.com/
> >
> > Change in v3:
> > - dt-binding:
> > - drm/bridge:
> >  1. already submit lt7911exc_fw.bin to linux-firmware.  [Dmitry]
> >  2. remove lt7911exc_remove function.
> >  3. drop  the "lontium, "  in lt7911exc_i2c_table.
> > - Link to v2: https://lore.kernel.org/lkml/20260428063224.3316655-1-syy=
ang@lontium.com/
> >
> > Change in v2:
> > - dt-binding:
> >  1. reset pins use active low.                        [Dmitry]
> > - drm/bridge:
> >  1. use atomic_* callbacks.                           [Quentin]
> >  2. fix the incorrect formatting and spaces.
> >  3. add the required header files.                    [Dmitry]
> >  4. remove "enabled" flag.
> >  5. remove *fw from the lt7911exc struct.
> >  6. .max_register and .range_max use actual range.
> >  7. regulator use bulk interface.
> >  8. use dev_err_probe, devm_mutex_init and devm_drm_bridge_add.
> >  9. Replace GPL v2 with GPL.
> > - Link to v1: https://lore.kernel.org/lkml/20260420023354.1192642-1-syy=
ang@lontium.com/
> >
> > ---
> > Sunyun Yang (2):
> >   dt-bindings: bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge
> >   drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge
> >
> >  .../display/bridge/lontium,lt7911exc.yaml     |  89 ++
> >  drivers/gpu/drm/bridge/Kconfig                |  17 +
> >  drivers/gpu/drm/bridge/Makefile               |   1 +
> >  drivers/gpu/drm/bridge/lontium-lt7911exc.c    | 787 ++++++++++++++++++
> >  4 files changed, 894 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/lo=
ntium,lt7911exc.yaml
> >  create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry
