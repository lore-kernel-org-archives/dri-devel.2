Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588F2CD4F3E
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 10:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66DE10E0EE;
	Thu, 14 May 2026 10:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="SSKmkPjx";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD8710E3BC
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:38:26 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so77422855e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778755105; x=1779359905; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xH2MsNAwWrhYQsE2/lBrkUnmS1ax7tifBlnFAGvQnY4=;
 b=SSKmkPjxM5h3RJgqZ1100XxdkiWk/v9xm+9elZc1pDtNr7yJdSnk36cpQG63qRaf+E
 m2Rcg5+QXkTkf42CsqiV7T+1y2EZCD6O1xgGvw8qro+BT9OtIj1kUDwmgjM15WU2RiIz
 ihvsGzTov7vrM3OM8x1zNBfu4NWeC7oEgqQedjuTbcMukahZu3/rJYxJKL56qA9BlJgX
 143AlW5PZHStMbLwBP6d1sSHmobNkqZdFIe+AQw9Q8DS1d6X6/Cdss9fBenXfSHAz/LQ
 rSaxO59iFMf+SHoyK8QRdPEQFSddzWquSppvzEy57672XlebQV2W1Xoht+ngoAy8nR1g
 KUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778755105; x=1779359905;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xH2MsNAwWrhYQsE2/lBrkUnmS1ax7tifBlnFAGvQnY4=;
 b=Yw6UmpXNMfPxJ6AO5lSbk2x4EiXjjqT+q/dDSgipXWLaZhGwDbK63Oj/XEI+mUgwP4
 A3F+6wu8sfikvRk+tKpprEfyDFu+ekJ5njVKzo6cea+BcWY5/EMl1ApHlk3da403u3Md
 qftuiJOfiPue0cgP9ltqDoXEWzypWuxLeRK1/drjACk4HxWw9j7s0OkXsn8c0ZyEQHs6
 gqZyKYnrVUqzlJnxj6KKtLFW0sme1GZe1bjPawo4XlIPM0BPuXgipacxdKsLP3QJXCBr
 czJGdWXCmsnS7BiWE8ACdx+nGuMSipJs5bA4hhRq7/GeUBUhqYTx8ThSHvRc/hHNLfX/
 NXHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ99fyhrP04v7yL3s3LQeOrzdXnBsOEnw2+Fo6iLeqv8F8ycBGmGMJmTsoiEeza79MHQK0gLtNgWzmc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzO+LI1JsLg0gALJaTku7GWd6cBePvQhABj268K28EhPiEvSpex
 GucxXXMvTwvcv5U1UVH8p4VlFOeKJrT8kwLJ8ct90MPsrl7ICHod9bKdi23oZzIKoE0=
X-Gm-Gg: Acq92OFQG/lJKlu4sMxiX1uuTkme99/3YIqxQB/MnbOjxRo3kb0THoU90I/nkfc02s9
 jG5BTLaewK7O9uset+WCykpFCpO6fiJ3VmiFywzyS5n6AaofikWhixwpPCUExFXb0kwr7uWNnWd
 G3iilYwcrLztFGu42ut3Sp3YV1/SFAgahaNku7lgMyI27yPruZQlYPXAIJKbDKlo71/Romhg4U4
 fiwZw7WUQQHtaTxdrHsnzXAVsw4WhaSzrQumI3iGiKJ8Xvi4u2a8UjPThOXdF0R4IcjCjnRyc9I
 AOORBn+PsFhbFOidBDkbJH4066lvnQ4MUerXW9wsacX5FAz/11/kBWahwevsjAhjL6Awwi31pE5
 lKwLjMNQxtWmpNVaCJhdOQ24x5h+F+qVP5eIV6bB4HkxdpIqAN9zwv0yfoJMAKDFPJuGefOFa67
 G0QZx+1hn3vnwn0JZBfoXotvAsUN8SQy5Om0rbPQUXQ7gD/P8=
X-Received: by 2002:a05:600c:37ce:b0:48e:62ec:f264 with SMTP id
 5b1f17b1804b1-48fc9a30cfamr126340005e9.17.1778755104690; 
 Thu, 14 May 2026 03:38:24 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64e2132sm57788365e9.15.2026.05.14.03.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 03:38:24 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <ray.wu@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/2] drm/amd: Replace system_unbound_wq with system_dfl_wq
Date: Thu, 14 May 2026 12:38:07 +0200
Message-ID: <20260514103815.190628-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
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

Hello,

Months ago we started a refactoring work about workqueue, still ongoing.
Recent changes in drm/amd/ code still uses the old workqueue names instead
of the newer added. This series addresses this, without introducing
change of behavior.

=== Changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

Replace system_unbound_wq with system_dfl_wq, without change of behavior.
system_unbound_wq will be removed in a future release cycle.


Thanks!

Marco Crivellari (2):
  drm/amd/display: Replace use of system_unbound_wq with system_dfl_wq
  drm/amdgpu: Replace use of system_unbound_wq with system_dfl_wq

 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c      | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.54.0

