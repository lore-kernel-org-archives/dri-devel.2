Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B77C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312BD10E0BB;
	Thu, 30 Jul 2026 06:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p+W1vqRd";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DBA10E0BB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:26:34 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d01663d816so15876525ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 23:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785392794; x=1785997594; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3EaYXPThWNdkG4MwcQhWQJEAKHoDeZpU3BU1Rq69yw8=;
 b=p+W1vqRdXy/FlqxDxZ8ibUY0Ow56G/uPMvBH1/ZX3aEuuQpyCPiBLYaDqMobiGBpAp
 B8KgG5QEPhmcC6gRDqQ4zyhPPVuZiccgup0wmCpEH/X2OHxVTFO9Sa6wr698XuO7i78T
 9Uuyfiy2KPDvx55rKrnIIAjFxnqdY0z52QH7h7mAARBX5a0YakEav4b2aLG0ocZT5zLb
 S4N7e43jyo21fmQWX9nZRUhCGbqTHHKl3R1WM5k4wf55KV7wSn5gh7wlUSlb9AtbFsFv
 t85cvYz13C/CrpTaCPm6HtsJAheH9ZL/mkcYtNZ6RsYwdR47JmGfrhiQbA0aRx76RPAc
 PXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785392794; x=1785997594;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3EaYXPThWNdkG4MwcQhWQJEAKHoDeZpU3BU1Rq69yw8=;
 b=i5tnVnc8JcYFhZbFfCKvTtoJ5XsmCwgq/EU9CQItUX6K8FBmCK+MDLZKbUl/hZMjbZ
 O1/Igkfn4/KaPag/iWVHRVvoRkD03pvKRuupjhk4Y3gh4+rDtvFDqH3armp/3Q5HMlmm
 VpJYxYEJcI8W3jrq+9mWf5lyW88uSwzkwKVikxnGYzbf5z3rSBc0T38ZZC5INip2WUJ1
 Hq38XSQ0rMNDo2m2LuTibFLRivnmj3vlOr+GnccglOrhUVcbndiPwrPJP7hrflzSGOvH
 c9z+dCjA/lunM3TNr+nFNiSJJafvSGCcUHM4a8fVNoM11J6U91q/oAiTmxNgVFyr4qOs
 181Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqyOVRi8wrpbimc1KyQTDhc4ht0bYihz2Z+bctRY6n4cXIEUL4QEo7etP7da1mfqFgXYn6YUPQGF7s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yze9mszxc094f/fuFIYjq4sqifelnnhxtoDjkPI6CQQ9D5l+ZDJ
 VXTTMSai0DuUCnbjLbnVzAX6p5DvySqiSi8f5c87+pzpKX8wQoukEh/1
X-Gm-Gg: AR+sD12woUcecCKPn+NAaiBeH7MNd+nmjWlyCX3cDVLKUAl5lxZ2hoMTI9HB0blWNg/
 Jn0E8kaM/pv5+zU4php6EsIwR1EEHptzzbNRkzhzgwj+7wPBLVJNdmMzBSRGTtbpz1l3ZPQ5NNd
 U301V1ArmAKyb/vEF0tX87/41buNb5gbY/tHImHefYsYjkjmnfFgIvAp57tPB1e17aPFPceZ2Ys
 0eko7G0tHcHdtCCBqGyhd/FOLtMf+KBgNpNCaF5gssRNtDcbD5p5eKe+6P3vpqMGURy5JWs5Q8O
 9l/QXZ/OTUsy0OVq50fstG+fj+ub+X1rMtUu9iJTWbWKxbk0eiCgRDV5tBSvTFHQolgQ8oAaMz3
 fP4vWH0rQNOmgaDNpywTw/YSFzQ3mH1RmCTUc99JtzLXa915R4xP1q+V9KJI59dGumAca2xL1UV
 ZmvlC2/ar0vhqZrVz0u8BrdEdcUQ5L1wvl45UjbdkLDZ3kW72gU/nub2s2EEgj2f//
X-Received: by 2002:a17:903:1aa7:b0:2ca:281:27fd with SMTP id
 d9443c01a7336-2d035ca538bmr15480515ad.25.1785392793712; 
 Wed, 29 Jul 2026 23:26:33 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bc9bd4sm21059695ad.48.2026.07.29.23.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 23:26:33 -0700 (PDT)
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
Date: Thu, 30 Jul 2026 14:25:46 +0800
Message-Id: <20260730062548.231239-3-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730062548.231239-1-shoubaineng@gmail.com>
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
 <20260730062548.231239-1-shoubaineng@gmail.com>
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

