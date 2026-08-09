Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A90DC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C107C10E666;
	Mon, 10 Aug 2026 06:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LY/ZRSiG";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3558010E15F
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 14:46:17 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso734199a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786286777; x=1786891577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sLtiiUZZXVNzDzJlTEnHgJIHbIC7FJbLG16BtntNSAU=;
 b=LY/ZRSiGl7HitrMYIRiGhdkS+bT2zY2Rc81hk2dS6cFM5uKPF+oLKzXldDmJ/L3xUc
 5wbrTn08WzTrfuSe1g015RSme4rTyvUBnxQpjixO+Eo5zqJKUmG4vFlv5ujXU2cY7Aub
 fddVEBunMGkwSQ2EABpoFL6nYblkoeZZWI13qRsJNCTq5MN2lFONoJa6PTEPtE7hCEmu
 i9mkCUGErTn731Z3oI6AOekj+SRVHlXELSPhG3M7kbyvnu1Ssj5/fQwwl5sIadlmw8Oc
 3hqvIwfVj5n/RTQpFF392tf1Rw/02t8xJqprwuOuvabtciHZ5UpGWvmOD4wNJWRQkNVc
 IXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786286777; x=1786891577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sLtiiUZZXVNzDzJlTEnHgJIHbIC7FJbLG16BtntNSAU=;
 b=ke7mEnRxNFPzsrJK4a4740OlmTx70LEQZJ7HQ2NNYr/+ymmCCjW6zE60Uiru2SOh4Q
 tV1CbOCpvFB+k76ept47iy4wapmc9dTCNAkLUEMYOm+Avcsf6Hi4Wc0ucVm6/zwfZ+ST
 fomNu4XfptQqLHXj1+58xxcMiT/5yJ4R5nP+Fsu9wz7tKStMosHyLxdfvhDX01KTDVN0
 RoPeNTvpDjsuj2HN0gX3A0mt9xA33RPgQxmkqWtLf5j1G8BCbfqecc6vYELiJmtW0mmP
 FnlTcSyugV6kL/SMARfKZe1/CksT7Yyud6e7bjxAf6stsBIADczFluYRmwOAW20fFLMm
 wDJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbxfU5/hGRbuLo9W6jE/XKRzWxsKLg4N9afe/FhnvrIS/LWqfVc5NTAWJwvjoDs1p3qPKlbJr2OTc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8p20EdxdDk6XjD6fb9PwQI9GUBguOVDPY3yqvLj+ca5cfqTna
 u3x3EpfvusO2l5Qy21SzriFdck5x8C/tIZ0Vyzk68VzqWpmESV4UEcrv
X-Gm-Gg: AR+sD10ANvQeI1uKSLmHvSq5rm2QfB9AbiicDUVX0AYcMY26Ki5mTaMJ20xGJhP93c4
 EotGZJh+vgo+KXFYHxXw+73Vap0Qj1gQeuqbsI5i7waSH1HkgQWt6XwA+Z9/YsJQomNYs29fs1p
 1NUH3UHIHvmDbqeiNd1Zx/9mMQmF9TLUUxCF4nfpqLDUcJRKY3R+SarpX+oNoIhsPxjRF4pY72X
 T9k3XRYU4Sma4HGypTAXzwuD7LhuD49U5RPFIyFI8/Mnc/UedqySjAcSLKCj4wNOzVbbIjbUsbv
 4zKZJtFehOXNNamk0TVCaDil3mpHGXt015yte2rYW33xQVdVjYFibuMdIKpoydi94NPUegWLNZ8
 0XdX0d5KDIrl20nKI1Q0tiOfry2kRZAgyoayJMM4LubO7KowajebQQHNmXza2jamV7RJFkDLa1l
 LgFGceyNZP54ccqFP1DlY3wmHNjVZ7hqcw29T1E2jP5FaJMdemUmax8joXJ2riGPNhjKS/I42lh
 9DMijKzTGI=
X-Received: by 2002:a05:6a20:4309:b0:3c8:ead5:bf7b with SMTP id
 adf61e73a8af0-3cb85ded991mr39942065637.4.1786286776550; 
 Sun, 09 Aug 2026 07:46:16 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm25911224c88.13.2026.08.09.07.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 07:46:16 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v5 0/4] drm/amdgpu: Robustness and safety fixes for ACA and
 RAS drivers
Date: Sun,  9 Aug 2026 14:44:47 +0000
Message-ID: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
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

This patch series addresses race conditions, boundary check bugs, logic
inversions, and teardown ordering in the AMDGPU ACA (Accelerated Compute
Architecture) and RAS driver subsystems.

v4 -> v5:
  - Dropped former Patch 4 (NULL check on banks parameter) and Patch 5
    (snprintf buffer size adjustment) from v5.
  - Patch 3: Dropped invalid kfree(handle) from remove_aca_handle()
    since ACA handles can be embedded in ras_manager. Removed non-existent
    mgr->lock references and retained list_del_init() prior to
    aca_fini_error_cache().
  - Patch 4 (formerly Patch 6): Retained the original work cancellation
    order in amdgpu_ras_fini() to prevent work re-queueing, while moving
    cancellation prior to mutex_destroy(&con->page_rsv_lock) in
    amdgpu_ras_recovery_fini().

v3 -> v4:
  - Patch 3: Moved node unlinking prior to aca_fini_error_cache().
  - Patch 4 (formerly Patch 6): Updated the subject and moved
    cancel_work_sync() and cancel_delayed_work_sync() prior to
    mutex_destroy(&con->page_rsv_lock) in amdgpu_ras_recovery_fini().

v2 -> v3:
  - Patch 3: Updated amdgpu_aca_get_error_data() to return 0 instead
    of -EOPNOTSUPP for invalid handles, allowing global RAS error
    queries to safely pass through non-ACA blocks.

v1 -> v2:
  - Patch 3: Updated remove_aca_handle() to use list_del_init()
    instead of list_del(), ensuring list_empty() correctly evaluates
    removed handles.

Sreeraj S Kurup (4):
  drm/amdgpu/aca: Fix race condition and UAF in error cache logging
  drm/amdgpu/aca: Add upper bounds check in aca_bank_hwip_is_matched
  drm/amdgpu/aca: Fix inverted validation logic and list cleanup
  drm/amdgpu/ras: Fix delayed work cancellation order during teardown

 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 34 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  7 +++--
 2 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.54.0

