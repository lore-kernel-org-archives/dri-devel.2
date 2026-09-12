Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECF9C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8168010E685;
	Sat, 12 Sep 2026 08:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LVUUaaqd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D345110E685
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:42:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A54CF418DE;
 Sat, 12 Sep 2026 08:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0279B1F00893;
 Sat, 12 Sep 2026 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202536;
 bh=EfFVvKa9lCxxEncl+3DaEHvYlcWwtW87kg9k12mJ3tk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LVUUaaqdtqEfmwhTcV1VpvzG+qZWuJnpA8fWDYs9NGqEuGR5m3Y4rS5XKzcAtzQJB
 b7oJoRFqe9xPIPnWmAk2M+G7A+ENqYm3/F7CkjSpQ1N15fbjEzj/JQag1UW7Jr7mQV
 U78RgQ2TMpw9IXOymCUFplD7tGGEdvE6CY84PYK74yb2xyoz14jBJV6ILf4Wemynz0
 +EsuW7VWlbKjS4y5bq50DaZ3W0+MfAdQ1R+5EV5u/9J2cz7FG7GdVvvcNBjXSidVGP
 hNRWoeOyw7R+0c0AfUCtWWASjUZntn64tSbiDlM9C4aiYm6/JspGyVP8oi4W+IdjWR
 cHBrKjl2ztEKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/20] dt-bindings: power: rpmpd: Add MSM8952 power
 domains
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: lee@kernel.org, mfd@lists.linux.dev, dmitry.torokhov@gmail.com,
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org,
 robh@kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-4-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-4-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:42:15 +0000
Message-Id: <20260912084216.0279B1F00893@smtp.kernel.org>
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
> Document the compatible for the rpmpd found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D4

