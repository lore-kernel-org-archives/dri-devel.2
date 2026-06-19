Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657E2CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 17:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B921210F6AA;
	Fri, 19 Jun 2026 17:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eQJsfrA0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D53A10E0F5
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 17:05:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAD4A409B8;
 Fri, 19 Jun 2026 17:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610711F00A3A;
 Fri, 19 Jun 2026 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781888710;
 bh=UdxH6owbpvjotP1H0Mzg0H02heg2damNE4ssLdIzPYs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eQJsfrA0QkT9xzcvNy+RPiLvTE8LXeUZEH+57exIl5eMZCuquaqxjukzO5Lp15foo
 A3Ewaefymv+/KGC5Ot5+DRgsWih6Ujv0/JVVopNyVNK2vIO/tc3ykG7qaCe/6clkgb
 SUbP48HuSaTV3nbfsezOLGkDXjNf1RKUhTobg1H5OArs65s0a+5sUIeqYAzXtgexjg
 4h8KyHdZMNxyv7XotI4PCN8qNLHCv9WA8PrlatiKkvgiGZqALl6kG+KW7FIOIRZgOs
 gLy7ptVsKs8d2zNxRUo31Umh+vuOiut9nViLsG93pUbvLae2bLPLmANuO2zNHQhJL3
 vUBa90We4dWsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] rust: driver: remove `$module_table_name` from
 `module_device_table`
To: "Gary Guo" <gary@garyguo.net>
Cc: conor+dt@kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, robh@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, devicetree@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260618-id_info-v1-6-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-6-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:10 +0000
Message-Id: <20260619170510.610711F00A3A@smtp.kernel.org>
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

> Wrap the generated code in a `const _: ()` block to avoid symbol conflict.
> This removes the need of creating a new identifier.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D6

