Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215CCC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A9110E67A;
	Tue,  4 Aug 2026 07:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Up8VHYBp";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE07910E0C6
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 02:14:48 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so3903710b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 19:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785809688; x=1786414488; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WumQsINKEjXXwnA9droH9TmWDMYMx6AIp5LTpSxd3MI=;
 b=Up8VHYBp/SprB6xfcCsziYhkk9LO8BGTLn4sv5mLWQ0f3KRMaRnj1l//lVT43zTPn9
 kSOxb9ojt8dAeXNDiM9Ca9OdtyH7C9CjRh3wW4blYBMuGoWfolbrTts1am2WQaewuCAy
 nuV1Jb6DdUGLo4cLvGl4C2JK774vxaH39CUMF/hcL28EtG47UJHdpzpNRfIO0zQSMJuJ
 zuxO2IYGCbiDt3UJiAZlnfVNNCbKX+BNu7OuIkhwEQlfmr6GSM+f5F/hH4suUPAQKFOQ
 qZ5pXeywAObtFGcKK2bpe1h9RJKeMc7/jzi3ZQ869mTMBrTobC+bn6XtNiHJSgucYftL
 AJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785809688; x=1786414488;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WumQsINKEjXXwnA9droH9TmWDMYMx6AIp5LTpSxd3MI=;
 b=nPM3h+D1XrFRPrszI1NoCC3uhLrJU7bhedeiQJZYhOc0fGjay4SjwtfRVVFkBx1XSB
 HMAIaKJEuPioM4f8WW2smqwaj/8NECpiNawVdfoge3t19bbmnEFbo5CTy9B9kLq4dnbA
 TlZhKBDSsCRF7Om9qSOkWbJERn4nIUMzzJQL/e4CWWeq1Hsk6/+nKj/yQ5eGXDKAYpnM
 1iuyBrAhyk8EPoai+jCyAZFU8xAyyG/0V8K7TgXd6z5cL/H23+KvpEQMhasX3tJ1QVMa
 D4M0RlBrbsbo5puGkP7C92g8n8pniEenM+dcRbUT2Gm4iKcMm1D2LzLWpb6H0CrFkMC4
 KldQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro27TEv4Q1z40Kj6EPXYalgznzp88dtQaGtxHFICYhg6lltyjROVmXWNKDGUTGGFH/0vKPVLrqM51I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztbNzBsFBlsUxha3YFOGlCyzElMs33yI+RnEaX4ODD5SZymiei
 EkssSlqHt2FZkWU7wAHcKhiWgldqVgBPg7Bk6h0xxe57zEExKdRAMwIZ
X-Gm-Gg: AR+sD12uJN9YO+beJytbwn/6zp70TgJ1qOnGuqPdvcI7A6iCmT0vrDxRfBXthJpTtRA
 Uy43OfBzvgB6WH71IZxLZ82K23QVkntLOO1xUWiXUaL0xEWb8Dy4q6h4WdY9uXJG1sXRXjLi8k1
 QMo5VEtS8e2cZ5B1NBxVybGvaCtZiwNjVjsiQu1MI5MN0/Mr/7viOHA4iaBd5tisJVW88rf3q7y
 SaXDP94OueCPOc/wUN8WJ0iL9yX2pOVr0KknISVIfbo0oWhMa5P2Opqy9pmXTc7zKhS0ofFKQr5
 DpCiRr2IU4/KdjAgs4wkRTA7d9X9rOLpTdoS3gG5fTcVdfIOcroTR6SDKnU6vZAScERQ9/ATqFR
 H796ByJiNg2zW3q7dvquhYe736xstoGoq8JMLxUTagJ+caH0ru+CyZ3EpkBcEXvB8LooFdaUxso
 VJN1xFjKzyHRyI2+QtcaTN4rlMRgdsDgxQe54whfgSwOE1Q+7AUsMx+5CFGSiiw6V5gEDJ9Kag6
 TojFublmZevJIZc7B/88I+olmpN1hUsGKADVEDjzNH+35Ykcgg=
X-Received: by 2002:a05:6372:a746:b0:3cb:76e6:4e19 with SMTP id
 adf61e73a8af0-3cb76e65a78mr288035637.59.1785809688250; 
 Mon, 03 Aug 2026 19:14:48 -0700 (PDT)
Received: from lord ([170.246.208.189]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4f0f0sm42267698eec.2.2026.08.03.19.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 19:14:47 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
Date: Mon,  3 Aug 2026 23:14:38 -0300
Message-ID: <20260804021441.3054424-1-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Aug 2026 07:15:10 +0000
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

Hi,

This series is a follow-up to the TLB invalidation ack stall I have
been debugging on ARL, tracked in:

  https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51 and
7dd1 machines here, plus an independent Arc Pro 130T report on the
issue above), TLB invalidation acks intermittently stall for ~2.3s.
The H2G request is consumed from the CTB immediately and the G2H CTB
is empty the whole time - the firmware simply does not send the ack
until much later. The fence timeout fires at 2.25s and the ack lands
tens of ms after it. Userspace blocked on the invalidation (compositor
buffer unmaps etc.) hitches for the full window.

Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has no
exec queue or job to blame - leaves a devcoredump with the GuC log and
CT state behind (Matt suggested capturing devcoredumps when we
discussed the issue; devcoredumps from both machines are attached to
the issue above).

Patch 2 logs when the ack for a timed out invalidation finally
arrives. This is what established that the acks are late rather than
lost.

Patch 3 is the RFC part: a delayed work that pokes the GuC (status
register read, CT flush, doorbell ring) every 250ms while an ack is
overdue. On my machines this converts the guaranteed 2.3s stall into a
sub-500ms hiccup for the majority of occurrences; a minority of severe
episodes ignore 8-9 consecutive doorbells, which points at the GuC
firmware being internally blocked for the whole window. Full data on
the issue. I am happy to rework the approach (different delay,
tying it to the G2H handler, dropping the status read, etc.) - mainly
I would like the firmware side investigated, since no host-side poke
can fix the severe cases.

Based on drm-tip. Tested for several days on both ARL machines under
desktop and VM-heavy workloads.

Thanks,
Tales

Tales A. Mendonça (3):
  drm/xe: Capture devcoredump on TLB invalidation timeout
  drm/xe: Log when a timed out TLB invalidation ack finally arrives
  drm/xe: Kick GuC while TLB invalidation acks are overdue

 drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
 drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
 drivers/gpu/drm/xe/xe_tlb_inval.c       | 131 +++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
 4 files changed, 243 insertions(+), 4 deletions(-)

-- 
2.55.0

