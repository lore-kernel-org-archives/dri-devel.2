Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB7606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPJvha8W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4363113247;
	Fri,  6 Nov 2026 23:53:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8030411323D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:53:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34DD4407B6;
 Fri,  6 Nov 2026 23:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF591F0089F;
 Fri,  6 Nov 2026 23:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794009223;
 bh=xJa0jZcpZqeN5vtRcyXU8zvbcrJMLdSjJP3qA98Wz4o=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=LPJvha8WWQCrwK8+nJ6utvCdxSE0N9Y6BAIKkcUaOySQyBW9xRUX+wc+qK6DabAcV
 LUseEWT0glyjPlN3zjpxTh/SQJeEgZ0r/LkdTuV4KrrbC0JQHuFTBRPkBlfgEEStRa
 Uraa6ZgY0jcsmgaR+EZ9BYismSuPzKEtWDmwGGEAXLrn4kqZwLX4gWXLw3MmcDGtS6
 bPpy6cKDxggzFW6u9iyht5wVrNaCUc9S3n+yD6I7AL4xjJ+E2PZwCaavR4GyOUidmz
 dHWFHo0ux0kqU2b2ry/6Zn+jBbTCBjZSwGpxwhPzWGQWVahjIRsKu80UZP9TPhRNRf
 5IalwUAWoAUpA==
Message-ID: <sashiko-outbox-202393@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/15] drm/msm/a8xx: Add missing a850 ifpc reglist
 entries
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261106232220.47602-6-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
 <20261106232220.47602-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 23:53:42 +0000
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
- [Low] drm/msm/a8xx: missing Fixes trailer on a850_ifpc_reglist_regs
  bug fix
--

commit a11014b95b303f1f3c8636f209c0da394344bee8
Author: Rob Clark <robin.clark@oss.qualcomm.com>

> drm/msm/a8xx: Add missing a850 ifpc reglist entries
>
> We want to save/restore all of the CP_PROTECT regs across IFPC.
>
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone =
3a)
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

[Severity: Low]
This fixes an incomplete IFPC register save/restore list in
a850_ifpc_reglist_regs.  Should this include:

  Fixes: b0e029f7cf87 ("drm/msm/a8xx: Add Adreno 850 support")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106232220.4760=
2-1-robin.clark@oss.qualcomm.com?part=3D5
