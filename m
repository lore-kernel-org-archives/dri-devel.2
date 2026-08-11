Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFC5C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2CEE10EE6A;
	Wed, 12 Aug 2026 07:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bknvqq8+";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835B210E240
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:46:51 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso28016465ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786438011; x=1787042811; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aRMZKmFxEexFiSBi+NXLZ4mOnz6FGsIj0DngbOrmNM0=;
 b=Bknvqq8+m+yUrk14WIQmYEbFQmfZQAFnU7KKBT/dUdyHIbcTrH1mn0ZI5t1MjFW3a+
 0QF0m7m49uQIg8/NPV+8q5YN1PjzZ/XGxlo8gXZGzLBNun+0vk7wKh6qKvfCRykS+yWi
 ZdS9p+II+Aev+oP+bNtBOCXYvsMZKFBQYHOVVGBadMP+K8wUzMbv9WNYM57aAGVmzwjl
 fgOkQp1D5oiKUlYDpUZZGl4Sxcsaz8NXpttyHSIjm/AQdczTkk030UFdAVOFMZO8a0j0
 BJifc/Y+xfCL7237oLXUAPe45jlRVSY2+40cQWu6I0YzzBp8tv4HN/3vMi3wYII+aFDv
 08fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786438011; x=1787042811;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aRMZKmFxEexFiSBi+NXLZ4mOnz6FGsIj0DngbOrmNM0=;
 b=I43A9HcDaKzNuB5mhJNrZ8ZBlnaipvzmFR7Gyrhq8lJEXzN2zCTLhDrNdj+bl8Ajg6
 j/CXUYFxR4BptcnAnHNTkgFpYYDik23lbqhnjxRSzniDNMlLHUhSFRffi02wOG+y9icD
 S4Pk4Z1dhJ5+xWrZ5dABEgF0sPgGzz7PwosNwp/ZzF8Rzuj5zK4iE28ksDpUcF/EmFlu
 AaSiDxHMQQ9hae/pDHACVbOvSpzevg1TKVt1aoaQ7xyxTWbtAXR9DujYIPi1I+WRvwcj
 oUa+hGny6SGXDTbPEx1YCx7Cu5H/Rk71apyhz6Ff/Z7EwVYL1yOdykfxBYC2hvPNXREK
 1vKw==
X-Gm-Message-State: AOJu0YzL0bUthYUljI3493m6ek0YKK4XbzUVg3MENE8L4IZowyZpYhFb
 fVZUuBSpopjuXPBci9+W7XmBsGj6Qw/uNHFf7PZ7VQxbOpmzEIraVgTS++0DL65MJFI=
X-Gm-Gg: AR+sD135NWZke0J4AtIqI+mGvLuXGHo0kh9ja0Fza349BgtLYZPFgmkwKc11jy2zqO+
 WS57dSMiVKUihxOUeeNuARDWCaRmRRY0/Xc561jIQAd6AzTjvQOPUQfsYZ1d9r+DUdpxgCo7VYT
 l2h3XImJEqQo8D27aV3PmSu1BjHQ8BEb/SELLQhwu9VoDwKDHKOamzCOQK2LNE2pUbDRTBV3TQj
 jNUGzoYmIqb91cA+XxYjl97pmcFEe9KOHzIq1rhXLUPDBaIibfc3BQMfLDtQid9K4C46DLLdAVA
 awEh89W3PopQrQ1/mRbJfrljumQx8xFLOEeAOwE/paSXsHNKgdmFoGkr2e+umNnrC3k11l3esBC
 Fqd3QP1s/6eqm0En2RXsyVAXQt/4XOzv8/7YBM3+2wNjUIPcdZw3hcSp/q6SAkJEg50z/2CRgDD
 n7oWuJiRcJkpFz5ItBWFRWdKvtOSe6iszHk2qbIn5WfGYzhcD2ihTpc64ac3p3wHXlKomYSg==
X-Received: by 2002:a17:90b:2750:b0:37f:b0a9:1a68 with SMTP id
 98e67ed59e1d1-392ec38eb9cmr1766448a91.7.1786438010922; 
 Tue, 11 Aug 2026 01:46:50 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392e58a94aasm633058a91.4.2026.08.11.01.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 01:46:50 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH v2 0/3] drm/nouveau/uvmm: fix VM_BIND submit/unwind
 error-path bugs
Date: Tue, 11 Aug 2026 16:46:27 +0800
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGPhemoC/42NTQ7CIBSEr9Kw9hnA2lhX3sN0wW/7jICBQjRN7
 y6tF3D5ZeabWUgyEU0i12Yh0RRMGHwFfmiImoQfDaCuTDjlHb0wBj7kYkSGXJyD4iR6DRbfJoH
 i2gp5OvfaclL9VzR7UPX78OOU5cOoeRvcGhOmOcTPfl7Y1vvnpzCg0FJtmaJtJ9v+NjqBz6MKj
 gzrun4BvA9VU9QAAAA=
X-Change-ID: 20260811-nouveau-uvmm-vmbind-fixes-c2dfab359df2
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786438000; l=1359;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=p2r9UCUH+IkCeVc0eIsmIJaqF16cFuYfb27Nri+KSQE=;
 b=BPNGH7Rxw1u58EJuGxnCMfLg0hb9HrQMIWMovlH5lsn/WN39m5IfwwvHzxSAs8yLw6I7youtI
 RP78gf9O83LAQQaRsjG8AMkpQbpSpp7soUvsAfEfjPsTqXCNx5yQnQa
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

Three bugs on the nouveau VM_BIND submit/unwind/cleanup error path, all
introduced by the original VM_BIND uAPI (Fixes: b88baab82871) and all
reachable by an unprivileged render-node client:

  1/3 NULL deref when the unwind loop frees a never-populated
      OP_MAP_SPARSE op's ops list.
  2/3 premature free of a region on a failed OP_UNMAP_SPARSE, because
      op->reg is left set on the failure paths.
  3/3 a sparse region left permanently marked dirty after unwind,
      wedging later binds over that range.

Each fix is minimal and self-contained; all are Cc: stable.

Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Changes in v2:
- Add an Assisted-by: trailer to each patch; no code changes.
- Link to v1: https://patch.msgid.link/20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com

---
Zhenhao Wan (3):
      drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op
      drm/nouveau/uvmm: fix premature region free on failed OP_UNMAP_SPARSE
      drm/nouveau/uvmm: clear the dirty flag when unwinding an OP_UNMAP_SPARSE

 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
change-id: 20260811-nouveau-uvmm-vmbind-fixes-c2dfab359df2

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

