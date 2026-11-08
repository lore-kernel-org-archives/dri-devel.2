Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64F6082BE4
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XipwP3AK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 892DE10EF97;
	Mon,  9 Nov 2026 09:31:35 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC48F10E777
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:58:09 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso518297eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 23:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794124689; x=1794729489; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zgeza4WC3yHtTC4XeH+C9X3JS6p9k1oxyKbAx3haHms=;
 b=XipwP3AKuoDK1hJ7TFujbRXnhN2IzDJrUa+D0D1QjXqnvfbZuWQWxIZn5SIk8gKGuy
 q5bdehqtRQjYCc7iTClF6bI0T+RqBKNWkF/jPrxrhRff6IORui0yBFVb/I6poLkssi6w
 V9qKO8vWC5x7brfk/7/19GnCn48gEkWo5Q5F6n8fj7jciA5NDQtdxLhMP82O+3EsfUR1
 zF9Ou3rMmUunfCYzhGAi1WybNc567KWQFpskjoYN1mHW9n+8W5fDOom+I/ht+PuJqNuX
 7eHoJO/EWd0iY4OjQfansIVT0fTta7MlOxb4p0m/owMuE2tOl90/nuLyu3joctazoA96
 vOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794124689; x=1794729489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zgeza4WC3yHtTC4XeH+C9X3JS6p9k1oxyKbAx3haHms=;
 b=wovGtJ4eSDwHcuyxw4GWnqgb1lmKnolk9B5n950NcbyG88ypLhUTKyBWcmcJoIEO2u
 dx1jVJrYYZWy3ktqEtI2TU4T8kmE/pdJDk3zEB5he01wSOtSuY9Q5qKOLGqvWjmPTFOt
 JVMnKAXcLhFgQBqL0A4Yxw2Sakql4b0au2g6X1jPqf10YXHiYQLynqlq+7yFoX9gcOq9
 Z+iK3ZQQRi63JBM7iHNoIq0nj41/oaR+pqqZQ9N9qiGxpziSPg+x/IWpi2E04z36eZRp
 d74q3/MZBsDCJgDc6D2tLfOV9/OgWAOVcGsvfI8rzdMDH31ZT+hKqGZwltCDLTOtJvK1
 5Jcw==
X-Forwarded-Encrypted: i=1;
 AL+hErHfEx0F7/bxpAW/9sTTGJYi3bDxqiTJzP0c95/AyqasS2R0rLpph8gsSLVtP/eRSVTF+fDMuIyP3B8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8bJmO4ftuJbFdFistdIsng2fST2PjZORr/HVwPIIXQsPnj0CSZ
 caeCd4uLI0s41qpF2U5BOonCkOS/P50Y+YNBu5LrPQncqvHNqQtx5Mup
X-Gm-Gg: AYBFou0tE4of45MsTR4avZx57reYKG218pSyNkoLsCr6s9sEQ6ar/4cTXHThDRJe/uh
 wZ3CajOAR3+B9+DiaDgv2rZDfK8gJxcF43PtV1L9xvgaaVvXubo3jLZUEusubI0qG5Pb074MwNc
 do4V8+0+i99n2HnaFVMJGWxNhIkyNcib9o4eN16OmPicFbHPJ1haWZUZtpDSAX0fysuOefqCB4G
 a545oztlEbJCunm/6rolLnZHzk2nY7NGdcd5fC616yxftCvppmjpUPF/hDJABa7h5F7j23RXgV+
 CNMq7DoiLTIgE9NxMOXw0UQXIAuTZh8zARnXvLXBXw+dy5KSXB7pHSwdAn/aAgBLK1Mb2LG5Tdp
 hsEUqF6L1LrrjTjyNeeg6T4oQJmi4kLnwVyueMV/tNYwy8pZbfDZ5bU/VGro2RtpbxOmxBvL3ve
 U7lZXYKXUdSw02I1OdmXXD7CCdGfV2tbXpMbSdvYQj0vsSmztatm8jyOxq09wm72FyJZ8NBdPz/
 NsbH5sqHG+RII6mp+tFYD85os4k899FDab0IG3KJI1mF/anrGHcNiyqjIiQguhhTKYYA4Wlwi5K
 k27DrwOttuDRJq2knLaKxGM+Qz+06cDb2dqoTUBqk2wr1NLYTzKiVNH4GdV6qEZ4dvtvJSteaBH
 7kfa6pgLSw/6rxSoKOn8u6UYpuQ==
X-Received: by 2002:a05:7300:6822:b0:369:9af5:7bc9 with SMTP id
 5a478bee46e88-37256bf17efmr2190444eec.23.1794124688659; 
 Sat, 07 Nov 2026 23:58:08 -0800 (PST)
Received: from localhost.localdomain ([2406:b400:d4:acc8:a024:59b8:c312:eefd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372660f385bsm3866093eec.20.2026.11.07.23.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 23:58:08 -0800 (PST)
From: Torra Sowmya <sowmyatorra@gmail.com>
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 outreachy@lists.linux.dev, rostedt@goodmis.org, julianbraha@gmail.com,
 julia.lawall@inria.fr
Subject: [PATCH v4] drm/xe: Remove unused xe_vm_restart and xe_vma_flush
 tracepoints
Date: Sun,  8 Nov 2026 13:23:35 +0530
Message-ID: <20261108075335.13248-1-sowmyatorra@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108060418.4554-1-sowmyatorra@gmail.com>
References: <20261108060418.4554-1-sowmyatorra@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit f3e9b1f43458 ("drm/xe: Remove async worker and rework sync
binds") removed the calls to trace_xe_vm_restart() and
trace_xe_vma_flush(), but left both event definitions behind.

Remove the unused definitions from xe_trace_bo.h to avoid
generating code and data for events with no remaining callers.

With the tested x86-64 configuration, size reports a reduction of
888 bytes in xe_trace_bo.o, from 20262 to 19374 bytes: 296 bytes
in text and 592 bytes in data.

Fixes: f3e9b1f43458 ("drm/xe: Remove async worker and rework sync binds")
Signed-off-by: Torra Sowmya <sowmyatorra@gmail.com>
---
Changes in v4:
- Combine the xe_vm_restart and xe_vma_flush removals as requested
  by Steven. This replaces the separate patches for these events.
- Report the measured combined object-size reduction.

Changes in v3:
- Add the Fixes tag.

Changes in v2:
- Document the measured object-size reduction.

 drivers/gpu/drm/xe/xe_trace_bo.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
index 86323cf3be2c..a6802f6d3a01 100644
--- a/drivers/gpu/drm/xe/xe_trace_bo.h
+++ b/drivers/gpu/drm/xe/xe_trace_bo.h
@@ -115,11 +115,6 @@ DECLARE_EVENT_CLASS(xe_vma,
 			      __entry->end, __entry->ptr)
 )
 
-DEFINE_EVENT(xe_vma, xe_vma_flush,
-	     TP_PROTO(struct xe_vma *vma),
-	     TP_ARGS(vma)
-);
-
 DEFINE_EVENT(xe_vma, xe_vma_pagefault,
 	     TP_PROTO(struct xe_vma *vma),
 	     TP_ARGS(vma)
@@ -228,11 +223,6 @@ DEFINE_EVENT(xe_vm, xe_vm_cpu_bind,
 	     TP_ARGS(vm)
 );
 
-DEFINE_EVENT(xe_vm, xe_vm_restart,
-	     TP_PROTO(struct xe_vm *vm),
-	     TP_ARGS(vm)
-);
-
 DEFINE_EVENT(xe_vm, xe_vm_rebind_worker_enter,
 	     TP_PROTO(struct xe_vm *vm),
 	     TP_ARGS(vm)
-- 
2.47.3

