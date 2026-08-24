Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612A7C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B6A10E733;
	Mon, 24 Aug 2026 11:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n4HfeApY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E1F810E733
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:24:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59C8C600AD
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21341F000E9;
 Mon, 24 Aug 2026 11:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787570681;
 bh=ApXPb53SPml/F9aldGqG+kjpgDpkMTNiPlSkzATJirk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n4HfeApYfUlWKXwMCGZfDagkLDrlAtyd8i01oFmS54X8YKCbOVUWn9Qyy8851Fsku
 iZOcm7kLcA8slNnmtMnYt4Gl3sth1MvEneMuFiqibjH670Z62SANlnaiA7kC6KJgwU
 Q7+kY4AYpSVsxRI/uYG6WevvL6zkjET3NLaIMjL2HdUcJ5FHz7eih/gfzW6OEkxzWZ
 JwUtjhpfmWVurIjb00a/vnYdnaHqGqSnSxj63ojeZE15p6YO4jW5ZRlqtsqdB+VV8H
 tPor6YVr4ZaPUJmNItXKPOaqcueR6ic7pNVCON6gDdvgrM6v4yGCg51bJYr5oSRhTN
 2n0xbR+8iVZxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 3/8] rust: implement `ForeignOwnable` for `Owned`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260824-unique-ref-v20-3-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-3-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:24:40 +0000
Message-Id: <20260824112440.C21341F000E9@smtp.kernel.org>
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

> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>=20
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D3

