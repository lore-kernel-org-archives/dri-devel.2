Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72A606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ubth0gDZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B5510E9FA;
	Thu, 26 Nov 2026 13:52:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5520D112441
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:52:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE58A42D5F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9196F1F000C6;
 Thu, 26 Nov 2026 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795701156;
 bh=dO47GcUag+bmDxotCWLihzVd3crs6RTsQDfW+nGMD/Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ubth0gDZOiXjUKEgvH3lDYCXoloRdlqyfm/7ZM/MPzWkCGQKMP7Ac9ClfxHB0R+pl
 izbyj+tIcQD9EN78suTfDD4q8LoPUOjTuHRzqLEnHEjzlc2aawIUwXiA/GjawjQKu8
 siJRjATbHdrvwxOEt4idpx7SFU4v8kKQFKMeX3LzE53WL4sZgUJsMownx9pLCPuaO8
 gGxqo/4Mbt0vuk88AFd4itYnd0thI4gUOH7N81B2m7RdQodW55McuYXzkWKVI6bfAU
 cpNltwsmlDEfPNvOG3aVdzr3EMEhCSwoPIIAt1wVuA0CTxV4s4ZIfWA+IsTetx8Kdp
 KTLJBmJ6gBi5A==
Message-ID: <sashiko-outbox-235656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] drm/panel: novatek-nt36672e: Fix the reset
 GPIO polarity
To: "Vladimir Zapolskiy" <vz@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261126134508.320700-4-vz@kernel.org>
References: <20261126134508.320700-1-vz@kernel.org>
 <20261126134508.320700-4-vz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:52:36 +0000
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
- [Low] drm/panel: novatek-nt36672e: missing Fixes trailer for reset
  GPIO polarity fix
--

commit 9b3b20020b17a5e54e69c4e88df2960f428e2e60
Author: Vladimir Zapolskiy <vz@kernel.org>

> drm/panel: novatek-nt36672e: Fix the reset GPIO polarity
>
> The RESET_N pin of NT36672E panels is an active low signal, however
> the driver drives the reset GPIO with inverted logical values, thus
> the reset GPIO has to be described as active high in device trees,
> which contradicts the panel hardware as well as the panel-common.yaml
> convention.
>
> Fix the driver to assert the reset GPIO to put the panel into reset,
> and to deassert it to release the panel from reset along with adding
> a gpiolib-of quirk, which enforces the active low polarity of the
> NT36672E panel reset GPIO. With the quirk the reset signal levels
> remain unchanged for dtbs, which describe the reset GPIO as active
> high, and device trees, which describe it as active low, start to work.
>
> To: Linus Walleij <linusw@kernel.org>
> To: Bartosz Golaszewski <brgl@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>

[Severity: Low]
This fixes the inverted reset GPIO logical polarity from the initial driver
commit.  Should this include:

  Fixes: ea4f9975625a ("drm/panel: Add support for Novatek NT36672E panel d=
river")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126134508.3207=
00-1-vz@kernel.org?part=3D3
