Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84470CCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC93510E031;
	Fri, 16 Oct 2026 14:23:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2328610E031
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 14:23:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E476140AD8;
 Fri, 16 Oct 2026 14:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BC21F000C4;
 Fri, 16 Oct 2026 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792160626;
 bh=V6R4f1oCrKXkw4ISA2vwnimqveCaTjz1x7+uWw02vV0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Cwlv6VUhvAX9mw39u+BNIhqWfBmuSQ6ls6DDF9ETswpDS9J8ocaSRCjDTAlpjHiVj
 z7vk1gGK1ZJL/GjWgVBflX/ADJRKfpH6bOViA7J6NBigsbPVxoPT2vlBMQLtLRsF7y
 OvqYUxukHjQYJI4HMHjH8WY0ZZ5ABuDFQ8ZJ5OGbqrQh3fc1eWN36+z/MUzDcVJYQb
 uSrV6TwF9zMyKemL2BuUwQSfbHRAxGbFVXQ8qe2wIbRpxuEvtG5CNkAk+/N15Pj3bO
 eSskpxqteFxHCzAjuH6BgEqbtqVHp33aS+XwTjif61ErVk08HIp9wnHccWz+HnOjGy
 4EUVeN0bEl1Tw==
Message-ID: <sashiko-outbox-174432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: validate SRAT subtables before parsing
To: "Jiale Yao" <yaojiale02@163.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261016141504.2794541-1-yaojiale02@163.com>
References: <20261016141504.2794541-1-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 14:23:46 +0000
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
- [High] drm/amdkfd: unaligned access and endianness bugs in SRAT parsing
--

commit 172d11efb00c0dedbe45ba294e5438f125fd1ad9
Author: Jiale Yao <yaojiale02@163.com>

drm/amdkfd: validate SRAT subtables before parsing

The KFD SRAT walker reads the first subtable length without checking that a
header is present and trusts subsequent lengths when accessing CPU and gene=
ric
affinity records. This patch validates the table header, subtable ranges, a=
nd
supported typed records to prevent out-of-bounds reads.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_crat.c
> index 6e0df685503d0..32d7573dffc94 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
[ ... ]
> @@ -2056,27 +2056,33 @@ static void kfd_find_numa_node_in_srat(struct kfd=
_node *kdev)
[ ... ]
>  		switch (sub_header->type) {
>  		case ACPI_SRAT_TYPE_CPU_AFFINITY:
>  			cpu =3D (struct acpi_srat_cpu_affinity *)sub_header;
> +			if (subtable_len < sizeof(*cpu))
> +				goto invalid_srat;
> +
>  			pxm =3D *((u32 *)cpu->proximity_domain_hi) << 8 |
>  					cpu->proximity_domain_lo;

[Severity: High]
cpu->proximity_domain_hi is at offset 9 in the packed acpi_srat_cpu_affinity
struct. Can casting it to a u32 pointer lead to an unaligned memory access,
potentially triggering exceptions on architectures that do not support nati=
ve
unaligned loads?

Also, on Big-Endian architectures, reading proximity_domain_hi as a u32 loa=
ds
bytes in reverse order. Does shifting by 8 discard the most significant byte
instead of clock_domain[0], resulting in a corrupted pxm value?

>  			if (pxm > max_pxm)
> @@ -2084,6 +2090,9 @@ static void kfd_find_numa_node_in_srat(struct kfd_n=
ode *kdev)
>  			break;
>  		case ACPI_SRAT_TYPE_GENERIC_AFFINITY:
>  			gpu =3D (struct acpi_srat_generic_affinity *)sub_header;
> +			if (subtable_len < sizeof(*gpu))
> +				goto invalid_srat;
> +
>  			bdf =3D *((u16 *)(&gpu->device_handle[0])) << 16 |
>  					*((u16 *)(&gpu->device_handle[2]));

[Severity: High]
Reading gpu->device_handle using u16 pointer casts correctly extracts the
segment and BDF on Little-Endian, but can this swap the bytes of both the
segment and the BDF on Big-Endian systems? Does this break GPU NUMA node
discovery on Big-Endian platforms?

>  			if (bdf =3D=3D pci_id) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016141504.2794=
541-1-yaojiale02@163.com?part=3D1
