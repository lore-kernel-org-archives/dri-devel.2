Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72A3EC01A5
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E5ED10E416;
	Mon, 23 Mar 2026 08:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C4VX5scA";
	dkim-atps=neutral
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB5210E354
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:49:41 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-89a1347051aso43059346d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 20:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774237780; x=1774842580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCe6AfDuVfEg6QjOo8uvrp54D1ITzl/mWaR5wLcR1dU=;
 b=C4VX5scAI0ug4cwSswEd3Ek3K2iUBasDkWW8LbxcjxsDYLszw237pHcAtgruiijRi1
 KEo5QDjs49dFZMicpumNjtSeIKQbZu3zgKSlJ4R+wUqfauqPPGb6AZVbsXuqlkZa/40e
 jAkcxd8T/a2T+kZGVV7lIy9QBuwJ+PfZLwLpD0JEQ3rIwSSjFZJ2uIwgrj6nDt4HZxGk
 QzRdxg1CJwPue3uVhL+a25fXTGHCUAxWllGL9zLPw3HhD+oz5aJh/X3+HxiO0rORWMfW
 +FIOGf1mtObTHHd1pTfl+RWDKStBe/tmjecVx8Ksk1j8bUkcd8XwMHYWj2h3FOz+oVbO
 rEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774237780; x=1774842580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bCe6AfDuVfEg6QjOo8uvrp54D1ITzl/mWaR5wLcR1dU=;
 b=NFovJxEa+cIjvFvwVi1BHW5ozqpeBVCAToDYIxKQLpRug9REeaZNi9w8liLiYqlCD7
 wGW83Nv3zPUrVdH9+9pZSSvZr0Q22Dlq3hMAWZhae0/XTofW3czyXRCtUFh20EZa2ijX
 B5/G1aMp8iEo+K/ezpxL5nVszDGodiRi3SurdrJ0DapZuGgI7aK5w2uwfcuI9WVAzkj1
 ZXtDyENTNvd2r2b5+Z9vOISx5nJtMOCB1E21u2YrOlGN3kuc/I8+XrF+6UGUmZwcphaA
 luEJxYmCtS0GBGZsY+fkqc3MC5uIDE/JbAQ1GnKfvP+xXs6pIHGKc6H3e9LjhM05YEao
 Ac3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH9ddeRfQ17d5TEBl1UqfL9TiCjaF+SzjC7v5aOFTa633hMbGDqH8d9UwIAX5dqWb0kwfy0MBMEHI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzviXsGMWy+jMbJaPek7DiU38U3zGaQULDz13XTi853Qoacmyjd
 y78DrZd/b37lvyv6/FkR+BKC7a6e+Yvq3/DrjIiNTqwfY2LAZJCTfLLW
X-Gm-Gg: ATEYQzy2yx+BF9IlSF+xnZRGe2xGYCKVPxJhGcsIIVqLBthB1Eytx8rN3/LnT2WSqfW
 IBuW1TFxJU6DVGM0rxaVyFWuGq1ufBX7H2PR6UF0jQfr/sxtOB/FsWeEc8DggzIxqCELuXnbztW
 yyctLJ7xCr1lTFYK4kIgFwExRSEdkMni9erp4U784I2YqcF4E1v8YdEhdq3IuukeowdC0F9Phon
 KfCFuqfUmmRR19tnCGGZZGBZOJxaeiZX9veQ7p6q2tqeMXuVC9swr6AK+Zsw0VFjVdCDw/K2SXM
 yC6UW17+Z2NfUPItU8NZUB5NPD8jheMRqu4ERPAdMfyyMqwS/NbOaxPG/pcf1/2VS6Rjnsoxbhd
 7A/Zg2TjOF/WegWF8TLUJqRJJpKyIi/LwlIQLDd0EwlOw1z8Gn7bCX0JUnv8BXu13JqKQUiOY0H
 ZdxQSoMflNIAHpzpgb6rO6xvFxQRQkVJYa6xVv2DmM5NJOY8T/8eVfF5LAzKYrubo=
X-Received: by 2002:a05:6214:20e9:b0:894:6112:457c with SMTP id
 6a1803df08f44-89c85a9c7bemr183169246d6.56.1774237780181; 
 Sun, 22 Mar 2026 20:49:40 -0700 (PDT)
Received: from ZC-202510311500 ([123.139.39.86])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8534f9ccsm79520226d6.39.2026.03.22.20.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 20:49:39 -0700 (PDT)
From: Haoyu Lu <hechushiguitu666@gmail.com>
To: lizhi.hou@amd.com
Cc: mamin506@gmail.com, ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "haoyu.lu" <hechushiguitu666@gmail.com>
Subject: [PATCH v2] accel/amdxdna: fix missing newline in pr_err message
Date: Mon, 23 Mar 2026 11:49:32 +0800
Message-ID: <20260323034933.216-1-hechushiguitu666@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <1af543d3-46ff-7a9c-6432-fe3c9050e23d@amd.com>
References: <1af543d3-46ff-7a9c-6432-fe3c9050e23d@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Mar 2026 08:11:26 +0000
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

From: "haoyu.lu" <hechushiguitu666@gmail.com>

Add missing newline to pr_err message in amdxdna_mailbox.c.

Fixes: b87f920b9344 ("accel/amdxdna: Support hardware mailbox")
Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
---
Changes in v2:
- Added Fixes tag as requested

 drivers/accel/amdxdna/amdxdna_mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 46d844a73a94..e681a090752d 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -499,7 +499,7 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 	int ret;
 
 	if (!is_power_of_2(x2i->rb_size) || !is_power_of_2(i2x->rb_size)) {
-		pr_err("Ring buf size must be power of 2");
+		pr_err("Ring buf size must be power of 2\n");
 		return -EINVAL;
 	}
 
-- 
2.53.0.windows.1

