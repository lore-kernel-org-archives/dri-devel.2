Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D073C531FC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0EA710F4A1;
	Fri, 24 Jul 2026 22:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jaEYENRN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9872910F4A9
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:02:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D14E411F2;
 Fri, 24 Jul 2026 22:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069551F00A3D;
 Fri, 24 Jul 2026 22:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784930530;
 bh=PW/i8776VBu7rM4sFwAMjM1fk1tVadh1I+vuIH3wxmM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jaEYENRNaGuZNM/sMbcIhckyT0UP81he8l8MZHXItkMu9skVYeXwnzY86Be6t/2AS
 6bDziAbrN8uIJXjuYfXsl4TrWaxlzg5gp8n6brUZy/HSnx2Z9wscyDrFP23rKVrgjI
 prs6+eA2o1t9l+cfA9Wkl13LOJsVXGC0TpkMVqzlayy1h/B8XBe6iYIjG1guk3CDa4
 8dMAr4Xamrp8NfPRf4APl+4aKUOsQFESCXDMJ3LzbNDSatI71/r+QolDjQPrKAO16/
 npFJWwFqzJ5L6YUeKO1nYEKCJEgmRjcTyxUYTS9/dI8vRWC5/cse0pON8vOkEqPr4c
 oAuCLc2JADsTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] PCI: Fix UAF when probe runs concurrent to dyn
 ID removal
To: "Gary Guo" <gary@garyguo.net>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org,
 linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-pci_id_fix-v4-9-3580726844e1@garyguo.net>
References: <20260723-pci_id_fix-v4-0-3580726844e1@garyguo.net>
 <20260723-pci_id_fix-v4-9-3580726844e1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 22:02:09 +0000
Message-Id: <20260724220210.069551F00A3D@smtp.kernel.org>
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
> as remove_id_store() can free the node. Thus, make a copy in
> pci_match_device(). Also, clarify that the id parameter is only valid
> during probe.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kernel=
.org/
> Fixes: 0994375e9614 ("PCI: add remove_id sysfs entry")
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-pci_id_fix=
-v4-0-3580726844e1@garyguo.net?part=3D9

