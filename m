Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBD7C624DA
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC6310F4FF;
	Thu,  3 Sep 2026 10:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O1ccCcYu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C8910F4FE;
 Thu,  3 Sep 2026 10:40:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 289F8600D4;
 Thu,  3 Sep 2026 10:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF641F000E9;
 Thu,  3 Sep 2026 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788432045;
 bh=rFP8MZSPreuyFV+kIBVC97RoRv+t3a0YVteWnIuDHZg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O1ccCcYuZPfpTRf2+GXrYxW8aySXe0VfKpmKvIjc9gYA8CpeWvWzonEhSRwBr6JR6
 wlVeAbDwLa50zO/EQ+Ad/mRBGvNBSZK+DQ8u673b6gdowNlcAhEkLoT1zxapl1KQLg
 M+1H0283l/1yp2Mw89E4AUgD5POg9KajQmYEsmnCnfqkXfo6NtFumYXgAZgkARTaGP
 iuWtrjn6Wqbjysh7G8nHkkyR2IWoUw0R7B4lVc7AC2AoHRCFnS2pDj+cYRyOLgNyT9
 01w1VjdCp3iMLqX9Y2JVglTwJUSGKWDIz8GNDW7rT70dvQSNgErQEddUuZXzIM7m72
 y+o9UhvK74H+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] mm: convert PTE table entry to pte
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: damon@lists.linux.dev, bpf@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903103002.1091859-6-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-6-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:40:45 +0000
Message-Id: <20260903104045.8BF641F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D5

