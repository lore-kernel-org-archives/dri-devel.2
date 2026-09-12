Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158E6C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFEF110E9EF;
	Sun, 13 Sep 2026 20:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M2xLuZAz";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B302510E076
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:54:20 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso1797485e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 22:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789192459; x=1789797259; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LAaqUssbGV1ECiiHRed3l4YR1E4BZ9oxbo2ZGY4QlSw=;
 b=M2xLuZAzIiHvUiNWwVRQhZQOaOWVOnDSVAIsZGcrhriEelkFyJ9Gb1OMCYbsD4iw4N
 ANYYEc8Cv9MI0ELTLWMmhmKwqMhIr986a5GUmsD7PEa05VA3ofqlj2O9e5rEo5Wr0RXT
 Cu8rBp2xrsM3Gk7ao3a5iiVTZEZ2XLo4xlMHuqpU4qne4DTtKyizEgK0K9wFDSBK3MJ4
 fulvqAYMrpJYnNlKHY6qVlf93Ou7YcQyD5ZINMjWj3aS6plsOrhwRUmOVs3TOD4mnn9B
 /Gw7JnYLs2ZMbNybvMHKdts7rP8Evf4nh3P0mWGpbFsadGkvanb9hwFc0YTsSxjtvFPN
 i+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789192459; x=1789797259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LAaqUssbGV1ECiiHRed3l4YR1E4BZ9oxbo2ZGY4QlSw=;
 b=roIiLnCFpZlV2ZPaDn/OiNUDW5J5Ov/lfu06wZIJhcAj9ggyxqQ1iWq13LiTikKGiL
 dh4lMWlAwkLzJjFZIJ3E7UGDrGzscYsik1raN1UxAAmClb5JyQDrdDbm37AKC1DSp4CS
 atclE2Dfq3h7HL4kIYL+HVWfNEzMC7Lmw0yP8iA+EEwe1juBosjJFtaV3OPYtTUoNUkX
 weH/iQn6+WCl6CxE+48Js5sgggL49KzyDFqwGC3WFXdahfk8aNkdNqEdPJtKbZEFBM/v
 M1lEPJsntD33M2dq0UdDstTnbOp5r0WCDZKc4oP7HygZxOCCbunSGjWo+fsOpFVJ3K+C
 7ICg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3QFA+E4qOJHIoSDaxLAS+k/B3RUF0OG0r94tJvYWgmx4YaSBpLZDvKlnMVWN83Y7wNWrKmy+zJIM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l1QCetGgdoWa7SEVr4YGRz+d4aVmqsgQw0kPQiKy5Gm82UUAKl
 f2YYI4095rTu60uNAZLw4v+VXP/svEakxbHJ060qWiNSE/mFJjUnJkxQ
X-Gm-Gg: AYBFou0hEEGDjJLtvhDpzyU6eshIxzOohuADUgIiiB5xrT1A/U1E6b6QCv7kU8mmIF/
 phGZn0Rb9FhBm3QWpyWaJStQQIohwVScAaS3Nk8rJwkydq1Sr++55ES1lfLK0JdIM+l5iRDjN34
 UCp48/nbJ5qP/y7RHIhXuRVQ+EVjg4mUh9I0aCu0XO4TvsJkGcw480eTrUlwFANmIiqE2nJGfkk
 UXJqm1G8Pv2HtFytjv1771HWjAGLJFDHyG2qzdMxu3vaa+G1shbahh8rIvrv9daJKS8Bf3SNe1W
 TjcT1vS3a/Yk5sZRAMn7OiLA3G2YWqWXmLeLzdydKoyFwN4ViWKEt+8bTIjxmV4zvBhOLBm2yF5
 5jpcUIL6Tpu4pklTWy53VaeeeZJ2nD2IbAEPtEuXcnb1Pl7psqnzzU0/Z0GBUv3dPqi8UcUDMLy
 oDptkixhfwlFe79eNHekcQQCtkYpDuKHIzSK+HYz/OViIRsIFMnagtIOU3wPrUu5LTaEXieQiM4
 8KBmzowScR96MWRQaly9MJ6Cz/g2a2Md/IcQ0dKewZa9lQEKvHK4fZi93Ral7tRvAvrmPdCirwo
 N2UA+ZGS5qTsbxv/dPXRoFLGjcLLiQFS/VUnDuZPEtWpj3tlctkhBaG1tkwmtkyUPThxu/N730n
 OGvnF+sM=
X-Received: by 2002:a05:600c:4f87:b0:49c:fa20:cc04 with SMTP id
 5b1f17b1804b1-49e6cc142c7mr11217395e9.27.1789192458728; 
 Fri, 11 Sep 2026 22:54:18 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de.
 [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm359490515e9.6.2026.09.11.22.54.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Sep 2026 22:54:18 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panic: Fix the get_scanoutbuffer reference in kernel-doc
Date: Sat, 12 Sep 2026 07:54:14 +0200
Message-Id: <20260912055414.39664-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

A kernel-doc comment refers to get_scanoutbuffer, which does not exist.
The name is get_scanout_buffer. Say get_scanout_buffer.

Fixes: c9ff2808790f ("drm/panic: Add support to scanout buffer as array of pages")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/drm/drm_panic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
index ac0e46b73436e9907326de29c393da3024876dc2..2a849c07eb72f6deb0ca28fbfeffff64cacf1b3b 100644
--- a/include/drm/drm_panic.h
+++ b/include/drm/drm_panic.h
@@ -44,7 +44,7 @@ struct drm_scanout_buffer {
 	 * to the array of pages of the scanout buffer. The panic code will use
 	 * kmap_local_page_try_from_panic() to map one page at a time to write
 	 * all the pixels. This array shouldn't be allocated from the
-	 * get_scanoutbuffer() callback.
+	 * get_scanout_buffer() callback.
 	 * The scanout buffer should be in linear format.
 	 */
 	struct page **pages;
-- 
2.39.5 (Apple Git-154)

