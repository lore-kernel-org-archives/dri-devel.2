Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870EDC982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF0610E0E9;
	Fri, 18 Sep 2026 13:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j2b4mXS+";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72EC210E0E9
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 13:16:24 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48434392b02so532053f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789737383; x=1790342183; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5wyvtDe6AEfbt4jvUldi9B/KYnA6W2vv8pFn6fJzAVs=;
 b=j2b4mXS+EUAyLsSeQbVZxhJHsbZq0FDNuH5Qi8hLCs7/7VIveqDlAaVUtfwvRFKVK0
 w2rdBM7t9AuUQm1rSsO66wb/uoUJYWW9Ai31Y+IV35hSTakfUU7/IyDRRqaoMCwmVOC/
 6QZDYDII7fpUB+sL/BFp/3qlmJ5eMEnOLXi+dAz/JgPyAulwrx2Pqpv072gQzxAOwAgr
 AI9P+gib8qhL+c98aLvDnFLxIBYuu4PpiyUZfxyodlDMkMaksBcr52KNNA0x8fnzjwym
 slGi1bdSJmpZSWVxZF1BlDzyDBCCQdDsvZIM8Ns7CdM0X6VppJLYQPdo8EnR4/y/HfBV
 HIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789737383; x=1790342183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5wyvtDe6AEfbt4jvUldi9B/KYnA6W2vv8pFn6fJzAVs=;
 b=YzL3A8emgqer+xiIq9wikBMojLYhGSEcfT2sa/O+Bh1TFfu+g9G/cyYYwr4e0cVs3C
 mfRJL3aYGgDIp8OgDXLesKwBJW7gbIomGOV7WhneHY9RDXxcwwZrX/iSjB0fJl405I1l
 kUpjlgkAeQoFW3fizmPcxlcwzNEyQORkkmuifMpCovzqkotiIWAnYdO7AqYk81a+LkIq
 J3bR4zNm3wFxbiIJwaCf30gf3FRiweptcyVkVzH22syIXuAbH1bEPtX6rMTUc20/Xe85
 eFZCjbePeJOWrcyHkxYCFy7lAkEqv4ppqQ5/QOELL9qugSNPl2Dd1+aVsxOcUszRFtsg
 /xXg==
X-Gm-Message-State: AFuF++k67hfF2z1onz+MIkPWFSYrKcAcENFJu5HztLEX69Nd+33jXdQ5
 7pwqEdPo1s4xej70K40aYXQ2RGmLwt4sB8680rcTvWhFI1cLZXCFmzyL
X-Gm-Gg: AYBFou0gOq097WFCbxOlT+XEgDnW3R6FKk9bLPrUg1+fY6txac2pSHDQ19QsUnabcRL
 OBy7PUIAvp3JNgVPg16hYNHsBAO1LRFyZzyQCn3PS8Cg4t0N2WDOTQItwSlLXz4+7dR9dOMzjIO
 25v1tcKaW1cxy5PBl9GBRqf8ohdx174Io8Ruhp3A9HTn2UevVb6FcKr4HbF36R6tI7HyuK2aFae
 GCmOHOSPRqm5KfkEn29Ke/aYGVYpkkjJAU0meLXjZNBNPtRxLIDX3COCAv+Vkf55LxJlREsfIKU
 qdjSl+NNU//ACvxADEkzQbJb66azSbY4PFLSxOXw9cxHg26GCnQoAABv1fFNsdMmINBxucLqohm
 4BAHlq/o/p6o6d6DsW8/06FPAcyj5bCHj/TBW1aPMspNIhSgwMHTk1Fiq1Di6gB1YsuCNlkLZj6
 R8o1E4yuVj8ocla86/jirDcWh/NVwtIXYf4nnRQc9XVxXEW+KKJHvbwBB/vi8X18ERzPKkGnEY4
 8jW+nheSo4=
X-Received: by 2002:a05:6000:2f87:b0:487:c3e:8df8 with SMTP id
 ffacd0b85a97d-4871e20f764mr6206001f8f.5.1789737382476; 
 Fri, 18 Sep 2026 06:16:22 -0700 (PDT)
Received: from fra-x8664.wind3.hub ([151.16.209.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487200829e1sm4487572f8f.34.2026.09.18.06.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 06:16:21 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
 Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v3 0/4] drm/nouveau: fix list cursor use after loop in the clk
 pstate paths
Date: Fri, 18 Sep 2026 15:16:16 +0200
Message-ID: <20260918131620.405133-1-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series deals with the three places in the nouveau clk pstate code
where the list_for_each_entry() cursor is used after the loop, plus one
unrelated fix.  They are exactly the three sites Dan Carpenter listed in
2022.

The only change in v3 is the one Lyude asked for: patch 1 is Dan's
original patch again, with his authorship and his Signed-off-by
restored.  The code is unchanged from what he posted; I only expanded
the commit message and noted that below the ---.

His Signed-off-by is kept with the address he signed it with in 2022
(dan.carpenter@oracle.com); .mailmap already maps it to the address he
uses today, and I did not want to rewrite someone else's tag.  Say the
word if you would rather have error27@gmail.com in there.  Dan is Cc'd
at that address this time - the v2 went to his old linaro.org one, which
is dead, so he most likely never saw it.

Patches 2, 3 and 4 are unchanged from v2 and carry Lyude's Reviewed-by.

Only patch 1 fixes a bug that can actually be triggered:
nvkm_clk_ustate_update() takes an arbitrary pstate id from the user and
never checks that a matching entry exists, so if it does not the cursor
ends up pointing at the list head and the code reads past it.

Patches 2 and 3 fix the same pattern in nvkm_pstate_prog() and
nvkm_control_mthd_pstate_attr(), but neither is triggerable as the code
stands: the callers of nvkm_pstate_prog() clamp the index against
clk->state_nr first, and nvkm_control_mthd_pstate_attr() already rejects
args->v0.state >= clk->state_nr before the loop.  Both are hardening, not
bug fixes, and they carry no Fixes: tag on purpose.  The point is to stop
the two functions from being correct only by virtue of what their callers
do.

Patch 4 is unrelated and is a real bug, though a modest one:
nvkm_cstate_prog() overwrites the reclock status in 'ret' with the status
of the voltage/fan restore calls it makes afterwards.  The only consumer of
the return value is an error message in nvkm_pstate_work(), so the
observable effect is that a failing reclock is never reported in dmesg.

Compile-tested only.  All the affected paths are reachable only by root,
through the 'pstate' debugfs file, so I could not exercise them in any
other way.

The two follow-up patches for nvkm_pstate_prog() that Lyude also reviewed
apply on top of this series and are not resent here:
https://lore.kernel.org/dri-devel/20260727152821.128432-1-postadelmaga@gmail.com/

v3: restore Dan Carpenter's authorship on patch 1 (Lyude), collect the
Reviewed-by tags, rebase on drm-misc-next.
Link to v2:
https://lore.kernel.org/dri-devel/20260712123616.1180830-1-postadelmaga@gmail.com/
Link to Lyude's review of patch 1:
https://lore.kernel.org/dri-devel/ad023b5df1495ced25aa681d10f57628df41ac13.camel@redhat.com/
Link to Dan's original patch:
https://lore.kernel.org/dri-devel/YvSkKAdk8Pe0g2K9@kili/

Dan Carpenter (1):
  drm/nouveau/clk: fix list cursor use after loop in
    nvkm_clk_ustate_update

Francesco Magazzu (3):
  drm/nouveau/clk: don't use the pstate cursor after the loop
  drm/nouveau/device: don't use the pstate cursor after the loop
  drm/nouveau/clk: don't clobber reclock status when restoring volt/fan

 .../gpu/drm/nouveau/nvkm/engine/device/ctrl.c |  8 ++++-
 .../gpu/drm/nouveau/nvkm/subdev/clk/base.c    | 31 +++++++++++++------
 2 files changed, 28 insertions(+), 11 deletions(-)


base-commit: bc47d5937f21c5fc94504f03e18f1adb56d97634
-- 
2.55.0

