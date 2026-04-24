Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C9AFED3E6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD7810F671;
	Fri, 24 Apr 2026 17:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C6dTGwlj";
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F225910F5AB
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 14:08:18 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso3618251a34.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777039698; x=1777644498; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9YAH8g2v2vBsoZmgPxB7XwrigYCMZajRhN5tYq8MvnA=;
 b=C6dTGwljJ3iu3qjJ3QV0ce4eTHjRI+vTOocAx1H6wHQsPrAOc0jcyGrlRKCqgm28DC
 SyFesGWiZ5ZHNZO3wuj0QzYnrs80NkG8xHoo49Y4GNU5Hds96F6DAaihKTWz5WFmaUKO
 fi9xvKihqs2pxdomz7dYpHDMs7xp+rBj6kUZtt+8dYCSf5eeI3RiMFsx0Iv1q/7u2nQK
 tth8X6EzVVwFtl62yHCA3AH4QvPzvG5cEIUMTHxlVOazUqc8cxDDYPCZ86t3QAhHi9V2
 C5qTgz0r8vpWZihlC15LaVY7oAl19aTaZJzQKNi0Hfz7v32R2+USkrxUx9QRmQ36IDno
 //Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777039698; x=1777644498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YAH8g2v2vBsoZmgPxB7XwrigYCMZajRhN5tYq8MvnA=;
 b=OVzY9QxiIze3McbnJ390z3MebYW8FLZ0dkF3g0aVYGeJtB4yFVSYFgD+PMAXjJcDWY
 ZxECGzilp0COkBwiTBpPwOesatt1KNHBzl2DfYFpGZcQjIEb5NNowEGd1tDuCdjZv7es
 g8FfIhmuIsZTc2d2REURbMa+LNISuEvgmYbksz/a+2a909oOIV4vFfAfnvl1UrPG2O5E
 CSa+yVimcl2//1CXPHlEPWDDCSv2vozc8G6fgbGwQEpF93ZQdNDQL+XHVcNzaIu3ORJF
 i04bpDkD6+do/mEYg71tSTqkZh8yxlodCLFq4ankpz1TcVwGEoOvnZJ03lnYlAQCjcF6
 h1aA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DNu0SSX2impJ0ulTBqpDJlIDkI3dFhpCSTQA/S3jRxzJg8nErKKVCVmnMk1p6ArHxATzuVjWOmnI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5qnyvYNAscQCeVvc52sXHq7KM4lkLzNQHssWtoa2QjmO9y29u
 YVWCFCKznhewFjBJkf0iS4ELYsq9qRuWlWQ9pdvYeVveFq+StPfc+dg=
X-Gm-Gg: AeBDievDRdinH5ZA7oO4duLeU1ViLi4VZFs6l1Ry07LomTGVFCmS0CzqgwOpRvRe6An
 jwNunRe3ud9xNWZGkdrXKLTbxFKjMRXPPA1Cn5ITx1EZAAxGXlauqtgt681niMsSrkL8MzA6ihx
 nLFcve9qff9VenRABXMEvfceH5i7QG7E4ZY1iRzkwYIIe+dBt+jHg9I2Iq2La5FZk/Jq4nbMsnf
 VAVpxvmOKvCe8XnDc3fDNzeKsg6Xfe/PTqkPvWQNMxVaAmxWvKefTqgdIbuyzggaltQIju4e/Wu
 r6PgQ1czl2CY6/gl3HTfDSSUBFhV8/RtbXRRI3PusQQjcdEbVEsMsZhh5FEFUn5KoU81opQrwY3
 99Z7QBpv+rzHKNbXYIb+HnYdJ4L5HwCVLKjRYWdvzlaXm5hPJy398rmitzcI1K5zd7a6465fyST
 WCDkz+ICeSEiHgL6nV24uw61EYYsv+qUgylv2QLGdSnHxe/bRiYS4GJI8bjjxbNSow8hy4x1SJI
 HJApAttmKN3N+dTLzU01o+yk7oNm1B/ax1bMoAPnyNILA==
X-Received: by 2002:a05:6830:6483:b0:7d7:4639:43ee with SMTP id
 46e09a7af769-7dc94f97a1amr21338986a34.3.1777039698033; 
 Fri, 24 Apr 2026 07:08:18 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a2dd1sm22228653fac.9.2026.04.24.07.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:08:17 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, stable@vger.kernel.org,
 "John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v2 0/2] drm/amdgpu: reject misaligned IB addresses in CS parser
Date: Fri, 24 Apr 2026 09:08:14 -0500
Message-ID: <20260424140816.43766-1-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

Userspace can submit command streams with IB addresses whose low two
bits are set.  On all hardware that amdgpu supports, those bits are
reserved (they encoded byte-swap mode on pre-amdgpu legacy HW).
Today these addresses pass through the CS parser unchecked and hit
BUG_ON(addr & 0x3) assertions in ring emission callbacks across
gfx_v9 through gfx_v12 and sdma_v4 through sdma_v7 (35 call sites),
crashing the kernel.

Patch 1 adds an early -EINVAL rejection in the CS parser before the
IB is allocated, plus a defense-in-depth WARN_ON_ONCE in
amdgpu_ib_schedule() to catch any that slip through from other code
paths.

Patch 2 is a trivial cleanup: removing a dead BUG_ON(!bo_va) in
amdgpu_cs_vm_handling() that is unreachable due to the NULL check on
the line above.

A follow-up series could convert the 35 downstream BUG_ON(addr & 0x3)
assertions in the ring emit_ib callbacks to WARN_ON_ONCE, but that is
a larger change and is not included here.

v2:
 - Rebased onto amd-staging-drm-next (was incorrectly based on a
   local branch in v1 — thanks Christian for catching this)
 - Split the dead-code BUG_ON removal into a separate patch
 - Moved the check before amdgpu_ib_get() to avoid unnecessary
   IB allocation on bad input
 - Added Fixes: tag and Cc: stable

John B. Moore (2):
  drm/amdgpu: reject IB addresses with reserved byte-swap bits
  drm/amdgpu: remove superfluous BUG_ON in amdgpu_cs_vm_handling

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 10 ++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.43.0

