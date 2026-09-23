Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3793AC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B38B10E9AF;
	Wed, 23 Sep 2026 20:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G8BZJWXH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739FC10E9AF
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:17:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D1BA40B3C;
 Wed, 23 Sep 2026 20:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A6A1F00893;
 Wed, 23 Sep 2026 20:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790194628;
 bh=yAjqfAW5bufm+AVogJB9WGLnr3zM55n/7TxWBu55cXw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G8BZJWXH/AeQQt/z6NE8wb4XMPVGdgWGdjJmhBDRva83xstzQVZuBsx0/gKuo9unM
 6PeI74aIai+EKLZF7xFbBUPALi/nv4W26DYp9zzxmiJAWVGesXKjhLRZYLsyNrc2HH
 jzz3+3vyVfnMdetDuszTdk0s2/4Fs0lj59hTKDYUzClNatqSIepaOUthBMorXz8bpE
 8xRzoXo4CfhBuksctE5rJZpkfpqYL5zP3HLLLG1uW5XmFsLdZJ2k5HLvze/ChdrahN
 vnqDLEhB8c9XHF6uXGFqi6jXV2acxZMhrIbZjqr3sho3Ni9BJVvbYv+qbiwzq/fPh7
 h+EymL7t5NJdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: display: allow the boot logo in a
 reserved memory region
To: "Max Pedraza" <maximpedraza@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260923201035.51007-6-maximpedraza@gmail.com>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <20260923201035.51007-6-maximpedraza@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:17:07 +0000
Message-Id: <20260923201707.E6A6A1F00893@smtp.kernel.org>
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
- [Low] dt-bindings: oneOf allows partial image properties with memory-regi=
on
--

commit 9a7a18d6778dd2101e7f626e61f0b37dcf103451
Author: Max Pedraza <maximpedraza@gmail.com>
Subject: dt-bindings: display: allow the boot logo in a reserved memory reg=
ion

This commit allows the boot logo to be specified via a reserved memory
region instead of inline properties, enabling the image to be shared across
multiple device trees. It introduces a oneOf constraint intended to make
the two methods mutually exclusive.

> diff --git a/Documentation/devicetree/bindings/display/boot-logo-clut224.=
yaml b/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
> index 9dc34717639e9..a71fc09a7c071 100644
> --- a/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
> +++ b/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml

[ ... ]

> @@ -103,10 +122,17 @@ properties:
> =20
>  required:
>    - compatible
> -  - width
> -  - height
> -  - clut
> -  - data
> +
> +# The image either lives in the device tree or in a reserved memory regi=
on,
> +# never both.
> +oneOf:
> +  - required:
> +      - width
> +      - height
> +      - clut
> +      - data
> +  - required:
> +      - memory-region

[Severity: Low]
Does this schema validation fully enforce the intended mutual exclusivity if
partial image properties are provided?

If a device tree includes memory-region alongside just a few of the image
properties (for example, accidentally including width and height but not cl=
ut),
the first branch of the oneOf evaluates to false. The second branch evaluat=
es
to true.=20

Since exactly one branch is true, the overall oneOf constraint succeeds. Th=
is
allows invalid device trees with overlapping configurations to silently pass
dt_binding_check.

Should the schema explicitly disallow the other properties when memory-regi=
on
is present to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923201035.5100=
7-1-maximpedraza@gmail.com?part=3D5
