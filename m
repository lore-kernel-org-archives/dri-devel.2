Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B9606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=g9gLx1Dy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C28E112226;
	Thu,  5 Nov 2026 07:50:02 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A758F112215
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:49:55 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKvbh1xmfzMldS;
 Thu, 05 Nov 2026 08:49:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793864992; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZ2kHCM2Jt6bsHOY5bYOgrVnEII8MD5ukPE+LJNqpAM=;
 b=g9gLx1Dy/UmZT+wWDLx/UUol8BGKhKqP836HjBAy23wKN+/aIjqsd9MFsy8LXpfpfoSgfX
 PV4EzolsAi8i8jXa2ORU7oDv1cBhe6FaOUnEeu6ld35q+wHfKAh2cucG1QUZzV8A1B0mq1
 q/l9kgx+ohjjg0DFuUz1P9GzHZ9i/E0pm8nQhFAqWubU/8q4KuhI5zLgulWsbwlYMOj05Z
 TJGpUo7i2vanTYHm1xaLfbm/OuHJqwOqGoT/8eNIqIchYGrS4Ys31Xv2zb6gB+//1f1tbW
 4UhBB2yfDNxfidYMx77BblxdIz5/vFk1+dzWPM/uLXcOUF5oSyi6pbMo1/YCKw==
Message-ID: <75367a9a19c1e9a007422e0a1b8ed0acaca2492a.camel@mailbox.org>
Subject: Re: [PATCH v2] dma-buf/sw_sync: Optimize the retrieval of fence
 reference counts
From: Philipp Stanner <phasta@mailbox.org>
To: Edward Adam Davis <eadavis@sina.com>, sashiko-bot@kernel.org
Cc: media-ci@linuxtv.org, sashiko-reviews@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
 robin.clark@oss.qualcomm.com
Date: Thu, 05 Nov 2026 08:49:49 +0100
In-Reply-To: <20261105052707.55911-1-eadavis@sina.com>
References: <sashiko-outbox-198550@kernel.org>
 <20261105052707.55911-1-eadavis@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 138597b0ebf596f7525
X-MBO-RS-META: grptiyux6188h3jp9sca11gsrqamht4e
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
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 13:27 +0800, Edward Adam Davis wrote:
> ---
> v1 -> v2: use dma_fence_get_rcu() and remove link & erase pt node

Ideally, one avoids sending new versions within 24 hours :)

>=20
> =C2=A0drivers/dma-buf/sw_sync.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 8df20b0218a9..261bc98b1ed6 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -221,7 +221,11 @@ static void sync_timeline_signal(struct sync_timelin=
e *obj, unsigned int inc)
> =C2=A0		if (!timeline_fence_signaled(&pt->base))
> =C2=A0			break;
> =C2=A0
> -		dma_fence_get(&pt->base);
> +		if (!dma_fence_get_rcu(&pt->base)) {

You must hold the rcu_read_lock() while doing that, don't you?

This probably works "by coincidence" since the surrounding spinlock
also disables preemption, like the rcu lock does.

That spinlock, why can't it guard the dma_fence reference? Doesn't obj-
>pt_list hold its own reference?



P.
