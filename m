Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912D3CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22C310F6A1;
	Thu,  1 Oct 2026 13:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F7HUCIjl";
	dkim-atps=neutral
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7892F10E429
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:39:57 +0000 (UTC)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0d31bda43so4172717a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790861997; x=1791466797; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3/yY7EGLa578fMnsnENYv1TYQDj2Pi2TjDEnt2TLl9Y=;
 b=F7HUCIjlPNfsWzFrLGbVaVQmRKP9xzr+YzAmIQA0sE4TkyjDe7TL95S3rqNg4Q/fBS
 DH/qNq3aBP9oVCGx3P+nx2adlh3g8kAzIEh5yTwJ1lqMgxNII7u2IMzuKcfPBweI9VX9
 oKA3/my8k5mX6qyPJMdR0M5Ml0l/NWLj22YrcDoxS3oN5LkisRX9tLtq/jgim3Qyk6/n
 n5tOQGqEnMN2rGZ3hwMWnoktic6It968jGSnOY0SSWt5iEy+dDPgayJAkwpapg705UWC
 +WF/WfG55zPh7Axoqi1aVEXkimXOiu+3ONpl/sDzW1VJn1X0ZVxgcBQw/+h+bwUAlxgJ
 tIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790861997; x=1791466797;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3/yY7EGLa578fMnsnENYv1TYQDj2Pi2TjDEnt2TLl9Y=;
 b=MAxBnSC+vOoGTAltIAEbGahQt7lKVfe8JmEivknzojRnr28MB7+rH7tzL7/9bf8kC4
 pyqsj/aBJ7FRaJxs68mrj9xGMkOZgcmDu2TuQagn7I2+I7LBxdkKvktSaLubZCxQtIt/
 ckPmle4hr7hqHo6q75pOT25Zwwj3T7G7BRXciovbm+0BT8K5rBvzUURE9j4P3D0B4ryJ
 BcDG1pv8947UHsCQu1wz6zCRr5KRnqg8pSHjOKOZPp4fjjuQZZfi3bGKufVL0GM4WtXU
 qAo4lpzr1N58+ASwboAbGj0qVxkjCC/aGw0KSqD+44u/SdE5en8jy9tk7Cy7q4GJom4P
 eCkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx999W+Jn1f5T2nV9K7+A+s8Z8dEzcPeMFoQZBp/81aOyTXb31mih0RmurVThWYQ72a3EMgmj6KwaU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJSb/+wUSF0LoZlAXIq5dIFZ23mJY4nvs2tjbSXQFGjou7BIX7q
 TXWNLLMCi1swwIJANu3Ppraa3LV8lskSUVIFfSPO9EJY/Pp1sd0Lxgn/
X-Gm-Gg: AYBFou12Ndl9UttHXPdDyZIejWFbRoRAdyerxLNMcQv8Lv5U3s9PEq9Fb2XEn/LioL1
 tIUkeQePJxjxoPpCF34MsQfJDZcD8IHdp1M2A6axauq52sdtwihdUHPTap0/vTJ9Q8ZWtMlae0t
 ZWpFAyHTMY/QJCQHZwcGIvg1XVSOxi6G8md+4tsJZ4+9RHxqoY78Fg1gTe4e0kS5jFm/0Wa1wzY
 KXyuz2TDy5BHAZ7YLnH0v+xvqHseffsXHpKEyAswXKmS7aLgJcew7aOg2oLTVzRuXHlqokYsnok
 nT4dwm2QxnUgHT+5+veN0h+ZtHJ/UPYHaMKQPF9ZNtVBwU5kB8IXXc9O6tMYcQH+YRKrz7lZ5F7
 wksaWZEj8ROZTiNz/6JdAfm0sfU+Xx9LjzgHxfsQXGv93knGnusIm1WbKHuOgy3rPZDW3nhdX+A
 oMks6O8C+fIXQVo2Pj5ClReTJ11LxujogIOUT3AO6NQ/r0yb6v9dHPXtxlWIWrurM=
X-Received: by 2002:a17:90b:1c85:b0:3a0:ab20:9e97 with SMTP id
 98e67ed59e1d1-3a4d197a3f7mr3920815a91.15.1790861996631; 
 Thu, 01 Oct 2026 06:39:56 -0700 (PDT)
Received: from [127.0.1.1] ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f47cb357sm4673435a91.17.2026.10.01.06.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 06:39:56 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH v2 0/2] drm/imagination: Fix pre-existing bugs flagged by
 Sashiko's review of a VM_BIND series
Date: Thu, 01 Oct 2026 22:39:11 +0900
Message-Id: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH9ivmoC/22OTQ6CMBCFr0K6drQ0AsWV9zAsOqXCGAukxUZDu
 LstxJ27+eb95C3MG0fGs0u2MGcCeRqHCOKQMd2roTNAbWQmuCh5LSqYgoM7vY0HBWcuq7KViCg
 KFhOTM5sUA7dmZ//Ch9FzqkgOVN4AOjXoPr1aZ8GS16ffsVcnZ09+Ht1nGxby1Ph/Q8iBQ3UvM
 JcKa1mra2cVPY96tKxZ1/ULWJP9MuIAAAA=
X-Change-ID: 20260927-pvr-fixes-a-40876d8bbb25
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexandru Dadu <alexandru.dadu@imgtec.com>, 
 Brajesh Gupta <brajesh.gupta@imgtec.com>
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

These two patches fix pre-existing bugs in this driver that a VM_BIND
series depends on. They address what Sashiko flagged while reviewing
that series (see Link below).

This series is based on drm-misc-fixes, which already includes the
"Fixes for map() path" series (see Link below). Patch 2 is built on top
of 0a8224058a58 from that series.

tests/imagination/pvr_vm_map.c, sent separately to igt-dev (see Link
below) and not yet merged, tests these paths and passes with this
series applied.

Link: https://lore.kernel.org/all/20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com/ # VM_BIND series Sashiko reviewed
Link: https://lore.kernel.org/all/20260926152341.783867-1-gye976@gmail.com/ # IGT reproducer (not yet merged)
Link: https://lore.kernel.org/all/20260922-mmu_fix-v4-0-12f1a871456a@imgtec.com/ # "Fixes for map() path" v4
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
Changes in v2:
- Drop v1 patch 2, already fixed by 7b824c293a6b ("drm/imagination:
  Propagate map failures correctly from pvr_mmu_map_sgl()").
- Patch 2: add 0a8224058a58 to Fixes, as requested by Brajesh.
- Link to v1: https://patch.msgid.link/20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com

---
Gyeyoung Baek (2):
      drm/imagination: Fix reference and vm_bo handling in remap()
      drm/imagination: Size page table preallocation by device address

 drivers/gpu/drm/imagination/pvr_mmu.c | 25 ++++++++++++-------------
 drivers/gpu/drm/imagination/pvr_vm.c  |  8 ++++----
 2 files changed, 16 insertions(+), 17 deletions(-)
---
base-commit: 4d0e2704118511e37790641d591454354e7c0d6c
change-id: 20260927-pvr-fixes-a-40876d8bbb25

Best regards,
--  
Gyeyoung Baek <gye976@gmail.com>

