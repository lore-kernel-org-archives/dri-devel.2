Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B8BF483CC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C258110E584;
	Mon, 23 Mar 2026 16:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="YqEYhYAT";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21BE10E584
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1774284390;
 bh=qmg1nPZUUxwm/Z10Trz1LjJPIJku5DoJhWgq9/ietK0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YqEYhYATKrEyMMtia5knDmEsnZmz8Dx6D7UxDLLaDBZfjviT7yi9v9pqkj3R21Seg
 tkQnUjy1jXW07s3v9BWoSABzKqnQzu//wD5ymeGsK/ipY5SXyMj6EDZiHio1TRSGlN
 XiOKImX6vEJY4wQ14ArsWJcrXTzH8dfTWQYBvn94gwOkor5iT3p8NfuxwoNM7s9K5/
 Mm3Y2SvZUib0ha0/qTfxVepOS4MhDAmk3PdTDr2rF51p0m8qIk/DeT1MnD2LJb3FTY
 kPFM8aahN9t24rknO+O3j3OecSk+9G16YdpjTnknRxMB6tLzdM9TwhrOKukcXYfZ3Q
 ue9J7dVP6aHXA==
Message-ID: <88f89d75-1e1f-4457-8c1f-57e934c251cc@lankhorst.se>
Date: Mon, 23 Mar 2026 17:46:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
To: Tejun Heo <tj@kernel.org>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
 <b099d9248df084fed8d4252e3c6fc485@kernel.org>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <b099d9248df084fed8d4252e3c6fc485@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hey,


Den 2026-03-21 kl. 20:27, skrev Tejun Heo:
> Hello,
> 
> Generally looks okay to me. One comment on 3/3 — the naked xchg() in
> set_resource_max() needs a comment explaining why it's used instead of
> page_counter_set_max() and what the semantics are (unconditionally sets max
> regardless of current usage to prevent further allocations, since there's no
> eviction mechanism yet).
> 
> Applied 1/3. Maarten, Michal, what do you think?

Yeah probably drop 2/3 too since there is no longer a case where setting a limit may fail.

Kind regards,
~Maarten Lankhorst
