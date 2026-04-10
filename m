Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786D4F459FC
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07FE10E9B0;
	Fri, 10 Apr 2026 17:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="l+CeHIAg";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813F510E9B0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775843713;
 bh=feAs37zU42FYD8EtE7KDyOfyphBRasa5VdzBOGLTvw4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=l+CeHIAgAM6QIztoc9rW9e8Ch1ETYKuvB0+GoSFKnwse8TMIKLG3S8FqVszOas6eQ
 OLPAyHD4cEOZnUrn/CcwbKiNkT+zJIgtWQ9V89H2KARq/sn6jMkuA2b8QHfeeg1AQd
 aPoPqEdlO4jyBPC9pbvYl67afM6U8MEj4vyo42PR9JWej8YkW+REN2OKaGtikz9hvd
 qFRgQNai2+bR9eG+IimpzERDJPAU962vl/C3DZw6VQevVbZeEkBZ5wzg0lvStkbR2R
 gpIkpSEeQXj/NPTbqY43WTCucWoGtLetatRkj1fT79gyFryeRPeMg5tlCVAl/HPqy9
 b9Csi/UHoXO2A==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 92C9917E10F4;
 Fri, 10 Apr 2026 19:55:12 +0200 (CEST)
Date: Fri, 10 Apr 2026 19:55:08 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] drm/panthor: Replace cross-component register
 accesses with helpers
Message-ID: <20260410195508.43c367c5@fedora>
In-Reply-To: <20260410164637.549145-4-karunika.choo@arm.com>
References: <20260410164637.549145-1-karunika.choo@arm.com>
 <20260410164637.549145-4-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 10 Apr 2026 17:46:32 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> +u64 panthor_gpu_get_timestap(struct panthor_device *ptdev)
> +{
> +	return gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
> +}
> +
> +u64 panthor_gpu_get_timestap_offset(struct panthor_device *ptdev)
> +{
> +	return gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
> +}

There's a typo here: s/timestap/timestamp/
