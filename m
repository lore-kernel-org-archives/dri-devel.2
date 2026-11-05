Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFC606D803
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDriHBvO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2642410E95F;
	Thu,  5 Nov 2026 19:00:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 976F010E95F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:00:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 37BB943CF2;
 Thu,  5 Nov 2026 19:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40A01F00A18;
 Thu,  5 Nov 2026 19:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793905248;
 bh=sxJizGzqf5hecqRsBsq6IAGYq0uV2CYJl21VOXF1s4k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bDriHBvO53HSOs6RzSIfINJuWwPe9TYy5+Bj7fxpUUP4oV2BK2KtDDOZWEgTUXqQA
 Pcsdkt7t4U4Dfqii3HopbJM1sjS3vHyBVMekEhCik8XvDU0E5m+fMTh6WJNwruqrrL
 IUI1DdeNRuRwyvvPvey78vg1LTplBA2s+gUIDKo5Bf0mg3xSHLEYm/i3hpOkiOgCGv
 cRjkJdAVOHfT+YS3a4Jw+BqK/7+phymMnfMirz4YPs1sJ5YXez6+YFsT+e7ZeBUlST
 /hgZQiO8ckhtmNrWTM/3n79QXWRW2ks6txrYQ9F6w4Q0bOLGX/EBtnZAP1QjR+Z6ZO
 ugJMZUWcBKlxg==
Date: Thu, 05 Nov 2026 09:00:47 -1000
Message-ID: <fbf6ec45cf29c26e2a064bd79f006862@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v8 5/6] workqueue: Imply strict CPU affinity for WQ_RT
In-Reply-To: <20261104095225.32654-6-tvrtko.ursulin@igalia.com>
References: <20261104095225.32654-1-tvrtko.ursulin@igalia.com>
 <20261104095225.32654-6-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

Hello, Tvrtko.

On Wed, Nov 04, 2026 at 09:52:24AM +0000, Tvrtko Ursulin wrote:
> -	if (wq->flags & WQ_RT)
> +	if (wq->flags & WQ_RT) {
>  		attrs->prio = RT_PRIORITY;
> +		/* Strict CPU affinity for low latency execution. */
> +		attrs->affn_scope = WQ_AFFN_CPU;
> +		attrs->affn_strict = true;
> +	}

I don't think this needs to be hard-coded. If setting it through
workqueue attrs is too inconvenient, how about adding WQ_ flags so that
the affinity scope and strictness can be set easily when the workqueue
is created? The flags can be expanded to u64 to make room and
reorganized cleanly while at it.

Thanks.

--
tejun
