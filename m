Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E1DC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156D710EC5F;
	Tue, 14 Jul 2026 08:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.b="U4lfxtlv";
	dkim-atps=neutral
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1FB10EC64
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 08:11:39 +0000 (UTC)
Received: from localhost (unknown [95.24.34.24])
 by mail.ispras.ru (Postfix) with ESMTPSA id 5A8654077925;
 Tue, 14 Jul 2026 08:11:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5A8654077925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1784016696;
 bh=VgVmW8xYosn9eiQExAeU/NJmJ4m2IB5bEc9w8himm7s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U4lfxtlvxBqvv4zXOJvCCqXRoI/MEwpNB1CjNePGU3E67/CoorkTnoxv1/H745dau
 tC9O8dXloA/RvxHG+EZn8G8B26BNtcjdsrq/abqTTv3i1b6YAq3QAcW/tKUpGMGzJo
 AkJi/MBCKrccOfzCB5pXZy8N0lIX2lC7Q0PCfqkQ=
Date: Tue, 14 Jul 2026 11:11:36 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Elizaveta Tereshkina <etereshkina@astralinux.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, lvc-project@linuxtesting.org, 
 Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Ethan Tidmore <ethantidmore06@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [lvc-project] [PATCH 5.10/5.15] drm/sun4i: backend: fix error
 pointer dereference
Message-ID: <20260714110040-3d9d1292810372916773a64a-pchelkin@ispras>
References: <20260713175238.715526-1-etereshkina@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713175238.715526-1-etereshkina@astralinux.ru>
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

On Mon, 13. Jul 20:52, Elizaveta Tereshkina wrote:
> From: Ethan Tidmore <ethantidmore06@gmail.com>
> 
> commit 06277983eca4a31d3c2114fa33d99a6e82484b11 upstream.
> 
> The function drm_atomic_get_plane_state() can return an error pointer
> and is not checked for it. Add error pointer check.
> 
> Detected by Smatch:
> drivers/gpu/drm/sun4i/sun4i_backend.c:496 sun4i_backend_atomic_check() error:
> 'plane_state' dereferencing possible ERR_PTR()
> 
> Fixes: 96180dde23b79 ("drm/sun4i: backend: Add a custom atomic_check for the frontend")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Link: https://patch.msgid.link/20260217014801.60760-1-ethantidmore06@gmail.com
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Elizaveta Tereshkina <etereshkina@astralinux.ru>
> ---
> Backport fix for CVE-2026-53066
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index d935f36a24dd..b3741827c6c3 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -507,6 +507,9 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>  	drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
>  		struct drm_plane_state *plane_state =
>  			drm_atomic_get_plane_state(state, plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);
> +
>  		struct sun4i_layer_state *layer_state =
>  			state_to_sun4i_layer_state(plane_state);
>  		struct drm_framebuffer *fb = plane_state->fb;

This would trigger a really unnecessary build warning due to lack of
commit b5ec6fd286df ("kbuild: Drop -Wdeclaration-after-statement") in
5.10/5.15 kernels.

I wonder if that commit can just be ported to 5.10/5.15.  You may consider
it.

Otherwise the current backport should be adapted to avoid declarations
after statements.
