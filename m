Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985B5C5B56D
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F22E10E2B2;
	Tue, 11 Aug 2026 07:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f9LcVysp";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1343A10E257
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 20:39:08 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso1698761b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786394347; x=1786999147; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eYLBNqXF1zNAZBvL6Z7VZZKJwlYWKUq5oR45TMWjugk=;
 b=f9LcVyspkVEniNaWLBeGbfpAISdH9p0x0bigwWnBOmf6O7nCpz/D819OXCaysQxOE+
 k9H7vOQMwxYwQkky9nvg3mzJzRYck8IRBDF5WlQcL2VlJi84xJWOoL3tVWs/nhAANCqb
 4Yb9by7NEcul2hgfSZo8/E+IUz9v4fB00yCBLWG6zdYAfNj6jqRCM+7qn9Q42o8+Kdo9
 06AhgcgItVwrpzlBfPFM7Fs3DThc8gD08kK1/zd5wTruaD6HgD/wOKOqKpQA65xXxXAw
 +rpoNjXKFg9WeVUmYrJpPK7E6Ewy007XV/mv4FBjZd0T2oqfvIbla40T5ykGGlqunNew
 TNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786394347; x=1786999147;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eYLBNqXF1zNAZBvL6Z7VZZKJwlYWKUq5oR45TMWjugk=;
 b=OxrePi1mClGgkbVd4UTTQgBbRZcnIMwItD37pD1b0cKxEU9PWlN07Q/5DYSeA33T6C
 aF0Bo5+B6Cr2AMs7yAgCmpOqdA8xiBug3Es4HtxKcp1UzHN+mkoAA+JpcAq3sVohg+/c
 kf/xZ6QHJJdAnnRygb7uvDt2nIj+Ija3h3m+CGSXXEA8PISl7N3fwpE6uAFPy1Vi0DhR
 oDg6QQcJrGUtwahAZ90f7g74wyAQCz5muLPELSNZ6IBTTE9bo81Pr530sGnoDQVruCA0
 lGKiUQei/9oDCdBcpAPxpAzoC8rYXX9WC9CVxooIgh53GiIXD5mNGTuF3CB8KjsEb7mc
 X3rA==
X-Gm-Message-State: AOJu0Yx84BcX6VdVx1UoO6Ri76WmNrViYseB6sg8shzCKYm5tJSyYQ4A
 fqKw4Roerjn9xIkYACYwrvZORANWGNRPZkhxsFf3YLywXrbYZS2oYE+e
X-Gm-Gg: AR+sD13C6phniDFTnRN4EhMxEZLdmm12/pFZvRP86vfHKT4cxGn8ivdqvSpK9/S7Yma
 jfigZEPgT1aQd//QT+yu+3J7sHCyVTkaIT+fexgJabpi0dOPmSP0SQcC/rT11vPcxgBAZWBBnql
 1BsrMpkQID0J/GBWUyAQ0pedJAmCwx08amFfPJaTWbw4qLwyeTgdTfgOA6KQJDNTK+TvYYdkbRE
 mgYKxRllZxQ8tUbLGNYukyUgyAVYZPkvpsEmWGN3RpC8klmZuoe0V1U14kA3U+5FbhmWJ/jaEfw
 pAvx6QTEUqbekNjmabLPkb2Hbarj6KeQULJyVjFkGGO1ePcCPwarm045o3ubQv78QabMGp5xF4v
 qPZoC85jI39szjoNxtl2ukD/WYBoJeEw2PbvrEk3ionzn2x5JscLd1GScgDL/2yliSBePt1OjQO
 kyUT0vKqk6vL0eLnOifhr2Iiph8A2DfHAn9EOQXa6hzvyDyMVS5TYiTBE4Qhg=
X-Received: by 2002:a05:6a00:399f:b0:848:42a7:1854 with SMTP id
 d2e1a72fcca58-84f4fee21bemr33610373b3a.39.1786394347422; 
 Mon, 10 Aug 2026 13:39:07 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a553071sm4324001b3a.43.2026.08.10.13.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:39:07 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 04:38:21 +0800
Subject: [PATCH 3/3] drm/nouveau/uvmm: clear the dirty flag when unwinding
 an OP_UNMAP_SPARSE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v1-3-40df1c046b49@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com>
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786394315; l=1588;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=EkPEKXF+/UaDvmD1DSJT1a9iDr68rR/Sq93UlMmDacU=;
 b=xvwCAsSALBfo+gvo3ZaHDs3yC6zp/pyKzQwwXyN0p3W5AseCOv1a26TdDXBFUuDwtF8D64GKY
 ptfwp0aTPmpDgfsO50bna4ltQAqDVyxcUVxtlWFJ9TQe4/CGG/JkW1W
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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

