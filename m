Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99916CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F1D10EB29;
	Mon, 28 Sep 2026 16:34:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RYjSL7M8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9795E10E921
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:34:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 75D7E42A0D
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087D81F000FF;
 Mon, 28 Sep 2026 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790613283;
 bh=mYBohBcNrmHXZ99E3VpI5D4qvTESFaKAsTHyBu9o/Yw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RYjSL7M8emIj+ZcOjaGoes5T8glSfz3mCacAr+yOFpN4+MnOUq4Ep5O1Z+SzZRyTE
 /auNbmKdb1jxXPpjh2Oq5b8j4Rt/re3cQHYGJ0zcjKW3Z0Xmw9SgDBOKuVI6HzIrcG
 6zGhVojriYTxs+Ogcd3Bt+mRhnkpJ3jLxjQgYTaLh3qKHFiDz2ZK1j1z9jE+kj679d
 HTq7u2haWT3jrB4B6XaM6i/jntQaDQzX/CW8QKaBrmOyvDotAXJKd1WDD/fbQJNgxh
 zQE5N7Ya9YvWKBb6TDtmlWQJYY8nTkmbSn1ShaC0kCYiDKHRZTrtXBxYftcAKBlfnP
 pJZ0is2+OdbFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] drm/panel: Add generic MIPI-DSI panel driver with
 BPF init sequences
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 bpf@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-2-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-2-5244926aace4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:34:42 +0000
Message-Id: <20260928163443.087D81F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] bpf: Use-After-Free when BPF program detaches from an unbound panel
- [High] bpf: Out-of-bounds read due to missing NUL-termination on user str=
ings
- [High] bpf: Out-of-bounds array access via negative enum indices in kfuncs
- [Medium] drm/panel: Missing hotplug event prevents display pipeline activ=
ation
- [Medium] bpf: Uninitialized kernel memory leaked over DSI bus via nullabl=
e pointers
- [Low] bpf: Tracepoints log incorrect status data instead of return value
--

commit 1f60161986e7e142490428d5f24fb3b831dddb58
Author: Maxime Ripard <mripard@kernel.org>
Subject: drm/panel: Add generic MIPI-DSI panel driver with BPF init sequenc=
es

This patch introduces a generic MIPI-DSI panel driver that uses BPF
programs loaded from userspace for panel-specific behavior. The driver
registers a disconnected drm_bridge, exposing sleepable kfuncs to
control regulators, GPIOs, and DSI data transfer.

> diff --git a/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-ops.c b/drivers=
/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-ops.c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-ops.c
> @@ -32,25 +32,25 @@
>  static int panel_bpf_mipi_dsi_bpf_init_member(const struct btf_type *t,
>  					      const struct btf_member *member,
>  					      void *kdata, const void *udata)
>  {
>  	const struct drm_panel_dsi_bpf_ops *uops =3D
>  		(const struct drm_panel_dsi_bpf_ops *)udata;
>  	struct drm_panel_dsi_bpf_ops *kops =3D
>  		(struct drm_panel_dsi_bpf_ops *)kdata;
>  	u32 moff;
> =20
>  	moff =3D __btf_member_bit_offset(t, member) / 8;
> =20
>  	switch (moff) {
>  	case offsetof(struct drm_panel_dsi_bpf_ops, panel_id):
>  		memcpy(kops->panel_id, uops->panel_id,
>  		       sizeof(kops->panel_id));
>  		return 1;
>  	case offsetof(struct drm_panel_dsi_bpf_ops, compatible):
>  		memcpy(kops->compatible, uops->compatible,
>  		       sizeof(kops->compatible));
>  		return 1;

[Severity: High]
Does this memcpy() ensure the string is NUL-terminated? If userspace=20
provides a string that is fully packed with non-NUL characters up to=20
the length of the array, the kernel string will remain unterminated.

[ ... ]

> @@ -78,12 +78,12 @@
>  static int panel_bpf_mipi_dsi_bpf_check_config(struct panel_bpf_mipi_dsi=
 *panel,
>  					       struct drm_panel_dsi_bpf_ops *ops)
>  {
>  	struct mipi_dsi_device *dsi =3D panel->dsi;
>  	struct device *dev =3D &dsi->dev;
> =20
>  	if (!of_device_is_compatible(dev->of_node, ops->compatible)) {

[Severity: High]
Can this result in an out-of-bounds read? If ops->compatible was copied fro=
m=20
userspace without a NUL terminator in panel_bpf_mipi_dsi_bpf_init_member(),=
=20
the OF core functions like of_device_is_compatible() will read past the=20
buffer boundary when attempting string comparison.

>  		dev_err(dev,
>  			"BPF compatible \"%s\" doesn't match panel\n",
>  			ops->compatible);
>  		return -EINVAL;
>  	}

[ ... ]

> @@ -134,25 +134,25 @@
>  static int panel_bpf_mipi_dsi_bpf_reg(void *kdata, struct bpf_link *link)
>  {
>  	struct drm_panel_dsi_bpf_ops *ops =3D kdata;
>  	struct panel_bpf_mipi_dsi *panel;
>  	int ret;
> =20
>  	trace_panel_bpf_mipi_dsi_reg(ops->panel_id);
> =20
>  	guard(mutex)(&panel_bpf_mipi_dsi_list_lock);
> =20
>  	panel =3D panel_bpf_mipi_dsi_find_panel_unlocked(ops->panel_id);
>  	if (!panel)
>  		return -ENODEV;
> =20
>  	guard(mutex)(&panel->bpf_lock);
> =20
>  	if (panel->bpf_ops)
>  		return -EBUSY;
> =20
>  	ret =3D panel_bpf_mipi_dsi_bpf_check_config(panel, ops);
>  	if (ret)
>  		return ret;
> =20
>  	ops->bridge =3D &panel->bridge;
>  	panel->bpf_ops =3D ops;
> =20
>  	return 0;
>  }

[Severity: Medium]
When a BPF program successfully attaches here, it changes the bridge's=20
detect callback behavior from returning connector_status_disconnected to=20
connector_status_connected. Should this function also broadcast a hotplug=20
notification to userspace so the display pipeline can be brought up without=
=20
waiting for the next KMS polling cycle?

[ ... ]

> @@ -168,21 +168,21 @@
>  static void panel_bpf_mipi_dsi_bpf_unreg(void *kdata, struct bpf_link *l=
ink)
>  {
>  	struct drm_panel_dsi_bpf_ops *ops =3D kdata;
>  	struct panel_bpf_mipi_dsi *panel;
> =20
>  	trace_panel_bpf_mipi_dsi_unreg(ops->panel_id);
> =20
>  	if (!ops->bridge)
>  		return;
> =20
>  	panel =3D drm_bridge_to_bpf_panel(ops->bridge);
> =20
>  	scoped_guard(mutex, &panel->bpf_lock) {

[Severity: High]
Can this sequence trigger a use-after-free when unregistering?=20

If a MIPI DSI device unbinds, devres triggers panel_bpf_mipi_dsi_list_clean=
up()=20
which removes the panel from the global list but doesn't detach the BPF=20
program or clear ops->bridge before freeing the panel structure.=20

If userspace subsequently unregisters the BPF struct_ops link,=20
panel_bpf_mipi_dsi_bpf_unreg() appears to use the dangling ops->bridge=20
pointer to resolve the freed panel structure, and then locks its bpf_lock.

> diff --git a/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-kfuncs.c b/driv=
ers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-kfuncs.c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-kfuncs.c
> @@ -36,15 +36,15 @@
>  __bpf_kfunc int panel_bpf_mipi_dsi_regulator_enable_and_wait(struct pane=
l_bpf_mipi_dsi_ctx *ctx,
>  							     enum panel_bpf_mipi_dsi_supply supply,
>  							     u32 settle_ms)
>  {
>  	struct panel_bpf_mipi_dsi *panel =3D bpf_ctx_to_bpf_panel(ctx);
>  	int ret;
> =20
>  	if (supply >=3D PANEL_BPF_MIPI_DSI_SUPPLY_COUNT)
>  		return -EINVAL;

[Severity: High]
Does this bounds check adequately protect against out-of-bounds array acces=
ses?
The BPF verifier validates kfunc enum parameters as signed scalar values,
which could be negative. A negative index here would pass the upper-bound
check and allow an out-of-bounds read into panel->supplies. This same=20
pattern exists for the GPIO enum checks elsewhere in this file.

> =20
>  	trace_panel_bpf_mipi_dsi_regulator_enable_and_wait(panel->panel_id,
>  							   panel->supplies[supply].supply,
>  							   settle_ms);

[ ... ]

> @@ -177,19 +177,19 @@
>  __bpf_kfunc int panel_bpf_mipi_dsi_dcs_write_and_wait(struct panel_bpf_m=
ipi_dsi_ctx *ctx,
>  						      u8 cmd, const u8 *data__nullable,
>  						      u32 data__nullable__sz,
>  						      u32 settle_ms)
>  {
>  	struct panel_bpf_mipi_dsi *panel =3D bpf_ctx_to_bpf_panel(ctx);
>  	int ret;
> =20
>  	trace_panel_bpf_mipi_dsi_dcs_write_and_wait(panel->panel_id, cmd, data_=
_nullable,
>  						    data__nullable__sz, settle_ms);

[Severity: Low]
Is this tracepoint logging the correct information? The trace event definit=
ion=20
expects the bus transaction's return value for the fifth argument (ret), bu=
t=20
this code passes the sleep duration settle_ms into the ret parameter.

> =20
>  	ret =3D mipi_dsi_dcs_write(panel->dsi, cmd, data__nullable,
>  				 data__nullable__sz);

[Severity: Medium]
Could this result in uninitialized kernel memory being leaked over the DSI =
bus?
When data__nullable is NULL, the BPF verifier doesn't enforce that=20
data__nullable__sz is zero. mipi_dsi_dcs_write() will allocate a buffer of=
=20
size data__nullable__sz, skip the memcpy because the source is NULL, and th=
en=20
transmit the uninitialized kmalloc buffer to the display. Should there be a=
=20
check for data__nullable =3D=3D NULL && data__nullable__sz > 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-drm-mipi-d=
si-panel-ebpf-v1-0-5244926aace4@kernel.org?part=3D2
