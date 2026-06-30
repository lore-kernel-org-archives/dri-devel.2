Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01204C43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B2E210EC66;
	Tue, 30 Jun 2026 12:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oUdiIiPu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F7710EC5C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:40:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B04454055C;
 Tue, 30 Jun 2026 12:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF841F00A3A;
 Tue, 30 Jun 2026 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782823212;
 bh=uKaCbDGpWr5UKHnGgrDO87OukPxEyAP0AwZqhmrej+k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oUdiIiPupylxAEryQUqh/oTtmWH41ATcBpPUPly+7VRm1yDoidgmy6mktoTVglH7q
 lCaqvSzRBoETfutMr6ueHJ7jDW6YIawqEXun7ma9Gs47539PZPgrB9nlnQCL9WPRrP
 7DKxNmmQoEfqNvOPn4jaj21G7szJdYZXETnd823u3TsjBjRWw/XiDt2WL3V++87/g6
 woFbxDL5+Z573X6aCkmU802d9b6iEyt5TziDkYdH37Our0bYxe7oc49DYXs49t+4XF
 mtkiTIWDHSaI9XyK2ok6vi4fnst59UuVcEHXCI3sYGVQUpG46gcuq2ElOkUdK67Zgv
 Esjd3JfQtW7PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] rust: usb: use `Option<&IdInfo>` for device ID
 info
To: "Gary Guo" <gary@garyguo.net>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
 "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, robh@kernel.org
In-Reply-To: <20260629-id_info-v2-4-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-4-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:11 +0000
Message-Id: <20260630124011.CBF841F00A3A@smtp.kernel.org>
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

> It is possible that ID without driver_data will be passed to the driver,
> e.g. `new_id` is used to dynamically create a new ID without data.
> Therefore, the driver must be able to handle the case where `driver_data`
> is 0. Thus, update the `probe` functions to get `Option`.
>=20
> The current code cannot tell if the info does not exist or is the first
> entry; however this will be achievable once the code is updated to use a
> `&'static IdInfo` pointer instead of indices.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D4

