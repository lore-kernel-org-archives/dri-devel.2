Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B60DC79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5EF210ECC2;
	Tue,  8 Sep 2026 15:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AV9cKUZR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82BA10ECCC;
 Tue,  8 Sep 2026 15:28:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF872601FD;
 Tue,  8 Sep 2026 15:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D9C1F00A3F;
 Tue,  8 Sep 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788881328;
 bh=i5px7Z02W9P6PnBrjrtniLAiKpg60s8L1n7dEkh5OQ4=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=AV9cKUZR4BhWai6g0oRaFc+2nidqX3yLaigBsGDyNfIM9Tp9ryU2OpqVcrUTzyMJ0
 a7rHY3+Dxqx77MNGGXEBHbWhivFf1kRuBhB9zr/0JzXUii3rBKbtWHVLrXD0ObgDKE
 4Rb3TTUQ6T9sL8hZvgbUK7hQfZFnSfYzfcZ/FiHiCWjzRkUq52HEZ1sLetA+UpjmJs
 ynne02lnBaKeUPBAbk/k/4X3FDPGQyZPTfqAwwbsLw46L4fAPFbthEt35ALko5jj9M
 X8EzF/TchCrO3QWwCAYH97FlSzn+aZabOSmxvtw5S7rlS3RMAGxFks23AE3qmOuA7A
 MMWb30OAsCDbA==
Message-ID: <88959eaf8836f080a10f67dda5e2adda@kernel.org>
Date: Tue, 08 Sep 2026 15:28:45 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 6/7] drm: Implement
 vga_switcheroo_client_ops.post_switch
In-Reply-To: <20260709092215.168172-7-tzimmermann@suse.de>
References: <20260709092215.168172-7-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dakr@kernel.org, deller@gmx.de,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com, jfalempe@redhat.com,
 joonas.lahtinen@linux.intel.com, linux-fbdev@vger.kernel.org, lukas@wunner.de,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tursulin@ursulin.net,
 "Maxime Ripard" <mripard@kernel.org>
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

On Thu, 9 Jul 2026 11:16:02 +0200, Thomas Zimmermann wrote:
> An output's attached display might have changed while a DRM client's
> device did not have the output switched to it.
> 
> The nouveau_switcheroo_reprobe() callback sends a hotplug notice to
> DRM's internal clients, so that they can reconfigure their display
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
