Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9109EC79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E914B10E6B2;
	Sat, 12 Sep 2026 08:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CjOPC+AS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB1B010E6B2
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:42:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F3A9601F1;
 Sat, 12 Sep 2026 08:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640631F000FF;
 Sat, 12 Sep 2026 08:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202575;
 bh=CHm8qz07+DxjMB5pPp6QEU4lM4MrohOHBKzrpQgl4AI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CjOPC+ASfYekTjBBKt3frqgMC75gG3RJ/sWLATF5nX89iZw4CRnN7Piu3Ef7ZbkPS
 K7Qbczgn+JIRSWAu39r3XpoTgJshzNmwmg53/cWASc3igjRpy3kY3DEQPAlxanJuIO
 3O5H608MIfT9hdEER7dE9J1o3Q/CYID8G8Syzy9sEr4t4/uvd5vDxsa8bePmVZCpqF
 M6iMTGl4LKReLrdxtwyMztnArAq+2Y1Um8U8RZIxBKLalEmt7RYSACTFhV7ysnLJ7g
 4et6vX65fzVqXFx4e4R1UOM5BQAXSCfLX83mDiblSeLvPBpkVZs6Bk+v5B+VAePcH+
 qakTTQydwqXqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/20] dt-bindings: mfd: qcom,tcsr: Add compatible
 for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, lee@kernel.org, devicetree@vger.kernel.org,
 dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-input@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-9-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-9-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:42:53 +0000
Message-Id: <20260912084254.640631F000FF@smtp.kernel.org>
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
> Document the qcom,tcsr-msm8952 compatible.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D9

