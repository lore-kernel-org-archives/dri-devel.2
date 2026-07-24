Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88348C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F37A10F4A8;
	Fri, 24 Jul 2026 22:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="niyeUvFR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC9910F49A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:02:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 046DC60A80;
 Fri, 24 Jul 2026 22:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C79D1F000E9;
 Fri, 24 Jul 2026 22:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784930525;
 bh=ZKj6/D+170NHQb4CC9r6Q/MsU8h4G7WoaajuGxIOBLE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=niyeUvFRplw74eWFXarqjm1cvcPa9ZoKaW4gbj2heI60/RG86rHOYNVZiee3clfXu
 gX4aX6xoIhObKU/Q9ZbMyGovssWiUKLtFcyvFbHwH/ze7R3I9ksauap5EWSiPbDySW
 elMw6PtWTVSBSUTZIGrPbnb14L3+e7PhYe1WLIjYDQ2t0vtu6cgOX63OyHkvqqzNb1
 XuMEiE9rJsWqFxnvuEvgbq7MmAD61IWGcjy/HMKzRhYsFE432g3PEdU54W8ynwfY4U
 JquIHlaA70rvHnWTfrRlNw6RUF8YAuSEpc3YI7qQxFLzNGhQbqvUj4wtw3GMk80PQR
 oz4jyM0JAln6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] mlxsw: pci: don't store pci_device_id
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org, dlemoal@kernel.org,
 dri-devel@lists.freedesktop.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260723-pci_id_fix-v4-4-3580726844e1@garyguo.net>
References: <20260723-pci_id_fix-v4-0-3580726844e1@garyguo.net>
 <20260723-pci_id_fix-v4-4-3580726844e1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 22:02:04 +0000
Message-Id: <20260724220205.4C79D1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-pci_id_fix=
-v4-0-3580726844e1@garyguo.net?part=3D4

