Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAF4CCA490
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 11:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D2C10E04A;
	Sun, 18 Oct 2026 11:32:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E60B10E04A
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 11:32:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2A1141B22;
 Sun, 18 Oct 2026 11:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C63F1F000C4;
 Sun, 18 Oct 2026 11:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792323165;
 bh=47k6rJMwcjQJjTImnf5DOBQ6a2OntryoiFRap2rObvs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=h/D0hgMVz5rl/qpXlUyLev+eBe42ydAo1pkXl6FhNUYu69tKFEB5hLEq4DzcGhJue
 Oy8//0PrfXog4unrlFErcBPGrHE9oZEhIYujhSWGzRjdGzGaRGZt+i6S31cwxsK9BA
 0Ren9dv3mNU28cWueQyuTXPUb0762Bu9dLtefGpsYM08+BtX1zKHUk1NiujkVyTNTV
 gQT9DF2W1rPYr+0OXt5+yaXt1yJfG2KoIyKtRyeip0ezIQzicuAmO6cAyXsWNP/SqL
 BTlJj7uHCn9UCXR9JCFwIZmjT6gAyZeikQlRSr0lxWjVZre8e6QsvTA/8BNnAA7PM9
 h4NFUHxQqz5AQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Deep Shah <deepshah146@gmail.com>
Cc: linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>, 
 Edward Srouji <edwards@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
In-Reply-To: <20261015083637.200958-1-deepshah146@gmail.com>
References: <20261015083637.200958-1-deepshah146@gmail.com>
Subject: Re: [PATCH rdma-rc 0/2] RDMA/uverbs: Fix DMABUF lifetime bugs
Message-Id: <179232316273.14756.10050537831811124188.b4-ty@kernel.org>
Date: Sun, 18 Oct 2026 07:32:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
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


On Thu, 15 Oct 2026 08:36:35 +0000, Deep Shah wrote:
> Fix two lifetime bugs in the uverbs DMABUF export path. Patch 1 fixes
> leaked uobject and ufile references when the uverbs FD is closed first.
> Patch 2 fixes a use-after-free when dma-buf release races with ufile
> cleanup.
> 
> Tested on mainline 4056b3c9d3c9 in x86_64 QEMU with KASAN and lockdep,
> using test-only siw export hooks. The unpatched kernel reproduces both
> bugs. Patch 1 fixes the leak, confirmed by tracing ufile release. With
> both patches, the same tests complete without KASAN or lockdep reports.
> 
> [...]

Applied, thanks!

[1/2] RDMA/uverbs: Fix uobject leak in DMABUF release
      https://git.kernel.org/rdma/rdma/c/4a953ee228f554
[2/2] RDMA/uverbs: Fix DMABUF use-after-free during ufile cleanup
      https://git.kernel.org/rdma/rdma/c/2854f9025d4ef6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

