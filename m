Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CD5C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C01B10EC5E;
	Tue, 30 Jun 2026 12:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HVdzR3jV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6846510EC5C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:40:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1E7D600BB;
 Tue, 30 Jun 2026 12:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEA91F000E9;
 Tue, 30 Jun 2026 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782823210;
 bh=bl3I/86hqMe/n8cOzb0d1IVOtT9qA2YDZh+SKJBsXcI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HVdzR3jVlS3D78eDPTu4X5Fw6VazQOmGQrEwliEqgbduF3GAHfkJCsS7o3zQfNXnT
 v650+/AY0+PBpi8xLUDShHWg4i/KI8oj8vnbNZOcKuQSNcmkQM+hSpoRG4Z2bS55se
 LW+MATI0id58rw5+808J9BZhHeM/6O0AGdIkS/WEkByaz2mwCwQow09sYpl1ayQP8o
 L37l2D4tB11K+Lt3RUyn+/BcX6d3ZWNzOReg+D1P3X00Wqzi8hn8tssyyTP7rz/iYO
 /1JjXM//R2/hkZ5WaggRBt/+5OzDcsaNNVubLqxkt4T9jwA1vsxYSrHs1FmFW5cikV
 z1Rh+R0GearSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/11] rust: pci: use `Option<&IdInfo>` for device ID
 info
To: "Gary Guo" <gary@garyguo.net>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, robh@kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260629-id_info-v2-3-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-3-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:09 +0000
Message-Id: <20260630124009.6BEA91F000E9@smtp.kernel.org>
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

> It is possible that `pci_device_id_any` will be passed to the driver, e.g.
> `driver_override` is used on the device. Therefore, the driver must be ab=
le
> to handle the case where `driver_data` is 0. Thus, update the `probe`
> functions to get `Option`.
>=20
> The current code cannot tell if the info does not exist or is the first
> entry; however this will be achievable once the code is updated to use a
> `&'static IdInfo` pointer instead of indices.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D3

