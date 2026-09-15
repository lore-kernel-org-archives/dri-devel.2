Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02C6C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAC110E750;
	Wed, 16 Sep 2026 07:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gFVnatJi";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0918910FBC6
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:56:07 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48583cc7ab1so1448504f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 05:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476965; cv=none;
 d=google.com; s=arc-20260327;
 b=nh4Qm6gRZJBjyLLSptXOSKpsD9pR9D9zn5/OnA5eLkky+3bgLl2iGCh6DyIE79NKIl
 NkGNxy+cQFQrV7CiKepsfLqM44h2Ljwex/J0kwY5oXoJCDjcOIcdEJkL/z+t7n2sL46q
 6qjpQMrSijpwQ9Va92nVfyqnKctxuAfdWSwIBk9qptzAfP2u0+qe1XLTbLkuZOvAqKSA
 rclB/v03sW3f/Vt+XlIGDybWqugUSB1mwiPGf4y9r/Ok7Tzubmhej1FzyGaYGsaUd/Kg
 MwwA80VtFLqsQdoU5Se+2TwUyiuQZs1fbNfhcoPr7w1+lREBBU7rxv9tbTg3PWDcmoXY
 P6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=8VR++9TjFdQK/ZqbtgyxTaAI6KMgtfNv8B338gT+IuA=;
 fh=3R71UCCMvflL5S5U+3tT9TVVeztEjZciAxXQNJBAaIo=;
 b=CbHgCk4BiF2SwmYnyxHzLkfJ9RSkn0J0JW8rVcc+AsB7ogDvWq4yH6zJdKLklsnOUX
 DgtllgwAiI4jrySxdiYwnJ9s4I8W5BWkoaUVKOsUa9nNqiu4QFywET+WjrXb5wPN0vJm
 yxzEudj8yvfApezMkOC6lVIlHrvum72EToSYrTjRTcpx27vpwkxXGkyFCfGHSLNvyMAc
 z7McJ5Xas6CfTZweQEpVjhuqRNUbI+HdgIYIvUKGtXtuIgOR4Bo7bpMISumz9Jc7sOA/
 addIM70a2RY7Bgjc9rN4YeSDqT4P6j7D3uwGCgQb4wA9f0vT497qF7T+vSC63A3CGOPb
 +nfA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789476965; x=1790081765; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8VR++9TjFdQK/ZqbtgyxTaAI6KMgtfNv8B338gT+IuA=;
 b=gFVnatJiocNd5FSmk2pCjpcBUkkhdETHTSnPJuvymCJHst1+vHP9BsZn2Qwn3wNzpR
 pL5OKQE4daETlTq/asgL1wIj3fYrAEob5YB4hp7AsqyvkDwPktQiyH1oIpvakL4zCziX
 JTP44RxJFco5GyLOYxccdZPacqzF9rWlI7dPHeX+JtJ+O+shCqIIKAulweX1w2TqtT/f
 ClnLCAUIcn6w+pc385jZJMM+Xo7j/cBTR76Mtb1RP2vQamAbz8RrLwMphPnyyDV5daTg
 7gqcVvHxLqqoAV2NltN4rInQQ9d/dMXF9CR/yIkj8wVdrDdE6rD9b0Sq8e9auTzsD8Pl
 e4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789476965; x=1790081765;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8VR++9TjFdQK/ZqbtgyxTaAI6KMgtfNv8B338gT+IuA=;
 b=KZIgWMqBp2fxjjiWl4wR6aA6uA7sQBEB+QiOeZJGFsvnkdoYl00sYP6k7ys/zsFVbr
 VVAOrdpyY0JJ8KtdC/g39WX4A58WKpEfNSgfuzJQ6ms+lzyZLJ++0I5UkZfdxfzGmXO/
 4u6yIQiSkUijNN9PnuZC0g7gbT22ctZSya0DLvtoHb6WtmYQv9pVq6BI/nyE+HKG2s1N
 uj1Pd/4FbHxjdzwGUnjpoFuflB0aKgcX103aWdhd3RghGu6o409p5Q458w6/jmDuCirB
 DiZRGWrTZwtLNx5kIX25wZA0t0+rL795Xrc0cKDohDZR702K0JxaTwnCULxBswkTgZTq
 9uOQ==
X-Gm-Message-State: AFuF++lfcjk9HgJD5IZ7WlOJlf4k/UHXVCRozb/ZgvzzfaVKkF1ReszY
 xHbbjnt2a5aLjTVUkfU4DipfX3bp230d/riJBBqtx2NJ804tIlGFaIRk//L6AmAXsVGkYYo2IXN
 NXtmVfVsIoAgzSCLeiUwSMcp92eUfyL2klkLnN+KzsUbb
X-Gm-Gg: AYBFou32HpJXe4SAwSjf9BSRBqYsXtoDJ/cf7Uf7eYAPOpOjWYGwLW83nDEkkOqSn8k
 VkBafcYSNSGbK2zQ3plkPzb2OB3lmLQJNuIGBasQk5p+YnhYyBa6c/GlEwNiVx5m056usFK3Qgw
 ypmYWsWnJzaGSylnHCJRzG1nn+N+LHCLYk7ZnhzMOZKJpmyIlKi3eRKecD/OyQqdYiUcpOeSXed
 qnMsteeC67Mf5jzfbtIou7Bqlry5JlC6Qmq+yT2M49oOAiQ6E5KjafsY6dJV3or63tIqHYqCb9M
 IXawbqaUfEjegE6cu5j6mnLHwSiGYiwt3Vrk0cHVAZl0IS8WqXqgnw==
X-Received: by 2002:a5d:5889:0:b0:486:e9ab:2b86 with SMTP id
 ffacd0b85a97d-48702b139e7mr8348791f8f.39.1789476965301; Tue, 15 Sep 2026
 05:56:05 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:04 -0700
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:04 -0700
From: Ruslan Vagner <rusya92266@gmail.com>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 05:56:04 -0700
X-Gm-Features: AcwNN1Ui9vQ5N7rG5ilbnePVRKDLXMNn0NRZ_1-Xln6RDPuX-uVJfVr6KBqPFrA
Message-ID: <CAF9RqJ64goBHhq3aC_FeGuzcRv2z1fRUyYL5hE=HPN7MsAw7RA@mail.gmail.com>
Subject: [PATCH] backlight: ktd253: fix comment typo
To: dri-devel@lists.freedesktop.org
Cc: lee@kernel.org, danielt@kernel.org, Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 16 Sep 2026 07:35:16 +0000
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

Fix the spelling in comments. No functional change.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 drivers/video/backlight/ktd253-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/ktd253-backlight.c
b/drivers/video/backlight/ktd253-backlight.c
index 327b4ee75254..f2c5527d02e0 100644
--- a/drivers/video/backlight/ktd253-backlight.c
+++ b/drivers/video/backlight/ktd253-backlight.c
@@ -53,7 +53,7 @@ static int ktd253_backlight_stepdown(struct
ktd253_backlight *ktd253)
 	 *
 	 * Architectures do not always support ndelay() and we will get a few us
 	 * instead. If we get to a critical time limit an interrupt has likely
-	 * occured in the low part of the loop and we need to restart from the
+	 * occurred in the low part of the loop and we need to restart from the
 	 * top so we have the backlight in a known state.
 	 */
 	u64 ns;
-- 
2.54.0.windows.1
