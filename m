Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96314606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoF6V+Q+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F7210E230;
	Mon, 23 Nov 2026 09:06:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D2D10E76E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 09:06:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 593B042B39;
 Mon, 23 Nov 2026 09:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ABF1F000C4;
 Mon, 23 Nov 2026 09:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795424802;
 bh=dFSe+alZLU94uoeE3YQ9ENGH7Tp7pGy8bvEYnLIRQYc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=DoF6V+Q+o8dMYtYN8ZmtMVuuaeJi0ycWMINPQzsfTnN/CcFJPzVNGi/M1vnkyJtQR
 ik2LrGj77UrA8ALnh5z4H1wmS+/BjhF9IxhuYeKk0QFPGMK3Kn9Su2wIpXO6KFpNmQ
 5Wsq7einrZa22QXnjb28n/I5WS57qYhGI7pbGNLGODd+2aC/TIGk6GQB1yC02tY54e
 qnzINHLSTftwK47BKVfzSvVxyEmyes1Mikn0qRUp6o8uWdsWU+sPD01/TGPJ7Sal01
 k/lfMU0OJzHV9HFDP8M49z5inNOZGrpikqJWqTaIkX8nL7X0sCGOPtACTljolwcCeN
 jq/8fzjdx+WOw==
Message-ID: <sashiko-outbox-228935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: Allocate a scatterlist per userptr dma-buf
 mapping
To: "Karol Wachowski" <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261123085935.623564-1-karol.wachowski@linux.intel.com>
References: <20261123085935.623564-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 09:06:42 +0000
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
- [Low] accel/ivpu: invalid commit SHA c0b3fef87069 in Fixes trailer
--

commit 4be7b1f71890e3b0656af1c546014270a1bde777
Author: Karol Wachowski <karol.wachowski@linux.intel.com>

> accel/ivpu: Allocate a scatterlist per userptr dma-buf mapping
>
> The userptr dma-buf DMA maps the same sg_table on every map_dma_buf(),
> so a second mapping would overwrite the DMA addresses of the first one.
> It only works today because ivpu is the only importer.
>
> Build a new sg_table from the pinned pages on each map instead.
>
> Fixes: c0b3fef87069 ("accel/ivpu: Add support for userptr buffer objects")
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>

[Severity: Low]
The commit referenced in the Fixes tag, c0b3fef87069 ("accel/ivpu: Add
support for userptr buffer objects"), does not exist in mainline git
history.  In mainline, that commit is 57557964b582 ("accel/ivpu: Add
support for userptr buffer objects"), so the tag should be:

  Fixes: 57557964b582 ("accel/ivpu: Add support for userptr buffer objects")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123085935.6235=
64-1-karol.wachowski@linux.intel.com?part=3D1
