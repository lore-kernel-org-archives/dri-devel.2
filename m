Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B912C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 668D410E95F;
	Mon,  6 Jul 2026 12:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jV6cEu7y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1E510E95F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:58:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 685F442D86;
 Mon,  6 Jul 2026 12:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67351F000E9;
 Mon,  6 Jul 2026 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342731;
 bh=e9YcVi8TzkKb/NF51WCy2xs+cIuvDfI9ZQOmvym0bUo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jV6cEu7yDR+99WD6NxEF/oU0uIMeuexwAVCPOviBjG9JhP84owRuy5w8jTYIlD3Un
 0+asuca7goZp3cs/4uN40iOxYA0W17rBuWMHDkMzYYNMFwYMCIVRXlQCtQ1cto5Tiv
 WlG6zWMvc66c3IVWN4RZEi1BjhWrbSnF4ICmaMnxuFbce+M213uiAZ0YGhKX0+ibRP
 m03nhRwBkVihp8Rbu2jYCKeXb+d5f2A2NHmB84ezrRBsUxbec5UYLd7hkChGH8k6Qg
 /L0LGvL1EhJIcgrJ/l4VV48C2fAwUWQYHJwKN+Tyw8haH8c2lB6RqL6IPx7x2vk8T5
 uRa0jBE8qsGLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/20] rust: io: add projection macro and methods
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-io_projection-v6-13-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-13-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:58:50 +0000
Message-Id: <20260706125850.E67351F000E9@smtp.kernel.org>
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

> Add an `io_project!()` macro to allow projection from `Io` to a subview of
> it, using the pointer projection mechanism to perform compile-time checks.
>=20
> For cases where type-casting is required, the `try_cast()` function may be
> used where the size and alignment checks are performed at runtime.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D13

