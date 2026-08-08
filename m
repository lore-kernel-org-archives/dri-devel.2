Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D073EC5B567
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C4410E65B;
	Mon, 10 Aug 2026 06:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NoX22I93";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3CB810E06A
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 21:09:58 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d02b4c3601so7165285ad.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786223398; x=1786828198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JEDozRCApOyIBa6Mlu5Ff5h7lMmTA4l7LeQfPER4AT0=;
 b=NoX22I93gZXlztW3//XaIgTkz8FYFU2NGA/xsvfvXtAXGt1bLxKz3RhtZqupyXmagj
 oLLUxWQ2f8GexkuNv+mg1lFxzJitNPTVJnL1QhZRG2XPlx+nr0mp2ZXv127aJ31P7SU2
 21ajRRQpAJsM2EL2LBJ6ZK5yilowvMJVRUtenflItYt/FsEstI4BII+XqErt2ky3wgSn
 vpTp9jxkIqchQyiPEqC6YrKgDw5ohcUfY9KyxFVUe8AhumcK5WTbaJqgVNm3eLIwflF5
 TNMAIQHePzRuh7VjFfzUEFkRWo/52hPL7eGAYO8BfRYbDBgLrdUy9ZmwEIZfeRVh/efd
 QyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786223398; x=1786828198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JEDozRCApOyIBa6Mlu5Ff5h7lMmTA4l7LeQfPER4AT0=;
 b=p7RjNFovgTS6/UGlr5D6ls1NlfC0ieXt9zT+hxif0TuBI6Ha++VNed4k4zk8tMM1RO
 QtV+SMLHWxc8Jgx+4DagG+vl6CsX/TzH2ntG0U1FL9Es+tL8lGEqo3PlgfhCyRBlvMa5
 ghEy5WuU3AgZHyIsezTcpXA0NVvxUzu1g9Mloq2MQpBmhPuwEnz4XdrTp2yI1zurQMPh
 Naiu52NkHERIxlJENm+pnJR+OCfUzp/LSb+NP2RROJUhOgbGOt5RWvaSjwOu1e8o0Ka9
 2FKUhwP3I5RMbNgL0PNBalH7+VtLkevZzNCZSfYhw6910aggJne880GB6r718htzqX0u
 xrBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RprMnpEx8NoPsdpSkZsaMwY8Y+j5674FZ+Li7DduCCrZAFofuj630fayRfMKeLfZIPp8PqT6C5k18o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8Q+BqGKvmskcu+27xalrgF71Okd/znJwohaoxgi1hrQGXHY1b
 AMLyrYfTTTgMYILtkahIyRXHBmpHCERnZKZmqcfGEImhjUby0GfU4qiT
X-Gm-Gg: AR+sD12FYl0t/FL6NN+v8mYIluvrKyKRWHfGZxe2CSP+Ibrmg5Z4F7TTbeJx2zvwAGi
 6A0ZIt1wsEe3djds73OLD0nCdporNWyT7I3z+jJkgJ3aV64cicGC1PtpAgnycr6Q2JPrxqWHtZd
 7Mh+ivKbnQJRCOWubUhbFs5NL5eZcDTuR3Hm/NDYSK6AHnWFXmUe3DAsFqppTGO/TcfHHPXC85e
 aCuQa3pNIzTpPNbpG8K8h6kXc6W01ER+QRAQNTQwnLaJzWp5H43032/uH51cQLHgCrsZYiYeQLB
 +VTWxOkJekeEEyRxPltn8pnh/IhzGzQUYGtBiPKdq3loAigFSqU1edSmWImdGpoVStjM5AfBpdM
 oDDH7b7YRuXOOSUqb4daAp4F2z44VekAvo0Nnp+u5e94A2Hq3hnhqKCu96HAoQlotyBBVhA7wbs
 jlbfBdvDxs54OSlgB9j6HlHi7rVM6H+qasInCnSzmr+W8T+ABJI1ojLoyIqM9Kdc5mhIacU2Zvl
 oSxuk9h1gQ=
X-Received: by 2002:a05:6a20:d4b:b0:3c3:a722:59cc with SMTP id
 adf61e73a8af0-3cb85ea6f6bmr37753432637.22.1786223398152; 
 Sat, 08 Aug 2026 14:09:58 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec5aac2sm25713133eec.30.2026.08.08.14.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 14:09:57 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH 0/5] drm/amdgpu/aca: Robustness and safety fixes for ACA driver
Date: Sat,  8 Aug 2026 21:08:47 +0000
Message-ID: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
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

This patch series addresses several race conditions, boundary check bugs,
logic inversions, NULL pointer checks, and buffer size parameters across
the AMDGPU ACA (Accelerated Compute Architecture) driver subsystem:

Sreeraj S Kurup (5):
  drm/amdgpu/aca: Fix race condition and UAF in error cache logging
  drm/amdgpu/aca: Add upper bounds check in aca_bank_hwip_is_matched
  drm/amdgpu/aca: Fix inverted validation logic in
    amdgpu_aca_get_error_data
  drm/amdgpu/aca: Add missing NULL check for banks parameter in
    aca_banks_add_bank
  drm/amdgpu/aca: Fix off-by-one buffer size parameter in add_aca_sysfs

 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 31 ++++++++++---------------
 1 file changed, 12 insertions(+), 19 deletions(-)

-- 
2.54.0

