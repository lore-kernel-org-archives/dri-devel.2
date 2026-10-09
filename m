Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F20ACA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B3210EB1F;
	Fri,  9 Oct 2026 18:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j2NCh4jg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B1D10EB1F
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:52:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85B3960267;
 Fri,  9 Oct 2026 18:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBD01F000FF;
 Fri,  9 Oct 2026 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571931;
 bh=iS6gRDNVxVdWwjfR0EFYGfvTS5rkURkUxECDqrFlPrs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j2NCh4jgs2Y4S8aWErXY5aLYgPFNf/euPSNPQbIC/vHAKPppC4cDfTN8BceM8Zoqc
 eQNVyKcjXdjBjsIuz8ewFbTsgAfzaUa+7GLROxrnEMKEdEmYPxwlzKPWgjuXIqBS9J
 heEhaR5G/+qfLK4nX7AZWDGVBpkjfOMwlt0jJqyfQZMznhdgbZhZlzXaDsQ9Mob7fR
 COXx8eU+iKRvxVKtdab3GgGkyo7cpiPgnjbXb9r4D/V73EigZx5vQYoS/BGdu1i+/B
 eMn+gXDMUGd93t6/pH+LDLz6sI28FMn6O+UOkAfhUHSmN0R2lSKE1xCrrIvN5uB0As
 jbDBAVTpqlnTg==
Message-ID: <sashiko-outbox-165985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 38/38] mm/huge_memory: remove vma_is_special_huge()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-rdma@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-usb@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-scsi@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, selinux@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-38-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-38-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:52:09 +0000
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

> vma_is_special_huge() tests whether either the VMA_PFNMAP_BIT or
> VMA_MIXEDMAP_BIT is set (i.e. whether the VMA is not mm-managed),
> but with a DAX carve-out.
>=20
> DAX however no longer sets VMA_MIXEDMAP_BIT, so this carve-out is no long=
er
> required.
>=20
> Therefore test for !vma_is_mm_managed() instead and also drop the
> VMA_IO_BIT check, as it is now redundant since it is enforced that
> mm-managed mappings may not set VMA_IO_BIT.
>=20
> This also eliminates another overloaded use of 'special' within mm.
>=20
> No functional change intended.
>=20
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D38

