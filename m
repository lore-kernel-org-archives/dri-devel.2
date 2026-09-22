Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D65DC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F79410E740;
	Tue, 22 Sep 2026 17:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W0Oc6+cm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C307610E6C0;
 Tue, 22 Sep 2026 17:21:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F3A0600E2;
 Tue, 22 Sep 2026 17:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615D91F000FF;
 Tue, 22 Sep 2026 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790097691;
 bh=lw3XClRq6WFmNlpAnSS5DAExCQJRDFkeL23ahHR58Ns=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W0Oc6+cmMC1R5seBXuRm0ebYP86unZ78J4LPVCbmcxDSH0bnukjRRk2VgZB4Uc8WC
 PO75uXi+0N/bu2oXV3jE9c+cKKfhjpE73MRxnO2GiqxPsFLb14yzEsHOCtnEZ8R9Fw
 ub14XxDSGwOkGPRQbRG/DbXX28OUrwG32PvbwIf/TCdQwomQZcUCY96qlgQdGKcYa4
 6CLos8xD25M+CD+yG1mTQvObFNwE1/7p0VFQeC/KoZX4+8An6tZYefNOwQoS6QIJv+
 GmbGTErGP4oCkmidolVG19lOK3D4Fo/LUbpHw5jnQrtfSTzHVVEUzpPL6fD5KoKFsb
 fWkomTk6tiyeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] mm/kasan: use hw_pte_t for the early shadow PTE
 table
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, damon@lists.linux.dev, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-7-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-7-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:21:30 +0000
Message-Id: <20260922172131.615D91F000FF@smtp.kernel.org>
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

> kasan_early_shadow_pte is a complete PTE table rather than a software
> PTE value. Declare and define its elements as hw_pte_t so the object uses
> the PTE table storage type.
>=20
> Read the first element through ptep_get(), which returns the software PTE
> value expected by note_page_pte(), instead of accessing hw_pte_t storage
> directly. This also uses the accessor selected by the architecture.
>=20
> No architecture selects ARCH_HAS_HW_PTE_T at this point, so the storage
> representation remains unchanged.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D7

