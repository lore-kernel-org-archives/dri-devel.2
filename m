Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD4EC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FF710E591;
	Mon, 24 Aug 2026 19:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cchFqQKL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2777710E591
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 19:57:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3C9C41A18;
 Mon, 24 Aug 2026 19:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1F21F00A3A;
 Mon, 24 Aug 2026 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787601466;
 bh=C/GTsfpWxVTyiI3ZqgkYztXVVANsc0bhr1ckF+KvMe0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cchFqQKLbl4fwpiy9e8v1EdLQ2sOnZUwzgX9w/mqew6BezI4+4GdBxIsg8QBelo+l
 saeeX3v7WzBwLNZPwN7TBQQS9pCoqEmKO/S3V/KZzoxNiH12sW1T0EeLK/e3tHV2wB
 ewd/K6JLX9cjFa0A8SLEqf86pJEjW0HiFB33XmKUVcWjEexio+LJr4Avcyv4XJE2ch
 kLlk05Q/FkhjILq/1U68a9ia0AB9mjxyNO0/eqR9FdVA8tGwI10KmWw17wQur1rogg
 nGh2AYR7e7e+Mu2J/UyOj9MyNFBFNA3+YfZB8t3pdk4joewmM0aEIimp+PpDGmNvAP
 maLPLvm9siH5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: Add GlandaGPU binding
To: "Leander Kieweg" <kieweg.leander@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260824195418.17707-2-kieweg.leander@gmail.com>
References: <20260824195418.17707-1-kieweg.leander@gmail.com>
 <20260824195418.17707-2-kieweg.leander@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 19:57:45 +0000
Message-Id: <20260824195746.3D1F21F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The new vendor prefix '^kieweg,.*' is inserted out of alphabetical =
order in vendor-prefixes.yaml.
--

--- Patch [1]: [PATCH v3 1/2] dt-bindings: display: Add GlandaGPU binding -=
--
commit 987b0ae0b2509987f3bf6af799a254628d7f7d34
Author: Leander Kieweg <kieweg.leander@gmail.com>

dt-bindings: display: Add GlandaGPU binding

This commit adds the Device Tree binding documentation for GlandaGPU, a
custom FPGA-based 2D display controller. It also adds a new vendor prefix
for the author in vendor-prefixes.yaml.

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 1e54877628c75..e20d045980ac9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml

[ ... ]

> @@ -668,6 +668,8 @@ patternProperties:
>      description: Giantplus Technology Co., Ltd.
>    "^gira,.*":
>      description: Gira Giersiepen GmbH & Co. KG
> +  "^kieweg,.*":
> +    description: Leander Kieweg

[Severity: Low]
This isn't a bug, but it looks like the new vendor prefix was inserted out =
of
alphabetical order, landing in the middle of the "g" entries. Should this be
moved down to the "k" section to keep the list ordered and avoid future mer=
ge
conflicts?

>    "^glinet,.*":
>      description: GL Intelligence, Inc.
>    "^globalscale,.*":

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824195418.1770=
7-1-kieweg.leander@gmail.com?part=3D1
