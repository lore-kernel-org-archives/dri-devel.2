Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954C1CD6E64
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED4110E570;
	Mon,  1 Jun 2026 11:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pR31DhYD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D346510E570
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 11:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aMahThsNoIqZXfjOF2caMWeci/HFO5adL+UBVjcqL8Q=; b=pR31DhYDdImvReAAz/H83t26EX
 Sz9oRA8XD5nJWAHQr9Asb7WXqJPhw8OPMtdmb3HPvaXIxjDQ7rp6JbswCseiiLrKlYzXyP1C5kISI
 WyM8gZCIC8qh1xuuT+XuFKKZ9n3i+deqf3/9qx87NlxIph0ErcEhtxVp/WjVIaaJ4bOGDjvKzH/rK
 BTZ7W9pQmMHTPEet0dWDBdeN4hgdGOyvy4jUVOS5aPITITVk/6m3enlVlPoXsMvhC1pacF4tEK9MT
 HwETKOK+C5FWVgkvgrjuAbeDRIkXDW1RgEq8O7vO6iAR0NQsH5k8cMOJXGBhZoDgpAjnwthpI1MYO
 KUrnyt2A==;
Received: from static-234-112-85-188.ipcom.comunitel.net ([188.85.112.234]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wU1C0-00B03V-9Q; Mon, 01 Jun 2026 13:52:28 +0200
Message-ID: <adf25997a5a3e9a2ae1186fc7505461033f76690.camel@igalia.com>
Subject: Re: [PATCH v2 2/4] drm/v3d: Refactor perfmon locking
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Mon, 01 Jun 2026 13:52:17 +0200
In-Reply-To: <20260531-v3d-perfmon-lifetime-v2-2-60ed4485a203@igalia.com>
References: <20260531-v3d-perfmon-lifetime-v2-0-60ed4485a203@igalia.com>
 <20260531-v3d-perfmon-lifetime-v2-2-60ed4485a203@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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

El dom, 31-05-2026 a las 17:18 -0300, Ma=C3=ADra Canal escribi=C3=B3:

(...)
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c
> b/drivers/gpu/drm/v3d/v3d_gem.c
> index 1ee3c038d5f6..9487ab7acd03 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -137,7 +137,8 @@ v3d_reset(struct v3d_dev *v3d)
> =C2=A0	v3d_mmu_set_page_table(v3d);
> =C2=A0	v3d_irq_reset(v3d);
> =C2=A0
> -	v3d_perfmon_stop(v3d, v3d->active_perfmon, false);
> +	/* Re-arm the global perfmon HW counters that the reset
> zeroed. */
> +	v3d_perfmon_resume(v3d);

What would happen if the reset happens when a non-global perfmon is
active?

Iago

