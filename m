Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EBDC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5CC10EA05;
	Tue,  4 Aug 2026 12:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="APra/Nry";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0833E10EA05
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785847359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TQH/JjUvcOWyxPKiyYjT1Ot442Ew27xIkCxVhNUrEBI=;
 b=APra/NryE/tCQq8AmSKA4z6oNV/XiT5GW7qGu0blYncuFr+1SYcq10p4q6XXWiQKvuR7q1
 avgk5PI+t/Pb/3RVhna22AigpFV3jVkJ3fhuuV7qEcFh8ssP+NWqwDadBK/u7FSc25mUCs
 MepvgGd9aempVBfdI+e1TSbpbWSs2lU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-NxlX5AQXPpecD8UsvgqumA-1; Tue, 04 Aug 2026 08:42:37 -0400
X-MC-Unique: NxlX5AQXPpecD8UsvgqumA-1
X-Mimecast-MFC-AGG-ID: NxlX5AQXPpecD8UsvgqumA_1785847357
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4740be00302so4240305f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785847356; x=1786452156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TQH/JjUvcOWyxPKiyYjT1Ot442Ew27xIkCxVhNUrEBI=;
 b=TTDc6Z1kkTz9iW3hu+vDsBHgcqBCtN4FRstOgHNwsB5SHql2ulQSjl+z8FU4VMjOFs
 yKjm1rjVay3V2O7wkxpYaFhz4jNRK24xwFjMpyBsTs2Xk8PqKN/cqpflMau+VLqwqaoP
 185hCZBx5er5yH8mmtEQ+bavWIWBpFDdK9K9JMLu0g1NXFPy0uOmYyHBVfd2qb0V6M+W
 nUOU2gSs3DAECbfNV/Fnr6fYOMUO3SquQUzPV8ZaGBoKuzeCzDXNs3IXafofUbwFu5qY
 QcryNtsQJllPQdVgO3sCSMqCkcEcTMNS1IubzZz7HGoVRZaE/ffmhH/J+1Fckenwb65p
 51Aw==
X-Gm-Message-State: AOJu0YyHQbSWlgof28BP0ON2CY5DEcDCmTuOBQGEJczDnaTTALTar4CD
 Ix929kixU/I8tsHRlBcZWQdDFw4b2drJMMOSAuh17yl87MMtiXmUOsfw1PoZm4CBcGxq53Q9myB
 VgooP0vufT9qOCI4oSZIhX3SmUkHEEisJPj4oDavO5WxJwSTQWbOhZBZykKR7GQ0Padaz6HOYeg
 joY8ZKUooMq8487HUX5EVojjeNkeFj+nqA9sLwN/SHYw2+9MN7/TB/Sg==
X-Gm-Gg: AR+sD12QUfzCUgBqvSfiM6Esp6+itc5WicOURH7CoQW48tvjicypMkrQiDh3bkhqLhk
 3Tj8UnWMeQky33CSHZs6Qap5RQCGSHsqakBbyFvlA71BSTM6gWxnlmPIfJLlEjdWLebwO8W2uXh
 HJ5mPSmD5qD1wcJH+hlLeGKFUW4BhKnvzfpWeUk+K+1kNzoYxchVyZH+oQS+T30nLGmjfnjU1Ab
 iZ/pVnPAhAILGLTMRzftIFMI3EndDHxM4bdt4hRqTTaGQ+mvcGq1oyuLwfgOsWRrebxORbHoiQf
 CWw4ClBj5K/y5tQTuBJfY93kMLPIf6QNCwyTo8E6DHOBvfLGGy6qjq7TYPjlq2/bhx6aVrhLYNf
 k7VKwF0458xEIZsUYRnrR1JKlrxbfC422pRrVg7I7/ynOdAMogszV/4QKw7XmwuLY5LVo+DXOph
 xoZ5M=
X-Received: by 2002:a5d:4c90:0:b0:47f:881f:74a8 with SMTP id
 ffacd0b85a97d-47fd72e179dmr30765559f8f.28.1785847356753; 
 Tue, 04 Aug 2026 05:42:36 -0700 (PDT)
X-Received: by 2002:a5d:4c90:0:b0:47f:881f:74a8 with SMTP id
 ffacd0b85a97d-47fd72e179dmr30765483f8f.28.1785847356310; 
 Tue, 04 Aug 2026 05:42:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41cf404sm43069323f8f.1.2026.08.04.05.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:42:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/ttm: fix handling of errors on prefaulted pages
Date: Tue,  4 Aug 2026 14:42:34 +0200
Message-ID: <20260804124234.1742087-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XTQei0b_8q2JAtPLA6C_AGjFB1WMB9pKAIb8CpRwkmk_1785847357
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Commit fe662d846c95 ("drm/ttm: remove io_reserve_lru handling v3")
mechanically converted the goto out_io_unlock exits into return statements,
but it broke the promise that errors in speculative fault would not
be reported.

The old code was

		if (unlikely((ret & VM_FAULT_ERROR))) {
			if (i == 0)
				goto out_io_unlock;     /* return ret, i.e. the error */
			else
				break;                  /* return NOPAGE */
		}
		...
	}
	ret = VM_FAULT_NOPAGE;
out_io_unlock:
	...
	return ret;

while the new one does the opposite: it returns ret if i > 0 (previously it
would return VM_FAULT_NOPAGE), and VM_FAULT_NOPAGE if i == 0 (previously
it would return ret).

Fix the condition of the "if".

Cc: stable@vger.kernel.org
Fixes: fe662d846c95 ("drm/ttm: remove io_reserve_lru handling v3", 2020-09-03)
Cc: Christian Koenig <christian.koenig@amd.com> (maintainer:DRM TTM SUBSYSTEM)
Cc: Huang Rui <ray.huang@amd.com> (maintainer:DRM TTM SUBSYSTEM)
Cc: Matthew Auld <matthew.auld@intel.com> (reviewer:DRM TTM SUBSYSTEM)
Cc: Matthew Brost <matthew.brost@intel.com> (reviewer:DRM TTM SUBSYSTEM)
Cc: Thomas Zimmermann <tzimmermann@suse.de> (maintainer:DRM DRIVERS AND MISC GPU PATCHES)
Cc: dri-devel@lists.freedesktop.org (open list:DRM TTM SUBSYSTEM)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index a80510489c45..6d59f3c0696c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -267,7 +267,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 
 		/* Never error on prefaulted PTEs */
 		if (unlikely((ret & VM_FAULT_ERROR))) {
-			if (i == 0)
+			if (i > 0)
 				return VM_FAULT_NOPAGE;
 			else
 				break;
-- 
2.55.0

