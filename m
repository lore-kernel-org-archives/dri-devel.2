Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C50606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYoVCJEF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 639DB10F91C;
	Wed, 11 Nov 2026 08:05:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E17B10F91C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:05:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C22543ECB;
 Wed, 11 Nov 2026 08:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39701F00A05;
 Wed, 11 Nov 2026 08:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794384317;
 bh=/LRlIqizB/WkSfvXfYQ6lrYdPo9pDpLIcLCQ42pP8kA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JYoVCJEFOGRk4Pi4rQ5wuBCa5MUrt+Ch0Pgx7nt4EeEgk0oycml9q36zdqODTsPcE
 hnmR9gah4chJiKZREgLQre1xUHbdjTXk0C7RbW6zjYAr/QBkIJtHrgtwxSZXVKm/mY
 XeTK73kJRSJAGNz03hisXJ3mrO7wsQMgqQlactq01EMx865q19ls3JRGkoCZVfQr/X
 W/5/gv2ehbswUUu7fLawlZSWW+vx/B4r1WStqDq+I3JkyUlOtU7MQ4vjcpIRT+swgx
 1Iv5OA+Y1/bECzkCcA8IChr8TnoFGqhj0Fz/tl9rz+5vbiG45e1leXBgcy4gMAaevs
 aj5raCGXOJ4aA==
Message-ID: <sashiko-outbox-208563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Drop dead error check for
 analogix_dp_init_analog_func()
To: "Xiangwu Lai" <laixiangwu@cmss.chinamobile.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261111080149.1567-1-laixiangwu@cmss.chinamobile.com>
References: <20261111080149.1567-1-laixiangwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:05:16 +0000
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
- [High] drm/bridge: analogix_dp: Signed-off-by uses handle instead of
  real name
--

commit b6a1a7f2eef3c9d11adbe1470d41eb8ca3821faa
Author: laixiangwu <laixiangwu@cmss.chinamobile.com>

> drm/bridge: analogix_dp: Drop dead error check for analogix_dp_init_analo=
g_func()
>
> analogix_dp_init_analog_func() cannot fail: since commit 917c8d192ba6ad
> ("drm/bridge: analogix_dp: don't wait for PLL lock too early") removed
> the PLL lock polling loop, the function only performs register writes
> and always returns 0.  The error check on its return value in
> analogix_dp_set_bridge() is therefore dead code.
>
> Drop the dead check and make the function void.
>
> Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>

[Severity: High]
The Author header and Signed-off-by trailer use a single-word account
handle ("laixiangwu") rather than a real human name (for example,
"Firstname Lastname"), which does not meet the Developer's Certificate of
Origin requirements in Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111080149.1567=
-1-laixiangwu@cmss.chinamobile.com?part=3D1
