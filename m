Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5198606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koFQ8muA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C0710E8B3;
	Tue, 24 Nov 2026 15:08:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7231810E8B3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:08:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9922C60F86;
 Tue, 24 Nov 2026 15:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0211F000C0;
 Tue, 24 Nov 2026 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795532929;
 bh=wgWLhpV+kH8K1X7Giq5qfKezqAa6iTtwuEl3zl+gw7M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=koFQ8muAUlhVxnuiYK4kXfHnDe47FmQwJhzWCCl6F7bFg6SY60sw5IfbpF25D04ua
 q2TWdaUXaWuozvxqrm63CG5PiSJufU4b4P4j+pmvUjoSggXqZzy2EUWpX8fI/i5Cp9
 cLDes5aDszD0pMwKSjD/gBfCg5vdQOl+OcIfzCWegy1Q76u+oLsZDw/3b0uXZwgGZV
 6ee6xZur6UzCteIgvYpDzzw/WZbk6YEYX/vRczBxsSTDxISgfwVyYiCwDy1RcBxWeO
 46ovb5Qb8z+J7iEUXCgO1KMDvsXXo8IOaD1mpQWmZFGBqHX94fC8BpjsbuBFOGeG0C
 qrTskgpfZ9E9g==
Message-ID: <sashiko-outbox-231391@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: linux-next: semantic conflict between the drm-misc and broadcom
 trees
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261124145652.3657102-1-sashal@kernel.org>
References: <20261124145652.3657102-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 15:08:48 +0000
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
- [High] platform/raspberrypi: missing Signed-off-by trailer in commit
  message
--

commit bbb76af5c6433d9b8132e79161f9eb212a02ceb8
Author: Sasha Levin <sashal@kernel.org>

> linux-next: semantic conflict between the drm-misc and broadcom trees
>
> Hi Mark,
>
> The current drm-misc tree has a semantic conflict with the broadcom
> tree that breaks the build:
>
>   drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:217:3: error: call to un=
declared function 'dma_buf_unmap_attachment_unlocked'
>   drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:438:8: error: call to un=
declared function 'dma_buf_map_attachment_unlocked'
>
> 77e0b2d2f4f3 ("treewide: Rename dma_buf_(un)map_attachment() to
> dma_buf_(un)map_sgt()") in the drm-misc tree renames the functions, and
> 6e0a8f1a8347 ("platform/raspberrypi: Add VideoCore shared memory
> support") in the broadcom tree adds a new user of the old names. It is
> the only caller in next-20261123 that the rename doesn't cover.
>
> The fix for the merge:

[Severity: High]
The commit message is missing a Signed-off-by: trailer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124145652.3657=
102-1-sashal@kernel.org?part=3D1
