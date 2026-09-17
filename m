Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFCAC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D25C10E751;
	Thu, 17 Sep 2026 17:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="joI7Th56";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7761510E751
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:25:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8F75600D4;
 Thu, 17 Sep 2026 17:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B981F00893;
 Thu, 17 Sep 2026 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789665903;
 bh=AurwT6A5xm0dKU9pNkiiFmaxKIywM3FD3DUjlKxgr2M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=joI7Th56uu5orRQmPqqaVfCsA0b6ZZEixJtMRj+Op+HIe4OA+n7+/ERPUNZKEGEb3
 JrG1GFXlvIwZyaJcSwEzPh3wzFRQMdi7Y4twnKQ0oPbpZnSuGm03q4rnO+jXIjTbTK
 kPGDNTadyX/YUO/h3045sUG140w/YCqK0eh3NB7ZCbTJL1CPMNy0NRxk/M2cokG7De
 qmeA1vofGQtMt064p4lXmkwkbnXINxqWS3d/6556gvXWKP9yY/Y1sm82fJfhe8W++4
 gohoe1tUWFGwY23mKmdeG3FokhNfvqel4qVJ/q2ZyZ85BVTwewoxteHoj3K+juzuSS
 yTW2eIjdwRr/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/40] bpf: arena: mark arena_map_mmap() mappings
 VM_MIXEDMAP
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
 kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, selinux@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-14-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-14-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:25:02 +0000
Message-Id: <20260917172502.93B981F00893@smtp.kernel.org>
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

> The bpf_map->ops->map_mmap callback invoked by bpf_map_mmap() can be set =
to
> one of ringbuf_map_mmap_kern(), ringbuf_map_mmap_user(), array_map_mmap()
> or arena_map_mmap().
>=20
> It is convention in mm to mark mappings whose pages the kernel manages
> itself with VM_MIXEDMAP, so the core mm knows not to treat them as ordina=
ry
> page cache or anonymous memory.
>=20
> The map_mmap callbacks ringbuf_map_mmap_kern() and ringbuf_map_mmap_user()
> use remap_vmalloc_range(), which ultimately invokes vm_insert_page() and =
so
> marks the ranges VM_MIXEDMAP, and array_map_mmap() sets VM_MIXEDMAP
> explicitly.
>=20
> However, the exception to this is arena_map_mmap(), which doesn't set the
> flag.
>=20
> This patch corrects this and updates the comment to reflect it.
>=20
> The pages are refcounted and vm_normal_page() finds them regardless of the
> flag, and VM_DONTEXPAND remains set (marking the memory as VM_SPECIAL and
> thus unmergeable). The one effect is that NUMA balancing now skips these
> VMAs, as it already does for the other bpf map mappings, which is the
> reason array_map_mmap() gives for setting the flag.
>=20
> The intent of this patch is to be able to establish the invariant that on=
ly
> PFN-mapped or mixed map ranges may clear the VM_MAYWRITE flag, as is done
> in bpf_map_mmap().
>=20
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D14

