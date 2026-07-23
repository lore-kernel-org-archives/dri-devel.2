Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17BAC531CF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0572310EFC0;
	Thu, 23 Jul 2026 09:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HctHJSfm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4E410E57D;
 Thu, 23 Jul 2026 09:28:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B1193600AD;
 Thu, 23 Jul 2026 09:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF031F000E9;
 Thu, 23 Jul 2026 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784798896;
 bh=3PNdn0S7w0qgb/ZvuAljb2K/5ST6bGlNkAYjIoGbaks=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HctHJSfmjQ+4RIeZr+ACRRACcOSpUa7Ae5mgt7DI0cu5vf2GQnhDk4FCPiXcTHUWx
 SoCybiusZQIxbncufPAwxr1Z+0GbDPJMYAXxwcmX+6fKbzhfk7Kyey9zxTL69cbm1o
 una7h0vSMlfdw9drFExJvjiLBZLTs8LDxgSBjTP3hlivLWjtU22S9lQa/y70OtlZzg
 Cw0TRlvUGpbXMrvQKm4YnuUdDfQ4Lip3gUeYEG+QCZR3/LxT3+PYxqAvjdXqWcWrVZ
 GK4/VeEbn+dVnWGTyJmDew/ENTg6VFid2ibcQkNv3y/D/7FyR1EZwWHmHKs9FBTf3H
 giRqO3tXoIN/w==
Date: Thu, 23 Jul 2026 11:27:51 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 andi.shyti@linux.intel.com, krzysztof.karas@intel.com,
 krzysztof.niemiec@intel.com, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/fb-helper: guard against NULL fb_helper->funcs in
 restore path
Message-ID: <amHed5UASdD_3Foc@zenone.zhora.eu>
References: <e1957da52fcdd1d88a285553d36e12a0362a8258.1784196681.git.sebastian.brzezinka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1957da52fcdd1d88a285553d36e12a0362a8258.1784196681.git.sebastian.brzezinka@intel.com>
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

Hi Sebastian,

On Thu, Jul 16, 2026 at 12:14:33PM +0200, Sebastian Brzezinka wrote:
> When a driver's fbdev probe callback fails before assigning
> fb_helper->funcs (e.g. i915's intel_fbdev_driver_fbdev_probe() bailing
> out early on a DMA/GGTT pin failure), the fbdev client stays registered
> with fb_helper->funcs == NULL. Any later restore, such as on drm fd close
> via drm_client_dev_restore() -> drm_fbdev_client_restore(), reaches
> __drm_fb_helper_restore_fbdev_mode_unlocked() and unconditionally
> dereferences fb_helper->funcs->fb_restore, causing a NULL pointer
> dereference.
> 
> Guard the fb_restore call with a NULL check on fb_helper->funcs.
> 
> Fixes: 2ef5754c9649 ("drm/i915/display: fbdev: Move custom restore code to new callback")
> Signed-off-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
