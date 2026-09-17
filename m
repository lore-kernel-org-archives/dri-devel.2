Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326D1C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5641C10EFEE;
	Thu, 17 Sep 2026 17:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lfAgDV6S";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB1B10EFEE
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:30:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D9158600D4;
 Thu, 17 Sep 2026 17:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5401F000FF;
 Thu, 17 Sep 2026 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666209;
 bh=TQUt3Ft0KayLMo0d7si3tE5C0B89992OAzVxI96NWsg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lfAgDV6Snf0fVDvkZdXdA4cdlt7zKxZ2lAQ47ceAnxNHyvgzz3xIjTX79k00k7V3+
 pvyNUNoCg72svQbb/pt4t8OSkCr5WGCSb3+e3GmUoZoDMQDgAFw3nQpHFDw22wYg0E
 kMM3Riml7CVNuX+TmqkXKpb+arKNWWh1LjI/NI2kijbbLWO0xn2kqUg/JuRQOXT7gz
 8MuYvKuXjDCMxfK+nBt3vPVjSfgdktQRF3593d/HgnQVXX3coN6L0tLg1k2gW0FX4+
 d5M0ZwZAYb7RDyNxBIpMbtbOFj/pDhjFPJcd+Vku5eGhmZu0Gj5QdvZWHH+SsPQabT
 TZpV6nTE8cKRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/40] uprobes: remove VM_IO, set VM_MIXEDMAP for
 mapped kernel pages
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: selinux@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>,
 linux-scsi@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org,
 "Marc Zyngier" <maz@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 bpf@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-22-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-22-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:30:08 +0000
Message-Id: <20260917173008.BA5401F000FF@smtp.kernel.org>
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

> These are not MMIO pages so VMA_IO_BIT is an inappropriate flag to set.
>=20
> Instead, set them VMA_MIXEDMAP_BIT as they are kernel mappings and this is
> the appropriate flag to set for those.
>=20
> This provides the semantics required - no VMA merging is permitted, but
> does not prevent GUP.
>=20
> However this has no meaningful impact as these are refcounted and thus can
> be GUPed.
>=20
> A previous commit already prevented __mm_populate() from being invoked on
> XOL areas, which VMA_IO_BIT was previously relied upon to do, so that is =
no
> longer required.
>=20
> Both VMAs set a VMA name, so always_dump_vma() returns true before
> vma_dump_size() reaches its VMA_IO_BIT check, and thus there is no change
> in core dump behaviour.
>=20
> Change this for both the core xol_add_vma() function and the x86-specific
> get_uprobe_trampoline() function.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D22

