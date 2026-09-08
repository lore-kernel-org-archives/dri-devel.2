Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CF9C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECDA10ECB7;
	Tue,  8 Sep 2026 15:27:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XvCV66AB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D187810ECB9;
 Tue,  8 Sep 2026 15:27:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B8DC54081D;
 Tue,  8 Sep 2026 15:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205C11F00A3D;
 Tue,  8 Sep 2026 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788881277;
 bh=qQbruPdcRkbgl8HfIhF5I/ft20+teeU0jvwgM4rj26A=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=XvCV66ABTo4OWC/44sKVa92p43c+0v2J/iue6EFeR7/Ok7g9uSLGMfm7n9kpFj+16
 eaikSUvoM2QGhoGsPbre8P6lPx0m5u79AcCtOL8NixpXvvpGIOiF04OfQV3zomh5TZ
 f3fXub9npQTUMyUJhRJ5Fswyh1Z5p5dLb8nCk+HQiCMiFmNxmADmW9gI0h4g6nfSGw
 EXqAJM6Y8TwdYsZiWXGUcNq56dSWn3+VTCvOiUanLgZEith4u8+5FXT6jvORYU7bXF
 O2/G0LRiyojLTsip/Af1WrCdo3eZlYiM4WM7rNVggZa/d3sP+EDG9zDB+raGj+HlMv
 9IimSxGYTwg7g==
Message-ID: <73f10ae2aa96eeefbec0f1308d85899b@kernel.org>
Date: Tue, 08 Sep 2026 15:27:54 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 5/7] drm: Implement struct
 vga_switcheroo_client_ops.pre_switch
In-Reply-To: <20260709092215.168172-6-tzimmermann@suse.de>
References: <20260709092215.168172-6-tzimmermann@suse.de>
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

On Thu, 9 Jul 2026 11:16:01 +0200, Thomas Zimmermann wrote:
> Call drm_client_dev_acquire_outputs() from vga_switcheroo's pre_switch
> callback. Pushes fbcon updates from vga_switcheroo into DRM's fbdev
> emulation. This affects amdgpu, i915, nouveau and radeon. No other
> drivers implement vga_switcheroo.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
