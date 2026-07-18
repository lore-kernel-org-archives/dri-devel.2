Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9362DC4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC4F10E609;
	Sat, 18 Jul 2026 22:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FCOtWQIT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A74C10E609
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 22:02:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84ED060008;
 Sat, 18 Jul 2026 22:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1971F000E9;
 Sat, 18 Jul 2026 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784412157;
 bh=62FrzbCTnCQ/Qpl/5cqJW+MCuQjti1STMy8ocwZ5vYw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FCOtWQITHj6eq2a2uVrkxNxBrn11DgcxZfRRnCLPYA6DynVkr1RWLqNS+a/6s7vqB
 A7TX3tYx7pUlnhORgwGWq4dpX+7iCUyphS0fAVj6hB3R9kWUw9BoWClUX1DVPPr40R
 CyX4DsyLERwX3BKE74NyL8DkfcHRPrbyRFAApsp0vEpcN13R5RKoQG2DCYEMzj7DG1
 r3pea+VDtPsfobNiYm8WYs/ytJfZxyYl5Jz1ILR1XhXWisN79OCFyEIau4QPkM+3Z/
 nUAxgCMjBCrtUn0Z4xf/cfXO7V72sXwDElUZk262lWP0IGHOXEwHZl3i8izPHLxDes
 6qhXI3Iot2HKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
 lee@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260718215632.3295049-3-egbostina@gmail.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-3-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 22:02:36 +0000
Message-Id: <20260718220236.CF1971F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718215632.3295=
049-1-egbostina@gmail.com?part=3D2

