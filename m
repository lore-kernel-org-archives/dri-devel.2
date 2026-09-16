Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09CFC982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504D510EB6D;
	Wed, 16 Sep 2026 14:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n2JaJPNL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494BD10EB69
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:31:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 322A94116F;
 Wed, 16 Sep 2026 14:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857711F00893;
 Wed, 16 Sep 2026 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789569080;
 bh=vinY7j095+XFfKjnUcfcd2zFXlIrEQyC5ZueZLN7QS0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n2JaJPNLr/e10MpQOWQRQMe62vGd3KINGVcg4M2MtAmONCMVKtUCU+G0BNrWody5M
 XSpyYcGk0g0dUoC2WL6v6Zm3zxMB3e5d1c6wAGheGY3Xdyc2x6VhD3K5zXTErg9TYb
 JA2xa3h4pYNU5DuQ1tk+1/1IhYLXIKeqFyTYhh5OSP6+Cg9pApb+ot0vWT2fRXXCrO
 zPr9qQjBmhYR/QA2t6yYSl1eASUWhF6FejJZL4+8t/qfrlCzHNF8EcYmFbAHTlSOzU
 5g5qC0cf+REtjiFFNZSbtu4vW5LeZ+Clby6+vErCup4vw/LWzapHZyt1PkCAI2Ng2J
 3UaJQ7LjoZj3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/19] dt-bindings: clock: qcom: Add MSM8952 global
 clock controller
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, robh@kernel.org, lee@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 dmitry.torokhov@gmail.com, mfd@lists.linux.dev, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-1-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-1-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:31:19 +0000
Message-Id: <20260916143119.857711F00893@smtp.kernel.org>
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

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add a device tree binding to describe clocks, resets and power domains
> provided by the global clock controller on MSM8952 SoC.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D1

