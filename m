Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AECC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A8D10E2FE;
	Tue, 22 Sep 2026 17:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DdYKdpmx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2884410E2FE;
 Tue, 22 Sep 2026 17:19:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E02AC41FEB;
 Tue, 22 Sep 2026 17:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AD91F000FF;
 Tue, 22 Sep 2026 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790097554;
 bh=7lz0VgCpGAx/LnBgEFLc5j8/O+Qhz3D9nWW31eDU4eY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DdYKdpmxo2sEdyUjPnkVLHzQz9QdIEM3niWUbASl1udcAIEcqmumcPhCK2lpnwBqy
 Wuec7t4087JyxfNzIkUo47F21Z0h/v4xqCpCa72hOQZWEPbNvyZFZ6YhwAeR3Xevxo
 JR2DDykynr3Dtpcc32/+WO1va3T/9Q7zel9RMP/DKCMjpmeMfyfLIZ1tm8Ihw91U1M
 ep2vQD3ux8jaCmOdQy2YM1fQMrRhw9g9QWhR7AIUwV6f0k5ZpRg4d9ZU9rZ0foCjrS
 NSpdntQDtRB5f6c4oynGd4GJKJtx6yB54TXJAGqiyC4LdnhOQqhv86jYPxhpwdkNA6
 s0lhp90rc50LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/9] mm: convert PTE table entry to pte
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, damon@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-5-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-5-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:19:13 +0000
Message-Id: <20260922171914.63AD91F000FF@smtp.kernel.org>
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

> The non-MMU stub receives hw_pte_t but returns a software PTE value. It
> has no attached PTE that requires ptep_get(), so convert only the stored
> entry through __pte_from_hw().
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D5

