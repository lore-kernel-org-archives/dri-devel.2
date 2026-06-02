Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637B2CD6E5D
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 11:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 749A610EFF2;
	Tue,  2 Jun 2026 11:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="S+4bM8BA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A549A10EFF2
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OqITYPON+V4iTiCCn+FZ5G5jdIoo/ylqj7tFBDOvcwU=; b=S+4bM8BA/V3ou7ChjXhvga8/Zz
 kY9+sdIaz5vJEbouqbJKOLZHeMnAqhF3MlHuUJ5jtp1UNhj37+lxsAL1U6VmCN9HH+uDPGbQu0iML
 nneUppltx9e8v/K/2DUXfYbp3UWJQpycuaUfRZYnoZaxg5h0ibTCElOQS6cphtutO/qK6P+0Zsshs
 9l07wOZgVw1ghT/h4ZzTR84aiLo2E3xRHEM2yZKS3bFu/mSQEQfhvTBWJFn7xECiFD+GguItwwARw
 YrqKp2pErug7EfEhxFhwZeCKw4xaBNtOvgen2DVu0103tWhR89z35BE//2h33kYm95M1veMFhjI98
 mYQiSmJw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUNk8-00BgWO-UB; Tue, 02 Jun 2026 13:57:13 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v3 0/2] drm/v3d: Fix indirect CSD jobs with zeroed workgroups
Date: Tue, 02 Jun 2026 08:57:05 -0300
Message-Id: <20260602-v3d-fix-indirect-csd-v3-0-cc79e06e543c@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNzQrCMAzA8VcZPVtpGxunJ99DPHT92AK6STuKM
 vbudkMQQY//kPwyseQj+cSO1cSiz5Ro6EvApmK2M33rObnSTAmFQkvkGRwP9ODUO4rejtwmx7E
 WaIMSRu8NK6f36MvOyp4vpTtK4xCf65csl+kbBPEbzJILLrUGOOxqRAgnas2VzNYON7aIWX0UF
 PKPoopijG+CAN0cAL+UeZ5f1WbBjv8AAAA=
X-Change-ID: 20260516-v3d-fix-indirect-csd-6806cf20a57a
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=xVzNQGTQpR3ArjteG3mXq0M0AhmRGBBW97tblgH89XI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHsUVRRPK71dGGp1ythC6+++t0WQQrT7h+jqvm
 d+NH2HQOXeJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCah7FFQAKCRA/8w6Kdoj6
 qrtrB/wPt7+4QHY5Sm9fdtAdOi4x0S2Y22/EzNzo8mwNT6bmAsQfzk3ME2H5qQ2S+5jCGlnEnHO
 ip3q09+xlmi+5CgwrGN8rdoUvggL2EygeNch7ngm1yxr5C72b74NdXeRb/dn7H/7SZvMiBy0uxF
 GCKoYUKN65RT3mwPV39N71xGNDoJbgUq+iOLwFfr2nR5sXSa8v+xoPcjNYQsAtsyhVeE4TmoqFe
 NOviA0Agz9d56VaIx8CZcCR5hviuR5ZFk2VNEdYsc6HH6wbpEZOQcDvj6REt1lvA50v76MCSXOO
 YaaiYIzT7HGiL9bIuszQxgu2+PLkm1QGbFM7SDd3e1xfgxUr
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

Hi,

Indirect CSD lets userspace defer the workgroup counts to a GPU buffer
that is only filled at runtime, so the counts are unknown at submission
time and can legitimately turn out to be zero.

However, exercing this case exposed two issues in the CSD path.

  1. Virtual address leaks when the indirect CSD has zeroed workgroups.

  2. CSD jobs with zeroed workgroups shouldn't be submitted to hardware.

This series intends to address both issues.

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20260530-v3d-fix-indirect-csd-v1-0-15533948663f@igalia.com

- [2/2] Don't check the whole cfg[0-2], check only the number of workgroups (Iago Toral)
- [2/2] Add a comment about how the HW interprets 0 (Iago Toral)

v2 -> v3: https://lore.kernel.org/r/20260601-v3d-fix-indirect-csd-v2-0-aaebf035b936@igalia.com

- [1/2, 2/2] Add Iago's R-b (Iago Toral)
- [2/2] Adjust the comment to make it more accurate (Iago Toral)

---
Maíra Canal (2):
      drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups
      drm/v3d: Skip CSD when it has zeroed workgroups

 drivers/gpu/drm/v3d/v3d_sched.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)
---
base-commit: ae0383e5a9a4b12d68c76c4769857def4665deff
change-id: 20260516-v3d-fix-indirect-csd-6806cf20a57a

