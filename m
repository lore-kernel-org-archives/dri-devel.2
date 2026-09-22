Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F67C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E89610EDFA;
	Tue, 22 Sep 2026 17:27:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XftxNA+L";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BE110EDF8;
 Tue, 22 Sep 2026 17:27:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C6EE417B5;
 Tue, 22 Sep 2026 17:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9401F00893;
 Tue, 22 Sep 2026 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790098033;
 bh=JfrULAjAYTN79xyC19YGhCr1rxdcFCCfrSjIGCo/tkw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XftxNA+LTBLkWQxw1kEjRiShug4MURxMfQ4eZynKtivgcS37l35AheQ4qlLtnb0w9
 6hXfjqPJM2AruNtPphAPfwWfwVKntrDqAMQJ9Fa9uBPUq3v9tKJBdRRgDzmqPDpciO
 VnaJLkLZvXo1/kFVexlruPNm8ETnkBRJ/HMAB/03cXE6BMioul0DHbT9urywfCAX4c
 RUH4GyHmAaWqqqpjsQEWR2Fp24aRF6V3JPKt1FBYWu99DfTYkFuG1tiPy/p1lCwQ6M
 DRRc8JEt/xtB3bnXX0ioL0VJJx5Xx4eqJiLBkeeOFzviEssH1jUkd6cWRdop1cGc9P
 GV3Oqi6Jj+6jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] mm: use hw_pte_t for generic PTE table storage
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 damon@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-3-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-3-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:27:12 +0000
Message-Id: <20260922172712.AD9401F00893@smtp.kernel.org>
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

> Generic page-table interfaces use pte_t * for both pointers to PTE table
> storage and pointers to software PTE values. Convert the generic
> declarations and their MM, fs, and kernel users together so parameters,
> return types, callbacks, and local pointers that designate table storage
> use hw_pte_t *.
>=20
> Include linux/pgtable_types.h from headers that expose the converted
> interfaces. It continues to provide pgprot_t to vmalloc.h through
> asm/page.h.
>=20
> Keep software PTE values as pte_t and retain pte_t * for value interfaces.
>=20
> No architecture selects ARCH_HAS_HW_PTE_T at this point, so hw_pte_t
> remains an alias of pte_t and this changes the interface vocabulary witho=
ut
> changing representation or behavior.
>=20
> Most of this mechanical conversion was generated with the Coccinelle scri=
pt
> included in the cover letter. The script deliberately ignores pte_t *
> pointers named ptentp because they designate software PTE values. The
> result was then audited, and sites the script could not convert were
> updated by hand.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D3

