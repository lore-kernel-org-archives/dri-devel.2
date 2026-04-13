Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C452F531C7
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 20:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD16710E531;
	Mon, 13 Apr 2026 20:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ueKp/Tc3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B5910E531
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 20:34:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 614A961339;
 Mon, 13 Apr 2026 20:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5340C2BCAF;
 Mon, 13 Apr 2026 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776112455;
 bh=udQmhbHAYKfxARhnBiFmlPPjAm5aIDxgX6FrYs49XaU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ueKp/Tc3D2T4mj9KONopLzkmpEcHbY3/kRGZG8SfqhL0L/aWP1ghxhxSVO03Ua5mE
 yLXwsiAenxD64ayJqoXfs8iBRWzAhqWZx+giUMaZ1iF2Bnx4m6ALNtlTwi0A7newGd
 I11xXRhvr1Geih5+J41lYDYfvA0fjuE85t2jSJk+D6EnfQjbLvYgHW+RmvM/XyhtCQ
 Ohh6PQSqRU31ugGUgxooghMNNshX6qSmQgpWHwIUAmCOeY4p4GXXuK1cXFHrr8XVCg
 usqs8p7pLJ9h0/rJVkm72u93GV5OUM7b5FdOEjl/B+MV+OFBfEttg7HY+3kR12WxY7
 9HLpsZUfy2QdA==
From: "Barry Song (Xiaomi)" <baohua@kernel.org>
To: david@kernel.org,
	urezki@gmail.com
Cc: baohua@kernel.org, 21cnbao@gmail.com, akpm@linux-foundation.org,
 dri-devel@lists.freedesktop.org, jstultz@google.com,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, mripard@kernel.org,
 sumit.semwal@linaro.org, xueyuan.chen21@gmail.com
Subject: Re: [PATCH] mm/vmalloc: map contiguous pages in batches for vmap()
 whenever possible
Date: Tue, 14 Apr 2026 04:34:10 +0800
Message-Id: <20260413203410.13079-1-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260403092028.61257-1-baohua@kernel.org>
References: <20260403092028.61257-1-baohua@kernel.org>
MIME-Version: 1.0
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

>> vmap_page_range() does flushing and it has instrumented KMSAN inside.
>> We should follow same semantic. Also it uses ioremap_max_page_shift as
>> maximum page shift policy.
> 
> Not quite sure if vmap() should follow ioremap()’s
> ioremap_max_page_shift. If needed, it shouldn’t be
> difficult to do so.
> 
> I have a version queued for testing (Xueyuan is working
> hard on it). Meanwhile, if you have any comments, please
> feel free to share.
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 57eae99d9909..8d449e78a07a 100644

Hi Uladzislau, David,

As explained there [1], this standalone patch is withdrawn,
as I have moved to a series that addresses a broader set of
issues.
Sorry for any confusion this may have caused.

[1] https://lore.kernel.org/all/CAGsJ_4wCBeVfyFraj_dRdsUrSNqDG5a8SO9C3=PFRSt04dRvGw@mail.gmail.com/

Best Regards
Barry
