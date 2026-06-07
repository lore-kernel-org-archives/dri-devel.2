Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7069ECD8C90
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 20:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E3C8825B;
	Sun,  7 Jun 2026 20:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jHZ4a6PM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83FB10EB74
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 20:19:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0C4A560018
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 20:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0721F00893;
 Sun,  7 Jun 2026 20:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780863570;
 bh=mZDpgTO32GJeTNUkWQiUVrsPeuYmJir0wvfjrucxL2c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jHZ4a6PMiCLyigF8/3ZCGMyP5vdLr3ZJYFBh6EG4qfzVSDWkn+YbUDS/ANSF+ON8h
 oP/JHeACkTPeoIZktI8HuhtAvVWT4Sa4rK4//ArgV9V1Z7jNw8MKt+IgkvW5pKzDwG
 8BFCOKujGYzZvaUruW2SvHvOK2EWZ1NqcgzG4Ddj/cr1Wpy+1My9dVo9htaEQkoYWW
 mTdPLOuD4J8tDw3vR/UvKYzOCLgO4thh4sDVcAQK4y0hwCYtA//IJUOa8/XBKmh60U
 7AI9L8M2UmFe/dY82wNDoIANWW9iC9p4SAb9S+sgU9YuXx9UMh6VHiLaAXk/feC/Kr
 FyQPSkvOMS7zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: Add Chipone
 ICNA3512 OLED driver bindings
To: "Aaron Kling via B4 Relay" <devnull+webgeek1234.gmail.com@kernel.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260607-icna35xx-v4-1-64de514add34@gmail.com>
References: <20260607-icna35xx-v4-1-64de514add34@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 20:19:30 +0000
Message-Id: <20260607201930.7E0721F00893@smtp.kernel.org>
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
- [Low] The vendor prefix 'ayntec' is used in compatible strings but is not=
 documented in vendor-prefixes.yaml, which will cause dt_binding_check to f=
ail.
--

commit 5d6611d7262ab82a8a3721761623b1f394d6e2ec
Author: Aaron Kling <webgeek1234@gmail.com>

dt-bindings: display: panel: Add Chipone ICNA3512 OLED driver bindings

This commit adds device tree bindings for the Chipone ICNA3512 and ICNA3520
MIPI-DSI OLED panel drivers.

> diff --git a/Documentation/devicetree/bindings/display/panel/chipone,icna=
3512.yaml b/Documentation/devicetree/bindings/display/panel/chipone,icna351=
2.yaml
> new file mode 100644
> index 0000000000000..90e69f30cd91c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/chipone,icna3512.ya=
ml

[ ... ]

> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ayaneo,pocketds-panel-top
> +              - ayntec,odin2portal-panel

[Severity: Low]
Does this new vendor prefix need to be added to vendor-prefixes.yaml?

Device tree schema validation verifies all compatible strings against the
known list of vendor prefixes. Since 'ayntec' isn't currently documented
there, will this cause dt_binding_check to report errors when validating
this schema?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607-icna35xx-v=
4-0-64de514add34@gmail.com?part=3D1
