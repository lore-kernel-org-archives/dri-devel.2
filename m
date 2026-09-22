Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4C5C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA8AF10EDEF;
	Tue, 22 Sep 2026 17:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NvEZ3ZR1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FA810EDE6;
 Tue, 22 Sep 2026 17:23:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A331C4142F;
 Tue, 22 Sep 2026 17:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270351F000FF;
 Tue, 22 Sep 2026 17:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790097784;
 bh=FVOP20CywOlOscX6m2SDY5nX87BWQA9RNgIT4wRKV8U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NvEZ3ZR1W88GHhCGwSiECzXDi7Bo1GfHgA6kyq1vMkQsSgOn0UMpebsSBtStaSHdY
 050AnFfezmAfLnrgn5yZhQa5nGF2/mYNuvH47l0iouQReOrMRlHUSwaZEjeCDOEdOn
 tRc0ETValrxXhT/wjt/LphBS8+HXyEqtgho/3Z44YynYa5sMLcL+Tc4m5aFuNF1tUp
 qVdj0z4udi773I/9DYS4rxQBG1z/AllvIGDP5wRY+Qk0hnq7Xxm4g90n3bKUkuB3XN
 +ws3BrBo4o/LsRsi7qfZqOOawwDMyrXgw1St9MNGQ2x8pGTVWlciJUmdw6mlLdWAs4
 MGuihCb/WmFDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] drm/i915: use hw_pte_t for PTE range callbacks
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: damon@lists.linux.dev, bpf@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-8-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-8-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:23:03 +0000
Message-Id: <20260922172304.270351F000FF@smtp.kernel.org>
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

> apply_to_page_range() now passes PTE table storage to its callback as
> hw_pte_t *. Update the i915 remap and selftest callbacks to match the new
> type.
>=20
> Continue to use ptep_get() for software PTE values and set_pte_at() for
> updates.
> The type remains an alias of pte_t on x86 until that architecture opts in.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D8

