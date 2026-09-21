Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B65C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C13410E992;
	Mon, 21 Sep 2026 18:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RHt02Rqq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E981E10E991
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:25:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3BC7060008;
 Mon, 21 Sep 2026 18:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525FD1F000FF;
 Mon, 21 Sep 2026 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790015119;
 bh=9VVnxWaPyzqRw93VtoDk0/scnPPESEg4PwBwUCD2/Vo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RHt02RqqcbTOWkNuarUBLENcfCgPUAZUVp3w1j//uR1vGaDnhDtLvcPAJSPEUZ1X9
 i+1cjgtX8b9b39TrKkXkxBdtuH0bS9ClRImZZxU4V4ZK0vm0arCs88htWSyBmxhp9f
 pm3aPkkJUtw3AnMKnlqt+nyG9vhdCTL4kY4eqX4/A7Q2E29BPXA/XcfVA8n53FKfS/
 FeIioEP8zAgumnm9BNVD+X8o0ppExHSIfDqmNkuF8AjBmwv+d+b1rv6TVHvigtKpzc
 PRkfbg/IM+IGnnG/WzeAojP9i7GBWoDcC0jqZ6r6dzVgE5+UQB2pGBUrq3IMnHH/92
 SaXij5a+dUlMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/19] dt-bindings: mfd: qcom,tcsr: Add compatible
 for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com,
 robh@kernel.org, lee@kernel.org, linux-input@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-9-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-9-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:25:18 +0000
Message-Id: <20260921182519.525FD1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D9

