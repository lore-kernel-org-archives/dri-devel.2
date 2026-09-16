Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC69C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28EF510EB54;
	Wed, 16 Sep 2026 14:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DUpUb+6Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F1410EB54
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:29:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42FCC60008;
 Wed, 16 Sep 2026 14:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D741F000FF;
 Wed, 16 Sep 2026 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789568986;
 bh=ZNo4I4BwfpUdfZF/eYBVmz+/Ycx+iBQCfdxGUZQNIyE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DUpUb+6YUYEPa+BcFxqmN4Yqxrc3C/r79+nDmE3xlXlgPcjHpF64Nyw8bMv11fAag
 3DcclRd5DxXXNsTfSKStzi6i8RDId2LyzyqEZwMqoWb9aj1bXvdS/Pli5T9GfrCwXk
 bNYAq7P8MU6AaxJbcl8OmHQYOoB4RpgVZzsNNPjusUqMlMm7nyB2nQ0uD6JxhSAmUR
 73Mbapsb5WOI7cASvjhGrGLQjkUc9H0JfbKSy54KvdrWZiBbyWW+DlBvmYctjytuvZ
 ribLKUoqj3uguuLJcm8Nk3Vm+qD/gOm1+fNteNUuuOchJKO5qeie5h2QhXRZzA4MpY
 Qjzjp/Fn8oN6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/19] dt-bindings: arm: qcom: Document MSM8952 SoC
 binding
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org, lee@kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-7-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-7-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:29:44 +0000
Message-Id: <20260916142945.67D741F000FF@smtp.kernel.org>
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
> Document the MSM8952 and add General Mobile shamrock to it.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D7

