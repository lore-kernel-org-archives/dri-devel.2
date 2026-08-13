Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53ABC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB9F10E4B7;
	Thu, 13 Aug 2026 10:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="A8oqBCr5";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8C610E4B7
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:13:19 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hLLlw341bzKwL3;
 Thu, 13 Aug 2026 12:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1786615996; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZRbCEJ1DrmBkK+k4bC9JHRBYf7jSP7KWeUNUIKAJ8M=;
 b=A8oqBCr5PhGRKE7FWHo0Q7s+Rtqg3l+n9xG8inoflVzpnyFvx2sjiIFLs0bGcvtLOLc5Dc
 Q1WXjCQ98Q68gIv4fHCYi9axeJdersnSCjhkDb4LZU5NGouqLEuZYeSueE89gZDMZi9UHG
 t3pul0XGmlfcRIw0RjaUIqnfJCIbiWa37Ch88zYbgPKU3bydU5f/O6ryzNmc3VTA1wOzGe
 2ii94lubAvxy83RrQQNf7AgnV4w9APGM2BQBR55bgMpq+502baztLJiXRSdSoESo4+pvsf
 T2o2ywezfj1cOwRCkKHGbF3HGQpaRCSMDaxGlIk0RNc7ctH928RzCTxWJz5nAg==
Message-ID: <ee5e9d04d45080b6d4189e9b6f5357d07cd77782.camel@mailbox.org>
Subject: Re: [PATCH v2 2/2] drm/sched: Protect entity->last_scheduled with
 spinlock
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich	 <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org
Date: Thu, 13 Aug 2026 12:13:10 +0200
In-Reply-To: <20260813092510.2385962-6-phasta@kernel.org>
References: <20260813092510.2385962-4-phasta@kernel.org>
 <20260813092510.2385962-6-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: zsbg87i5thrucb9gkyfzgo394uzbe3jy
X-MBO-RS-ID: 635c47fe6de67341a7e
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

On Thu, 2026-08-13 at 11:25 +0200, Philipp Stanner wrote:
>=20
> +	drm_sched_rq_pop_entity(entity);
> +	spin_unlock(&entity->lock);
> =C2=A0
> =C2=A0	spsc_queue_pop(&entity->job_queue);
> =C2=A0
> -	spin_lock(&entity->lock);
> -	drm_sched_rq_pop_entity(entity);
> -	spin_unlock(&entity->lock);
> +	dma_fence_put(prev_last_scheduled);


The relative order between these must not be changed. My bad.

So unfortunately it looks as if at least locking spsc_queue here is
necessary. I really wished someone could pick up our spsc_queue locking
TODO.


P.
