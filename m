Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38BAC982DC
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8C310E5A1;
	Fri, 18 Sep 2026 11:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CGg2xmrp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8466010E5A1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:14:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50C7D4384E;
 Fri, 18 Sep 2026 11:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB33B1F000FF;
 Fri, 18 Sep 2026 11:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789730061;
 bh=vSoF6eZxSvLI0WPAvkqPvQ5N5wtMhuKEHJvL1NuT3Ew=;
 h=Date:From:To:Cc:Subject;
 b=CGg2xmrpM49QjFNnvbWTPjP6U73xQffZ+rBRhQ3/Wl7kj4skEIizFxbA8mEEi88DY
 7Q0JQkD/7VQ/1qpoprj6OzDNqTl552CGPjyMjOxq5N+ZHtEFurUg/TkncdHQ/7LGX/
 PP6BZaduNmgNLpi3I+UfbYcXE9LQl4296yrtQj2xdHjE3jAoDY5hWtJ3o3xDBwumNA
 Sx1uYAYpUZ5L0fF55jgcXhJM0ja4yAGJMUlAWilazxpGQy9jr6AGwQYme/R3mSkZl8
 b1rcnMWGaw6jrGRqIbPf+ni89uiR5Y0hV8EMRrDhHDirfiUNNW8ayft18MZ6S0OHFc
 2jsBP1VtUM9fg==
Date: Fri, 18 Sep 2026 12:14:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Lyude Paul <lyude@redhat.com>,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
 Wentao Liang <vulab@iscas.ac.cn>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes tree
Message-ID: <aq0dCW8iD494oG7j@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/RO/vh3LytLQYj4w"
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


--/RO/vh3LytLQYj4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/nouveau/nouveau_connector.c

between commit:

  1e04611d37355 ("drm/nouveau: Fix runtime PM leak in nouveau_connector_det=
ect()")

=66rom the drm-misc-fixes tree and commit:

  0116f19db5931 ("drm/nouveau: honor HF-EEODB EDIDs by converting to struct=
 drm_edid")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/nouveau/nouveau_connector.c
index 4cfc9c7c2ae0c,cc3caf8de64b0..0000000000000
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@@ -397,7 -397,8 +397,8 @@@ nouveau_connector_destroy(struct drm_co
  	struct nouveau_connector *nv_connector =3D nouveau_connector(connector);
  	nvif_event_dtor(&nv_connector->irq);
  	nvif_event_dtor(&nv_connector->hpd);
- 	kfree(nv_connector->edid);
+ 	cancel_work_sync(&nv_connector->irq_work);
+ 	drm_edid_free(nv_connector->drm_edid);
  	drm_connector_unregister(connector);
  	drm_connector_cleanup(connector);
  	if (nv_connector->aux.transfer)
@@@ -469,6 -470,36 +470,36 @@@ nouveau_connector_ddc_detect(struct drm
  	return found;
  }
 =20
+ static void
+ nouveau_connector_set_edid(struct nouveau_connector *nv_connector,
+ 			   const struct drm_edid *drm_edid)
+ {
+ 	if (nv_connector->drm_edid =3D=3D drm_edid)
+ 		return;
+=20
+ 	/* Updates the EDID property and display_info with HF-EEODB-aware
+ 	 * sizing. The legacy helpers truncate both to what EDID byte 126
+ 	 * admits, hiding the DisplayID extension blocks that carry the
+ 	 * high-refresh timings.
+ 	 */
+ 	drm_edid_connector_update(&nv_connector->base, drm_edid);
+=20
+ 	drm_edid_free(nv_connector->drm_edid);
+ 	nv_connector->drm_edid =3D drm_edid;
+=20
+ 	/* The SPWG link-count byte lives in a vendor descriptor drm has no
+ 	 * accessor for. Peek at it once here so nothing else needs the raw
+ 	 * EDID.
+ 	 */
+ 	nv_connector->spwg_links =3D 0;
+ 	if (nv_connector->type =3D=3D DCB_CONNECTOR_LVDS_SPWG) {
+ 		const u8 *raw =3D (const u8 *)drm_edid_raw(drm_edid);
+=20
+ 		if (raw)
+ 			nv_connector->spwg_links =3D raw[121] =3D=3D 2 ? 2 : 1;
+ 	}
+ }
+=20
  static struct nouveau_encoder *
  nouveau_connector_of_detect(struct drm_connector *connector)
  {
@@@ -490,8 -521,17 +521,17 @@@
  		int idx =3D name ? name[strlen(name) - 1] - 'A' : 0;
 =20
  		if (nv_encoder->dcb->i2c_index =3D=3D idx && edid) {
- 			nv_connector->edid =3D
- 				kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
+ 			const struct drm_edid *drm_edid =3D
+ 				drm_edid_alloc(edid, EDID_LENGTH);
+=20
+ 			/* Firmware-provided, so validate it like the DDC
+ 			 * readers would.
+ 			 */
+ 			if (drm_edid && !drm_edid_valid(drm_edid)) {
+ 				drm_edid_free(drm_edid);
+ 				drm_edid =3D NULL;
+ 			}
+ 			nouveau_connector_set_edid(nv_connector, drm_edid);
  			return nv_encoder;
  		}
  	}
@@@ -546,17 -586,23 +586,23 @@@ nouveau_connector_set_encoder(struct dr
  	}
  }
 =20
- static void
- nouveau_connector_set_edid(struct nouveau_connector *nv_connector,
- 			   struct edid *edid)
- {
- 	if (nv_connector->edid !=3D edid) {
- 		struct edid *old_edid =3D nv_connector->edid;
+ struct nouveau_rm_edid {
+ 	u8 *data;
+ 	size_t size;
+ };
 =20
- 		drm_connector_update_edid_property(&nv_connector->base, edid);
- 		kfree(old_edid);
- 		nv_connector->edid =3D edid;
- 	}
+ static int
+ nouveau_connector_rm_edid_block(void *context, u8 *buf, unsigned int bloc=
k,
+ 				size_t len)
+ {
+ 	struct nouveau_rm_edid *rm =3D context;
+ 	size_t offset =3D (size_t)block * EDID_LENGTH;
+=20
+ 	if (offset + len > rm->size)
+ 		return -EINVAL;
+=20
+ 	memcpy(buf, rm->data + offset, len);
+ 	return 0;
  }
 =20
  static enum drm_connector_status
@@@ -590,25 -636,37 +636,37 @@@ nouveau_connector_detect(struct drm_con
 =20
  	nv_encoder =3D nouveau_connector_ddc_detect(connector);
  	if (nv_encoder) {
- 		struct edid *new_edid =3D NULL;
+ 		const struct drm_edid *new_edid =3D NULL;
 =20
  		if (nv_encoder->i2c) {
  			if ((vga_switcheroo_handler_flags() & VGA_SWITCHEROO_CAN_SWITCH_DDC) &&
  			    nv_connector->type =3D=3D DCB_CONNECTOR_LVDS)
- 				new_edid =3D drm_get_edid_switcheroo(connector, nv_encoder->i2c);
+ 				new_edid =3D drm_edid_read_switcheroo(connector, nv_encoder->i2c);
  			else
- 				new_edid =3D drm_get_edid(connector, nv_encoder->i2c);
+ 				new_edid =3D drm_edid_read_ddc(connector, nv_encoder->i2c);
  		} else {
- 			ret =3D nvif_outp_edid_get(&nv_encoder->outp, (u8 **)&new_edid);
- 			if (ret < 0) {
- 				pm_runtime_mark_last_busy(dev->dev);
- 				pm_runtime_put_autosuspend(dev->dev);
- 				return connector_status_disconnected;
+ 			struct nouveau_rm_edid rm =3D {};
+=20
+ 			/* RM (which owns the DDC pads on GSP boards) reads the
+ 			 * EDID whole and returns its true size, which for an
+ 			 * HF-EEODB EDID exceeds what byte 126 admits. Serve it
+ 			 * through drm's block reader so EEODB sizing, block
+ 			 * validation, and the debugfs EDID override all apply.
+ 			 * A failed read is treated like an empty DDC read,
+ 			 * which releases the runtime-PM reference.
+ 			 */
+ 			ret =3D nvif_outp_edid_get(&nv_encoder->outp, &rm.data);
+ 			if (ret >=3D 0) {
+ 				rm.size =3D ret;
+ 				new_edid =3D drm_edid_read_custom(connector,
+ 								nouveau_connector_rm_edid_block,
+ 								&rm);
+ 				kfree(rm.data);
  			}
  		}
 =20
  		nouveau_connector_set_edid(nv_connector, new_edid);
- 		if (!nv_connector->edid) {
+ 		if (!nv_connector->drm_edid) {
  			NV_ERROR(drm, "DDC responded, but no EDID for %s\n",
  				 connector->name);
  			goto detect_analog;
@@@ -629,7 -687,7 +687,7 @@@
  				    nv_partner->dcb->type =3D=3D DCB_OUTPUT_TMDS) ||
  				   (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_TMDS &&
  				    nv_partner->dcb->type =3D=3D DCB_OUTPUT_ANALOG))) {
- 			if (nv_connector->edid->input & DRM_EDID_INPUT_DIGITAL)
+ 			if (drm_edid_is_digital(nv_connector->drm_edid))
  				type =3D DCB_OUTPUT_TMDS;
  			else
  				type =3D DCB_OUTPUT_ANALOG;
@@@ -641,7 -699,8 +699,8 @@@
  		conn_status =3D connector_status_connected;
 =20
  		if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_DP)
- 			drm_dp_cec_set_edid(&nv_connector->aux, nv_connector->edid);
+ 			drm_dp_cec_attach(&nv_connector->aux,
+ 					  connector->display_info.source_physical_address);
 =20
  		goto out;
  	} else {
@@@ -673,7 -732,7 +732,7 @@@ detect_analog
  	}
 =20
   out:
- 	if (!nv_connector->edid)
+ 	if (!nv_connector->drm_edid)
  		drm_dp_cec_unset_edid(&nv_connector->aux);
 =20
  	pm_runtime_mark_last_busy(dev->dev);
@@@ -689,7 -748,7 +748,7 @@@ nouveau_connector_detect_lvds(struct dr
  	struct nouveau_drm *drm =3D nouveau_drm(dev);
  	struct nouveau_connector *nv_connector =3D nouveau_connector(connector);
  	struct nouveau_encoder *nv_encoder =3D NULL;
- 	struct edid *edid =3D NULL;
+ 	const struct drm_edid *edid =3D NULL;
  	enum drm_connector_status status =3D connector_status_disconnected;
 =20
  	nv_encoder =3D find_encoder(connector, DCB_OUTPUT_LVDS);
@@@ -700,7 -759,7 +759,7 @@@
  	if (!drm->vbios.fp_no_ddc) {
  		status =3D nouveau_connector_detect(connector, force);
  		if (status =3D=3D connector_status_connected) {
- 			edid =3D nv_connector->edid;
+ 			edid =3D nv_connector->drm_edid;
  			goto out;
  		}
  	}
@@@ -736,11 -795,20 +795,20 @@@
  	 * stored for the panel stored in them.
  	 */
  	if (!drm->vbios.fp_no_ddc) {
- 		edid =3D (struct edid *)nouveau_bios_embedded_edid(dev);
- 		if (edid) {
- 			edid =3D kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
+ 		const void *embedded =3D nouveau_bios_embedded_edid(dev);
+=20
+ 		if (embedded) {
+ 			edid =3D drm_edid_alloc(embedded, EDID_LENGTH);
+ 			/* The panel is there either way, so report it
+ 			 * connected and let the probe helper fall back to a
+ 			 * default mode if the EDID itself is unusable.
+ 			 */
  			if (edid)
  				status =3D connector_status_connected;
+ 			if (edid && !drm_edid_valid(edid)) {
+ 				drm_edid_free(edid);
+ 				edid =3D NULL;
+ 			}
  		}
  	}
 =20
@@@ -889,7 -957,7 +957,7 @@@ nouveau_connector_detect_depth(struct d
  	bool duallink;
 =20
  	/* if the edid is feeling nice enough to provide this info, use it */
- 	if (nv_connector->edid && connector->display_info.bpc)
+ 	if (nv_connector->drm_edid && connector->display_info.bpc)
  		return;
 =20
  	/* EDID 1.4 is *supposed* to be supported on eDP, but, Apple... */
@@@ -916,9 -984,8 +984,8 @@@
  	/* LVDS: DDC panel, need to first determine the number of links to
  	 * know which if_is_24bit flag to check...
  	 */
- 	if (nv_connector->edid &&
- 	    nv_connector->type =3D=3D DCB_CONNECTOR_LVDS_SPWG)
- 		duallink =3D ((u8 *)nv_connector->edid)[121] =3D=3D 2;
+ 	if (nv_connector->spwg_links)
+ 		duallink =3D nv_connector->spwg_links =3D=3D 2;
  	else
  		duallink =3D mode->clock >=3D bios->fp.duallink_transition_clk;
 =20
@@@ -976,12 -1043,17 +1043,17 @@@ nouveau_connector_get_modes(struct drm_
  		nv_connector->native_mode =3D NULL;
  	}
 =20
- 	if (nv_connector->edid)
- 		ret =3D drm_add_edid_modes(connector, nv_connector->edid);
- 	else
- 	if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_LVDS &&
- 	    (nv_encoder->dcb->lvdsconf.use_straps_for_mode ||
- 	     drm->vbios.fp_no_ddc) && nouveau_bios_fp_mode(dev, NULL)) {
+ 	if (nv_connector->drm_edid) {
+ 		/* The probe helper clears the property and display_info for
+ 		 * a forced-off connector without calling detect(). Re-sync
+ 		 * from our copy then, since add_modes() reads the property.
+ 		 */
+ 		if (!connector->edid_blob_ptr)
+ 			drm_edid_connector_update(connector, nv_connector->drm_edid);
+ 		ret =3D drm_edid_connector_add_modes(connector);
+ 	} else if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_LVDS &&
+ 		   (nv_encoder->dcb->lvdsconf.use_straps_for_mode ||
+ 		    drm->vbios.fp_no_ddc) && nouveau_bios_fp_mode(dev, NULL)) {
  		struct drm_display_mode mode;
 =20
  		nouveau_bios_fp_mode(dev, &mode);

--/RO/vh3LytLQYj4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqtHQgACgkQJNaLcl1U
h9DHrAf/Y+XRmHgIeLlRq7ypu95kkOefOOlyhXX0FBgq9ALfcmcezNBfxj0S8DGG
+lGFtJGPGLR13ovJui+NC17n2oFqcfT7kTggx1sIzeKrB6XuTE6zeuH5pTQuSMel
fjC9TDIe+gh5dhPF8k9BmNTdBEr+sh3SsFO5BRgPZfaxnJ6gfUHxJgdf6bvUWej7
nkEKjl3iXCzTe0D6OwEt7Aq1WZNcLVFm/SFQknh1iTBMDSPl8uBazPhtnGRUL2C2
WsGF4kqBT83uAh2UCEe550S2gLYIxrwNUn7V0pDKofuxBweFkRcjGePINZmEgVOu
GbdXZ6LjvBE9Bv2Cb2IzAm1NjPAbBw==
=VQDw
-----END PGP SIGNATURE-----

--/RO/vh3LytLQYj4w--
