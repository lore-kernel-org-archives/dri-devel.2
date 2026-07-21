Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C770FC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130BF10E328;
	Tue, 21 Jul 2026 11:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PCXqL6Ma";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500E310E328
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:34:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 093C840C55;
 Tue, 21 Jul 2026 11:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655C01F000E9;
 Tue, 21 Jul 2026 11:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784633648;
 bh=PArcXuGcxVkYbHbZ0JDAmL4nZr7XyevIyRu/GP8HdQk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PCXqL6MafXzNC1VPH8DkyClaoNyl35lEe6/++vtT6LqpyJGu0Napu9U2OpYQIssT8
 iQcovEHdwpAd0TZF+ESJ7wvd5HPNicTJyrZKcIUP5B97LlezwCasyN7eRrUkZXtq5+
 HKiWkpjixo5DWAWS91zj+QY2UW1RPYEdWSpyDOntt7f8z3aYpifKzQcZ5bZW+A1G9k
 r10izde39OCpsLYvJyMjnO+JrFM2L6F7Fi+mcEFBRSRd8cFaEzQJJsrBhIgW1gF3o4
 2CnIiO93wuUCjSp02XDtl315jvE9bVkkgWT2nlw5mrZFZDmV3Y6GNwmtpcDYDsbUex
 i/IXExfRcO5SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260721112133.70382-4-egbostina@gmail.com>
References: <20260721112133.70382-1-egbostina@gmail.com>
 <20260721112133.70382-4-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:34:07 +0000
Message-Id: <20260721113408.655C01F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing NULL check on `dev_get_regmap` can lead to a kernel panic =
in the IRQ handler.
- [High] The driver incorrectly masks `platform_get_irq()` error codes with=
 `-EINVAL`, breaking probe deferral.
--

--- Patch [3]: [PATCH v3 3/4] dt-bindings: input: Convert TI TPS65217 power=
 button to DT schema ---
commit 7ffa82f06e0d099b257abd8ec45ed224af6ff3c6
Author: Eduard Bostina <egbostina@gmail.com>

dt-bindings: input: Convert TI TPS65217 power button to DT schema

Convert the Texas Instruments TPS65217 and TPS65218 Power Button
bindings to DT schema.

drivers/input/misc/tps65218-pwrbutton.c:tps6521x_pb_probe() {
        ...
        pwr->regmap =3D dev_get_regmap(dev->parent, NULL);
        ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code need to check
if pwr->regmap is NULL?

If dev_get_regmap() returns NULL due to an incomplete device tree, it seems
this could lead to a kernel panic during an interrupt when tps6521x_pb_irq()
dereferences it:

drivers/input/misc/tps65218-pwrbutton.c:tps6521x_pb_irq() {
        ...
        error =3D regmap_read(pwr->regmap, tps_data->reg_status, &reg);
        ...
}


drivers/input/misc/tps65218-pwrbutton.c:tps6521x_pb_probe() {
        ...
        irq =3D platform_get_irq(pdev, 0);
        if (irq < 0)
                return -EINVAL;
        ...
}

[Severity: High]
This is also a pre-existing issue, but does masking the return value of
platform_get_irq() break probe deferral?

If platform_get_irq() returns -EPROBE_DEFER, converting the error to -EINVAL
prevents the driver core from handling the deferral and retrying later.

> diff --git a/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutto=
n.yaml b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
> new file mode 100644
> index 0000000000000..3526d8b045fd2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721112133.7038=
2-1-egbostina@gmail.com?part=3D3
