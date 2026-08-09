Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD53C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 20:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C96010E5B3;
	Sun,  9 Aug 2026 20:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cCLfi2lN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5AB210E5B3
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 20:17:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E92A600AB;
 Sun,  9 Aug 2026 20:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDF41F000E9;
 Sun,  9 Aug 2026 20:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786306638;
 bh=qQyTAwnkEOdAypyH9vKKuSv4GvuvP8c6s+t9W6np4D0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cCLfi2lNVycTOzCua8N4oL87dJCgGc66vAjwJjtpm+nw5TlYcTbI530sYeyqks1/9
 fqRHC1fBw3B54DQHxzdfU/1BzOFiVTAhmxgZ2Pty5G22J5IOIlzFqsRByxTcfm2q1/
 QNQDgX88Lm8Bp9DDrD+hWFtPQLJadAUV+pwItiyY0/VccjBuFEJINmTUTDIQrbfCqq
 rNKP6PhbFu0DOVJxDrNgfYoFwfmddisruqu1qUszJ5fkYkhmcgNEGy/zm6dA3UtsT0
 pNdrfP4Cuxg0kiIugPbSxFrrTX2H9Ps3F70C23jF2JqGCS4e9euIxy8CKAh86df67K
 zoADgBY08hJhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: Document 10" Raspberry
 Pi Touch Display 2
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org
In-Reply-To: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
References: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 20:17:17 +0000
Message-Id: <20260809201717.BDDF41F000E9@smtp.kernel.org>
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
- [Medium] Incorrect use of `additionalProperties: false` when inheriting f=
rom a common schema via `allOf`.
--

--- Patch [1]: [PATCH 1/4] dt-bindings: display: panel: Document 10" Raspbe=
rry Pi Touch Display 2 ---
commit 24ac9b0c966cb6294b25fc745f5c098627bda264
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
Date:   Sun Aug 9 19:58:50 2026 +0000

dt-bindings: display: panel: Document 10" Raspberry Pi Touch Display 2

This commit documents the 10" Raspberry Pi Touch Display 2 MIPI-DSI TFT LCD
panel based on the Ilitek ILI79600A controller.

> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili79=
600a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili79600=
a.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili79600a.ya=
ml
[ ... ]
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
[ ... ]
> +  backlight: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

[Severity: Medium]
Should this use unevaluatedProperties: false instead?

Because this binding inherits from panel-common.yaml# in the allOf block,
using additionalProperties: false will cause the schema to reject any valid
inherited properties (such as rotation or port) when evaluating a device tr=
ee.

Using unevaluatedProperties: false would correctly evaluate the properties
provided by the $ref, which would also allow the redundant local declaration
of backlight: true to be removed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809200107.8429=
45-1-marek.vasut+renesas@mailbox.org?part=3D1
