Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06F6C982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343DC10EA60;
	Mon, 21 Sep 2026 18:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Eg2iPt+j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D85B410EA60
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:26:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56DFF60008;
 Mon, 21 Sep 2026 18:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997891F000FF;
 Mon, 21 Sep 2026 18:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790015168;
 bh=Dy4ks4r1jC0danVqhDaLYNAadxSRMpv51HmmJl36a8c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Eg2iPt+jnMaeBP0QILs3RC/4CVk0iEOgjXZmkTP9kJQCYct6i7zqg8tFw7p8YV8vB
 yI5/EObchHGnlasU1cite1ksx2gy4K5GKAFUgcAPcg7znOdvYyS8EVYOqbQy3HR5EY
 ZqL6eCKH59smT/FhAFn4K85TOlMdSQEKh0c8UPXOwj0geQbzGWv94K1Db1pb2JmnpG
 AcBDyKLMMX9ZbWj9DgzXkqGsLN7V5YQqbOjQMSXvwu2axP1OClIEh/ETev9h28POX4
 XHJ/v0YMY0AiW9sNhJL0SRLLecCvxaXp3U6b1CKz5nRn+jpY6Le8YNBMMidAecrwt7
 CYGkG2iMD40Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/19] dt-bindings: thermal: tsens: Add MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
 robh@kernel.org, lee@kernel.org, mfd@lists.linux.dev,
 devicetree@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-15-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-15-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:26:06 +0000
Message-Id: <20260921182606.997891F000FF@smtp.kernel.org>
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
> Add compatible string for tsens block found in MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D15

