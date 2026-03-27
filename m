Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7911B10F285F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DF110EEA8;
	Fri, 27 Mar 2026 17:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mh0o5W+O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6884110EEA8;
 Fri, 27 Mar 2026 17:25:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 14F1040E0B;
 Fri, 27 Mar 2026 17:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFCBC19424;
 Fri, 27 Mar 2026 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774632328;
 bh=J2ZtS44ey2b2m3iD6de4uRfVMdpCjWHbwNExqhgQsHA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mh0o5W+O7ZdJr9v8OlqpATFkeHxzXejWbzgZl786+iDRx9bLeJtucnmNCuofO8ms7
 ZcTkJwM1hB7CHB6mN6dOs1t9tHDSkEBHDKHqJ5aRspuFlMTMxWvFpQs4wQ1y1odVWG
 4iWGVe9g0KcOKO11fNW24OQtfnTgqAZSl6XMRI+TlQHSvVdNHWk7YZD7CBAxTZ2vOs
 PL7vlrHhj0zsw7tcPzG5kQAF6dYHx4q5702ROhmjsnzfAe6BlGWFSiqnP8J4YVUOD5
 XmG/1amSPUEdAwyCNkSVUtdJKisofXgxwvmh0w2qH6TWALxXlk9HIO60A2BYYcazMV
 NlFOQs7xSuOgg==
Date: Fri, 27 Mar 2026 07:25:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/12] workqueue: Add interface to teach lockdep to
 warn on reclaim violations
Message-ID: <aca9hz9WTDBFkKuw@slm.duckdns.org>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-2-matthew.brost@intel.com>
 <acQGehvhyfU5j6uL@slm.duckdns.org> <acSQxyclGs7FYvbS@gsse-cloud1>
 <acSXwPliraMdYTFH@slm.duckdns.org>
 <acYIo0570M0Ndhp9@gsse-cloud1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acYIo0570M0Ndhp9@gsse-cloud1.jf.intel.com>
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

On Thu, Mar 26, 2026 at 09:33:39PM -0700, Matthew Brost wrote:
> Can I send an independent patch addressing the WQ_MEM_WARN_ON_RECLAIM
> usage above for you to pull into 7.01? I’m still working through a few
> issues on my driver (Xe) side to enable this, and the larger DRM-level
> changes will take some time since pretty much every driver is doing
> something wrong.
> 
> Alternatively, we could defer this to 7.02 and merge it through DRM,
> since the 7.01 DRM cycle is closing today. Either option works for me.

It'd probalby make sense to merge it together when DRM side is ready.
Whenever you're ready to merge the users of the interface, please let me
know. I'll create a separate workqueue branch with the patch on so that DRM
can pull it in.

Thanks.

-- 
tejun
