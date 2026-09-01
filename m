Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38EEC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162F310EDEB;
	Tue,  1 Sep 2026 17:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZgH0zZhD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A69E10EDEA
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:03:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 095AF4336D;
 Tue,  1 Sep 2026 17:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855141F000E9;
 Tue,  1 Sep 2026 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788282198;
 bh=8IobpCD/J1G/fW29mTH47TNvdFsAfiuggZHz1+f4p3g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZgH0zZhD8zDktf2I8703f9cHLnCdOowmejS5JeKNwMVrrGWJVzdPN1N+saNemJkHh
 HKNsDXvGD2+ZhCwCQhXvIBQddLEyTwQ2VXZAwR20wLQO3YMart3JJsh4WLzpu0VrxP
 Qh1Fhsma4S+1OrrZ+dOmkTftjmhwMXBeDK/PNnzwGfyaAvt96W3oZ1CE1nZi5nS+YN
 lqnYNw8knvba5u61FTCrLrfFZJNJJOZQ3hwpYAmMyaCSlAgfj8t91y7I2DEia6FY4h
 2p1TKKw5kCBb7A7fDorCckF/H3DL+hbrnVOxl1keowLR4dKZkXAgHlFCo7hLXqsx4C
 CIVmITImZqFuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/16] rust: io: register: remove `Register` trait
 and cleanup macro
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260901-typed_register-v4-15-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-15-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:03:18 +0000
Message-Id: <20260901170318.855141F000E9@smtp.kernel.org>
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

> With the removal of relative registers, there are only two type of
> registers left, fixed register and register arrays. There is not much
> benefit in having a common super trait for them anymore, thus remove it,
> and cleanup the macro rules associated with it.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D15

