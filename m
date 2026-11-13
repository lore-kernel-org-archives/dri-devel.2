Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C7606A886
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOgWXsFA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1CD610EC1F;
	Fri, 13 Nov 2026 14:40:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574B510EC1F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:40:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0F69433E3;
 Fri, 13 Nov 2026 14:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4471F000C4;
 Fri, 13 Nov 2026 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794580819;
 bh=e+ETkyUc9DLYZBI7Ggkx7fN+4soUBMdhhVKivjmWx50=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oOgWXsFAOsnVGfyJeeSY5diVUGRbHSHTmpv6h0Vw55lAghIc76P1CaLunOBfGeqmo
 hc3wN4icSp4UIueYZDE/AA2jYuwsKlpIpdKPQQiTgsh3Dx/YxOQCiawQeHI8fU5YNU
 dtiOsSMDbQP5fJMvcgNwGhC76X731OosZWeUQbl3eSb9gr4zfMwSywybTRN4740fiv
 1gXLNtnX3ZMCBJTO12/LiyFQCktUFSZBSG1daQ8abfXYI7GN1eG+gQo7U4tw2SmOSN
 w97qptQlEmLdouThhLfSH+u5lhjXgJjGHy3nLmyoDQs4xYbPELMFm3XvsB4JKHbMgW
 nyMc7pizxpoGA==
Message-ID: <sashiko-outbox-213000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] drm/tyr: clear stale IRQ state before soft reset
To: =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261113-tyr-reset-impl-v8-1-2ee298ac9808@onurozkan.dev>
References: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
 <20261113-tyr-reset-impl-v8-1-2ee298ac9808@onurozkan.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:40:19 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/tyr: missing Fixes: trailer for issue_soft_reset() stale IRQ
  fix
--

commit e053765c9b79d29e4e4daed59084849814476fe4
Author: Onur =C3=96zkan <work@onurozkan.dev>

> drm/tyr: clear stale IRQ state before soft reset
>
> Previous reset may leave the reset completed IRQ set which can make the
> poll return too early.
>
> Clear the IRQ first so the driver waits for the current reset to
> complete.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

[Severity: Low]
This looks like a bug fix for issue_soft_reset() polling.  Should this
include a Fixes: tag, such as:

  Fixes: cf4fd52e3236 ("rust: drm: Introduce the Tyr driver for Arm Mali GP=
Us")

or:

  Fixes: 6ea52b6d8f33 ("drm/tyr: use read_poll_timeout")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-tyr-reset-=
impl-v8-0-2ee298ac9808@onurozkan.dev?part=3D1
