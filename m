Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DBB606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+sS0rU6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4160010E2FA;
	Mon,  9 Nov 2026 06:07:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E87010E6EB
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:06:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C143611A0;
 Mon,  9 Nov 2026 06:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E151F0089F;
 Mon,  9 Nov 2026 06:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794204414;
 bh=8X4vLobARokYUJFhoVUN93CsOOvRJbAxF9W/UNeLn/c=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=W+sS0rU6A8yRcsFl47ZTULgPurSvpE6L3H2jBT6iqetOg1XXSiaVBRcFR6+Ixkq+i
 NTo+xRZXgIh49cGQ5aO5MpYgBAMuIFvitelNj4P4I8yvZlcjRdL3A4bjYTvskSUzDc
 1VbSBpF7xKyN8WEq3oMGrydB13ly1CNgxPrlt9vYW8SuQY2os0jPDCaJ7PxcAP0lTA
 11P0yg5W39vq2MuNfs6tIVlmkrq6yCRcpokf5F62xcIcX0tKlU+EAv3kfakOeIiLMZ
 jC6ttJUDD6mZ147KGIe7S9ZnCf3UETmLXS2TUX3g1pGhXl5t58mvWpxvRjeZR9f26z
 IhW5FD3Iea7NQ==
Message-ID: <sashiko-outbox-204483@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/6] drm/gma500: Propagate SGX MMU setup and GEM pin
 failures
To: "Gabriel Gama" <operatingsystemsdepression@gmail.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261109055451.17458-6-operatingsystemsdepression@gmail.com>
References: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
 <20261109055451.17458-6-operatingsystemsdepression@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 06:06:53 +0000
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
- [Low] drm/gma500: missing Fixes trailer for MMU error checks
--

commit 781534e30915fea9a7d73d13c97f11a95323ad77
Author: Gabriel Gama <operatingsystemsdepression@gmail.com>

> drm/gma500: Propagate SGX MMU setup and GEM pin failures
>
> Check the GEM GPU address and perform transactional MMU insertion before
> changing cache attributes or publishing the GTT mapping. On failure,
> release temporary pages without publishing a pin and return the error.
>
> Propagate stolen-memory mapping failures through probe cleanup before
> installing a hardware context. Existing cache-attribute error handling
> is unchanged. This depends on the preceding rollback fix.
>
> Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>

[Severity: Low]
Since this fixes the unchecked psb_mmu_insert_pages() and
psb_mmu_insert_pfn_sequence() calls, should the commit message include a
Fixes tag?

  Fixes: ae012bdc5799 ("drm/gma500: Hook up the MMU")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109055451.1745=
8-1-operatingsystemsdepression@gmail.com?part=3D5
