Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA7606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k3N4wrSR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE26910F316;
	Tue, 27 Oct 2026 09:31:59 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1571010EDA2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:18:32 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-369f33df08eso2516067eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793009911; x=1793614711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uMe2OrBlQbkfT3wcvRtHcAjQdCdPt+EgXnOa1muqk1Y=;
 b=k3N4wrSRpplTRcWPmn/gQL+JvUxTsHVvQmVtFFs4PrF21EjhvWZf8EBMszUyEaZqZD
 vAW33Y/afsV4ip3GkdCH0IP2s12Qur4o/TddHtZJp8OJNWqQZBJyq4aAsTaxXchxgMCl
 r6IN5I9UBoBax0aIFoOum59TpJD9XDuO/WsuZuXejzuN8C30pfkaVgvzDEQTl7x35VPK
 dSWXtGn7OSf5Px1fQIW3+0REE9CyoXPuGaZEP5g8c9cXHZ9YmRKCJ3TAZ+rDXAll6EVy
 gj9X0PCf0T+KxztEg7IQGdz7GvUB2TmZX1Qh+xPlkbrWwSzE3Me3YprrLQw7e9FHcDx0
 JHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793009911; x=1793614711;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uMe2OrBlQbkfT3wcvRtHcAjQdCdPt+EgXnOa1muqk1Y=;
 b=iVTUlj5EpEhLMxmpolk5zRqtd1LjPDaqvpJE6iqbePzU6yRLw9Om3XdGJLVsQhhyha
 A5/l3slMyxbkRcaVRQFIYceFB0Kn9lZNaYJ+lEYF2E8P50YUtvmjT9erWJ4XfzoXtllV
 mjlj2Y+fMZk6McumMLAbGpLRhWLeAkljTzkxahM1+k17YLFGGo1I5Fd0sDctcLYNBJgN
 I8tlP3ukNmUdPNZgrKJp1UWUr/i1tKhXmXqhpV+khLqPykVB9PFs0u+STveh4EtA8Qm7
 sUSdtJj5bItk7A22JU+3iBmN+Zh/nUgHwUzRr8ya653PuBJrFiTbM3dV1dwmEsQAJ9/W
 uTMg==
X-Forwarded-Encrypted: i=1;
 AKwUvByauhhnBXpO73DpSSy+u4T769rIPZWv5B/af8UpYeOwPh1VNcs0LRzYJUwEMvygFFXw7NHQI+CujhU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJce6L8lbcitRC5oRzjmczAq95JMmmj6ILwqN4zJIhrZWs6dkRj
 YL1IcyIy/N42iVpTe1toO4RUF8+d0hkZdr6LXQ8Oh/DG9xkNG9gutEbS
X-Gm-Gg: AYBFou1ZUTIcpZ9UFbciS/3QLT9D2IO9TisprUgkDwPe5y2Jvdh8bH0dp9x8iXd6So6
 eYf/csjJMrMuahsx/NywCDRwD2/EsLOpQnXAnY1am4aqGXd501K6ZJMWmn42QZAjQDmWRqd4kRB
 S07yMyzbZQ5KquX7iWzSEGXpl+4tPV6RpRvkNxh824ouq6eByZWFhck0Aq9iNuhsjibwJWBSHco
 ccaut+/eVHhz1L0n0fF6KjXzIt/33HIG37Wdds4aX21RAa1UTFHK3yi0sbeiP5EEX7FhDiYHi3J
 J7iA4JuZARXsU9KHYVNrgfjRAKlgJ8EA04M228szryp9lCapR1LrD1cUDA6HGAetyA6r262xq+x
 CXvFxcGjCx/5u2C9x7tMa6kv75KCNQCziRdTBWUG7/cz9RtAbRTWaTO2b+WnwRCkmep6sVvcbLj
 uKC5xiq4PtfFe1YEyMc4q4k05ajAw35Lkeu3ZmJbEpK5jKlGXQJ/y8xhKUDX7J95n/UsDW4C3JP
 CP4etUX7Vo/1nhcIM0teQPjt0dAeX6poNmzA/APyoXip1QrUbjHgLNKLZgIFkcndexWISvGukA=
X-Received: by 2002:a05:693c:8214:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-369e8613376mr10271627eec.16.1793009910967; 
 Mon, 26 Oct 2026 03:18:30 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ec865esm22437475eec.26.2026.10.26.03.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:18:30 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dennylin0707@gmail.com, cenzhang@linux.microsoft.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 error27@gmail.com, Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH v3] staging: fbtft: remove unused fbtft_init_dbg()
Date: Mon, 26 Oct 2026 15:48:15 +0530
Message-ID: <20261026101815.73722-1-himanshu.bakshi478@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>

The fbtft_init_dbg() macro is not being used, so delete it.

Reviewed-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
Changes in v3:
- Fix tag formatting as requested by Andy Shevchenko.
- Add revision history and testing details following review feedback.

Testing:
- Built the fbtft driver successfully.
- Verified that fbtft_init_dbg() has no call sites in the kernel
   tree.
---
 drivers/staging/fbtft/fbtft.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 40a7567df1eb..16459e4e0ba0 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -420,13 +420,6 @@ module_spi_driver(fbtft_driver_spi_driver);
 #define DEBUG_REQUEST_GPIOS_MATCH   BIT(30)
 #define DEBUG_VERIFY_GPIOS          BIT(31)
 
-#define fbtft_init_dbg(dev, format, arg...)                  \
-do {                                                         \
-	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
-		dev_info(dev, format, ##arg);                \
-} while (0)
-
 #define fbtft_par_dbg(level, par, format, arg...)            \
 do {                                                         \
 	if (unlikely((par)->debug & (level)))                    \
-- 
2.56.0

