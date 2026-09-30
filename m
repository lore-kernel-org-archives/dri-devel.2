Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A41CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B12810F144;
	Wed, 30 Sep 2026 17:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ibumzUvK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99B110F144;
 Wed, 30 Sep 2026 17:12:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E41F460258;
 Wed, 30 Sep 2026 17:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F142C1F0089B;
 Wed, 30 Sep 2026 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790788358;
 bh=rcrhRvyt+QUZDK8arHLdmp7/DTv63vewJo7tvJBjxd4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ibumzUvK7zcKE6kZSzlnpMFeJHB4GdEoZ1f1cn7uhXxvY5WiDuP5Uf9/pS/9h0b3b
 w7G4E7/D4vyp4z4uVzwHZOyDnn1AgYkE5kRYnbq0U+Stv9TvLaEl7BxwpFoOY6mwfU
 Zvvvj17CcsFaDrtzbGe2kwu84XJx/QbLJBvjnXeKlynaXPtITLctisIFiZSMITpQwv
 qZXc4oKd0t4EvVvY+xtudL3ysN8RHt7gx3mb+kF5E9DZOdJWaunJMgvzaH/GJKy9rY
 RqJV8QpiPBGQ6QKWa8fIC5PNUN8mr2wbZZ3ypiXIvfclyuxe8HLjnnqnGHGrhLjewS
 i0Uo2BmZIk7Eg==
Date: Wed, 30 Sep 2026 19:12:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 5/7] drm/i915: Use drm_timeout_rel_to_jiffies()
Message-ID: <ar1C7umRWNYnWVy1@zenone.zhora.eu>
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
 <20260915-drm-timeout-helpers-v3-5-f2ae987d861f@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915-drm-timeout-helpers-v3-5-f2ae987d861f@igalia.com>
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

Hi Maira,

On Tue, Sep 15, 2026 at 04:42:20PM -0300, Maíra Canal wrote:
> nsecs_to_jiffies_timeout() originated here and has since been copied into
> another driver. It is now available in "drm_timeout.c", so use it and drop
> the local definition.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
