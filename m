Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E734606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=l/1JiQps
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C62FF10FBAA;
	Wed, 18 Nov 2026 12:09:02 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D0C710FB98
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:08:46 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-49d64a88222so1255179f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795003725; x=1795608525;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A7/+6Gr3dy5+sHZr1gNu9O8cTp4wuu+Tn58fAqOTFgs=;
 b=l/1JiQpsGIs8tJhvTrXTZcR9GXW1ffwb4NGOk+n5Dtm2/7hxZjx30EE0HpwtmKGCeU
 q8z4m+bq1zr4D8WB2X94kcRMKVgI6l1885s7QczWYsPMF1cw/ocILAkLE89ank1OqMwP
 wIf/rGVLKLH7gfTGH+vQPCJTyxK2kZcX41r8cO+syV3rA1pwRXLbK3kcKoCubLSrdQZX
 7J8qr/inqEK4Qn9u+diiazmb/cv2QZGheGzcnse9JSjFqIMAgENhogF6Gy89yXdbfbB/
 Ghse83po5wodYlWSsc6SQIjQxZafoH2gzRWMe8jPn2q6bWdPw9JpFVWWDVc/qont+hV9
 2dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003725; x=1795608525;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A7/+6Gr3dy5+sHZr1gNu9O8cTp4wuu+Tn58fAqOTFgs=;
 b=D9W2aeGS57DnmPcbQT4oYsa8IzWMzIiiptjHexifFIg5CX8hiEcNCIYUw5wfsAlKNC
 rgmAAebTr0PD7icdmqVa8Au2gyqlkb6t1+RQftpGKDQMLUhSlzjzYbnm27a1y03Va3L5
 /0OHUzfjMVqKeiZjyV2OfgRt4fVkiQOe5hMh9Sta//UZOk1mBbPVPc+ZqngxXVwdVzF0
 xtRvvdvvb2PxLUcBbX3SFtfWQdIAdEPvc9dp2EXCapp9zs2CaMGqbnKLa7MvZnOBdvVX
 DGQc0aq0o0s0Z58cPRkTT/cBGPThoX111aRIMEdAWOsvQerEMHyG4Eg7TFXLJSkFJEFw
 PSzQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGeBDH5u1rMJSYsPnFuhy6wDbk4wJEzXa0Xl3Gp5bbq5JXZXQnz+JyXEdk+embdvBjKfffKzyoPe6E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8dxD5qgO8b3+kBDNuE0U+Z5Sii5Mh6UywcRDA+pr+uOrnD54Kn
 ARKuspkqKEi5sGDFHB1CLNBfbhm08/Hu9MyaF5R4Q/rNzGIIWx+NSqwULebuKNBS0Ts=
X-Gm-Gg: AYBFou0DDHIM4it8zokFZ/XadgVSkqMyhtlZG8Sg225O842k/H6NPOW+Jxx2cJLHboK
 0crk+BigAkXlkPYKHjCliLAOLsLfnPP0a3uCx9VpdT+zbbBdJHyIovLxrrOBVBRcGgxoERhZl/Q
 r1W+6dXNuAcsECWW5Mzl4LW8HOjtPW5hYgv6u03smk7eOO8qhb5X7LaYNONsfeW06roRt4EQ/+b
 lsnj6HPntDiSRJp1cCCDw2xqxv2P9JTSZ1Es/v892MuBqJ8u3xDBdHa6TM8ulwaGjUTd9LKHRHe
 wfSJR050QuOrzLgDV6ngkWRkIoSYeMtF1mWuRE8pqQspbRpSYS3tl4QanEn4nJWFB2Jv202jplH
 F9aB+xAzO5e1E5xu6aUwPuExQr9SnLKdtKvOFMSy+oli7l8lQVpT7SQpU1gNwzm9u6fdmnfxQr9
 F/oSg9Cc1HQPaX9+ifYVjXnKbqsKdRMkdcrwFJ/fRQScTiFZQuU/yjLz+KuHVvbDSZBv/fSHnQ9
 h0YUzp9f4Yr616Dt0QnYoYzJPwhxGxdNu6U/15opJ49U+wNZqNkaEbvZVPfWHskWwD/WrHw5LvQ
 cLSOGXysJwzYmKUkEnF1IKW63q0MEUn7/89qZQdPw5poAY7bTbecutPgmOBKrTDUyOG+SL3l7kF
 LnNEfNoIb8tcXBb8=
X-Received: by 2002:a05:600c:37c3:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4bb7d6cd4ffmr42083365e9.2.1795003724791; 
 Wed, 18 Nov 2026 04:08:44 -0800 (PST)
Received: from localhost
 (p200300f65f19a904dea20c2220232395.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:dea2:c22:2023:2395])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb7e50e7c6sm26768855e9.0.2026.11.18.04.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:08:44 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Linus Walleij <linusw@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v1 8/9] drm/pl111: Use an empty initializer as amba_id array
 terminator
Date: Wed, 18 Nov 2026 13:08:15 +0100
Message-ID: <69cc3ae97cac70a5178befb171205bf6035958ff.1795002467.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795002467.git.ukleinek@kernel.org>
References: <cover.1795002467.git.ukleinek@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=697;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=dk6TYRTsKivhXSXc/cBhXN2jw01Xga3J8yHizEw6R6E=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq/ZU6qBeszW91A1hGGPcGXccY12HyFEuNmWSH0
 pmkctCGsWGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCav2VOgAKCRCPgPtYfRL+
 Tr5kB/9lwBY7UG675PfE5oNwDp1w+PIfcpbhRI+zJz0C/Do2GiAPb1r56y6sEKm8KkTU3IN0ZxS
 p5SsOALQeslG7Qg4lJVJ8MlLftt9ayAuLF8Qs62Z+BC9+EHvW/pnagjrR/OGRGR65tRmVN6f3X/
 lgq7ZKT8CdQPVk8u3Kl8SKZ+wnU0sQbPTzBUjzBFI95VQFUO7qjrS2AT8bMFQR2jnRNREDlsj6n
 IwhfQBWtwDuCpAuM6GL/17LKMfmrTVulGlmi3tcaShiSfWX/nhW0S95tnNnxXaniS8pYWGEG8ka
 WiN5BrlFNza7kXWVHnkxjsPcCYCVEmxRmuHe0jDwbYia51oA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rely on the default initialisation provided by the compiler instead of
explicitly assigning zeros.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index ab8af4cacf10..d8e7b7c29e4b 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -415,7 +415,7 @@ static const struct amba_id pl111_id_table[] = {
 		.mask = 0x000fffff,
 		.data = (void *)&pl111_variant,
 	},
-	{0, 0},
+	{ }
 };
 MODULE_DEVICE_TABLE(amba, pl111_id_table);
 
-- 
2.56.0.rc1

