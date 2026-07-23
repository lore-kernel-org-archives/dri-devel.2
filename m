Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D54C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7028810F072;
	Thu, 23 Jul 2026 10:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JPGaGmLv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFCAD10F072
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:22:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7AFF741763;
 Thu, 23 Jul 2026 10:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9091F000E9;
 Thu, 23 Jul 2026 10:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784802164;
 bh=SVE0WBK1ETYot1oQG4Aeb/YUZ11+jFDmTVNkmlwJaRc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JPGaGmLvtgpo8MI8V2qY9XdBriY5hKyR1v9aX6q5FRJpFukXxeTh/8iFwN6SHDxtv
 nToG6lJ+KcJvwAseD/0jMczKie7v7ohQgM0HbxBtOHLbdQSxpJbSmvSqf8mT3jYkqC
 WSTWqjqseuVLYxo+2S602wQMAQFExj4+xdLx42M0ImtSel2COkyq7rRt7IjglT8GdM
 qLtD1uw8EkkxtQmTMY2hAGd7f3KaByiA3kOpCbUOujtW5T8JBE8l/LiVzrecjxusoB
 CO/LgiOtNSZOdNG2Osz4EsiSrl3PjxHmz9EnLtZM84gSrFAjEVnpNtc0tDPKJ8j1vH
 Bgvy5oopDm2IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 dmitry.torokhov@gmail.com, lee@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260723100605.628882-4-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
 <20260723100605.628882-4-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:22:43 +0000
Message-Id: <20260723102243.BC9091F000E9@smtp.kernel.org>
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

> Convert the Texas Instruments TPS65217 and TPS65218 Power Button
> bindings to DT schema.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100605.6288=
82-1-egbostina@gmail.com?part=3D3

