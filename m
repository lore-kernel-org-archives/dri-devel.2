Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64849C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C836610ED58;
	Tue,  7 Jul 2026 14:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="erjAGEwi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F1F110ED86
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:12:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 478BE43A03;
 Tue,  7 Jul 2026 14:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3991F00AC4;
 Tue,  7 Jul 2026 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783433536;
 bh=eyDgeJF51paQKpDoILd8CGhbNI4Uaxh0TsSiULTfk8w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=erjAGEwiejadxQ7ohbGW/96YMylj6W/A2WCbZ6MXSH9f836pRgXyv3aymOsKTfVsi
 KeaMvO3G+cIQpu0lwfPvatqtzVIqqfurk7wHMs5kYOavLU7lv1SJ54GaDmYI+oirq+
 NQVIjHhMKr6iH4jN3wvMepxe2dDIhkRhkmLBbBhlvXy1QsRNd26XEKTXTkKCFwXN6N
 piL4fZ4ebmJGA4DqmXwn48Bcvl6Rsu8FZ1gyKXpJlRRMSGJfDY1Z7mZdY++EWx/hZg
 Sn+uHMjtbDbK1ZypURU5O1K8CSaDK577IZbETbvzd2D38+CaA+8Eb/Qd9rF9QS3pvs
 KvdZsSes8qs5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] mlxsw: don't store pci_device_id
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, dlemoal@kernel.org, cassel@kernel.org,
 linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org
In-Reply-To: <20260706-pci_id_fix-v3-4-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-4-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:15 +0000
Message-Id: <20260707141215.BA3991F00AC4@smtp.kernel.org>
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

> pci_device_id is not guaranteed to live longer than probe due to presence
> of dynamic ID. This stored ID is unused so remove it.
>=20
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D4

