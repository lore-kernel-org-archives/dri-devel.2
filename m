Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E24EC982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6B210F028;
	Thu, 17 Sep 2026 17:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mDzZpsWp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1390A10F028
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:34:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA12D40B90;
 Thu, 17 Sep 2026 17:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B7B1F00893;
 Thu, 17 Sep 2026 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666460;
 bh=D7EIUiCSW8iily/HtmC1xEaz+vgSGhAgleNdQGw5lnI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mDzZpsWpAaNakqQeQfyFP8wSGhGbnPPtjnarV9/Me+o/MXdHwd2gYmLzQFUmfuDdp
 zmjXnMnSel0sqz5b8ba9VDD4MXsvFlN5hI1Y3obO7AUFhSB5Jp1nSHrHluhyMKUqjI
 fi+4pNllDyYGwK0Rz27M4DC0U5KqNXff4UPpAnDnfFz+DDGKUszX+fvAZkIqAZR3+C
 s9B/jNjZk+tp6otqaaMaJPPB0H1emJHRHozetlKe0GN5BEpJ5o7y/5gKw/kyryjEBm
 oFBBF4LSdMTs4enCyW8oA24bgEYokI2lfjUa/eogAdEuWmDk+8A31gDHLS3leKiIDZ
 /InT/Uizwh+Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/40] ALSA: pcm: use vm_insert_page() to map PCM
 status page
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-scsi@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, selinux@vger.kernel.org, bpf@vger.kernel.org,
 kvmarm@lists.linux.dev
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-13-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-13-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:34:19 +0000
Message-Id: <20260917173419.E0B7B1F00893@smtp.kernel.org>
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

> There's no need to keep a fault handler around for this, instead map on
> mmap.
>=20
> While we're here, rename area to vma to be consistent.
>=20
> This correctly makes the mapping a mixed map mapping.
>=20
> This works towards establishing the invariant that only PFN mapped or mix=
ed
> map mappings may clear the VM_MAYWRITE flag. The status page mapping clea=
rs
> VM_MAYWRITE, so it must be kernel-owned; the control page mapping remains
> writable and is left fault-based.
>=20
> The assumption is made that the struct pcm_mmap_status structure is at mo=
st
> a page in size, which is asserted as a build bug.
>=20
> This is safe to assume, as the size of the structure is 56 bytes at most.
>=20
> Acked-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D13

