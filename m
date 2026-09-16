Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DB6C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B24310EB22;
	Wed, 16 Sep 2026 14:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ua7f+cgD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4E310EB22
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:29:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83C854385F;
 Wed, 16 Sep 2026 14:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A631F00898;
 Wed, 16 Sep 2026 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789568954;
 bh=l6OLpuiTCzyGtg21re1Q4j7YWZJh8rW4+8RjR2l/7hY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ua7f+cgD932uIjdXchyObhMtJdVOu336cmZ1Il7f+mW3QYZkj/LM4YXeKf39Seae+
 zMituMn2/0Pu+HF9eYfn7+nFcicxyLw+5V8egbD7ti9T1rpUfsS8PoaIXxI/AtkM2x
 BaBBEyCnw6Bat6MZkBA1jCX1DVvv69MdMFAbqfGaXU9XnqC2xOF8HGRqlgJOrWzFDN
 VQbWSwRfeQA0BTsYwFgf0fNzb4V/6ZixBtotrBHU8Gid6s14wSj3Jh/APS6UBp2mXy
 bltQvKoCUkWp3LwUFsosCS9ym2TEVVbmESlhA2FbsRXepbcrtMURGEwSa8qjGyTEew
 CzO80JOquxegA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/19] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org,
 mfd@lists.linux.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20260916-msm8952-initial-support-v2-18-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-18-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:29:13 +0000
Message-Id: <20260916142913.D7A631F00898@smtp.kernel.org>
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
> GT970 works with GT911 driver, document it to be
> used with GT911 compatible.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D18

