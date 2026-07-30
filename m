Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22799C55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BD3B10E682;
	Thu, 30 Jul 2026 06:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQMy/Lbu";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F65210E138
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:27:24 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-848479c9bd5so1518245b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 23:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785392844; x=1785997644; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3EaYXPThWNdkG4MwcQhWQJEAKHoDeZpU3BU1Rq69yw8=;
 b=hQMy/LbuS0eHS83kYzGhGwfVtywKKC0YR8jCO5KBq5BEREhgLKGSFOimjIPWcAiDdY
 W+npBF6AMQpw4Aw1D8OcViJn7kLAJb5S0ZNc1h3DIwXsp/Lk0lU7fU7F965xz7zAfTP7
 81CYdVpuVDSnwE8qk+J9tisypN7M2skd0opYzKSskQ9lCa84/KIPWMNnfVTYzCC5/4fD
 l7RYUFtFaUWopGf4CyytyVTj8mvNxGYthK7EBLPxOyIaWVVOe/lEW/hhXx2E9c5fr1pB
 kLRmOV+nj0lxlMYBi0u8CpzzMsirQ5Kji4G/rKXJTkDTT31um7RCdT41KlWJPq2/7K5F
 bv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785392844; x=1785997644;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3EaYXPThWNdkG4MwcQhWQJEAKHoDeZpU3BU1Rq69yw8=;
 b=HfFOpbHKwaa5Xbli56qEnMfJpr+stv3tl5BXuVohKta2lk2gMNqGGXGbc19aQMQalI
 uRdqqu3haPrQQq/VsmSLXCBNwYcX4MuLgnA/jUkH0VN3aR7nNJO5N/lyMQHmgNn1HVYR
 UX9lxJUT62DOdZo89Ey0y5mcAOo6nh+anIiYn4mW4ZIm+ura/zdvWyyVSy4rTxD/x/bk
 H8S1fUGem8SVaZsVHwYkC2y8LMIXMis0o66bAIyyP4Psxx15MQVGXVCd/FXLFrXpYt2y
 PYmoaZ+EtBRtN1Bwb5LYy2EKUdbKsPwY+GWi+tW9qkfJmchqvjiTjdrzTOgXuSvtoqK1
 2OGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpY5UXYLDSmtdZn1RLUIOpu31rYCE20UtlZ0nrPqyrOqGJhMv77x7HF5y/LC4mgmScWhjzbCtvZrho=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLn5qZSz5vd6VXc1oFdFvCbj+BJRL4JD754XLdLlc0oNH4PX5y
 mWcZOZhymxwuf8+qYk+HD9FfkE6vqp34jvVbxgK6x4n9xcaOBxd2FXM7
X-Gm-Gg: AR+sD1012ZPqN3QOZjl8joZZsaALgmyY23QHkG8EO1qkrN1GhJOB6WP/KAZwvQfSGfi
 JkU4AQ6o6oPr8g7/aVEIoY9mIAFa2hBXYAqRn7Pqyk3CaTxGvG7YbxtId7EfOZ4NgSQ7wKmuRdW
 A3EwtMrQsT5f+P+oab9Oh2CUPA5PqFARqMC8vvCAqs3tONj8jCGiSVZy/S3hUxlN3Ag+UgvnNxz
 0JYLIig7jMbUDEqy3G6wR+4b85eIrrhWCXN33IuHNNweeigWPIdJp8yDRubhCA2KRt3nJQx6+Y1
 096y9WrQnVYotAVS0cjrFQeLr8a9oRe8WFrwKjm5UAEz2x+MVk2LGjtk3kBdzB+pshtjiTGLeVt
 ELMX0JWv9doGCbMPBlMnbJavQKuHaKxht611FCC2K/0DBC6z/md1VsjIolFQf8zZs5qJy8YdACi
 x9yDcywZlbu/JRdZGxpfWNzTBaTYGZapTiudOqmq8PG71yTbPZ0xF8G4IxOx5tUG/j
X-Received: by 2002:a05:6a00:1150:b0:84a:2fff:cef9 with SMTP id
 d2e1a72fcca58-84ebc1ed97fmr1520110b3a.13.1785392843988; 
 Wed, 29 Jul 2026 23:27:23 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea00507b0sm2503229b3a.14.2026.07.29.23.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 23:27:23 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>,
 Srinivas Kandagatla <srini@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v5 2/4] misc: fastrpc: don't publish fd before copy_to_user()
 succeeds
Date: Thu, 30 Jul 2026 14:26:43 +0800
Message-Id: <20260730062645.233148-3-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730062645.233148-1-shoubaineng@gmail.com>
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
 <20260730062645.233148-1-shoubaineng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

fastrpc_ioctl_alloc_dmabuf() calls dma_buf_fd() which installs the fd
into the caller's fd table before copy_to_user() copies the fd number
back to userspace.  If copy_to_user() fails, the fd is already visible
to other threads in the same process but the ioctl returns -EFAULT.
The existing comment in the code even acknowledges the problem:

  "The usercopy failed, but we can't do much about it, as dma_buf_fd()
   already called fd_install()..."

Now that dma_buf_fd_install() is available (introduced to fix the same
issue in dma-heap), apply the same pattern here: reserve the fd with
get_unused_fd_flags(), attempt copy_to_user(), and only on success call
dma_buf_fd_install() to publish it atomically with the tracepoint.  On
copy_to_user() failure, put_unused_fd() and dma_buf_put() cleanly
unwind without any user-visible side effects.

Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
Cc: stable@vger.kernel.org
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/misc/fastrpc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3a49384586d..c5143cd25767 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1709,24 +1709,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 		return err;
 	}
 
-	bp.fd = dma_buf_fd(buf->dmabuf, O_ACCMODE);
+	bp.fd = get_unused_fd_flags(O_ACCMODE);
 	if (bp.fd < 0) {
 		dma_buf_put(buf->dmabuf);
-		return -EINVAL;
+		return bp.fd;
 	}
 
 	if (copy_to_user(argp, &bp, sizeof(bp))) {
-		/*
-		 * The usercopy failed, but we can't do much about it, as
-		 * dma_buf_fd() already called fd_install() and made the
-		 * file descriptor accessible for the current process. It
-		 * might already be closed and dmabuf no longer valid when
-		 * we reach this point. Therefore "leak" the fd and rely on
-		 * the process exit path to do any required cleanup.
-		 */
+		put_unused_fd(bp.fd);
+		dma_buf_put(buf->dmabuf);
 		return -EFAULT;
 	}
 
+	dma_buf_fd_install(buf->dmabuf, bp.fd);
+
 	return 0;
 }
 
-- 
2.34.1

