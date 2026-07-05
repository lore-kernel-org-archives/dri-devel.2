Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897CEC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 06:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F29B10E13A;
	Sun,  5 Jul 2026 06:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sA0cJBia";
	dkim-atps=neutral
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4870D10E12A
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 06:24:12 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-737de525d2eso1946629137.2
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 23:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783232651; cv=none;
 d=google.com; s=arc-20260327;
 b=LT8TZfzjrqtC8VOPTPNVsojcPki+1xqtiC7xBk1rsULLPkJZuCaq5x55h1sKYSNreD
 julcmCS1Te9vvF5dJN6m23Hr52hIqHwx4mOJxG8QSO1osa9Z7yqdW+Et3H1PvW+q0aHM
 Jq6MHd/j3aYAd+m1yatMkuDTHyudMRPwhFz/roQV++OLkQYBWg0qCquyCY6vzC7HUJnH
 0M/NFFX9d3/jkXuxk0V6KPO3P9Zjl/jk40Y46cEIiKWq1mVMRLsk2BmzhmRh1jibqAYI
 AQ9E4gqknlmfSLxBi+tEfzLKOQy8S1YEvpSJCxLIBSNJlfeCiaBPa9of+vD+i2Ma95FG
 IeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cy2Jt6lny7j/yQ3c78NTqavzrjxuBgUkufs4x1Ayla0=;
 fh=k36u5oks0pSGKHBD3wpCxQZQLsCavGghJIsgEfA9Sj8=;
 b=XK+jEHqZz/RqOrSU92xdkBBOiUDp+MD6HGQvNeP8wlekvthAuB4PoYhggTBc8tsYzs
 7FGukBAZWRoS2tplJNNK8s17zRdtofJY+YNpP55wTf8FxmZWwiBl8iTmgWt/+5m8qxaz
 47U2IvAyMmLcEX0uwyQpwuCw3aJQivd0Ew0n4JM3PUrtf7IVhruMbeNjpJTwfrpU6+NX
 KdZ+OVz3uZMIsYUacJ3OF14VrxWY4tOJMQO8ZXdwhCUQcObo3yOMwUuindmBEG5plCO0
 YIeR4Qib+IOA7pQJ3n4WzrovF1ISCd9my7LynBpwxsSD3G2FpYki754bKtk2xTqpQlvI
 wb/Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783232651; x=1783837451; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cy2Jt6lny7j/yQ3c78NTqavzrjxuBgUkufs4x1Ayla0=;
 b=sA0cJBiaaFuULV+H8rgNFcd2gL0FKb6mqp07snU82npKArw16BOfGxgcCDT6OJ9Ho6
 AuLeDcnCaigVuQT1r2yfTF4/cTtbbgpgesXELzQlBOKZH7wzmnHTOwRgubz0vV96i+Qr
 E8Z+jNbqU8KFnqjF74/stKumKTe4Ec7EH+3OwEEsk536eJznpO3MSC2uQjwv1kD7VDor
 GBdJN8uIKU/3aOnZYU2SfhWyD+oKXW3V7uns0JLFtT40TC8vBlP2lp0Ng/NN1+nzkvf0
 glkehs7EVYe3gujVDYDRbB2plKulUUsU+xNqjNxUcx2dy/2WYuMNnD/bTtnwext7kdBn
 ixDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783232651; x=1783837451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cy2Jt6lny7j/yQ3c78NTqavzrjxuBgUkufs4x1Ayla0=;
 b=RSVkDRu1PH5ZjGGOILfRKVcQgnehz1gkEMb61US11fByoAqxGYCvJuM1zO/1dAKjab
 D1nZ/sSWlpFNKw7r4F/h0R0DcImRWIBkKZq6sxdsnArPtopbZwYmX6juAcPC7keT8ZcF
 Ev+xQLi7q+NKNbfmolK7px3t7aVr+QRm8o9c1aDdQN4HMsA8kQODb4c/p4jDpKOXNYdb
 ozJNRQzdwyFLaTDO2Pfq019dlZKaApIcrExtwTX+AJh/RWGHKDOSUMtz6/Ewdhz/ni2J
 ii/AXsXjJWQiqeDfAIehdrVAacUkOc2+6JiY808oRnwK5gh4XBCZ8O65gMi37eXT2P0O
 iKcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtjTrlqAlyP31TxtxoXQSscNIi7U0cT1FBtpIVlSPnMIyGIwscQ01ltns2mFZDmm3uTbAhJmYsp/k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzrn0+G+kKbUkT9OAvxxLBx6QYAfQ9eC0FIDC318kfJrQgamIg7
 XooPP47uynhI6fQ2shWyewCIMdKQkIsDPpdCghGENvzM/VzIhIoAyn1ulWWD+wQcc60GKiqg6/c
 KgVcRw+XbYcVTZlR+XZT8k1oeiOwWMEE=
X-Gm-Gg: AfdE7clpJBB1KTQlIZiN8cZl9D5Hq0rtxFUfjH09w/gyiGihEqtng1pCfx7/w/Kov8q
 3FMttYFRq5HM9i39ks1lmzInoAXjB8JbZd3wuLDzyfUl2K0MLJbFr46FMAMOaeV1LnMENPoJceR
 WT9QA2Qef46nDBEMifWK9lx14dlF0TuHwcx3ZyM1aBYm8/yLyutamZ4I01eBX08ty8k492YT/r6
 bTR15tDXMlUcpcYKG+RMVofWJgXFWAa1AdlcoLmZMpXbZ3DJ1plSo6nss8bz3YqWGr6qZe9S5ni
 Ivh6bkokNTzXqvEnZ/cnLSmTgGM=
X-Received: by 2002:a05:6102:e06:b0:643:80f1:350a with SMTP id
 ada2fe7eead31-7427ce18c0dmr2135936137.2.1783232651081; Sat, 04 Jul 2026
 23:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-exynos-drm-simple-v2-0-a8d59678b7d2@gmail.com>
In-Reply-To: <20260623-exynos-drm-simple-v2-0-a8d59678b7d2@gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Sun, 5 Jul 2026 15:23:34 +0900
X-Gm-Features: AVVi8Cf8yc--a4qZ7FOXrm9j2w5KabYozWK2_t--A7TY5sNuVyS73aMpX1qw6v0
Message-ID: <CAAQKjZN12OSBg+ch+xf+-uO6_Sbrtq-o8AkLdLA3mFQ_ubiLxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/exynos: DRM encoder improvements for Exynos
 devices
To: Diogo Silva <diogompaissilva@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

It looks like you may have forgotten to post the v2 patch. Could you
please check?

Thanks,
Inki Dae

2026=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:19, =
Diogo Silva <diogompaissilva@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> This series does two things:
>         - Open-code drm_simple_encoder_init() since it is deprecated
>         - Handle the error code from drm_encoder_init (previously
>           drm_simple_encoder_init) to prevent silent failures and
>           cleanup of uninitialized encoders
>
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
> ---
> Changes in v2:
> - Fix mistake in exynos_drm_vidi
> - Fix indentation
> - Link to v1: https://lore.kernel.org/r/20260623-exynos-drm-simple-v1-0-b=
b52f098b1ee@gmail.com
>
> ---
> Diogo Silva (2):
>       drm/exynos: Remove dependency on DRM simple helpers
>       drm/exynos: Add error handling to drm_encoder_init()
>
>  drivers/gpu/drm/exynos/exynos_dp.c       | 13 +++++++++++--
>  drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 14 ++++++++++++--
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 11 +++++++++--
>  drivers/gpu/drm/exynos/exynos_drm_vidi.c | 14 ++++++++++++--
>  drivers/gpu/drm/exynos/exynos_hdmi.c     | 15 +++++++++++++--
>  5 files changed, 57 insertions(+), 10 deletions(-)
> ---
> base-commit: 60326b17f877e12846167bf8ef83680b9875218a
> change-id: 20260623-exynos-drm-simple-bb5386d64597
>
> Best regards,
> --
> Diogo Silva <diogompaissilva@gmail.com>
>
>
