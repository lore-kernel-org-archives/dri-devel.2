Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0E2CA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600DB10EAC5;
	Fri,  9 Oct 2026 18:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n0rGnCjY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFFA10EAC5
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:22:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A94D41570;
 Fri,  9 Oct 2026 18:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96C41F000FF;
 Fri,  9 Oct 2026 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791570141;
 bh=PSgtuvzTKTQ258s7HGhGgijbC/siZGtncf0Y5xLeOr0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n0rGnCjYDiMCsNVjOOoHjnmd4kyfeAM6oB+89nwOyMR1YV5pZ+l5wOH3ERyHtXapk
 BT+Pq5nez707hOE+c0j7/wVswk3GtYtbP/Yls8htZ+NSf82av2pA1Q3/qplNKrUunf
 4OV8xTuQwlu4uK4/AOymitVv/mf3z6X6YTBcS+ZzffDjpXF6moTXKqSmCtfQ0V49dk
 9/hBt3VRCVq+qwZvaR1P1ZYiSO/Z1CQH9Z5pDG2Nvu1ZwuiTJAw0os8ZFY5cNBxglm
 y9MrszJBu1iMdD3Cyeasy8qmWK+p5n3Ca5eLcwDztO/CdcD0941RYe/xgIZB41E9Y4
 pmYFHlJRqTG9Q==
Message-ID: <sashiko-outbox-165936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/38] mm/vma: ensure mmap_prepare doesn't set
 actions on a mergeable vma
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org,
 selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-4-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-4-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:22:20 +0000
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

> When a user requests an mmap_action be performed in mmap_prepare, this
> involves populating the VMA range with data.
>=20
> However, if the VMA is mergeable, it might then mistakenly be merged with
> another VMA without having populated the range.
>=20
> Every mmap action currently available sets VMA flags such that the VMA
> cannot be merged.
>=20
> However, to ensure that no future mmap action falls foul of this, assert
> that this is the case upon mmap_prepare validation.
>=20
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D4

