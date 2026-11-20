Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB09606A333
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOVl8u8A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D638410E92C;
	Fri, 20 Nov 2026 15:07:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 365F110E906
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:07:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D00DA457FA;
 Fri, 20 Nov 2026 15:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271C81F000C6;
 Fri, 20 Nov 2026 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795187266;
 bh=874nfZYHG7Hr/xD5J0V8qN8D2eIadlh7ZI+XuhVVHpA=;
 h=Date:From:To:Cc:Subject;
 b=UOVl8u8A0RvdsXwL30D6nrvUVgtvLlswrPO8ayHYAdBwPUQzmZt7qmhY/GabaRkmU
 QGbY6kZ9ZB0vz732je85SDMgUiyLwc/6l7T6L6WbGZYb71cHHmNPEoTY2uKLx3OEZW
 B3CB/bo7JoLolXu9rjtgwd6UQ7IaVX0kYzTlCHAkmy1pyVZcu/6G1x8uT2FZGNTiCB
 Uo1QkP3qtxXBa/aNmwC8QD/lCOttBWtImlL6pXMWsmt/FWX9hpCS1k5szh3to/kwjA
 iB0x5zH+Osy4SwXyaqVQ/clKkRRZjUcailzYpHvkYKtP8ODs2vtUi2vfi7fuJilYV0
 aMsQVYgU969TQ==
Date: Fri, 20 Nov 2026 15:07:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
 Karthik Poosa <karthik.poosa@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Subject: linux-next: manual merge of the drm tree with the drm-xe-fixes tree
Message-ID: <awBiPWrQJAygBnaS@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wjy12GJi7iLOsjrW"
Content-Disposition: inline
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--wjy12GJi7iLOsjrW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/xe/xe_hwmon.c

between commits:

  94099304b80e8 ("drm/xe/hwmon: Fix pcode power limit handling")
  c9d8ef7f6835d ("drm/xe/hwmon: Decode mailbox temperature as sign-magnitud=
e")
  d37dcdaa99b18 ("drm/xe/hwmon: Fix thermal sensor data handling")
  f2a144e9891b3 ("drm/xe/hwmon: Add helpers to validate thermal sensor read=
ings")
  dbd199c775cbe ("drm/xe/hwmon: Handle unavailable memory controller sensor=
s")
  808951ee16738 ("drm/xe/hwmon: Report errors using structured xe_log API")
  58417a6534dd3 ("drm/xe/hwmon: Propagate all hardware read errors")

=66rom the drm-xe-fixes tree and commits:

  58c84a1dffe21 ("drm/xe/hwmon: Report errors using structured xe_log API")
  c5b502e43f7cd ("drm/xe/hwmon: Fix pcode power limit handling")
  1bbbd7d98fa58 ("drm/xe/hwmon: Decode mailbox temperature as sign-magnitud=
e")
  ca6e33701de86 ("drm/xe/hwmon: Fix thermal sensor data handling")
  054805851f2e1 ("drm/xe/hwmon: Add helpers to validate thermal sensor read=
ings")
  99ceaebb88894 ("drm/xe/hwmon: Handle unavailable memory controller sensor=
s")
  8fdd3d4c55ecb ("drm/xe/hwmon: Detect unavailable PCIe thermal sensors")
  0d4033d899609 ("drm/xe/hwmon: Consolidate temperature sensor availability=
 checks")
  87ce4876e3f50 ("drm/xe/hwmon: Cache temperature availability to reduce pr=
obe time")
  b6ccfa0bed5b7 ("drm/xe/hwmon: use CRI-specific package and VRAM temperatu=
re registers")
  993338420540a ("drm/xe/hwmon: Add platform-aware VRAM thermal channel sup=
port")
  24ec15d646179 ("drm/xe/hwmon: Decode CRI temperature registers as IEEE-75=
4")
  ae4cd659d22dc ("drm/xe/hwmon: Update memory controller temperature offset=
 for CRI")
  32b98ee8d317b ("drm/xe/hwmon: add PCIe temperature support for CRI")
  0dd554733ae8a ("drm/xe/hwmon: Simplify temperature channels config")
  a3d7376b9d671 ("drm/xe: Validate thermal sensor count before reads")
  4289dded4329b ("drm/xe/hwmon: Propagate all hardware read errors")
  72fde60e3ed74 ("drm/xe/hwmon: Use overflows_type() for temperature range =
check")
  a5b29fce26597 ("Merge tag 'drm-xe-next-2026-11-05' of https://gitlab.free=
desktop.org/drm/xe/kernel into drm-next")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/xe/xe_hwmon.c
index daa3f61617a02,defe8aaca7c11..0000000000000
--- a/drivers/gpu/drm/xe/xe_hwmon.c
+++ b/drivers/gpu/drm/xe/xe_hwmon.c
@@@ -6,6 -6,7 +6,7 @@@
  #include <linux/hwmon-sysfs.h>
  #include <linux/hwmon.h>
  #include <linux/jiffies.h>
+ #include <linux/overflow.h>
  #include <linux/types.h>
  #include <linux/units.h>
 =20
@@@ -40,7 -41,11 +41,11 @@@ enum xe_hwmon_reg_operation=20
  	REG_READ64,
  };
 =20
- #define MAX_VRAM_CHANNELS      (16)
+ #define MAX_VRAM_CHANNELS	80
+ #define FIXED_VRAM_CHANNELS	16
+=20
+ /* Each MSU enable bit maps to one VRAM subsystem of 4 channels. */
+ #define VRAM_CHANNELS_PER_MSU	4
 =20
  enum xe_hwmon_channel {
  	CHANNEL_CARD,
@@@ -49,6 -54,7 +54,7 @@@
  	CHANNEL_MCTRL,
  	CHANNEL_PCIE,
  	CHANNEL_VRAM_N,
+ 	/* Compile-time upper bound; actual channel count is hwmon->temp.vram_co=
unt */
  	CHANNEL_VRAM_N_MAX =3D CHANNEL_VRAM_N + MAX_VRAM_CHANNELS - 1,
  	CHANNEL_MAX,
  };
@@@ -102,8 -108,15 +108,15 @@@ enum sensor_attr_power=20
 =20
  #define PWR_ATTR_TO_STR(attr)	(((attr) =3D=3D hwmon_power_max) ? "PL1" : =
"PL2")
 =20
- /* Index of memory controller in READ_THERMAL_DATA output */
+ /* Sensor byte indices in READ_THERMAL_DATA output for BMG. */
  #define TEMP_INDEX_MCTRL	2
+ #define TEMP_INDEX_PCIE		10
+ #define BMG_G21_TEMP_INDEX_PCIE	8
+=20
+ /* Sensor byte indices in READ_THERMAL_DATA output for CRI. */
+ #define CRI_TEMP_INDEX_MCTRL	16
+ #define CRI_TEMP_MCTRL_COUNT	4
+ #define CRI_TEMP_INDEX_PCIE	20
 =20
  /* Mailbox sentinel reported for an unavailable temperature sensor */
  #define TEMP_MBX_INVALID	0xFF
@@@ -145,16 -158,22 +158,22 @@@ struct xe_hwmon_thermal_info=20
  		/** @data: temperature limits as little-endian dwords */
  		__le32 data[DIV_ROUND_UP(TEMP_LIMIT_MAX, sizeof(u32))];
  	};
- 	/** @count: no of temperature sensors available for the platform */
+ 	/** @count: temperature sensors count from READ_THERMAL_CONFIG */
  	u8 count;
+ 	/** @vram_count: exclusive upper bound for VRAM temperature channel indi=
ces */
+ 	u8 vram_count;
+ 	/** @available: temperature sensor availability cached at registration */
+ 	bool available[CHANNEL_MAX];
+ 	/** @msu_mask: VRAM subsystem enable mask read from MMIO */
+ 	u32 msu_mask;
  	union {
  		/** @value: per-sensor raw mailbox temperature; bit7=3Dsign, bits6:0=3D=
magnitude */
  		u8 value[U8_MAX + 1];
  		/** @dword: sensor values as little-endian dwords, u32-aligned for pcod=
e reads */
  		__le32 dword[DIV_ROUND_UP(U8_MAX + 1, sizeof(u32))];
  	};
- 	/** @vram_label: vram label names */
- 	char vram_label[MAX_VRAM_CHANNELS][MAX_LABEL_SIZE];
+ 	/** @vram_label: vram label names, dynamically allocated based on vram_c=
ount */
+ 	char (*vram_label)[MAX_LABEL_SIZE];
  };
 =20
  /**
@@@ -297,6 -316,14 +316,14 @@@ static int xe_hwmon_pcode_set_default_p
  	return ret;
  }
 =20
+ static bool xe_hwmon_vram_channel_enabled(const struct xe_hwmon *hwmon, i=
nt index)
+ {
+ 	if (hwmon->xe->info.platform =3D=3D XE_CRESCENTISLAND)
+ 		return hwmon->temp.msu_mask & BIT(index / VRAM_CHANNELS_PER_MSU);
+=20
+ 	return true;
+ }
+=20
  static struct xe_reg xe_hwmon_get_reg(struct xe_hwmon *hwmon, enum xe_hwm=
on_reg hwmon_reg,
  				      int channel)
  {
@@@ -304,12 -331,21 +331,21 @@@
 =20
  	switch (hwmon_reg) {
  	case REG_TEMP:
- 		if (xe->info.platform =3D=3D XE_BATTLEMAGE || xe->info.platform =3D=3D =
XE_CRESCENTISLAND) {
+ 		if (xe->info.platform =3D=3D XE_CRESCENTISLAND) {
+ 			if (channel =3D=3D CHANNEL_PKG)
+ 				return CRI_PACKAGE_TEMPERATURE;
+ 			else if (channel =3D=3D CHANNEL_VRAM)
+ 				return CRI_VRAM_TEMPERATURE;
+ 			else if (in_range(channel, CHANNEL_VRAM_N, hwmon->temp.vram_count) &&
+ 				 xe_hwmon_vram_channel_enabled(hwmon, channel - CHANNEL_VRAM_N))
+ 				return CRI_VRAM_TEMPERATURE_N(channel - CHANNEL_VRAM_N);
+ 		} else if (xe->info.platform =3D=3D XE_BATTLEMAGE) {
  			if (channel =3D=3D CHANNEL_PKG)
  				return BMG_PACKAGE_TEMPERATURE;
  			else if (channel =3D=3D CHANNEL_VRAM)
  				return BMG_VRAM_TEMPERATURE;
- 			else if (in_range(channel, CHANNEL_VRAM_N, MAX_VRAM_CHANNELS))
+ 			else if (in_range(channel, CHANNEL_VRAM_N, hwmon->temp.vram_count) &&
+ 				 xe_hwmon_vram_channel_enabled(hwmon, channel - CHANNEL_VRAM_N))
  				return BMG_VRAM_TEMPERATURE_N(channel - CHANNEL_VRAM_N);
  		} else if (xe->info.platform =3D=3D XE_DG2) {
  			if (channel =3D=3D CHANNEL_PKG)
@@@ -810,30 -846,24 +846,24 @@@ static const struct attribute_group *hw
  	NULL
  };
 =20
+ static const u32 hwmon_temp_config[CHANNEL_MAX + 1] =3D {
+ 	[CHANNEL_CARD] =3D HWMON_T_LABEL,
+ 	[CHANNEL_PKG] =3D HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT |
+ 			 HWMON_T_LABEL | HWMON_T_MAX,
+ 	[CHANNEL_VRAM ... CHANNEL_PCIE] =3D HWMON_T_CRIT | HWMON_T_EMERGENCY |
+ 					 HWMON_T_INPUT | HWMON_T_LABEL,
+ 	[CHANNEL_VRAM_N ... CHANNEL_VRAM_N_MAX] =3D HWMON_T_CRIT | HWMON_T_EMERG=
ENCY |
+ 							 HWMON_T_INPUT | HWMON_T_LABEL,
+ 	[CHANNEL_MAX] =3D 0, /* hwmon config terminator */
+ };
+=20
+ static const struct hwmon_channel_info hwmon_temp_info =3D {
+ 	.type =3D hwmon_temp,
+ 	.config =3D hwmon_temp_config,
+ };
+=20
  static const struct hwmon_channel_info * const hwmon_info[] =3D {
- 	HWMON_CHANNEL_INFO(temp,
- 			   HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL |
- 			   HWMON_T_MAX,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
- 			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL),
+ 	&hwmon_temp_info,
  	HWMON_CHANNEL_INFO(power, HWMON_P_MAX | HWMON_P_RATED_MAX | HWMON_P_LABE=
L | HWMON_P_CRIT |
  			   HWMON_P_CAP,
  			   HWMON_P_MAX | HWMON_P_RATED_MAX | HWMON_P_LABEL | HWMON_P_CAP),
@@@ -847,9 -877,31 +877,31 @@@
  static int xe_hwmon_pcode_read_thermal_info(struct xe_hwmon *hwmon)
  {
  	struct xe_tile *root_tile =3D xe_device_get_root_tile(hwmon->xe);
+ 	struct xe_mmio *mmio =3D xe_root_tile_mmio(hwmon->xe);
  	u32 config =3D 0, data0 =3D 0, data1 =3D 0;
  	int ret;
 =20
+ 	/*
+ 	 * Only CRI reports dynamic VRAM channel state. Fixed-channel platforms
+ 	 * set the count up front so those sensors stay visible even if the ther=
mal
+ 	 * mailbox reads below fail.
+ 	 */
+ 	if (hwmon->xe->info.has_fixed_vram_channels)
+ 		hwmon->temp.vram_count =3D FIXED_VRAM_CHANNELS;
+=20
+ 	if (hwmon->xe->info.platform =3D=3D XE_CRESCENTISLAND) {
+ 		hwmon->temp.msu_mask =3D xe_mmio_read32(mmio, CRI_MSU_VRAM_ENABLE);
+ 		hwmon->temp.vram_count =3D fls(hwmon->temp.msu_mask) * VRAM_CHANNELS_PE=
R_MSU;
+ 		drm_dbg(&hwmon->xe->drm, "MSU VRAM enable mask 0x%x, VRAM channel bound=
 %d\n",
+ 			hwmon->temp.msu_mask, hwmon->temp.vram_count);
+ 		if (hwmon->temp.vram_count > MAX_VRAM_CHANNELS) {
+ 			drm_warn(&hwmon->xe->drm,
+ 				 "VRAM channel bound %d exceeds max %d, clamping\n",
+ 				 hwmon->temp.vram_count, MAX_VRAM_CHANNELS);
+ 			hwmon->temp.vram_count =3D MAX_VRAM_CHANNELS;
+ 		}
+ 	}
+=20
  	ret =3D xe_pcode_read(root_tile, PCODE_MBOX(PCODE_THERMAL_INFO, READ_THE=
RMAL_LIMITS, 0),
  			    &data0, &data1);
  	if (ret)
@@@ -902,17 -954,43 +954,43 @@@ static int mbx_temp_decode(u8 value
  	return (value & TEMP_MBX_SIGN) ? -temp : temp;
  }
 =20
+ static u8 xe_hwmon_pcie_temp_index(const struct xe_hwmon *hwmon)
+ {
+ 	if (hwmon->xe->info.platform =3D=3D XE_CRESCENTISLAND)
+ 		return CRI_TEMP_INDEX_PCIE;
+=20
+ 	if (hwmon->xe->info.subplatform =3D=3D XE_SUBPLATFORM_BATTLEMAGE_G21)
+ 		return BMG_G21_TEMP_INDEX_PCIE;
+=20
+ 	return TEMP_INDEX_PCIE;
+ }
+=20
  static int get_mc_temp(struct xe_hwmon *hwmon, long *val)
  {
  	struct xe_tile *root_tile =3D xe_device_get_root_tile(hwmon->xe);
- 	int ret, i, count =3D 0;
+ 	int ret, i, start, end, count =3D 0;
  	s32 average =3D 0;
+ 	u32 data =3D 0;
 =20
  	guard(mutex)(&hwmon->hwmon_lock);
 =20
- 	for (i =3D 0; i < DIV_ROUND_UP(hwmon->temp.count, sizeof(u32)); i++) {
- 		u32 data =3D 0;
+ 	/* CRI relocated the memory controller temperatures to READ_THERMAL_DATA=
 bytes 16..19. */
+ 	if (hwmon->xe->info.platform =3D=3D XE_CRESCENTISLAND) {
+ 		start =3D CRI_TEMP_INDEX_MCTRL;
+ 		end =3D CRI_TEMP_INDEX_MCTRL + CRI_TEMP_MCTRL_COUNT;
+ 	} else {
+ 		start =3D TEMP_INDEX_MCTRL;
+ 		end =3D min_t(int, hwmon->temp.count - 1, xe_hwmon_pcie_temp_index(hwmo=
n));
+ 	}
 =20
+ 	if (end <=3D start || end > hwmon->temp.count) {
+ 		drm_warn(&hwmon->xe->drm,
+ 			 "memory controller range [%d, %d) is invalid for temperature count %d=
\n",
+ 			 start, end, hwmon->temp.count);
+ 		return -ENODATA;
+ 	}
+=20
+ 	for (i =3D start / sizeof(u32); i < DIV_ROUND_UP(end, sizeof(u32)); i++)=
 {
  		ret =3D xe_pcode_read(root_tile, PCODE_MBOX(PCODE_THERMAL_INFO, READ_TH=
ERMAL_DATA, i),
  				    &data, NULL);
  		if (ret)
@@@ -921,7 -999,7 +999,7 @@@
  		hwmon->temp.dword[i] =3D cpu_to_le32(data);
  	}
 =20
- 	for (i =3D TEMP_INDEX_MCTRL; i < hwmon->temp.count - 1; i++) {
+ 	for (i =3D start; i < end; i++) {
  		if (!mbx_temp_valid(hwmon, hwmon->temp.value[i]))
  			continue;
  		average +=3D mbx_temp_decode(hwmon->temp.value[i]);
@@@ -941,23 -1019,36 +1019,36 @@@
  	return 0;
  }
 =20
- static int get_pcie_temp(struct xe_hwmon *hwmon, long *val)
+ static int get_pcie_temp(const struct xe_hwmon *hwmon, long *val)
  {
  	struct xe_tile *root_tile =3D xe_device_get_root_tile(hwmon->xe);
  	u32 data =3D 0;
+ 	int index;
  	int ret;
 =20
+ 	index =3D xe_hwmon_pcie_temp_index(hwmon);
+ 	if (index >=3D hwmon->temp.count) {
+ 		drm_warn(&hwmon->xe->drm,
+ 			 "PCIe temperature index %d out of range for temperature count %d\n",
+ 			 index, hwmon->temp.count);
+ 		return -ENODATA;
+ 	}
+=20
  	ret =3D xe_pcode_read(root_tile, PCODE_MBOX(PCODE_THERMAL_INFO, READ_THE=
RMAL_DATA,
- 						  PCIE_SENSOR_GROUP_ID), &data, NULL);
+ 						  index / sizeof(data)),
+ 						  &data, NULL);
  	if (ret)
  		return ret;
 =20
- 	/* Sensor offset is different for G21 */
- 	if (hwmon->xe->info.subplatform !=3D XE_SUBPLATFORM_BATTLEMAGE_G21)
- 		data =3D REG_FIELD_GET(PCIE_SENSOR_MASK, data);
-=20
+ 	data >>=3D (index % sizeof(data)) * BITS_PER_BYTE;
  	data =3D REG_FIELD_GET(TEMP_MASK, data);
- 	*val =3D mbx_temp_decode(data) * MILLIDEGREE_PER_DEGREE;
+ 	if (!mbx_temp_valid(hwmon, data)) {
+ 		drm_dbg(&hwmon->xe->drm, "PCIe temperature not available\n");
+ 		return -ENXIO;
+ 	}
+=20
+ 	if (val)
+ 		*val =3D mbx_temp_decode(data) * MILLIDEGREE_PER_DEGREE;
 =20
  	return 0;
  }
@@@ -1056,19 -1147,70 +1147,70 @@@ static void xe_hwmon_get_voltage(struc
  	*value =3D DIV_ROUND_CLOSEST(REG_FIELD_GET(VOLTAGE_MASK, reg_val) * 2500=
, SF_VOLTAGE);
  }
 =20
- static inline bool is_vram_ch_available(struct xe_hwmon *hwmon, int chann=
el)
+ static bool xe_hwmon_temp_probe(struct xe_hwmon *hwmon, int channel)
  {
  	struct xe_mmio *mmio =3D xe_root_tile_mmio(hwmon->xe);
- 	int vram_id =3D channel - CHANNEL_VRAM_N;
- 	struct xe_reg vram_reg;
+ 	struct xe_reg reg;
+ 	u32 reg_val;
 =20
- 	vram_reg =3D xe_hwmon_get_reg(hwmon, REG_TEMP, channel);
- 	if (!xe_reg_is_valid(vram_reg) || !xe_mmio_read32(mmio, vram_reg))
+ 	switch (channel) {
+ 	case CHANNEL_PKG:
+ 	case CHANNEL_VRAM:
+ 	case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
+ 		reg =3D xe_hwmon_get_reg(hwmon, REG_TEMP, channel);
+ 		if (!xe_reg_is_valid(reg))
+ 			return false;
+=20
+ 		/*
+ 		 * On CRI, VRAM channel presence comes from the MSU enable mask
+ 		 * (applied in xe_hwmon_get_reg()); the temperature register's
+ 		 * 0xffffffff sentinel is not reliable for VRAM channels.
+ 		 */
+ 		if (hwmon->xe->info.platform =3D=3D XE_CRESCENTISLAND && channel >=3D C=
HANNEL_VRAM_N)
+ 			return true;
+=20
+ 		reg_val =3D xe_mmio_read32(mmio, reg);
+ 		if (!mmio_temp_valid(hwmon, reg_val)) {
+ 			drm_dbg(&hwmon->xe->drm,
+ 				"channel %d temperature unavailable, val 0x%x\n", channel, reg_val);
+ 			return false;
+ 		}
+=20
+ 		return true;
+ 	case CHANNEL_MCTRL:
+ 		return hwmon->temp.count && !get_mc_temp(hwmon, NULL);
+ 	case CHANNEL_PCIE:
+ 		return hwmon->temp.count && !get_pcie_temp(hwmon, NULL);
+ 	default:
  		return false;
+ 	}
+ }
 =20
- 	/* Create label only for available vram channel */
- 	sprintf(hwmon->temp.vram_label[vram_id], "vram_ch_%d", vram_id);
- 	return true;
+ static int xe_hwmon_init_temp_info(struct xe_hwmon *hwmon)
+ {
+ 	struct device *dev =3D hwmon->xe->drm.dev;
+ 	int channel;
+=20
+ 	if (hwmon->xe->info.has_mbx_thermal_info && xe_hwmon_pcode_read_thermal_=
info(hwmon))
+ 		drm_warn(&hwmon->xe->drm, "Thermal mailbox not supported by card firmwa=
re\n");
+=20
+ 	/* vram_count is known only after reading thermal info above. */
+ 	if (hwmon->temp.vram_count) {
+ 		hwmon->temp.vram_label =3D devm_kcalloc(dev, hwmon->temp.vram_count,
+ 						      MAX_LABEL_SIZE, GFP_KERNEL);
+ 		if (!hwmon->temp.vram_label)
+ 			return -ENOMEM;
+ 	}
+=20
+ 	for (channel =3D 0; channel < CHANNEL_MAX; channel++) {
+ 		hwmon->temp.available[channel] =3D xe_hwmon_temp_probe(hwmon, channel);
+ 		if (hwmon->temp.available[channel] && hwmon->temp.vram_label &&
+ 		    in_range(channel, CHANNEL_VRAM_N, hwmon->temp.vram_count))
+ 			snprintf(hwmon->temp.vram_label[channel - CHANNEL_VRAM_N], MAX_LABEL_S=
IZE,
+ 				 "vram_ch_%d", channel - CHANNEL_VRAM_N);
+ 	}
+=20
+ 	return 0;
  }
 =20
  static umode_t
@@@ -1078,14 -1220,13 +1220,13 @@@ xe_hwmon_temp_is_visible(struct xe_hwmo
  	case hwmon_temp_emergency:
  		switch (channel) {
  		case CHANNEL_PKG:
- 			return hwmon->temp.limit[TEMP_LIMIT_PKG_SHUTDOWN] ? 0444 : 0;
- 		case CHANNEL_VRAM:
- 			return hwmon->temp.limit[TEMP_LIMIT_MEM_SHUTDOWN] ? 0444 : 0;
  		case CHANNEL_MCTRL:
  		case CHANNEL_PCIE:
- 			return hwmon->temp.count ? 0444 : 0;
+ 			return (hwmon->temp.available[channel] &&
+ 				hwmon->temp.limit[TEMP_LIMIT_PKG_SHUTDOWN]) ? 0444 : 0;
+ 		case CHANNEL_VRAM:
  		case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
- 			return (is_vram_ch_available(hwmon, channel) &&
+ 			return (hwmon->temp.available[channel] &&
  				hwmon->temp.limit[TEMP_LIMIT_MEM_SHUTDOWN]) ? 0444 : 0;
  		default:
  			return 0;
@@@ -1093,14 -1234,13 +1234,13 @@@
  	case hwmon_temp_crit:
  		switch (channel) {
  		case CHANNEL_PKG:
- 			return hwmon->temp.limit[TEMP_LIMIT_PKG_CRIT] ? 0444 : 0;
- 		case CHANNEL_VRAM:
- 			return hwmon->temp.limit[TEMP_LIMIT_MEM_CRIT] ? 0444 : 0;
  		case CHANNEL_MCTRL:
  		case CHANNEL_PCIE:
- 			return hwmon->temp.count ? 0444 : 0;
+ 			return (hwmon->temp.available[channel] &&
+ 				hwmon->temp.limit[TEMP_LIMIT_PKG_CRIT]) ? 0444 : 0;
+ 		case CHANNEL_VRAM:
  		case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
- 			return (is_vram_ch_available(hwmon, channel) &&
+ 			return (hwmon->temp.available[channel] &&
  				hwmon->temp.limit[TEMP_LIMIT_MEM_CRIT]) ? 0444 : 0;
  		default:
  			return 0;
@@@ -1108,7 -1248,8 +1248,8 @@@
  	case hwmon_temp_max:
  		switch (channel) {
  		case CHANNEL_PKG:
- 			return hwmon->temp.limit[TEMP_LIMIT_PKG_MAX] ? 0444 : 0;
+ 			return (hwmon->temp.available[channel] &&
+ 				hwmon->temp.limit[TEMP_LIMIT_PKG_MAX]) ? 0444 : 0;
  		default:
  			return 0;
  		}
@@@ -1117,13 -1258,10 +1258,10 @@@
  		switch (channel) {
  		case CHANNEL_PKG:
  		case CHANNEL_VRAM:
- 			return xe_reg_is_valid(xe_hwmon_get_reg(hwmon, REG_TEMP,
- 								channel)) ? 0444 : 0;
  		case CHANNEL_MCTRL:
  		case CHANNEL_PCIE:
- 			return hwmon->temp.count ? 0444 : 0;
  		case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
- 			return is_vram_ch_available(hwmon, channel) ? 0444 : 0;
+ 			return hwmon->temp.available[channel] ? 0444 : 0;
  		default:
  			return 0;
  		}
@@@ -1132,6 -1270,70 +1270,70 @@@
  	}
  }
 =20
+ #define IEEE754_SIGN		REG_BIT(31)
+ #define IEEE754_EXP_MASK	REG_GENMASK(30, 23)
+ #define IEEE754_MANTISSA_MASK	REG_GENMASK(22, 0)
+ #define IEEE754_EXP_BIAS	127 /* Exponent bias to obtain the actual expone=
nt */
+ #define IEEE754_MANTISSA_BITS	23 /* Mantissa width and implicit leading-1=
 bit position */
+ #define IEEE754_EXP_SPECIAL	0xff /* reserved exponent value encoding infi=
nity or NaN */
+=20
+ /**
+  * xe_hwmon_temperature_decode - Decode an IEEE-754 temperature register =
value
+  * @reg_val: The raw register value to decode
+  * @temperature: Pointer to store the decoded temperature in millidegrees=
 Celsius.
+  *
+  * IEEE-754 single-precision format:
+  *
+  *  31 30                         23 22                         0
+  * +--+-----------------------------+----------------------------+
+  * | S|          exponent           |          fraction          |
+  * +--+-----------------------------+----------------------------+
+  *
+  * value =3D (-1)^S * 1.fraction * 2^(exponent - 127)
+  *
+  * Return: 0 on success or an error if @reg_val is non-finite or cannot be
+  * represented in millidegrees Celsius.
+  */
+ static int xe_hwmon_temperature_decode(u32 reg_val, long *temperature)
+ {
+ 	u32 exponent =3D REG_FIELD_GET(IEEE754_EXP_MASK, reg_val);
+ 	u32 mantissa =3D REG_FIELD_GET(IEEE754_MANTISSA_MASK, reg_val);
+ 	s64 value;
+ 	int shift;
+=20
+ 	/* Exponent 0xff encodes infinity or NaN. */
+ 	if (exponent =3D=3D IEEE754_EXP_SPECIAL)
+ 		return -EINVAL;
+=20
+ 	/* Subnormal values are smaller than one millidegree Celsius. */
+ 	if (!exponent) {
+ 		*temperature =3D 0;
+ 		return 0;
+ 	}
+=20
+ 	value =3D (s64)(mantissa | BIT(IEEE754_MANTISSA_BITS)) * MILLIDEGREE_PER=
_DEGREE;
+ 	shift =3D exponent - (IEEE754_EXP_BIAS + IEEE754_MANTISSA_BITS);
+ 	if (shift >=3D 0) {
+ 		if (shift >=3D BITS_PER_LONG || value > (LONG_MAX >> shift))
+ 			return -ERANGE;
+ 		value <<=3D shift;
+ 	} else if (shift > -64) {
+ 		value >>=3D -shift;
+ 	} else {
+ 		value =3D 0;
+ 	}
+=20
+ 	/* Ensure the decoded value fits in a long. */
+ 	if (overflows_type(value, *temperature))
+ 		return -ERANGE;
+=20
+ 	if (reg_val & IEEE754_SIGN)
+ 		value =3D -value;
+=20
+ 	*temperature =3D value;
+ 	return 0;
+ }
+=20
  static int
  xe_hwmon_temp_read(struct xe_hwmon *hwmon, u32 attr, int channel, long *v=
al)
  {
@@@ -1141,26 -1343,33 +1343,33 @@@
  	switch (attr) {
  	case hwmon_temp_input:
  		switch (channel) {
- 		case CHANNEL_PKG:
- 		case CHANNEL_VRAM:
- 			reg_val =3D xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_TEMP, cha=
nnel));
-=20
- 			/* HW register value is in degrees Celsius, convert to millidegrees. */
- 			*val =3D REG_FIELD_GET(TEMP_MASK, reg_val) * MILLIDEGREE_PER_DEGREE;
- 			return 0;
  		case CHANNEL_MCTRL:
  			return get_mc_temp(hwmon, val);
  		case CHANNEL_PCIE:
  			return get_pcie_temp(hwmon, val);
+ 		case CHANNEL_PKG:
+ 		case CHANNEL_VRAM:
  		case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
  			reg_val =3D xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_TEMP, cha=
nnel));
- 			/*
- 			 * This temperature format is 24 bit [31:8] signed integer and 8 bit
- 			 * [7:0] fraction.
- 			 */
- 			*val =3D (s32)(REG_FIELD_GET(TEMP_MASK_VRAM_N, reg_val)) *
- 				(REG_FIELD_GET(TEMP_SIGN_MASK, reg_val) ? -1 : 1) *
- 				 MILLIDEGREE_PER_DEGREE;
+ 			if (!mmio_temp_valid(hwmon, reg_val)) {
+ 				drm_dbg(&hwmon->xe->drm,
+ 					"channel %d temperature invalid, val 0x%llx\n",
+ 					channel, reg_val);
+ 				return -ENXIO;
+ 			}
+ 			if (hwmon->xe->info.platform >=3D XE_CRESCENTISLAND) {
+ 				return xe_hwmon_temperature_decode((u32)reg_val, val);
+ 			} else if (channel >=3D CHANNEL_VRAM_N) {
+ 				/*
+ 				 * This temperature format is 24 bit [31:8] signed integer and 8 bit
+ 				 * [7:0] fraction for platforms before CRI.
+ 				 */
+ 				*val =3D (s32)REG_FIELD_GET(TEMP_MASK_VRAM_N, reg_val) *
+ 					(REG_FIELD_GET(TEMP_SIGN_MASK, reg_val) ? -1 : 1) *
+ 					MILLIDEGREE_PER_DEGREE;
+ 			} else {
+ 				*val =3D REG_FIELD_GET(TEMP_MASK, reg_val) * MILLIDEGREE_PER_DEGREE;
+ 			}
  			return 0;
  		default:
  			return -EOPNOTSUPP;
@@@ -1567,8 -1776,10 +1776,10 @@@ static int xe_hwmon_read_label(struct d
  			*str =3D "mctrl";
  		else if (channel =3D=3D CHANNEL_PCIE)
  			*str =3D "pcie";
- 		else if (in_range(channel, CHANNEL_VRAM_N, MAX_VRAM_CHANNELS))
+ 		else if (in_range(channel, CHANNEL_VRAM_N, hwmon->temp.vram_count))
  			*str =3D hwmon->temp.vram_label[channel - CHANNEL_VRAM_N];
+ 		else
+ 			return -EOPNOTSUPP;
  		return 0;
  	case hwmon_power:
  	case hwmon_energy:
@@@ -1596,7 -1807,7 +1807,7 @@@ static const struct hwmon_chip_info hwm
  	.info =3D hwmon_info,
  };
 =20
- static void
+ static int
  xe_hwmon_get_preregistration_info(struct xe_hwmon *hwmon)
  {
  	struct xe_mmio *mmio =3D xe_root_tile_mmio(hwmon->xe);
@@@ -1653,15 -1864,14 +1864,14 @@@
  		if (xe_hwmon_is_visible(hwmon, hwmon_fan, hwmon_fan_input, channel))
  			xe_hwmon_fan_input_read(hwmon, channel, &fan_speed);
 =20
- 	if (hwmon->xe->info.has_mbx_thermal_info && xe_hwmon_pcode_read_thermal_=
info(hwmon))
- 		drm_warn(&hwmon->xe->drm, "Thermal mailbox not supported by card firmwa=
re\n");
+ 	return xe_hwmon_init_temp_info(hwmon);
  }
 =20
  int xe_hwmon_register(struct xe_device *xe)
  {
  	struct device *dev =3D xe->drm.dev;
  	struct xe_hwmon *hwmon;
- 	int ret, err;
+ 	int ret;
 =20
  	/* hwmon is available only for dGfx */
  	if (!IS_DGFX(xe))
@@@ -1683,7 -1893,9 +1893,9 @@@
  	hwmon->xe =3D xe;
  	xe->hwmon =3D hwmon;
 =20
- 	xe_hwmon_get_preregistration_info(hwmon);
+ 	ret =3D xe_hwmon_get_preregistration_info(hwmon);
+ 	if (ret)
+ 		goto err_null_hwmon;
 =20
  	drm_dbg(&xe->drm, "Register xe hwmon interface\n");
 =20
@@@ -1692,13 -1904,15 +1904,15 @@@
  								&hwmon_chip_info,
  								hwmon_groups);
  	if (IS_ERR(hwmon->hwmon_dev)) {
- 		err =3D PTR_ERR(hwmon->hwmon_dev);
- 		xe_log_err(xe, HWMON, err,
- 			   "Failed to register xe hwmon\n");
- 		xe->hwmon =3D NULL;
- 		return err;
+ 		ret =3D PTR_ERR(hwmon->hwmon_dev);
+ 		xe_log_err(xe, HWMON, ret, "Failed to register xe hwmon\n");
+ 		goto err_null_hwmon;
  	}
 =20
  	return 0;
+=20
+ err_null_hwmon:
+ 	xe->hwmon =3D NULL;
+ 	return ret;
  }
  MODULE_IMPORT_NS("INTEL_PMT_TELEMETRY");

--wjy12GJi7iLOsjrW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsAYjwACgkQJNaLcl1U
h9Cczgf8DHRr/9zGNBtDzmDdwIf4EGMUvSDJiUawTJ4Rhq1TJvIVZFQdkHnD7sWw
NH0T2QajyIqVeskJAfFBYqKohlCi/mXaHxsYu5zYbPOAqVOAW8nb1kRNMauKBREw
MhIqJiho+gj48awPoDhOizEAJRFqQ7EJHtSuC3LyXjumWT1xRrtEGR4ID9f4tgdq
kQgkddpPrSheCzezljhwdnc7M35QdsWsy66uOrGx8W1aJUtehhSjmf7wSrJ4vD4t
hJdN5O4ZAgqfCBicmugTOawulQ9UGjino5IIoDys7sevXJozRJTNX0HJudC+SPI1
vmYZchhYjokDMduGTuVjTPCs4hA36A==
=iaTS
-----END PGP SIGNATURE-----

--wjy12GJi7iLOsjrW--
