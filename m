Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E231606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=U+ttS3M7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 059B8112792;
	Thu, 22 Oct 2026 16:15:07 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151A210E446
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 16:15:00 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-7c2f48f3a96so6704137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792685698; cv=none;
 d=google.com; s=arc-20260327;
 b=f7fd17ODR84Vdwe/nKODuT45VP0swqnMzMbxZgVjuBxa7dE03llT1Sk+2FdZVkxiZD
 OTEMjG1A8TxZ3HaQLoyKfhhrB167CuDrTtgrtfblqvKYO6y1Va+DyPYVTrgZQhDsiKkq
 F7NDq139UbawtrKNNUmvzODsr/N3fqrp1ToL8TQ5maFkY7h6dBwAa9MmMWuGBBk3ITXg
 T2+O6y4InEfFbcSkgyy9VlrDEwhhSHjYzpD8XK8fgjkXa39rrJnv4jhKCvoCw+S/QbdC
 jiqVLo+hcZ7PiBtKR84h/zYfCXG3E50el0WlZ4ZAyOx9rlhM8hVbyuQAfY9QIimH4DUd
 NK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=32W/TLORMHvdyxB9kUYfHwQgrTsCdKwMK9mAoglU6Uk=;
 fh=JZ+p/Gg5K6Kyy0BNBupH8OiEj43AQYGqqpivhaZn29Q=;
 b=m+jL9Bamv37ZjClrdF5LpKEma/YG+L7/efUMXwGRzp0zivm20bLM284P3wxS8RwjGT
 Xq3Z9VWkERgmZSNRuh0sIip2GkGAm+F6qRh7o4ghnOYJNGCiK3Cc4/aYZegM0Fcp7r7J
 j/ZGxXqt/Jfw9DLrkS2oug3HSb6EmSKBctCNXyeIsjYw2OVeuKPG7Imb5qYadoLYi5PS
 pW3cyzsy7+EF/cbN4Csi1r2Ko02UnUAZcZCPKgrzoXqLTYLipqNE8Vtpq7xPAN6ZTX0Z
 ITpaMOzO3uEHxYHIONilLGJuElJEYkK2e4ooNeoJ3vX3QOPyIxtk4eAVdMkPpPvPiKWd
 aKYA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792685698; x=1793290498;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=32W/TLORMHvdyxB9kUYfHwQgrTsCdKwMK9mAoglU6Uk=;
 b=U+ttS3M7s+alEV08Rl6iBfqDrxqlk6nfOIK2EPa7vi6amjQIO/Scq2wUgtitd3xyHe
 HptudYeFUVSeMhyXiv4VHrHLGDyyuncJwL3db7wm7mEjDOa21nmcnj7tKJ7fzj1imAtf
 /XRNTSEuqjApN9ZN5WIofTN68MKanQ4e35aksmaWMDY9bH4b5u0n74L98o3dpV3MKFQW
 lXgJfYE9u8fABi91wG8GStGk4lpBR8QGU7cqZHqQSZC5ejFeC5uLqMG9zLniSCgRN1UO
 eSFLzxtbrDC1N/f1GkSBES5EBWdNpiu66u5kAbZkrsniSWSxIARhaynkovTaG709QoaG
 Myxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792685698; x=1793290498;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=32W/TLORMHvdyxB9kUYfHwQgrTsCdKwMK9mAoglU6Uk=;
 b=v9LI/xb0HSRhOVHRWe+p6jcfOd5Qju/AxzSDOfJOOL77kXhOluSfuRcXOcJxfGFytI
 REzTyk23I4BoMxZ6Ue3ZqkuptEVATRwUipFkEfXQgkSQS5FVfzoj3b+MaEAXqR/Vc4MD
 uRIBreduwYoZ/whQ7TKG9kVBs1j59nOg2KNbYIorIvWwrzTIoE2ct+QceRPykdeHfiGP
 1hNunU4k1Q3/IVyUoN/FLVdGnOyJGDrvvhER0arXhern4lOz9XdmkIZlPDQXzyaXUb5R
 zyf+2jUi3ZkJpHKDXDdcvD/euz50KvS/fk+8iRNsqs3FmUujaR0ETedf3v3i6z+H7osX
 ekVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzl/COde9Oj/Mk8iqN3TQqkGrSNxeUt689bh56zwyPonLzpkeSO0Dybek71dkDUXyIBWdlB5ZoUrGI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLF/ur/x4rjsIjm8gSbyIlQI0Ip7syN5IaVcZxtfrt1zPI/Q/q+
 oS1V59Eep5O9pfu2Hm/k2oF4OQRADxsxQda3zPFJH1ary3UwcyjwsPW+dtrcCzrcNkiYBlKLBs6
 SwLa2DIp7hEY1ddLXyCRgnPaC9SAMoUnxsXDlXGGi+qR5U+vnYyvedeHBB90=
X-Gm-Gg: AYBFou06WyLesYSQndb5FDKd6gzSeNM5WuSi9BdVyu4TSDxxh566GRSPnN9ay2e03LH
 Py0g2XWc5m64QBHhqAnnw3pjKSxmtwzFi+EFfvGvmHzJK/Pv2vHkJ0GkxxnVFYqosm5m/lQezhh
 xwOeatFDsZvNvLAM26EPhqTkKoOMPSLRkPvwwRkORweE9kSdnzTLAczK+TmUFl7PVipJQwB23w3
 eNoyvNNOEOoEjRVy01WLIW3OF5B28PPQ/xALII0ivz0I+oWegsbN/tINwMagzN2hk/JXJZ0qj5c
 3GsJfG1QD2qVBbFv1McBQFWu2W5bAatWSsOulLEaTdXrc+Zz2TvWci4JfJgw9fmZYaVFrp89hGR
 0CIi/jud0E72OzFElsRM/1hnpon35IrL4DCCo3ERBiTfvvNiMypbzvEXZKdQuFBOXjK0BwI2I60
 dpGXTR8JaohN8=
X-Received: by 2002:a05:6102:8689:20b0:7b4:eb1d:d1e9 with SMTP id
 ada2fe7eead31-7cc93ac38f1mr1449225137.5.1792685697620; Thu, 22 Oct 2026
 09:14:57 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013205223.2396822-1-arnd@kernel.org>
 <6c18da11310ced4a7c85ac7862c3f5c67b39891a@intel.com>
 <3486e0b1-d188-47a9-9de6-7ee5c2cfd097@app.fastmail.com>
 <90fe0000d611f080164a1fd7f228cd533a2e927d@intel.com>
 <CAG_fn=WbwZKeaprUu2q640ffLfxOSsGAjGE3CcC8fm7yeJ77AQ@mail.gmail.com>
In-Reply-To: <CAG_fn=WbwZKeaprUu2q640ffLfxOSsGAjGE3CcC8fm7yeJ77AQ@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 22 Oct 2026 18:14:19 +0200
X-Gm-Features: AclHuK--rsXJ5Myf1mlhnm3dw8FN3KT0MKGkzp140BmHAIBqC5OkBPIMAzLleOA
Message-ID: <CAG_fn=UnS6wqCfuvjTeSoK5QmzhDc7=5n=U6kY1qFiPenidPKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: reduce update_display_info() stack usage
To: Jani Nikula <jani.nikula@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Chenyu Chen <chen-yu.chen@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> 3. The GCC estimate itself is also fixable (make account_stack_vars()
>    add the redzones it is going to allocate anyway, ~30 lines in
>    cfgexpand.cc). That reduces total KASAN stack usage by ~7% for
>    +0.35% text and fixes this particular case on its own (704 -> 368),
>    so it is probably worth upstreaming. But it is a correctness fix, not a
>    cure: it doesn't change the number of frames above 1024/2048 at all.

For what it's worth, the patch looks like this:

diff --git a/gcc/cfgexpand.cc b/gcc/cfgexpand.cc
index 0261f861b..56e335cb2 100644
--- a/gcc/cfgexpand.cc
+++ b/gcc/cfgexpand.cc
@@ -1653,12 +1653,17 @@ expand_stack_vars (bool (*pred) (unsigned),
class stack_vars_data *data)
   gcc_assert (known_eq (large_alloc, large_size));
 }

-/* Take into account all sizes of partitions and reset DECL_RTLs.  */
+/* Take into account all sizes of partitions and reset DECL_RTLs.
+   When the stack is sanitized by ASan, account for the red zones that
+   expand_stack_vars will later allocate around each protected variable,
+   so that the inliner's stack size estimate is not wildly optimistic.  */
 static poly_uint64
 account_stack_vars (void)
 {
   unsigned si, j, i, n = stack_vars_num;
   poly_uint64 size = 0;
+  bool asan_vars = false;
+  bool asan_p = asan_sanitize_stack_p ();

   for (si = 0; si < n; ++si)
     {
@@ -1668,10 +1673,32 @@ account_stack_vars (void)
       if (stack_vars[i].representative != i)
  continue;

-      size += stack_vars[i].size;
+      poly_uint64 vsize = stack_vars[i].size;
+      unsigned HOST_WIDE_INT csize;
+      if (asan_p
+  && vsize.is_constant (&csize)
+  && stack_vars[i].alignb * BITS_PER_UNIT <= MAX_SUPPORTED_STACK_ALIGNMENT)
+ {
+  bool prot = false;
+  for (j = i; j != EOC; j = stack_vars[j].next)
+    if (asan_protect_stack_decl (stack_vars[j].decl))
+      {
+ prot = true;
+ break;
+      }
+  if (prot)
+    {
+      vsize = asan_var_and_redzone_size (csize);
+      asan_vars = true;
+    }
+ }
+      size += vsize;
       for (j = i; j != EOC; j = stack_vars[j].next)
  set_rtl (stack_vars[j].decl, NULL);
     }
+  /* Leading red zone of the ASan protected frame region.  */
+  if (asan_vars)
+    size += ASAN_RED_ZONE_SIZE;
   return size;
 }
