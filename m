Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464FCC982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2EB210E982;
	Mon, 21 Sep 2026 18:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P5cXZWnF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1471710E982
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:24:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D55D643D5F;
 Mon, 21 Sep 2026 18:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D6B1F000FF;
 Mon, 21 Sep 2026 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790015098;
 bh=is3FgDq+8e7aC+cKPj/HZa7V8OPw8lsHhUUPFx4UDq8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P5cXZWnF328l2Kj2hdJfudnvWmbk95XjTVg/wvCr4c+/weJInd2aD0PCqaQiMFx3C
 xR/Cj6QDWFpWCtM8tEZS7e1ySPVQRQjh6JujrlsQslCKB1uxs9wVCHtDZmVBhBk3gN
 mRl7zjWycZiEzi2nWiu/3Sl/BpZ6Dm6c0U/R+1RY7ZGnwGgxi9JJcD5jYPl5+hPDr7
 zttuaw2lR2h3RGl7rDovfPsYwSuKnZtCjHPjB5gLqRT8hqbZvRgWXniWQ4+ltAr6UN
 WNO7PNy9ggTKdYYZdKft9ARVTuOxrLwVtB6gg5b98aGQXi0+0NlP16Xfd/OFkAE5Va
 ZXvEO7UvtJCtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/19] dt-bindings: display/msm: qcom, mdp5: Add
 MSM8952 compatible
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: mfd@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, lee@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20260921-msm8952-initial-support-v3-10-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-10-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:24:57 +0000
Message-Id: <20260921182458.31D6B1F000FF@smtp.kernel.org>
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
> Add the compatible for the MDP5 found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D10

