Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE17F109448F
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 19:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A417610E0E0;
	Sat, 21 Mar 2026 19:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BX1Yu60O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D67510E0E0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 19:27:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F414E42DE5;
 Sat, 21 Mar 2026 19:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E6CC19421;
 Sat, 21 Mar 2026 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774121233;
 bh=px/TL8DGdi8VbNkcoFn729fcLlKGeeNByfaaget981k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BX1Yu60Ol5ehk77hP+kFw96c2GjI8TOxEBdOFl5VXyNVJBTytBLi2nXgYekVxYEr7
 brjaVeauUx3ZE3XSDQg8+HzLoe1zplCI88ytF0pGZ9ygt8Ns1TXgseGBA0j7w9sJXG
 OwgrT6hs4Dq7sgn/JRlXhAMFgyA2nZ8Sb59ppFXvC+jIzXtPVIHFTtn6ygyqPmqJz9
 bIi1NlqRpDMHT2rzmC+8yOob0YExGujcmXbr4uvfY3oq96AMY3JeiMKqP8B3ksQ1L3
 oOAJcIxAWP/U+kffezmYLPIclivp/2LZSlfawz170eQe/06ejpYCsXx7gLfLOU0uys
 CUTiA6Xcx4vyw==
Date: Sat, 21 Mar 2026 09:27:12 -1000
Message-ID: <b099d9248df084fed8d4252e3c6fc485@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes
 to dmem.max
In-Reply-To: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hello,

Generally looks okay to me. One comment on 3/3 — the naked xchg() in
set_resource_max() needs a comment explaining why it's used instead of
page_counter_set_max() and what the semantics are (unconditionally sets max
regardless of current usage to prevent further allocations, since there's no
eviction mechanism yet).

Applied 1/3. Maarten, Michal, what do you think?

Thanks.
--
tejun
