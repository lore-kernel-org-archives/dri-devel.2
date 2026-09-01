Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1F8C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7618D10ED8F;
	Tue,  1 Sep 2026 16:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BC7zs/B/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D500B10ED8F
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:55:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B512741995;
 Tue,  1 Sep 2026 16:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D831F000E9;
 Tue,  1 Sep 2026 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788281730;
 bh=9gYJjWt1RaZrk3Ek06aGjK4JGzvbLvHWqNCWx85TfvM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BC7zs/B/LZlPx89BEp4n3RT+MfViHOfKrR4+/QcVUo6T5wzTT0fw8ErPapABB3udZ
 i4UYGAiEdZ1Oc3W+TfdCrlABX7vsd75h2cwTNhLkPQLREdEI3Ty829GA2920KaVaHW
 pGSdSq5ppJ8y24+/vVnURSLo2tUPbOMn1zYyd+aeMARxo5T8c7amnQmUMxqwTJX4cH
 qIZKZNngEdg8DBQGHAo4wDAnjjcwIowdUGUC5AenWt78kmwf+WcE9CJMSxiwg3bcoU
 GWy53IXV/tvh9vA8drHuCv/YkU8+qGzaQ2km/I5t8eLxauJBTJH+WFT8WxQCKvW5l7
 1woMZvbDxIFeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/16] rust: io: register: allow explicit base type
 specification
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260901-typed_register-v4-6-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-6-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:55:29 +0000
Message-Id: <20260901165530.43D831F000E9@smtp.kernel.org>
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

> Currently registers work for all untyped I/O regions, which is not ideal.
> It allows registers defined for device A to work for another device B and
> there is no safeguarding at all.
>=20
> All users of the `register!` macro know what type it will be operating on,
> and that type is consistent across the driver. Therefore, add a `base`
> parameter to `register!`.
>=20
> Currently this parameter is unused in the generated code; it will be used
> when all users of `register!` is converted to gain the parameter.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D6

