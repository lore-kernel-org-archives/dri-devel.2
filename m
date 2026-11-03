Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12443606A337
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Qq3e/fmF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E1910E780;
	Tue,  3 Nov 2026 07:15:57 +0000 (UTC)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13A810E780
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:15:50 +0000 (UTC)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so2766390a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 23:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793690150; x=1794294950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j/Bcqh1Ir2ox5ZHSRD7plS8yIHsdPIl+LjTttxcCQ1U=;
 b=Cl8LL7tX0/m+8ktEz80WJhxB92Agac91TsBjqPAdciTcBbit6s5ZpqQ946F4CuWajW
 RGIh4Dk6FXO9stOYpsy7uQOkI6KQmQRtjiUu7+H4UQBG3LvLvA2776r6IlfkTtNn+ukL
 j/hyPJ3FUcZCAv8TWgE8wpM24gGaWy27gBhXikQyDHgOrAvanV6v1QHeaAN4u46k5APQ
 iDQ4BwQt1nGV7La0Xb0L99ku98+BwPRb8/8+Bhp+b7WP6leDz01i8CgrQxy2q2asUpX8
 AKM7irCnqnzK7LbEZL2K+OygBkofVkPow4HqSdhTp6CwYRGXw7nrwTT9vpJLXzDaTApH
 tZnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC5XRq3WQBNKBvB/f39x56UFcF6R29oGgQsM2PBeh6+wGjCkj4HuOO1VPqvZxcwEjY9zfLz2YKXWY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8iAQd3ObxYIfg+/Y6DadtLBP+NV04GxWTRl5hS69UCffuCXmaT
 F/xTrjPEbLk6dP/zsQln6jgnlSoAJ73JSQz0BNYYYTXKndSvstiOTaP+HHyhZ2sJhNX3UEaiiV7
 E+rvirhlhvuZT+IFKB7AgRIsm0nhFqmVIGv1bLf/NcfU0VvW4rzRilRBd7JRXAQx8VYJe2gK+b8
 TrJocuWJWIXa6ZZFNeUmAWTBY7Fy6csobMxaP2/KfZQnNKd0LcbQalCcKQJZ/I5krmIIM/1v1Cz
 sB+DezfghFYP5r3xlBg
X-Gm-Gg: AYBFou2UPM+1A3972NiNc/CXSfReeH53ip3KkZUKRGUZzKPwYRBsq8Ymv7Vwtiox46z
 76dH/0aeIgRXYpLULVVFcdRHHuCEUeuBuibUGtek5hsopgUl7ZfrE3fMSJA0o1oD+NTx7OgR+Qo
 bKqJ5t5+wewTyFUpT8+yEsPB0jvcEkQPLWPGmbHfwtRnai7aTJffXvSCCLfnReLJZdfAVusJdHD
 JYjqknytxpcW5Kt+cy2b0V1jNDOnGnW+lc03fvcfpXq8oX5quEmkZI+/y8G9iBh+Pj9AE5kcUtk
 HXWqHf1M1rVPbBVPpiT8Dar6Bupy/opxIB3yrkEUQXpU+CCKKfSNvn1vvtvUT/dzuL8JI6Bu4EQ
 WOqpc/Dy+ZLEFhPoy+NQkq+svq1TFIKgyR6WtCuC4dJ8tg+LrBWk9vVluaeLjSTfp1Ij2zrhz6I
 FCGg4Nr7dSyPecj0J52UvffwlP5H6EjI0Q
X-Received: by 2002:a17:90b:180d:b0:3ac:a204:aa27 with SMTP id
 98e67ed59e1d1-3ae8985edbfmr10703538a91.66.1793690150075; 
 Mon, 02 Nov 2026 23:15:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3aed16d1ab2sm1055863a91.1.2026.11.02.23.15.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Nov 2026 23:15:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-943e8ff02d0so341328785a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 23:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793690144; x=1794294944;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j/Bcqh1Ir2ox5ZHSRD7plS8yIHsdPIl+LjTttxcCQ1U=;
 b=Qq3e/fmFoQZehlTT6buBumG/boaYHydzLD8p0SMs44kVfqnZXlALQkab2FyenwVRCX
 sjATX5e9fwijJ1+rCEYOIIHYA9748Jxr09SZ6P9ZHsTDD4RpVECG4ldx6lUzUALoLPKA
 TYuDt497EtNa8DP6j1V3LWV2hRYnmuZ+gdX8g=
X-Forwarded-Encrypted: i=1;
 AKwUvBwcEATrNrKqg7lQivBEJ8fmWjJG0GE/5oz8xkKyqMIuearziuiYi8mDfM+bmqxsLfui+xA9h1GBQrM=@lists.freedesktop.org
X-Received: by 2002:a05:620a:4044:b0:93f:3163:3e37 with SMTP id
 af79cd13be357-944216b1af2mr2136142485a.28.1793690144057; 
 Mon, 02 Nov 2026 23:15:44 -0800 (PST)
X-Received: by 2002:a05:620a:4044:b0:93f:3163:3e37 with SMTP id
 af79cd13be357-944216b1af2mr2136140385a.28.1793690143503; 
 Mon, 02 Nov 2026 23:15:43 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9442581b2d2sm1018334585a.15.2026.11.02.23.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 23:15:41 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v3 0/3] x86/vmware: Clean up the hypercall code
Date: Tue,  3 Nov 2026 02:14:55 -0500
Message-ID: <cover.1793685318.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move VMware hypercall assembly out of vmware.h and select the
low-bandwidth backend with a static call, following Linus's request:
https://lore.kernel.org/all/CAHk-=wivx7pi+h+hGmvNFAJm6StQLiQ-b8DdsE5J=LMOWae8Ng@mail.gmail.com/

Patch 1 moves the high-bandwidth helpers out of line and removes the
redundant vmwgfx caller annotations. Patch 2 uses input and result
structures for the four low-bandwidth backends, selects the backend
during VMware platform setup, and removes the early dispatcher. Patch 3
retires the unused VMware feature bits.

The caller API is unchanged. The I/O-port backdoor remains the initial
target for early DMI probing. Modules use the exported high-bandwidth
helpers and static-call trampoline; the static-call key stays private.

This v3 replaces patch 1 of Alexey's v2:
https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/
Its panic logging patches and steal-time fix were reposted separately:
https://lore.kernel.org/r/cover.1790014793.git.zack.rusin@broadcom.com
https://lore.kernel.org/r/20260929040256.543767-1-zack.rusin@broadcom.com

It is based on tip's x86/urgent branch, which has the i386
high-bandwidth fix this series builds on: e0e022004bbe ("x86/vmware:
Fix i386 high-bandwidth hypercall arguments").

Please route this through tip. As the vmwgfx maintainer, I agree that
its small annotation removal should go through tip with the assembly
move. DRM maintainers and dri-devel are copied. I'll make sure there are
no conflicts in that code while the trees merge.

And yes, this code is a bit like me, meaning it gets on everyone's nerves
and likely looks awkward in shorts, so we're just trying to make the best
out of what a politician would call a less-than-ideal situation.

Changes since v2:
- Replace the ten-argument backend interface with input/result structures.
- Move the high-bandwidth assembly out of the header as well.
- Preserve all low-bandwidth outputs and the backend-specific %dx flags.
- Export the callable trampoline without exporting its key.
- Correct the ABI documentation and retire unused feature bits.
- Keep the backportable i386 fix in its separate posting.

Alexey Makhalov (1):
  x86/vmware: Route low-bandwidth hypercalls through a static call

Zack Rusin (2):
  x86/vmware: Move high-bandwidth hypercalls out of line
  x86/cpufeatures: Remove unused VMware hypercall feature bits

 arch/x86/include/asm/cpufeatures.h  |   4 +-
 arch/x86/include/asm/vmware.h       | 371 +++++++++++-----------------
 arch/x86/kernel/cpu/vmware.c        | 299 +++++++++++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c |   3 -
 4 files changed, 351 insertions(+), 326 deletions(-)


base-commit: e0e022004bbedc7caf1c18770980eb5372019189
