Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DDACD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4683410EA8E;
	Wed, 10 Jun 2026 16:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T4tZFeht";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3193610EA8E
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:54:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAAEA4042A;
 Wed, 10 Jun 2026 16:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE8A1F00893;
 Wed, 10 Jun 2026 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781110452;
 bh=ZvZIX8lmkcHbCHcb7V6Ou7kKGR1t8AdqXfXbDIXt2Ss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T4tZFehtlEkYpUEBX6v2+ysc7Artr8i/PaXy8FSfEA04RFLXI29Ag6mHDj436zu9x
 Ed19oObVSpO4j9sNvfntL3a5JEQolQE/YHuwqIsh/ZslTkA94mdrIVKOVFkrVaaaai
 2CH4wBfa7oHOhNUqv+XmFg6D85cV8WZuCxciZmjtJnxH9ij1S9uIgqfh5lfLM4x5ec
 Jz6oyTPcC6cUdIBQIYop55Dlfhhh710MKmrqgGm+8fOf6h6P0sT2pFhqEEMgBP09Pq
 SmjnjlXk4E2ofpj+icoQ4Z8vVJK6fNUbYgxqivECh++2eHgnAjWCVysbFrziX1Dy0+
 HITqakeb0e44Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260610164428.180091-2-amit.barzilai22@gmail.com>
References: <20260610164428.180091-2-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 16:54:12 +0000
Message-Id: <20260610165412.8EE8A1F00893@smtp.kernel.org>
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
- [Low] Missing type and value constraints for `rotation` property in devic=
e tree binding.
--

commit 4e4bbc4176c7e781dd970cf6e2d43e667642bddd
Author: Amit Barzilai <amit.barzilai22@gmail.com>

dt-bindings: display: Add Solomon SSD1351 OLED controller
   =20
This commit adds a new device tree binding for the Solomon SSD1351 OLED
display controller. It defines the standard properties and builds upon
the shared solomon,ssd-common.yaml schema.

> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1351.ya=
ml b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
> new file mode 100644
> index 0000000000000..a7d77132faa63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
[ ... ]
> +properties:
> +  compatible:
> +    enum:
> +      - solomon,ssd1351
> +
> +  solomon,width:
> +    default: 128
> +
> +  solomon,height:
> +    default: 128
> +
> +  rotation: true

[Severity: Low]
Does this permit the rotation property without enforcing type validation?

Without including a reference to panel/panel-common.yaml# (or a direct type
definition), dt_binding_check will not enforce that rotation is a uint32 or
restricted to valid degrees (0, 90, 180, 270). This could allow incorrectly
typed device tree entries to pass schema validation but fail at runtime
when the driver attempts to call device_property_read_u32.

> +
> +required:
> +  - compatible
> +  - reg

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610164428.1800=
91-1-amit.barzilai22@gmail.com?part=3D1
