Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33AAC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507C910F269;
	Thu, 13 Aug 2026 09:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rf5rRA78";
	dkim-atps=neutral
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ABFB10E3F9
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 11:37:57 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-39f927721f2so6606531fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786534675; x=1787139475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vcy0V4sanVWnhAv8P2awTDxn202Hp42bIgbbeqoNGH0=;
 b=rf5rRA78ZLTGWBB2OGPoB/gUOuzxedSgrvhJpybzaNvlFLVvLdOCMnZ2ssbU3u+0Mf
 ieYKad5NAIpYh76wbjrztRi7dWPfFFVm7uq/c8O4CfCANOmi4lktavXeOSMti163SvqX
 TUBuMMEs8tR+uHpYm7iu/MJSkMzOuieJmyEeTurWQB/2Dv31iw0SuWt/UGAgrVmzulM/
 35woYxH/sEgDAc4fhhO62jbwtdFAoiGyBkPhUviz3ilYnvoWxu4FO3KiutSbbX6IoJyu
 NqI03BikWwrXlYzhSwXj4rIPcIN1PnttECELtHIEecv0/1nbBRWEKFf1DdRik9Gy4zlz
 h3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786534675; x=1787139475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vcy0V4sanVWnhAv8P2awTDxn202Hp42bIgbbeqoNGH0=;
 b=d6NtLXIoK0j64Nx/AfqlNuJrRtrE2i1fSiPFznmHBHwMPEZMyySGiwuiFnVyGHI+Ii
 LSLM6o8o3BwVi6kbeJeJdntQpZSrJXM6NKx1s36TTNAyxw8a/uvMyzjYfzc93MT0l3RT
 Sx2vIpPLAZY3wKb+7oIbM876+z0z2m4WjC97dApBObb7S9TwAIfyC/+9fYelBrDuhmD+
 niDP/vrFvQTMTe9Th68dRdnBbat20vOB0KeEYikKzNIlDGIRpvFf/Ev/pmcOIFwgAknM
 uWeJj4wPjXOGI7M7YQ/rj07oDczdQTMmjY7R9KsgUX2ip0vUpuEIlwe2EFyY3+TEm0om
 UAlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXnfQOLviqx0K/Euehrslalgd0TCIroZSw3DMYGPvp7GCcfoBbpZZUr8/EWTmLjoN44gZr4OljS/U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLW+aiJT0pB2OUe6NehQjILMW7cjRxAQCytdeoTPV2o0DZxDEW
 8oDzVGgTywC3Ws+m7yeK0d9D28iyZ/wS6fBmECkoGljXf6JlLrN3SoAU
X-Gm-Gg: AR+sD13/xdotdGTqWA9p+Os/n/KaPrUfxGFcosZ5rcpE226QJWZmPUQnYksS/4ovqUY
 5aJbNjUYa72NaezpqhZQBC3S3M8t7veeXDwHBUr+yne3SVYGAyV27iHYaPPdqTa9EZ4ZzP9CF+L
 5xNVkzdR62T5iSmviak3Te8QrtbCGeHvOblwVI2ZsRtzjMy7RBaEQAdVyuiJ1mRfp0saWkkeCih
 z/iEajSUXnEmBb0buEM9LMtJKBlhup82gTImXOcB+pXVCP1D0tqVRjjnqHM8/UCB6q6SBsiZy7e
 URqdU3zxAduXfDTaSrNGmqlg6RXM9t0rsZP6tkQGiYiybFEyEEHBYZ0KsM8uNkzssGoEL164dT8
 vSUdverdb3ypYNjTg76jQQ2PGB6kbpMkD0paQBB1WV69s9ctn7qeW2t8ucEhYDi8DhvTHcpaDhA
 POQGG791zErIeciBCnIzy37L4FJ6Ukc5kPMX2m9D3dPPiexOGcOOwdGGYLqh/1bcbTzn7weMleM
 m9sn7s=
X-Received: by 2002:a05:651c:2121:b0:3a1:476:74b3 with SMTP id
 38308e7fff4ca-3a10d4aa3e3mr4393061fa.9.1786534674956; 
 Wed, 12 Aug 2026 04:37:54 -0700 (PDT)
Received: from localhost ([176.210.177.198]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1082d11b9sm3881101fa.33.2026.08.12.04.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 04:37:54 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: aliceryhl@google.com, ttabi@nvidia.com, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH 0/2] gpu: nova-core: retain the GSP-RM log buffers
Date: Wed, 12 Aug 2026 18:37:50 +0700
Message-ID: <20260812113752.532537-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

The GSP-RM log buffers are exposed through debugfs, but the entries are
owned by the Gpu that probe() builds, and the buffers themselves are DMA
allocations that cannot outlive the device. They are therefore gone as
soon as the GPU is unbound, and in particular as soon as probe() fails -
which is the case todo.rst singled out ("even after failure to probe the
driver"), and the one where a GSP log is worth having.

Patch 1 adds CONFIG_NOVA_CORE_KEEP_GSP_LOGS: when the log buffers are
dropped, whatever the GSP wrote is copied into memory owned by the
module and exposed under a "retained" directory until the module is
unloaded. Patch 2 drops the now completed task from todo.rst.

nouveau has the same feature behind its keep_gsp_logging module
parameter. It recreates the entries under the name of the GPU that just
went away, which collides with that GPU coming back; the "retained"
directory here avoids that.

Tested on a GB203 (RTX 5080), which the driver probes successfully:

  - after an unbind, retained/<BDF>/{loginit,logintr,logrm} hold the
    contents the live entries had;
  - with a failure injected after the GSP has booted, probe() fails and
    the logs of that attempt are still readable;
  - binding the GPU again does not disturb the copies, and unbinding it
    a second time replaces them;
  - the copies are released on module unload, with nothing left behind;
  - with the option off, the entries disappear on unbind as before.

Built and checked with CLIPPY=1 and rustfmtcheck for both settings of
the new option.

The testing was done on top of e6c2c6265521 ("rust: firmware: add
request_into_buf()"), that is, before the TLV firmware series, because
the nvidia/*/gsp/*.tlv images are not in linux-firmware yet and the
driver therefore cannot load firmware at the current tip. The series
applies and builds unchanged on top of drm-rust-next.

Vladislav Zaharov (2):
  gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind
  Documentation: nova: remove completed GSP log buffer task

 Documentation/gpu/nova/core/todo.rst |  12 ---
 drivers/gpu/nova-core/Kconfig        |  18 ++++
 drivers/gpu/nova-core/gsp.rs         | 146 +++++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs   |  19 ++++
 4 files changed, 183 insertions(+), 12 deletions(-)

-- 
2.55.0

