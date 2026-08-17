Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6798C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22CDE10E637;
	Mon, 17 Aug 2026 05:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kQPUZqm8";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C8810E637
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:05:23 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so3092383a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 22:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786943123; x=1787547923; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TnRbd61Koh8fAk6B/yQ0KzLTDaUh5Tr2u2+ZL0OT4NI=;
 b=kQPUZqm8mVFG5dF6l7WZhvVOMx4XkWxc7yShDsNLuToofkN7LYORxJ5u5gPRzraK1s
 1DDwfOwIjxVAbG4a42AfhqZSpjwyyPvTn3KkdvgqjswFZW+x2OFND+h3OSDUPJXvJ24i
 ZrF9qvotmcjVoXPOhGpVFE42oMexAO7rXIYYxdRobtR+L5X3Zpzl4Zt2uOHv4h8nqV48
 n8Q9GVV0vE6IVZf2Q3ihhXTw4ag+BitauB2jVM9dbImxR5v7TvvJ2ImWn9/M6RRhujd2
 npbUArZHFL0ukrwxslIFClaNRVfQ7f/xM0YtSUhfZaTPMREtTsPq3agmRtpg3c7VNNO1
 WF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786943123; x=1787547923;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TnRbd61Koh8fAk6B/yQ0KzLTDaUh5Tr2u2+ZL0OT4NI=;
 b=QoSLHl5/6k/RXF7Q79LO3UkqiO/8TUtDy0oxf46NYRBdr+2K3NhTnVB2d9DSGL/Gky
 USK3KrM2wA7xpx+coEewPbhtgaVZ4QPYgXJn21RvwEqQvcQpnvJrj8VWyTWRDr6Tmkis
 ZgJJXaQXOD6N4pzqfjNjzQ+X9lFacTpfNaSMLbLLC9r+dj4/OFox67ZLY1EpGTIB4k4S
 VvKl+uyOLOHxtVk9PO1G3ewmIxx+QtRhpUDQgP2QA+M88jhpNcr/8Y/Q3X6CdujsIIKP
 zgKfd8KZkbnHr7Nbf6Ia6JmYJTJfwp8lkSQpNhoJZF6ORzZjNNHG8+aidEyx/hlRSdNA
 3N9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPby7dLuu7qrRK9N1cBasHpqoY+suAxm/6netQhYZc3FM3y3ldVT3VHMb/Mq23EIJNPMOeab5vak0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDBkgspghgXpeycnEMhUPilkMnFAXmz9dzzSaBbIIPfnUjEGWv
 +azEmC86kx7WbfY3fWrvLQYWMWBIL6O+pOu+EWQBghHUiWbxT1Y6JYMu
X-Gm-Gg: AR+sD12HMmt/73bwG9dJT0kGjqd5wan6CMb/S2Vdt+p/XoQv5fnWcEBGkwBrEMF+1LA
 a/1mQ7DEFD38W6dxbIhp4EXfNH4Jo1dWjbGwkpdHxZjc1Aj8A/9UQFzLph9PAUaGU/K1mCP479G
 CZNvzhQPpXTutHAkgClPHsz8hYtqWSrRhNTbq/Qq7F3S80KEr9YjsL+SjCPvm+9BHRkyGyDFkuc
 GQdEnb+lFaHiqb1cVhWEXY4Kj9Dn/K7VLu2pv28oDvxbKaTgSP/7GNtI0Rk3crZkakKWD3wI10d
 X+7889WpftxkWxDP6X8M5w8v9qFbgSy5AuBl8/8JFAD//DsJqBsfvUU/h4noOprV4Q/YxEOUPXH
 GKcorDNQRMx6PEJysbtc6dmDKz6TdFpcBaU91qcNgpovTJLV9uvvtoW/iA1O8+hnVmi0NdR7nIw
 Yw19wd6PMeqyAJ6IYVYpQ6R7JuveN/q4UptkzaPinbR3T2pnS5cP7hNwHRPFrNEVmYTKquEBafP
 90=
X-Received: by 2002:a05:6a00:3907:b0:847:e791:d5c5 with SMTP id
 d2e1a72fcca58-84fde2ded84mr22165983b3a.35.1786943123096; 
 Sun, 16 Aug 2026 22:05:23 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d267310sm2131036b3a.53.2026.08.16.22.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 22:05:22 -0700 (PDT)
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
Subject: [PATCH v7 3/4] drm/prime: use dma_buf_fd_install() to preserve export
 tracing
Date: Mon, 17 Aug 2026 13:04:56 +0800
Message-Id: <20260817050457.1005285-4-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817050457.1005285-1-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260817050457.1005285-1-shoubaineng@gmail.com>
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
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
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

