Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBF5F459F7
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AD810E9EA;
	Fri, 10 Apr 2026 18:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="azJ9ohxC";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9966210E9E9
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775844508;
 bh=y3LM0sU4axh6UrJQBefLWitalJFNSzQ3niKQlSuqcVU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=azJ9ohxCNNLlGqAmRNHgBkRDKKeQEg5dzcofW+N+jQYa67OBVVRQ9NKQFG/7qAHbE
 7CeUGfDZ5xp+eldnLpZ22ycKp0DK+VO+PBsVzL3ongr6x3qiAnPooXUVN0LJgIXOLh
 8rCrLz1cMrqNAfY9TYacsi0pIu9rUJpgRLjzPG8WzkyzunYl32BMM5ucicWaXw9T1k
 N9u6yrZsOAIHs8cUrDYwCi0qRclw21Q2t4dnbZhFta77P82/GcIGVFWKonlbmW7vgH
 g+nSesfoH6pqXbJocFEqcoVy3pTB7cw2Gf6ntpFsjqe8PZWbg8BhD2yvTJr9/p27MA
 3hR54j6lkPIUw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DAEB617E05FC;
 Fri, 10 Apr 2026 20:08:27 +0200 (CEST)
Date: Fri, 10 Apr 2026 20:08:23 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] drm/panthor: Split register definitions by components
Message-ID: <20260410200823.5110f2b6@fedora>
In-Reply-To: <20260410164637.549145-3-karunika.choo@arm.com>
References: <20260410164637.549145-1-karunika.choo@arm.com>
 <20260410164637.549145-3-karunika.choo@arm.com>
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

On Fri, 10 Apr 2026 17:46:31 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_hw_regs.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
> +/* Copyright 2026 ARM Limited. All rights reserved. */
> +
> +#ifndef __PANTHOR_HW_REGS_H__
> +#define __PANTHOR_HW_REGS_H__
> +
> +#define GPU_ID						0x0
> +#define   GPU_ARCH_MAJOR(x)				((x) >> 28)
> +#define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
> +#define   GPU_ARCH_REV(x)				(((x) & GENMASK(23, 20)) >> 20)
> +#define   GPU_PROD_MAJOR(x)				(((x) & GENMASK(19, 16)) >> 16)
> +#define   GPU_VER_MAJOR(x)				(((x) & GENMASK(15, 12)) >> 12)
> +#define   GPU_VER_MINOR(x)				(((x) & GENMASK(11, 4)) >> 4)
> +#define   GPU_VER_STATUS(x)				((x) & GENMASK(3, 0))

Any particular reason for not having those defined in
panthor_gpu_regs.h?

> +
> +#endif /* __PANTHOR_HW_REGS_H__ */
