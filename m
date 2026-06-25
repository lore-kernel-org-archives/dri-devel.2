Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705F2CDE00B
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DFF410F304;
	Thu, 25 Jun 2026 15:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ycI0Burm";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334FB10F305
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 15:01:30 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gmMSz0dPXz9vDY;
 Thu, 25 Jun 2026 17:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782399684; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDf8uKydeb/dWDgOUroHzcLhyUDFhghnhH6xp9NcqCs=;
 b=ycI0BurmMS2ieeqdTbYQ84MnvXcjhlbp53mhDYB9+wT3sGlmCH48HAU8XRCob/RY15qKfa
 46vH0a9/eUKKIR6acC0jVlN70oxzUXcuQ3A7lfNj4LGqNiG2AoTlWmdwoe7jO7wc9PRn5c
 FX/dlwNXmSfJw5lsGBbl3YhKjkWsZ02u3jekBXN3SwwTNuqptKlYhuMf5nD+/NfEld7Ibh
 SZvnezVMZStCMT+ko8iO8+rIXht+Hz+DQ9enUvZRxRk40lcClIkValkQnBvj8oEanFnqWw
 WvnJHDu3QY6aDNry8JeBVbaI9nfArpBP2ct0WI5HTIu/avTb6zCPcw6MwLQT6Q==
Message-ID: <de3b9b978ffeeb43c18d877080e93823214313ec.camel@mailbox.org>
Subject: Re: [PATCH] dma-fence: Fix dma_fence_timeline_name() to call
 get_timeline_name()
From: Philipp Stanner <phasta@mailbox.org>
To: Baineng Shou <shoubaineng@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, =?ISO-8859-1?Q?Andr=E9?= Draszik	
 <andre.draszik@linaro.org>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Akash Goel <akash.goel@arm.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Thu, 25 Jun 2026 17:01:15 +0200
In-Reply-To: <20260625141227.38931-1-shoubaineng@gmail.com>
References: <20260625141227.38931-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 1c878a47db5afd3a54a
X-MBO-RS-META: xyidt6keibsxozexi515dqim3gdtwzox
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

+Cc Andr=C3=A9

On Thu, 2026-06-25 at 22:12 +0800, Baineng Shou wrote:
> dma_fence_timeline_name() incorrectly invokes ops->get_driver_name()
> instead of ops->get_timeline_name(), so every caller receives the
> driver name where the timeline name was expected.
>=20
> This is a copy-paste regression that has resurfaced twice. It was
> originally introduced by commit 62918542b7bf ("dma-fence: Fix sparse
> warnings due __rcu annotations") when adding the __rcu casts, fixed
> by commit 033559473dd3 ("dma-fence: Fix safe access wrapper to call
> timeline name method"), and then accidentally reintroduced by commit
> e58b4dea9054 ("dma-buf/dma-fence: Add dma_fence_test_signaled_flag()")
> when both wrappers were refactored to use the new helper.
>=20
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>

Andr=C3=A9 has caught this a few days ago already:

https://lore.kernel.org/dri-devel/20260618-linux-drm_crtc_fix-v1-1-801f29c9=
853d@linaro.org/


To save my honor I want to state that e58b4dea9054 did not actually *do
this* change. But merging it must have caused it somehow, since that
commit was still based on the old bug. I guess somewhere in conflict
resolution somehow tho old code must have entered.


P.

> ---
> =C2=A0drivers/dma-buf/dma-fence.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index b3bfa6943a8e..5292d714419b 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1202,7 +1202,7 @@ const char __rcu *dma_fence_timeline_name(struct dm=
a_fence *fence)
> =C2=A0	/* RCU protection is required for safe access to returned string *=
/
> =C2=A0	ops =3D rcu_dereference(fence->ops);
> =C2=A0	if (!dma_fence_test_signaled_flag(fence))
> -		return (const char __rcu *)ops->get_driver_name(fence);
> +		return (const char __rcu *)ops->get_timeline_name(fence);
> =C2=A0	else
> =C2=A0		return (const char __rcu *)"signaled-timeline";
> =C2=A0}
	=09
