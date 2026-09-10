Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0504AC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EE310F3A5;
	Thu, 10 Sep 2026 09:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bLpd8FPJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E1510F3A5
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:05:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5533600C8;
 Thu, 10 Sep 2026 09:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B05F1F00893;
 Thu, 10 Sep 2026 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789031118;
 bh=GV1sdq7x4gC2/9+iZ0mAKAWXQI7nM+LrtSc2CkR7ZF4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bLpd8FPJRUo8G5uwh52gJrEBy42kdqhQneUkHMJ3vfXLLWY+E2WsRcVILmvBOsY7H
 h0wWYF6juzly4l1v3FQAsxFlkJzwEUDf+qNAs1u/Cd5lnIo9FlHsYE+wwTyA92/1OW
 1p0gI/cN/g0i8U+Vr6nvyJmy4gL8f32JVroEwXsQxYBQ1FS/wAHz60Os/mR+6+zBHt
 xdRHNzgg0AeMtF2DDSgi2jsYlxsOCsjP4ciAEWL7k0WWnEW/i4IT3KYs3PARpI1WN0
 QN68Z8Oh3UAXNuIdh+AYCsXWWtT7WhbJyfuSWIK9GoA74aU+vFXCoewWRkMhfozTfo
 OBbvA2rbtG96Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 1/9] rust: alloc: add `KBox::into_non_null`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, gary@garyguo.net,
 linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260910-unique-ref-v21-1-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-1-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:05:17 +0000
Message-Id: <20260910090518.1B05F1F00893@smtp.kernel.org>
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

> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
> is a convenience wrapper around `Self::into_raw` for callers that need
> a `NonNull` pointer rather than a raw pointer.
>=20
> Assisted-by: LLM
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D1

