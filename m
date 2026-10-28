Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294CE606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utexas.edu header.i=@utexas.edu header.a=rsa-sha256 header.s=google header.b=BmeAC1yD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75ADC112028;
	Thu, 29 Oct 2026 07:58:57 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896F410F9DF
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 06:35:32 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-8470d7d430fso274498a34.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.edu; s=google; t=1793169331; x=1793774131; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:cc:date:subject:to:from:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8h/qo6kthTAWj0+DvmbQM0qiT9gJIQfvau3oJd2x4lk=;
 b=BmeAC1yDJAjsyTtFMHA8pLab7RlEus59hnyu7vgYmygkpg1wbycFMiu2J7FAgS66bi
 8D3V3IZDccEjwdV5n8UUup/r8/FTLyWK2e32xhiSrXtF4Nbj0B86xvNRmsCj7ltc5pvd
 j/pcmdznlqvzegVBKacnZbnvYmnOxYMm++h/Fya1fvjQDfakDVtXO/QmW3ZeKX1udgRU
 nkEez8tTaQQZEDQMjoV6hOmurXUGbzQlIF3Xxz12meUSPR1cvFCYvD32FxVHrDPt245m
 +V/9ry7O5Qtqc9fJTwlK60YaMgnBaj8IczGjCGq3EAu7vbBc+J3HXGq45zyZ/EjCc+cc
 05Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793169331; x=1793774131;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:cc:date:subject:to:from:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8h/qo6kthTAWj0+DvmbQM0qiT9gJIQfvau3oJd2x4lk=;
 b=uDLzpXotNi/owhePaLwXsRXoxo3djP3pOvgWb1INc6t9QEnQlG42jIz7cQuHXDy+8S
 e/gacA+IE7k6a9By+dFR5AWXJcl+IuXURZKfzjdIewDGzFHGppeRFM7IVB977dNlJ7bT
 J4yCAaTI7UXnyDvbVJkbsIxbW5dieGfHCCej/ff2TB2j7GlUtii0NIYXC8h2wg3mgglt
 JQuqgbHattPm0rvIz0LTByzOFtDiOSNeayLzz9vUGN0oUfs789W/mjWNjVq91reI3BCB
 HvDkQumZyUs8SGmvPbsM5cYAJZvNiDoJs4nTBeCvT0nqLSwYTxwqBUU0a0yWUG8hReD2
 Z/jQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4tUVOOrPR4pqwMW8spbc89JPVOoumhV9RtJRQLwE/EDvXsNqxkREWm7WNdIMKKK3rK+0iUCRuoK4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLmLDMiTZXi50M3x17I+5U65/9BCx5xyMizPhNcmMwDJTeL+vHK
 UD0dsPp6GmW89EbfRkZkQwilyZsz6S1EbP7h6YvQwnGFkIKw2/XW3Yz9A5zTVnHMqO4=
X-Gm-Gg: AYBFou0F/U8pis82VCxS0LagKSWnXgyJnPVTe91TjPaYXWIbmut7q0mVg7d+AVe+dKI
 rBYmhvnE361XqgzpFBbNgvClN22mOqY6KLk3hyiIqk0QgcHnMaz6KW/nwa0eKhtcl/z6AfiJmDu
 /8CHStErtB8Ee+j4IXki5KxOF6ye75SCKfiWiHDbiHE3y3ThEZL0i91Io7GWUuqT3gXgu5HIulq
 W0ztajg2Eecz0tBo63l9gXjwttzyFQ9y4OTtJkiHYhts7srE15U4Vr8yvoJHmdhkcFmBlFbnb7b
 eGghop62OJyUwkqeJesKpfHMB1fvgkUdiAn7J9D4cnAxM3OjmfZi5Z04UGWBq5H9Ddf/ETtw6ss
 BkhcuRC/a0/0cdk13fVFx30K13KJ/UfuseS4sSIsGgrwLo8VU16BnJX6dqAMPuEvjP2E2TVDhGq
 acxsBBNkCH/+EMUsyp84Sso5RDg+UOrBtspD2w4C6MIvXG94y1XcMVoai3yQZ127sd952rnFPua
 5pm/jrDoZbuEpUd/z6WljTKZdRQMcGb1QG3WW3J648ueraqwKBKBhqMi6z3JJBj1skaHIMf79Si
 ZqioKcYhkpbZ2sr9Y3EG0cX4DL4PIyeBNdsA1HS9EmBWrgu3BfEFbQPM/ihoG55Na4wYAf0ydj9
 T89axLZZ/CsGuaFOadBUxa+JvjCGt+v0PGVZvQuBQAKZTx/fVrS/qw/tGuRrdSUwh6+CWXGCjhj
 uRsC7y6XAajLFKSQWupYU/Dfb4AoLWhydYpWFg189olokEqWlwSCh6qctRgr2eigGKQqae
X-Received: by 2002:a05:6830:44a3:b0:7dc:4947:36a1 with SMTP id
 46e09a7af769-85ab9e46071mr1422426a34.12.1793169331496; 
 Tue, 27 Oct 2026 23:35:31 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([173.174.112.101]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4363d0sm770585a34.4.2026.10.27.23.35.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 27 Oct 2026 23:35:31 -0700 (PDT)
Message-ID: <6ae197b3.d47bf0d2.14cb70.fecd@mx.google.com>
From: karim.sabar@utexas.edu
To: Matthew Brost <matthew.brost@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2] drm/xe: Rebind VMAs one at a time when a bulk rebind fails
Date: Wed, 28 Oct 2026 01:35:29 -0500
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <atl2i1vJoU2QwCbG@gsse-cloud1.jf.intel.com>
References: <atl2i1vJoU2QwCbG@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Karim Sabar <karim.sabar@utexas.edu>

Big games die after every s2idle resume on flat-CCS iGPUs. The exec
ioctl keeps returning -ENOMEM even with 11-16 GB of RAM free.

On suspend xe_bo_evict_all_user() evicts every user BO in XE_PL_TT on
these parts. On resume the first exec rebinds every VMA in one job and
xe_vma_ops_alloc() kmallocs one 384-byte op per VMA as a single array.
Final Fantasy VII Rebirth has about 33,500 VMAs which means a 12.9 MB
array. It's over the 4 MB KMALLOC_MAX_SIZE and can never succeed. A
bind that big can also fail later with -ENOBUFS when it doesn't fit in
the migrate layer's vm_update_sa.

When xe_vm_rebind() fails with -ENOMEM or -ENOBUFS, fall back to
xe_vm_rebind_iterative(). It rebinds each VMA on the rebind list in its
own job, the same thing Mesa does from userspace when a bind returns
-ENOBUFS. Each VMA comes off the list once its job is queued which
means a failure part way through leaves the rest for the next attempt.

I tested this on a OneXPlayer 3 (Panther Lake) running SteamOS's 7.2.7
kernel. A small Vulkan program fills a VM with 20,000 or 35,000 64 KiB
buffers, suspends with rtcwake and submits again after resume. Without
the fix the first exec after resume returns -ENOMEM over and over and
Mesa reports the device as lost. With the same fallback loaded into
xe_vm_validate_rebind() through a test module, the bulk rebind failed
with -ENOMEM on all four resumes and the fallback rebound 20,024 VMAs
three times and 35,027 VMAs once with no errors. The program kept
submitting after every resume and the kernel log stayed clean. The
patch itself is build tested on drm-xe-fixes with W=3D1.

I tracked this down and tested it on my own device. I used an AI
assistant to help with the debugging and with writing the fallback. I
ran every test and reviewed the change myself.

Fixes: 2e524668c440 ("drm/xe: Add xe_vm_pgtable_update_op to xe_vma_ops")
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Cc: stable@vger.kernel.org # v6.11+
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Karim Sabar <karim.sabar@utexas.edu>
---
Hey Matt,

Sorry for the slow turnaround on this one. I said I'd write it and then
it sat for a week. Here's the iterative rebind you suggested. When
xe_vm_rebind() fails with -ENOMEM or -ENOBUFS, xe_vm_validate_rebind()
now falls back to rebinding one VMA per job.

I only hooked it into xe_vm_validate_rebind() like you said. The
preempt rebind worker for LR VMs still calls xe_vm_rebind() directly. I
left that alone since it's not the path I can reproduce but I'm happy to
add it there too if you want it covered.

Thanks for offering to take the error injection and IGT test on your
side. Also I'm not on the Intel CI allowlist which means CI won't run on
this one until someone hits retest. Would you mind kicking it off?

Changes in v2:
- Fall back to per-VMA rebinds in xe_vm_validate_rebind() instead of
  switching the op array to kvmalloc (Matt)
- Link to v1: https://lore.kernel.org/r/6ad8027c.7f7fe2b9.10c6e4.4073@mx.goog=
le.com

 drivers/gpu/drm/xe/xe_vm.c | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 99e42bd29..3cbb305b8 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -370,6 +370,8 @@ static int xe_gpuvm_validate(struct drm_gpuvm_bo *vm_bo, =
struct drm_exec *exec)
 	return 0;
 }
=20
+static int xe_vm_rebind_iterative(struct xe_vm *vm);
+
 /**
  * xe_vm_validate_rebind() - Validate buffer objects and rebind vmas
  * @vm: The vm for which we are rebinding.
@@ -397,6 +399,8 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_ex=
ec *exec,
 			return ret;
=20
 		ret =3D xe_vm_rebind(vm, false);
+		if (ret =3D=3D -ENOBUFS || ret =3D=3D -ENOMEM)
+			ret =3D xe_vm_rebind_iterative(vm);
 		if (ret)
 			return ret;
 	} while (!list_empty(&vm->gpuvm.evict.list));
@@ -856,6 +860,51 @@ int xe_vm_rebind(struct xe_vm *vm, bool rebind_worker)
 	return err;
 }
=20
+static int xe_vm_rebind_iterative(struct xe_vm *vm)
+{
+	struct dma_fence *fence;
+	struct xe_vma *vma, *next;
+	struct xe_vma_ops vops;
+	struct xe_vma_op *op, *next_op;
+	int err =3D 0, i;
+
+	lockdep_assert_held(&vm->lock);
+	xe_vm_assert_held(vm);
+
+	list_for_each_entry_safe(vma, next, &vm->rebind_list,
+				 combined_links.rebind) {
+		xe_vma_ops_init(&vops, vm, NULL, NULL, 0);
+		for (i =3D 0; i < XE_MAX_TILES_PER_DEVICE; ++i)
+			vops.pt_update_ops[i].wait_vm_bookkeep =3D true;
+
+		trace_xe_vma_rebind_exec(vma);
+
+		err =3D xe_vm_ops_add_rebind(&vops, vma, vma->tile_present);
+		if (!err)
+			err =3D xe_vma_ops_alloc(&vops, false);
+		if (!err) {
+			fence =3D ops_execute(vm, &vops);
+			if (IS_ERR(fence)) {
+				err =3D PTR_ERR(fence);
+			} else {
+				dma_fence_put(fence);
+				list_del_init(&vma->combined_links.rebind);
+			}
+		}
+
+		list_for_each_entry_safe(op, next_op, &vops.list, link) {
+			list_del(&op->link);
+			kfree(op);
+		}
+		xe_vma_ops_fini(&vops);
+
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
 struct dma_fence *xe_vma_rebind(struct xe_vm *vm, struct xe_vma *vma, u8 til=
e_mask)
 {
 	struct dma_fence *fence =3D NULL;

base-commit: d2ce8fcd778ee6d92748c92d23a56d4416c29d86
