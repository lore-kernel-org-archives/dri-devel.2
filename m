Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77853606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYcBbpX2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE5A10E39E;
	Wed, 21 Oct 2026 21:27:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8702B10E39E
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 21:27:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3693340A5E;
 Wed, 21 Oct 2026 21:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30951F000C8;
 Wed, 21 Oct 2026 21:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792618063;
 bh=9Q79igMfokPbIn4EF3OHWsP3g9W63ebKo434jeW1LzM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=AYcBbpX2rk/d4fk4EfwD0tkZh3GQXUshFjLTTvFKk3ztvwgG/jtwWEXreKIiWiB7e
 7K9SLcHWjszHxDrCfvCK/IGOVVmH+eaF+G8Vqws8zJEiGUcZr0gXZys55GP0S0LRbk
 FdYgVOHil5ybD+tcXBf0tqYRuykk1CfZEGrwrADfAuMIOVNDGGgL9p66CcYeZWPflI
 enswrK01qoHMxdvVzOoMJ45Z1++TGc6c2xrkBQIEj87sfdUQYTg0UgQD2qJtIOhVZr
 cse3InQfCYfHiOnsInKA2TjYoUmqPk/U1EMTeMH/tjUrQ0HPS6/wBM8N4g7rOSqtz2
 okiW3/nJDc0hA==
Date: Wed, 21 Oct 2026 11:27:41 -1000
Message-ID: <c46ebed464535b07694a449976cdd27a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Breno Leitao <leitao@debian.org>
Subject: Re: [RFC v6.1 2/3] workqueue: Add support for real-time workers
In-Reply-To: <bd59f9aa-b0d3-474f-8c95-f3763e320638@igalia.com>
References: <20261001160711.59888-3-tvrtko.ursulin@igalia.com>
 <20261001184848.61776-1-tvrtko.ursulin@igalia.com>
 <3a139a32135c149f51bac4f2bd58ad56@kernel.org>
 <9bb46cf4-7982-463b-8289-06bbc319bba9@igalia.com>
 <cb60b6a0f8f35957d64c9abf240c2dbd@kernel.org>
 <bd59f9aa-b0d3-474f-8c95-f3763e320638@igalia.com>
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello, Tvrtko.

On Wed, Oct 21, 2026 at 01:53:01PM +0100, Tvrtko Ursulin wrote:
> +static void
> +sanitize_workqueue_attrs(struct workqueue_struct *wq,
> +                        struct workqueue_attrs *attrs)
> +{
> +       if (wq->flags & WQ_HIGHPRI)
> +               attrs->nice = HIGHPRI_NICE_LEVEL;

WQ_HIGHPRI only sets the initial nice level, which can be changed
afterwards, e.g. through sysfs. Forcing it here would silently override such
changes. Maybe keep setting it at allocation instead?

> Could you please confirm (or deny :)) this is what you had in mind?

The rest sounds sane to me, but it's difficult to evaluate without looking
at the patches. Can you please post them?

Thanks.

--
tejun
