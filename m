Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8694E606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FjuzrB8y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE20C10F108;
	Thu, 19 Nov 2026 23:23:16 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3BF11278C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:23:10 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-382ecd5cf2cso266759eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795130590; x=1795735390;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UffuqQ0/QwW3j93WsK3RwuvU3KYjpsoV/H71XJWvRDc=;
 b=FjuzrB8yeg+yql3Rcjo3A/YwbezRgpdDL9sJttxAeQZMewkpGeqrvFj2O0cfUnKnyK
 11qgxpSWcGIVS+tJyJoOlBeeEc7+93qJ805At2HztLBq+Me5X5w0In9VVoUR9oApihYD
 eLXIbhOiUTPV0uaeNj6+YOnvV0A/BkAgd7/Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795130590; x=1795735390;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UffuqQ0/QwW3j93WsK3RwuvU3KYjpsoV/H71XJWvRDc=;
 b=Ipd1MIxxNo2y1cthVISz4vMqJPyKxTRQS6MNordoW3OV8EQPCAEBqzgiMs5jLednCL
 hcO00+4V7zyQiCTWAxNO2Y4pbgWN+LI1ZfZ3mQuhQAk7w3ZyMzXtWtax8UxrIcR6XjgA
 hsTuI7eBZBfn+6l4ukeUWal8alLyoMm7sMLzM8B1JcQJjYvGWRUjTeMFrlNV/4z9x7Rn
 A/SB/uvhjD2htPpuNK/Aw7JytfcUv+6wvK6IjiBSdJXayQaKe6uGS25UQ2G/YW5dR5to
 nYM9WhbKrxdHhO600MLDPbWd2XUTY60fzpc/Z9AbsUoJApH2YoOvJ8sp6SFdAM/iGeSp
 SE0g==
X-Gm-Message-State: APuU4Z9bOAyfA5ZYKIzdy7KNpoRw1VLPwGjCYS7/leiG6qB5ZHvx5hkp
 VYBVT/FaCNlMycODkgPEaFr018FpbaALdJBYcbfZ3MiGLyd51P0/8Fd0nXIH0BpfXQ==
X-Gm-Gg: AYBFou3NY4+DMERZZIFOtvBI3+6hCI53/d7Jip9j5kIunsjT/RXp+M099CEzhlDWZoN
 bvm4TvsmQUsaum+GtCgVRCyKJaU2SLdHijgPjUnQA/noWsM6XmtXnylsYuUXAC7o1CnKyHo4phO
 2IrRy8etbphwPsvfBvn7BJcl2795+fP1+69g21GyZoWrZouy1AGkb8K+zLBrj8912paaw+HSem5
 0hDE2aWR7Sdns3UxGOC2WkYZ5j+ZpJaZJ3tJkGJCIMLQaNXwCrmOh+/9865obFBpDT3qaz9aUoK
 2xv9pNbFrfI04EixL8nLG9Q3hTPDQaWtNeg8GtZ3kv9Xwj+nCzWp/Dw9PNcQthp2ZLebZsXA7Hr
 J8hikeh0WfccNIzoPmHlSscUU7+kx1Rza6iVD6EYK6ubtkVnmKCi866J9ICmKLZC9XdiKX5zZe+
 /TT/t189ZasL/+HavR19SwKBXrL/ZFJoO8/BvnvqsRfabdVfvwI86dNSqXDJkA2oNJEP93lGuzL
 i5spp8b9TkOaVN7CCsK5vT1dSUU7+g6Qyk36RfA2QptCw6FqXOrmgTnqk5gCkv8DUdWot9+KI7M
 Cx7CSorgYDyrMVNYiJY7FcS1pNtXcJZsAPc6zRAfkjL+cmwBa3SZLmS2F7lgsimZ3RN0
X-Received: by 2002:a05:7300:51d4:b0:384:fef7:5876 with SMTP id
 5a478bee46e88-384fef75c78mr1881671eec.24.1795130590024; 
 Thu, 19 Nov 2026 15:23:10 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:bdc0:a95f:45fc:7172])
 by smtp.gmail.com with UTF8SMTPSA id
 5a478bee46e88-385646633d0sm3678892eec.3.2026.11.19.15.23.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 15:23:09 -0800 (PST)
Date: Thu, 19 Nov 2026 15:23:07 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] drm/bridge: analogix_dp: Power down synchronously on
 bridge disable
Message-ID: <av-E277eE3c6FxhR@google.com>
References: <CGME20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6@eucas1p2.samsung.com>
 <20261119084923.1156243-1-m.szyprowski@samsung.com>
 <av9AkwQDhB7O4wgl@google.com>
 <7f73a078-1041-43b7-8e35-3a2d9c69240f@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f73a078-1041-43b7-8e35-3a2d9c69240f@samsung.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 11:27:33PM +0100, Marek Szyprowski wrote:
> Sigh... Runtime PM API is highly confusing and imho a bit over-engineered.

Agreed. Or, over-implemented / under-engineered perhaps.

I'm working on trying to reduce some of the confusion (e.g., we're about
ready to eliminate all the differences between put*() and
put_*autosuspend()).

I'm nearly of a mind that put_sync() and friends serve more to confuse
than to help, because while they work like you expect much of the time,
they aren't really guaranteed to be all that synchronous. So in its
current state, it might be better to not pretend it's synchronous at
all.

Anyway, enough musing. Feel free to send me thoughts separately if you
have specific confusing things that you think could be improved.

Brian
