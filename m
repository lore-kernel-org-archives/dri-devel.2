Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5843CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3964510ECAB;
	Tue, 23 Jun 2026 20:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U27ZsWrn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBDF610ECAB
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:45:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35EF360008;
 Tue, 23 Jun 2026 20:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80ED1F000E9;
 Tue, 23 Jun 2026 20:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247545;
 bh=yUYFq5DAAG2SLv4A2CCN+6azP/0BEXvEEkJ88piReNA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U27ZsWrnZfI9G8YWnrDNWEAYbLlRFj1b4RGaKkUFp2kaD7vw+s6sUz9Igtcl++fTs
 ZE2iMXS3bjMnJtExclIN/YPdQXjn4p4EQyzv0JhI8FzvN2YSNQ3oYh6F+32kZuz/Sj
 Lg9hU2WQWl9z6e2hvjwtdfDtbmrjWtQ6IqMk520j9a4knpaaNIgsOG1u1NIPc9O95h
 61ErTcUwf00Alt//LeH/SQo28Iq0emhewCXg9td2zlNbBR1W/sy3Fwnws23/0dYNqN
 Tt4wtk1GzcbKAIo7e82pRrqwIuJXST30fzoX9wqSKYBbsKsHyFPm5Ze9jgXQsrZbxs
 nkLG9BspJ/3mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] gpu: nova-core: split FbLayout into FSP and
 non-FSP versions
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260615-blackwell-fixes-v1-10-f2853e49ff7d@nvidia.com>
References: <20260615-blackwell-fixes-v1-10-f2853e49ff7d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:45:45 +0000
Message-Id: <20260623204545.A80ED1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The overall framebuffer size (`fb_size`) is calculated but omitt=
ed from `FbSizes`, causing the `fbSize` parameter in `GspFwWprMeta` to inco=
rrectly default to 0 on FSP architectures.
--

commit e3787f5a66f5e8d087e62ad8eace078a355f8a6f
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: split FbLayout into FSP and non-FSP versions

The commit splits `FbLayout` into `FbRanges` and `FbSizes` to distinguish
between pre and post FSP architectures. For post-FSP architectures, only
sizes are calculated and passed instead of ranges.

> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index 725e428154cf0..facecb8b411fe 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
[ ... ]
> +/// Framebuffer region sizes needed for GSP-FMC boot.
> +#[derive(Debug)]
> +pub(crate) struct FbSizes {
> +    /// VGA workspace size, in bytes.
> +    pub(crate) vga_workspace_size: u64,
> +    /// FRTS size, in bytes.
> +    pub(crate) frts_size: u64,
> +    /// WPR2 heap size, in bytes.
> +    pub(crate) wpr2_heap_size: u64,
> +    /// Non-WPR heap size, in bytes.
> +    pub(crate) heap_size: u64,
> +    /// PMU reserved memory size, in bytes.
> +    pub(crate) pmu_reserved_size: u32,
> +    /// Number of VF partitions.
> +    pub(crate) vf_partition_count: u8,
> +}
> +
> +impl FbSizes {
> +    /// Computes the framebuffer region sizes for GSP-FMC boot.
> +    fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Self> {
> +        let hal =3D hal::fb_hal(chipset);
> +        let fb_size =3D hal.vidmem_size(bar);
> +
> +        Ok(Self {
> +            vga_workspace_size: u64::SZ_128K,
> +            frts_size: hal.frts_size(),
> +            wpr2_heap_size: gsp::LibosParams::from_chipset(chipset)
> +                .wpr_heap_size(chipset, fb_size)?,
> +            heap_size: u64::from(hal.non_wpr_heap_size()),
> +            pmu_reserved_size: hal.pmu_reserved_size(),
> +            vf_partition_count: 0,
> +        })
> +    }
> +}

[ ... ]
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/=
fw.rs
> index 4db0cfa4dc4d1..042b0122e98dc 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
[ ... ]
> +        let fields =3D match fb_info {
[ ... ]
> +            GspFbInfo::Sizes(sizes) =3D> WprMetaFields {
> +                non_wpr_heap_size: sizes.heap_size,
> +                gsp_fw_heap_size: sizes.wpr2_heap_size,
> +                frts_size: sizes.frts_size,
> +                gsp_fw_heap_vf_partition_count: sizes.vf_partition_count,
> +                vga_workspace_size: sizes.vga_workspace_size,
> +                pmu_reserved_size: sizes.pmu_reserved_size,
> +                // When only sizes are supplied, offsets and several oth=
er parameters are not used.
> +                ..Default::default()
> +            },
> +        };
> +
[ ... ]
> -            gspFwHeapVfPartitionCount: fb_layout.vf_partition_count,
> -            fbSize: fb_layout.fb.end - fb_layout.fb.start,
[ ... ]
> +            gspFwHeapVfPartitionCount: fields.gsp_fw_heap_vf_partition_c=
ount,
> +            fbSize: fields.fb_size,

[Severity: Medium]
Since `fb_size` is calculated in `FbSizes::new()` but not saved into `FbSiz=
es`,
`fields.fb_size` will be set to 0 via `..Default::default()` for FSP archit=
ectures.

Even though the comment mentions that "offsets and several other parameters=
 are
not used" by FSP, can omitting `fb_size` here and passing `fbSize` as 0 in
`GspFwWprMeta` cause firmware initialization failures or memory mapping err=
ors
if the firmware still relies on this field?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-blackwell-=
fixes-v1-0-f2853e49ff7d@nvidia.com?part=3D10
