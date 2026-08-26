Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFC6C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B567810E298;
	Wed, 26 Aug 2026 11:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c2OGi2cA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2BA10E298;
 Wed, 26 Aug 2026 11:52:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9D9341A7B;
 Wed, 26 Aug 2026 11:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED251F000E9;
 Wed, 26 Aug 2026 11:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787745176;
 bh=iRWRkd0hh7NrpUS5yE2QLfqEtCKKKQGDAZF4IlZG2oE=;
 h=Date:From:To:Cc:Subject;
 b=c2OGi2cAPPXOAYKLZsziyiNnAvK8t7iU77VLCW+1A+ypJMoxdPahVJnDq5ucQFllx
 d+ZiklmUfqdPtXq6IyZ7fpmGheobqfWAZ7Ye77ZDFlsL7OpDMjzlCVF9S71UggV7+B
 zPsXlcYe8Bch/6FXUCeCd+rbAlsH5nX4MwdFef8Ou5CdzLFOE5m8wBJpamiNaFVjf2
 F3G2W4wB/6DG444VtZDHSosyA2nlWGmaqbW+M/J3/J3dSc4dj+vANWJQyOdmqqo6JK
 CxmHGrCaTjmXVL7GCdw/mlLkhyHoDmJeFzVQMR7M+Dki1OH3O+NnaAqEEPlToEK858
 xLEaw3jNnPqMA==
Date: Wed, 26 Aug 2026 12:52:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Dave Airlie <airlied@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Lyude Paul <lyude@redhat.com>,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: linux-next: manual merge of the drm-misc-fixes tree with the origin
 tree
Message-ID: <ao7TlLDCvDc9KS2q@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BcRjPkRg30TfJc73"
Content-Disposition: inline
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


--BcRjPkRg30TfJc73
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc-fixes tree got conflicts in:

  drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c

between commit:

  804cb093b245c ("drm/nouveau/disp/r535: Add scanline position support + he=
ad state support")

=66rom the origin tree and commits:

  c6659e0ffc19b ("drm/nouveau/disp: move GSP head-timing ISR and vblank hel=
pers to tu102.c")
  5bb489b333237 ("drm/nouveau/gsp: fix vblank interrupts on GB20x")

=66rom the drm-misc-fixes tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
index b642729c254fe,5976498da9094..0000000000000
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
@@@ -56,6 -56,8 +56,8 @@@ int gv100_head_new(struct nvkm_disp *,=20
  void gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *sta=
te);
  void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline);
 =20
+ extern const struct nvkm_head_func tu102_gsp_head;
+=20
  #define HEAD_MSG(h,l,f,a...) do {                                        =
      \
  	struct nvkm_head *_h =3D (h);                                           =
 \
  	nvkm_##l(&_h->disp->engine.subdev, "head-%d: "f"\n", _h->id, ##a);     \
diff --combined drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index e77733a5d9c3c,f5f22173fc2c1..0000000000000
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@@ -400,16 -400,16 +400,16 @@@ r535_sor_dp_audio(struct nvkm_ior *sor
  		r535_sor_dp_audio_mute(sor, false);
  }
 =20
- static void
- r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16=
 pbn, u16 aligned_pbn)
+ static int
+ r535_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn=
, u16 aligned_pbn)
  {
  	struct nvkm_disp *disp =3D sor->disp;
  	struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
 =20
  	ctrl =3D nvkm_gsp_rm_ctrl_get(&disp->rm.objcom,
  				    NV0073_CTRL_CMD_DP_CONFIG_STREAM, sizeof(*ctrl));
- 	if (WARN_ON(IS_ERR(ctrl)))
- 		return;
+ 	if (IS_ERR(ctrl))
+ 		return PTR_ERR(ctrl);
 =20
  	ctrl->subDeviceInstance =3D 0;
  	ctrl->head =3D head;
@@@ -429,12 -429,20 +429,20 @@@
  	ctrl->MST.sendACT =3D 0;
  	ctrl->MST.singleHeadMSTPipeline =3D 0;
  	ctrl->MST.bEnableAudioOverRightPanel =3D 0;
- 	WARN_ON(nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl));
+ 	return nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl);
+ }
+=20
+ static void
+ r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16=
 pbn, u16 aligned_pbn)
+ {
+ 	const struct nvkm_rm_api *rmapi =3D sor->disp->engine.subdev.device->gsp=
->rm->api;
+=20
+ 	WARN_ON(rmapi->disp->dp.vcpi(sor, head, slot, slot_nr, pbn, aligned_pbn)=
);
  }
 =20
  static int
- r535_sor_dp_sst(struct nvkm_ior *sor, int head, bool ef,
- 		u32 watermark, u32 hblanksym, u32 vblanksym)
+ r535_dp_sst(struct nvkm_ior *sor, int head, bool ef,
+ 	    u32 watermark, u32 hblanksym, u32 vblanksym)
  {
  	struct nvkm_disp *disp =3D sor->disp;
  	struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
@@@ -461,6 -469,15 +469,15 @@@
  	return nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl);
  }
 =20
+ static int
+ r535_sor_dp_sst(struct nvkm_ior *sor, int head, bool ef,
+ 		u32 watermark, u32 hblanksym, u32 vblanksym)
+ {
+ 	const struct nvkm_rm_api *rmapi =3D sor->disp->engine.subdev.device->gsp=
->rm->api;
+=20
+ 	return rmapi->disp->dp.sst(sor, head, ef, watermark, hblanksym, vblanksy=
m);
+ }
+=20
  static const struct nvkm_ior_func_dp
  r535_sor_dp =3D {
  	.sst =3D r535_sor_dp_sst,
@@@ -545,16 -562,21 +562,21 @@@ r535_sor_hdmi_ctrl_audio(struct nvkm_ou
  static void
  r535_sor_hdmi_audio(struct nvkm_ior *sor, int head, bool enable)
  {
- 	struct nvkm_device *device =3D sor->disp->engine.subdev.device;
- 	const u32 hdmi =3D head * 0x400;
-=20
  	r535_sor_hdmi_ctrl_audio(sor->asy.outp, enable);
  	r535_sor_hdmi_ctrl_audio_mute(sor->asy.outp, !enable);
+ 	sor->disp->func->gsp.hdmi_gcp(sor, head, enable);
+ }
 =20
- 	/* General Control (GCP). */
- 	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000000);
- 	nvkm_wr32(device, 0x6f00cc + hdmi, !enable ? 0x00000001 : 0x00000010);
- 	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000001);
+ static void
+ r535_sor_hdmi_infoframe_avi(struct nvkm_ior *sor, int head, void *data, u=
32 size)
+ {
+ 	sor->disp->func->gsp.hdmi_infoframe_avi(sor, head, data, size);
+ }
+=20
+ static void
+ r535_sor_hdmi_infoframe_vsi(struct nvkm_ior *sor, int head, void *data, u=
32 size)
+ {
+ 	sor->disp->func->gsp.hdmi_infoframe_vsi(sor, head, data, size);
  }
 =20
  static void
@@@ -582,8 -604,8 +604,8 @@@ r535_sor_hdmi =3D=20
  	.ctrl =3D r535_sor_hdmi_ctrl,
  	.scdc =3D r535_sor_hdmi_scdc,
  	/*TODO: SF_USER -> KMS. */
- 	.infoframe_avi =3D gv100_sor_hdmi_infoframe_avi,
- 	.infoframe_vsi =3D gv100_sor_hdmi_infoframe_vsi,
+ 	.infoframe_avi =3D r535_sor_hdmi_infoframe_avi,
+ 	.infoframe_vsi =3D r535_sor_hdmi_infoframe_vsi,
  	.audio =3D r535_sor_hdmi_audio,
  };
 =20
@@@ -608,31 -630,6 +630,6 @@@ r535_sor_cnt(struct nvkm_disp *disp, un
  	return 4;
  }
 =20
- static void
- r535_head_vblank_put(struct nvkm_head *head)
- {
- 	struct nvkm_device *device =3D head->disp->engine.subdev.device;
-=20
- 	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000000);
- }
-=20
- static void
- r535_head_vblank_get(struct nvkm_head *head)
- {
- 	struct nvkm_device *device =3D head->disp->engine.subdev.device;
-=20
- 	nvkm_wr32(device, 0x611800 + (head->id * 4), 0x00000002);
- 	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
- }
-=20
- static const struct nvkm_head_func
- r535_head =3D {
- 	.state =3D gv100_head_state,
- 	.rgpos =3D gv100_head_rgpos,
- 	.vblank_get =3D r535_head_vblank_get,
- 	.vblank_put =3D r535_head_vblank_put,
- };
-=20
  static struct nvkm_conn *
  r535_conn_new(struct nvkm_disp *disp, u32 id)
  {
@@@ -1404,35 -1401,6 +1401,6 @@@ static const struct nvkm_event_fun
  r535_disp_event =3D {
  };
 =20
- static void
- r535_disp_intr_head_timing(struct nvkm_disp *disp, int head)
- {
- 	struct nvkm_subdev *subdev =3D &disp->engine.subdev;
- 	struct nvkm_device *device =3D subdev->device;
- 	u32 stat =3D nvkm_rd32(device, 0x611c00 + (head * 0x04));
-=20
- 	if (stat & 0x00000002) {
- 		nvkm_disp_vblank(disp, head);
-=20
- 		nvkm_wr32(device, 0x611800 + (head * 0x04), 0x00000002);
- 	}
- }
-=20
- static irqreturn_t
- r535_disp_intr(struct nvkm_inth *inth)
- {
- 	struct nvkm_disp *disp =3D container_of(inth, typeof(*disp), engine.subd=
ev.inth);
- 	struct nvkm_subdev *subdev =3D &disp->engine.subdev;
- 	struct nvkm_device *device =3D subdev->device;
- 	unsigned long mask =3D nvkm_rd32(device, 0x611ec0) & 0x000000ff;
- 	int head;
-=20
- 	for_each_set_bit(head, &mask, 8)
- 		r535_disp_intr_head_timing(disp, head);
-=20
- 	return IRQ_HANDLED;
- }
-=20
  static void
  r535_disp_fini(struct nvkm_disp *disp, bool suspend)
  {
@@@ -1659,7 -1627,7 +1627,7 @@@ r535_disp_oneinit(struct nvkm_disp *dis
  		nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
 =20
  		for_each_set_bit(i, &disp->head.mask, disp->head.nr) {
- 			ret =3D nvkm_head_new_(&r535_head, disp, i);
+ 			ret =3D nvkm_head_new_(disp->func->gsp.head, disp, i);
  			if (ret)
  				return ret;
  		}
@@@ -1703,12 -1671,20 +1671,20 @@@
  	if (ret)
  		return ret;
 =20
- 	ret =3D nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type, disp->engine.=
subdev.inst);
+ 	/* Chips that raise head-timing interrupts on a separate low-latency
+ 	 * vector report it as a second DISP interrupt table entry, exposed
+ 	 * as instance 1 by the RM engine-index translation (see
+ 	 * r570_gsp_xlat_mc_engine_idx()). Their high-latency vector
+ 	 * (instance 0) is left unhandled as no event nouveau enables is
+ 	 * routed to it, and without a handler it stays masked.
+ 	 */
+ 	ret =3D nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type,
+ 				  disp->func->gsp.intr_low_latency ? 1 : disp->engine.subdev.inst);
  	if (ret < 0)
  		return ret;
 =20
  	ret =3D nvkm_inth_add(&device->vfn->intr, ret, NVKM_INTR_PRIO_NORMAL, &d=
isp->engine.subdev,
- 			    r535_disp_intr, &disp->engine.subdev.inth);
+ 			    disp->func->gsp.intr, &disp->engine.subdev.inth);
  	if (ret)
  		return ret;
 =20
@@@ -1741,6 -1717,7 +1717,7 @@@ r535_disp_new(const struct nvkm_disp_fu
  	rm->uevent =3D hw->uevent;
  	rm->sor.cnt =3D r535_sor_cnt;
  	rm->sor.new =3D r535_sor_new;
+ 	rm->gsp =3D hw->gsp;
  	rm->ramht_size =3D hw->ramht_size;
 =20
  	rm->root.oclass =3D gpu->disp.class.root;
@@@ -1782,6 -1759,8 +1759,8 @@@ r535_disp =3D=20
  	.dp =3D {
  		.get_caps =3D r535_dp_get_caps,
  		.set_indexed_link_rates =3D r535_dp_set_indexed_link_rates,
+ 		.sst =3D r535_dp_sst,
+ 		.vcpi =3D r535_dp_vcpi,
  	},
  	.chan =3D {
  		.set_pushbuf =3D r535_disp_chan_set_pushbuf,

--BcRjPkRg30TfJc73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqO05MACgkQJNaLcl1U
h9CATQf/eTmz4L9PldBgbRXKE1nOTca5dubEoc9B+iIZxzIFATgaP38XjuSdnNPC
24CNMAHj4cKDL1lR6GWBBX/12q4PxJNP5uFuTy51+20ymenrTRlyCSg3YSz7RsmR
OwucwUXHx5W0Z9MaeDgFV9WDMRdwbzOI60vx5lo36iaXo+j1sxeP2PLbqHUFR1lX
9GtbdeTPRvNKCv03zEYf98pzZMdN1PDdUACfpOHOTiqRsIiO7wxVAsPI611HEwVj
63zC4Wo+sYzlkDixyZpbkLc6KlXD6blfIoqfzlxu3ZDUOmluB8in4A8O8l5Y1wUl
XMz0TJPT9gIfQU1h13EGP4ckOg9Buw==
=vvaO
-----END PGP SIGNATURE-----

--BcRjPkRg30TfJc73--
