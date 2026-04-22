Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5155FF94CDE
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E1D110E889;
	Wed, 22 Apr 2026 08:26:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="bdFQKL01";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022DF10EDFD
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:40:18 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12c45281a06so6550640c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1776818418; x=1777423218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1/I+pZwMOrzhrEepnB/LVQxD8E3WFxc/6DwgKc4sW9c=;
 b=bdFQKL01JcTq1M/RviuyOHHIj/oQgo6MBPvQVYT7GU64h5430Ugpqm4gKdGmLI4itw
 /iRFzl1Zq3zSf4BNKEn6HzhoImMgCH0+za7fmRvwWcld6CK5whY7SQc0DdgqrukbJwuk
 7SJABbh0UTUKiv0MAF/rBxeDCVxhr3iYZT9O6qyOdpRQHIfJV4gug40ZC9WUXmIgCUqr
 vkAQholQnxaPp0jiQCatoRuu16SG6DT6QOUPyDpBEgCEMwzjVl+MBNuY/LcqvV6pUynZ
 39j+P4PEu2HNKNS/Ki4sonU07iOwBswmM31A5CvctN6yLEEebUoT1oayFnApuu6nBS3y
 PmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776818418; x=1777423218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/I+pZwMOrzhrEepnB/LVQxD8E3WFxc/6DwgKc4sW9c=;
 b=JhBH7Tiq76ghgiJuhOdHrfLG9mIMWPrtnHgDLpfEcL4VxOGHbx3FeQStFdVF29AmI+
 KnumCstTqas3eN8MbO8mra0bQcOo6RR/QiDENIIKlC5AwEpN1uQ+OgsgUJyRAVX8oZJs
 deeimCUJiK/oZJ95TkRL9O65GBSSaSaXBsP+gTr5SXL1BymnErDVha8+Z59j54OXfdgX
 ctMJ0BXnHoGdRpy8XsaF+7d+KWFjRaJKiJY5DINUQ7naYlXum9AwttCQswk/TxFXf6yT
 8RgkCO8mRC402azGu+jLlg7Dvra5KAnWEvkMSPsZkNhIWlax4BX0oKxWcz+mJpOGdPo7
 nQWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hsAGkCqgfsAAf80DvZUecV76MBMehJqwkFMhUC0CELFSYEJkwrY7w45QIYzuFJU4uWlu28nL2Ky0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVH9AUQtKOTMVjmlB/y/Sg7IAslTw6tnQsxqx/pAq/Bjgrqs5E
 UDdDLEGaMySSvKZ5x0ywORRCxqEs8R0eqUEdaOqrD3cw67N1B2RerWe0Cpy/w1XXisM=
X-Gm-Gg: AeBDieuqu2RQa1XCxuO9368w9q7M9PN7UzKcDf/hg92xrY+JTAr0FMfkaE0+vQjTIgK
 ao0aLAayFhCcUqam+8N5EEUnB8Niej3pfztqOJkRyc5DVjNTS1Y14HfQKXdXU+LRyXy47mVwyCT
 V5dcg6QCXEAOQMxQOtwOavZ933q19nP69C3cAhtm26HRdzb02oOcEObgdTFxt7Mjtew7i1RVqVQ
 4K+5z2MXJTKcQrBZ3wzH1ei3+8RKwxgszaa+Y1MjlJ4y0o3RN6rmhG1zOJf05SYBZMsXPfTm5zw
 WCr+Oqt548KtSj4oRpAFZgtbhiKtIdG95RrLzvpAlsqd9466xVClpF/IYnBgJUB8JMWcKYKtW1V
 3ZnZNq1ZnEO72Xk+3Xe4oi9BVLctMM+JEjzBWLHTPmbk3hypAPiQ6l62RHRB1RukxF5RUBOqPnY
 b309zlCwY+gDthjb7TdOMgvk0TYeFkbTZkWJ92QyXz3RJh8fIMrTXaELoBApWIjUuWBTr7UMd9n
 MWQlPEPwdWX2CVfQ9WjtkOKvvT1bg==
X-Received: by 2002:a05:7022:6606:b0:128:bae0:e044 with SMTP id
 a92af1059eb24-12c73fc621dmr10332983c88.30.1776818417739; 
 Tue, 21 Apr 2026 17:40:17 -0700 (PDT)
Received: from voyager.. ([191.251.25.148]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dbaab165bsm552462c88.6.2026.04.21.17.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 17:40:17 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 simona@ffwll.ch
Cc: luiz.f.f.fernandes@usp.br, Tiago Dourado <tiagodourado@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm/amdgpu/jpeg: deduplicate process_interrupt across
 JPEG versions
Date: Tue, 21 Apr 2026 21:38:43 -0300
Message-ID: <20260422003911.33841-1-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 08:26:51 +0000
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

The JPEG versions v3_0 and v5_3_0 have process_interrupt implementations identical to their predecessor versions (v2_0, v5_0_0 respectively). This patchset removes these duplicates by exporting the original functions and reusing them via macro aliases.

Tiago Dourado (2):
  drm/amdgpu/jpeg: deduplicate jpeg_v3_0 process_interrupt
  drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0 process_interrupt

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 21 ++-------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 22 +++-------------------
 6 files changed, 15 insertions(+), 40 deletions(-)

-- 
2.43.0

