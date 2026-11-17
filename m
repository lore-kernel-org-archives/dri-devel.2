Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B5606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkCAT53R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA7A10E50E;
	Tue, 17 Nov 2026 01:32:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54B210E50E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:32:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E070423C8;
 Tue, 17 Nov 2026 01:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536781F000C4;
 Tue, 17 Nov 2026 01:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794879152;
 bh=tawZZIx0KcDqO/xm6e7gYNE2MVGM3yyNu2hg/24PLTY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HkCAT53R6Wao3IINNaq75tjkrRESWMbMS6vBmg1L7zO6Z8uyZSRfXyAW62UV4EXr6
 sFrUQSCntlMoQBq7Ask8pRcyweF3hoiNAFVCjPj3hN5lo7dYmWzUjsAzxcGo2lriTh
 gUkPO8R8IrBF+5HTBFLsJ9KBf3nXofnZ35auM2LaZJv40y+TNgn4Y/pmFd7GfcED7L
 +pvC3Nsqpu3aP53ILkOpvPUb6mJuFwTtpmMUVRTRhLHAoiFl+mr1t/KxzCYLVNivSh
 P4YoHKuSWGhVI7atwogfrsNY6cY8vJZs6gxg0zxvtz4M4ya/uqseDCNzX3usH1KjL0
 VgA1NfkUHPedw==
Message-ID: <sashiko-outbox-218045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] drm/vkms: Add KUnit test for BGR565 writeback
 conversion
To: "Sidharth Saha" <ssaha2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-rgb565-test-v1-2-27f49c1aa694@gmail.com>
References: <20261116-rgb565-test-v1-0-27f49c1aa694@gmail.com>
 <20261116-rgb565-test-v1-2-27f49c1aa694@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 01:32:31 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/vkms: unroutable GitHub noreply email in Signed-off-by
  trailer
--

commit f9d2ab12880eb54ad84218efebd8fde44f4e329b
Author: Sidharth Saha <ssaha2000@gmail.com>

> drm/vkms: Add KUnit test for BGR565 writeback conversion
>
> Reuse the RGB565 writeback cases to test argb_u16_to_BGR565(), which
> packs the same 5/6/5-bit channels with red and blue swapped. The
> distinct-channel case checks that red and blue land in the right bits.
>
> Make argb_u16_to_BGR565() visible to KUnit so the test can call it.
>
> Signed-off-by: Sidharth Saha <40047656+Sidharth-Saha@users.noreply.github=
.com>

[Severity: High]
Should the Signed-off-by trailer use the commit author's routable email
address (ssaha2000@gmail.com) instead of an unroutable GitHub noreply
address?  The current trailer does not match the Author header and does
not satisfy the Developer's Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rgb565-tes=
t-v1-0-27f49c1aa694@gmail.com?part=3D2
