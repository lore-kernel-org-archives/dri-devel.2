Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D10606A332
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bdmr+6a3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C03610E6B0;
	Wed, 25 Nov 2026 22:25:50 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3997E10E20D
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:25:37 +0000 (UTC)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-38531c1a566so496465eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795645536; x=1796250336;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RZfUBsQBjrYMkeiiy+HZZjsd5SGGB1qkI+nxVlUd/GA=;
 b=bdmr+6a3Iis6CQuUEZxOP/Z3lGy1M6utHrhlaDAd2dnfNul5XZbZmZXAwcnBIGsh98
 g/ZH2s3dXtjGwxq2ccT6GT6BHalSZQieWtQ7hiRkgXe/ZRev4y5OpQT5GQyRikwdpJ+r
 kg7yORJA/fWmJkkvEcvCd4ZtCSLr8e3CWxeRNcQsYLV4EOr5adhTvC+qt2gkujh0mXq6
 oWZc6Smd/mJMtRfCzcFQMCwMNzJQeqsQTVt8kg5v1PaDQCC/eNg00CDUkqoNXIg3RxYf
 v7qkDsod1qzdbqf1krCX1fGjf6+9s57imXQbpOVVFUIpe2t3HZr/8QlYyhpkibFKfqKR
 +0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795645536; x=1796250336;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RZfUBsQBjrYMkeiiy+HZZjsd5SGGB1qkI+nxVlUd/GA=;
 b=gL8S6TdKap0qJGWK7yX7CjHRHjs/Ar0BrcXX4aH7nlsN5H80ZHz1gfrEUB6G6UsWXK
 sIRD854ytJ2x1+mxV4D7lHA0yyy7l72n2KWK9TF6+SmzPtHamUIiWEiOjhyrOvxL7g5S
 OFBgfKmx7MCcHQp/m++fI143z7uzFmYB+w1D/zxkprZf3AaJCOs3HO4ExX6UDR11icHf
 2VEeImtkqkG9BjTmSaDBlG7vs/elnH/U24dhaiJZmguBFJ+j4TABwMjAXEIeUSauWdRV
 MrYPJb+TmkWNoDAQSKI2QAIQtLGYejsCgCjSQ/S4m0c5b2X59NNgI9yGb7wx8p+yNFqw
 JRLQ==
X-Gm-Message-State: APuU4Z/auL1bOwo+qD/msfdmeLHpZBJ8QMiTjsPcu73CdrQwGBPKk9eI
 7evbpki1GAhj7shoD7FG3VXvPyGMiAS2oEIPvdXYf/veeZG+HTE1g5NOBSM1tuLvbayAxEjnIz6
 u9A==
X-Received: from dybpk12.prod.google.com
 ([2002:a05:7301:428c:b0:377:a5e3:b669])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:c00f:10b0:381:1eb7:938e
 with SMTP id 5a478bee46e88-3856c9a61c1mr23535009eec.4.1795645535979; Wed, 25
 Nov 2026 14:25:35 -0800 (PST)
Date: Wed, 25 Nov 2026 22:25:13 +0000
In-Reply-To: <20261125222513.1446099-1-elkin@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261125222513.1446099-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222513.1446099-4-elkin@google.com>
Subject: [PATCH 3/3] drm/sitronix: st7920: Pass u8 row address when setting
 GDRAM address
From: Elkin Cruz <elkin@google.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

st7920_update_rect() passes &i (int *) as the data pointer for
SET_GDRAM_ADDRESS, whereas st7920_store_gdram_address() reads a single
u8 byte. On big-endian systems this reads the most significant byte (0)
instead of the row index.

Store the row index in a u8 variable and pass its address to
st7920_spi_write().

Fixes: 88b09229f34a ("drm: Add driver for Sitronix ST7920 LCD displays")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index ea4566009c4b..005994a8f87f 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -309,7 +309,9 @@ static int st7920_update_rect(struct st7920_device *st7920,
 			data_array[array_idx++] = line_buffer[j];
 		}
 
-		st7920_spi_write(st7920, SET_GDRAM_ADDRESS, &i, 72, &err);
+		u8 y = i;
+
+		st7920_spi_write(st7920, SET_GDRAM_ADDRESS, &y, 72, &err);
 		st7920_spi_write(st7920, SET_GDRAM_DATA, line_buffer, 72, &err);
 	}
 
-- 
2.56.1.839.g22a8290db9-goog

