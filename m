Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52831606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=quSszNO8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECEA10F01A;
	Sat, 14 Nov 2026 16:25:00 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FF910E38F
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 14:19:03 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-3719e3cb82bso228727eec.3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 06:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794665943; x=1795270743; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=994O5G9ZxUQ8jqNBdTBnXMOuXg5Iwc5e9f/ldhdma60=;
 b=quSszNO8tieccjUls0CCYx46v9VcCPwUuE+VvmNczsaObtvM262bS+9mlDZ+i+OotX
 fkkGfYs5fgIIp4GgTuy4DRPLk0mxIhZElfzGPTM/6A1ISGvImGaIdc1Ik7D2rpm5jtVf
 /AIi42Hp+jRxnix7FL2gqwxFlwiwrkXn5jVQjnhqWsTcE6o8jiHzYbFzsxoBXdla/L0h
 BgltLycSEEZ1RARz+zLy9QAmZ0EWPhMo/12LqszZl0Yn8JOIGCe1SHeI4gkWXr2N7uhY
 rbvNKnVja6bc9B2grK1RzNEELhnM3EEtNiF7U7JEmvtZEnt2aU2xI5TT/zGA6mXfU1Nn
 MRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794665943; x=1795270743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=994O5G9ZxUQ8jqNBdTBnXMOuXg5Iwc5e9f/ldhdma60=;
 b=UY72ywROiellGi8gYIF+hzukm48cuASpXy0Zq8C8QtCYRIOXtHCHnIPibc7/Mdewgq
 ryg/i8Gc4MAqj15+b/SidZsBID1qkiQVC8zUxoyQsjUvoywl0ByvzRwrKtzVxzrMTUhi
 ShKu/ROm923D8HBCAnkwFbeZsS5+qYSpHV/z0SGWXe7xPSDsgCIL/GZ1rrVO6Otw0Of/
 RiuKMAW3fX/FfJT/Y2iVrrRsFP+zSxsBMybfKJTzwP0zz0udrt+vqZgZnCXw7Q3Axxz1
 ZSf8x4r/NUpYHUAYbluGRhqVm2+YCfQgp1YqvgMNsIlgYDuzepk1MR0S0VYwolszSQ3/
 YIaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFz0P30CQ31pP82bnE7e6q0W/YsUxVuvp1RlTwFHWADvDA0my/oTJaa9LfIfNuAS+jCW2j52UEBQyA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9YAYijB40AQGPuN0kgkXALvZgeKZeY5SnHYrzpIpklaY1a/gEs
 Dxv9SLeLjuLOJBN0vnb3wZX4/moO37VjVWduNSeuF27XFEymbY4wqqT9
X-Gm-Gg: AYBFou2vUhmm+HNG/AcA39Ir0hNTI4PhIxLa+FHu9UGOXHzpx7lm5g3l/OtKMShDu9V
 xyum5GPcpRVSCc/jX8NUJooIQM/5qWpVy4G+mThf1gbEVdZLF9LiBg7Sb5AHWh52IpQWBA8U+ox
 NVPeCTpMJ/c/mibBmtDSC7ujR2w20wHsUdkve1Lu5hGlQ2VpiRsrgEdyybf0kk2dwAI9XFTJ2ET
 B4WKyHasADwUHC0utiXqqnemfwjodJOycWfPNm/z2xbcVpa1eYeWoPai+IKuEAvu40hoyP05D0l
 mDuHjPprSV8yBXe0/+8h9mS0ZF0XBYblGUawGMVbqLRBETJ+MRtpcPYa+nd6ceA0vkVrIK0NEMc
 7PMq8DyGXQo8O8gPElLuc8oia8R8zryV7zKZvCLTusLrG+JUQXhiHmfe8L41MTu0VgHsIHKoasA
 jajy1dV2CX32IqeNvRS45IENewsU50z90PF+cYoDM0MR+ibawBvPYo6RALfPeGopuViJSYTTu5a
 pJXoSEmZUsbNTSlOcLAqFJ12FbCLRZAq0JIWKraYnDjDe/xLo58Iy2cRDRT5bewDxpnTQ8KTzEU
 DXlhPmPsKCTizMft4pODvfx67I1iASn7ZiztZGg6BoOdMuJYv4TSkal/bvWtNdlh9LeTbjLb/Ft
 1fTk=
X-Received: by 2002:a05:7022:158e:b0:183:d275:cf76 with SMTP id
 a92af1059eb24-1b5030dcb27mr9272048c88.2.1794665942684; 
 Sat, 14 Nov 2026 06:19:02 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b2519sm14745032c88.13.2026.11.14.06.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 06:19:02 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Julius Bairaktaris <julius@bairaktaris.de>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v3 0/3] drm/msm: Fix VM_BIND job, queue and entity lifetimes
Date: Sat, 14 Nov 2026 23:18:48 +0900
Message-ID: <20261114141851.134290-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These fix what happens to VM_BIND jobs, queues and entities when the
file or a VM_BIND queue is closed while jobs are still pending.

Patch 1 makes a VM_BIND job that the scheduler kills before it runs
apply its queued unmaps before it drops the references that keep the
unmapped pages alive, release its BO pins, and mark the VM unusable,
as the VM no longer matches its pgtables. Patch 2 destroys the VM_BIND
entity when its queue is closed, instead of on the final put, which can
come after the VM's scheduler has been torn down. Patch 3 puts the
queue last when a job is freed, as the queue may hold the last
reference to the VM.

Changes in v3:
- Patch 1: only apply the queued ops of a job that the scheduler frees
  after killing it, once its dependencies and the previous job of its
  entity are done. The error path of msm_ioctl_vm_bind() frees the job
  right away, so v2 could apply its unmaps too early and out of order
  (Sashiko). That path is left as it is in mainline, and the title now
  says which jobs the patch is about.
- Patch 3: rebased on patch 1, title adjusted.

Changes in v2:
- New patch 1, for an issue that Sashiko reported on v1 patch 1, which
  that patch makes easier to hit.
- Patch 2: changelog refers to patch 1.

v2: https://lore.kernel.org/r/20261114081902.1669-1-arpe1618@gmail.com
v1: https://lore.kernel.org/r/20261114062541.2001-1-arpe1618@gmail.com

Jiwoo Kim (3):
  drm/msm: Release the pins and ops of a killed VM_BIND job
  drm/msm: Destroy the VM_BIND entity when its queue is closed
  drm/msm: Put the VM_BIND queue last when freeing a VM_BIND job

 drivers/gpu/drm/msm/msm_gem_vma.c     | 99 +++++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_gpu.h         |  6 ++
 drivers/gpu/drm/msm/msm_submitqueue.c | 50 ++++++++++----
 3 files changed, 128 insertions(+), 27 deletions(-)


base-commit: 1e59855738454b14021b64115f0090eafc7526ae
-- 
2.43.0

