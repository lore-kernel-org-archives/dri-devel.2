Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA1C606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFcjqJvu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 159CB112957;
	Fri,  6 Nov 2026 09:18:42 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4710110E1E4
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 15:06:48 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso1780479eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 07:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793804807; x=1794409607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=srOy3C5I/IQfUjrUYw7AbLY9/VnfU44F/qy2laTqkjs=;
 b=SFcjqJvuuPjBTflgGSRQ5WXsLIbAknKhwVNBn4ODAymsB58XNnJx5+VM+MGxbTrinr
 rEU9O3aUkNwz9d3a5IJzzAg9OPdcG7fnVzhCgelI+Y2P3WcUBTYcqOc+/CGiRfTD2+mT
 1B4XP8CA/zoBHLHCcBTmQ3sC39wqugMQ1ksKQ7GkKKeriqHC5V8WBDaPAes3rokO4XXs
 +VGsjFN7wfPlxyryrl5IOhM1DKt2Z0ozn2dIcBxwcl+gNdpV3Vji6jDs5ZRBjq6cLT7a
 bVTGWcX/beYEZLkvngAFMC9Rm8ocEaSfYIXYQpmYuK3sBkeF5m5SRYHrf8T0YTcxy1JM
 VR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804807; x=1794409607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=srOy3C5I/IQfUjrUYw7AbLY9/VnfU44F/qy2laTqkjs=;
 b=EoEDuj96i/2V4vuPVqbzU/OMudEaexOR/iaAJO1D7j8EsXNr844G08wl1pMNjS21Ko
 3kvkdlyj+KaqLb07UmdPrvUZP0ybC4KY6DHatjQ06veFPep/xgI7OhL9mRmD3EnuvQQp
 tAbhIlOzP3fGsbZmtupIz7ZF2JajjusvyCRM57XwGFmjWkT7+Ys0KRE1wHYbqhHT4klr
 0aFvUOMLLZiwHy55RE2OehsKNwvf20f7o93a50YC0o5yaFedcT/gArodkH0tsFtilJSc
 Iov2hg/xH8GT2Ihc4V5P/0+vBjM2nWrw5S2IxgVQ9wHxCz3C5hRv6skFtaV8KxOD9gE4
 QY+A==
X-Forwarded-Encrypted: i=1;
 AKwUvByfaBjsNx3c12EmHrbvkVaE8KKbfAbzdd4xujo4ekdydEZiw3eIEr81laM3/2KZwQW1TYPRqEmQ0RA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z84lBlJ4HM5RwBALC825JaM0mwFCJ6YQL8Acmt0nIDDnNW5WjDi
 z63UNVaoOWuqn4I+BJQg8wTH4O4Xu9kHFIEoCwYkHiu2b/skdlQO2HHt
X-Gm-Gg: AYBFou0+EvzGL6FyKbjj+xfRqvDDnCYxzyne1y5YOR3MAGhSzH57w7SafQjRd7qtWoS
 Bk9dukNQRjmsjLSqgrkS/65LhFnxhjHrbWR4T1SuV/R89k5GQeICw9tAI1lbvS0a7yCFsoEtOk7
 NFk3U2xe/n2KJJBf7OeV2pdy0P2Xeo76ZdI3ZdfysnVImJY9+6mjKFQOcCYhIKQxSi7NudV1ACa
 m14d655A87sqDnj2JNLaprrKnC3NtoxLmfc5ix7nAHUzgpwlChR48BBES59bV0218boXe4lMxG7
 meFy53CDI2gbz60Fx8cKbASso85IZD1R6MdMDDHLfkPLHwSEWZERYzOp2co3scYO+CdznlU2c1R
 rvVoGH5MHtVMctpv4Ez0R2cNZ7Z1bIyT8RhYK70Z/AQzYaz030S8tngfk1MQgwLYCUW422KHIJh
 b3zQ1I4yPuUdQrGt1Vtpy1FWxW0wZPx74FhYVPhY1t1gxc++0sEDOgLgVYS+z9VdHkSDJDGYYnm
 8Ez2iz4qrcemEqAJfJTDrCzvbnrIBdfv2sbKg8whqHKCHvC4iHBcLhqEiC+KGT6j7DSma6asKuz
 dodLcNUjzs726D7EWF12z3Dul2yHud4wdhEpuLEatFPeVecxwvK8Emfh1YKmzgklc7Xk03OGT+z
 ShtcrtyUMuyGYmdOFsoMjFj2cdGfq
X-Received: by 2002:a05:7301:4203:b0:36a:50f4:ed0d with SMTP id
 5a478bee46e88-36a50f4ef92mr20087021eec.25.1793804807290; 
 Wed, 04 Nov 2026 07:06:47 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:5040:8550:f5e4:709a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm527287eec.10.2026.11.04.07.06.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 07:06:46 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH 2/2] drm/amdgpu: use str_enable_disable() in
 amdgpu_ualink_set_irq_state()
Date: Wed,  4 Nov 2026 20:36:23 +0530
Message-ID: <20261104150632.33843-2-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261104150632.33843-1-sinha.aryan03@gmail.com>
References: <20261104150632.33843-1-sinha.aryan03@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the open coded ternary with the helper from the string_choices.h.
Same output.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index f875209e5..a307d165a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -34,6 +34,7 @@
 #include <linux/math.h>
 #include <linux/sysfs.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 
 static void deactivate_accelerator(struct amdgpu_device *adev);
 static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
@@ -6558,7 +6559,7 @@ static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
 	 * interrupt driver.
 	 */
 	dev_dbg(adev->dev, "ualink interrupt %s\n",
-		state == AMDGPU_IRQ_STATE_ENABLE ? "enable" : "disable");
+		str_enable_disable(state == AMDGPU_IRQ_STATE_ENABLE));
 	return 0;
 }
 
-- 
2.46.0

