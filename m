Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202B6C54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CC810E655;
	Thu, 30 Jul 2026 06:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i4hvpLJV";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903B910E655
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:27:37 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84a652535dcso1332631b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 23:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785392857; x=1785997657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8LdAoJKwXyAPy2Oxe1p5of7f27uz/x1w5QiaYqvn624=;
 b=i4hvpLJV5t7RQjVoAJYdynmgpfVpbiRciCyOMcj/76DoyDZPIaiig3jwQqTFX8itLf
 MZ/WCfeWGhValV+fbdZheO4elqRyOcbtZ1b8b0KUDN+3eyUv4aCGPU6/nGgAYe9EVTXg
 INI0MtmvDKsDaDFbSZC4Pdv3VUIpm6mzmepCUS9DvD4N+SJtHq9ce+gLm/go4tb7vOEI
 lI4FoJfc9sVbMpIRSTEtAcSkisGK+3oIx472ijRjRZujQ8OZx+lKwcRXkLSusm+PvbI8
 e8yqDJsliRFWYrVFFFKbNGDUbFxDda5Vsv2i/iSWQzX+4SPJglJKNEss9nQbX7BnmbfX
 8Ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785392857; x=1785997657;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8LdAoJKwXyAPy2Oxe1p5of7f27uz/x1w5QiaYqvn624=;
 b=Y5kQVdimTVW7RP0UbDYabtL61hVk4k7Kim6bw2CbD3UaIYUZ5mXhB2hvIw2PnMoqDP
 8m7DanPb+1+vZR43pidUaCmMIcfd0wdzcLuB/Ks4SvZsaWChdKbNWRHJ9zRuDT5QMKgv
 lMpRHDZF+lk02fJqlbqNRIiyNhcQEd3K1goyitCitzO6RPe687brXBWE9u62drP1DwJd
 giY+uFdkNt3OvMV0X1BSsxKSnnI4FMYYw7xmIBpT1pQqwyAuFWM24+DvYhTaKrfyrWy5
 ptYWntEB61fF2Qnn/RjP9YwkYu0zZ1g7Q0b/Sd1EjKH+1vgaRlWDx/jxwo8AwBoy7s/O
 xweg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKz63gCIo8o0vy3k/YrLXZ1ivQkhgS7ZOEo3P3c3QpjVTOgjmJaXm9qoEHtOyVMR3lRqlUjah2urM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxKCiTqsWIqaZIL+/YjkvIEuLm0s6VztRHFo5dgiIDjyOnebLv
 9lnIL21aLsU26htUYcTG8Wb4hzl3c0EXpEm4LzoTBLyVPfcXqEZkewWK
X-Gm-Gg: AR+sD107D8pVYPDHlb4Dcee8CnKE+4PMcXjiaei3ZZFRLZ+2CHE4fQ9OJP/yh4nkpLE
 7AZGi669BY0IG/PwOQs/NWZqoGynPqXdRxpLF6yQUFYy8T/iWViMPA7tHTkAKQHcjEcVux8vbfZ
 Ip68WJBcjNpiFkHXN+mGHOnHuCHY33rXP/HfJ6dI9/TpD/4TugOl9bNVJP+27V2bxPjv2A+rJv/
 dc4GCJicl0zXmBJ+FG7zRdg1DgZB93YxECgwhMc4tgKDQNww+M6RJJDiLVzNgg/JN0WMdRKKHOG
 9hmdkaCk6cB0GbhyhHqYh+p4/WyBBJ1TDKRxJUyRTxMTnZQhY1vYmp/DfxHL7WsrYtKu4fn8//H
 JmghiDA96lhtZL55DG4HfdUvglzDI2WGcHN8gvwFGA12fVCyRrKLfF44zfw5tJlBfc1KMN2E/KN
 5xZMRsRTykB+9f5c9Vn14A1loxz11kOAFihAILMdCvccxzaVVKxI1QHAUREOBntEEPUR3cMlrsA
 SI=
X-Received: by 2002:a05:6a00:2e87:b0:842:5da3:9b89 with SMTP id
 d2e1a72fcca58-84ebc3e1d64mr1491102b3a.38.1785392856941; 
 Wed, 29 Jul 2026 23:27:36 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea00507b0sm2503229b3a.14.2026.07.29.23.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 23:27:36 -0700 (PDT)
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
Subject: [PATCH v5 3/4] drm/prime: use dma_buf_fd_install() to preserve export
 tracing
Date: Thu, 30 Jul 2026 14:26:44 +0800
Message-Id: <20260730062645.233148-4-shoubaineng@gmail.com>
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

