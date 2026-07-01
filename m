Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD401C44501
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D8D10F1C8;
	Thu,  2 Jul 2026 07:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rD8WSX0D";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e6T9RzQu";
	dkim-atps=neutral
Received: from flow-a1-smtp.messagingengine.com
 (flow-a1-smtp.messagingengine.com [103.168.172.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D799A10E368
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:43:28 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailflow.phl.internal (Postfix) with ESMTP id 266B0138003F;
 Wed,  1 Jul 2026 08:43:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 08:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1782909808; x=
 1782913408; bh=hCwzeqiZqQn1EeYlAWoOxLI45HYxj+0NX1TXbYFjUzw=; b=r
 D8WSX0DqJbUdVz6AHBANjrmqDRkZc5VPtN43qTs/l4g4FbmQ5ZNUhXHyUxTW5a8Y
 mwQNE/fAFil76hhDIRE2bl2rP018JTTf2up0OWj3fKZFXWvSD1TTJYXoZcwbUL9e
 N8mhhlFkhZDv/6daIsHEV6cjlwUDHiO7Djorc3maReyyHci3smWnPJgEwXP+5/YY
 RLc5A/cdTRt21PcRZ1fyAZxD0rQOlOEkMn5qiOUak/9hNxNvK7KuGy1QeR/Q19kZ
 7ep47fhIHtdXlMEMfioWzVT9ZgALg1XuhA/6PGkZ2wPGl9BAs+hcuWtDojS1aaDX
 E2TdL81IBtmxrcm76wSEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1782909808; x=1782913408; bh=h
 CwzeqiZqQn1EeYlAWoOxLI45HYxj+0NX1TXbYFjUzw=; b=e6T9RzQuQ+I8UBQTW
 hK5sN8FkEBKswUHmZADrc7HYz141TSunuSm0Ltk7KfsSHywxsJKM6FiOlloXeesv
 Nz8/ikOxJibwkEGJotHqcYv7extfpVHNBiG7m58p/1XDA2o8M4EUKs2PMTDW6fYj
 ph5dA5nXfzmqIMFliMhIoqCeVydBiezKGBSF8ALjSzdeQhYxt8naXsaM0oOYkiVK
 NzhBe6bq+eH5iKYqYfjw/Vkx1rrXPoo/c7g8BFitl3h3fiYr600XEZ2aGqSCRoQ7
 /aYlIVXJcNI/RvS0zuWXaOClVUPq9NUeLRe6oWAeX5DkWI2xje1IhmjtOcWWX7Bo
 0nrBg==
X-ME-Sender: <xms:bwtFakFc93EQo32GPTamIwyMo15cpW4yXdOzJuQ490gK4ZbGV1QP_A>
 <xme:bwtFajssi38r77oeM_nZjUW3kj9vNcOBCAb2aVrdXzjUayg15pYf01URb087tqx8b
 aaTos902Z78KAah6Y-iOYrO-XFLXlBfPU_cwafaRJ6yhHyvRrVAHSw>
X-ME-Received: <xmr:bwtFaqb4UsVkTTrUxhfHOTvaeq3qm4oYArIAgYaD-DqFpbU8ZUPKjHX->
X-ME-Proxy-Cause: dmFkZTGBq7gKXug1IiWhHduKANkZDifvXsa10TKTCAkjtHbpw+32P+uDSNsh7UkqvDQz35
 5GsHfrpOhzNQ1YRMDLdtqkOKtNwAwX1eLMORyfL/k5Bv0/h3xMPq24mqgBlnnW8okBxo49
 osinnLxNinneVAeoo0euooMolnMfXRKLx9mOA7Ss2txEYNyheFI/9Kz5qGOBqwW1sTiJ1O
 NGHLHrFzxgzZEsteBMU+UgtmSy0K5UPUyve8VnY5EyBP2gFc6UCU/NWsqHftDntCABhJO3
 q+i4+j3A4csrukzVj2fTKrlpDZ5cL1beypvxpyUHK5JKJ7qqdrnCdx/RDBFzK8sd0MvTQ2
 b6tx4BWzeTxZCDDwqPet4r4u4VOMJPIEHG8KeWRWTnyDQiIDKwfhOyD35FPvjJo/fF4Dja
 oFv9NvtVaNCz7/CyCHmkrUB5DVuEfyRZsMRrKZrpeGY+8fNeX+So2Oq7yUokfyCFfe9cbV
 DR+Bm9SGLnZA1NU+e9ZN732JieVRyWPFTqXtSorON0ESvsu3svlaYKmx7UzOa+sG1gHBaD
 quBZ6qBwr/9cIsLX/QEs0udoJXjywOnAX3HK13DiqFdqhDgDY6Y2NzLHCd06vRlpE2U4EA
 8uDzq3K1h70plC4Lb+r0eLwID2YFChNe5w17lDWvaW0TYiF5RxHUHireU+UQ
X-ME-Proxy: <xmx:bwtFaj6iLiK-9MEumjjtE1fJfcbrcdkK_EbXMv1NbH30RojajsfYQQ>
 <xmx:bwtFai_TsGE6KhYgsquBnJlVhSiTiL75VlJKXapyb0m8HEPtJybDVg>
 <xmx:bwtFavZwBPUPChVBH9uUZ1U6k4H0bsUFuUJjzPpNc3sIZCYakHfviA>
 <xmx:bwtFar7_FkGf7EJV5h5wOH1JzcZmZzv7E8xaYwiZkZOabmmGdkFCag>
 <xmx:cAtFaheSxioz6neWGl0J38gnpNquBZl-HzMHqRRqmeAgFuY9Ov-f6PVJ>
Feedback-ID: i9dce4b48:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 08:43:22 -0400 (EDT)
From: Baran Tuna <barant@fastmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-doc@vger.kernel.org (open list:DOCUMENTATION),
 linux-kernel@vger.kernel.org (open list)
Cc: Baran Tuna <barant@fastmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] docs: Fix typos under GPU TODO
Date: Wed,  1 Jul 2026 15:42:39 +0300
Message-ID: <20260701124239.9713-1-barant@fastmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <01433E06-1132-4580-93FD-D6E82341A041@infradead.org>
References: <01433E06-1132-4580-93FD-D6E82341A041@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

Fix minor spelling mistakes in GPU TODO section of documentation.
No functional changes.

Signed-off-by: Baran Tuna <barant@fastmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/gpu/todo.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index cdddf8db35f5..b8c01e3fb655 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -55,7 +55,7 @@ There are still drivers that use drm_simple_display_pipe. The task here is to
 convert them to use regular atomic helpers. Search for a driver that calls
 drm_simple_display_pipe_init() and inline all helpers from drm_simple_kms_helper.c
 into the driver, such that no simple-KMS interfaces are required. Please also
-rename all inlined fucntions according to driver conventions.
+rename all inlined functions according to driver conventions.
 
 Contact: Thomas Zimmermann, respective driver maintainer
 
@@ -277,8 +277,8 @@ Various hold-ups:
 - Need to switch to drm_gem_fb_create(), as now drm_gem_fb_create() checks for
   valid formats for atomic drivers.
 
-- Many drivers subclass drm_framebuffer, we'd need a embedding compatible
-  version of the varios drm_gem_fb_create functions. Maybe called
+- Many drivers subclass drm_framebuffer, we'd need an embedding compatible
+  version of the various drm_gem_fb_create functions. Maybe called
   drm_gem_fb_create/_with_dirty/_with_funcs as needed.
 
 Contact: Simona Vetter
@@ -303,7 +303,7 @@ everything after it has done the write-protect/mkwrite trickery:
 
       vma->vm_page_prot = pgprot_wrprotect(vma->vm_page_prot);
 
-- Set the mkwrite and fsync callbacks with similar implementions to the core
+- Set the mkwrite and fsync callbacks with similar implementations to the core
   fbdev defio stuff. These should all work on plain ptes, they don't actually
   require a struct page.  uff. These should all work on plain ptes, they don't
   actually require a struct page.
@@ -891,7 +891,7 @@ Querying errors from drm_syncobj
 ================================
 
 The drm_syncobj container can be used by driver independent code to signal
-complection of submission.
+completion of submission.
 
 One minor feature still missing is a generic DRM IOCTL to query the error
 status of binary and timeline drm_syncobj.
-- 
2.54.0

