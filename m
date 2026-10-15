Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AABCCA463
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F91D10FB48;
	Thu, 15 Oct 2026 16:15:10 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 840DD10E0FB
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:36:40 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-93ef1a2948dso365052085a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792053399; x=1792658199; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=csLZTWFJZwVmJjPK2j5B/Fm6zSWB8VBpn8JFPtRRzfA=;
 b=A3r7q2l/BYqW6Lx8kP0EuZcbi9AVq1/i51C4A5PqMVf4P0ojHOPy79rW7G73eaXuTa
 uTqO//y6woA0FlP2gnryMPbuEGEUlhR1hY5WKBohjgxZdo/REYmZCbQyCyIaimEyZ1kA
 iBrJgUu1CmeRw0U4UWRw3fE/y073dSNr2C/1IHoiBvac2MBI2ATnMHxHlFoCDA0BG2dP
 FlUGZYmKn9sPDrOxPuTUcZqzDH1muoHA5/bGh9CtlD+aZtxy/XDXmfuAwG9rXsaOyAIK
 79dbzSfYaifY4yprFabRZvdcn76k7FuJRiOg/01QSy6wVVxkYJLhP0topcb8NXxS/UQy
 GajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792053399; x=1792658199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=csLZTWFJZwVmJjPK2j5B/Fm6zSWB8VBpn8JFPtRRzfA=;
 b=i6xPP3sr3Dw8OdTuEItLLJYIQDq5eqHA12QWnjQ2nMsnlSRO36vd0LUpxM8X/O3lbj
 Si64BHF+65SahnEm/66qtMUJHEWuG+xHMflS8q4LwRHXJ3M1urwe00EyB4eCzxmksOKq
 3TdUiLu4ocQ0p1hAnYu/bLgoEOW/mGbX3RkLeUQtnOPv1fVTPgQcJRZ95F5H9xmHb9pd
 XMyUjvV3nFfZDw5aeUh76jNCNSbtD0sxXhGYvYTJGJWLqbtml3qCB7K3Dne2xBrU50cZ
 7j9ClNB2ZrgcTXjclcb07iA3i4luO/EP4t9byzWDfPocx+p1R86qa9iMvejSVAqOAAol
 1/Gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0jXOZs7GUxVF0P3PPHk07OR0u7y56ZHdvWTbPcoN5iH03yB9hvmQ8MjtZEx0o88qt+pcTuLBMkFs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJuHtt3J4XbC+cRmJ2G9aoPBqLyG41L90agK6KDepeApBySFhz0
 hxYFVpvYsmC9WnxCKWIkA0s5qYavSdmf+GBeQmD94HUgrXfYp8T7XUul
X-Gm-Gg: AYBFou20HRyLf1QxJDu1kmQ3NcVQTzhp+/9+4v6KHxafgHQ8BL2IjRrg3pnpvWOJWfT
 5/oQYFqNQf54jrTVBoknuidLryGXIf9voz8+jjvQDJMUYsCinjeNzHt+lnRUg0fi50XhTRImfRk
 zwrIzn7o20XtIjamdgY8w9Ie0k4V2agu/myCO6rcqFwe3rVx1lL/I3hnVjj22jDymak7fvKAxSv
 FeRqSotaftm4FWCuGJwK5O4yh/TwS5/L1f4qrsy8xNfJXgVzjR2J48KGSdShlvcYvYtnQtxjhXt
 /oRJm3/0lvtPiUrbrxA5/2qeeH1oaifM7p8XBg1xlolRJ/O4bLBwGnORrrHnG32H1egRcn7mnaQ
 BP/XqiSAjX+0Lf0S+Nqu0uFdld92YwVtWZ2ZI2O1lk98w+Y6kZVBmVagtBbyOqPygb7dxsHkdhS
 aRLhK/PbnN225oGJ9oJYSDq5A00LoCLXBOBtxUjIQkAz82t4AsywP7lbjgNDqemAMM8p26UMJXI
 dh58pQZWO0aDlrFs1jxXbsvJQmz01rbdvAB3crpOiCxc8tOHX9qpqMMn71Z2TEdb2Q6ENq0L7KQ
 a9PJCLKPG3PJV4B1jTUL32OuZ+/CI04hKg==
X-Received: by 2002:a05:620a:4552:b0:93e:5821:2c57 with SMTP id
 af79cd13be357-93ebd2244d7mr3256091585a.22.1792053399383; 
 Thu, 15 Oct 2026 01:36:39 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal
 (ec2-44-200-54-59.compute-1.amazonaws.com. [44.200.54.59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef5090050sm711843985a.40.2026.10.15.01.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:36:38 -0700 (PDT)
From: Deep Shah <deepshah146@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Deep Shah <deepshah146@gmail.com>
Subject: [PATCH rdma-rc 0/2] RDMA/uverbs: Fix DMABUF lifetime bugs
Date: Thu, 15 Oct 2026 08:36:35 +0000
Message-ID: <20261015083637.200958-1-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 16:15:09 +0000
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

Fix two lifetime bugs in the uverbs DMABUF export path. Patch 1 fixes
leaked uobject and ufile references when the uverbs FD is closed first.
Patch 2 fixes a use-after-free when dma-buf release races with ufile
cleanup.

Tested on mainline 4056b3c9d3c9 in x86_64 QEMU with KASAN and lockdep,
using test-only siw export hooks. The unpatched kernel reproduces both
bugs. Patch 1 fixes the leak, confirmed by tracing ufile release. With
both patches, the same tests complete without KASAN or lockdep reports.

The tests cover core export and teardown, not real mlx5 hardware,
importer DMA mappings, device removal, or allocation abort. The abort
issue in patch 1 is based on source review. Testing on mlx5 would be
helpful.

Deep Shah (2):
  RDMA/uverbs: Fix uobject leak in DMABUF release
  RDMA/uverbs: Fix DMABUF use-after-free during ufile cleanup

 drivers/infiniband/core/ib_core_uverbs.c      | 10 +---
 drivers/infiniband/core/uverbs.h              | 37 +++++++++++++++
 .../infiniband/core/uverbs_std_types_dmabuf.c | 46 +++++++++++--------
 3 files changed, 66 insertions(+), 27 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
