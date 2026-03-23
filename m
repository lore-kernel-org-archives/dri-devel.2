Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9349F4613C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2708310E4A6;
	Mon, 23 Mar 2026 15:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="klu2AOTl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD5C10E4DD
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:55:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CF4B0600CB;
 Mon, 23 Mar 2026 15:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1197C4CEF7;
 Mon, 23 Mar 2026 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774281339;
 bh=wHzaRl+PH4iWK+jpXaqEHqAp1wRSlwfsE0mEj9+UiRs=;
 h=Date:From:To:Cc:Subject:From;
 b=klu2AOTl43S6BkI2DPD7hK74g/CgvZrMBISIIvo/HV4VoUMrT12KexibKJzK2vNW6
 3NnKfS1MTT0Z4iLlE256HYhSc8OGxzu+fn/AG0RShZ5jzD9ns/RtKCv9W4mzx8CDRz
 93NpiThgZBeC22IaEofdspQaYfHGp3Ne3oNaUL5ssP2AgaQjzNvJNOQMUeuY6C9Ifh
 81bnHATnJKCCdNnxeZC846z38rcDB6OQJsiiypAbDFsauhzs3vRGNEb6Mc5jD50E+u
 B8sjUajDrbI9TwdqybiJr/LhyFzsczGSk333QW2sZo+tbRdFEwumDzBkchp3BpR9jC
 spVtuHUPgJJzw==
Date: Mon, 23 Mar 2026 15:55:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Nareshkumar Gollakoti <naresh.kumar.g@intel.com>,
 Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <acFid74H4aSWfrBg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WhwODcKUFgG2HqjC"
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


--WhwODcKUFgG2HqjC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/xe/xe_gt_ccs_mode.c

between commit:

  65d046b2d8e0d ("drm/xe: Fix missing runtime PM reference in ccs_mode_stor=
e")

=66rom the origin tree and commit:

  9b5e995e61290 ("drm/xe: Mutual exclusivity between CCS-mode and PF")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/xe/xe_gt_ccs_mode.c
index 03c1862ba497a,b35be36b0eaa2..0000000000000
--- a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
+++ b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
@@@ -12,8 -12,8 +12,9 @@@
  #include "xe_gt_printk.h"
  #include "xe_gt_sysfs.h"
  #include "xe_mmio.h"
 +#include "xe_pm.h"
  #include "xe_sriov.h"
+ #include "xe_sriov_pf.h"
 =20
  static void __xe_gt_apply_ccs_mode(struct xe_gt *gt, u32 num_engines)
  {
@@@ -147,15 -145,29 +146,30 @@@ ccs_mode_store(struct device *kdev, str
  		return -EBUSY;
  	}
 =20
- 	if (gt->ccs_mode !=3D num_engines) {
- 		xe_gt_info(gt, "Setting compute mode to %d\n", num_engines);
- 		gt->ccs_mode =3D num_engines;
- 		xe_gt_record_user_engines(gt);
- 		guard(xe_pm_runtime)(xe);
- 		xe_gt_reset(gt);
+ 	if (gt->ccs_mode =3D=3D num_engines)
+ 		return count;
+=20
+ 	/*
+ 	 * Changing default CCS mode is only allowed when there
+ 	 * are no VFs. Try to lockdown PF to find out.
+ 	 */
+ 	if (gt_ccs_mode_default(gt) && IS_SRIOV_PF(xe)) {
+ 		ret =3D xe_sriov_pf_lockdown(xe);
+ 		if (ret) {
+ 			xe_gt_dbg(gt, "Can't change CCS Mode: VFs are enabled\n");
+ 			return ret;
+ 		}
  	}
 =20
- 	mutex_unlock(&xe->drm.filelist_mutex);
+ 	xe_gt_info(gt, "Setting compute mode to %d\n", num_engines);
+ 	gt->ccs_mode =3D num_engines;
+ 	xe_gt_record_user_engines(gt);
++	guard(xe_pm_runtime)(xe);
+ 	xe_gt_reset(gt);
+=20
+ 	/* We may end PF lockdown once CCS mode is default again */
+ 	if (gt_ccs_mode_default(gt) && IS_SRIOV_PF(xe))
+ 		xe_sriov_pf_end_lockdown(xe);
 =20
  	return count;
  }

--WhwODcKUFgG2HqjC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBYnYACgkQJNaLcl1U
h9BruQf8C+ZOaWjO01sNrbKsaYQGkI8YKrGZvrBCpwExXo/1Rwsjwq1HjNT9iqHx
m/jCTs7D80u+7GvD7NCYGsxDmChotzPbCisJofosybr6dwNMS3Uq1Q/f4L8ruqvn
CAOkVQGSxw6EeqnI+x+rKsLZgrLWNj579b1RAFi3X/7hSvTEqRUeu4e9m0h5+Hkn
pf+DxKKdvm0gKCjkZDRBG8aUvmgC5x6UJVNMDmHgZJQBTvJMp9EGgGyBuCP0idCE
UeGD2/afZac3aCT/eYEMIFDw5BLdRoO4PVq36gUBT7liEo4VOtL0OIhlI3lBrTre
m8uQvwtTCT9ayH1qRtPwyA0mbyrOOw==
=/hto
-----END PGP SIGNATURE-----

--WhwODcKUFgG2HqjC--
