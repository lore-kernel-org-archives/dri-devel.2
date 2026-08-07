Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB3BC5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BE210F434;
	Fri,  7 Aug 2026 10:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Scg+EeU+";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F72910F434
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:12:14 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso2095337b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786097534; x=1786702334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3EaYXPThWNdkG4MwcQhWQJEAKHoDeZpU3BU1Rq69yw8=;
 b=Scg+EeU+dAs/b0/hp1QYJ32Qg6r2WuN0JFm88R8qwD2qZFtY5E667ZYJrOaiUKd1nV
 yg+RxSzkQCUrBkwDLSwNMiYUeOysvoUc0ghYI7Rj+NrW7hKDso0rLk/p08q9InHkxX2Y
 HwJMMY2qvTQMdmGUEzCKc6Fl3ZHR38x+Esfplfz83MRqt6a2JakdwsEoZo1PtdPMoTLB
 bJB4gyMlwndpqOUbaJVeOxRFKKi8Re99ppGGE8F2TLocmQRJ8/ePz1DixbLD2ev7n+/N
 G5T4f11VBSVncIZECt7vVaOdRpbIUYVMMsDVeI08zIGukfBbqATcEGw9/dKCIB2+wIc7
 nySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786097534; x=1786702334;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3EaYXPThWNdkG4MwcQhWQJEAKHoDeZpU3BU1Rq69yw8=;
 b=lcj+3npmkDyV2KmvgXboU9btcQapK2s7rVDl8mUYgmaPyMGq/6QVWCmHw7uAtE5HkV
 enXXS6DqLCaPIb0ARz4TC5rqJ2w6fmwdgYQTMSMIk3bp0ON6+AwWafYbFLK91WQyE3As
 m5OFyn+clfMVeUuNd0urY3ZRoaiYXWCbBHFKE87GPpPKILWdghRRIGFmd2t7H7+XKuSR
 iKPN9nGbXnRDkxRpXes7fp+tYk+Jfq6K+U+gJ+FGuV2UXhcIiaYBZO1hYTaG8ffiyMwK
 RKaKqQQsi0wMkaSq97zbdFJJvGVvro9w0cfvBsuBBLERcqQxVsfkGG9VPlLRWvKRGwmT
 8TXg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXbfXfaJz+DrXCcUvb/tgwexqJuE1CWhyYX7qK2eaQCTLzGktvQ2uV3ENOJNcg4sLeMBto2lU44pM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUZkF4XmaavW2IWFfly0l6Nz2nnkEdM50gBs+8HDvX4ffF4+QN
 ntMnTjqnBytsDxHD2A1hbxgJVxDSM5g35ugG4CaW846dBOEbZ5wYI9Tb
X-Gm-Gg: AR+sD11UH/UM3Ovzsfxdcmigklndszx6ezmqvq5hwJU5wnD6hqm3qDEbv+qASrvt25A
 NdXRBbDMyOeb2iliF4Rk9GNiQpDHP5Ckro9TwR6+ETGwy5XxQs6VEPk1v7G67BZRaTRpQcYOB9M
 a/TUpCRVfOuG1oTZCWMVC5mB6Rtznos/f4uEZZFMGFysk/VdibR012hDSGR7di/asJSaLjvI5F8
 jCjmlkR6/0/0V180y10CKwZCJuwOeTZART3YwaSi1BQ7iZcqhs/wQ6tF+bMaxdh1AyL8Qpmoqz4
 UYkgw+RfpgOLzPwwyEsRxDm+rWZpx+EAKsIdZZ3AWZeQaVjquxZL+QQS1fUHm7q2SYhNS4TtSZs
 QgekBXmOF7EMClWMa4wiNYxwKTMvX6+V0ZiGRBnygjejoppxseoUF0IVBDh2CnifxL9Huetz70A
 gdEeM3AYWhDraAx08gq+9P4Qn1RsC5UYAmd8Ff+WLfgvy3GRo44GfYZqVnne8zstECBaJDN+yV5
 zs=
X-Received: by 2002:a05:6a00:2406:b0:845:a435:a2eb with SMTP id
 d2e1a72fcca58-84f2e094eacmr22879939b3a.31.1786097533847; 
 Fri, 07 Aug 2026 03:12:13 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a5528adsm797510b3a.45.2026.08.07.03.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:12:13 -0700 (PDT)
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
Subject: [PATCH v6 2/4] misc: fastrpc: don't publish fd before copy_to_user()
 succeeds
Date: Fri,  7 Aug 2026 18:11:38 +0800
Message-Id: <20260807101140.1357218-3-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807101140.1357218-1-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260807101140.1357218-1-shoubaineng@gmail.com>
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

