Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBCDC43638
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDBC810EB45;
	Tue, 30 Jun 2026 07:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bReqqF0/";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DAC210E8E3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:28:49 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493a548fc99so7178415e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782746928; x=1783351728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HFhwRQO/XnDqnsNCNRMiUIQQuhF/q4kw4HCjqPfc1vw=;
 b=bReqqF0/CtTYtcKbjZyeVugl+OjTwLWqr+CVLT0pT2XsoQSXXXmPF5eKKYfF+/7xNZ
 4I0knfqB2hk4o1bVaPGs0HLe8GgflvhqkeR0P8qOKwpYdYIVY51m9h4lyCT093xhULj0
 h97TDH/yc97CtrwbbrGIN392jJS6cr/tK3Xx9qm3c8juJDQkw9n9VEcg2+q3Md8wvf78
 ADS7G5/i5OpriPPXZYqSFE4CJ7XT8G7cVbyvb1e6GT7N89C8EecgqzMGtVHqLmY70vVF
 metLevno1pQMO7Gt+5Up+8Jnmj5rlonCQTbGGsKJoO4KTGDe86cS6D11l5cdzAHFtlSr
 1hQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782746928; x=1783351728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFhwRQO/XnDqnsNCNRMiUIQQuhF/q4kw4HCjqPfc1vw=;
 b=stqlOof8WgBPdcFqCWBlzRlVowfh1U2ksb0TeZ8Y0OlN+Ll3Leq4lvYOD7oVRNTl9o
 YTuP4ld97JuN38osp3ftvZWURYPxobrdjI02Z2p4Ua0jBKzNUDq2C7KmT0/jMQvwrIQp
 tyr+BlwJZsyZwkYZEFA1gCxTxrNGdxvGWJNi8Zo3KjXLXRCPSv9BgVaopzUzBeFyVy2y
 CBwg4FdEXAmLevwSKH//TpMEkv5k5ub9CdipVHk9n+jlzd26S9O4YhWDiStUNf2boD1F
 yY392f0y2jWKuo8r3zbMNAHO7rCcWlO9Nub5wCNQuXQgwLkPMXG0+qlq1+oEdJ1wUrio
 /CGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SCVm7Mf6M4TwYYMBQ1eE8w6qnZkjWZlf0881/bF8plUigxx1G9ULjxDW5uiV323CVtLkJFtifZcQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxE5njWkwar5gU16gXr+L5B8LZzC22j/NNBhmv0O2M4SyjrjS0K
 hS6d7Q0XyvaKQO4P23AHxrSN8VnloJzY75tZSQylCxCo569cP7y4ARtR
X-Gm-Gg: AfdE7cljmGviiJYjymBJfuugSB+linrUcXXwAeNZ4yMduyUT2PNfw0F+PR5NpZmVRNw
 s95Ad0UnTWOFc9EKxhOmYAUhzlqEHP2bzFEv6D6hWcIhWaZvGcquyYJ2+0f/NRomEBK48xG1iD1
 iuHBJtyRRU2J1h5Uczeb2Dc+AKv9DHsBKN9PLXWME8g+PenJw66ERx4eQ1DnTZYnajYRI//nlbN
 TmzV0f9ZLCgFMFhoRWcKwo1B2PKqNwcdTGfsZDoJa+lFP4b1MhONO6MsPalP6G88TKWG4XdicN5
 AgZb0Y31FIe6FB8RpPWFpSzf1tnTCo0PY9j+TfjY7lWPaguvmwL571RXp1bEgCNdc/97w9xeC74
 SDndyyT1y7dlT9bFq+3x3rL3s3WHYSmPqCZG/PSSjqWoLNOllntxFZujT/VAlktJfyFHMOEGxSr
 +3QyusEgi/OKOBMI/0K2o3oF6LMg==
X-Received: by 2002:a7b:cd96:0:b0:490:6237:5200 with SMTP id
 5b1f17b1804b1-493b828c480mr1572865e9.10.1782746927577; 
 Mon, 29 Jun 2026 08:28:47 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268f700c0sm371321555e9.0.2026.06.29.08.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:28:46 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v3] drm/amdgpu: reject mapping info when BO VA is gone
Date: Mon, 29 Jun 2026 17:28:07 +0200
Message-ID: <20260629152807.13492-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the GEM object before taking
the object and VM locks. The object reference keeps the BO alive, but a
concurrent handle close can remove the per-file BO VA before
amdgpu_vm_bo_find() runs.

The mapping-list walks then dereference the NULL BO VA. Return -EINVAL
when the BO is no longer associated with the VM.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v3:
- Generate a clean patch against drm-misc-next instead of stacking on v1.
- Keep only the intended !bo_va guard for the handle-close race.
- Clarify the v2 withdrawal confusion in thread replies.

Changes in v2:
- Describe the handle-close race instead of an initially unmapped BO.
- Return -EINVAL instead of -ENOENT.

 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 27be5083f2af..83ec994ad36b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		struct drm_amdgpu_gem_vm_entry *vm_entries;
 		struct amdgpu_bo_va_mapping *mapping;
 		int num_mappings = 0;
+
+		if (!bo_va) {
+			r = -EINVAL;
+			goto out_exec;
+		}
+
 		/*
 		 * num_entries is set as an input to the size of the user-allocated array of
 		 * drm_amdgpu_gem_vm_entry stored at args->value.
-- 
2.54.0
