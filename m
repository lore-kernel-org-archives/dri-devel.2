Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A955C98328
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2412110E144;
	Sat, 26 Sep 2026 12:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DpOyCmnG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C066910E144
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 12:44:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 60BF141AEA;
 Sat, 26 Sep 2026 12:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E2A1F000FF;
 Sat, 26 Sep 2026 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790426649;
 bh=2ODxEQcjvqmkuPG+SDefLmH/+uRSXK5o4R5dGwS3vq0=;
 h=From:To:Cc:Subject:Date;
 b=DpOyCmnG6OIpkKcoLZ+Kh04cMCthlsfsrJvBnAjzAa9Gmpz/6g2Aq1a8o2SAYbJSk
 FqxUH1NizFfK261BwYKSTmjUadKlAodINrB3JmUz+AmVMuabtschM2+MLs6xq+SAUj
 ZfWhW+aHplYjfhFeullcxg2/lQyGzygCA1fcUOIa7bigFSnzVdPsXjPAXy2es/lyDB
 JOj5yqQb5/oSxFfLBzHKZUyXd4qruKAiK+m5nREj8z7agFnMB6xtkpjp7FDVsTFJx2
 KR750lWqvzoxohtI1YGgcPMNyXUPPcrdkQBmRjZ1u4YXL53tMtq8LIgQq/i5UMJzXy
 LulvCTF1t1cdA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/4] nova-core: align Bar0/Bar1 and remvove unnecessary Arc
Date: Sat, 26 Sep 2026 14:43:23 +0200
Message-ID: <20260926124405.604707-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
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

Get rid of the Bar0/Bar1 type alias inconsistency and the unnecessary reference
count of BarUser.

There's much more to improve, but this just crossed my way.

Danilo Krummrich (4):
  gpu: nova-core: align Bar1 alias with Bar0
  gpu: nova-core: remove unnecessary Arc around BarUser
  gpu: nova-core: mm: get rid of Arc<BarUser> in BarUserAccess
  gpu: nova-core: mm: fix lifetime name in BarUser

 drivers/gpu/nova-core/driver.rs      |  4 +--
 drivers/gpu/nova-core/gpu.rs         | 26 ++++++++---------
 drivers/gpu/nova-core/mm.rs          |  5 ++--
 drivers/gpu/nova-core/mm/bar_user.rs | 43 +++++++++++++---------------
 4 files changed, 36 insertions(+), 42 deletions(-)


base-commit: 896ed083362758b33c49a1b5e5a3423c5814d87e
-- 
2.55.0

