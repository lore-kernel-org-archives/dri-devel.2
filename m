Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056C6C54F4D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6393610E7D1;
	Tue, 28 Jul 2026 07:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O2wc/MYQ";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5064A10E4C8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 21:12:20 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so237819a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785186740; x=1785791540; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CvjIroWBUR46GpmdR10fQCd9PWHAMrSwKzxKCg+dB3Q=;
 b=O2wc/MYQi5grqulAFcxMK3iy373zejRA3+PMr9RBAaUAfY6ZN1K60if6DyCczdAsmq
 YjVJVPTKYVU7NQorLiSFAOk1kir9LgDYU8WuTafV1Ho64AeVtp41uAMGAHjVrshXzOih
 iOG54iOCpT/UvztUAS+TboL+kXsPS6cqIRSrcWJRwh1qiua6TBkBuGT3IvfILCnDRKKL
 L+ckErFsKgbramTuaqEaq3NoXhelR5k6fNVR4yiZfLpdoG52D0+4uU62jYcfg1twlrp+
 Q4U0KdP0lZOyOjx+Eyh/NHZzoWpVoP7sgzjrUp+iFxdlcMHYh7flUpgdWIqXy/hkvwG7
 iF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785186740; x=1785791540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CvjIroWBUR46GpmdR10fQCd9PWHAMrSwKzxKCg+dB3Q=;
 b=CO735K6rorSUx/UIklvLQk38EvUgyuLCOci3SK5w0fh95OeMLC5KASQ2c+p+CUrNZ+
 fWyI8oO2Zk+6kIFNnwDt+jFTSqOEaT6jfvRgUSVFnzXv6p+TMTwJc+cWtA6xhbeKO+oM
 7zzcGo4VjsmMrk12Ru6GwOMDNgR2FuJHdbyZKxnKGaAtYxAwyZyNHABOeHlCrV/Xb3hK
 8F5E/dVBfVG6N8Q1m3EdU72rvESpDOFX0/y4AincXV1gCIeiJeQ1LEB5VMx4XmTWc6Gq
 W9uveQD00jwIt7oL5mEehndIiQoKtcvz5PTHtHdNBEtKduYnPWx5gmoynQQ7RWJQoFHK
 Zrgg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9PpEru5xHbUPfSw9geQS0YZgpS6XPGhV7wf4657jf5aiXWhgFJb5J/sl/xSZxhGrxlFs1rLdYwFw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCCNFEczPTLuSiI61VSzoM+PRamm6+tI++VN2rCsRSuVDU8wyN
 09f7/BSgJrhvo0uMDLU7KVSRd7eTT1xZgzBd8+ZnjKsqLvDviQp//jLC
X-Gm-Gg: AR+sD11xqkIpY4kT01NNkD/EzCI3i585lRGo0Xt13+X0AMJ4XaWw+ZH3LAtt2AtT8kY
 mQvoXoU2ka2I0b8Bce1iT/mQAaMifUWfkgBGkCARNeUSa2WioiMn9Rt73qS5Oi7ONMENLFIQUOi
 eNUpMUDM7CNbwkbh67MyEVWeswK9NOhYLWGe/6myNlkwyqizaGNaUn6h23EJYOWDXHmDzMPuhbr
 3uLZW35yp9m2rcuwNcidzHXFW/Qk3WGqEGeyfB9OZ4ozPEP+cOIiw26I/wRW97auVE8BlELGDiK
 qLSp3HLhyYGJDjSUbLs7bXD/EFsbIBmGskZESydO+4rusP0KBpJp5nm/JsMLMEBRSbzVJkkjZNE
 HV65sHW0zM6qoEbYYz55mLERc6GZJuzExtlxlgcP4ZjCCb2SSG/2JCTfzXHxeePteTR/DpRE=
X-Received: by 2002:a05:6a20:7faa:b0:39b:bc11:9ec5 with SMTP id
 adf61e73a8af0-3c785785491mr424424637.13.1785186739724; 
 Mon, 27 Jul 2026 14:12:19 -0700 (PDT)
Received: from archd ([2601:640:8c00:a:1544:c19e:8a1c:4058])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e127asm58456645eec.2.2026.07.27.14.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 14:12:19 -0700 (PDT)
From: Daniel Pesic <danny.pesic@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Daniel Pesic <danny.pesic@gmail.com>
Subject: [PATCH 0/2] drm/gpuvm: avoid deferred cleanup on GpuVmBoAlloc drop
Date: Mon, 27 Jul 2026 07:11:19 -0700
Message-ID: <20260727141121.11975-1-danny.pesic@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

GpuVmBoAlloc::drop() (rust/kernel/drm/gpuvm/vm_bo.rs) currently releases
its drm_gpuvm_bo via drm_gpuvm_bo_put_deferred(), which exists to handle
destruction from contexts where the GEM's gpuva lock cannot be taken
synchronously. However, a GpuVmBoAlloc has a refcount of one and is
never added to the gem, extobj, or evict lists by construction.
Therefore, a GpuVmBoAlloc that is dropped without being consumed by
obtain() does not require a deferred put.

drm_gpuvm_bo_obtain_prealloc() currently handles this situation
internally, where it discards the losing preallocated drm_gpuvm_bo by
unlocking obj->gpuva.lock and calling
drm_gpuvm_bo_destroy_not_in_lists() directly, which skips the deferred
path.

This series lets GpuVmBoAlloc::drop() behave the same:

	1/2: exports drm_gpuvm_bo_destroy_not_in_lists() so it can be
	called from the Rust binding, and promotes its comment to
	kernel-doc.

	2/2: switches GpuVmBoAlloc::drop() to call it directly, and
	includes the safety argument for why its precondition holds.
	Drops the TODO left previously.

Note: there is currently no in-tree caller of GpuVm::obtain(), so the
drop path isn't currently exercised by an existing driver.

Daniel Pesic (2):
  drm/gpuvm: export drm_gpuvm_bo_destroy_not_in_lists()
  rust: drm: gpuvm: call drm_gpuvm_bo_destroy_not_in_lists() in Drop

 drivers/gpu/drm/drm_gpuvm.c    |  5 +++--
 include/drm/drm_gpuvm.h        |  2 ++
 rust/kernel/drm/gpuvm/vm_bo.rs | 10 +++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.55.0

