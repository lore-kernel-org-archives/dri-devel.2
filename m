Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8FEC88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAED110EA0A;
	Sun, 13 Sep 2026 20:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="newOX2Qt";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7A010E668
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:29:50 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49e6deb520eso3511665e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789198188; x=1789802988; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PXc+4SKfKNKk/rs+2uET25nPCHn0nrmdn1gdEMSeqW8=;
 b=newOX2Qt0GWvn8kt16iHhxAAJ22kU2F9R+Ylfpy5KIsh15j6pFtejwS4R3BRaco+T3
 ZpLZ46OOWruGH9tfxoMKl4DfZBaQrAP/UgHng8LOcfK57DGiMDlUFtwe9EI6OQvBeWvZ
 wgFUqcDFQP4dK1115YUgy+dDYbheEbJwxPPJem+bKNbCHdTIQoopIGXwCBU65K8grkKn
 WC7tuGQgZl5X8WnkY3YW53qRXc68ff49skKwqGkuAwxZXGPKiQDV0O1vYAyTjIwnon5/
 A7RySWmwAovKus2zuqMVOb513NhUYl/ZmNSog98o21sL4GKhJrev49ZdT6N3zOR0vrpz
 FZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789198188; x=1789802988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PXc+4SKfKNKk/rs+2uET25nPCHn0nrmdn1gdEMSeqW8=;
 b=j93kH2tq8Q8Prx0SQCDVPu4/AK4PLiQBKmbRSSVrmy1ItM4Jcr0iFAbWYAhLcLlBXv
 qGBVm+Ply6+SIkvwAthqauJA5f0wOErA5cMo/BDWoujjgfjqZXE9mVDmh+tcUCjBrus/
 HQNxXcEzGwdoM7LfRK0ZmnSO8BhIIrOEqcMzMh127uxkBntDpNi7I9DCQPdYT7d4CnUN
 5lhEffnGbUu6aHZp7TtqSfxjjvRYXJQ021HdDWlybFDhCqVHKGDkYLcN/VsdRt7TO051
 5xTNXKG57O0Qy90ehBzdB4lLuEo4fk1emE8CllbPwAlo616hOcZ6pnNjxjiTlY98/m9W
 RR9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBywDaOPyT0IY9D7HNuzjfM0TRr2KgRXCUjkqVVB5MP2OAG7w2RRZJQ+AzqmnNJgU5lWdVB4GR3j9lY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m7yL4I4MUPsSYhqlLYesUXS8gpl7ALEL5Rf75DCECY2E611UHR
 IH39dN0gHv3Nv+arYtXUXy7LJw1m+wduyMq6jRozFr/kJzE8LdmZIFow
X-Gm-Gg: AYBFou0YxsbmYru2JRkiozsVaxwWqEh1gIT1uLMEFYrOMkv5nRuOMLmdgUZKGJpCEZ6
 KLaIqV/iRe8eaun/Kppx4U0Vg5hyTK4ZOuID90JjQw5k/QheSJJwoxklFlZZ1+CdO2IjprFdlyE
 k2DzbMwXpqm5sxxlMfaTA/LgdYDNCbJiHyY9EVqNNn0jYDqZd2psaPv2wjfrpPYcSGPADaeqfmD
 wXH2deJhx4SF1L0B8RnNvJ06NL7VU0ccwjppVScQeSxPlmkg4Y2N/YS78PT1swuxMDJEUAUpyW6
 RPXssWc9NKyn+slcQdENhJptSTx0R8FlzjXi0oZoZnh6D07R0WgeunrJZ4NN8+zr3n3rW6D89bC
 FiBkb0s35bmr76ztKjoISWD2QmDWPvlvPYfEqPuZzIwTYOC+GMWJXofmKg0Fc1mRbxybrCCbcX+
 +eMu9sbcIMNLo97WlQWKvgokZM0V1V0rrKpxztLFNyf+RsJdUQ/xRLi7BcmwxZJec4yg6YBaC9w
 kRBGU0EcVvVMkOY0MPjlP8PVgmaDzBpEN9Tv/sH25IKpc8oWhlgx+Us7jMlzsYr6ENZXrRbJSEP
 5PmVZqF4KEZAfs66qxwZbaF7u+LPtngtQYgG+ofbGolmoCgMIMG30qcJIoLqGmvSqXRGxuHifLc
 +z6ka2wE=
X-Received: by 2002:a05:600c:4714:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-49e61988b9emr84737275e9.10.1789198188447; 
 Sat, 12 Sep 2026 00:29:48 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de.
 [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6499d57bsm171373105e9.3.2026.09.12.00.29.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 12 Sep 2026 00:29:48 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/display: Fix DPLL reserve and release references in
 kernel-doc
Date: Sat, 12 Sep 2026 09:29:46 +0200
Message-Id: <20260912072946.50769-1-kmehltretter@gmail.com>
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

The intel_dpll_state documentation still uses the former reservation and
release helper names. Update the references to intel_dpll_reserve() and
intel_dpll_release().

Fixes: 2b3b9a8faf56 ("drm/i915/dpll: Move away from using shared dpll")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.h b/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
index d408ccf6f9025667177e411e5c2cef72cc30aae9..cec6208fa7535ba77c203999bc75b3c077a94a5d 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
@@ -302,7 +302,7 @@ struct intel_dpll_hw_state {
  * future state which would be applied by an atomic mode set (stored in
  * a struct &intel_atomic_state).
  *
- * See also intel_reserve_shared_dplls() and intel_release_shared_dplls().
+ * See also intel_dpll_reserve() and intel_dpll_release().
  */
 struct intel_dpll_state {
 	/**
-- 
2.39.5 (Apple Git-154)

