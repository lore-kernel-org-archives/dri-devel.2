Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B85CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 09:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E5410E132;
	Sun, 11 Oct 2026 09:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WOOnFOMs";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C646610E14B
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 09:45:54 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d032846c95so7585285ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 02:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791711954; x=1792316754; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AvGhTKKdbU1GWyQfWY5VlojnPZ4MgvqmXbvuxJbcqHg=;
 b=WOOnFOMs5ERePK+GSuB22KfThXKVs94r88AokPjEbw3VX6r9OlqNmr/AK6F0TOiOKp
 SCnNYgN4KAMv1yHBQABEnoHlDfBOnDW4LyhofOwIg3pAzdWodxCpIjfvpweHHQzvPW7X
 KLwSSJt7cFih6PFYxPNAFb0RyWCrjFpuU4RE7gVaeO6/q9pP5AnjFgu4JCwDQx26jxf5
 EOoE8w+6hbyw+r3FKeA+m9m7wwL04lzqo8xiyPEkbjUFI89GXRl+9czDr4kODqnWs8ir
 h2Z6cTR9TpCa2oWYj65cBcNT/XVg2JCqLA4B55r7VgUcFV7m6YpryjL/fa9yRttWIujF
 x53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791711954; x=1792316754;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AvGhTKKdbU1GWyQfWY5VlojnPZ4MgvqmXbvuxJbcqHg=;
 b=Lu0PReNCNpvry2n+BiN35ZptXgzBLf/neBo08izq8zYJtT8y9wqNH2gUoUNVnz/zWD
 aiD9iMHL8qAhT+FhR1RD61FeEykkPIC9ZgLN914PDaPvJYas5JMHAXGTpi+rA3WCsQWu
 MtPzG5LrEMNKk+nGlx6x4NlE/cEIyIKBHRXOlFyhtz7RQSTohzRdpSBMue+g47UX41O/
 Ij4/TLNWOFV//ufn0wcMbco/NyDpTRwCjtgeErQ1hhxaiGmwsWckRxGcYtRMkL5TKt7p
 FJndbLU/TciW91v5iq3iSA46MiijOgw5YgCpzUMbIyFm42xhrGUdYi0cHR+LZk8DVLpv
 lL9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyNSTGCYsPloynGOO3qwRjswJ6xp+Cocnyp/Qi8fA48rWThmHsYZGaRtfrirAikPyC6iuL9Ffd0Wk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIHbaUwOHcJUTXnvtYkTJDzwumBinWWqifiNmtae0DjRSAHkUJG
 k7s2uUfWBpoj7ggDik5Ckhrj1qDHXBIuVy1paXj9Hwt+R5XToG7VklMg
X-Gm-Gg: AYBFou3bF/3z+78UtHv3tebkHpL9Zn0BVPqRDfW3UBQB1lUSD2iZIXgAwrSwStp7k5L
 3hikFxItxmAe9Ww5iXVXHiYSZVejOmuq1KEcAVGWyS/qSVr6eMa6sdMmaj61XwkXK1AY4McIKEA
 RTu/O0nfA1txt7ZwqL73USC8iWROE0czuInkxXCfFEzJf+Mdh5YVqRi5aJP8xfqTu/VKyh99NN5
 II77W3xHOBiROF6TeHAnMDj9H84L65mfMaTqTvBng98uJW5szmVPEjGl9Cm4ReE8hxyKSOgc+TX
 V9C5h2ITu7Vnp+i2K7+0m/I6LQl7gcasrroD5uC3lV2YM31zrRk1A4cuS7R3rbSBhHhj8YKDQUD
 COy2EeA2vO0ro31G4LZlnNMu8iy1oDm08NPeEMgrSqaAekbFzD1M+CL7WxgMyjHIJrNb4D/VVqF
 MED0iJpIEC4kJgPvLEKFvtVWBzSmTDJlOryJJj9qkvLBC95XxDwwDXCqcbRHy0G8tR1/w=
X-Received: by 2002:a17:902:ea05:b0:2dd:ad73:c93e with SMTP id
 d9443c01a7336-2e842abf8a8mr58037495ad.31.1791711953944; 
 Sun, 11 Oct 2026 02:45:53 -0700 (PDT)
Received: from [127.0.1.1] ([121.125.115.175])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422ba80asm31067695ad.63.2026.10.11.02.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 02:45:53 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH v2 0/2] drm/imagination: Switch the GPUVM to immediate mode
Date: Sun, 11 Oct 2026 18:45:31 +0900
Message-Id: <20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALtay2oC/32Oyw6CMBBFf8V07ShtVNCV/2FY9DGFMRZIC42G8
 O+2ELfu5kzuPbkzC+gJA7vtZuYxUqC+SyD2O6Zb2TUIZBIzUYgLLziHIXpohik6IOfQkBwRbIm
 yQqMFlpal5uDR0nu1PuqNw6SeqMesygklA4LystNtfhnvwFHQx98BWz8lWwpj7z/rwMiz8f+Wy
 KGAsxLXyliNJ1vdGyfpddC9Y/WyLF9T+9QI8gAAAA==
X-Change-ID: 20261011-pvr-gpuvm-immediate-f7ea8edc2e7f
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alexandru Dadu <alexandru.dadu@imgtec.com>, 
 Brajesh Gupta <brajesh.gupta@imgtec.com>, 
 Frank Binns <frank.binns@imgtec.com>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

Switch the GPUVM to immediate mode, as a prerequisite for asynchronous
VM_BIND. A revised VM_BIND series will follow separately; v1 [1] is
linked only for context.

The switch also fixes an issue Sashiko reported on [1]: the GPUVA lists
of other objects are updated without holding their reservations [2].

Based on drm-misc-fixes (depends on 196d4d10c1b3).

Tested on BeagleY-AI with lockdep, KASAN and failslab enabled:
- All IGT imagination tests pass, including pvr_vm_map [3].
- The fail-nth reproducer in patch 1 no longer warns.

[1] https://lore.kernel.org/r/20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com
[2] https://sashiko.dev/#/patchset/20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com?part=1
[3] https://lore.kernel.org/igt-dev/20260930125057.1837788-1-gye976@gmail.com/

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
Changes in v2:
- Patch 1: drain the vm_bo that fini() deferred when map_init() fails.
  (Sashiko)
- Link to v1: https://patch.msgid.link/20261011-pvr-gpuvm-immediate-v1-0-5b298dfce4f8@gmail.com

---
Gyeyoung Baek (2):
      drm/imagination: Switch the GPUVM to immediate mode
      drm/imagination: Stop locking reservations around map and unmap

 drivers/gpu/drm/imagination/pvr_vm.c | 82 +++++++++++++-----------------------
 1 file changed, 30 insertions(+), 52 deletions(-)
---
base-commit: 6ccf996a0dec1852dab94ad865f27b4904750e12
change-id: 20261011-pvr-gpuvm-immediate-f7ea8edc2e7f

Best regards,
--  
Gyeyoung Baek <gye976@gmail.com>

