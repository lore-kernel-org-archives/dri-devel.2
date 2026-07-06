Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABB6C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAFB10E945;
	Mon,  6 Jul 2026 12:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xvc4hMCl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF42F10E945
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:54:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 736B2600BB;
 Mon,  6 Jul 2026 12:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDF11F000E9;
 Mon,  6 Jul 2026 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342480;
 bh=ssZxNUHOvHadFm32pEIllAUjpxyvZEGt8R1ly+q6RIU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xvc4hMClS+Prxl3ZJDgcyOL7H8n4JuWDfAvgcO5RE6IA8kzHB82X5yhdkXBdbYNLb
 oeBi/7HNKE3dd7lHxtUmVr6OTUiUuy26HcupuLQDBkI4h7cC2fAMgaS+oWZSsXhVPd
 BQN6d2ByKrmdCm/aG4x4bObumWobA7YK1S65ZhCBFtbVtQMwkcTKQLnr4ExV+/jJ31
 GT/OHdXJuir4Nri1Lc60n/BW/g7UWRsWOsDOkPc46iG1888y36G2pTikDQHhEFO26G
 EgEJtY9kt1flmmvPbJnxPDzIwSd0ClWrU8Ls+ebx7YKKV9w06GDVeEghalbAvQ6Ngo
 iMxSB1EShtjSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/20] rust: io: remove `MmioOwned`
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 linux-pci@vger.kernel.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260706-io_projection-v6-11-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-11-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:54:39 +0000
Message-Id: <20260706125439.DCDF11F000E9@smtp.kernel.org>
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

> `Io` trait is now very easy to implement. Thus, implement it on `Bar` and
> `IoMem` directly and remove the `MmioOwned` struct.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D11

