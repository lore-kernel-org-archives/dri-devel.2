Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABC1C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 22:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88ADE10F3DC;
	Fri, 21 Aug 2026 22:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PYcVTqkY";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA8F10F3DC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 22:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787350806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sh8cznjpIKBPy7dvZww9ExyDi5jyouvOeWvCBgqYb0A=;
 b=PYcVTqkYSeoiAhBkYcIq4I8EPB6KGUY28+sQ6vMDmbjOxDO3QOiNOSsJp01p0FoH7dfFT5
 dAXdFhKbbmELBNXTGEaSg1XhhqM+OSqjwSXkKybHpEdUgqZf40wpV5SOnQqgijh+cGxZQ+
 P3y+DZXdAkkRpigud+r3mLeBU/4Y1AU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-bxcPhXH6PKOkrdkuqVAUNw-1; Fri, 21 Aug 2026 18:19:50 -0400
X-MC-Unique: bxcPhXH6PKOkrdkuqVAUNw-1
X-Mimecast-MFC-AGG-ID: bxcPhXH6PKOkrdkuqVAUNw_1787350789
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90c914d88c6so955436d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787350789; x=1787955589;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DQkr9w10nlQ8gm/DKrubBOOVTdxyxtdDUmfOTZG3zRo=;
 b=Dp9jQWqrqJKgMxLYYoyyfX8uAJt0YxKgqTwuDneKBY138SFUM/uaZ9FwXD664fTirL
 HPdBk+emRUA4xTGWi32NpwGnLB9hOhq9x/jDxRia8DdWBzyG0MYOK3t1Yp69K4NRS89J
 53npa4FOvEX4tjipz7ZdWfdHLGhmVydzH+7LOJgSBVSSEF9XwwXFyb1nzMsP2yZaJ9ZI
 pekhaHkXsyDamiCDB2xJmRfs+MeCxF2sQmL7/IdYJKcZJ9HujwqDowA7GeTVkDM6uaF3
 EY34gcAxHckU/25FwG9jSBoD+JhHm6CrzHqqd1gViL5+NKd5gftxPGgr3rqR8Ry1lkDf
 UhQQ==
X-Gm-Message-State: AFuF++lF0sEb7zRyIGwagWJjycdLtfmtl6IC4a423lhCfXQot5fKd53q
 s51V5QOdTOR7tsXpWouyt2Ht9upwlFfvLYXAIbFujMGK8bwoASe2vUXxHRtu2PrKQMLEmhOeZlT
 ZWe7s+NQygWhlA8tzrtEG+YZgmPDh+WO3z4VuWrOKjYIbX7bvo93GXAGu6HQP5aCFr4jYYQ==
X-Gm-Gg: AR+sD10IrurrBUqTzdAFxTgL1W8sSBrTew2k5ggQWLlycDXEd/pF1NKlxuHBtf2lvnL
 4GZbFkX0tOo35AIXp0ZcOMjRF5hgjPO0F/K6kgvnZB5lNt35Mc9Qc35a8S9X3sL6s4cZZo6qwnm
 XFt/658QfblUk/xcIo0CtvIrDdPIsK08uaT2+Kw3fnNh1OtZWSgjQvyNvJa4quH/7bFcV/DLvfz
 cF00e6dZRdq8YLOQmwJEnd60aGgjDfr4PDzNHBizdw2YO6+GSNwEMnh8aPOm6Qn3aTCAG026zL8
 VLwpGB+yKRN3FOyYPgJ+s5PnHLWPS8tzCcpH4+3ZUM1tmmXFLmP6GYaicrR1dbg+HMipaKJY
X-Received: by 2002:a05:6214:21e6:b0:908:488b:14f with SMTP id
 6a1803df08f44-90c6ab306bbmr157986756d6.5.1787350789141; 
 Fri, 21 Aug 2026 15:19:49 -0700 (PDT)
X-Received: by 2002:a05:6214:21e6:b0:908:488b:14f with SMTP id
 6a1803df08f44-90c6ab306bbmr157986286d6.5.1787350788559; 
 Fri, 21 Aug 2026 15:19:48 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2b2b38sm72754756d6.43.2026.08.21.15.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 15:19:47 -0700 (PDT)
Message-ID: <95f6f723028a7b402dfa5ba62672a5c18be3521a.camel@redhat.com>
Subject: Re: [PATCH v2 10/10] drm/nouveau: honor HF-EEODB EDIDs by
 converting to struct drm_edid
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Fri, 21 Aug 2026 18:19:46 -0400
In-Reply-To: <20260820164929.17117-11-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-11-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4j4AR0uhl7puC77izpyIxdtqtDaigxdo4NkY-kbyzzo_1787350789
X-Mimecast-Originator: redhat.com
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2026-08-20 at 20:49 +0400, Mohamed Ahmed wrote:
> HDMI 2.1 sinks ship HF-EEODB EDIDs. Byte 126 deliberately claims one
> extension block for legacy sources, and the true count lives in the
> CTA
> block's first data block. Their high-refresh timings sit in DisplayID
> extension blocks 2+.
>=20
> The kernel already reads these EDIDs whole, and on GSP boards RM
> returns
> the full EDID with its true size. However, nouveau then hands the
> buffer
> to the legacy API which sizes the EDID from byte 126 so the DisplayID
> blocks are not parsed/exposed and the sysfs blob truncates to 256
> bytes.
> The mode list then tops out at the CTA VICs.
>=20
> Convert to the struct drm_edid API, which carries the real size.
> Read via drm_edid_read_ddc()/drm_edid_read_switcheroo() where an
> adapter exists, and serve RM's buffer through drm_edid_read_custom()
> with a block-reading callback where not, which also routes the GSP
> path through drm's block validation and the debugfs EDID override.
>=20
> A failed RM read now takes the same "no EDID" path as an empty DDC
> read
> which stops it from leaking the runtime-PM reference detect() holds.
> The
> property, display_info, and mode list go through
> drm_edid_connector_update()/_add_modes() and every EDID source is
> funneled through nouveau_connector_set_edid() so all of them reach
> the
> property that drm_edid_connector_add_modes() reads from.
>=20
> nouveau_acpi_edid() now returns a drm_edid sized from the EDID's
> extension count but never past the length _DDC actually returned, so
> padded buffers pass and truncated ones are rejected, and every
> firmware-provided EDID (OF, ACPI, VBIOS-embedded) is validated with
> drm_edid_valid(). An invalid one is treated as no EDID. get_modes()
> re-syncs the property from the connector's copy when the probe helper
> has cleared it for a forced-off connector, before adding modes.
>=20
> The few raw EDID readers are converted along with it, so no raw
> struct
> edid pointer is kept. Ownership and freeing move to the drm_edid. MST
> connectors keep their separate legacy path.
>=20
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/dispnv04/dfp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 5 +-
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/disp.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 4 +-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 21 ++-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 10 +-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.c | 147 +++++++++++++++--=
-
> --
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.h |=C2=A0 12 +-
> =C2=A06 files changed, 151 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/dfp.c
> b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
> index c9f96ec8455d..00eb2aacbe93 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/dfp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
> @@ -344,9 +344,8 @@ static void nv04_dfp_mode_set(struct drm_encoder
> *encoder,
> =C2=A0=09=09regp->fp_control |=3D (2 << 24);
> =C2=A0=09if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_LVDS) {
> =C2=A0=09=09bool duallink =3D false, dummy;
> -=09=09if (nv_connector->edid &&
> -=09=09=C2=A0=C2=A0=C2=A0 nv_connector->type =3D=3D DCB_CONNECTOR_LVDS_SP=
WG) {
> -=09=09=09duallink =3D (((u8 *)nv_connector->edid)[121]
> =3D=3D 2);
> +=09=09if (nv_connector->spwg_links) {
> +=09=09=09duallink =3D nv_connector->spwg_links =3D=3D 2;
> =C2=A0=09=09} else {
> =C2=A0=09=09=09nouveau_bios_parse_lvds_table(dev,
> output_mode->clock,
> =C2=A0=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &duallink,
> &dummy);
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 2c66e480b511..add19d479ebe 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1803,8 +1803,8 @@ nv50_sor_atomic_enable(struct drm_encoder
> *encoder, struct drm_atomic_commit *st
> =C2=A0=09=09=09lvds_dual =3D bios->fp.dual_link;
> =C2=A0=09=09=09lvds_8bpc =3D bios->fp.if_is_24bit;
> =C2=A0=09=09} else {
> -=09=09=09if (nv_connector->type =3D=3D
> DCB_CONNECTOR_LVDS_SPWG) {
> -=09=09=09=09if (((u8 *)nv_connector->edid)[121]
> =3D=3D 2)
> +=09=09=09if (nv_connector->spwg_links) {
> +=09=09=09=09if (nv_connector->spwg_links =3D=3D 2)
> =C2=A0=09=09=09=09=09lvds_dual =3D true;
> =C2=A0=09=09=09} else
> =C2=A0=09=09=09if (mode->clock >=3D bios-
> >fp.duallink_transition_clk) {
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> index 21b56cc7605c..ab2868edd42b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> @@ -360,9 +360,10 @@ void nouveau_unregister_dsm_handler(void) {}
> =C2=A0void nouveau_switcheroo_optimus_dsm(void) {}
> =C2=A0#endif
> =C2=A0
> -void *
> +const struct drm_edid *
> =C2=A0nouveau_acpi_edid(struct drm_device *dev, struct drm_connector
> *connector)
> =C2=A0{
> +=09const struct drm_edid *drm_edid;
> =C2=A0=09struct acpi_device *acpidev;
> =C2=A0=09int type, ret;
> =C2=A0=09void *edid;
> @@ -384,7 +385,23 @@ nouveau_acpi_edid(struct drm_device *dev, struct
> drm_connector *connector)
> =C2=A0=09if (ret < 0)
> =C2=A0=09=09return NULL;
> =C2=A0
> -=09return edid;
> +=09/* Never let the EDID's own extension count reach past what
> _DDC
> +=09 * actually returned. Drop the padding some firmware appends
> so the
> +=09 * container is exactly the EDID, then validate it like the
> DDC
> +=09 * readers would.
> +=09 */
> +=09if (ret >=3D EDID_LENGTH)
> +=09=09ret =3D min_t(int, ret, EDID_LENGTH *
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 + ((const struct edid
> *)edid)->extensions));
> +=09drm_edid =3D drm_edid_alloc(edid, ret);
> +=09kfree(edid);
> +
> +=09if (drm_edid && !drm_edid_valid(drm_edid)) {
> +=09=09drm_dbg_kms(dev, "Invalid EDID from ACPI _DDC\n");
> +=09=09drm_edid_free(drm_edid);
> +=09=09drm_edid =3D NULL;
> +=09}
> +=09return drm_edid;
> =C2=A0}
> =C2=A0
> =C2=A0bool nouveau_acpi_video_backlight_use_native(void)
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.h
> b/drivers/gpu/drm/nouveau/nouveau_acpi.h
> index e39dd8b94b8b..bc3ccca7b338 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.h
> @@ -4,13 +4,15 @@
> =C2=A0
> =C2=A0#define ROM_BIOS_PAGE 4096
> =C2=A0
> +struct drm_edid;
> +
> =C2=A0#if defined(CONFIG_ACPI) && defined(CONFIG_X86)
> =C2=A0bool nouveau_is_optimus(void);
> =C2=A0bool nouveau_is_v1_dsm(void);
> =C2=A0void nouveau_register_dsm_handler(void);
> =C2=A0void nouveau_unregister_dsm_handler(void);
> =C2=A0void nouveau_switcheroo_optimus_dsm(void);
> -void *nouveau_acpi_edid(struct drm_device *, struct drm_connector
> *);
> +const struct drm_edid *nouveau_acpi_edid(struct drm_device *, struct
> drm_connector *);
> =C2=A0bool nouveau_acpi_video_backlight_use_native(void);
> =C2=A0void nouveau_acpi_video_register_backlight(void);
> =C2=A0#else
> @@ -19,7 +21,11 @@ static inline bool nouveau_is_v1_dsm(void) {
> return false; };
> =C2=A0static inline void nouveau_register_dsm_handler(void) {}
> =C2=A0static inline void nouveau_unregister_dsm_handler(void) {}
> =C2=A0static inline void nouveau_switcheroo_optimus_dsm(void) {}
> -static inline void *nouveau_acpi_edid(struct drm_device *dev, struct
> drm_connector *connector) { return NULL; }
> +static inline const struct drm_edid *
> +nouveau_acpi_edid(struct drm_device *dev, struct drm_connector
> *connector)
> +{
> +=09return NULL;
> +}
> =C2=A0static inline bool nouveau_acpi_video_backlight_use_native(void) {
> return true; }
> =C2=A0static inline void nouveau_acpi_video_register_backlight(void) {}
> =C2=A0#endif
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
> b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index b0b0ad9a0c24..55912da83cd0 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -397,7 +397,7 @@ nouveau_connector_destroy(struct drm_connector
> *connector)
> =C2=A0=09struct nouveau_connector *nv_connector =3D
> nouveau_connector(connector);
> =C2=A0=09nvif_event_dtor(&nv_connector->irq);
> =C2=A0=09nvif_event_dtor(&nv_connector->hpd);
> -=09kfree(nv_connector->edid);
> +=09drm_edid_free(nv_connector->drm_edid);
> =C2=A0=09drm_connector_unregister(connector);
> =C2=A0=09drm_connector_cleanup(connector);
> =C2=A0=09if (nv_connector->aux.transfer)
> @@ -469,6 +469,36 @@ nouveau_connector_ddc_detect(struct
> drm_connector *connector)
> =C2=A0=09return found;
> =C2=A0}
> =C2=A0
> +static void
> +nouveau_connector_set_edid(struct nouveau_connector *nv_connector,
> +=09=09=09=C2=A0=C2=A0 const struct drm_edid *drm_edid)
> +{
> +=09if (nv_connector->drm_edid =3D=3D drm_edid)
> +=09=09return;
> +
> +=09/* Updates the EDID property and display_info with HF-EEODB-
> aware
> +=09 * sizing. The legacy helpers truncate both to what EDID
> byte 126
> +=09 * admits, hiding the DisplayID extension blocks that carry
> the
> +=09 * high-refresh timings.
> +=09 */
> +=09drm_edid_connector_update(&nv_connector->base, drm_edid);
> +
> +=09drm_edid_free(nv_connector->drm_edid);
> +=09nv_connector->drm_edid =3D drm_edid;
> +
> +=09/* The SPWG link-count byte lives in a vendor descriptor drm
> has no
> +=09 * accessor for. Peek at it once here so nothing else needs
> the raw
> +=09 * EDID.
> +=09 */
> +=09nv_connector->spwg_links =3D 0;
> +=09if (nv_connector->type =3D=3D DCB_CONNECTOR_LVDS_SPWG) {
> +=09=09const u8 *raw =3D (const u8 *)drm_edid_raw(drm_edid);
> +
> +=09=09if (raw)
> +=09=09=09nv_connector->spwg_links =3D raw[121] =3D=3D 2 ? 2
> : 1;
> +=09}
> +}
> +
> =C2=A0static struct nouveau_encoder *
> =C2=A0nouveau_connector_of_detect(struct drm_connector *connector)
> =C2=A0{
> @@ -490,8 +520,17 @@ nouveau_connector_of_detect(struct drm_connector
> *connector)
> =C2=A0=09=09int idx =3D name ? name[strlen(name) - 1] - 'A' : 0;
> =C2=A0
> =C2=A0=09=09if (nv_encoder->dcb->i2c_index =3D=3D idx && edid) {
> -=09=09=09nv_connector->edid =3D
> -=09=09=09=09kmemdup(edid, EDID_LENGTH,
> GFP_KERNEL);
> +=09=09=09const struct drm_edid *drm_edid =3D
> +=09=09=09=09drm_edid_alloc(edid, EDID_LENGTH);
> +
> +=09=09=09/* Firmware-provided, so validate it like
> the DDC
> +=09=09=09 * readers would.
> +=09=09=09 */
> +=09=09=09if (drm_edid && !drm_edid_valid(drm_edid)) {
> +=09=09=09=09drm_edid_free(drm_edid);
> +=09=09=09=09drm_edid =3D NULL;
> +=09=09=09}
> +=09=09=09nouveau_connector_set_edid(nv_connector,
> drm_edid);
> =C2=A0=09=09=09return nv_encoder;
> =C2=A0=09=09}
> =C2=A0=09}
> @@ -546,17 +585,23 @@ nouveau_connector_set_encoder(struct
> drm_connector *connector,
> =C2=A0=09}
> =C2=A0}
> =C2=A0
> -static void
> -nouveau_connector_set_edid(struct nouveau_connector *nv_connector,
> -=09=09=09=C2=A0=C2=A0 struct edid *edid)
> +struct nouveau_rm_edid {
> +=09u8 *data;
> +=09size_t size;
> +};
> +
> +static int
> +nouveau_connector_rm_edid_block(void *context, u8 *buf, unsigned int
> block,
> +=09=09=09=09size_t len)
> =C2=A0{
> -=09if (nv_connector->edid !=3D edid) {
> -=09=09struct edid *old_edid =3D nv_connector->edid;
> +=09struct nouveau_rm_edid *rm =3D context;
> +=09size_t offset =3D (size_t)block * EDID_LENGTH;
> =C2=A0
> -=09=09drm_connector_update_edid_property(&nv_connector-
> >base, edid);
> -=09=09kfree(old_edid);
> -=09=09nv_connector->edid =3D edid;
> -=09}
> +=09if (offset + len > rm->size)
> +=09=09return -EINVAL;
> +
> +=09memcpy(buf, rm->data + offset, len);
> +=09return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static enum drm_connector_status
> @@ -590,22 +635,37 @@ nouveau_connector_detect(struct drm_connector
> *connector, bool force)
> =C2=A0
> =C2=A0=09nv_encoder =3D nouveau_connector_ddc_detect(connector);
> =C2=A0=09if (nv_encoder) {
> -=09=09struct edid *new_edid =3D NULL;
> +=09=09const struct drm_edid *new_edid =3D NULL;
> =C2=A0
> =C2=A0=09=09if (nv_encoder->i2c) {
> =C2=A0=09=09=09if ((vga_switcheroo_handler_flags() &
> VGA_SWITCHEROO_CAN_SWITCH_DDC) &&
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0 nv_connector->type =3D=3D
> DCB_CONNECTOR_LVDS)
> -=09=09=09=09new_edid =3D
> drm_get_edid_switcheroo(connector, nv_encoder->i2c);
> +=09=09=09=09new_edid =3D
> drm_edid_read_switcheroo(connector, nv_encoder->i2c);
> =C2=A0=09=09=09else
> -=09=09=09=09new_edid =3D drm_get_edid(connector,
> nv_encoder->i2c);
> +=09=09=09=09new_edid =3D
> drm_edid_read_ddc(connector, nv_encoder->i2c);
> =C2=A0=09=09} else {
> -=09=09=09ret =3D nvif_outp_edid_get(&nv_encoder->outp,
> (u8 **)&new_edid);
> -=09=09=09if (ret < 0)
> -=09=09=09=09return
> connector_status_disconnected;
> +=09=09=09struct nouveau_rm_edid rm =3D {};
> +
> +=09=09=09/* RM (which owns the DDC pads on GSP
> boards) reads the
> +=09=09=09 * EDID whole and returns its true size,
> which for an
> +=09=09=09 * HF-EEODB EDID exceeds what byte 126
> admits. Serve it
> +=09=09=09 * through drm's block reader so EEODB
> sizing, block
> +=09=09=09 * validation, and the debugfs EDID override
> all apply.
> +=09=09=09 * A failed read is treated like an empty
> DDC read,
> +=09=09=09 * which releases the runtime-PM reference.
> +=09=09=09 */
> +=09=09=09ret =3D nvif_outp_edid_get(&nv_encoder->outp,
> &rm.data);
> +=09=09=09if (ret >=3D 0) {
> +=09=09=09=09rm.size =3D ret;
> +=09=09=09=09new_edid =3D
> drm_edid_read_custom(connector,
> +=09=09=09=09=09=09=09=09nouv
> eau_connector_rm_edid_block,
> +=09=09=09=09=09=09=09=09&rm)
> ;
> +=09=09=09=09kfree(rm.data);
> +=09=09=09}
> =C2=A0=09=09}
> =C2=A0
> =C2=A0=09=09nouveau_connector_set_edid(nv_connector, new_edid);
> -=09=09if (!nv_connector->edid) {
> +=09=09if (!nv_connector->drm_edid) {
> =C2=A0=09=09=09NV_ERROR(drm, "DDC responded, but no EDID
> for %s\n",
> =C2=A0=09=09=09=09 connector->name);
> =C2=A0=09=09=09goto detect_analog;
> @@ -626,7 +686,7 @@ nouveau_connector_detect(struct drm_connector
> *connector, bool force)
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0 nv_partner->dcb->type =3D=3D
> DCB_OUTPUT_TMDS) ||
> =C2=A0=09=09=09=09=C2=A0=C2=A0 (nv_encoder->dcb->type =3D=3D
> DCB_OUTPUT_TMDS &&
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0 nv_partner->dcb->type =3D=3D
> DCB_OUTPUT_ANALOG))) {
> -=09=09=09if (nv_connector->edid->input &
> DRM_EDID_INPUT_DIGITAL)
> +=09=09=09if (drm_edid_is_digital(nv_connector-
> >drm_edid))
> =C2=A0=09=09=09=09type =3D DCB_OUTPUT_TMDS;
> =C2=A0=09=09=09else
> =C2=A0=09=09=09=09type =3D DCB_OUTPUT_ANALOG;
> @@ -638,7 +698,8 @@ nouveau_connector_detect(struct drm_connector
> *connector, bool force)
> =C2=A0=09=09conn_status =3D connector_status_connected;
> =C2=A0
> =C2=A0=09=09if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_DP)
> -=09=09=09drm_dp_cec_set_edid(&nv_connector->aux,
> nv_connector->edid);
> +=09=09=09drm_dp_cec_attach(&nv_connector->aux,
> +=09=09=09=09=09=C2=A0 connector-
> >display_info.source_physical_address);
> =C2=A0
> =C2=A0=09=09goto out;
> =C2=A0=09} else {
> @@ -670,7 +731,7 @@ nouveau_connector_detect(struct drm_connector
> *connector, bool force)
> =C2=A0=09}
> =C2=A0
> =C2=A0 out:
> -=09if (!nv_connector->edid)
> +=09if (!nv_connector->drm_edid)
> =C2=A0=09=09drm_dp_cec_unset_edid(&nv_connector->aux);
> =C2=A0
> =C2=A0=09pm_runtime_mark_last_busy(dev->dev);
> @@ -686,7 +747,7 @@ nouveau_connector_detect_lvds(struct
> drm_connector *connector, bool force)
> =C2=A0=09struct nouveau_drm *drm =3D nouveau_drm(dev);
> =C2=A0=09struct nouveau_connector *nv_connector =3D
> nouveau_connector(connector);
> =C2=A0=09struct nouveau_encoder *nv_encoder =3D NULL;
> -=09struct edid *edid =3D NULL;
> +=09const struct drm_edid *edid =3D NULL;
> =C2=A0=09enum drm_connector_status status =3D
> connector_status_disconnected;
> =C2=A0
> =C2=A0=09nv_encoder =3D find_encoder(connector, DCB_OUTPUT_LVDS);
> @@ -697,7 +758,7 @@ nouveau_connector_detect_lvds(struct
> drm_connector *connector, bool force)
> =C2=A0=09if (!drm->vbios.fp_no_ddc) {
> =C2=A0=09=09status =3D nouveau_connector_detect(connector, force);
> =C2=A0=09=09if (status =3D=3D connector_status_connected) {
> -=09=09=09edid =3D nv_connector->edid;
> +=09=09=09edid =3D nv_connector->drm_edid;
> =C2=A0=09=09=09goto out;
> =C2=A0=09=09}
> =C2=A0=09}
> @@ -733,9 +794,17 @@ nouveau_connector_detect_lvds(struct
> drm_connector *connector, bool force)
> =C2=A0=09 * stored for the panel stored in them.
> =C2=A0=09 */
> =C2=A0=09if (!drm->vbios.fp_no_ddc) {
> -=09=09edid =3D (struct edid
> *)nouveau_bios_embedded_edid(dev);
> -=09=09if (edid) {
> -=09=09=09edid =3D kmemdup(edid, EDID_LENGTH,
> GFP_KERNEL);
> +=09=09const void *embedded =3D
> nouveau_bios_embedded_edid(dev);
> +
> +=09=09if (embedded) {
> +=09=09=09edid =3D drm_edid_alloc(embedded,
> EDID_LENGTH);
> +=09=09=09/* Firmware-provided, so validate it like
> the DDC
> +=09=09=09 * readers would.
> +=09=09=09 */
> +=09=09=09if (edid && !drm_edid_valid(edid)) {
> +=09=09=09=09drm_edid_free(edid);
> +=09=09=09=09edid =3D NULL;
> +=09=09=09}
> =C2=A0=09=09=09if (edid)
> =C2=A0=09=09=09=09status =3D connector_status_connected;
> =C2=A0=09=09}
> @@ -886,7 +955,7 @@ nouveau_connector_detect_depth(struct
> drm_connector *connector)
> =C2=A0=09bool duallink;
> =C2=A0
> =C2=A0=09/* if the edid is feeling nice enough to provide this info,
> use it */
> -=09if (nv_connector->edid && connector->display_info.bpc)
> +=09if (nv_connector->drm_edid && connector->display_info.bpc)
> =C2=A0=09=09return;
> =C2=A0
> =C2=A0=09/* EDID 1.4 is *supposed* to be supported on eDP, but,
> Apple... */
> @@ -913,9 +982,8 @@ nouveau_connector_detect_depth(struct
> drm_connector *connector)
> =C2=A0=09/* LVDS: DDC panel, need to first determine the number of
> links to
> =C2=A0=09 * know which if_is_24bit flag to check...
> =C2=A0=09 */
> -=09if (nv_connector->edid &&
> -=09=C2=A0=C2=A0=C2=A0 nv_connector->type =3D=3D DCB_CONNECTOR_LVDS_SPWG)
> -=09=09duallink =3D ((u8 *)nv_connector->edid)[121] =3D=3D 2;
> +=09if (nv_connector->spwg_links)
> +=09=09duallink =3D nv_connector->spwg_links =3D=3D 2;
> =C2=A0=09else
> =C2=A0=09=09duallink =3D mode->clock >=3D bios-
> >fp.duallink_transition_clk;
> =C2=A0
> @@ -973,12 +1041,17 @@ nouveau_connector_get_modes(struct
> drm_connector *connector)
> =C2=A0=09=09nv_connector->native_mode =3D NULL;
> =C2=A0=09}
> =C2=A0
> -=09if (nv_connector->edid)
> -=09=09ret =3D drm_add_edid_modes(connector, nv_connector-
> >edid);
> -=09else
> -=09if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_LVDS &&
> -=09=C2=A0=C2=A0=C2=A0 (nv_encoder->dcb->lvdsconf.use_straps_for_mode ||
> -=09=C2=A0=C2=A0=C2=A0=C2=A0 drm->vbios.fp_no_ddc) && nouveau_bios_fp_mod=
e(dev,
> NULL)) {
> +=09if (nv_connector->drm_edid) {
> +=09=09/* The probe helper clears the property and
> display_info for
> +=09=09 * a forced-off connector without calling detect().
> Re-sync
> +=09=09 * from our copy then, since add_modes() reads the
> property.
> +=09=09 */
> +=09=09if (!connector->edid_blob_ptr)
> +=09=09=09drm_edid_connector_update(connector,
> nv_connector->drm_edid);
> +=09=09ret =3D drm_edid_connector_add_modes(connector);
> +=09} else if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_LVDS &&
> +=09=09=C2=A0=C2=A0 (nv_encoder->dcb->lvdsconf.use_straps_for_mode ||
> +=09=09=C2=A0=C2=A0=C2=A0 drm->vbios.fp_no_ddc) &&
> nouveau_bios_fp_mode(dev, NULL)) {
> =C2=A0=09=09struct drm_display_mode mode;
> =C2=A0
> =C2=A0=09=09nouveau_bios_fp_mode(dev, &mode);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h
> b/drivers/gpu/drm/nouveau/nouveau_connector.h
> index 0608cabed058..eb292d2ba4bc 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
> @@ -43,7 +43,7 @@
> =C2=A0
> =C2=A0struct nvkm_i2c_port;
> =C2=A0struct dcb_output;
> -struct edid;
> +struct drm_edid;
> =C2=A0
> =C2=A0#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> =C2=A0struct nouveau_backlight {
> @@ -121,6 +121,13 @@ struct nouveau_connector {
> =C2=A0=09struct drm_connector base;
> =C2=A0=09enum dcb_connector_type type;
> =C2=A0=09u8 index;
> +=09/* LVDS_SPWG panels state their link count in EDID
> descriptor 4 (SPWG
> +=09 * byte 0x79), cached by nouveau_connector_set_edid() so
> nothing else
> +=09 * needs the raw EDID. 0 =3D unknown (not an SPWG panel, or no
> EDID) and
> +=09 * callers fall back to their transition-clock/VBIOS
> heuristics;
> +=09 * 1 =3D single link; 2 =3D dual link.
> +=09 */
> +=09u8 spwg_links;
> =C2=A0
> =C2=A0=09struct nvif_conn conn;
> =C2=A0=09u64 hpd_pending;
> @@ -137,7 +144,8 @@ struct nouveau_connector {
> =C2=A0=09int scaling_mode;
> =C2=A0
> =C2=A0=09struct nouveau_encoder *detected_encoder;
> -=09struct edid *edid;
> +=09/* Owner of the sink's EDID, HF-EEODB-complete. */
> +=09const struct drm_edid *drm_edid;
> =C2=A0=09struct drm_display_mode *native_mode;
> =C2=A0#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> =C2=A0=09struct nouveau_backlight *backlight;

