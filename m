Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76126C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C6A10E045;
	Sat,  4 Jul 2026 08:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HGs6WlwC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76AA510E045
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:17:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DD7A6001A;
 Sat,  4 Jul 2026 08:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD4D1F000E9;
 Sat,  4 Jul 2026 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783153078;
 bh=eYdslUEHglSsKArGGYBW8S+iSURNODT8r9whWz4B9R4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HGs6WlwCM9f/mawrsX022QQHevm+W0PXWjlfWzl51azxHJvSA7YuOVpHz14NpNNrx
 wUGM/CVuHIHE8YVhUai/nRrhmHeGXpTHjttsIPQ03L8QhxHeg4hnvFia3dcr+KSbGs
 iA01V40zuAbrj+wdYDuoFN9Iy54DydlJTbVYbHx2jw/1aqlr1sT1XO3i/TgD5ieMa4
 nYu2MPb/2XUB+9cftXzK/V3wDPcIiJC228QchrBJStZ0KTwU7L5vQnLTLiVA0jPpjn
 wSdnNPYUtLJb/L5grbgnnuKvfNqTmzCBqZsXBVQomDRj0mTYi5k5DVgFhAhnfI+lGq
 KYxmeYvl6BJAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260704080925.75113-2-amit.barzilai22@gmail.com>
References: <20260704080925.75113-1-amit.barzilai22@gmail.com>
 <20260704080925.75113-2-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 08:17:57 +0000
Message-Id: <20260704081758.0BD4D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing default values for `solomon,width` and `solomon,height` in =
the binding schema.
- [Low] Malformed Git trailer in the commit message (`Assisted-by: Claude:c=
laude-opus-4-8`).
--

commit 1fc812656be731d6e9e5623e968e630de22b7e48
Author: Amit Barzilai <amit.barzilai22@gmail.com>

dt-bindings: display: Add Solomon SSD1351 OLED controller

This commit adds a device tree binding for the Solomon SSD1351 OLED display
controller. The binding builds on the shared solomon,ssd-common.yaml proper=
ties.

>     Assisted-by: Claude:claude-opus-4-8

[Severity: Low]
This isn't a bug, but this Git trailer does not follow the standard format
`Tag: Full Name <email@address.tld>`. Without an email address enclosed in
angle brackets, this will likely trigger checkpatch warnings.

> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1351.ya=
ml b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
> new file mode 100644
> index 0000000000000..80850c2ab5b3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
[ ... ]
> +allOf:
> +  - $ref: solomon,ssd-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - solomon,ssd1351

[Severity: Low]
Should there be default values defined for `solomon,width` and
`solomon,height` in this block?=20

Since the common schema `solomon,ssd-common.yaml` indicates these defaults
are controller-dependent, omitting them here leaves the hardware's default
resolution undocumented in this schema.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704080925.7511=
3-1-amit.barzilai22@gmail.com?part=3D1
