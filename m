Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B9606A9AE
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ayBA5VUk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D6B610E1D1;
	Tue, 10 Nov 2026 08:33:28 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23F010E8AB
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 13:37:42 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso800715eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 05:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794231462; x=1794836262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QWyQhqJ9ucdQAcEnl95DfWPx+aoHDTMLg3gXeTbngSs=;
 b=ayBA5VUkmcmIkq4GV5nWMDpLsEu34WtmKDCwNbE6jdQRuHDoAVQCMwgdHbtE3VUx/z
 fPhIrUHmDFgUnuKiEzDPk8932qRxl/oZF9jPEFKvwgQfHwPW0lhU0AXc1OC6mlXY0vmK
 gPgMHjZrElPoPjkWb7QUpsZeIRdNVb3gyNsjjUYTbu1dwO3gvysTXr/qFAHXDAKk6a2b
 0jVZ+HZ1zXoPyDOUQH08PvV32R/jnwRC4Nummeu1LzkRkv8W9fG4S7Un+KdVll1wJQ3U
 /8YFlTzryqQVJM5WxefNezecbISUk7eDhLJ/cyEUyAVIEguP9tk1s7rlIx8ysrJbYdII
 7eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794231462; x=1794836262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QWyQhqJ9ucdQAcEnl95DfWPx+aoHDTMLg3gXeTbngSs=;
 b=SWUb31baKAQxIkHD8CIV77N7+3qSFcJSpKxe41Y5hItzz4H+lbD9EgXqO5S05jseH2
 DerYFqZiMXsaCZDKjRqTP3IuzhlUgCZ3KbO+I2BxLPBnS/iI8UyrCpFcIYomQrAsqMA1
 vqosweXicf0UlMqBg6/jOMdGA3CSFZHnXmPeAidtlG/LaIBXbJuZWcfT0dAzvuYSPzWK
 e2l3HGO0NSOdbBFBpx4gcUb/rfZgQQqm//OslTicoYMFFHm7jg24BO0pY+Q/cjde804+
 tY++js/gARXP8eMYZCGgc4fP2XsfOTUnxpa5RM0F7e/vUhQ8Yu47RoUSoAWobrRNH5JD
 EQwg==
X-Forwarded-Encrypted: i=1;
 AL+hErE+1OhE3ypDsqI2a7EthI025EPSNJYHwB8/OnZAttckC2O91VTx+pSWI0x5l9Gf/KqKXOsT+XQ+i/s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+HeRhODRg7TAsx9wZS8LHO1BCZ7nqejOcGShlmLSA3P18nWuZ8
 Vh5tHfvrUTOALcpE1ztl2oQW7ofqYOvhjg+rWWjS+wuaHRTuoA7RupxM
X-Gm-Gg: AYBFou0UJUflBIeY2h2Crn5766d75KVWUG5/rIlXvk+2mV25DpahFvQk552gvgfVa3j
 jZFi9Uq/VfGoucmxU31Y7MlDdW/6x0aWUmpaR8cEYdxoTx2UecaisPEZczsZoYvNpUIayRMQx7x
 qU89l+toiFRA6MYi4qT0F3l8Oy5i34of+8NSt8X00n6eDLIdq/hk8P9ObGieFt6xrHEtZqWFm52
 16qMjKiMNnPUOLfCGvENi8iw0iHP6MWhkplmfn3yu8hKF7uCwWF5XoCPn6dGIAI0u/nw/zVCoQA
 NsAUEAGkOHoS2SbtdYa7k967Li7Vu7AcinlsaSIkDZYaKbyibs/REySFVK3gyHnyvgs2Oqh/yoz
 gbRU9LqnSmNo7lIE/en+nHEcxtY56C+hkaJwMjOkPgehWYABsCS6j4vDjkYZbnhYvpTU3pgypc1
 wLvySN/f0kFGLNA4yEl6uU+TvDNP68vbxWZRFGFLpJvpCfVawshArNEhqzGvRFRaeYzPlvE1eRk
 zLngVKinr2yBWmvZWHXMwlgnAk8MqQ6SNXtOaylUMvOIWork+xeug4qBfUfsE2uN9BEXfUUKi3Z
 oO4LLfuerUpJMMbKIDtzfylf+Vfzc1g/QkAA82sWycDy39/WMcwxpjC6C+hmkJuMio08D7rmbbd
 XCH2nIGRYa6VVT4z8svw14ExMBpq9q/+1IoFbqPxcCKSv
X-Received: by 2002:a05:7301:6497:b0:369:efd5:9cad with SMTP id
 5a478bee46e88-37255475628mr7236459eec.8.1794231461483; 
 Mon, 09 Nov 2026 05:37:41 -0800 (PST)
Received: from localhost.localdomain ([203.92.58.30])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372666d2fcbsm13225525eec.24.2026.11.09.05.37.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 05:37:40 -0800 (PST)
From: Shivani Patel <patelshivani2283@gmail.com>
To: outreachy@lists.linux.dev, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, Shivani Patel <patelshivani2283@gmail.com>
Subject: [PATCH] staging: fbtft: fix spelling mistake "writte" -> "written"
Date: Mon,  9 Nov 2026 19:07:31 +0530
Message-ID: <20261109133731.66016-1-patelshivani2283@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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

Correct spelling mistake in comment ("writte" -> "written").

Signed-off-by: Shivani Patel <patelshivani2283@gmail.com>
---
 drivers/staging/fbtft/fb_st7789v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 861a15414..c4db681eb 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -221,7 +221,7 @@ static int init_display(struct fbtft_par *par)
  * write_vmem() - write data to display.
  * @par: FBTFT parameter object.
  * @offset: offset from screen_buffer.
- * @len: the length of data to be writte.
+ * @len: the length of data to be written.
  *
  * Return: 0 on success, or a negative error code otherwise.
  */
-- 
2.50.1 (Apple Git-155)

