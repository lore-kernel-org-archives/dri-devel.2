Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2BAC79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D1E10E6A3;
	Sat, 12 Sep 2026 08:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KmGMVF2u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D231110E6A3
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:48:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB7E542D70;
 Sat, 12 Sep 2026 08:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AC81F000FF;
 Sat, 12 Sep 2026 08:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202901;
 bh=Buc+viVam7kZEFCB1UuibokZEgQcX4yL0d5r0rhufyE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KmGMVF2uZhM7G5pzxWcj1+S8AdLEpop0TUM9kp+808duvvsBNWw2d63MX8M7/DT57
 /2RYPqrNN6+Lfxm4hYTlKzTRyh9H27irUz07GUiDfxaW5gDPOy8zj6XSLqNFxkKNNQ
 V7ysiSMP37C1zF6ZZ29xy02vrnF56ltPg1EZfjYIl7BolWALDDP/KBZn+Y/Ox/3QPO
 ei0jtFkc5Gu3KInQSODxelar4y0of+8nE4GtfuHVJ3l/5ZmeeEe0RLTSK+EJeVMZfO
 95JRLPf425rruQQ2tFpZ2WN/GGPl5zhPrkB+KbvwgyDC8YjOPwLfiHjLr8cT//4tvN
 vku5uEBQVV65g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/20] dt-bindings: arm: qcom: Document MSM8952 SoC
 binding
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, mfd@lists.linux.dev, lee@kernel.org,
 linux-clk@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20260912-msm8952-initial-support-v1-7-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-7-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:48:20 +0000
Message-Id: <20260912084821.48AC81F000FF@smtp.kernel.org>
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
- [Medium] Undocumented Side-Effects / Missing Commit Message Information
--

commit b2938fc599ccd3f200169a9387303de5b8f42abe
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

dt-bindings: arm: qcom: Document MSM8952 SoC binding

This commit documents the MSM8952 SoC binding and adds the General Mobile
shamrock to the list of compatible devices.

> dt-bindings: arm: qcom: Document MSM8952 SoC binding
>=20
> Document the MSM8952 and add General Mobile shamrock to it.

[Severity: Medium]
Does this commit message accurately reflect the changes in the patch?

The commit message explicitly claims only to document the MSM8952 and add
General Mobile shamrock to it. However, the patch introduces a 3500-line
clock controller driver and multiple unrelated dt-bindings (clock, mmc,
nvmem, power).

For example, the patch introduces the following probe function:

drivers/clk/qcom/gcc-msm8952.c:gcc_msm8952_probe()

It appears that this driver is not removed or re-split in subsequent patches
in the series.

Could the commit message be updated to reflect the full contents, or should
this patch be split to separate the clock driver and unrelated dt-bindings
for proper subsystem review?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D7
