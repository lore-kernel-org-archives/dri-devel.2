Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E176C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8728B10E169;
	Sun,  5 Jul 2026 08:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MVj2HJbB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6187F10E169
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:17:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 581A260052;
 Sun,  5 Jul 2026 08:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC071F000E9;
 Sun,  5 Jul 2026 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783239444;
 bh=IReY2qpkTZ9HFmy4i2itPiMHAlBWzg9RKPPI+b+wRhk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MVj2HJbBoMda3jmDw4ueruIWlYJ52sSrEUivOC27AVb8OdXpHAj+YftlqNmG3XE4g
 N+gFDviN86uSYVHieBDp610EBido4Xjhv/cOiUwflgs29gjGleyUSzkQbF26DXqvFf
 YZpLKLJ0D3qFpWzKNlN5Wn62vS+/zM8KNpoZWAdwtxUuWkv0TflmuAyMRKTPVCE5Uv
 JYT+xj3xB8SL9kEPHy//1eY1DHEDTEY18W1iHVJ8aapmEy+21rTpgWD9LPzZ/WwMWA
 RLFEZWmA/WHo72RjRtjmKdMidTQYhC/+enhvVkBeFOistjO6/8y49hnBPJUfojUAvP
 2WGHWqYRvoNkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] drm/msm/a6xx: Increase HFI GX perf level limit
 to 24
To: "Akhil P Oommen" <akhilpo@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260705-kaana-gpu-dt-v2-1-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-1-6ac53de56314@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 08:17:23 +0000
Message-Id: <20260705081723.BDC071F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Expanding fixed-size arrays in packed HFI structures silently shif=
ts the offsets of subsequent fields, breaking communication with older GMU =
firmwares.

Pre-existing issues:
- [Critical] Out-of-bounds stack write in `a6xx_hfi_send_perf_table` and `a=
6xx_hfi_send_perf_table_v1` due to a mismatch between `GMU_MAX_CX_FREQS` an=
d the `cx_votes` array size.
--

commit b7dcd380638139f2d4f6982c947797f34b9ff256
Author: Akhil P Oommen <akhilpo@oss.qualcomm.com>

drm/msm/a6xx: Increase HFI GX perf level limit to 24

Newer Adreno GPUs expose more than 16 GX frequency levels. Introduce
HFI_MAX_GX_LEVELS and use it to size the perf-table and bandwidth-table
GX vote arrays, and to derive GMU_MAX_GX_FREQS, so these levels are not
truncated.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.h
> index 3f96b10b5f61a..62e3fb230cd3a 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -20,7 +20,7 @@ struct a6xx_gmu_bo {
>  	u64 iova;
>  };
> =20
> -#define GMU_MAX_GX_FREQS	32
> +#define GMU_MAX_GX_FREQS	HFI_MAX_GX_LEVELS
>  #define GMU_MAX_CX_FREQS	6
>  #define GMU_MAX_BCMS		3
> =20
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/=
adreno/a6xx_hfi.h
> index e10d32ce93e0c..f4da73a555c65 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> @@ -5,6 +5,7 @@
>  #define _A6XX_HFI_H_
> =20
>  #define HFI_MAX_QUEUES 3
> +#define HFI_MAX_GX_LEVELS 24
> =20
>  struct a6xx_hfi_queue_table_header {
>  	u32 version;

[ ... ]

> @@ -119,7 +120,7 @@ struct a6xx_hfi_msg_perf_table_v1 {
>  	u32 num_gpu_levels;
>  	u32 num_gmu_levels;
> =20
> -	struct perf_level gx_votes[16];
> +	struct perf_level gx_votes[HFI_MAX_GX_LEVELS];
>  	struct perf_level cx_votes[4];

[Severity: High]
Does expanding this fixed-size array in a packed structure break compatibil=
ity
with older GMU firmwares?

Because a6xx_hfi_msg_perf_table_v1 is a packed structure, increasing the si=
ze
of gx_votes from 16 to 24 elements shifts the offset of cx_votes. During dr=
iver
initialization on older Adreno GPUs, firmwares expecting the previous fixed=
-size
v1 performance tables might read cx_votes at the old offset and receive
uninitialized zeros instead of the actual frequencies, which can cause syst=
em
instability.

This same offset shift appears to happen below in struct a6xx_hfi_msg_perf_=
table
as well.

[Severity: Critical]
This is a pre-existing issue, but can this cause a stack buffer overflow?

The cx_votes array is hardcoded to a size of 4 here. However, in
drivers/gpu/drm/msm/adreno/a6xx_gmu.h, GMU_MAX_CX_FREQS is defined as 6.

During initialization, a6xx_hfi_send_perf_table_v1() iterates up to
gmu->nr_gmu_freqs (which can be up to 6 on newer platforms with more OPPs)
and writes to msg.cx_votes[i] on the stack:

drivers/gpu/drm/msm/adreno/a6xx_hfi.c:a6xx_hfi_send_perf_table_v1() {
	...
	for (i =3D 0; i < gmu->nr_gmu_freqs; i++) {
		msg.cx_votes[i].vote =3D gmu->cx_arc_votes[i];
		msg.cx_votes[i].freq =3D gmu->gmu_freqs[i] / 1000;
	}
	...
}

If gmu->nr_gmu_freqs exceeds 4, this loop appears to write out-of-bounds on
the stack, which can corrupt memory. This identical loop is also present in
a6xx_hfi_send_perf_table().

>  } __packed;
> =20
> @@ -128,7 +129,7 @@ struct a6xx_hfi_msg_perf_table {
>  	u32 num_gpu_levels;
>  	u32 num_gmu_levels;
> =20
> -	struct perf_gx_level gx_votes[16];
> +	struct perf_gx_level gx_votes[HFI_MAX_GX_LEVELS];
>  	struct perf_level cx_votes[4];
>  } __packed;
> =20
> @@ -144,7 +145,7 @@ struct a6xx_hfi_msg_bw_table {
>  	u32 cnoc_cmds_addrs[6];
>  	u32 cnoc_cmds_data[2][6];
>  	u32 ddr_cmds_addrs[8];
> -	u32 ddr_cmds_data[16][8];
> +	u32 ddr_cmds_data[HFI_MAX_GX_LEVELS][8];

[Severity: High]
Does increasing the size of ddr_cmds_data risk breaking length validation
on older firmwares?

Expanding this array increases the overall message size by 256 bytes, which
older GMU firmwares might reject if they strictly validate the length of the
bandwidth table message.

>  } __packed;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-kaana-gpu-=
dt-v2-0-6ac53de56314@oss.qualcomm.com?part=3D1
