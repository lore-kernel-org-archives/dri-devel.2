Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F03C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ECF210ED6E;
	Tue,  7 Jul 2026 14:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PEozfLmb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 954B510ED61
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:12:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DA2B437E0;
 Tue,  7 Jul 2026 14:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024481F00A3D;
 Tue,  7 Jul 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783433541;
 bh=jA9Ju4PIhu1ffgguky4STt6TzXMN7ues9/+gqUty3/0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PEozfLmbcNcu9IQcd+7U97REqOs0CUoZKiHeyGMuYGdHwII8G7PriyYvg0bD5wZ1d
 a4zWQJw5K8fx+cMWk+zfoxjtE6dfa4Xeny0vRi5DOotxtsTd16zFJ2H7YLpwQpDST7
 8vDAPtwDm7H5Ed0TrssWGZf5PCgpHlkCbVqKIRh+U6Z5sTvRupupvh8IWcf7T4+/80
 2smlsH/8woTT/s1dcNe4R+3quoqmOU66NN+ufgVUCz489buY6QqtLzK4Mo0MnDwcKv
 YpsNP6yjEhxsBG+aB4a099ybTyqnr9UBhlPfQj6rXboHmd4H1Hpj53SNG9on9d/5jE
 1TRnVU6RTjygQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] pci: fix UAF when probe runs concurrent to dyn
 ID removal
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-scsi@vger.kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org,
 dlemoal@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-pci_id_fix-v3-9-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-9-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:20 +0000
Message-Id: <20260707141221.024481F00A3D@smtp.kernel.org>
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

> Dynamic IDs are only guaranteed to be valid when dynids.lock is held,
> as remove_id_store can free the node. Thus, make a copy in
> pci_match_device. Also, clarify that the id parameter is only valid during
> probe.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kernel=
.org/
> Fixes: 0994375e9614 ("PCI: add remove_id sysfs entry")
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D9

