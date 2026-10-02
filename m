Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F57CA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3658010E57A;
	Fri,  2 Oct 2026 09:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ev0mzQ8p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67FBE10E556;
 Fri,  2 Oct 2026 09:53:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E84760A6F;
 Fri,  2 Oct 2026 09:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922BD1F00893;
 Fri,  2 Oct 2026 09:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790934790;
 bh=V9eweX5GzvdtWPMv8Zy3U2sIpaLtu0cxEfa92kCEUO4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ev0mzQ8pHx/l3R+grkxPjEE0Bsaq9N539uUU0kye7V3qFKQUa3QcJKSYg/7HlgZ5r
 e3jocM/kB41pBhO+mrRKXVetVwhKLYiz8FQwSLawwEZ9FHHEM1rOL9iiY1ooE5mMIa
 18kd02RWcg0T0pTcFhxbps3Rrp1pZ/Ya7fsCSE/ruyzSWDf2soGOXsRqtiblCX4aDb
 ewTfljJ2053P4+5NM4u9j5FmfX5KguXqdr34mi/hMuMu0TpUt/5UlN7J7dgtSnhi+P
 S23t+4akEydrJhrdrdHK80y/9J/SvKwZvxLnJr1x0PaEwc533sawj1A9XV2bGS7yCa
 d7uxCuvX8HUsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] media: Consolidate AtomISP v2 PCI IDs in the
 pci_ids.h
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>
References: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:53:09 +0000
Message-Id: <20261002095309.922BD1F00893@smtp.kernel.org>
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

> We have a few drivers using same pair of the PCI IDs across the kernel and
> there seems more to go, consolidate AtomISP v2 PCI IDs in pci_ids.h datab=
ase.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002094813.8564=
39-1-andriy.shevchenko@linux.intel.com?part=3D1

