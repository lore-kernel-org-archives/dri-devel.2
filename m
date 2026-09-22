Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0137DC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9E510E6E3;
	Tue, 22 Sep 2026 11:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VaTVPvQE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD8510E6E3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 11:35:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 860E460E07;
 Tue, 22 Sep 2026 11:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DE91F00898;
 Tue, 22 Sep 2026 11:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790076943;
 bh=ecd9LSXJtZ8rxLwVQiJYvUqPkFGTHzw1TxeisN7gO4s=;
 h=Date:From:To:Cc:Subject;
 b=VaTVPvQEuOOtU/svouiQU9EQPumxKCJf3iyj2plioiwzd8DDMW2dQNo9ZdBcAqJO0
 gVI384ERpwS2kDjBvVvPLHSYjTVJldo3wCjA3ZTGru/HIVBu9i8k8ZI/Qr9gHnGQx8
 fV7nQY5qKsEN9kIp7asiAKp3DMrGs1+J32cdLQdr4q10UAa1G/jjMC7s5H8LjkXZn6
 umeSpGUrZ5zTrszFEKVX7MoLOq7v+fi0jferx89hRcSbv3AR9Kv/Vn1hMrrRt6JKwf
 avB83HZOWR9H6xdFygE/XEgUiSMzy2yDOrDb8iTqiLGaQzbU4ndVnYTHywPluU6QLp
 GjFz/ixLLrMZQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id EF37F1AC56BF; Tue, 22 Sep 2026 12:35:38 +0100 (BST)
Date: Tue, 22 Sep 2026 13:35:38 +0200
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm tree
Message-ID: <arJoCiRM1hRbgRb5@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi all,

After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

/tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/dc/dc_memory_pool.c:87:37: error: stack frame size (8264) exceeds limit (2048) in 'dc_memory_pool_create' [-Werror,-Wframe-larger-than]
   87 | __must_check struct dc_memory_pool *dc_memory_pool_create(size_t size,
      |                                     ^

which I am frustrated to see that I previously reported against the
amdgpu tree:

   https://lore.kernel.org/r/aq0vYhZXtMqA41wZ@sirena.org.uk

I have used the version from next-20260921 instead, also pulling in the
build bodges I've been carrying for amdgpu's bad interactons with
changes in drm-misc.  There seems to be a pattern with failures in drm
trees sitting in -next and then getting merged into the main drm tree,
it seems like there is some process issue that needs work here.
