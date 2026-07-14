Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5906CC4450D
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8775A10ED17;
	Tue, 14 Jul 2026 11:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G2atzGQO";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4CA10ED17
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 11:47:07 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso2090719a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784029627; x=1784634427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CQQ+xhhQTJIQk1G/3qoal2tftp25+Ya+e3y9IcyhICU=;
 b=G2atzGQOoWMyXLDdfEd+ggbYnQmiod8/icrs+MW5X2tf5iGokc4y9JROnvofjWOGEd
 F0jVe2JD6pZVFlMDI7FMhMKSuxs+F+ssNG1dseALq0FQwTRlX8Zqiz+BA/PWRWOXbkgi
 YlCT9yTzhI3Y95rUUMOlkRvNRK/8rAv6hjs1T2qZs3p+uv5ITzdw5sNegbqBtAkp0/qK
 IZIFhzdWzZjIncC2G7cz5dpkRpE9TuV2wAOQEGsw8P6Ad1IDNHzUWU3hy57P15/YZKN6
 YOWcrsFNLmFzT71ay9h9wUR4MVbsq8WPaaAg+SSzAWlo5djZR5sGrUdZ5asTWhpQqIPI
 utqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784029627; x=1784634427;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CQQ+xhhQTJIQk1G/3qoal2tftp25+Ya+e3y9IcyhICU=;
 b=d4iAtT1Fcx+04+m7iMKSs+GvuhSKsB30sJYWGRGvLPahICKvAqauSBTb+/o53+FsIQ
 XX6YM0QyCHcWaEkKarTwB5tT9mRzKKaIuOHWGNQ43QMaeJEHaWTryFmYErRmTomFeOA/
 53NHU54ovDvaeyv+NayqRJHsi1LHDM8+yqS9dhf36S92qufiLJttcMeqOejA+ywY9scl
 ncq3jVihMVYVaKAG41xfhRruGghzYfC6ABYnrZc0f9q9QXQOwvnqPgAFO5ns4F0pXtc5
 j61m31ttUsOsO/Q/NsfOuVO04uN0Tx5juaOvVcUr+3uhhj6pf7gBOaONaJPqE5sUaPjF
 jv7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RorDTl2lJWJkhk6bQFSw2arIPlyQ8I7IFTgJc3NhGkBPgRtqqQV8lPZuMyBNB0dYQR3LP5zEpM+TPA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+wvXmgS4oBmWhMByFos489avqQsHZ+a4MZdRatdaPRc89vJzU
 cMu0PrLik0rltumCat+YzxJkmgQ8gae0e3wTKb385cyh4i++nOHa02S5
X-Gm-Gg: AfdE7clKMsWMsam4inoSJ4EO9r/5MjU64oyu4OMXheKn9rS1dBEVHLaEnPbr8fT/LpP
 wNDmZbivGmA5fv/GK6oSfYRp3bM/v8EQKdvFiCcHH/5NP+pV8P6lCg8ISDwDKwB97lQy2OvduRZ
 tEnZ6zdJMcFzlJ0dGRn4sgokTeyZjki3TT/7vfvbBRa3uli/CTsa59KZ9VZFA06U2CJK8U5H5sh
 PTEv6z+TNPQ3NEhrv7aW+P9T+y+S5OT55yMB0r+MtA4IpHw977gJILfPp0YjDjOQtLL3y18oq20
 4JidXOy/mGhdRX8qE7e7q+3ZcOTJqPyUA0CAR3pj1JsZ/ER/QoaSJVtPZF4FIc5geGeBstgNVf4
 KKBQH+mGbCMkG9fCDa67v1fg/LF25iFlV7NbwtN3PMud6KuGJrLK5TxhAG/c/5rda4J6UWLSCm/
 FTkMg3KsQAcE0ty+4F
X-Received: by 2002:a17:90b:2c83:b0:380:f34a:6ff1 with SMTP id
 98e67ed59e1d1-38dc75eb657mr11649534a91.17.1784029627050; 
 Tue, 14 Jul 2026 04:47:07 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e17470008sm1356162a91.17.2026.07.14.04.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 04:47:06 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v3 0/2] dma-buf: fix fd leak when copy_to_user() fails after
 fd_install()
Date: Tue, 14 Jul 2026 19:46:52 +0800
Message-Id: <20260714114654.3885457-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
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

Several drivers call dma_buf_fd() — which internally calls fd_install()
— before copy_to_user() returns the fd number to userspace.  If
copy_to_user() fails, the fd is already published in the caller's fd
table but the ioctl returns an error, so userspace never learns the fd
number.  Worse, the window between fd_install() and copy_to_user()
allows other threads to observe and manipulate the fd (dup, close,
SCM_RIGHTS), making any "close it on the failure path" fix unsafe.

The fix is to split the allocation into three steps: reserve an fd with
get_unused_fd_flags() (not yet visible to other threads), do
copy_to_user(), and only then publish the fd with fd_install() via the
new dma_buf_fd_install() helper.  On copy_to_user() failure,
put_unused_fd() + dma_buf_put() cleanly unwind with no user-visible
side effects.

Patch 1 introduces dma_buf_fd_install() in dma-buf.c (wrapping
fd_install() together with the DMA_BUF_TRACE call to preserve export
tracing) and applies the fix to dma-heap.

Patch 2 applies the same fix to fastrpc, which even had a comment
acknowledging the problem could not be fixed before.

v1: https://lore.kernel.org/dri-devel/20260703080922.1838362-1-shoubaineng@gmail.com/
v2: https://lore.kernel.org/dri-devel/20260710105430.3059661-1-shoubaineng@gmail.com/

Changes in v3:
 - Split into two patches (dma-heap + fastrpc separately)
 - Add dma_buf_fd_install() to preserve trace_dma_buf_fd tracepoint
   (spotted by T.J. Mercier and sashiko-bot on v2)
 - Add fastrpc fix using the new helper (suggested by T.J. Mercier)

Baineng Shou (2):
  dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
  misc: fastrpc: don't publish fd before copy_to_user() succeeds

 drivers/dma-buf/dma-buf.c  | 20 ++++++++++
 drivers/dma-buf/dma-heap.c | 80 +++++++++++++++++++-------------------
 drivers/misc/fastrpc.c     | 16 +++-----
 include/linux/dma-buf.h    |  1 +
 4 files changed, 67 insertions(+), 50 deletions(-)

-- 
2.34.1

