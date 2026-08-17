Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AB4C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 23:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66EA10E469;
	Mon, 17 Aug 2026 23:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aR0Egtj7";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AEB510E46D
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 23:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787010720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzND+zp9q/JR5wa/7ajbsp+dyC566yAAPv3ruDghD+U=;
 b=aR0Egtj7dbNoJ10Sl9Xx67ESglpdC+ea1sEAl8txQut04/ZVx4IVIOtam06WS7vDoWSvJ0
 2TDqfYTvyrH3+BSsKOWYgSiadKlW4dINFaC+xsPYL2taaBjbgb1zsNQf7sDEZ11/oU3TmG
 dud1RbYKGhFJLyPhQ3Lxq2dg14k0f5E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-ckE1FhnuNwC8-MswgpMHIw-1; Mon, 17 Aug 2026 19:51:57 -0400
X-MC-Unique: ckE1FhnuNwC8-MswgpMHIw-1
X-Mimecast-MFC-AGG-ID: ckE1FhnuNwC8-MswgpMHIw_1787010716
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e820609d9so391888785a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 16:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787010716; x=1787615516;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iSF/FvhwTwSJgXW6nLHqHhB1nUwj7OkN5gXEkNQV4vc=;
 b=LVsFwWO34dUOT3plfndzOhf8V44gN9dIjosHap6Mxy/eOlndsgWRU/GKXgI5JApSuo
 Ujm2Ie07gKh6s7Wbo/PDQyPL8r7CEZP1p8k6TF6XwlGefuKfQ5fo1DaHIhbCnwosi6Xa
 y5U69ks3LYPfIJv7uTtZDSN4rhO1UhEJeOzYRAhdlHx7eE+ocFL1Q0JiLWepomnJBQgu
 OSfvpuqP1Re2ZEF/rdJxnUgquwMBe+H26JSOS1nZZp1HgU3F9SCZ7v0svm0Kq2OzQuQ1
 oVTuiRUtINNtDZd6U0yGKiUQQE36xnwZl7lY+yj32KchESifmeI5HEucGhjtEDLGjfeH
 kP7Q==
X-Gm-Message-State: AOJu0Ywb9QRx/rAF18fKQglPZMUEKqSqFvLHWsEeae8C/R9IXlunvNEX
 sr45MYOnT7j0BRI0hmjw1riBzIiFYSEHsHwGtNbYrNSu++r85IHfR5z5SQbiQ6ntQjYztk57S9F
 NbsCkyAghrrVidqn6nd00QkzRT72eyqrnuLdFn61gN5lI4UmqNsph6hTpomNBui4sKD3YjQ==
X-Gm-Gg: AR+sD11jLZcvXr/IcmBlD2+yIsymLwnMwZ6uNRtJE6YwRfLSxWzhG+vc5jQDeWX1Ok6
 nU23j7958Wa5gFxcs9wiyVUaU50g4UhK39Ppmpgc246MvHLLuTLKI0gl3FQlx/zRy59lgcrtVxR
 qMzU1R+20xk7RODDkVKNYLJJ8lz/PiV/MknyD8Ngn9ycfvCIq6nh28NhUe94/stVdQ21Jwnipo7
 +Wam0wTAVOOiugKV9kNeN3TquwSCLd1EGeLG4SqAD5gaJJolA4PApcyoRaGGg/RjviwQ9K3Onsx
 9BJVi1OeiT2DakIM+1DQkLUVi6srH8/1VteK7FJ6sHLD1YALBiG5vP+A7v3Mqzr3R/6YCNnL
X-Received: by 2002:a05:620a:701c:b0:936:dbf1:f495 with SMTP id
 af79cd13be357-93704b1ba0dmr480099885a.1.1787010716534; 
 Mon, 17 Aug 2026 16:51:56 -0700 (PDT)
X-Received: by 2002:a05:620a:701c:b0:936:dbf1:f495 with SMTP id
 af79cd13be357-93704b1ba0dmr480096585a.1.1787010716063; 
 Mon, 17 Aug 2026 16:51:56 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937010240absm207239685a.0.2026.08.17.16.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 16:51:54 -0700 (PDT)
Message-ID: <9ed92694e5cb9c6f89755b41b705346b7bf83590.camel@redhat.com>
Subject: Re: [PATCH 7/7] nouveau: honor HF-EEODB EDIDs by converting to
 struct drm_edid
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Mon, 17 Aug 2026 19:51:54 -0400
In-Reply-To: <20260814235705.59132-8-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-8-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uDl7sPaKMmVnTrsjvUxrQBp-faj1dBFx3zETzg0Cdck_1787010716
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

Ah, how rust has changed me. Some comments below:

On Sat, 2026-08-15 at 03:57 +0400, Mohamed Ahmed wrote:
> HDMI 2.1 sinks ship HF-EEODB EDIDs. Byte 126 deliberately claims one
> extension block for legacy sources, and the true count lives in the
> CTA
> block's first data block. Their high-refresh timings (e.g., 4K240,
> 6K165,
> etc) sit in DisplayID extension blocks 2+.
>=20
> The kernel already reads these EDIDs whole, and on GSP boards RM
> returns
> the full EDID with its true size. However, nouveau then hands the
> buffer
> to the legacy API which sizes the EDID from byte 126 so the DisplayID
> blocks are not parsed/exposed and the sysfs blob truncates to 256
> bytes.
>=20
> Convert to the struct drm_edid API, which carries the real size.
> Read via drm_edid_read_ddc()/drm_edid_read_switcheroo() where an
> adapter exists, and serve RM's buffer through drm_edid_read_custom()
> with a block-reading callback where not, which also routes the GSP
> path through drm's block validation and the debugfs EDID override
> (previously dead on GSP boards, since nothing consulted it outside
> the i2c readers).
>=20
> The connector keeps a borrowed const drm_edid_raw() view in ->edid,
> same
> as i915's detect_edid so the raw-EDID consumers (SAD parsing, deep-
> color
> flags, the DVI dual-link byte, DP CEC) are untouched. Ownership and
> freeing move to the drm_edid. The OF path additionally now frees any
> previous EDID itself rather than relying on the callers. MST
> connectors
> keep their separate legacy path.
>=20
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/disp.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.c | 95 ++++++++++++++++--=
-
> --
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.h |=C2=A0 7 +-
> =C2=A03 files changed, 80 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 364227f5456f..c3b7fd29c077 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1804,7 +1804,7 @@ nv50_sor_atomic_enable(struct drm_encoder
> *encoder, struct drm_atomic_commit *st
> =C2=A0=09=09=09lvds_8bpc =3D bios->fp.if_is_24bit;
> =C2=A0=09=09} else {
> =C2=A0=09=09=09if (nv_connector->type =3D=3D
> DCB_CONNECTOR_LVDS_SPWG) {
> -=09=09=09=09if (((u8 *)nv_connector->edid)[121]
> =3D=3D 2)
> +=09=09=09=09if (((const u8 *)nv_connector-
> >edid)[121] =3D=3D 2)
> =C2=A0=09=09=09=09=09lvds_dual =3D true;
> =C2=A0=09=09=09} else
> =C2=A0=09=09=09if (mode->clock >=3D bios-
> >fp.duallink_transition_clk) {
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
> b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index b0b0ad9a0c24..4105555151c9 100644
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
> @@ -490,8 +490,11 @@ nouveau_connector_of_detect(struct drm_connector
> *connector)
> =C2=A0=09=09int idx =3D name ? name[strlen(name) - 1] - 'A' : 0;
> =C2=A0
> =C2=A0=09=09if (nv_encoder->dcb->i2c_index =3D=3D idx && edid) {
> +=09=09=09drm_edid_free(nv_connector->drm_edid);
> +=09=09=09nv_connector->drm_edid =3D
> +=09=09=09=09drm_edid_alloc(edid, EDID_LENGTH);
> =C2=A0=09=09=09nv_connector->edid =3D
> -=09=09=09=09kmemdup(edid, EDID_LENGTH,
> GFP_KERNEL);
> +=09=09=09=09drm_edid_raw(nv_connector-
> >drm_edid);
> =C2=A0=09=09=09return nv_encoder;
> =C2=A0=09=09}
> =C2=A0=09}
> @@ -546,17 +549,42 @@ nouveau_connector_set_encoder(struct
> drm_connector *connector,
> =C2=A0=09}
> =C2=A0}
> =C2=A0
> +struct nouveau_rm_edid {
> +=09u8 *data;
> +=09int size;
> +};
> +
> +static int
> +nouveau_connector_rm_edid_block(void *context, u8 *buf, unsigned int
> block,
> +=09=09=09=09size_t len)
> +{
> +=09struct nouveau_rm_edid *rm =3D context;
> +=09size_t offset =3D (size_t)block * EDID_LENGTH;
> +
> +=09if (offset + len > rm->size)
> +=09=09return -EINVAL;
> +
> +=09memcpy(buf, rm->data + offset, len);
> +=09return 0;
> +}
> +
> =C2=A0static void
> =C2=A0nouveau_connector_set_edid(struct nouveau_connector *nv_connector,
> -=09=09=09=C2=A0=C2=A0 struct edid *edid)
> +=09=09=09=C2=A0=C2=A0 const struct drm_edid *drm_edid)
> =C2=A0{
> -=09if (nv_connector->edid !=3D edid) {
> -=09=09struct edid *old_edid =3D nv_connector->edid;
> +=09if (nv_connector->drm_edid =3D=3D drm_edid)
> +=09=09return;
> =C2=A0
> -=09=09drm_connector_update_edid_property(&nv_connector-
> >base, edid);
> -=09=09kfree(old_edid);
> -=09=09nv_connector->edid =3D edid;
> -=09}
> +=09/* Updates the EDID property and display_info with HF-EEODB-
> aware
> +=09 * sizing. The legacy helpers truncate both to what EDID
> byte 126
> +=09 * admits, hiding the DisplayID extension blocks that carry
> every
> +=09 * timing a DTD can't express (>655.35 MHz).
> +=09 */
> +=09drm_edid_connector_update(&nv_connector->base, drm_edid);
> +
> +=09drm_edid_free(nv_connector->drm_edid);
> +=09nv_connector->drm_edid =3D drm_edid;
> +=09nv_connector->edid =3D drm_edid_raw(drm_edid);
> =C2=A0}
> =C2=A0
> =C2=A0static enum drm_connector_status
> @@ -590,20 +618,36 @@ nouveau_connector_detect(struct drm_connector
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
> +=09=09=09struct nouveau_rm_edid rm =3D {};
> +
> +=09=09=09ret =3D nvif_outp_edid_get(&nv_encoder->outp,
> &rm.data);
> =C2=A0=09=09=09if (ret < 0)
> =C2=A0=09=09=09=09return
> connector_status_disconnected;
> +
> +=09=09=09/* ret is RM's true buffer size: an HF-EEODB
> EDID is
> +=09=09=09 * larger than its byte 126 admits, and RM
> (which
> +=09=09=09 * owns the DDC pads on GSP boards) reads it
> whole.
> +=09=09=09 * Serve it through drm's block reader so
> EEODB
> +=09=09=09 * sizing, block validation, and the debugfs
> EDID
> +=09=09=09 * override all apply.
> +=09=09=09 */
> +=09=09=09rm.size =3D ret;
> +=09=09=09new_edid =3D drm_edid_read_custom(connector,
> +=09=09=09=09=09=09=09nouveau_conn
> ector_rm_edid_block,
> +=09=09=09=09=09=09=09&rm);
> +=09=09=09kfree(rm.data);
> =C2=A0=09=09}
> =C2=A0
> +
> =C2=A0=09=09nouveau_connector_set_edid(nv_connector, new_edid);
> =C2=A0=09=09if (!nv_connector->edid) {
> =C2=A0=09=09=09NV_ERROR(drm, "DDC responded, but no EDID
> for %s\n",
> @@ -686,7 +730,7 @@ nouveau_connector_detect_lvds(struct
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
> @@ -697,7 +741,7 @@ nouveau_connector_detect_lvds(struct
> drm_connector *connector, bool force)
> =C2=A0=09if (!drm->vbios.fp_no_ddc) {
> =C2=A0=09=09status =3D nouveau_connector_detect(connector, force);
> =C2=A0=09=09if (status =3D=3D connector_status_connected) {
> -=09=09=09edid =3D nv_connector->edid;
> +=09=09=09edid =3D nv_connector->drm_edid;
> =C2=A0=09=09=09goto out;
> =C2=A0=09=09}
> =C2=A0=09}
> @@ -712,7 +756,13 @@ nouveau_connector_detect_lvds(struct
> drm_connector *connector, bool force)
> =C2=A0=09 * valid - it's not (rh#613284)
> =C2=A0=09 */
> =C2=A0=09if (nv_encoder->dcb->lvdsconf.use_acpi_for_edid) {
> -=09=09edid =3D nouveau_acpi_edid(dev, connector);
> +=09=09struct edid *raw =3D nouveau_acpi_edid(dev,
> connector);
> +
> +=09=09if (raw) {
> +=09=09=09edid =3D drm_edid_alloc(raw,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EDID_LENGTH * (1 +
> raw->extensions));
> +=09=09=09kfree(raw);

Maybe check drm_edid_alloc() after calling it so we can print something
if it fails? Otherwise, an allocation failure might mask itself as some
other unrelated connector probing error

> +=09=09}
> =C2=A0=09=09if (edid) {
> =C2=A0=09=09=09status =3D connector_status_connected;
> =C2=A0=09=09=09goto out;
> @@ -733,9 +783,10 @@ nouveau_connector_detect_lvds(struct
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
> =C2=A0=09=09=09if (edid)
> =C2=A0=09=09=09=09status =3D connector_status_connected;
> =C2=A0=09=09}
> @@ -915,7 +966,7 @@ nouveau_connector_detect_depth(struct
> drm_connector *connector)
> =C2=A0=09 */
> =C2=A0=09if (nv_connector->edid &&
> =C2=A0=09=C2=A0=C2=A0=C2=A0 nv_connector->type =3D=3D DCB_CONNECTOR_LVDS_=
SPWG)
> -=09=09duallink =3D ((u8 *)nv_connector->edid)[121] =3D=3D 2;
> +=09=09duallink =3D ((const u8 *)nv_connector->edid)[121] =3D=3D
> 2;
> =C2=A0=09else
> =C2=A0=09=09duallink =3D mode->clock >=3D bios-
> >fp.duallink_transition_clk;
> =C2=A0
> @@ -973,8 +1024,8 @@ nouveau_connector_get_modes(struct drm_connector
> *connector)
> =C2=A0=09=09nv_connector->native_mode =3D NULL;
> =C2=A0=09}
> =C2=A0
> -=09if (nv_connector->edid)
> -=09=09ret =3D drm_add_edid_modes(connector, nv_connector-
> >edid);
> +=09if (nv_connector->drm_edid)
> +=09=09ret =3D drm_edid_connector_add_modes(connector);
> =C2=A0=09else
> =C2=A0=09if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_LVDS &&
> =C2=A0=09=C2=A0=C2=A0=C2=A0 (nv_encoder->dcb->lvdsconf.use_straps_for_mod=
e ||
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h
> b/drivers/gpu/drm/nouveau/nouveau_connector.h
> index 0608cabed058..ca8f310b3680 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
> @@ -137,7 +137,12 @@ struct nouveau_connector {
> =C2=A0=09int scaling_mode;
> =C2=A0
> =C2=A0=09struct nouveau_encoder *detected_encoder;
> -=09struct edid *edid;
> +=09/* Borrowed decoded view of ->drm_edid for the raw-EDID
> consumers
> +=09 * (SADs, deep-colour flags, dual-link byte); do not free.
> +=09 */
> +=09const struct edid *edid;
> +=09/* Owner of the sink's EDID, HF-EEODB-complete. */
> +=09const struct drm_edid *drm_edid;
> =C2=A0=09struct drm_display_mode *native_mode;
> =C2=A0#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> =C2=A0=09struct nouveau_backlight *backlight;

