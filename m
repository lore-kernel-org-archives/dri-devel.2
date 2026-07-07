Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9933DC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C0510ED74;
	Tue,  7 Jul 2026 14:12:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="je+MHiFg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A29510ED80
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:12:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1085E41AB4;
 Tue,  7 Jul 2026 14:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856F51F00A3A;
 Tue,  7 Jul 2026 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783433532;
 bh=IUpvRC9wcs1dCUCuTPSKS6N90kwfuNsOcY+hxN9a/+8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=je+MHiFgYHsOBg91S1REa9sghrqxq1jVQGvqjbExLoTLl/mz0zk5uF1L1HbzkKC50
 MbTSCczlK1IuCadfNh6jcvgBORPY+pSQfvZ2pqnCd/CvEvC6OXwJmyVt1MmcXAouvR
 KxNAfqbzmav/tZI/FHOJOBhoq5uZZdJQueOv74fjpmjloEJ7bYh+vUkoBVqrPfIDYM
 8glIVgKG6SoB0SKOtcQXeJ0ps+aLB1SZ8BNDuCSY2iLaHhckKMrhgWAyTVr3cUX3RY
 G1EFE/0nBfX+hDxReXUfs6YEjF52Ov6MlMOr6UwfCKEiCsCi3F534QGsShMsp9QOgk
 CXTbF4i3rivNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] ata: don't store pci_device_id
To: "Gary Guo" <gary@garyguo.net>
Cc: cassel@kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dlemoal@kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
In-Reply-To: <20260706-pci_id_fix-v3-1-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-1-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:12 +0000
Message-Id: <20260707141212.856F51F00A3A@smtp.kernel.org>
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
> of dynamic ID. All information apart from driver_data can be easily
> retrieved from pci_dev, so just store driver_data.
>=20
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D1

