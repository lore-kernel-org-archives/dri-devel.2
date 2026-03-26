Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C847E10A3D8C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB1810E9A1;
	Thu, 26 Mar 2026 12:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ZA9fIdF6";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F136610E9C8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 12:32:30 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-486fa07f2bbso5357625e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774528349; x=1775133149;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yH9b1Z9LWNEOI2+GECgyejSXeUsvyBElCPTE9tOWLWY=;
 b=ZA9fIdF6xJMvfs3UBW1N54mS3FWN9JEbUJcEfei9bvfgJKT6sBEDRuK7jaYHNgEaOB
 crHO8rKIOUmqaxaX73/T2BbocUj9w7xuPcO5Un3QbFMufODa+hLU1PMSgRCHiDKKHJkY
 RvcXUOXv3qCG+CCUxv8MOyr9cHdMlDfZCt0Ft8u6qnYOP2zye2EUWCQfNe/xeGSLVBpp
 fZbI9VEFjn5Xi/KJrqjL49uiW2+QtNQrJUmVncA4d9Z059JbpwlE+kcH5BEBgOKyKLOi
 zRtSziAj0fqchgU8GJ7jSMv+7L/puZNRl7ivnrO4pAqe6WRwTk2eOKCSy/ncQBssIb4t
 ymbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774528349; x=1775133149;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yH9b1Z9LWNEOI2+GECgyejSXeUsvyBElCPTE9tOWLWY=;
 b=E1ym0wvDsNBOS0KramOzBLkzcRaTFt5U9PhNvKQSnXSVFGuGm/zEngYomF73937oRK
 N9gP64HaHq87NDudwegoVNCdQ7TihBkEPMASSY+TT9RQA//91t6pLGe9sm991ElICeHn
 7+a0y8cJB4/zr70crn0a+4zX0488gRNaBuZT7GXXsoSasSoq4xIkgeBX8DGJaGQ21UVN
 /bdWqM8+MZAcTztE+htpkdij2JqYtlR50+miucxq0iGEz+PT++L38rMsVUjbh4zpconn
 zKo/1bDYsCAsjrTSn7dAk/6mpMTibLkQhNDGDYEQEkx9x0GTRoBxpl+kB8+Bu+OR2VmU
 UEzQ==
X-Gm-Message-State: AOJu0Yw8NRKqHtWtnh5Sai2atPmGOaLA4a6Z0iDvyeYhI7YviQuuV2fd
 IqxHhbf++RcZx1UfPBniMbak1hwW1CMwoCz4zJeZKt602/EEjJ1L5WfBLz069Dwp8yUvyUIpyyE
 hJxKesUOID4Q0EQ==
X-Received: from wmf21.prod.google.com ([2002:a05:600c:2295:b0:486:fc75:1429])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c177:b0:487:2e8:69c5 with SMTP id
 5b1f17b1804b1-48715fe2aa7mr107288655e9.15.1774528349254; 
 Thu, 26 Mar 2026 05:32:29 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:31:56 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADwnxWkC/13MQQ6DIBCF4auYWZcGkYh25T0aF4ADTtKKgYa0M
 dy91GWX/8vLd0DCSJjg1hwQMVOisNUQlwbsqjePjJbaILjoedeOzLu9l0zpUXE9cKMlQv3uER2
 9T+c+114pvUL8nGxuf+u/kFvGmbCqM8MihVFu8iH4B15teMJcSvkCegKY1ZsAAAA=
X-Change-Id: 20260319-gfp64-7a970a80ba4e
X-Mailer: b4 0.14.3
Message-ID: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Subject: [PATCH v2 0/4] treewide: fixup gfp_t printks
From: Brendan Jackman <jackmanb@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Stanislaw Gruszka <stf_xl@wp.pl>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"
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

This patchset used to be about switching gfp_t to unsigned long. That is
probably not gonna happen any more but while writing it I found these
cleanups that seem worthwhile regardless.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v2:
- Drop gfp_t changes
- Add correct CCs
- Add minor fixups to preexisting code spotted by AI review
- Link to v1: https://lore.kernel.org/r/20260319-gfp64-v1-0-2c73b8d42b7f@google.com

---
Brendan Jackman (4):
      drm/managed: Use special gfp_t format specifier
      iwlegacy: 3945-mac: Fixup allocation failure log
      mm/kfence: Use special gfp_t format specifier
      net/rds: Use special gfp_t format specifier

 drivers/gpu/drm/drm_managed.c                  | 4 ++--
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 ++--
 mm/kfence/kfence_test.c                        | 2 +-
 net/rds/tcp_recv.c                             | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260319-gfp64-7a970a80ba4e

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>

