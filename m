Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD3E606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bC7/Qk0v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E199110F0B3;
	Mon, 26 Oct 2026 18:37:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC5110E381
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 18:37:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BC4D840BA7;
 Mon, 26 Oct 2026 18:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DE11F01825;
 Mon, 26 Oct 2026 18:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793039861;
 bh=9C4Uluvd0xkYA+zo3dMgPpHbnwkaCgVbnnUTHjmZZJw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bC7/Qk0vq8cZZc6oEXAbxGsifR5b5IzIAM2Hez33JAZ8gnPVz/6YshFTXzvTQ7q3n
 ngL+xWSM6a4HEmIxJ4M2eK52LYe2R2cpqO7P8n9zRxwmFjchS9g15FpBrJaAirs4hE
 OdnDE1U9eruJ5GxYOyUC3nGlhlqnG2NFgPr3NUe4SypJKaBEGXjZA55INW87wIBbty
 rLAk5KwoSyPUCPwe0Do+8vwH5wbYYQB/Cd5krWQpEnr0iSvIh2t79JFl4GN1gxQe/a
 tJJb+fTE1PKpr5oeqtnSmVCcg8m9o/MME1pSrMm4xPtwyuQlqEyATnOmGDV0JTWwZH
 h0MsL+U0xOe8Q==
Date: Mon, 26 Oct 2026 08:37:40 -1000
Message-ID: <7fec5fa8362328bf3356a077a8bd9687@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v7 3/4] workqueue: Add support for real-time workers
In-Reply-To: <9d6add80-2ec9-4f29-a815-ad0e955f7b5a@igalia.com>
References: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
 <20261022093848.5727-4-tvrtko.ursulin@igalia.com>
 <a3ae9a0f13e3972d0645f555bcc26f4f@kernel.org>
 <9d6add80-2ec9-4f29-a815-ad0e955f7b5a@igalia.com>
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

On Sat, Oct 24, 2026 at 09:33:42AM +0100, Tvrtko Ursulin wrote:
> Can do. I'll get to it the week after next. (Tweaks to other patches in
> the series as well.) Should I switch to a different base branch by then?

I just branched wq/for-7.5. That should work as the base.

> But if you are curious how much better strict
> affinity makes them I can measure, it is not a huge effort.

Yes, numbers with and without strict affinity would be great.

> Hmm.. I could do that, but since the tool ships within the kernel does
> it _need_ to have backward compatibility regarding kernel _internal_
> implementation details?

It's just a nice-to-have, but other parts of the script already support
older kernels, so falling back would be good if it doesn't add too much
complexity.

Thanks.

--
tejun
