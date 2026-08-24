Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B2CC5DF8C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 04:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36D010E04A;
	Mon, 24 Aug 2026 04:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ggNemzTO";
	dkim-atps=neutral
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61CFD10E04A;
 Mon, 24 Aug 2026 04:22:20 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4b09d569d;
 Mon, 24 Aug 2026 12:22:17 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Runyu Xiao <runyu.xiao@seu.edu.cn>, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] drm/amdgpu: return reserve errors from
 amdgpu_gfx_kiq_init()
Date: Mon, 24 Aug 2026 12:21:54 +0800
Message-Id: <20260824042154.1720968-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260823092936.992430-1-runyu.xiao@seu.edu.cn>
References: <20260823092936.992430-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa032013e2b03a1kunm9c9c385021612f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR1KVkJMT09OTxkZGU8fQlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
 xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=ggNemzTOmri2HozeoaZul+Kvn+Sxz8uJa9Xlrm/MF6/uBXuz0yE7W7docIX7u97CXBWFy4WcObDo6Byy0RND2Ga891aAct6q6PMmQ9JPqErTiPcAn6rtrbNgldIqffUBK8uH4HQX2VCMa2jtKOk/uTYfwz3OH0+4iUaYrmbUwWc=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=slTYeHhnsF4LJMK9bqKlF4AjIQDkMkQFY+4RCApACV8=;
 h=date:mime-version:subject:message-id:from;
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

Thanks for the review.

Before preparing a resend, I rechecked the reservation path:

  amdgpu_bo_reserve(bo, true)
    -> ttm_bo_reserve(bo, false, false, NULL)
    -> dma_resv_lock(...)

This is an uninterruptible, blocking lock acquisition without a ww acquire
context. Under the current locking semantics, contention is waited out and
the call cannot normally return -EINTR, -EBUSY, -EDEADLK, or -EALREADY.

The reserve-failure path targeted by this patch is therefore not reachable
under the current locking semantics, and this patch does not address a
currently triggerable bug.

I am withdrawing the patch and will not send a v2. Thanks for catching this.

Runyu Xiao
