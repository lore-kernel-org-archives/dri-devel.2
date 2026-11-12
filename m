Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807AF606A337
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=M+fVD4ZQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4E110EBAF;
	Thu, 12 Nov 2026 17:12:21 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF4E711226B
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:12:15 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cdb9d5c1c8eso52937a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1794503535; x=1795108335; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZQNtd1ogtUf073Hn9VbhfcKkxE1DWp6VlKt/Boo33zg=;
 b=M+fVD4ZQrp9FJvmYpOjubK2Z9SlPW3pg7dUreigqfhZQKNczvl8vLNWW39XbYHvOOk
 Z7gXzpsxxs8+WYpJz/We4TyRRMFfuTpFX1Ld/WYqZa58Xr7lCG3g8figFaTKVjHgvzBF
 7ovsrTOOChz+cIDC9YXDEJolBX29h5skkcg6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503535; x=1795108335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZQNtd1ogtUf073Hn9VbhfcKkxE1DWp6VlKt/Boo33zg=;
 b=dUyg897nq5ANqCmzYg3dU4kbRmSOkygr9K9Tgs4vwGkdM2axtWmqoY0YOIIs8QBEJH
 Twa1An3DN7fdHehl9PRHjGSoVOKupIgwIUSKF6dDBkzsMg9rTnT8kXnX8cbcfe5VV4PT
 jPg/9V8ad9JiDHNeCIPRkO66MhJtJTijaIOPmAObkKItz8Xol6fjOKsqjimZlWFdnwky
 jqPVtsxs2M5py0/dD2fG/VDTh/BNNxq/RDdX71tC/w7o9A6Z6Awso5qCNKR2zKCx+w+B
 93HOOvcF5p34GfAIS7iiS2aKizeLr7RfHdgo6qey9wNwret/r3iQzIvTD7UoxZ2m4GIi
 5pZA==
X-Forwarded-Encrypted: i=1;
 AL+hErEVgl+VzZdncLjKEX+phnL3EtIGhOUQQUPAgsBx/kZNf3M5di/A9DGH+EBMePKK1FUXWLZ+RrNdLAQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/PgDIkO/7loibfm3o4FnX0YgPyM6LAMYyPUF69Zc9LoLdDaN5P
 AiQAjRPSihR0QO35khnshqknu605UrVzCOwjiI0RkmXl6E9aTrktwuUjFm3K4kRCN24=
X-Gm-Gg: AYBFou3oM8u1v9IN+EoMZK95xVuFYLr1fZkIJ1jtqwibIy9mDo2NQKZ/2ThVX9qd81n
 +6Ttdg9LWUA2XB00S57itNEt229a/+FDEcpyvuDXpXbIo0iDmzx6eoJicrxOYWMxJSyUc7szXIF
 +kWi1RgR7lESwc18QI3/eOmmUJheMU+80vgzLDpYQad4GipILiFmSwX8PkwjReNs5aRbgVVcAae
 r+Vpk8d4CdqAfHCAJ/c+lms4NICQ3ON1gDwsiEQdzURgAxHqJb3fGpwTVJLlalE2XG+VvUZN33W
 j+5rCoHapqDda5SrAXB9hMDLWlNARLXv70pYGJzkemRPDORN9wJnlRuBD3iS73SHe1CGx8PeS4m
 nYlpMYYzSoudi48bSi2BaCDEGPB6icn0Pz43ydF+zqyjAtn4kCvLT57VJSgB2Y1p7bRczwjBuYr
 NNW5OGRaQMHIGkfI0eUBHZR7CR6NuSpcnAkwNacrpGcZr2mvWI7mg7CKHo9Mem9GGiU+0sFS7ko
 VjHcUOQ2Rl+3cdRW8oTDrXVfFHRShpRhizGFfI0fjiNq/XuXTM6LwTQtmM3TyTL5EZpszGgDIj1
 PuOjpl/C9OXvNnqB2TqJg8IxJCaiNw4U+ILY6dwosv5wjbzDBreOvS76ICyAW7Ovh1pLq/MFzm6
 SJ/7+pUNh9Jqt
X-Received: by 2002:a17:90b:1c01:b0:3b0:9a2e:b491 with SMTP id
 98e67ed59e1d1-3b182f8c3e4mr5361131a91.66.1794503535321; 
 Thu, 12 Nov 2026 09:12:15 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1ae981c55sm263682a91.1.2026.11.12.09.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:12:14 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, ckoenig.leichtzumerken@gmail.com
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, mcanal@igalia.com,
 Heiko Stuebner <heiko@sntech.de>, Gyeyoung Baek <gye976@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH v5 0/2] accel/rocket: Report NPU usage through fdinfo
Date: Fri, 13 Nov 2026 02:11:42 +0900
Message-ID: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Report how much of the NPU each client uses through fdinfo. Patch 1
exports the runtime the scheduler already accounts per entity, and patch
2 uses it for rocket's drm-engine-npu key.

v5: Use the entity runtime from the new drm_sched_entity_get_runtime()
    instead of a counter in rocket (Tvrtko Ursulin). Reviewed-by tags
    are not carried as the accounting changed. Based on drm-misc-next.
v4: Single drm-engine-npu key with drm-engine-capacity-npu, and
    documentation (Tomeu Vizoso).
v3: Add a rocket_engine_usage_create() helper (Gyeyoung Baek).
v2: Size the per-core counters by rdev->max_cores.

Link to v4: https://lore.kernel.org/all/20261103155338.1949294-1-sidong.yang@furiosa.ai/
Link to v3: https://lore.kernel.org/all/20261103104804.1887489-1-sidong.yang@furiosa.ai/
Link to v2: https://lore.kernel.org/all/20261101152723.1430312-1-sidong.yang@furiosa.ai/
Link to v1: https://lore.kernel.org/all/20261031083642.1076356-1-sidong.yang@furiosa.ai/

Sidong Yang (2):
  drm/sched: Add drm_sched_entity_get_runtime()
  accel/rocket: Report NPU usage through fdinfo

 Documentation/accel/rocket/index.rst     | 28 ++++++++++++++++++++++++
 Documentation/gpu/drm-usage-stats.rst    |  1 +
 drivers/accel/rocket/rocket_drv.c        | 21 +++++++++++++++++-
 drivers/gpu/drm/scheduler/sched_entity.c | 25 +++++++++++++++++++++
 include/drm/gpu_scheduler.h              |  1 +
 5 files changed, 75 insertions(+), 1 deletion(-)


base-commit: 7678b7f2d38b5575981b1a7c09139a4660b66826
-- 
2.53.0

