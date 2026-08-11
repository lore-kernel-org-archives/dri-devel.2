Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD223C5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C3310EE7B;
	Wed, 12 Aug 2026 07:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XDXY78ts";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0866A10E240
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:47:22 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so3248279a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786438041; x=1787042841; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FHAeoyo5cMJf1W0mZYzZjfd/SrG8usIZS6fsxweLRlk=;
 b=XDXY78tsSuCB3bE+Xe4roT083L/eKnhgGnAvHaDyIduGcjNWwtRM27YDfmRLf6bKy/
 5XyBIQhAdi8YMu+QR5ng4vruv+2ouq6qR4BKBXZz9NNiSnEDttXGKZN8hbKcI5ptpT8s
 4JdDf6mG1B4UFUOS7zA/Voa3mgDOhtoQvEA9nhkW9MP6cW9DDch/OGX0khi9bRUH1Ba/
 8WjzN2u92CGoNRFz4v7kcpAp7FgeBHq0L2GCHCGep7Lf0UktY+0xRmDxOHnyCn7whn/k
 TgtRlL55YlfTcaJDuOc6IsrvFvwTG/BPYR2tg3ZCHfdAZK96ADz1cJKhoxUw/15+MyZc
 3+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786438041; x=1787042841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FHAeoyo5cMJf1W0mZYzZjfd/SrG8usIZS6fsxweLRlk=;
 b=s9BUe4BGgDzPz4+y888IC7EcmX+j1aUIS7O1jnjwppc8qMRO/ELD+x0Mx0ggfsVGbi
 WSl0ynq0jDO1YYkCdJYmPxwl/Wk7k6MVhEKKEc3DVHtVWG6HdbrCEFneBej+z8BhBcaE
 tJjP5aab9S9GYCHWp3nnylZKMXTPu9BJe5ohcIIuS6b9muZSu1EHE6HuEXc1XOO7V+Mh
 HqRvyl7QXwo8l2RclWAVqu3ZiAqS35xQFoN3VksoqAJ5lEKzDp4k3dE/wR705kVyKMVb
 jVLAeji5LQYdQVebZvhcggeQTOLkVp2mgdqZAbNhIV+TV6LsPsVVm8ZE60TzzCVlvWME
 D4dA==
X-Gm-Message-State: AOJu0YyZp3G+7Jv7q4G/StqCum4HGAZgweH7Qflzk+MwdQ2TmPqly40/
 HpB1DOqUB+9+BLmjHn3JhiCeid3qjai3nbgUfHXWNDzbbq5cJFD/fmwi1qIroPi9iNI=
X-Gm-Gg: AR+sD128tUUmxINK5OBzAFrODgOsEkheRRHZhb27foRqyQGxabHzv2R8YDhcxsnoIS2
 gUZj0Hdbvw6efSqeJTTOYwr1MTqua7Qd0cXG4lpQW9HUCOgTAQh3fNrzjrp2zeOZ+3oBfZc/F+r
 uWPhj7dl2XF3gc50uN41KGOahAb+7qb9Fd8myO4gmOiMbPoPadUgm4yGjGxy2310Ea9TjHHptg2
 jW7MjvnG5kXfKX1egXHCMA45rPcNiHLx0IUUsKao+lSwJuChFSzzri+dypThq8UiSfVvxfX5Qfo
 mG7uvnEVJxhJKkrGLBsGvpj4DH6qBloVuJUvBs4BYN5+Lw1n34fFwVoW+NizO2J9IwPVLmUmIJA
 0FdR9vW8rD+UblL15Zsq1c4zVQxo08uCoiWDmhqpQDKhJ0PgnUoyC6joZLj/JcjQlZV+vKC7EX6
 TTJjjTZNEyrABRt69Mj6mVCJ2/uHXxyr35kZeY+pUuJovgFzyS5Z9K3/BNMTw=
X-Received: by 2002:a17:90b:5483:b0:36d:9e0b:3801 with SMTP id
 98e67ed59e1d1-392ec4cf8e2mr1886740a91.8.1786438041538; 
 Tue, 11 Aug 2026 01:47:21 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392e58a94aasm633058a91.4.2026.08.11.01.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 01:47:21 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 16:46:30 +0800
Subject: [PATCH v2 3/3] drm/nouveau/uvmm: clear the dirty flag when
 unwinding an OP_UNMAP_SPARSE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v2-3-aaee4b395d04@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786438000; l=1623;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=lIptHHN9gxorlm/NvGtJXIbFnkM/mVFweQW+foQRg4s=;
 b=BbY3eudDUU3rCJhubXR1NqITi9+XwlsZJYkYbjnHMrEnfLQTsJ3piqBsNjdoamVkGcHZ/Oh66
 8ZouVLyJEukCAvYeXRa06MN6LzT6WFM2hlbqZHknRlcvNwKCxLz3JDA
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

A successful OP_UNMAP_SPARSE marks its region dirty with
nouveau_uvma_region_dirty() and defers the teardown to
nouveau_uvmm_bind_job_cleanup(); it does not remove the region from
uvmm->region_mt.

If a later op in the job fails, the unwind path never clears reg->dirty
(set in one place, cleared nowhere) and sets op->reg = NULL, so cleanup
skips the teardown. The region is left in the tree with dirty set and its
completion never signalled. Later binds over that range then fail
permanently -- -ENOENT or -EINVAL from the dirty checks, or an unkillable
wait_for_completion() in bind_validate_region() -- for the lifetime of
the uvmm.

Clear reg->dirty when the unwind reverts the sparse unmap, restoring the
region to the state it was found in.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 3412200b21fd..76ab377f0e2c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1475,6 +1475,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 						    op->va.range);
 			break;
 		case OP_UNMAP_SPARSE:
+			op->reg->dirty = false;
 			__nouveau_uvma_region_insert(uvmm, op->reg);
 			nouveau_uvmm_sm_unmap_prepare_unwind(uvmm, &op->new,
 							     op->ops);

-- 
2.34.1

