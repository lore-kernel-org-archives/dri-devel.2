Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A23C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 07:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB2010E422;
	Sun, 28 Jun 2026 07:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Afr0EmOa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FBD10E422;
 Sun, 28 Jun 2026 07:34:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ED0EC600B0;
 Sun, 28 Jun 2026 07:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F061F000E9;
 Sun, 28 Jun 2026 07:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1782632084;
 bh=Ln2Tw+sGy7ydx3N8w0OkVCZpqvk/JGyFu6srxkz+XKI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Afr0EmOa6NBBjm3Xh270RvPlky6vA6jlGxZXo7PE0y/xZUUsuNbJz84uzMsThfL/J
 bF7+54lJR1rxvyTr7aW4T1SvwPGMDe6Ehat6J9FOAsrrK3twV7tu8GanRDy3aPwPKn
 x3Zk+L4JHEeYovpICqR9MCQB9G0COGKtAEwy/OgY=
Date: Sun, 28 Jun 2026 09:33:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/amd/display: set new_stream to NULL after release
Message-ID: <2026062816-contour-womankind-1646@gregkh>
References: <20260628072740.8884-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628072740.8884-1-vulab@iscas.ac.cn>
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

On Sun, Jun 28, 2026 at 03:27:40PM +0800, WenTao Liang wrote:
> In dm_update_crtc_state(), the skip_modeset path releases new_stream
> via dc_stream_release() but does not set the pointer to NULL.
> 
> If a later error (e.g., color management failure) triggers the fail
> label, the error path calls dc_stream_release() again on the same
> dangling pointer, causing a double release and potential use-after-free.
> 
> Fix this by setting new_stream to NULL after the initial release.
> 
> Fixes: 9b690ef3c7042 ("drm/amd/display: Avoid full modeset when not required")
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
> - Correct Fixes hash based on reviewer feedback

Did you forget to include an Assisted-by: tag?
