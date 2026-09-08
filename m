Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B5EC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C616F10ECA4;
	Tue,  8 Sep 2026 15:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WJaO26YQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D59510E61E;
 Tue,  8 Sep 2026 15:27:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EB6F400EF;
 Tue,  8 Sep 2026 15:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADED1F00A3A;
 Tue,  8 Sep 2026 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788881223;
 bh=45Fa9JFJgFfxvMXU87kkWtdb4QSxmQx0SdJUFfq54ZE=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=WJaO26YQEBESzQ+3+b4rBC4UvX2za9FEQXE6OjU06tsjMOKruOfHgjVU3OfNEKChr
 Vyoi1VuCgZ3tlP62Ne6W+P7cu3seWG0c/EHV1AFLITSLy5tFI2iqIb8hmbhxb7Kvl9
 WFNMiCfnk4ILz94eoTQWnkmM16Mjg+5EWijqRsK0cQP9UPnZo1DdiwmDs1Hk9/tPJO
 PlS6aH1ZBPSAyr7BcO6VhkrJqpyV5xIxqPrnFO4tytf7Y4EwEIV3jv9xQ4+Ml+kqMT
 AFMq2j7A4SCxp6nKvzlPeQ8PtwtNc7gmAlwN93R3Ams3lJkVXm13RWHUJhwxGt6PuR
 vqjKcbOPxYy5g==
Message-ID: <467a6478db3c7140ca9f4d0e5c11d029@kernel.org>
Date: Tue, 08 Sep 2026 15:26:59 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 3/7] vga_switcheroo: Add pre_switch callback to
 client ops
In-Reply-To: <20260709092215.168172-4-tzimmermann@suse.de>
References: <20260709092215.168172-4-tzimmermann@suse.de>
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

On Thu, 9 Jul 2026 11:15:59 +0200, Thomas Zimmermann wrote:
> Add pre_switch to struct vga_switcheroo_client_ops to inform the
> switcheroo client about upcoming switches of the outputs.
> 
> This callback is intended to replace the hard-coded call to fbdev's
> fb_switch_outputs(). With DRM supporting more clients than just fbdev
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
