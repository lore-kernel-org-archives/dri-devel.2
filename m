Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53585C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C9110E6B5;
	Sat, 12 Sep 2026 08:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XTjUWmyM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F7A10E6B6
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:44:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E77460219;
 Sat, 12 Sep 2026 08:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64911F000FF;
 Sat, 12 Sep 2026 08:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202654;
 bh=+ABGxwCNM5sZ8CTJo3fIHMUsTnJTARAjJDSqtXXGjIM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XTjUWmyMyMnXKzpKCYieoaZ2P0gcDT4cJQQ6fsOd754YUlLaxFSktLThXImKILyXN
 dcxcVi92ARbi8/Fh//qaodskNgMWbVsLTpuds68dx73zbnHjiYLSDo8WFcjlN6FhWn
 1XqYs7U+tMiYcPmbQql7O1nyZSDwdhUhvynu12I3Vk2xyhHKKtuxBjSd0zHoSuexad
 UJ+CWZRMQo7ss3MSrw3F5MaaWkLIEpsSswI7oG3ewprlGCXDSUzd8nzEI6u0RePyIl
 JcftA01Ahk6WARhYuJXGVLcQLRvGN555Xm5r/c0XPzioP36ZC6lHwkmt0lV/aqom6k
 UOVA36lt98IpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/20] dt-bindings: firmware: qcom,scm: Document
 MSM8952 SCM
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, mfd@lists.linux.dev, linux-input@vger.kernel.org,
 lee@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 robh@kernel.org, dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912-msm8952-initial-support-v1-11-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-11-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:44:13 +0000
Message-Id: <20260912084413.C64911F000FF@smtp.kernel.org>
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
> Document the scm compatible for msm8952 SoC.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D11

