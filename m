Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641AAC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9BDF10ED61;
	Tue,  7 Jul 2026 14:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gBG3ZsPE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F1510ED61
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:12:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BECAF61833;
 Tue,  7 Jul 2026 14:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BE61F000E9;
 Tue,  7 Jul 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783433540;
 bh=UfmXVhSM5Umjns2A9HvBx2SkFQe8VPlW+QWf63BmQAk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gBG3ZsPEWjvZExJhMn5eRA+6Oj2wVar8453d1Ihc58vUeC6K1REcnEX1b0GRkajrr
 4pk98SRWjIkzI0Ut7XnTI9Evd+3AshYw7APhC601CmAn7xVDkr0wgmzt7RJwivIVjj
 x1wSeulDOE3mlrOmJB+LNeD5y4MUxckboK/JsMRmwvSKa3OUVJiPdAF1m95zYelD1B
 DgpmEaCok3QPESmRKAy8GyuCyV4GzdcxGaRzvWInTCSpEGkFO9iplD3jPb/pdq8h3t
 yjA+/6+iDQs55osPHVqW6LW8LWn9GhSQw4/3mCAX2SkvImnXnobrTKKYQt27Rv9bm2
 GImWhNFWg194A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] pci: fix dyn_id add TOCTOU
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org, cassel@kernel.org,
 dlemoal@kernel.org
In-Reply-To: <20260706-pci_id_fix-v3-8-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-8-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:19 +0000
Message-Id: <20260707141220.10BE61F000E9@smtp.kernel.org>
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

> Currently there is a TOCTOU issue in new_id_store as the dyn ID insertion
> in pci_add_dynid and the pci_match_device are in separate critical
> sections.
>=20
> Fix this by moving the existing ID check to inside pci_add_dynid and only
> check against the static ID table outside the critical section.
>=20
> Fixes: 3853f9123c18 ("PCI: Avoid duplicate IDs in driver dynamic IDs list=
")
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D8

