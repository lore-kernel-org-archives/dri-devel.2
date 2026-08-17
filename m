Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EA1C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D95010E17C;
	Mon, 17 Aug 2026 15:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j3B3x5HA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A88B10E877
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:27:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 773D560204;
 Mon, 17 Aug 2026 15:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B4E1F00A3A;
 Mon, 17 Aug 2026 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786980477;
 bh=jxfpnvbhiaHLnsy8VZZheLUiY+p7GB7+Q0WLzAeRaB0=;
 h=Date:From:To:Cc:Subject;
 b=j3B3x5HAWGzV92wItQaUzF4qMFuxVK2CMn8vqJBxHYlafXG0NaCN7qZ3exgqiLzKA
 0lKwrLoZa+AKrFH+kOTDVKG1yXjUxZ5+1SEzBizwNJ0eP+KjpPMRilBqE0OGfGIYSG
 OlcIqo4YefYY9GJOCcSfEhZe9tcvE2OETUGQWkrbZctmD92cJH3/DPS5xuhTBo4jBd
 02nnEAYfFphx9uoX8noX+MgYebts6g3FZdCjsHLlriXobCm1Yao4mpmALt0m9P8ODx
 xpTBHA6tQ/xibc9FvGtULG6BJ9G/LzVwkTpDo5b9ZGX8Pq+X1N9NwcD6EbbEaSyXZn
 UazoutKBqj0BA==
Date: Mon, 17 Aug 2026 16:27:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Yang Wang <kevinyang.wang@amd.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <aoMoeEtvdJzu6cS2@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XytuleQJXo+FUOAx"
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


--XytuleQJXo+FUOAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/pm/amdgpu_pm.c

between commit:

  1849a64165ccc ("drm/amd/pm: use milliwatts for GPU power sensors")

=66rom the origin tree and commits:

  757ba0790bafe ("drm/amd/pm: use milliwatts for GPU power sensors")
  f5998f4d71b23 ("drm/amd/pm: Simplify SoC power printing in debugfs")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 85b089a3dc414,c0e677328af57..0000000000000
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@@ -34,6 -34,7 +34,7 @@@
  #include <linux/nospec.h>
  #include <linux/pm_runtime.h>
  #include <linux/string_choices.h>
+ #include <linux/units.h>
  #include <asm/processor.h>
 =20
  #define MAX_NUM_OF_FEATURES_PER_SUBSET		8
@@@ -98,6 -99,37 +99,37 @@@ const char * const amdgpu_pp_profile_na
  	"UNCAPPED",
  };
 =20
+ static int amdgpu_pm_parse_long_params(char *str, long *params,
+ 				       uint32_t max_params,
+ 				       uint32_t *num_params)
+ {
+ 	const char delimiter[] =3D { ' ', '\n', '\0' };
+ 	uint32_t count =3D 0;
+ 	char *sub_str;
+ 	int ret;
+=20
+ 	if (!params || !num_params)
+ 		return -EINVAL;
+=20
+ 	while ((sub_str =3D strsep(&str, delimiter)) !=3D NULL) {
+ 		if (strlen(sub_str) =3D=3D 0)
+ 			continue;
+ 		if (count >=3D max_params)
+ 			return -EINVAL;
+ 		ret =3D kstrtol(sub_str, 0, &params[count]);
+ 		if (ret)
+ 			return -EINVAL;
+ 		count++;
+ 		if (!str)
+ 			break;
+ 		while (isspace(*str))
+ 			str++;
+ 	}
+ 	*num_params =3D count;
+=20
+ 	return 0;
+ }
+=20
  /**
   * amdgpu_pm_dev_state_check - Check if device can be accessed.
   * @adev: Target device.
@@@ -761,8 -793,6 +793,6 @@@ static ssize_t amdgpu_set_pp_od_clk_vol
  	long parameter[64];
  	char buf_cpy[128];
  	char *tmp_str;
- 	char *sub_str;
- 	const char delimiter[3] =3D {' ', '\n', '\0'};
  	uint32_t type;
 =20
  	if (count > 127 || count =3D=3D 0)
@@@ -797,22 -827,10 +827,10 @@@
  		tmp_str++;
  	while (isspace(*++tmp_str));
 =20
- 	while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D NULL) {
- 		if (strlen(sub_str) =3D=3D 0)
- 			continue;
- 		if (parameter_size >=3D ARRAY_SIZE(parameter))
- 			return -EINVAL;
- 		ret =3D kstrtol(sub_str, 0, &parameter[parameter_size]);
- 		if (ret)
- 			return -EINVAL;
- 		parameter_size++;
-=20
- 		if (!tmp_str)
- 			break;
-=20
- 		while (isspace(*tmp_str))
- 			tmp_str++;
- 	}
+ 	ret =3D amdgpu_pm_parse_long_params(
+ 		tmp_str, parameter, ARRAY_SIZE(parameter), &parameter_size);
+ 	if (ret)
+ 		return ret;
 =20
  	ret =3D amdgpu_pm_get_access(adev);
  	if (ret < 0)
@@@ -1385,11 -1403,9 +1403,9 @@@ static ssize_t amdgpu_set_pp_power_prof
  	struct amdgpu_device *adev =3D drm_to_adev(ddev);
  	uint32_t parameter_size =3D 0;
  	long parameter[64];
- 	char *sub_str, buf_cpy[128];
- 	char *tmp_str;
+ 	char buf_cpy[128];
  	char tmp[2];
  	long int profile_mode =3D 0;
- 	const char delimiter[3] =3D {' ', '\n', '\0'};
 =20
  	/* Reject empty/whitespace strings - fuzzing found this is not validated=
 */
  	if (count =3D=3D 0 || sysfs_streq(buf, ""))
@@@ -1407,19 -1423,11 +1423,11 @@@
  		while (isspace(*buf))
  			buf++;
  		strscpy(buf_cpy, buf, sizeof(buf_cpy));
- 		tmp_str =3D buf_cpy;
- 		while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D NULL) {
- 			if (strlen(sub_str) =3D=3D 0)
- 				continue;
- 			ret =3D kstrtol(sub_str, 0, &parameter[parameter_size]);
- 			if (ret)
- 				return -EINVAL;
- 			parameter_size++;
- 			if (!tmp_str)
- 				break;
- 			while (isspace(*tmp_str))
- 				tmp_str++;
- 		}
+ 		ret =3D amdgpu_pm_parse_long_params(buf_cpy, parameter,
+ 						  ARRAY_SIZE(parameter) - 1,
+ 						  &parameter_size);
+ 		if (ret)
+ 			return ret;
  	}
  	parameter[parameter_size] =3D profile_mode;
 =20
@@@ -2015,6 -2023,7 +2023,7 @@@ static int pp_dpm_clk_default_attr_upda
  		      gc_ver =3D=3D IP_VERSION(11, 0, 1) ||
  		      gc_ver =3D=3D IP_VERSION(11, 0, 4) ||
  		      gc_ver =3D=3D IP_VERSION(11, 5, 0) ||
+ 		      gc_ver =3D=3D IP_VERSION(11, 5, 1) ||
  		      gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
  		      gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
  		      amdgpu_is_multi_aid(adev)))
@@@ -2023,7 -2032,8 +2032,8 @@@
  		if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
  		       gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
  		       gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
- 		       gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >=
=3D 2))
+ 		       gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
+ 		       gc_ver =3D=3D IP_VERSION(11, 5, 1)) && adev->vcn.num_vcn_inst >=
=3D 2))
  			*states =3D ATTR_STATE_UNSUPPORTED;
  	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
  		if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
@@@ -2036,6 -2046,7 +2046,7 @@@
  		      gc_ver =3D=3D IP_VERSION(11, 0, 1) ||
  		      gc_ver =3D=3D IP_VERSION(11, 0, 4) ||
  		      gc_ver =3D=3D IP_VERSION(11, 5, 0) ||
+ 		      gc_ver =3D=3D IP_VERSION(11, 5, 1) ||
  		      gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
  		      gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
  		      amdgpu_is_multi_aid(adev)))
@@@ -2044,7 -2055,8 +2055,8 @@@
  		if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
  		       gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
  		       gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
- 		       gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >=
=3D 2))
+ 		       gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
+ 		       gc_ver =3D=3D IP_VERSION(11, 5, 1)) && adev->vcn.num_vcn_inst >=
=3D 2))
  			*states =3D ATTR_STATE_UNSUPPORTED;
  	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
  		if (amdgpu_is_multi_aid(adev))
@@@ -3943,18 -3955,14 +3955,14 @@@ out_pm_put
  	return size;
  }
 =20
- static int parse_input_od_command_lines(const char *buf,
- 					size_t count,
- 					u32 *type,
- 					long *params,
- 					size_t params_max,
+ static int parse_input_od_command_lines(const char *buf, size_t count,
+ 					u32 *type, long *params,
+ 					uint32_t max_params,
  					uint32_t *num_of_params)
  {
- 	const char delimiter[3] =3D {' ', '\n', '\0'};
  	uint32_t parameter_size =3D 0;
  	char buf_cpy[128] =3D {0};
- 	char *tmp_str, *sub_str;
- 	int ret;
+ 	char *tmp_str;
 =20
  	if (count > sizeof(buf_cpy) - 1)
  		return -EINVAL;
@@@ -3979,28 -3987,8 +3987,8 @@@
  		break;
  	}
 =20
- 	while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D NULL) {
- 		if (strlen(sub_str) =3D=3D 0)
- 			continue;
-=20
- 		if (parameter_size >=3D params_max)
- 			return -EINVAL;
-=20
- 		ret =3D kstrtol(sub_str, 0, &params[parameter_size]);
- 		if (ret)
- 			return -EINVAL;
- 		parameter_size++;
-=20
- 		if (!tmp_str)
- 			break;
-=20
- 		while (isspace(*tmp_str))
- 			tmp_str++;
- 	}
-=20
- 	*num_of_params =3D parameter_size;
-=20
- 	return 0;
+ 	return amdgpu_pm_parse_long_params(tmp_str, params, max_params,
+ 					   num_of_params);
  }
 =20
  static int
@@@ -4013,10 -4001,7 +4001,7 @@@ amdgpu_distribute_custom_od_settings(st
  	long parameter[64];
  	int ret;
 =20
- 	ret =3D parse_input_od_command_lines(in_buf,
- 					   count,
- 					   &cmd_type,
- 					   parameter,
+ 	ret =3D parse_input_od_command_lines(in_buf, count, &cmd_type, parameter,
  					   ARRAY_SIZE(parameter),
  					   &parameter_size);
  	if (ret)
@@@ -4892,9 -4877,8 +4877,8 @@@ static int amdgpu_debugfs_pm_info_pp(st
  {
  	uint32_t mp1_ver =3D amdgpu_ip_version(adev, MP1_HWIP, 0);
  	uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
- 	uint32_t value, mwatt, centiwatt;
  	uint64_t value64 =3D 0;
- 	uint32_t query =3D 0;
+ 	uint32_t value;
  	int size;
 =20
  	/* GPU Clocks */
@@@ -4915,25 -4899,22 +4899,22 @@@
  		seq_printf(m, "\t%u mV (VDDGFX)\n", value);
  	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB, (void *)&value=
, &size))
  		seq_printf(m, "\t%u mV (VDDNB)\n", value);
- 	size =3D sizeof(uint32_t);
- 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void =
*)&query, &size)) {
- 		mwatt =3D query;
- 		centiwatt =3D DIV_ROUND_CLOSEST(mwatt, 10);
+ 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void =
*)&value, &size)) {
  		if (adev->flags & AMD_IS_APU)
- 			seq_printf(m, "\t%u.%02u W (average SoC including CPU)\n", centiwatt /=
 100, centiwatt % 100);
+ 			seq_printf(m, "\t%u.%02u W (average SoC including CPU)\n",
+ 				   (u32)(value / MILLIWATT_PER_WATT), (u32)(value % MILLIWATT_PER_WAT=
T) / 10);
  		else
- 			seq_printf(m, "\t%u.%02u W (average SoC)\n", centiwatt / 100, centiwat=
t % 100);
+ 			seq_printf(m, "\t%u.%02u W (average SoC)\n",
+ 				   (u32)(value / MILLIWATT_PER_WATT), (u32)(value % MILLIWATT_PER_WAT=
T) / 10);
  	}
- 	size =3D sizeof(uint32_t);
- 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (voi=
d *)&query, &size)) {
- 		mwatt =3D query;
- 		centiwatt =3D DIV_ROUND_CLOSEST(mwatt, 10);
+ 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (voi=
d *)&value, &size)) {
  		if (adev->flags & AMD_IS_APU)
- 			seq_printf(m, "\t%u.%02u W (current SoC including CPU)\n", centiwatt /=
 100, centiwatt % 100);
+ 			seq_printf(m, "\t%u.%02u W (current SoC including CPU)\n",
+ 				   (u32)(value / MILLIWATT_PER_WATT), (u32)(value % MILLIWATT_PER_WAT=
T) / 10);
  		else
- 			seq_printf(m, "\t%u.%02u W (current SoC)\n", centiwatt / 100, centiwat=
t % 100);
+ 			seq_printf(m, "\t%u.%02u W (current SoC)\n",
+ 				   (u32)(value / MILLIWATT_PER_WATT), (u32)(value % MILLIWATT_PER_WAT=
T) / 10);
  	}
- 	size =3D sizeof(value);
  	seq_printf(m, "\n");
 =20
  	/* GPU Temp */

--XytuleQJXo+FUOAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqDKHgACgkQJNaLcl1U
h9DZBQf/eNAsmIZK8Etkb64PLV2NFGZKa3vhLC8EIOFwp1MWUw4T58JLzdFMBozN
YJlVSzGUHP9K3YGVqanPtYzoxiyZNAZNwzybeJwXNV9OU5CRemXHVUgOTwb032Jv
MUT8gpfKOmmp5AulhsUMsK5BrF1kSyCuVlWOKnw1fJ7U7x8OflHzVChytBPqERE2
ZAFrJmMiw08y6qXyF6E8B5a37isPAjzx/fuhnPI31sJ69st5Q7riw41DKnBWP7ne
0dvTAdx2wUMId4c1jCIuRA+YM7IRmG7meZy26ZJVY09CJ0GcKnDV2nNf/COBtqcQ
du7/7sBgM6V4ODrGs1V7tkOb7IzYzA==
=HG6f
-----END PGP SIGNATURE-----

--XytuleQJXo+FUOAx--
