Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4743DCD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96B310F05B;
	Thu, 11 Jun 2026 18:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DtNoFAyf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF3D10F05B
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 18:01:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9436560129;
 Thu, 11 Jun 2026 18:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7F21F00893;
 Thu, 11 Jun 2026 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781200884;
 bh=+c25jnHGJMWv7saIkdGgkjW867NiEHLTSToJmZ/zoUg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DtNoFAyfU3FTXtgRAycER9b4XPn/ZKxdXWOW8jHPTPKHUcD7dg2RsAXeuqe7x8w9E
 1SPDZjHtS3eQMwmq68+5jButKfvUXY2v34PBfUdI0a1dEwR5vDtzGm1adVdHespvoA
 LDmBlcOVriSVKg9pDmerjHG8as1/kWKvwqYbazLkaDXwEKeTAV2WHPtsvQ40S+W4Bm
 IpV4laEDy87EB6Hx5AvfrNlJ9GZNUTQmw9UuuR+al1V4wSUeg6E2BiFAwalaVc/Z6d
 yIHPghTGPds7yY9pOzNkL8Zn+ubFXPYM+YkdW5bIuqFpZwlJ3vp6HYx0KhjWxJev1l
 od5/60IRg461A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/20] rust: prelude: add
 `zerocopy{,_derive}::IntoBytes`
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-io_projection-v4-12-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-12-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:01:23 +0000
Message-Id: <20260611180123.ED7F21F00893@smtp.kernel.org>
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

> In order to easily use `IntoBytes`, add it to the prelude.
>=20
> This adds both the trait (`zerocopy::IntoBytes`) as well as the derive
> macro (`zerocopy_derive::IntoBytes`).
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D12

