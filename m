Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86E3F4613D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13EB610E429;
	Mon, 23 Mar 2026 15:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MJE1IymS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4478B10E467
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:55:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E33360103;
 Mon, 23 Mar 2026 15:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768FFC4CEF7;
 Mon, 23 Mar 2026 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774281329;
 bh=ULBWExFXSPRBaksWSelAuKTDofOa5iKEHT/IaLGaDvQ=;
 h=Date:From:To:Cc:Subject:From;
 b=MJE1IymSa2VxP4J/dHB5JHdpxH/nXehKd5yLcK+ChKJFIBnin1t1luGdifPcRuRCn
 x/ACadwOkINaNpU1u7rLXos8po2PjjacOtntwHi1r4UuDJi1tOGalFiWZJ+Y+52A+Q
 FwlGZj4fhbPtRkn5L76T88GVk3V4e6ViWQjldIj64pJZjIySWdBTYJrFksl80UIhYt
 90J3Ew40spfXyVxV1s0csl/3MqtHtideiev+uwnLVhA/npvmqNHgBj34ZMKRf/XATk
 Sy89kihZEnam28MrEERd7ApGO5NUAtS305Ed+MoOicQIPq5yiDir339k7ede1jxSvu
 5sDcIrB4mjf2Q==
Date: Mon, 23 Mar 2026 15:55:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <acFibFyDdy_qrRys@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eEiGK7RTlGjP2+tG"
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


--eEiGK7RTlGjP2+tG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/xe/xe_ggtt.c

between commit:

  01f2557aa684e ("drm/xe: Open-code GGTT MMIO access protection")

=66rom the origin tree and commit:

  e904c56ba6e0d ("drm/xe: Rewrite GGTT VF initialization")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/xe/xe_ggtt.c
index d1561ebe4e56c,0f2e3af499120..0000000000000
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@@ -379,18 -437,7 +439,8 @@@ int xe_ggtt_init_early(struct xe_ggtt *
  	if (err)
  		return err;
 =20
 +	ggtt->flags |=3D XE_GGTT_FLAGS_ONLINE;
- 	err =3D devm_add_action_or_reset(xe->drm.dev, dev_fini_ggtt, ggtt);
- 	if (err)
- 		return err;
-=20
- 	if (IS_SRIOV_VF(xe)) {
- 		err =3D xe_tile_sriov_vf_prepare_ggtt(ggtt->tile);
- 		if (err)
- 			return err;
- 	}
-=20
- 	return 0;
+ 	return devm_add_action_or_reset(xe->drm.dev, dev_fini_ggtt, ggtt);
  }
  ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); /* See xe_pci_probe() */
 =20
@@@ -413,12 -465,15 +468,12 @@@ static void ggtt_node_fini(struct xe_gg
  static void ggtt_node_remove(struct xe_ggtt_node *node)
  {
  	struct xe_ggtt *ggtt =3D node->ggtt;
 -	struct xe_device *xe =3D tile_to_xe(ggtt->tile);
  	bool bound;
 -	int idx;
 -
 -	bound =3D drm_dev_enter(&xe->drm, &idx);
 =20
  	mutex_lock(&ggtt->lock);
 +	bound =3D ggtt->flags & XE_GGTT_FLAGS_ONLINE;
  	if (bound)
- 		xe_ggtt_clear(ggtt, node->base.start, node->base.size);
+ 		xe_ggtt_clear(ggtt, xe_ggtt_node_addr(node), xe_ggtt_node_size(node));
  	drm_mm_remove_node(&node->base);
  	node->base.size =3D 0;
  	mutex_unlock(&ggtt->lock);
@@@ -429,8 -484,10 +484,8 @@@
  	if (node->invalidate_on_remove)
  		xe_ggtt_invalidate(ggtt);
 =20
 -	drm_dev_exit(idx);
 -
  free_node:
- 	xe_ggtt_node_fini(node);
+ 	ggtt_node_fini(node);
  }
 =20
  static void ggtt_node_remove_work_func(struct work_struct *work)

--eEiGK7RTlGjP2+tG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBYmsACgkQJNaLcl1U
h9BQAQf/blEoQP2/+hLPV0sr7BRHOY+5ZlxOoqXGcVyrZtQvT58nFI4+diwVk/KR
iKDnPY47aV+1KA2cx00oI0SOyxnhc8gF8ckKs5LG/YwSCbmLaMWA935QkVUA+o+C
YEfe6bY3ancGVPj3pKtLYzBkTTQhgpevbC8osQz4MhbwhB6i177HHbJcqAmXrjc0
xhYzS9ncqaC3RHDrZlMadcHYQLN5M5lVAAJYWKy06fSCIqXBGx4hGFcVsZY1OcOU
E+MBoeMWo7a27N7xyw9LwSaMUml4QSyVOn08Nt9YI3iwm6zqpzUHIBiKf3G9nAg5
r9uGDPfCPukKWUEPOjSwvZbAGSPJQQ==
=0xMP
-----END PGP SIGNATURE-----

--eEiGK7RTlGjP2+tG--
