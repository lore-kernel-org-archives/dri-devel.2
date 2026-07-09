Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF19C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C4110E690;
	Thu,  9 Jul 2026 06:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mMVeRXBW";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF7510E69E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:11:24 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso8326835ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 23:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783577484; x=1784182284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hd6GoWd0nNSvkzn4bZsOD9QjS5q1cvBf4vz24CQIaxI=;
 b=mMVeRXBWtYpMPyMO0gpl7iURVGh2fKK10LVwDCYrMpoUo9X4r0o7IgS1SXh4/4Bdx3
 scKHykIzU1+WP5mW5J+blJKDqHhm/VD0WAnnB/y5v7bpW9/tHIRO/80IUfY3VjTWbbcg
 vLd+cEe8PMdvLDIx1UbNRLiUebDrbbYGbHzHlpv3jEVVVreg2EPelDEMkvcwiqBfsf1t
 SWLHtOJLprNNczBJtQwnPCeJ2f1JxW+XQDJFlWoMcGiVe6jwnGy6KXj7lf3Yx1yf8E8d
 K+BQbdtwBgAFwR4wx2QsC/VMTUSc/6L5EI1ItK6YKefdjrSX65HdHC1fK5JREYw7YTuC
 /smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783577484; x=1784182284;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hd6GoWd0nNSvkzn4bZsOD9QjS5q1cvBf4vz24CQIaxI=;
 b=a/OKPOZ3WNJMGlPLkq/0y0vQJPwaOVFF6IKKKs1B7iDGZf+51L4GY7HdbNHl7c8xRg
 L+3JCeC7Qb8ctgW+Hp592IaqINFJWpFR3VaTCwVLuvMuyZTf1hVaDYpS/u1mLp2Xc1IM
 VurKak9FuoGljmfV8M+A7SLKu1gZ/cZ85W36Cy6/2bcyp+InzjfE9UN7cu0nV5qr2DAL
 Q96fo4a+nB8Sdd3UbMTykIT+xjqD74436XYPXohCv0Aq6iF034YLoh0dUbYyrsH7dCwD
 Uu3RgyZHZXJZ25O6qS3pD37T3MyDoY88wq2fbFuBrCg/9F/v6wSG6W/YFQ6GOz9AYMhq
 QU/g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5ykF2wkQDSgrwxjSZTqvD753J+8WeVzf7kT6hUBfBEjrQrna/ayZpN58k2OFcKm+wIHf+EEM4nP0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyd/Cm1DfoJZYAbuWHDYXUxTnBZYi0qy6Gh0zCJaotGfO678RDF
 Ev6/dWn75P3qZroa9mhY6TbUyGDuHcofjEpD/drFhj8pmJ6kchPxg//s
X-Gm-Gg: AfdE7cm3Mahb1gYG7S0MdOXJJGlJg7Lsmntdo1yzKI3ffZvVM+/4Nfj20zz+OXc1kK+
 QWMUYNF3KhK2JaQOaAQZNUkT1tek6nhcZL7Nh6pfebBm/ImWtg5pdeEsPGkeP9zo+P5MX/E/rsj
 eSbR1z1RjvjvJJAHgGCZrVma60cWUiOv+6QK2eNhOINvPwGESE0SVjA6vhHQT/CVrScnXHT2CvJ
 2cFvD/X3yyQURG89CmuY8bCsxlmXzkgQERklYzEQkPER1aNWUT1ssAypSkNUdbhMzgsdM2SZUvQ
 /DdVHWVXtDnnurqti92VKyfFj8j5GKfYZp/VNzviRrVXZyPBQY2AOAmusmZp8Zw0yJZTdzL3/Q5
 AUA/Rapgz5sRUG4h1E8Hs3/0yD7ahZJKvKqopC6ap4HSCDfI+0yeKzy5RaXn+MFBlcpc7WiEVij
 qDC/LGHBE=
X-Received: by 2002:a17:902:ce0d:b0:2c9:d27b:af11 with SMTP id
 d9443c01a7336-2cdd8a84479mr14704525ad.11.1783577484149; 
 Wed, 08 Jul 2026 23:11:24 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d602fdsm37778845ad.81.2026.07.08.23.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 23:11:23 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: matthew.brost@intel.com
Cc: thomas.hellstrom@linux.intel.com, christian.koenig@amd.com,
 ray.huang@amd.com, matthew.auld@intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, natalie.vock@gmx.de, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 Jing Wu <realwujing@gmail.com>
Subject: Re: [PATCH v7] cgroup/dmem: implement dmem.high soft limit with
 proactive reclaim
Date: Thu,  9 Jul 2026 14:11:13 +0800
Message-ID: <20260709061114.1623774-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ak81RUK6vRZaMN2D@gsse-cloud1.jf.intel.com>
References: <ak81RUK6vRZaMN2D@gsse-cloud1.jf.intel.com>
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

On Wed, Jul 09, 2026 at 12:44:37AM -0700, Matthew Brost wrote:
> This looks quite similar to work Thomas is doing here [1].

Thank you for the pointer, Matt.  We were not aware of Thomas's series
before your mail.  After reviewing Thomas's v7 [1], the two series turn
out to address different — and complementary — problems:

  - Thomas's series hooks a reclaim callback into the dmem.max write
    path: when an administrator lowers dmem.max below current usage, the
    kernel calls the driver's reclaim callback to bring device memory
    usage down to the new limit.  This is analogous to what happens in
    memcg when memory.max is written below current usage.

  - Our series adds dmem.high as a soft limit enforced in the charge
    path: when a successful allocation pushes a cgroup's usage above
    dmem.high, TTM proactively evicts one BO from that cgroup before
    returning.  This mirrors memory.high semantics in memcg, where
    reclaim is triggered per-allocation to keep usage below the soft
    threshold.

Both mechanisms coexist independently in memcg and serve distinct
purposes: the max write path handles capacity reconfiguration by
operators, while the high-limit path provides automatic backpressure
for workloads approaching their quota.  Having both in the dmem cgroup
controller seems correct.

> Are either of you two aware of this seemly overlapping work?

We were not, until your mail.  Now that we are, we would like to
coordinate with Thomas on a few interaction points:

  1. API intersection: Thomas's v5+ replaces the bare u64 size argument
     in dmem_cgroup_register_region() with struct dmem_cgroup_init (which
     bundles the region size, reclaim ops, and driver private data).  If
     Thomas's series lands first, we will adapt our patches to the new
     registration interface.

  2. File-level conflicts: both series modify ttm_resource.c and
     ttm_bo.c.  The changes are semantically independent and should
     compose cleanly after a rebase, whichever lands second.

Thomas, would you be open to coordinating on merge ordering?  We are
happy to rebase our dmem.high series on top of yours once it lands, or
to split out any shared infrastructure as a common prerequisite if that
helps.

Thanks,
Jing Wu
