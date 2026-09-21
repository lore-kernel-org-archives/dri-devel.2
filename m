Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795BFC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D323210E354;
	Mon, 21 Sep 2026 07:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dzVJCakb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9576F10E354
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:06:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9CD9F6021A
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C391F00893
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789974390;
 bh=dS669YdL4HWYJMFHFuqUiLwJ+dBe/E6NjwQ/Nk/pJzY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=dzVJCakbVvndGYTPoffC9/BBzOjv0OuuLWyNhM2cqnoeUPz+j3kaKJOg2Ng3Ulpi/
 OUwKJDf/XbLgq/xbydxb4tVHHGEjq4K5NX4NTSzi7ekOAtUXh93zNeNQcirNdMSQC/
 qgwtyW/is7d9DkFEp3EkoYTh/aG0fqU6Z1ZbLEgZGDyMQkSD4sEopBD++gKCIhxyp5
 oevnUHQJOTp1ymFFvrgXGZeYcyNVXl2p9idu7/cguSIfBl5ukTlUM0D6t0uX+y9QuK
 oor95CfEQRpTCnYlC5qMzeXmFazG6QZVe8mtQJ66H1OOMS+yz7TCLtTUULjPcxYQ3k
 S9JoC0Hct48Vg==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f1b846so2959447e87.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 00:06:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwiyzZFkydU9pKGa1xAW+BePhM/WwWVNHMZTuW+Imrokst/w4UZ67xeytVjGkvyLVfuqMkErhqRoq0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ml245DUKsPGL5mRdlX4y1PWLUdhKE6hXLUR5tw9/HdKMtZ6C3+
 XG35Rl8PyjqSlNQAU+taenou+ROW6UbBzoI8+l8S6fxO9CQrUzUJXvIsrLCY4NZPLD4M27wERPX
 RoAu56C6hCA5pCPGtzAI9dWE3i+afG5Y=
X-Received: by 2002:a05:6512:23a7:b0:5b6:1a7c:aa1a with SMTP id
 2adb3069b0e04-5b8c197cf88mr3053851e87.50.1789974389058; Mon, 21 Sep 2026
 00:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-18-9352be6b86b1@kernel.org>
 <20260920230526.D9E331F000FF@smtp.kernel.org>
In-Reply-To: <20260920230526.D9E331F000FF@smtp.kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 09:06:16 +0200
X-Gmail-Original-Message-ID: <CAD++jLkazAsBWPD9vhh_N4fgsohDARUZLb72HMpfV4ZJvVs+6A@mail.gmail.com>
X-Gm-Features: AcwNN1WdHGAFgi49VdletBEx39eGC37Zp4G66DB5ah7Aob95Mw3hiURMbaajIF4
Message-ID: <CAD++jLkazAsBWPD9vhh_N4fgsohDARUZLb72HMpfV4ZJvVs+6A@mail.gmail.com>
Subject: Re: [PATCH v3 18/18] ARM: dts: ux500: Remove DB8500 EPOD regulators
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, 
 dmaengine@vger.kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Sep 21, 2026 at 1:05=E2=80=AFAM <sashiko-bot@kernel.org> wrote:

> Will removing the v-ape-supply property cause regressions in the
> ux500-msp-i2s driver?
>
> Looking at sound/soc/ux500/ux500_msp_dai.c:ux500_msp_drv_probe(), it
> unconditionally requests this regulator:
>
>         drvdata->reg_vape =3D devm_regulator_get(&pdev->dev, "v-ape");
>         if (IS_ERR(drvdata->reg_vape)) {
>
> Will this missing supply cause the regulator framework to fall back to a
> dummy regulator (emitting a warning) or return an error and break the
> driver probe entirely?

Ooops I'll add a patch removing that so the driver just uses the power
domain.

Yours,
Linus Walleij
