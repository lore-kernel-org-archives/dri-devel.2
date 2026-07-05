Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8C3C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 13:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87AE910E12C;
	Sun,  5 Jul 2026 13:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eXdXF+HT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BCF010E12C
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 13:52:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C48E2413C7;
 Sun,  5 Jul 2026 13:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6B21F00A3D;
 Sun,  5 Jul 2026 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783259524;
 bh=hiXx0kh1llU+tqTb5cQLeELIhtzQB8YMaLGKmHcMmT8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eXdXF+HTA76vk6XNS/vpiHTMSk+4FpMeNvRZmKgO8fO2droK6kJamzz2kJ8o2E9mW
 UXXYCvFJ5fT1e2JQ+P9Tv3IJ76zYmA+czNJ9uy4Xg5XK1a0WoqHA3kDRrX+VbCFdU3
 rqA9ifY2b9eHSUHyxfpweXEQCaU/cSUQ3At3MiJQt2DcC5sGzpskRjaDvjuNhV3vG5
 BegQJHRNGJ59ocpzb/UbLmhFvM6KVGIZ1poDnVkzWlij5XbukRWorvucLvVJkqa5HG
 hGxerQFd58E7/X1XZi9/7xfznMbhiXcZWtc7z0jwPrzdgjdKAdViUYJvlPraIvFsYE
 2/qLQXFlaM9FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com,
 Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2] dma-buf: remove unused dma-fence-unwrap.c
 (stable/linux-5.15.y only)
Date: Sun,  5 Jul 2026 09:51:58 -0400
Message-ID: <2026070416-stable-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703-5-15-dma-fence-unwrap-v2-1-43d58ee68c6b@linaro.org>
References: <20260703-5-15-dma-fence-unwrap-v2-1-43d58ee68c6b@linaro.org>
MIME-Version: 1.0
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

On Thu, 2026-07-03 at 14:28 +0000, Tudor Ambarus wrote:
> The file drivers/dma-buf/dma-fence-unwrap.c was incorrectly added to
> the 5.15.y stable branch in commit 4e82b9c11d3c ("dma-buf: add
> dma_fence_timestamp helper") as a new file, but it was never enabled in
> the Makefile, and its header include/linux/dma-fence-unwrap.h was not
> present, making it uncompilable.

Queued for 5.15.y, thanks.

-- 
Thanks,
Sasha
