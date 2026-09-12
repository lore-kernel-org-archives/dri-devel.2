Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF98C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF22010E684;
	Sat, 12 Sep 2026 08:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UkqtJRlt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9AC10E684
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:41:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 841BB43C88;
 Sat, 12 Sep 2026 08:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B331F000FF;
 Sat, 12 Sep 2026 08:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202475;
 bh=9GJSBK27NdknLZevfr534GsBFcHqjNITB+5Ar8rgZAc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UkqtJRltQg8lfB/pVB1KdiMDE5kzY2N4x9UqDCkci/W1vxrh/xgSBar2h649atsos
 GYH/ZdjY8wfXlBTlckRkblicAvUzZTgNoHRr/pGGmhCAa1iwiZqUEi2rPvE60X5EGI
 5ciC+94L0jbge5C/ucDm3JxkMHOwfX0jTgPye0TLaZTjgzjbvsVkkqVqEc9x0C7unY
 JMGBR3aMysut+Vuhh28Xm/l/8f7riggzA1r+he/64rk0egEubJDSw3/hERhW+Dfbdv
 kHuxznwB7oihTy9LlKzPUep9CWVGEEhF/CCrp6kbPrFvO1q6e5bmAau7l1+Rgn13OQ
 90/cEn6da78yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/20] dt-bindings: vendor-prefixes: Add General Mobile
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, linux-input@vger.kernel.org,
 dri-devel@lists.freedesktop.org, lee@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev,
 dmitry.torokhov@gmail.com
In-Reply-To: <20260912-msm8952-initial-support-v1-6-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-6-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:41:14 +0000
Message-Id: <20260912084115.05B331F000FF@smtp.kernel.org>
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
> Add vendor prefix for General Mobile.
> Link: https://www.generalmobile.com
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D6

