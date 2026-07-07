Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1189EC44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4862F10ED5F;
	Tue,  7 Jul 2026 14:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ig139JRf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F1E10ED58
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:12:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F02641AB4;
 Tue,  7 Jul 2026 14:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929C91F00ACA;
 Tue,  7 Jul 2026 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783433538;
 bh=+Q8bsBDe/NPd3jPzAf281UsX9sWgZa/fkzVNcKGpaGw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ig139JRfu1SsHtLD/2CqUoX+sR1iL+JWLycuQ54NG3jIc6EfG/OLqzcUJ90VDAsDv
 N7QhOF7tkFzEN8yVg2vzpzHYvmKwydMnu64BXpUxTTMhZTaIM/TcvISYuzZfvE0FxC
 kdc1R8QtMsy/hGvikB47Phpvlke1bSJe3a27PnGGJgWRzhqlGZRAqRjQrNj0UJ7iXE
 yNPQ3zup4TXVy0L7NMwYSwVsF9RBkGhxrW31zvhz1Gnz/fvU+sxVN1X10W0rVKtZpx
 49hPNYUbOkkhGgjTNPtvbcFI8Hh6yqpgL5S/9rstz9UyR5QBOGFWXieBe2Hofd0cDW
 zqv6yK6NFfCFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] agp/amd-k7: don't rely on address of pci_device_id
To: "Gary Guo" <gary@garyguo.net>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-pci@vger.kernel.org,
 linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-scsi@vger.kernel.org
In-Reply-To: <20260706-pci_id_fix-v3-6-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-6-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:17 +0000
Message-Id: <20260707141217.929C91F00ACA@smtp.kernel.org>
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

> Address of pci_device_id cannot be relied on due to presence of dynamic ID
> and driver_override. Use driver_data instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D6

