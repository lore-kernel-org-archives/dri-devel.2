Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E1AC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D3210E73B;
	Mon, 24 Aug 2026 11:28:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ifJCOg8/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06D310E73B
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9237D4324A
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB9B1F000E9;
 Mon, 24 Aug 2026 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787570900;
 bh=CAd6OU/Ery5CdCIZJTpri50JvE5CV33/gZSHvSJdBOk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ifJCOg8/to6KIb7P2Hsxj0KjyLLoDzgiqiw20FBKYeopu857l0jzD9PGvVmYhz+DO
 +besw9Nk657sSe2ukqL7LmEUAatptX0BPRyIdDbeXaJ+cDUHIfS0wVd7nZKnILXw34
 /fDgnWthtjv3IAA7URNKBXuuLEVt6AJe1+6Mcl100gn5opZbUWDDigJv+ztn0fpR1I
 CLjQbhAK1b7sPtVMsIoM4sIutqDAQeJf5TNVuPlmmLOGlIBlk/mDQXc3mkhQ1JLh1c
 mjfE4x94HKUIntlOZCo3903F0bdDo1Pz4DgNZuzLpNJLfJ/aO1brkpvlO/dkgruqW7
 kD5AQQzbscHCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 7/8] rust: Add `OwnableRefCounted`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260824-unique-ref-v20-7-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-7-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:28:19 +0000
Message-Id: <20260824112820.3EB9B1F000E9@smtp.kernel.org>
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

> From: Oliver Mangold <oliver.mangold@pm.me>
>=20
> Types implementing one of these traits can safely convert between an
> `ARef<T>` and an `Owned<T>`.
>=20
> This is useful for types which generally are accessed through an `ARef`
> but have methods which can only safely be called when the reference is
> unique, like e.g. `block::mq::Request::end_ok()`.
>=20
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Fix formatting, update documentation, fix error handling in
>   examples. ]
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D7

