Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AB606A32D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v0uAwbaj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4907010E54F;
	Wed,  4 Nov 2026 00:19:26 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D7410E54F
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 00:19:20 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so126763f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 16:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793751559; x=1794356359; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q9rahWNqn5TrjQs9MBNRTiFNXPe8F3h3uvk3o1ZjbFE=;
 b=v0uAwbajGVRvDwx52TAjevOFbohtqz9a4DrQrzUP77JTmGsVyR+Ek7j2CPRuAe5+92
 4qRRF1KCoqFpjiwU+Qh67WXWPHHVw/QSvS3DLsXQmXHIZkH72Z5ZEZPjzheajHMS3hOi
 sGdNdjNCjkXZnnDWdqyxYGg6BHPdClab593lAfT9pNyBgdIIAWLKpPrUzZDjfDOD9RaQ
 9jRmBaJ6SvEtNEcE/MwpbLHbPyYTMHZbOlLMYippSWmMmTUssywNsv1fCzOiYvpJtqVP
 lfbJxqkOYKXJKqCkVzBxF/V5PX48ReDLpgA3QZlwX/TB1NaS5dxutZ0/7EkLN5GitH9G
 8Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793751559; x=1794356359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q9rahWNqn5TrjQs9MBNRTiFNXPe8F3h3uvk3o1ZjbFE=;
 b=OY4MFVMJH3MbEikc3CUTVmBxrQEX85OBUQW7wPRbBuujxVfI/vRLepNTKYnQcUJIFC
 4MvD2notKRUJpgXBJqP87fKp4itC0NgUFwe9UfIUQlL+gFZIXkP927KoWBwAbm96WjKX
 LzvOvCXW+p+rI6gtfnMJqBKfIA7DdZzaMK7uq1LVShjcDgksqBc3OpAy6u0z8LZ1R4ds
 imnyLdHaRgcnC0YHi4QWEudvuj6U9GaFrEgpzOsb8VzxQQm7FLEGlxgWMa8UArDmg1Tg
 4+SlRQKH8++6psnHY1uAl5fmYvMUoPuBAeBNxHbVWsnwaCdaaR3HYJzbe029+3gScl7i
 N8Qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQkzF2MVLaRZ8nf42UExGJCpn/9dGQVJDOVQlaREwkYdm+Kq1ZVQfJifLPO2un0uDhn/lxmtT6no8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+p7Geo2RAaxDXkmqKcrV7zq/RsM0mRWYsbWhrrYHF80y3l9uFG
 GGPKTCT5cYVrgPB+GsH2aRYg4wwIqhFYP87YFwvM97xE8t0wHPx7D8f1u/QzRQ==
X-Gm-Gg: AYBFou23taAmed5fhwo1QKAotyC/DOyOdZgEWODEQfgWDi0BimU9WaltW1QIPGCdOLt
 nlErlYu7F45f32YTjqnMJXhyagoGVVvK2opMgKy/bNKN8rswTAJoZTuDJccGeFh2fBMut4g5gEm
 iurFnvwj8k3w1ldWkILgOUjyeP3s5ex9QuHiHGhoGW9+4GrchQbllH+Fn9H/ymeFGDekefWzliG
 wryTk+foQk9Z94QbFP7wE7LAvobjvGBujyC0cncYuCGjetLSrnhdH2cIeVldTeVoVdgkAjZgBdA
 L5J0b7mopoI68cWFFnTxnxEu8FMBtgWLgBytjXK4lJfHoguwuhCu6HZTTq/fMa+xEX+VIxKzTJm
 6k/k1+ZjmMjSMDb2CHA/P/957Nmwqy3UAwi8oM+zy8kF07tUKh9iyhP+tipTp2ohNqbkIfUIT+Z
 SQwaU6adIrpXbew7VG62nwLKlFul2LiJ/YcYpvf6+wTr0nBOSi3KabyOl7gDRvsEyK7Ic0LaRbr
 Vj29rnqIvVQcWDQkkIUokyrNvZrZ84sv5JEhW2tg/qeDXSZdcT0VEKVrx+oKj5qnAUsyZnDC/dt
 KHLKIHdtBBuWxiYAdYQyCpuJCXVjPtiRc36+mfQzDwTotryaq0zwWxWbfu2/VSnGhRbk0Gbt2Ag
 itlgY50yAlcRhTpziHjwujVl1g2jd9Ws=
X-Received: by 2002:a05:6000:2dc4:b0:48e:3b53:e100 with SMTP id
 ffacd0b85a97d-48e6e535ca9mr33172348f8f.56.1793751558968; 
 Tue, 03 Nov 2026 16:19:18 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 16:19:17 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 2/5] block: set dma-buf-io tag to block files
Date: Wed,  4 Nov 2026 00:18:58 +0000
Message-ID: <91697f770aa09d1be8f358378f1e11e0143ebe5d.1793751001.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1793751001.git.asml.silence@gmail.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We need to set dma-buf-io tag to be able to share contexts between
multiple files. Use gendisk pointer as a tag, this allows sharing
b/w different partitions of the same block device.

Fixes: 839231d19393 ("block: add dma-buf support for raw bdev")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/fops.c b/block/fops.c
index 60b9c9b1cefe..6f013780b76b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -687,6 +687,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
 	if (ret)
 		blkdev_put_no_open(bdev);
+	filp->f_dma_io_tag = (unsigned long)bdev->bd_disk;
 	return ret;
 }
 
-- 
2.54.0

