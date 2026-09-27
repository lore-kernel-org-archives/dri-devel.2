Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433ECC98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 08:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F68510E308;
	Sun, 27 Sep 2026 08:27:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I6mHVD1n";
	dkim-atps=neutral
Received: from mail-pz2-f13.google.com (mail-pz2-f13.google.com
 [74.125.228.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464CD10E41C
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 08:27:19 +0000 (UTC)
Received: by mail-pz2-f13.google.com with SMTP id
 41be03b00d2f7-cc4cdc0d663so775050a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 01:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790497639; x=1791102439; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XuEMzYsQmuqvuSw703l+7WHrOcEGXR3Wzqv/Y5f5zrQ=;
 b=I6mHVD1n7Tt+Yp1xmyhkeLPkneOI2pmWoINy15Dqsom8YuaXp2I+ogpcGNgmB1JvDR
 YQTOb3jOguRVaRwKjYY/YbV8v+VDOYv8OgF0/MEeV6bz5KwywcgU7cbcBtpCsaZV8J0q
 cPc8V4loDpA7GM1M7zygYM4r1a/6raF5diWuLLu8omZ3FURbEolSDUZhfrHcVxz6Mtcc
 nzdvEM//ZdG/iJmt9ECqqw+Rn2gj7aFUz28jHyz7mSpG6rC6NT9qXn63LCY8fdNFM0Cr
 edp3C1oKfQMTr4cCSgu9V/XbKAGWiV95lWvrgijzUKZqtnwav5cpULUCjKfRWMd6auaG
 tyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790497639; x=1791102439;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XuEMzYsQmuqvuSw703l+7WHrOcEGXR3Wzqv/Y5f5zrQ=;
 b=mTAczQgUK/ak4oMAX+QkWV7WGOrj2iBUS7rnfzuYDkyTIeCE4NPQoD579VWTLeLCHZ
 4ULszeda5LgpySRrbUwaU1LI5SuJ8EZo+3/KdzVfGwREfc3OHBDTr8lEYaD8xi2XHwHO
 Wx+2uLaevNSjXY00YgIbnzmLabnriepgPX+hpe0fu7/RBy4YjXye+hRCAF7gV0yXVAR7
 v6Ci1PKCzG9KNWL+1JRlHw/qsRuLrKVwIdL8nSvJiS5p3LPZuU/tCHgWHt0adUbQv53C
 dC+xdBWgcO/TWxSHpRmGM141tu2G0FEve6M/SgrLOkIifPn41SYrBVNnGMVtmehnKi+A
 VY0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzG4UdM4U/MbsJ9IT/Uh1Biak8A4Jm+giGV3e+VOVaCOnVkmtHDdFNgGafpinISlc7+EfsS6PyOEiU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlX18YhTP6xFN0iWLk4MddMvgfMjMuIl0fh9dpvIuE2rMzguXV
 AuVe1Kr+nXkBbX5TokVSAvzIx9mbhIk1Jbrw4LuxGvwdBnH3rnBselTb
X-Gm-Gg: AYBFou1mHZ0MfBSzV88QqeZgz7EKHZ3A3AtGWrhdSyhEHlbGF2IFzute5zmV4GszAW4
 oT8kvK/H/LaXmp9/eWrKKfhx6yMTyueZVYyBK8FRK+WaMZTrTVGgtrpQx7SHJuEoVYiUA9rFnjG
 9yefQ5l6vjLTCGzA2G2iLCv+YsCO85IberDoV32p6dX+FFBFLAPLCm0tsgVxQP7FdBUh4Nl8bna
 ADCByjFdU+N3Es+9YgOxDmqHsPuwKmHUKdK4MXp9L8ix+oS3+PVpLe8W0vO6dDXRSbjNU8nh+P8
 F+dQw2h9OgUOs6uEkMzfKX7n2TtpaowS4t6ejfzZoz0TA6yot+xdFfys1R0mG2OpYVoWxaBRVvJ
 OfuGaajobl5BoX8w+QRUe3r2kogVqwhtArDK56OB3YcjihKi6yGXr5fLC+h0cZTAC2i9GdqdOYw
 rFHIt7DpxQw8M517KquWQUam7Yl5sq6rxDw/HiXjUuBeI31wTJdlwrG5leJEgpjBI=
X-Received: by 2002:a17:90b:17c3:b0:3a0:bfaf:2ae with SMTP id
 98e67ed59e1d1-3a0bfaf039bmr5225656a91.43.1790497638614; 
 Sun, 27 Sep 2026 01:27:18 -0700 (PDT)
Received: from [127.0.1.1] ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a2b1e4d5basm1921496a91.9.2026.09.27.01.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 01:27:17 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH 0/3] drm/imagination: Fix pre-existing bugs flagged by
 Sashiko's review of a VM_BIND series
Date: Sun, 27 Sep 2026 17:25:52 +0900
Message-Id: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABDTuGoC/zWM3Q6CMAyFX4X02sa5KKCvYrxYR5WaMEmLhITw7
 m4a7853/lYwVmGDS7WC8iwmr5ThsKsg9iE9GKXLDN752p19g+OseJeFDQMeXdvUXUtE/gR5MSp
 /ozy43n5sb3pynMpFaVAwRtKQYl+sTgccxOL+LzDxMsG2fQCJVMD0mAAAAA==
X-Change-ID: 20260927-pvr-fixes-a-40876d8bbb25
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

These three patches fix pre-existing bugs in this driver that a VM_BIND
series depends on. They address what Sashiko, an automated review tool,
flagged while reviewing that series (see Link below).

tests/imagination/pvr_vm_map.c, sent separately to igt-dev (see Link
below) and not yet merged, reproduces all three bugs and shows they are
fixed by these patches.

Link: https://lore.kernel.org/all/20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com/ # VM_BIND series Sashiko reviewed
Link: https://lore.kernel.org/all/20260926152341.783867-1-gye976@gmail.com/ # IGT reproducer (not yet merged)
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
Gyeyoung Baek (3):
      drm/imagination: Fix reference and vm_bo handling in remap()
      drm/imagination: Fix pvr_mmu_map_sgl() overwriting its own error
      drm/imagination: Size page table preallocation by device address

 drivers/gpu/drm/imagination/pvr_mmu.c | 29 +++++++++++++++--------------
 drivers/gpu/drm/imagination/pvr_mmu.h |  3 ++-
 drivers/gpu/drm/imagination/pvr_vm.c  | 13 +++++++------
 3 files changed, 24 insertions(+), 21 deletions(-)
---
base-commit: 98c7fc4219b93f953ee85c07fb6c8256046aba73
change-id: 20260927-pvr-fixes-a-40876d8bbb25

Best regards,
--  
Gyeyoung Baek <gye976@gmail.com>

