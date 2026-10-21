Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510C1606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utexas.edu header.i=@utexas.edu header.a=rsa-sha256 header.s=google header.b=rWr1luxS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C48210FCB0;
	Wed, 21 Oct 2026 08:51:53 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 039DF10F841
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 00:08:29 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-843cf077f10so250519a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 17:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.edu; s=google; t=1792541309; x=1793146109; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:cc:date:subject
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q76fPd6I+9oLgbQ4WW7J9EoxVAQOgPqIoUvr4JNR1bA=;
 b=rWr1luxSe3DcgeqpSsB0Cb7L/tbdPtJBZ6dQAOdgqFzk/oW0EVd+vh8ogEayngTKUc
 tFJoStVYoeR/y3M6g0sqUBfsMNrYneilupHxqLIJe5VAlv7xIp2PvIchSwl/hPyffxhv
 0X5iiqpZU6pCPyPTnGg0ZqdTXNZjNAE5/N1gpiy90gpDC5AwsL1VXE101xp/es+O5vW4
 N/kBBP5wvqJSTSmWYCQFGsFBAGHSme2F/qiIgAjH94BtrLIPm9ghhI/RysWXhVjtzzNn
 3KRYP3vTczGmCTBkDMmlO06Io+6Gq7vRjlJLuW2EFCnamLKzzhLufA0O3dPp9T4hEfHe
 9xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792541309; x=1793146109;
 h=mime-version:content-transfer-encoding:content-type:cc:date:subject
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q76fPd6I+9oLgbQ4WW7J9EoxVAQOgPqIoUvr4JNR1bA=;
 b=pogj1pDi4xRusbrNoU7ufsV6WAL1qa7scH9hJ+HNes/Lt1r0wuGCGQM+a0a02n+s8E
 xDvXyF3fhTtEOSCpgMvKu+H91yK1CfwNALdMHNLU5ttehWxCmAqOuL8SbVYbuvt+F8b7
 OuQCf6x/+TrnEwey8TVJfBXDNFy01Fs7eCbeBpJYZFaw3eBnsdtO3earTst+DWvHYgml
 Jf7rr6vhMLssO596heYFeAOUSCji2u5eWCdzwFum7Fo3HXBlrQ1iVQcGqHDe2FwTqS82
 rxpnt42RU84Lvrra/sqcyt6BYHOCcP/zfz6S4kemJotYiWEyuz8qezfwgbP0oe9lltf1
 GxqA==
X-Forwarded-Encrypted: i=1;
 AKwUvByKQwqfy5ZdH1jzxcHsGf8lN28FFDZ7BtfvIV6iGbvpuOuyCAAIFQWPEBPpqjnUPAGVDOC1gGLJSac=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIOZHYlNQp32bhTL3POQvFQhxjqIxmNlmCJjm3z5a+SUNvXetzS
 wTYZRYccifa2DhgqVFeA1lXzqgrtM0baIr+k/w2dDcKm3hcZMlBIjVvD8ks+Egc6z7c=
X-Gm-Gg: AYBFou0vfqgVBpMfvCB0dNsQ+mbu7sMYJBfY5QSHsMlhVa9aI339+4BBXEyqcRfYS7r
 C6fiZnP7/fkLB+hcOD2GVTiObHA9XwVaRoPUaWj96ZbUkJfDESmNHIJ3cABmws6scPdzcoH6GjN
 J07qxdAqBTaKKHU8LoH4BD6bo/f4D6JepeoB6UnxJ1xSLgiTmc7sQ89P56UQXneRCCEe3BUH+6z
 +wN4HPwYQJGnm+vP86qdFGxlIYfiNInIsrVPauLyq593p3cnn6IMao7klGZ5f5+8E2+/ZTlG55L
 GB6DQmZkC7DLKg2b80y+0gj6xfs0fr/w3AJVFLtRyqxj37YGp5DsAcSiVae+Vfw9I8DFnYXDNjN
 7uWLpMHr4+9uN688xOn8XBiaPKfMxEQLUBHXI/fhbBAOngGRyxSanxCctIT3BvjISk1I7Ae5bXL
 h5Z3cFNYm7fgBm8txXmtNzXZG7I/CKrM09m2JrY3JiCcyA9XYmxDdfGeCVaNUlq2kU/qZfJjKLH
 V2IDASMyCLhrLDs8LYhhUvV2oQXjYGh3kVfFPoGyqEA7vlnLtOWtLYcLItnfjV5E8aBK0Xlci7o
 SwHaJ5PppKeRsYWG+bl1xSc9nM9v8oJUpTVhDxzrNf1HuJTiOf+3gA3WkqPQBr/gVr/Srkw83Y8
 A4dSTIlXmysHwWcGEuk4X8+w03oqh10udASfLFdq2DoOXcZYDWRXJUA2QLCIJwoEXbQU4lZLfnl
 qTw3vqY1NhJV2R4ru8Cw==
X-Received: by 2002:a05:6830:4425:b0:81c:37e2:2012 with SMTP id
 46e09a7af769-84d07f09896mr256325a34.15.1792541308869; 
 Tue, 20 Oct 2026 17:08:28 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([173.174.112.101]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd7d4431sm955195a34.19.2026.10.20.17.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 17:08:28 -0700 (PDT)
Message-ID: <6ad8027c.7f7fe2b9.10c6e4.4073@mx.google.com>
From: karim.sabar@utexas.edu
To: Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/xe: Use kvmalloc for the VMA ops page-table update array
Date: Tue, 20 Oct 2026 19:08:27 -0500
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Karim Sabar <karim.sabar@utexas.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Karim Sabar <karim.sabar@utexas.edu>

Big games die after every s2idle resume on flat-CCS iGPUs. The exec
ioctl keeps returning -ENOMEM even with 11-16 GB of RAM free.

On suspend xe_bo_evict_all_user() evicts every user BO in XE_PL_TT on
these parts. On resume the first exec rebinds every VMA in one go and
xe_vma_ops_alloc() kmallocs one 384-byte op per VMA as a single array.
Final Fantasy VII Rebirth has about 33,500 VMAs which means a 12.9 MB
array. It's over the 4 MB KMALLOC_MAX_SIZE and can never succeed.
__GFP_NOWARN keeps it out of dmesg.

Data from a Panther Lake handheld (SteamOS kernel 7.2.7), kretprobes
after resume:
  xe_vma_ops_alloc  -ENOMEM on 63 of 63 attempts
  xe_vm_rebind      -ENOMEM on 63 of 63 attempts
  BO validate, TTM populate, PT prepare  never failed

The array is only used by the CPU and doesn't need to be contiguous.
This switches it to kvmalloc and kvfree.

With the same change applied as a module on that kernel, the game
survives every sleep I tried with zero ENOMEM. The biggest array was
30,753 ops (11.8 MB).

drm-xe-next already does this through commit 0e33330f1238 ("drm/xe: Add
struct xe_pt_job_ops"), but that's part of a big series that won't go
to stable.

I tracked this down and tested it on my own device. I used an AI
assistant to help with the debugging, i.e the kprobe tracing and
reading through the xe code. I ran every test, picked the fix and
reviewed the change myself.

What I couldn't do: this is build-tested on drm-xe-fixes but only
run-tested on the SteamOS 7.2.7 kernel through an equivalent module,
not on a mainline kernel.

Fixes: 2e524668c440 ("drm/xe: Add xe_vm_pgtable_update_op to xe_vma_ops")
Cc: stable@vger.kernel.org # v6.11+
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Karim Sabar <karim.sabar@utexas.edu>
---
Downstream SteamOS report with the same data: https://github.com/ValveSoftwar=
e/SteamOS/issues/2962
---
 drivers/gpu/drm/xe/xe_vm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 99e42bd29..5caef443b 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -703,9 +703,9 @@ static int xe_vma_ops_alloc(struct xe_vma_ops *vops, bool=
 array_of_binds)
 			continue;
=20
 		vops->pt_update_ops[i].ops =3D
-			kmalloc_objs(*vops->pt_update_ops[i].ops,
-				     vops->pt_update_ops[i].num_ops,
-				     GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+			kvmalloc_objs(*vops->pt_update_ops[i].ops,
+				      vops->pt_update_ops[i].num_ops,
+				      GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
 		if (!vops->pt_update_ops[i].ops)
 			return array_of_binds ? -ENOBUFS : -ENOMEM;
 	}
@@ -742,7 +742,7 @@ static void xe_vma_ops_fini(struct xe_vma_ops *vops)
 	xe_vma_svm_prefetch_ops_fini(vops);
=20
 	for (i =3D 0; i < XE_MAX_TILES_PER_DEVICE; ++i)
-		kfree(vops->pt_update_ops[i].ops);
+		kvfree(vops->pt_update_ops[i].ops);
 }
=20
 static void xe_vma_ops_incr_pt_update_ops(struct xe_vma_ops *vops, u8 tile_m=
ask, int inc_val)

---
base-commit: d2ce8fcd778ee6d92748c92d23a56d4416c29d86
change-id: 20261020-xe-kvmalloc-vma-ops-2637ebf81cfd

Best regards,
-- =20
Karim Sabar <karim.sabar@utexas.edu>

