Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386A9C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C1510E832;
	Sun, 13 Sep 2026 06:31:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eb0GvKTr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7369D10E835
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 06:31:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4607A40723;
 Sun, 13 Sep 2026 06:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83681F00893;
 Sun, 13 Sep 2026 06:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789281068;
 bh=xAwViQErcoj/iSttbbspJZcrpFedxAxEGKzSOirtOkE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eb0GvKTrK6JzGGFT6T639FISDQIWxwijFAHO7rxs60EO2H604Dt47YyIzbCpa4sd1
 JsvyWir7dtH7h3uL15D4teeD0UXjN5uVf7cavJjDPF62oQxHDDjStnTzPn2YlHU3je
 Js5AWPF+pFYRKFjRj7i/5mQEzr12twUvd2IHVeALz/iVwhI4oLSBa4u3MCV1EcAztO
 I48pp/5sv8s4EjhqkxyWgoH7MRuIk9VIFmB4mt7SfsU9jGicij8DFZlMU4F7i+yOto
 77sMckRL0KxeQu/REbLlFdmL6YZr7lavHaYnHxQpxyHXUpEbfp5y2KAVxSBfc7Act+
 l8z2tZjnSjpZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: vendor-prefixes: Add Shenzhen Zhuohong
 Electronic
To: "Alexey Minnekhanov" <alexeymin@minlexx.ru>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260913-nt36672a-panels-v1-2-ce097402c6ea@minlexx.ru>
References: <20260913-nt36672a-panels-v1-0-ce097402c6ea@minlexx.ru>
 <20260913-nt36672a-panels-v1-2-ce097402c6ea@minlexx.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 06:31:07 +0000
Message-Id: <20260913063107.D83681F00893@smtp.kernel.org>
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
- [Low] Vendor prefix mismatch: 'shenchao' mapped to 'Shenzhen Zhuohong Ele=
ctronic Technology Co., Ltd.'
--

commit 73f96d396aaa9d9d8dc1a660e32b98910c8690b8
Author: Alexey Minnekhanov <alexeymin@minlexx.ru>

dt-bindings: vendor-prefixes: Add Shenzhen Zhuohong Electronic

This commit adds a new vendor prefix to the device tree bindings. It aims
to register Shenzhen Zhuohong Electronic Technology Co., Ltd., a
manufacturer of LCD/IPS displays.

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1507,6 +1507,8 @@ patternProperties:
>      description: SGX Sensortech
>    "^sharp,.*":
>      description: Sharp Corporation
> +  "^shenchao,.*":
> +    description: Shenzhen Zhuohong Electronic Technology Co., Ltd.

[Severity: Low]
Is this vendor prefix mapped to the correct company description?

The patch introduces the 'shenchao' prefix, but maps it to Shenzhen Zhuohong
Electronic Technology Co., Ltd. Since 'shenchao' typically refers to a
Shenchao panel (as seen in a subsequent commit introducing the
'shenchao,fhdplus-video' panel), mapping it to Zhuohong, a different panel
manufacturer, could cause confusion for device tree authors.

Should this prefix be named something like '^zhuohong,.*' instead to match
the manufacturer, or should the description be updated to reflect the actual
Shenchao company name?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-nt36672a-p=
anels-v1-0-ce097402c6ea@minlexx.ru?part=3D2
