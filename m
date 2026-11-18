Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD20606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=O2KW/G1K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE01910E4F1;
	Wed, 18 Nov 2026 06:40:27 +0000 (UTC)
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com
 [209.85.222.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A7C110E342
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 06:40:20 +0000 (UTC)
Received: by mail-ua1-f99.google.com with SMTP id
 a1e0cc1a2514c-99c042cee7dso287296241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794984019; x=1795588819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BN2eMBIZKP4IgFzjpmqX87SaP1ERJDhlfNIPjHVFBk4=;
 b=I/eW0+dxFk05VHDvA1WVFcvdqkBotuWjrD5l1eJ3YNEc7w6EPlNtOdvDq0yiCYg9Bj
 wxyPBKAkhSo8X4g67NvqCVzXJpteVxI6A3CkrMWseLGVukygslNBlU1ZMjBsvII268xL
 W0cWp8iFA1WcijEIrWK65kGJ4WQwcrjpAkxMr1JiIZVIHKwNvHyiGYyB5ylkKykF9QoB
 g4v2BNHgDV3EbPMqt4p8VBOPv4JlcGPIcmHjX5N2NEfTs1QkBytd6psVspPpFpDLIcCe
 7CJERrNpg9FEHnp3sR88dosW9qATs4hs1YMe8jTSARe3wgDtJsOW8cE2R+RGAucTVkFL
 inJg==
X-Forwarded-Encrypted: i=1;
 AL+hErHJKSoIkMazLRso+FDcRAojV6zPq5hBexaqQDDCyEq2Ux/rKmbrXDlySEOznntx7cee/PXdciTH2sU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ok2B2gpxTi1xlDXHSATfeD8oBku/A1gdu3bEokMztcXW/UD/M
 DO4W6IXDQDPt4IKp4NWXSqyVDmFyx+oxxAVjnhTvE9mavlsGl4UoF5wVNuzRC8JbTrqk5dJWN/G
 TlGfbzL5/EMfs50/I+sd3m6bOwHHQNfrorsi65JK+exR0uIDzi87XGIevax4wfePWXtzQgVRq5Z
 M4N55hrIT+92LMUDQlvpEySwaWkmNhF/WSpgfgfo0bCrBDYkNXhbKitoW8RxwXuqHV5XjAFD03c
 5HzjSCJROUmYuF1fo8R
X-Gm-Gg: AYBFou13eGvOwMBm/oHUXvJNI6dGEIu9oZEsTF5lSDytTgRz99MGimT4loaSCpMvWkp
 q9WRUWjSTplgMjBQDsrRCSuUlDq1+475lygrvHqrUZSmbFOYqz767heJZ5o2/XgsiZiPf5wpvRf
 R77Q3e0GffcmcrhPom9O9WQhU5G72F2Ayjb0TAo4Y4QjvfoTeZMOrcJJp25UFDynEC15r4OfWkI
 aAK8U1c2Ybujs3/hYI7vL2HsOs2sE/6cuLlugr16/kUffZ2dPukXxS5zQ5wvTPyW3Tqp9VMPEbN
 cjoNaB2I7mzQT0YiFSJ5tUP7pvUkuTzpSzZqLlhOnZCTvw0KpTT+CeeWCqTgsVZzUvX0++OjoYv
 FF1puo36fRi4da7ikJ/oa01bv56IPtY42oBMt0tCBPeD9kXISRzrvYbiNdOWMP1YCfgjyQ3+j9n
 lFPO460/CJJe3qdn4wgBG6fRXjk5kf4n1z
X-Received: by 2002:a05:6102:149d:b0:7cc:1045:604 with SMTP id
 ada2fe7eead31-7d6ba4ca641mr447353137.30.1794984019501; 
 Tue, 17 Nov 2026 22:40:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-99e4a4bbc47sm182000241.5.2026.11.17.22.40.18
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Nov 2026 22:40:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55b9c13273dso11407831cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794984018; x=1795588818;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BN2eMBIZKP4IgFzjpmqX87SaP1ERJDhlfNIPjHVFBk4=;
 b=O2KW/G1KzSEjPomPF6+qkKm/GdizQQnOPO3NoEH8ORz1n11/z4u4YJerKeyf1GXGUc
 LvB9VdkjRBRefpkr4oce0lsqQsj9rn+7JHdnI2JCQFKMPP0ZMKpRvrw5u+2VJgKykmbk
 eHachrxbxMNyZsU+v5TO/N4Z9SBqY1jQwo8vg=
X-Forwarded-Encrypted: i=1;
 AL+hErF9iww9oIHheW9cgeE/lqnDViWFFxcn2/Vf4PmDdQs+vZpmVRi+YRH2GOJWfqmTioYp0GQN+sGGVd4=@lists.freedesktop.org
X-Received: by 2002:a05:622a:346:b0:536:7b67:95f7 with SMTP id
 d75a77b69052e-55d5a7af113mr24847341cf.77.1794984017836; 
 Tue, 17 Nov 2026 22:40:17 -0800 (PST)
X-Received: by 2002:a05:622a:346:b0:536:7b67:95f7 with SMTP id
 d75a77b69052e-55d5a7af113mr24847041cf.77.1794984017277; 
 Tue, 17 Nov 2026 22:40:17 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d61cf3b56sm2078141cf.13.2026.11.17.22.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 22:40:16 -0800 (PST)
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
Subject: [PATCH v4 0/3] x86/vmware: Clean up the hypercall code
Date: Wed, 18 Nov 2026 01:40:10 -0500
Message-ID: <cover.1794206170.git.zack.rusin@broadcom.com>
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

This series replaces patch 1 of Alexey's v2:
https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/
Its panic logging patches and steal-time fix were reposted separately:
https://lore.kernel.org/r/cover.1794201807.git.zack.rusin@broadcom.com
https://lore.kernel.org/r/cover.1792471114.git.zack.rusin@broadcom.com

It is based on v7.4-rc2, which includes the i386 high-bandwidth fix
this series builds on: e0e022004bbe ("x86/vmware: Fix i386
high-bandwidth hypercall arguments").

Please route this through tip. As the vmwgfx maintainer, I agree that
its small annotation removal should go through tip with the assembly
move. DRM maintainers and dri-devel are copied. I'll make sure there are
no conflicts in that code while the trees merge.

And yes, this code is a bit like me, meaning it gets on everyone's nerves
and likely looks awkward in shorts, so we're just trying to make the best
out of what a politician would call a less-than-ideal situation.

Changes since v3:
- Forward TDX guests from the backdoor backend to the TDX backend,
  restoring the pre-series ULONG_MAX return on other hypervisors such
  as KVM instead of attempting port I/O (reported by Sashiko).
- Correct patch 2's description of the duplicated assembly.
- Rebase onto v7.4-rc2.

Changes since v2:
- Replace the ten-argument backend interface with input/result structures.
- Move the high-bandwidth assembly out of the header as well.
- Preserve all low-bandwidth outputs and the backend-specific %dx flags.
- Export the callable trampoline without exporting its key.
- Correct the ABI documentation and retire unused feature bits.
- Keep the backportable i386 fix in its separate posting.

v3:
https://lore.kernel.org/r/cover.1793685318.git.zack.rusin@broadcom.com

Alexey Makhalov (1):
  x86/vmware: Route low-bandwidth hypercalls through a static call

Zack Rusin (2):
  x86/vmware: Move high-bandwidth hypercalls out of line
  x86/cpufeatures: Remove unused VMware hypercall feature bits

 arch/x86/include/asm/cpufeatures.h  |   4 +-
 arch/x86/include/asm/vmware.h       | 371 +++++++++++-----------------
 arch/x86/kernel/cpu/vmware.c        | 307 ++++++++++++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c |   3 -
 4 files changed, 359 insertions(+), 326 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
