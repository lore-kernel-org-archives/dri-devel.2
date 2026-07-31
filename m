Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC380C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F91910F276;
	Fri, 31 Jul 2026 14:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KggttOVB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A94D810F29C
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:01:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FB0A4178B;
 Fri, 31 Jul 2026 14:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0264B1F00A3A;
 Fri, 31 Jul 2026 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785506490;
 bh=0/2dhS8PknrX0sQZIwFDGsl/5PFR1Z2/ult7Fbl6HoY=;
 h=Date:From:To:Cc:Subject;
 b=KggttOVBpPhbw+fV95VEXLjNtAalqs5ZzmxK6UcPpYKZlOnJtuSTAliu5hPbS4JyN
 afR0QjdzKlr04+ZBFcUBmV3uLip3n4LPvR42YhI8IAAmXQYyFE4iUM0M2UjT6TI/OR
 k6QakWM/uUHuFoH4t1kvvRTV1CdPgAwZBEq7htxsKbdJWae5MC0JjQKnrpIvfC3Dvd
 7msslDb+z9JATWbwqZl56lC4YaPGIqsz1acfcoCvijazRz1UNyKoIz0GUnVDwC5N0a
 hFNjXY5nxW9dVTz0r3mNe6xLUGfOSuCLAx6SYErTzhYX9pveKCpI8AXky814vEGqLF
 7Ttgtzgq48A/w==
Date: Fri, 31 Jul 2026 15:01:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <amyqtk0a9vLP4Zu-@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MmhSx7XsVUWz7dfO"
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


--MmhSx7XsVUWz7dfO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/pm/amdgpu_dpm.c

between commits:

  bb493058c35c8 ("drm/amd/pm: fix pptable use-after-free")
  a65f5179d3f0c ("drm/amd/pm: hide pp_table sysfs on APUs")

=66rom the drm-fixes tree and commit:

  b0ae60ea3f3f1 ("drm/amdgpu: Resolve VM through DRM PASID ownership")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index e5e89294958a8,8f59ea12fe0ea..0000000000000
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@@ -1183,13 -1183,6 +1183,16 @@@ int amdgpu_dpm_dispatch_task(struct amd
  	return ret;
  }
 =20
++<<<<<<< HEAD
 +static bool amdgpu_dpm_is_pp_table_allowed(struct amdgpu_device *adev)
 +{
 +	return !amdgpu_sriov_vf(adev) &&
 +	       !(adev->flags & AMD_IS_APU) &&
 +	       !adev->scpm_enabled;
 +}
 +
++=3D=3D=3D=3D=3D=3D=3D
++>>>>>>> drm/drm-next
  int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
  			    size_t size)
  {
@@@ -1200,8 -1193,7 +1203,8 @@@
  	if ((!table && size) || (table && !size))
  		return -EINVAL;
 =20
 -	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabl=
ed)
 +	if (!amdgpu_dpm_is_pp_table_allowed(adev) ||
 +	    !pp_funcs->get_pp_table)
  		return -EOPNOTSUPP;
 =20
  	mutex_lock(&adev->pm.mutex);
@@@ -1725,8 -1717,7 +1728,8 @@@ int amdgpu_dpm_set_pp_table(struct amdg
  	if (!buf || !size)
  		return -EINVAL;
 =20
 -	if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_enabl=
ed)
 +	if (!amdgpu_dpm_is_pp_table_allowed(adev) ||
 +	    !pp_funcs->set_pp_table)
  		return -EOPNOTSUPP;
 =20
  	mutex_lock(&adev->pm.mutex);
@@@ -2133,10 -2124,3 +2136,3 @@@ ssize_t amdgpu_dpm_get_xcp_metrics(stru
 =20
  	return ret;
  }
-=20
- const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_dev=
ice *adev)
- {
- 	void *pp_handle =3D adev->powerplay.pp_handle;
-=20
- 	return smu_get_ras_smu_driver(pp_handle);
- }

--MmhSx7XsVUWz7dfO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpsqrUACgkQJNaLcl1U
h9AMxAf/Wcuf8AqPNSGLyMiyKfG89DM5CGWJGm+B6uQkSsnaIdnpxrGLjxMwdVvW
slxKYePiTrLDsqnPjsf/eDiT3X7RS4Z11cISyORRqBXhKylIk4q3W/9Z14OcJk2M
c8SypC79XB0YNUNIqFIAJBOFhLlLfdf8oHDdzOjoOyVon3aoOY1yxCM3BLoSs9Hx
uHohlLtUpcyN3Me1nyBEKXRcp7U4RGZDThHOYrG7suWP5KjI2KZno9hr9C6nWrYd
PJqQHZZGtm8zQp5cCtDyHHXhZz1NiQxTppiApchyKqDXD6lmpZ/sjRgWFmMVsUEG
wRaNRutn6OEpXyS1LUJNlw6lka+nmQ==
=b5wi
-----END PGP SIGNATURE-----

--MmhSx7XsVUWz7dfO--
