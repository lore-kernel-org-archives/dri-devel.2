Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA30C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4282C10E3C7;
	Fri, 26 Jun 2026 14:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OMstkal4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3436B10E3C7
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:52:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0BCEF403CB;
 Fri, 26 Jun 2026 14:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F611F00A3A;
 Fri, 26 Jun 2026 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782485536;
 bh=NbT9jLawGsGqePH+jW3ahHXLyZeNZZ2Wf+s/u3aLdGo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OMstkal4tm3OkH2dTlTy1acp0I//ocSPp5sJ/yg/O108J98yQuuIXTQkUc3dKOO3y
 hwci/Kbt6G4s+ZD0/Cvje6LdjIq9ni0PlyQ96p0X0coQ04ZbKJSCdA5ql5ToYPGB6v
 amp4FEOycAw1KjReQaL9d3MnhqfBnVG6HGVc3Dr4ey/gkvbOTog1kyrNttdXVuoe3Y
 cEKoN/+/KudAxo43zzm3izQFYqoVq9SvDDYlmKIQAAlGa21znncQwJmhvmWdLgqKcY
 OT4W8sO0KXzSE89o6tCp2J7HITOVMYcIfAWvGBGU3l7/hT22QF0hJb0AIDPM7OBhQh
 cdbR3wN4YNuPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/20] pwm: th1520: remove unnecessary `deref`
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260626-io_projection-v5-10-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-10-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:52:16 +0000
Message-Id: <20260626145216.A2F611F00A3A@smtp.kernel.org>
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

> `Deref` is automatic and should normally not be used directly.
> Also, `IoMem` is going to be implementing `Io` directly, so it will no
> longer to be implementing `Deref`.
>=20
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/to=
pic/.E2.9C.94.20Projection.20in.20dma.20bus.20address.20space/near/606672061
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D10

