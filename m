Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0217DC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A46710ED6F;
	Tue,  8 Sep 2026 20:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mUgNQSRk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9954510ED6F
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:34:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F07760235;
 Tue,  8 Sep 2026 20:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597861F00ACA;
 Tue,  8 Sep 2026 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788899679;
 bh=qUqXvKxxXiUI2Z6BlbfFAF4xv+3v4ywt9F9wctfbeX0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mUgNQSRkEFqX3iOnwuUf4mB0qF1os53i5Hk1cJCVSkSbxtwcRvxdfOwTvVvXmkra+
 VL+lGKB8dRmhqJ1BJzutIsYOPqiDO16k+znkfDPQ/sKgdjHIkqiyH4CTkEVFKcs0IQ
 lXGERSfYhQOrviyRxTqrmwbv5DqleNPWiaItfrTjhhOYPjJ8mdntOCTAgmNee2xPnf
 QRyvlls/s4nb2ES408QQx87Me/m+iCpI9IiBVmtaNVviknIMxnJe+kCgCf3rGDhWXw
 gyTTxBDFwrvWsy3BqgJVKw4uEwfyOyxq/F+pIPEOEc6dbIEH5se/8/7UGkusawaDgK
 sW9++qOBNMp7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/39] bpf: arena: mark arena_map_mmap() mappings
 VM_MIXEDMAP
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org,
 "Marc Zyngier" <maz@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 selinux@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-13-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-13-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:34:39 +0000
Message-Id: <20260908203439.597861F00ACA@smtp.kernel.org>
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
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D13

