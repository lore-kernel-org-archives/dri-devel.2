Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF91C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB3A10E48B;
	Fri, 17 Jul 2026 14:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oQcGfCg8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B97210E48B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:40:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E685541214;
 Fri, 17 Jul 2026 14:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D73D1F00A3A;
 Fri, 17 Jul 2026 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784299234;
 bh=0Ja6Txckzv422OY7TXVGjpXfQvAcNQG+dwgoP+3B8ho=;
 h=Date:From:To:Cc:Subject;
 b=oQcGfCg8aA00L4zX6F+OTVU99Us/U0zFtGSWEGO6sjjpq1ThJ5Xz6HOV+T3qmLzWP
 jj6gXhNx0FycFClMFrkiZtVsSTDP7uxoltWjhA0siOeHWEPjGB2zchmTiUVjwX8AZX
 rl+6hlM0f83Yi8OCs7H+8DKCrMlGIMXAjptBNp24ivO+9HIcudBHg2gjyBEKFLcg/H
 ROWxWFDyYmCjOujil3w2wzhvx9vUdKA3/81njsJAkCpGdMTdC+Y0Ta1BsQ9qBPSGVW
 UABKcoycWhLj2BixAidEdxcoFTp1Lv/Jc/WhSpyj3qRtgW4oBzk7qkKuhsTvEjNWPW
 7TYtXXyrkT5vw==
Date: Fri, 17 Jul 2026 15:40:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <alo-3o3jWIAqs2ao@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XFT8V/N11vWBBOo0"
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


--XFT8V/N11vWBBOo0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

between commit:

  8ad5ab4da7db2 ("drm/amdgpu: Disable PCIe dynamic speed switching on Ryzen=
 Pinnacle Ridge")

=66rom the drm-fixes tree and commits:

  9ceb4e034a327 ("drm/amdgpu: Disable PCIe dynamic speed switching on Ryzen=
 Pinnacle Ridge")
  a57c68224d739 ("drm/amd: Move dynamic PCIe switching quirks to X86_MATCH_=
* macros")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e5f26e5892bac,472e96ae884e5..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@@ -72,8 -72,10 +72,10 @@@
 =20
  #include "amdgpu_xgmi.h"
  #include "amdgpu_ras.h"
+ #include "amdgpu_wb.h"
  #include "amdgpu_ras_mgr.h"
  #include "amdgpu_pmu.h"
+ #include "amdgpu_smu.h"
  #include "amdgpu_fru_eeprom.h"
  #include "amdgpu_reset.h"
  #include "amdgpu_virt.h"
@@@ -1005,109 -1007,6 +1007,6 @@@ int amdgpu_device_pci_reset(struct amdg
  	return pci_reset_function(adev->pdev);
  }
 =20
- /*
-  * amdgpu_device_wb_*()
-  * Writeback is the method by which the GPU updates special pages in memo=
ry
-  * with the status of certain GPU events (fences, ring pointers,etc.).
-  */
-=20
- /**
-  * amdgpu_device_wb_fini - Disable Writeback and free memory
-  *
-  * @adev: amdgpu_device pointer
-  *
-  * Disables Writeback and frees the Writeback memory (all asics).
-  * Used at driver shutdown.
-  */
- static void amdgpu_device_wb_fini(struct amdgpu_device *adev)
- {
- 	if (adev->wb.wb_obj) {
- 		amdgpu_bo_free_kernel(&adev->wb.wb_obj,
- 				      &adev->wb.gpu_addr,
- 				      (void **)&adev->wb.wb);
- 		adev->wb.wb_obj =3D NULL;
- 	}
- }
-=20
- /**
-  * amdgpu_device_wb_init - Init Writeback driver info and allocate memory
-  *
-  * @adev: amdgpu_device pointer
-  *
-  * Initializes writeback and allocates writeback memory (all asics).
-  * Used at driver startup.
-  * Returns 0 on success or an -error on failure.
-  */
- static int amdgpu_device_wb_init(struct amdgpu_device *adev)
- {
- 	int r;
-=20
- 	if (adev->wb.wb_obj =3D=3D NULL) {
- 		/* AMDGPU_MAX_WB * sizeof(uint32_t) * 8 =3D AMDGPU_MAX_WB 256bit slots =
*/
- 		r =3D amdgpu_bo_create_kernel(adev, AMDGPU_MAX_WB * sizeof(uint32_t) * =
8,
- 					    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
- 					    &adev->wb.wb_obj, &adev->wb.gpu_addr,
- 					    (void **)&adev->wb.wb);
- 		if (r) {
- 			dev_warn(adev->dev, "(%d) create WB bo failed\n", r);
- 			return r;
- 		}
-=20
- 		adev->wb.num_wb =3D AMDGPU_MAX_WB;
- 		memset(&adev->wb.used, 0, sizeof(adev->wb.used));
-=20
- 		/* clear wb memory */
- 		memset((char *)adev->wb.wb, 0, AMDGPU_MAX_WB * sizeof(uint32_t) * 8);
- 	}
-=20
- 	return 0;
- }
-=20
- /**
-  * amdgpu_device_wb_get - Allocate a wb entry
-  *
-  * @adev: amdgpu_device pointer
-  * @wb: wb index
-  *
-  * Allocate a wb slot for use by the driver (all asics).
-  * Returns 0 on success or -EINVAL on failure.
-  */
- int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
- {
- 	unsigned long flags, offset;
-=20
- 	spin_lock_irqsave(&adev->wb.lock, flags);
- 	offset =3D find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
- 	if (offset < adev->wb.num_wb) {
- 		__set_bit(offset, adev->wb.used);
- 		spin_unlock_irqrestore(&adev->wb.lock, flags);
- 		*wb =3D offset << 3; /* convert to dw offset */
- 		return 0;
- 	} else {
- 		spin_unlock_irqrestore(&adev->wb.lock, flags);
- 		return -EINVAL;
- 	}
- }
-=20
- /**
-  * amdgpu_device_wb_free - Free a wb entry
-  *
-  * @adev: amdgpu_device pointer
-  * @wb: wb index
-  *
-  * Free a wb slot allocated for use by the driver (all asics)
-  */
- void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
- {
- 	unsigned long flags;
-=20
- 	wb >>=3D 3;
- 	spin_lock_irqsave(&adev->wb.lock, flags);
- 	if (wb < adev->wb.num_wb)
- 		__clear_bit(wb, adev->wb.used);
- 	spin_unlock_irqrestore(&adev->wb.lock, flags);
- }
-=20
  /**
   * amdgpu_device_resize_fb_bar - try to resize FB BAR
   *
@@@ -1304,37 -1203,44 +1203,44 @@@ bool amdgpu_device_seamless_boot_suppor
  	return amdgpu_ip_version(adev, DCE_HWIP, 0) >=3D IP_VERSION(3, 0, 0);
  }
 =20
- /*
-  * Intel hosts such as Rocket Lake, Alder Lake, Raptor Lake and Sapphire =
Rapids
-  * don't support dynamic speed switching. Until we have confirmation from=
 Intel
-  * that a specific host supports it, it's safer that we keep it disabled =
for all.
-  *
-  * https://edc.intel.com/content/www/us/en/design/products/platforms/deta=
ils/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/0=
05/pci-express-support/
-  * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
-  */
- static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_=
device *adev)
- {
  #if IS_ENABLED(CONFIG_X86)
- 	struct cpuinfo_x86 *c =3D &cpu_data(0);
-=20
- 	/* eGPU change speeds based on USB4 fabric conditions */
- 	if (dev_is_removable(adev->dev))
- 		return true;
-=20
- 	if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)
- 		return false;
-=20
+ static const struct x86_cpu_id amdgpu_pcie_dynamic_switching_quirks[] =3D=
 {
+ 	/*
+ 	 * Intel hosts such as Rocket Lake, Alder Lake, Raptor Lake and Sapphire=
 Rapids
+ 	 * don't support dynamic speed switching. Until we have confirmation fro=
m Intel
+ 	 * that a specific host supports it, it's safer that we keep it disabled=
 for all.
+ 	 *
+ 	 * https://edc.intel.com/content/www/us/en/design/products/platforms/det=
ails/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/=
005/pci-express-support/
+ 	 * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+ 	 */
+ 	X86_MATCH_VENDOR_FAM(INTEL, X86_FAMILY_ANY, NULL),
  	/*
  	 * AMD Ryzen Pinnacle Ridge (Zen+, family 0x17 model 0x08) CPUs don't
  	 * support PCIe dynamic speed switching.
  	 * https://gitlab.freedesktop.org/drm/amd/-/work_items/5436
  	 */
- 	if (c->x86_vendor =3D=3D X86_VENDOR_AMD && c->x86 =3D=3D 0x17 &&
- 	    c->x86_model =3D=3D 0x08)
+ 	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x08, NULL),
+ 	{}
+ };
+=20
+ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_=
device *adev)
+ {
+ 	/* eGPU change speeds based on USB4 fabric conditions */
+ 	if (dev_is_removable(adev->dev))
+ 		return true;
+=20
+ 	/* Hosts have problems with dynamic speed switching */
+ 	if (x86_match_cpu(amdgpu_pcie_dynamic_switching_quirks))
  		return false;
- #endif
+=20
  	return true;
  }
+ #else
+ static inline bool amdgpu_device_pcie_dynamic_switching_supported(struct =
amdgpu_device *adev)
+ {
+ 	return true;
+ }
+ #endif
 =20
  static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
  {
@@@ -2140,6 -2046,8 +2046,8 @@@ static int amdgpu_device_ip_early_init(
  	adev->cg_flags &=3D amdgpu_cg_mask;
  	adev->pg_flags &=3D amdgpu_pg_mask;
 =20
+ 	amdgpu_smu_early_init(adev);
+=20
  	return 0;
  }
 =20
@@@ -2380,10 -2288,10 +2288,10 @@@ static int amdgpu_device_ip_init(struc
  					r);
  				goto init_failed;
  			}
- 			r =3D amdgpu_device_wb_init(adev);
+ 			r =3D amdgpu_wb_init(adev);
  			if (r) {
  				dev_err(adev->dev,
- 					"amdgpu_device_wb_init failed %d\n", r);
+ 					"amdgpu_wb_init failed %d\n", r);
  				goto init_failed;
  			}
  			adev->ip_blocks[i].status.hw =3D true;
@@@ -2915,7 -2823,7 +2823,7 @@@ static int amdgpu_device_ip_fini(struc
  		if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TYPE_GMC) {
  			amdgpu_ucode_free_bo(adev);
  			amdgpu_free_static_csa(&adev->virt.csa_obj);
- 			amdgpu_device_wb_fini(adev);
+ 			amdgpu_wb_fini(adev);
  			amdgpu_device_mem_scratch_fini(adev);
  			amdgpu_ib_pool_fini(adev);
  			amdgpu_seq64_fini(adev);
@@@ -3687,6 -3595,10 +3595,10 @@@ static void amdgpu_device_sys_interface
  		amdgpu_pm_sysfs_fini(adev);
  	if (adev->ucode_sysfs_en)
  		amdgpu_ucode_sysfs_fini(adev);
+=20
+ 	amdgpu_discovery_sysfs_fini(adev);
+ 	amdgpu_preempt_mgr_sysfs_fini(adev);
+=20
  	amdgpu_device_attr_sysfs_fini(adev);
  	amdgpu_fru_sysfs_fini(adev);
 =20
@@@ -3783,6 -3695,7 +3695,7 @@@ int amdgpu_device_init(struct amdgpu_de
 =20
  	spin_lock_init(&adev->irq.lock);
 =20
+ 	amdgpu_early_init_rlc_reg_funcs(adev);
  	amdgpu_device_init_apu_flags(adev);
 =20
  	r =3D amdgpu_device_check_arguments(adev);
@@@ -4218,6 -4131,7 +4131,7 @@@ void amdgpu_device_fini_hw(struct amdgp
 =20
  	if (adev->mman.initialized)
  		drain_workqueue(adev->mman.bdev.wq);
+=20
  	adev->shutdown =3D true;
 =20
  	unregister_pm_notifier(&adev->pm_nb);
@@@ -4716,161 -4630,6 +4630,6 @@@ exit
  	return 0;
  }
 =20
- /**
-  * amdgpu_device_ip_check_soft_reset - did soft reset succeed
-  *
-  * @adev: amdgpu_device pointer
-  *
-  * The list of all the hardware IPs that make up the asic is walked and
-  * the check_soft_reset callbacks are run.  check_soft_reset determines
-  * if the asic is still hung or not.
-  * Returns true if any of the IPs are still in a hung state, false if not.
-  */
- static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
- {
- 	int i;
- 	bool asic_hang =3D false;
-=20
- 	if (amdgpu_sriov_vf(adev))
- 		return true;
-=20
- 	if (amdgpu_asic_need_full_reset(adev))
- 		return true;
-=20
- 	for (i =3D 0; i < adev->num_ip_blocks; i++) {
- 		if (!adev->ip_blocks[i].status.valid)
- 			continue;
- 		if (adev->ip_blocks[i].version->funcs->check_soft_reset)
- 			adev->ip_blocks[i].status.hang =3D
- 				adev->ip_blocks[i].version->funcs->check_soft_reset(
- 					&adev->ip_blocks[i]);
- 		if (adev->ip_blocks[i].status.hang) {
- 			dev_info(adev->dev, "IP block:%s is hung!\n", adev->ip_blocks[i].versi=
on->funcs->name);
- 			asic_hang =3D true;
- 		}
- 	}
- 	return asic_hang;
- }
-=20
- /**
-  * amdgpu_device_ip_pre_soft_reset - prepare for soft reset
-  *
-  * @adev: amdgpu_device pointer
-  *
-  * The list of all the hardware IPs that make up the asic is walked and t=
he
-  * pre_soft_reset callbacks are run if the block is hung.  pre_soft_reset
-  * handles any IP specific hardware or software state changes that are
-  * necessary for a soft reset to succeed.
-  * Returns 0 on success, negative error code on failure.
-  */
- static int amdgpu_device_ip_pre_soft_reset(struct amdgpu_device *adev)
- {
- 	int i, r =3D 0;
-=20
- 	for (i =3D 0; i < adev->num_ip_blocks; i++) {
- 		if (!adev->ip_blocks[i].status.valid)
- 			continue;
- 		if (adev->ip_blocks[i].status.hang &&
- 		    adev->ip_blocks[i].version->funcs->pre_soft_reset) {
- 			r =3D adev->ip_blocks[i].version->funcs->pre_soft_reset(&adev->ip_bloc=
ks[i]);
- 			if (r)
- 				return r;
- 		}
- 	}
-=20
- 	return 0;
- }
-=20
- /**
-  * amdgpu_device_ip_need_full_reset - check if a full asic reset is needed
-  *
-  * @adev: amdgpu_device pointer
-  *
-  * Some hardware IPs cannot be soft reset.  If they are hung, a full gpu
-  * reset is necessary to recover.
-  * Returns true if a full asic reset is required, false if not.
-  */
- static bool amdgpu_device_ip_need_full_reset(struct amdgpu_device *adev)
- {
- 	int i;
-=20
- 	if (amdgpu_asic_need_full_reset(adev))
- 		return true;
-=20
- 	for (i =3D 0; i < adev->num_ip_blocks; i++) {
- 		if (!adev->ip_blocks[i].status.valid)
- 			continue;
- 		if ((adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TYPE_GMC) ||
- 		    (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TYPE_SMC) ||
- 		    (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TYPE_ACP) ||
- 		    (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TYPE_DCE) ||
- 		     adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TYPE_PSP) {
- 			if (adev->ip_blocks[i].status.hang) {
- 				dev_info(adev->dev, "Some block need full reset!\n");
- 				return true;
- 			}
- 		}
- 	}
- 	return false;
- }
-=20
- /**
-  * amdgpu_device_ip_soft_reset - do a soft reset
-  *
-  * @adev: amdgpu_device pointer
-  *
-  * The list of all the hardware IPs that make up the asic is walked and t=
he
-  * soft_reset callbacks are run if the block is hung.  soft_reset handles=
 any
-  * IP specific hardware or software state changes that are necessary to s=
oft
-  * reset the IP.
-  * Returns 0 on success, negative error code on failure.
-  */
- static int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev)
- {
- 	int i, r =3D 0;
-=20
- 	for (i =3D 0; i < adev->num_ip_blocks; i++) {
- 		if (!adev->ip_blocks[i].status.valid)
- 			continue;
- 		if (adev->ip_blocks[i].status.hang &&
- 		    adev->ip_blocks[i].version->funcs->soft_reset) {
- 			r =3D adev->ip_blocks[i].version->funcs->soft_reset(&adev->ip_blocks[i=
]);
- 			if (r)
- 				return r;
- 		}
- 	}
-=20
- 	return 0;
- }
-=20
- /**
-  * amdgpu_device_ip_post_soft_reset - clean up from soft reset
-  *
-  * @adev: amdgpu_device pointer
-  *
-  * The list of all the hardware IPs that make up the asic is walked and t=
he
-  * post_soft_reset callbacks are run if the asic was hung.  post_soft_res=
et
-  * handles any IP specific hardware or software state changes that are
-  * necessary after the IP has been soft reset.
-  * Returns 0 on success, negative error code on failure.
-  */
- static int amdgpu_device_ip_post_soft_reset(struct amdgpu_device *adev)
- {
- 	int i, r =3D 0;
-=20
- 	for (i =3D 0; i < adev->num_ip_blocks; i++) {
- 		if (!adev->ip_blocks[i].status.valid)
- 			continue;
- 		if (adev->ip_blocks[i].status.hang &&
- 		    adev->ip_blocks[i].version->funcs->post_soft_reset)
- 			r =3D adev->ip_blocks[i].version->funcs->post_soft_reset(&adev->ip_blo=
cks[i]);
- 		if (r)
- 			return r;
- 	}
-=20
- 	return 0;
- }
-=20
  /**
   * amdgpu_device_reset_sriov - reset ASIC for SR-IOV vf
   *
@@@ -5162,20 -4921,7 +4921,7 @@@ int amdgpu_device_pre_asic_reset(struc
 =20
  	/* Don't suspend on bare metal if we are not going to HW reset the ASIC =
*/
  	if (!amdgpu_sriov_vf(adev)) {
-=20
- 		if (!need_full_reset)
- 			need_full_reset =3D amdgpu_device_ip_need_full_reset(adev);
-=20
- 		if (!need_full_reset && amdgpu_gpu_recovery &&
- 		    amdgpu_device_ip_check_soft_reset(adev)) {
- 			amdgpu_device_ip_pre_soft_reset(adev);
- 			r =3D amdgpu_device_ip_soft_reset(adev);
- 			amdgpu_device_ip_post_soft_reset(adev);
- 			if (r || amdgpu_device_ip_check_soft_reset(adev)) {
- 				dev_info(adev->dev, "soft reset failed, will fallback to full reset!\=
n");
- 				need_full_reset =3D true;
- 			}
- 		}
+ 		need_full_reset =3D true;
 =20
  		if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
  			dev_info(tmp_adev->dev, "Dumping IP State\n");
@@@ -5628,8 -5374,7 +5374,7 @@@ static void amdgpu_device_halt_activiti
  		drm_client_dev_suspend(adev_to_drm(tmp_adev));
 =20
  		/* disable ras on ALL IPs */
- 		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev) &&
- 		    amdgpu_device_ip_need_full_reset(tmp_adev))
+ 		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev))
  			amdgpu_ras_suspend(tmp_adev);
 =20
  		amdgpu_userq_pre_reset(tmp_adev);
@@@ -6901,7 -6646,7 +6646,7 @@@ ssize_t amdgpu_get_soft_full_reset_mask
 =20
  	if (unlikely(!ring->adev->debug_disable_soft_recovery) &&
  	    !amdgpu_sriov_vf(ring->adev) && ring->funcs->soft_recovery)
- 		size |=3D AMDGPU_RESET_TYPE_SOFT_RESET;
+ 		size |=3D AMDGPU_RESET_TYPE_SOFT_RECOVERY;
 =20
  	return size;
  }
@@@ -6917,8 -6662,8 +6662,8 @@@ ssize_t amdgpu_show_reset_mask(char *bu
 =20
  	}
 =20
- 	if (supported_reset & AMDGPU_RESET_TYPE_SOFT_RESET)
- 		size +=3D sysfs_emit_at(buf, size, "soft ");
+ 	if (supported_reset & AMDGPU_RESET_TYPE_SOFT_RECOVERY)
+ 		size +=3D sysfs_emit_at(buf, size, "soft_recovery ");
 =20
  	if (supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
  		size +=3D sysfs_emit_at(buf, size, "queue ");

--XFT8V/N11vWBBOo0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpaPt4ACgkQJNaLcl1U
h9CFawf/V4Q/yiDjPdZMO2isK2cZM7h1lEfRS3HpEJO/VCy4/6VNYVfFgxWREPDU
dBUhoPfxuCtRpofXmig4fEFGaGAMHwj9vhzeQB2NVRD+tb68kNiJp7sdRzVgONgY
5/rxkhhgS8JpsrRe/50lojRNdHt8111WEkrsDwDefBPQNF6LYy1mPTwRpy4DcmEW
fTolRijO1O8ayiDmfvtNvqWS9dZAncWOIcmDbwrIiaSaSvJiBj4YO06hKh8XKFHF
MNRT13yQj1rbqDhIY3Qwgb40BWCgLVY/4nvPR+nOYu4Lg9vxtBJ64rjkuf7qPJDb
D1xv074u0oU04AencOLnDYiFX1vdDw==
=xgYa
-----END PGP SIGNATURE-----

--XFT8V/N11vWBBOo0--
