Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17E606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zK4rzB9r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B45B112C51;
	Fri,  6 Nov 2026 09:18:54 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532DE10E939
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 06:04:36 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3ae1a9e187aso227647a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 22:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793858676; x=1794463476; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6JrtG29F6YmjX1if1HVP+LUFJxu86N0pKm/C06N0tvM=;
 b=zK4rzB9rhp3IEjcbtq2kbv2sJVRSB8SEIjdxmxQsq5Br34vzFSCEF9KYzbkHGmFeEk
 71jRVKjNt/KMKEpM+DY/0JDFz7L9jiQ+PtWW/q7CFF12o7wWVP3ANpp2djnZoW0m/GKr
 w0oCcCpsx0Ajx4vutYSeQjOyGMM4vCWLMcVd6/p0AJGVBDG4OQChSR6dzVz/Da5JsOcE
 eRcRT3nn37Il1UVuZmluOyRe2ygGTcFCMDk3ZX90lPYaG/ix2PmlDr9kF6RUSe714rI8
 b05PEdDXXnkz5wOw8Di2MEadUtj3fIxkzvBhiVDqVovhBqK+JRkPdtLQXTvK+Xvw0eow
 Osyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793858676; x=1794463476;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6JrtG29F6YmjX1if1HVP+LUFJxu86N0pKm/C06N0tvM=;
 b=MRN9aI+HMd1oM/Ry7r8oTINgbc4YjsYUk/lNnechtya8RP9QDEsYiTPadNB/WgyEbu
 0cGIf9RfFb8A+0w2D9CV4kFSE1VhFRh5HEUx+PZEA/CR+R1Fw+sQ6le+Owryn/3YNXOn
 ZVsZtvaxgZIwn+W/JRrxi5vf/DYOo6/acDPry6aXYdre0DC1lUpa6ldpylKwXXLUjCrx
 /Ff96S9qZ1hwfh7rEYOLL3sN6ZY9sLqUjEb2siMA0KdhvqsPAB3vJcZuly26j23xxcVM
 r+s0euS5NT/M/5In3sZkTgnb8jHUQS6JYrZMhujEMY9wQIrJgNL8SIuXn4ne6KvzW/L9
 1wmw==
X-Gm-Message-State: APuU4Z/Uq86pj0SRJ6qaMBhCaSRfzvGr5jPFWq4mzf/KD1dz2DpUOpxY
 cu67nD0OfE4KUZvQZ96Urr0nLbiXb3EtzTqaQKipHML8TzI4IU1InE6w
X-Gm-Gg: AYBFou3cxqrMjjhh1CwOzMK646rkAk+75pObXQfdT5KJsKBKusERSF6jiJV2j/l5FVd
 dC+YdgZNTdbTzn3kcPZMUrgzcTrGm4Yc2KlpdeT6KfWoYK+TicgtSqVEGC6TPi5qQz4VRGYSvyf
 5iUu/Ku5kkKSjWqdVltNNAoFKaz7w8z/PJ8/LH6rsHno6F2pUqqZvFp+HyO1yoyI/gqrmxJrKCy
 3mnfV1mCIVsRd7AHW5gXPoWTzaH7B4bVGPNaWije4LuMf77r7tkGqSpaz5VTk4BUkfBsbVtLsJ+
 wwt6Lh2rH1G4jQBJWuv36luCo/W//kbtt9V1UT1j/YoN1wuVT6cyaaMdhITHW/zxYH0SJv8FJ6b
 +IoATIML+lI64YZ9cKBXDgjnrdah/byju0FlmArtT5fZgTkDGKeb/DQt5woVuyD/lZK7HZUF4SU
 hDb5EamsEvNLscaISKEt8Wh/s81GmodEnZboNDCmfhcL4f56vB+qw6PKZeZMWVRGtIN8GcZtHpN
 smvjcZI7H5aZDGs1bmPqsRYgJGJtUlKzHGyuVyTOEzrc6Q8tmjruWz7mxTNwbbYl21F2RCmL11O
 0aISLKgM2qvgWjEtQApjUCQTfkb9cILtEeCAzCpmFQ==
X-Received: by 2002:a17:90b:28c7:b0:3a7:fef3:8561 with SMTP id
 98e67ed59e1d1-3ae89822b55mr26092371a91.5.1793858675639; 
 Wed, 04 Nov 2026 22:04:35 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b313c0dcsm2093100a91.1.2026.11.04.22.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 22:04:35 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, stable@vger.kernel.org,
 Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v2 0/2] i915: two teardown fixes (gen6 ppgtt ERR_PTR,
 OA config sysfs leak)
Date: Thu,  5 Nov 2026 14:04:20 +0800
Message-Id: <20261105060422.51848-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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

Two independent small fixes found by static analysis:

1/2: gen6_ppgtt_create() stored the result of gen6_alloc_top_pd()
     directly into ppgtt->base.pd; on failure the ERR_PTR stayed in the
     field and the async release worker crashed dereferencing it in
     gen6_ppgtt_free_pd().  v2 follows the local-variable pattern
     suggested by Ville: assign to the field only after validation, so
     it can only ever be NULL or a valid pointer, and
     gen6_ppgtt_free_pd() now bails out on a NULL pd.

2/2: i915_perf_add_config_ioctl() creates the dynamic sysfs entry
     before idr_alloc(); if idr_alloc() fails the error path frees the
     config without removing the sysfs entry, leaving attributes that
     point into freed memory (UAF read via the embedded show()
     callback).  Remove the group on that path, mirroring the remove
     ioctl's ordering.  Unchanged since v1.

Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v2:
  - 1/2: don't assign the error pointer into ppgtt->base.pd at all
  - 2/2: unchanged

v1: https://lore.kernel.org/r/20261104073311.1617823-1-lui2012qwq@gmail.com

Chengyu Liu (2):
  i915/gt: don't store ERR_PTR into ppgtt->base.pd on allocation failure
  i915/perf: remove sysfs entry if idr_alloc() fails in add_config

 drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 11 ++++++++---
 drivers/gpu/drm/i915/i915_perf.c     |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.25.1
