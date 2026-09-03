Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B295FC624DA
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C133A10F509;
	Thu,  3 Sep 2026 10:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D0p67jG8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE33F10E0E3;
 Thu,  3 Sep 2026 10:48:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B5C5438F0;
 Thu,  3 Sep 2026 10:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF221F000E9;
 Thu,  3 Sep 2026 10:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788432528;
 bh=8GGHXpoinHMF8S3XF+nIIttC4DJt7cPH2zOWSyjOLMk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D0p67jG81rSHSrJG5QAe435bHXddsWghRHB0VqZPykQEYgTMVVt2g9gEF/FEmMh5n
 o/p/SM1G8lmw0j0BoY128VNEO0viJykmsEP7VXs8saboatZHTjeVQDeuIHTgDQ+70e
 CXewnJcVqJYbGn3hu3qxegzZyNvFqsvXQxIP6jd+dA6TsTuzGNA8Pl1A5qnSRxyyio
 07/JJL7KkSaxhHOBtVPjxwIthxoc7useKZWfEMGtIqtYKU8Os8jeMqcq1Z1xpiKuQU
 O1a/DCQ+MCBuHcyERt94WQT3CQlw8joj9YzEZYqOQTHD69eNcugK5XcCBvthZw1yB0
 uDr1aROVc7I3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] mm: use hw_pte_t for generic PTE table storage
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: intel-gfx@lists.freedesktop.org, damon@lists.linux.dev, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260903103002.1091859-4-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-4-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:48:44 +0000
Message-Id: <20260903104844.DEF221F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D3

