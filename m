Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FA8C5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE89210F443;
	Fri,  7 Aug 2026 10:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BUzEGSd3";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E879710F443
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:12:20 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84a652535dcso2156856b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786097540; x=1786702340; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8LdAoJKwXyAPy2Oxe1p5of7f27uz/x1w5QiaYqvn624=;
 b=BUzEGSd3pZayvwrcqwnmeA2pNqViqjwkHFK9QbgHTdyxWANOhXfyuJgej9wfMtXV3K
 zviFGHj21rDIZeaYLvp0WkcN/tNcmvEXarIzruBLV3bzRTNPx4Qmt51jU1dnJoWbKaqp
 w3pUerzuLBv308lxb99LuVKCIjynYpThKFxP/q37M/E+eFKfBPEnmVCx2/HeDyBMZYyq
 WQZidQ5eQK//Mf5IJeMtKyvEomQI/hg95Zs52BAMNv6FZ6EgSdIcphcF9RN5HH8fFtTI
 bfYZvQuX4emqedXh3J0RMFzKG4Eh3zTW0a82fBFtrigKl0y61HW+yV4ojf23ti3gWi8M
 bQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786097540; x=1786702340;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8LdAoJKwXyAPy2Oxe1p5of7f27uz/x1w5QiaYqvn624=;
 b=q5WzuVTLOZ4t3AE/JQU6ynu85LiM/0Iw5RgxErRX4nLgGvs7F/w2+nvbm/tJqFGn2m
 UXpWxOYGX6cn51mR1edpv3jLi1xjDhOCuHcMuIOeV/VmhyVB/YLAn5xVUsS3Ska9PkFM
 Aahdkc3/alOg6EZWuxBF+zUqXY0T2s7SbTvzSFgu1L8ROzeTXk1jeSo0+LbLkwnKmxhv
 ENoS1cuD9DKNFS+k+UyuaqNfqKV5OFW1J6/hm7rHeNnBTG7BdfJdQMBt2S0nMGFczQ3Q
 uj/iHKNAY5iHgBCrLjQFd/vTBqTt77huiPcFHX5XGaD+lGDBK/TFXEhmo6Y66VBnO/+w
 /Upw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqwy4YXgtscjx9v/7uUbnDgXehAxFeuWmxeEzlVRiP4AlXDveHSl94mKhZkZmjYam9uUOHRoHeBLmc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcL47q2TDVWT2NVHReDoMQuM9PegZ9gGbMWuCxQzfmY/FBKL/0
 18GsrA6v67wK38qikloKI4j9qTcfTWiGSrc5hwtxkPaktSwTj0p0rVun
X-Gm-Gg: AR+sD12nh3+2js44qwJCMQuURMyDQJHw0TEgJM+eSeh60SeOdkMxlA6jh0sIhxh68hF
 skXmZ5lnl8UcXjDrMVvRCfCvfRGYBr7fnVfeBYc7FfjK9o6yTVe6Ul9WfCYXAzuVDd/KDKcIO8C
 6byWtjN6Ykzfs9I7VqhzrEa5067RcQ2eMH3dQROixvK/5CIV4R5H6Xo75iCEhluGpLlBqiGoTA6
 oYRpJS3XuN48IX7coDo61Qn3wdX8XbBeuJW4aK2nDMzjutwtcmjiQlbPADH250XggeP0TjM2TqA
 cVs+r5sopAYF/WITuIBnIldzjHam6IoBAW7r8qGoQFkBotbSqDgpVzdXVrVrG/eAwnXwZaYdpw4
 3hQiKrnAMuQArbAF9ng+yokSaVIV7dxAFz14lr51bAIEEuwxuGYxA+HihngKSu6E5Abdkm+g5cp
 WhiUdwCWMMz3X0N4PrRyyGO8jOWP3B9se+J9/MqMFUtIqij8Kx2EXu5PPDGq2qKSlp
X-Received: by 2002:a05:6a00:32c3:b0:848:47d3:47ec with SMTP id
 d2e1a72fcca58-84f2e0826afmr26947369b3a.31.1786097540308; 
 Fri, 07 Aug 2026 03:12:20 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a5528adsm797510b3a.45.2026.08.07.03.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:12:19 -0700 (PDT)
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
Subject: [PATCH v6 3/4] drm/prime: use dma_buf_fd_install() to preserve export
 tracing
Date: Fri,  7 Aug 2026 18:11:39 +0800
Message-Id: <20260807101140.1357218-4-shoubaineng@gmail.com>
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

drm_gem_prime_handle_to_fd() open-codes fd reservation and install
using get_unused_fd_flags() + fd_install() directly.  This bypasses
the DMA_BUF_TRACE() call that dma_buf_fd() emits, so observability
tools relying on the trace_dma_buf_fd tracepoint silently miss all
DRM PRIME exports.

Replace the bare fd_install() with dma_buf_fd_install(), which wraps
fd_install() together with DMA_BUF_TRACE(), restoring full tracepoint
coverage.  No functional change; the fd lifecycle (get_unused_fd_flags
→ work → install) is already correct.

Note: this patch depends on dma_buf_fd_install() introduced in
"dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds"
[1].

[1] https://lore.kernel.org/dri-devel/20260714114654.3885457-2-shoubaineng@gmail.com/

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/gpu/drm/drm_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 9b44c78cd77f..fe3436d1235d 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -524,7 +524,7 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
 		return PTR_ERR(dmabuf);
 	}
 
-	fd_install(fd, dmabuf->file);
+	dma_buf_fd_install(dmabuf, fd);
 	*prime_fd = fd;
 	return 0;
 }
-- 
2.34.1

