Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD11CD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D89C112905;
	Thu,  4 Jun 2026 18:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XK165cnR";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DCAC112905
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780596139;
 bh=roHnOO6PR5PMKjQ4Zpx9Ftl9QWQlUI8Jeetmvwdosng=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XK165cnRMhMQL9W0EO+PZ0Alad3bxW4i3RwcIyWidfjrAQhqMt/hAvjLL7zTimE02
 P27ahs825A0XqbrwrG8qkPJnJ+WN3Iv6g9rPxMh0m1YmLm5jvCg/hsNLzV7MM+vwgK
 lCkQYgiw728VIly+LdHKQjWQ4YDYFpbotYlvYHde9Tj9/NRattaBR23BUQ77Qf6+1v
 IHZ+NReu6ooaFlmsLn6VBEyF2R2gqIyKbDf8ml5Wa3fU8NRAmX+kQTmEQCutW772bF
 ZcaLMLb+7QqZMk8j4mf5XrF9dvfGZUaXx5xFdGeVac0I+qaJkcTVo+7huy4a8ODOlP
 OSHNPXwKGV5cQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 874B717E062B;
 Thu,  4 Jun 2026 20:02:18 +0200 (CEST)
Date: Thu, 4 Jun 2026 20:02:15 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
Subject: Re: [PATCH v2 2/7] drm/panfrost: Prevent division by 0
Message-ID: <20260604200215.303dbc43@fedora-2.home>
In-Reply-To: <20260604-claude-fixes-v2-2-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-2-57c6bd4c1655@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 04 Jun 2026 18:35:21 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> When updating and debug-printing devfreq stats, in the very unlikely
> offchance that total device time is less than 100 ns, clamp it to 0 to
> avoid division by 0.
>=20
> Reported-by: Claude <noreply@anthropic.com>
> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> index b51c30778811..e34de47bf43b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -78,7 +78,8 @@ static int panfrost_devfreq_get_dev_status(struct devic=
e *dev,
> =20
>  	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
>  		status->busy_time, status->total_time,
> -		status->busy_time / (status->total_time / 100),
> +		status->total_time >=3D 100 ?
> +			status->busy_time / (status->total_time / 100) : 0,

or:

		status->busy_time * 100 / MAX(status->total_time, 1),

>  		status->current_frequency / 1000 / 1000);
> =20
>  	return 0;
>=20

