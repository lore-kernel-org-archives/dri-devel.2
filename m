Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92490606A322
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTHQe6Wy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F62910F3BD;
	Mon,  9 Nov 2026 14:24:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3073010F3BD
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:24:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 191AC4557B;
 Mon,  9 Nov 2026 14:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FCB1F0089F;
 Mon,  9 Nov 2026 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794234285;
 bh=HZwCReN5TfpP/7UgtdfoNSUQJuUtcpW5E6BDQOlTEDs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bTHQe6WyCD2PN76oe0NakU0wWJ2SzDnnyBIriO3GtdG8dAuwkvpkzLT8Au2tc3Zra
 l+e0fl3klvXSGzI3ledA34/J5QrRg7NvhDLfHX+rSdVDLJsij9gTrGSKtL/AnCMHzq
 sct3pUvwsTTfKs04OD3Y6LQg+QwC/1tCTPTzf6ZnTd50ZDWZLp7vRqfjKx7dpzGjPf
 W2DG2NIM1AONa6X+1p36NAU0++m8gD7TBUf+ObQnFe6LJD4q08OdF6iry87HHYvFJJ
 ACwNeI3btAPjLfQui/yiZP2AQPSrZaoVvS9XLJo9/wknE1VS1TD/7ziiW6dePJnwq7
 735BUxH12B20A==
Date: Mon, 9 Nov 2026 04:24:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v8 5/6] workqueue: Imply strict CPU affinity for WQ_RT
Message-ID: <avHXq1lK7m_Sfz2j@slm.duckdns.org>
References: <20261104095225.32654-1-tvrtko.ursulin@igalia.com>
 <20261104095225.32654-6-tvrtko.ursulin@igalia.com>
 <fbf6ec45cf29c26e2a064bd79f006862@kernel.org>
 <6b489363-274f-426a-9143-6ed5593a0c19@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b489363-274f-426a-9143-6ed5593a0c19@igalia.com>
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

Hello,

On Mon, Nov 09, 2026 at 09:52:17AM +0000, Tvrtko Ursulin wrote:
...
> apply_workqueue_attrs() would work in theory but is not exported for modules
> which is required for panthor.

Oh, please feel free to export them.

> Regarding the flag reorganization, what would require expanding to u64?
> Unless I am missing something I see currently only 20 bits are used.

Right, it might not be strictly necessary. Just something we might as well
do while at it if we want to encode a bunch of scope / attrs in the flags.

> Although on a higher level my feeling is that panthor could first try with
> WQ_RT as is, and we consider adding strict affinity, via either of the above
> options, if that will not be good enough.

I see.

Thanks.

-- 
tejun
