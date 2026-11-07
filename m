Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E63D606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNQEz9Fi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5845610E032;
	Sat,  7 Nov 2026 00:12:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A1810E032
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 00:12:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC77E40917;
 Sat,  7 Nov 2026 00:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D161F0089F;
 Sat,  7 Nov 2026 00:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794010341;
 bh=uNVQmzo/bHycePIwRqcpdfaMQStdj9PdAW1IeyQRRcc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=QNQEz9FigoGEUHfAuxKirO26K/U5OC5hY9W7a0Z5KJUJ9hY/CFLJCgmE5VATNVTtj
 /LNQDleujtEbPSGI7AIW/pb9IiyNscNB7rES3Fl2RJpBbfWlanmvik5lbagIFJOo1R
 6r5ZcC5xLXQZZf+GSOrNbcNJW4qLwLJSGcwJ3GAnZAati1P5kzESwTtrUe+vuH8lLD
 KtYMduSaLhYEVFxfK0Kxro/7Ifda0mKtI9L8BHDfKb00BXylfd8RwMVikFewyP89Nj
 4xPz6KtNg+KMRmGz1mfAZ6uGJ6zMhLTGhwwfQ17jtQVEshlohK9MSXcxfNvdqo5Gf2
 DbF0lJ6vp7Zmg==
Message-ID: <sashiko-outbox-202414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/15] drm/msm/adreno: Fix PROTECT span length
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261106232220.47602-9-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
 <20261106232220.47602-9-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 00:12:21 +0000
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
- [Low] drm/msm/adreno: missing Fixes trailer for CP_PROTECT span length
  mask fix
--

commit 7bc09402b77f2e494b3bf9d1610efc50f87c8cb5
Author: Rob Clark <robin.clark@oss.qualcomm.com>

> drm/msm/adreno: Fix PROTECT span length
>
> Don't let the length bleed into b31.
>
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone =
3a)
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

[Severity: Low]
This fixes the _len bitmask in A6XX_PROTECT_NORDWR and
A6XX_PROTECT_RDONLY.  Should this include:

  Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106232220.4760=
2-1-robin.clark@oss.qualcomm.com?part=3D8
