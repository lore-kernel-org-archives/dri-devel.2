Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3F606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuFdukRC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4FA1125F6;
	Thu, 26 Nov 2026 16:53:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8588C1125F6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:53:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08F6060CC9;
 Thu, 26 Nov 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795712010;
 b=Sgl0pbMK8owNKAwEydNCqIMKb/Ub+Kj0ZQJ0EtraQIGckxeePTFonFCgIcvhPqOyYdYN
 Cb8dVS/HvqLuZVQUz947ihP8pXQ7WXs7XQqn0usZxtl7MGeTcJ3lFa4J0eWvjq3nr8oWc
 yvWuG+MuSjoPnTf2RQs5hZR0jErP5a3t8rs7YALgDcKZDy8jndi3k7ud/9PyFDLnrCOLF
 52mvpKx8v1mcr2vxEYfUVvqlTatxtQ6jFUh750ks5MnHr/DiuxS5q1R6dAXMjqkkFDPne
 Q5tQt2HhuRHSN87gbFxOU+sG04/N1lFPhfJDDdhKBzNfZU1PDMpM1NA93oF7rDe8aFA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795712010;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=IocBkr6PDwSRlU4c2lXtALJlV7Kvjs3SeXTIcIHDx1g=;
 b=AhEC1kLky08dm6z3jvHcamFv073yM5CyYmI5uC6JZYV0o1faHDZslYqexiPVeIXrsU/H
 gNp+703RJgf41o9NhBA0G6Ud8EzF6aOM8uDLnH43Jsgy4/IgL5Ydiw+ZcsWXosZE+mz/p
 YDF0l7EjZaxazc2gz1ZyIk/Y7NEwiBJifpNqt8kEE4x/a4XK4c6axQ6/blntVQe3ywVMJ
 AK3f/xjREwtno3VNBpoZH92xF+Es4HIyXete414VkHxYHcUc+WbORNq9M550lsuy/YVH/
 RFY9L8EEc0ayj50iRKDjUsx2iLB0adYM+lhjPOVCvaRN682qr5v87p//v6nS6h+N4OA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 6A5ED1F000C0;
 Thu, 26 Nov 2026 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795712010;
 bh=IocBkr6PDwSRlU4c2lXtALJlV7Kvjs3SeXTIcIHDx1g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=GuFdukRCD5txeQ06sjzV4auUT1oYWV0+KBNDtZke8n4c3irhaV/AME6XAXPgoJLNV
 69s0niWczyIZWi3AiJqm9aZDZQY8vx9oO4PROaRfdBg93UAdApg/xpwq6kbjUPRfEt
 jUNpgplOMo/dUENqojrL6D38HQWK9tw9y1RQzyWzEIY4hSOtDVCSTT2XV5RoHjrTOy
 mX3j1QFfwaBMUtIQOoSimQbbTAoDlSuvxiy82rpmqMUmkhuwCtsPCnq6DknOc8o+Oa
 5FmLUwv/AyPohGj6kjwc9ZN10k1IZay72chCleaookqeMZS2jSF6qdzVLuW584iXOI
 nRoDqj5ZsxUpA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id EDCB14D740;
 Thu, 26 Nov 2026 16:53:19 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 17:53:17 +0100
Subject: [PATCH 3/3] drm/panic: Simplify QR error correction exponent reduction
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-perf-drm-panic-qr-v1-3-51856937dc4d@gmail.com>
References: <20261126-perf-drm-panic-qr-v1-0-51856937dc4d@gmail.com>
In-Reply-To: <20261126-perf-drm-panic-qr-v1-0-51856937dc4d@gmail.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795711998; l=1585;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=jOYNOD5E6yoy7JZimrIqJExB0NGTGDoxm0GeT3zDnb4=;
 b=kva8hevRr4jLZgPXiXP32AbjpKIn0JmGDc+elnVXsnDOvTOQH9cnOU+iv4pyCxeUrnrBXQhzb
 DganHaRZQGeAtcg8bTINMuOIo4dDq6MrJIgNPkJViYolYbcqUMhTfb4
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: peder.bergan@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peder Bergan <peder.bergan@gmail.com>

Reed-Solomon error correction reduces the sum of two GF(256) exponents
modulo 255 for each generator coefficient. Both exponents are below
255, so the sum needs at most one subtraction.

Use a conditional subtraction for the reduction. In the x86-64
userspace benchmark, this replaces a multiply-and-shift sequence with
a comparison and conditional moves. On top of the first two patches,
the change saved about 32 us per version-40 encode with raw input and
31 us with a URL.

Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
 drivers/gpu/drm/drm_panic_helper_qr.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic_helper_qr.rs b/drivers/gpu/drm/drm_panic_helper_qr.rs
index 1d96ae855052a..4ba2e3de5a6b6 100644
--- a/drivers/gpu/drm/drm_panic_helper_qr.rs
+++ b/drivers/gpu/drm/drm_panic_helper_qr.rs
@@ -569,7 +569,10 @@ fn error_code_for_blocks(&mut self, offset: usize, size: usize, ec_offset: usize
             }
             let log_lead_coeff = usize::from(LOG_TABLE[lead_coeff]);
             for (u, &v) in tmp[i + 1..].iter_mut().zip(self.poly.iter()) {
-                *u ^= EXP_TABLE[(usize::from(v) + log_lead_coeff) % 255];
+                // Both exponents are below 255, so at most one subtraction is needed.
+                let sum = usize::from(v) + log_lead_coeff;
+                let index = if sum >= 255 { sum - 255 } else { sum };
+                *u ^= EXP_TABLE[index];
             }
         }
         self.data[ec_offset..ec_offset + self.ec_size]

-- 
2.56.1


