Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782D5C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F3710EFE1;
	Mon, 14 Sep 2026 16:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Eebbc4/+";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4BE10EFE1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 16:11:35 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hk9BX60WSzKm6k;
 Mon, 14 Sep 2026 18:11:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789402292; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfMNuIBGLCoCqhNcMOy6gzcxk2JxD7if2PlSrtkj3qc=;
 b=Eebbc4/+vT0xel+2RkOmpPeEQOBHHActyL5FdHQCXm/pUOKg9JInHy/tefc96Lfcy7x30Q
 L9/pz7gBQEZxSN2L9NxUrgGm0Bmid5gC1VLd7uqAS18iNZ3xYp5IVM0NYdyOt9w7zXs9Zb
 dHzS4GuQgjyrXZAXj1YOJM5ep5nHk9tNZ6axTjVpmAGwbn2AcW2dPC6lZiI1rnGnd144t4
 HrVwLJ4gYzPpdUW5DlLTmMF+8zfOn9o2i4DISkFliUobZ3tP3RQs+6/820wtboi93ZHKIS
 67L+rxrEbpCP7Xn7pqXiW3GUj7kFUDr8wRMXer7dpZ3RwOqhgMaQDxPQh78HNA==
Message-ID: <3eb314e4fa5e55675cac54cd43999d549f945368.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Remove forgotten header
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich	 <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 18:11:28 +0200
In-Reply-To: <20260625104903.1713213-2-phasta@kernel.org>
References: <20260625104903.1713213-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: zfa5eayat5bs9jw9jhyjgbnx9niqdjnb
X-MBO-RS-ID: 26cb2e40f312526b947
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

On Thu, 2026-06-25 at 12:49 +0200, Philipp Stanner wrote:
> sched_main.c still contains the spsc queue header, which is not needed
> anymore in that file.
>=20
> Remove the surplus header import.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Can someone review this?

P.

> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index d2ca01b31ee4..9446b08fff1c 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -77,7 +77,6 @@
> =C2=A0#include <drm/drm_gem.h>
> =C2=A0#include <drm/drm_syncobj.h>
> =C2=A0#include <drm/gpu_scheduler.h>
> -#include <drm/spsc_queue.h>
> =C2=A0
> =C2=A0#include "sched_internal.h"
> =C2=A0
