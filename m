Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DB7C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADBAE10EF48;
	Wed,  5 Aug 2026 16:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AvFIte3V";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EBE110EF47
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:42:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ADF4740AE2;
 Wed,  5 Aug 2026 16:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399321F00A3A;
 Wed,  5 Aug 2026 16:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948156;
 bh=TIoB2BgUaZdimMEqxoehkcJbvD31AsnjBFEWX3HglBo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AvFIte3VHaAOoWBbX/fN5JGSYuon/NnODMHUmHMUuAaN1NRd+3pI0CytFCU1Jo2p1
 QkCxPGtcCxdq1gyq8e1VZVzpmKcFgGSOXLf8ab/GE5irA5mFsOBNAdBAIMV4BZtWYr
 oN8gPqSZJkSBs/y+Ix5I1LSaFZTFc9NQI+e+h8vNGWMdVOIjjLszRSkDgqIjGYfGoP
 PO2XYSY4Oe7aLBxnbONOT66D5/IRz+RxcYqaIXizCht6pQsAzlQrb/tGtD1CMaBfgR
 fjeLfWl/Yc+6ZuNFA5ADYCl5pUOYZcqwoMHYgySj1HwLfrtemgBuKyB/j7HFdDwvs6
 3RyBabkyYCMbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/16] gpu: nova-core: specify base type for registers
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-7-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-7-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:42:35 +0000
Message-Id: <20260805164236.399321F00A3A@smtp.kernel.org>
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

> All registers use the same base type, which is `<Bar0 as IO>::Target`. Th=
us
> add the base parameter to `register!` invocation.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D7

