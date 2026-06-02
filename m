Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C603CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4778710F47B;
	Tue,  2 Jun 2026 17:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gDTMEFpH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE54910F47B
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hnjPHFnIOQBuotWFFvevqHK9mM8IjJ0IDLkDeAfybkg=; b=gDTMEFpH5h8REIIIcH3Zr4xbww
 YiLiPzK4DgEh0R01fpMx781WQd/eSFieSl9BVxzVnaIdFua7jSMWmez2kHRNlObTyzr6iPBD+DtHM
 wl3/kSizDgkU/P75b/mhCHqiwZN8+Lc3gS5c9oGT9ESA25+g28T8b5OhUH0S4cU+c6RejXjeAr0tO
 ktCSPn0guhCpYsmzKf+4C9KhwfP22ngi1zuR6+zyuPf/jKkAxnNPUGkri2Z286+Msl/0InIbJA9Rp
 3bUOW3k3yg/0Uk1i7t9i3/kmAdxp9ekIbPd9mwT4+95U/M3A7KiLsvMrcs1dWarGlpJ84kuqnc8lD
 J8Bja2zw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUTFu-00BpDx-Rr; Tue, 02 Jun 2026 19:50:23 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v4 0/2] drm/v3d: Fix indirect CSD jobs with zeroed workgroups
Date: Tue, 02 Jun 2026 14:50:13 -0300
Message-Id: <20260602-v3d-fix-indirect-csd-v4-0-654309e32bc0@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNwQrCMAyA4VeRnq2kzRqdJ99DPNQu04Bu0o6iy
 N7dKoKKevxD8uWqEkfhpJaTq4qcJUnflaimExX2vtuxlqa0smAJnCGdsdGtnLV0jUQOgw6p0bQ
 ACq0F7+ZeldNT5LLzYNeb0ntJQx8vjy/Z3KdPEOE3mI0GbZxDrKsFEbYr2fmD+Fnoj+ouZvtSC
 MwfxRbFe962gG5bI30p+K7YPwoWJYR5zUDsKgwfyjiONwNyFf9FAQAA
X-Change-ID: 20260516-v3d-fix-indirect-csd-6806cf20a57a
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=A7lnRaThiYl0PFmNKnD2kHwzQgqugpCR/BRlRbYw8aI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHxfb41P3jkgJW/D6xnzp6jT6t3MH+Cm1OiAGu
 TrC6gwdQEqJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCah8X2wAKCRA/8w6Kdoj6
 qivdB/4q5q6w0DF8rr6Cv28K1Z7rkLEIHFKWJppsJQ9Ybug0vUvqvn4x2zoTnQa97A8T9cWVmoy
 qSszRgw2nm4yfJWxEENwbE32q7DeUMvV+L2rYb3fubTcutY2MWRq615gphhGPTlbpd8fuY12Nme
 QHWnbKTBgyse7jf+oqOymX2+se0/kFblGv4mjn9ygqD94tbOo1hT9bVs8ufgj4Qf63eWMOvd1xe
 b/aqGtWZAXxiGzKR1kmCQGc04oMHK5ybpuMsGsZc5V8uDlHusK/aXuumLHNZAaxoRRcc0aAe4VY
 jkv5lHXz2KCtgay4qQcHKx0ZbUpw/JgpJWuJFLvYiKhItAi6
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

Tested with the following CTS tests:

 - dEQP-VK.compute.*.indirect_dispatch.upload_buffer.empty_command_x*
 - dEQP-VK.compute.*.indirect_dispatch.upload_buffer.empty_command_y*
 - dEQP-VK.compute.*.indirect_dispatch.upload_buffer.empty_command_z*

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20260530-v3d-fix-indirect-csd-v1-0-15533948663f@igalia.com

- [2/2] Don't check the whole cfg[0-2], check only the number of workgroups (Iago Toral)
- [2/2] Add a comment about how the HW interprets 0 (Iago Toral)

v2 -> v3: https://lore.kernel.org/r/20260601-v3d-fix-indirect-csd-v2-0-aaebf035b936@igalia.com

- [1/2, 2/2] Add Iago's R-b (Iago Toral)
- [2/2] Adjust the comment to make it more accurate (Iago Toral)

v3 -> v4: https://lore.kernel.org/r/20260602-v3d-fix-indirect-csd-v3-0-cc79e06e543c@igalia.com

- [2/2] Always rewrite CFG[0..2] from the indirect buffer to avoid
        preserving stale contents from user space.

---
Maíra Canal (2):
      drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups
      drm/v3d: Skip CSD when it has zeroed workgroups

 drivers/gpu/drm/v3d/v3d_sched.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)
---
base-commit: ae0383e5a9a4b12d68c76c4769857def4665deff
change-id: 20260516-v3d-fix-indirect-csd-6806cf20a57a

