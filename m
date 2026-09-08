Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52507C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8199910ED83;
	Tue,  8 Sep 2026 20:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QVENvXy+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C7F910ED83
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:42:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 651F7601F6;
 Tue,  8 Sep 2026 20:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505551F00A3A;
 Tue,  8 Sep 2026 20:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900132;
 bh=ZEHXXIn5MPhqvEFo2IZk3OAkWv+n7ylTTyz8NGZ5HlU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QVENvXy+w5E29pNkrXUvhpfma0eJ3SaQ+KREk1R4WPFe8FJyVnPghIwnav7AmxPqD
 wUhW5K87e3jZF3kZqKuniPKHYddBRKFrMN2jMBtZKlNzqMqf/6FSiuh4nT2VidtUH4
 eKfio2fk1wETy+nlvz4MHr554/3hCaJDC6OmhkA11SInoZn9rIEv7DQjYg9A6Hsqlz
 1Q+PaAYqGDODlaYIRoC60PDkfBU3n0Re063FmUkWfyyXxKc83gvQbbYmZMNnlAa+dy
 nAFjKqOneyTB7FQ8pIIBEF7tiohdLxYaC+o+UXzajRaRTEy5EcUYZr8LdV60h4ZyHB
 1UKEYG6OL4ayg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/39] mm/vma: add and use vma_[flags]_is_fixed_mapping
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Marc Zyngier" <maz@kernel.org>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, linux-scsi@vger.kernel.org,
 bpf@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 selinux@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-16-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-16-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:42:10 +0000
Message-Id: <20260908204211.505551F00A3A@smtp.kernel.org>
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

> This determines whether a VMA cannot be expanded or merged because what
> they mapped was determined to be a set size at mmap time.
>=20
> This typically refers to kernel-owned mappings, however VMA_DONTEXPAND_BIT
> is not reliably set alongside VMA_PFNMAP_BIT or VMA_MIXEDMAP_BIT, so we
> must explicitly test for this for now.
>=20
> We also explicitly test for VMA_PFNMAP_BIT as VMA_DONTEXPAND_BIT may not =
be
> set for VMA_PFNMAP_BIT's despite the one implying the other.
>=20
> Use this predicate in vma_flags_can_merge() and in check_prep_vma() in the
> mremap logic testing to see if mremap() can expand the VMA. The criteria
> for khugepaged and MADV_COLLAPSE eligibility in
> __thp_vma_allowable_orders() are precisely those for mergeability, so use
> vma_can_merge() there (with an expanded comment).
>=20
> This obviates the need for the VM_NO_KHUGEPAGED mask, so remove it.
>=20
> Hugetlb VMAs remain excluded from khugepaged as hugetlbfs always sets
> VMA_DONTEXPAND_BIT.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D16

