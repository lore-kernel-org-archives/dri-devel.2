Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55257C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590EA10ED9C;
	Wed,  5 Aug 2026 09:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dMdf7S78";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 329AD10ED9C;
 Wed,  5 Aug 2026 09:12:45 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hFPnj2ZkvzKnXX;
 Wed, 05 Aug 2026 11:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1785921161; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r3iZ+lFUZEsJBTzuychvBQ1Ca0+n8u+px9eNdOiqqvc=;
 b=dMdf7S78nzJyAqIJlTMsT6eywbAjjrX+/L+SnQXsqEjyyRVHKvGvusRr70IwiOyZLxylAa
 Rmj4K0HXWOmKQYS/mckEbukJjHP1kCmlpcF19yRIBpRQ9FCsdtlxcfhx1PA28Nk6lqHR/i
 00zmNRtxg2MMzTxrth7Ix7B1LCuNtYYZH7nZ2ehKUYeg5wyzJ3xImA3Z2sZTka2EKSu8gw
 BGsR5t8o0eE2BTj1prn3i1QgI8rJegHv7vWDqo8aXIT3hdsHe6L0eCFgXNYnhTPPKJiswi
 7o2GlR4+1zYSj3pVfJGn98+eruzOEWlYJs3Pz5/jJnG6JISBnMZVJ2Gp7vCGJQ==
Message-ID: <73de3de29ffbd36375a3a8d48f7ca840bf8f2d06.camel@mailbox.org>
Subject: Re: [PATCH] drm/radeon: restore hardware polling in
 fence_is_signaled to fix performance regression
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 2564278112@qq.com, alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Wang Jiang	
 <jiangwang@kylinos.cn>, Philipp Stanner <phasta@kernel.org>, Danilo
 Krummrich	 <dakr@kernel.org>
Date: Wed, 05 Aug 2026 11:12:37 +0200
In-Reply-To: <baa434d9-e0a9-482d-a071-42d204b82126@amd.com>
References: <tencent_BB2A7CAE632BA0AC08D9296E78A15786200A@qq.com>
 <baa434d9-e0a9-482d-a071-42d204b82126@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 0b0204cefdf41debb11
X-MBO-RS-META: mddfdxogy45fcp43gf7167yu8yj59bn9
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

On Wed, 2026-08-05 at 10:34 +0200, Christian K=C3=B6nig wrote:
> On 7/29/26 12:26, 2564278112@qq.com=C2=A0wrote:
> > From: Wang Jiang <jiangwang@kylinos.cn>
> >=20
> > Commit 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in
> > is_signaled, no deadlock") removed the hardware polling from
> > radeon_fence_is_signaled() to fix a self-deadlock caused by
> > wake_up_all(&rdev->fence_queue) being called with the fence queue
> > lock held.
> >=20
> > However, removing the polling entirely causes significant performance
> > regression (e.g. glxgears FPS drop) because the fence signaled check
> > becomes purely passive =E2=80=94 it only reads the cached last_seq with=
out
> > probing the GPU, so completed GPU work is not detected in time,
> > causing unnecessary CPU stalls in sync-heavy workloads.
> >=20
> > Fix this by calling radeon_fence_activity() directly instead of
> > radeon_fence_process(). radeon_fence_activity() reads the hardware
> > fence counter and updates last_seq via atomic ops without calling
> > wake_up_all(), thus avoiding the deadlock while restoring timely
> > fence detection.
>=20
> Yeah I already feared that removing this in commit 9eb00b5f5697b
> could cause issues.
>=20
> Adding Philip and Danilo since we recently had a discussion about the
> necessity of this.

necessity of avoiding deadlocks with the callbacks somehow, or the
necessity for opportunistic signaling?


What we were wondering about was

a) who can even reach the hardware_fence when the gpu scheduler's fence
is in between and

b) why it might be a problem if we lock in dma_fence_is_signaled(),
because it would mean that someone (e.g. in userspace) is busy-looping
on the fence.


Since radeon does not use drm_sched, it seems to be one example for a),
I can see that.


Regards
P.
