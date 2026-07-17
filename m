Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE601C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556EB10E488;
	Fri, 17 Jul 2026 14:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BSWz+Qlv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9A710E488
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:41:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 45FC440B49;
 Fri, 17 Jul 2026 14:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538B71F000E9;
 Fri, 17 Jul 2026 14:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784299265;
 bh=K/BRkWxDJI8Kh5sczuL4DQbT4oWat23rlDExPcifJzo=;
 h=Date:From:To:Cc:Subject;
 b=BSWz+QlvL9gsyu8eTwHPW+wi2x08zt6EIfvXw6CRUCjS2Gtr2BUhLYZvuvXIBbWkz
 We3k5E58iZd6QqQ4SWYd96nP33WZQUgkg60D1P1Xg7//7Fbx3y4H2QXvpN2FLfMQ0F
 ZOJZQJA8hvf4SlpnEe8KWF+XF2tZk6apOVkxniJF2o2tjKpw2P90DUNgYTrrFEtzSU
 ypdHIR8irnY/tb/BwV1BBYTV8iHT7HcaN82/1EWBFHDYf8bGFnfHa5uivuXszOt9Bx
 WtqGB/k6ONUhR99Zf93tiSDBWHLDIJOYTu6tmlHYa1AZhRtrnrspuz68/e44WMrZcm
 RiomJ3VHLE0+w==
Date: Fri, 17 Jul 2026 15:41:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Ce Sun <cesun102@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Yang Wang <kevinyang.wang@amd.com>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <alo-_M1a8v-NN3CM@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uzW1W57Wu56gyMt/"
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


--uzW1W57Wu56gyMt/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h

between commit:

  6e4bc34568e38 ("drm/amd: Create a device link between APU display and XHC=
I devices")

=66rom the drm-fixes tree and commits:

  07c93d7eeb0d9 ("drm/amd: Create a device link between APU display and XHC=
I devices")
  958430a1f068f ("drm/amd/pm: retire legacy smu ras driver framework")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index e3a89e9a9df41,7ea7c4a5279be..0000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@@ -852,8 -852,6 +852,6 @@@ struct pptable_funcs=20
  	 */
  	int (*set_default_dpm_table)(struct smu_context *smu);
 =20
- 	int (*set_power_state)(struct smu_context *smu);
-=20
  	/**
  	 * @populate_umd_state_clk: Populate the UMD power state table with
  	 *                          defaults.
@@@ -906,16 -904,6 +904,6 @@@
  					      struct
  					      pp_clock_levels_with_latency
  					      *clocks);
- 	/**
- 	 * @get_clock_by_type_with_voltage: Get the speed and voltage of a clock
- 	 *                                  domain.
- 	 */
- 	int (*get_clock_by_type_with_voltage)(struct smu_context *smu,
- 					      enum amd_pp_clock_type type,
- 					      struct
- 					      pp_clock_levels_with_voltage
- 					      *clocks);
-=20
  	/**
  	 * @get_power_profile_mode: Print all power profile modes to
  	 *                          buffer. Star current mode.
@@@ -1357,11 -1345,6 +1345,6 @@@
  	 */
  	int (*register_irq_handler)(struct smu_context *smu);
 =20
- 	/**
- 	 * @set_azalia_d3_pme: Wake the audio decode engine from d3 sleep.
- 	 */
- 	int (*set_azalia_d3_pme)(struct smu_context *smu);
-=20
  	/**
  	 * @get_max_sustainable_clocks_by_dc: Get a copy of the max sustainable
  	 *                                    clock speeds table.
@@@ -1378,18 -1361,6 +1361,6 @@@
  	 */
  	int (*get_bamaco_support)(struct smu_context *smu);
 =20
- 	/**
- 	 * @baco_get_state: Get the current BACO state.
- 	 *
- 	 * Return: Current BACO state.
- 	 */
- 	enum smu_baco_state (*baco_get_state)(struct smu_context *smu);
-=20
- 	/**
- 	 * @baco_set_state: Enter/exit BACO.
- 	 */
- 	int (*baco_set_state)(struct smu_context *smu, enum smu_baco_state state=
);
-=20
  	/**
  	 * @baco_enter: Enter BACO.
  	 */
@@@ -1651,12 -1622,6 +1622,6 @@@
  	int (*ras_send_msg)(struct smu_context *smu,
  			    enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
 =20
- 	/**
- 	 * @get_ras_smu_drv: Get RAS smu driver interface
- 	 * Return: ras_smu_drv *
- 	 */
- 	int (*get_ras_smu_drv)(struct smu_context *smu, const struct ras_smu_drv=
 **ras_smu_drv);
-=20
  	/**
  	 * @set_power_dep: Create or destroy a power dependency link
  	 * from an integrated xHCI controller to the GPU so that the GPU is
@@@ -1962,7 -1927,13 +1927,13 @@@ int smu_link_reset(struct smu_context *
 =20
  extern const struct amd_ip_funcs smu_ip_funcs;
 =20
- bool is_support_sw_smu(struct amdgpu_device *adev);
+ void amdgpu_smu_early_init(struct amdgpu_device *adev);
+=20
+ static inline bool is_support_sw_smu(struct amdgpu_device *adev)
+ {
+ 	return adev->is_sw_smu;
+ }
+=20
  bool is_support_cclk_dpm(struct amdgpu_device *adev);
  int smu_write_watermarks_table(struct smu_context *smu);
 =20
@@@ -2005,7 -1976,6 +1976,6 @@@ int smu_set_pm_policy(struct smu_contex
  		      int level);
  ssize_t smu_get_pm_policy_info(struct smu_context *smu,
  			       enum pp_pm_policy p_type, char *sysbuf);
- const struct ras_smu_drv *smu_get_ras_smu_driver(void *handle);
 =20
  int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_=
type msg,
  			    uint32_t param, uint32_t *readarg);

--uzW1W57Wu56gyMt/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpaPvwACgkQJNaLcl1U
h9A2igf+OztYrmUSNtXsytXTnqLezPi68dmq8SMC+mUDrONs+/u8Ul1+j96oIHPb
q7Q9YplF/4rs7pRRrtjbq6bX+j00NC55+zTJ0vbNKq8EhFv+QLxiZlBUUrw/xrwt
PMbkLsRZmCHMfj5eYOlwrcitmmeJZc9C1YgFTYgwIE6ME3FxUnQrOBCLPoehwfHw
hvDlgGSIc49MfO0H3rsjoUXNvSySWmzQXzKRpw4NKX2azU24Qz7Wk7ahjSmSlVqq
YKoTW1wUkGjeLH/Jl2X1EamWuDZVufJrkXShQaUtqkqbdrQDIQ1vyKhBZAmClMxI
/EitAo9apNm/pqfLQZClmHZPiSiglA==
=0oW6
-----END PGP SIGNATURE-----

--uzW1W57Wu56gyMt/--
