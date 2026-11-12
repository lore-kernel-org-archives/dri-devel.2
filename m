Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D02A606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjQPuAIm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F90810EBBF;
	Thu, 12 Nov 2026 16:15:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C4310EBBF
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:15:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FDF246180;
 Thu, 12 Nov 2026 16:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBB81F000C7;
 Thu, 12 Nov 2026 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794500120;
 bh=3qloGhbNz15UUQzFVqBP20Tld4gTikU+XHSf/lqerJ0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=GjQPuAImnh7KdSeIHXHZ5xHcxvhEdeu0LkrGUethED/s8FzDqkSzr1WLHvLzHyiIX
 Q1v0ziw0KfXjbf3m6l6/ubNFU1dBpyfDS9iAZl3AvnjeLKvYfn/ZChsvz1/YQfoxT+
 NV9gwrZCaY4R5kqDNwVwuyKmezm9ujCz0fRriDR9Xnc+zzhy6k0vMov42w6eQhOMaW
 9ugbB/aEKdTM2QyXFsNe/8Q7/tYnGWo3U5b2k3qFzxIccGQEjPxcVXkvUFpGUIxyHg
 90Z8VYzEAuERNqr++tjTbWKhW7o47FA1eb8CpNggnbaofg3sneC8J4cM8gCz6xpbgX
 SbPQjrh8RQz3g==
Message-ID: <sashiko-outbox-211484@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/a8xx: Fixup hw_err_irq messages
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112160706.387641-1-robin.clark@oss.qualcomm.com>
References: <20261112160706.387641-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 16:15:19 +0000
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
- [Low] drm/msm/a8xx: missing Fixes: trailer for a8xx_cp_hw_err_irq()
  bug fix
--

commit a5cb62925f6bda8ba8bcbb7f74369ec6522ba176
Author: Rob Clark <robin.clark@oss.qualcomm.com>

> drm/msm/a8xx: Fixup hw_err_irq messages
>
> Handle all the pipes, and don't clobber 'status'.
>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

[Severity: Low]
Since this fixes missing pipe fault checks and clobbering of status in
a8xx_cp_hw_err_irq(), should this include a Fixes tag?

  Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112160706.3876=
41-1-robin.clark@oss.qualcomm.com?part=3D1
