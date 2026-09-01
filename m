Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB18EC624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D38010EDDE;
	Tue,  1 Sep 2026 16:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UE2l5IJS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1664610EDCA
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:59:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EF92602BA;
 Tue,  1 Sep 2026 16:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B239B1F00A3D;
 Tue,  1 Sep 2026 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788281943;
 bh=cchq70ZENhU1nnYN9GEBzStZcJtso6S7bxU+vicxzA4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UE2l5IJSJDE8cKdqn/zyggr9wXOT+ojkCZrlX0PdFPkW4GH83rgjgzeXgPPOBGME3
 R7JVRO7Ggx9c7/VUk9hlp2MQjdJQk8Ik24HA8VnuViIkEkOZFGbCvjdtPwORIq4Gk0
 rRHOByANN1EysZ6EZdTUFIjVFKOug/pcLCR09xjvbNaaB5Wh0L4+9jxdFYxUiwOqp1
 WN58WUlYDrfI1cV0jC0zDKNZuylKsaibcfmCKL6Df5zT2VdcPOWgO9lRHi6UmJ0Sh2
 eUgmChrermENGndxsIdWM3U7tJOD4R6g5SS4x7ckMm7lxsKeaOIF5xyM0QFdeFglL5
 rW/yMqa118r7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/16] rust: io: register: make register have a typed
 base
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260901-typed_register-v4-10-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-10-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:59:02 +0000
Message-Id: <20260901165902.B239B1F00A3D@smtp.kernel.org>
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

> Previously `register!` defined registers can be used on any untyped I/O
> regions. With all users specifying their desired register type now,
> propagate the specified type and restrict I/O access only when type
> matches.
>=20
> Also, add an `io_project!` example which is enabled by this change.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D10

