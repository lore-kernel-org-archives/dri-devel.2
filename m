Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC873C5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E92A10E683;
	Mon, 10 Aug 2026 06:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="icJ0yLkq";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D3610E115
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 08:49:00 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-381b831d535so1168936a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 01:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265339; x=1786870139; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qSsyx07rdbg9BS6CDdvM5aa6FHTdoOSpWof0piChyTs=;
 b=icJ0yLkq6XRywZnrAA6KOci2aj0FcU7CWc1t/0745qrdQ4q0qKmKVi4/qBWz3Q+oGg
 7+hcr1PBJV55udWS6/cmKMwxsrFo8bYarpEXsPtmUlhsHBWeGyff7P5ALIiNDi0/8U8c
 fag9iNCt1cFxagaBSKFEX/IZk00y25oZP2Tw50L5uzUSQAWt9HckUAAkDEj2uvWsfiwN
 J7d7Swq8tYyUeG8kZF01MfOknVVlSUGHok20MjP67z0tksjUtvtI51HUJq3yktI5ynEq
 yrmH8eiq/CLlQSJV2Qk1ti4CAGvFdGQIopFU5eyUzucXZ8ZTSt2i2Qchn8hsNWhLXLSE
 8p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265339; x=1786870139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qSsyx07rdbg9BS6CDdvM5aa6FHTdoOSpWof0piChyTs=;
 b=WUmntC9LFNGRkMozzIgBz6X2b67nazKl9iVqDQPi2lQmolECqK9egcpt/3f98qoozk
 oDRpHuTTF0b/7m45bvqM6ZIN6REaMImzR2qVgQVlrAqGhnsW2psMt3yrMlvqRajfj0rJ
 n7bhZRkmTDabDF9b/a46HY2JmW0k2hGvRKU0tfkCuO10ngzqH5dkgGRK4nU19aml5ogj
 9xF9DbY2GInS7QpZik1Ybey9/Hq+MzS45uaN3aICnJAfNX9vWIZSn7TWrzZy9Jon8emx
 1qmw/M8/IZEx9vzOa+CFpju5JCMq2xMR+aEWDzud5R+5pEptTgT+090jgczLly5lXska
 zP1w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5XVuVczhu6JdqGjAwwMYC8VX81HEF7A/z/Ls4Gd8hIxKda0CkCFjmOH9k2MtKk/35AV/JD/4eMwk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yww202wj8ZJS3J8vVjfwE6mld5BDdkxjldJxz49iiVSm6oU13Pv
 YNDTP+mGVE8selVgQhvFC8cbyCCAHJhJlJfZzg5LuOfETdkXclaMVACM
X-Gm-Gg: AR+sD13HQ7OMhFovKDYNA9umrrksNzHkpo3WBovttojpOtJhq1WqL/tNs41miSaIXWr
 mEbxZt0LfPrI1ruFRICR1SG4dspGO6R5NNB5OQA7xlhlVU71iZ99UYC4VEIRPR4L9vO248z3TOS
 3Lvr/Q55X763s6zNmTsQ1jKtzmxWoRiZd+fGJn+W9k9kaN4OPSJ/3tqro8e2nPS0zSiprhDnKhS
 G94yXZTsgZkZ8n/VnkiOTeoX/3kFOwJPzbTxR+TTOklp8vxWjxZokKunP2mU4nNv7p8DWj3diBq
 E5omp7XmDy+ZfY4gm2KO+ox7bNTfBkLTUbWUlx+Ikokbo5cOC2gVMLIk/Weqq4HzO0ticmO3r8F
 bDWMfhe3h0RuyzsshG62zvpoHwlRXOVztCREZ94OOIvRD0R09GMOqb1/beKiAN+sHHpzLclp05I
 nyClLNsAytzyyHSiZV5egbFV5ekXnzPc3i1bi9jXvl2anQTc2GbArJBYwDzyORvfEWXyvALHEzg
 7y5DHD1vfQ=
X-Received: by 2002:a17:90b:2585:b0:38e:bbf1:de34 with SMTP id
 98e67ed59e1d1-39261fdab5amr18507599a91.7.1786265339360; 
 Sun, 09 Aug 2026 01:48:59 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:48:58 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 0/6] drm/amdgpu: Robustness and safety fixes for ACA and
 RAS drivers
Date: Sun,  9 Aug 2026 08:47:29 +0000
Message-ID: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

This patch series addresses several race conditions, boundary check
bugs, logic inversions, NULL pointer checks, and buffer size
parameters across the AMDGPU ACA (Accelerated Compute Architecture)
and RAS driver subsystems.

v3 -> v4:
  - Patch 3: Wrapped list_del_init() inside mgr->lock in
    remove_aca_handle() and moved node unlinking prior to
    aca_fini_error_cache(). This prevents infinite loops during
    concurrent list traversal and stops background queries from
    referencing destroyed error cache mutexes during teardown.
  - Patch 6: Updated subject and moved cancel_work_sync() and
    cancel_delayed_work_sync() prior to
    mutex_destroy(&con->page_rsv_lock) in amdgpu_ras_recovery_fini()
    to prevent work executing after lock destruction.

v2 -> v3:
  - Patch 3: Updated amdgpu_aca_get_error_data() to return 0 instead
    of -EOPNOTSUPP for invalid handles, ensuring global RAS error
    queries safely pass through non-ACA blocks without breaking
    telemetry.
  - Patch 6: Moved cancel_delayed_work_sync() in amdgpu_ras_fini()
    prior to ACA subsystem and lock cleanup to avoid teardown races
    and UAF.

v1 -> v2:
  - Patch 3: Updated remove_aca_handle() to use list_del_init()
    instead of list_del(), ensuring list_empty() properly evaluates
    removed handles and avoiding potential UAF during device
    teardown.

Sreeraj S Kurup (6):
  drm/amdgpu/aca: Fix race condition and UAF in error cache logging
  drm/amdgpu/aca: Add upper bounds check in aca_bank_hwip_is_matched
  drm/amdgpu/aca: Fix inverted validation logic and list cleanup
  drm/amdgpu/aca: Add missing NULL check for banks parameter in
    aca_banks_add_bank
  drm/amdgpu/aca: Fix off-by-one buffer size parameter in add_aca_sysfs
  drm/amdgpu/ras: Fix delayed work cancellation order during teardown

 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 41 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++----
 2 files changed, 24 insertions(+), 28 deletions(-)

-- 
2.54.0

