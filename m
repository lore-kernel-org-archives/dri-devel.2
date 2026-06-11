Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D00CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 221AD10E23D;
	Thu, 11 Jun 2026 17:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KarMgPbq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4906E10E23D
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:21:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 47067600AA;
 Thu, 11 Jun 2026 17:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA401F00893;
 Thu, 11 Jun 2026 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781198483;
 bh=rxmT4EXVrC2yPmlUW4UrcRP96HMPM0knxSTqoonqRFI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KarMgPbqavGNaEzvKuW2iO/5ecGq8qH0Uy9XJj+4xgePc0h184A9mTQYqTw8gkqX+
 i45ytQL4I5sCEov+ztcyLexwBWskQKipGwva+an+Mn89MDysUvEmUdzol/CVp/AVME
 Ks8pZyVqtEb5d+fcddxndf9arSV8K90bOzUdpYqPtH4aKWU+c4y7eKp28r/sb3Euxp
 GWCMbCQYJkH1ziTFKZw41bsIL4SnLkAyEcr8hMgpJ8c7JYAeqRvw8Mwt98fDpvr3oM
 KFfpTAP+/7uA5XWWyycqclCi201bDYyu6uohrLImB3Ba1ibrp6ORfPrzdanmGH7zsm
 hpD3inE759BBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/20] rust: io: rename `Mmio` to `MmioOwned`
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260611-io_projection-v4-6-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-6-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:21:20 +0000
Message-Id: <20260611172122.7AA401F00893@smtp.kernel.org>
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

> Most users would more commonly reach out to a view of `Mmio` rather than =
an
> owned instance of `Mmio`. Only implementor of `Io` like `Bar` or `IoMem`
> would need the owned version. Thus, rename `Mmio` to `MmioOwned` so that
> the name `Mmio` can be used for the view type instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D6

