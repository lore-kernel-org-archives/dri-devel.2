Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4555FCA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9226910F596;
	Wed,  7 Oct 2026 13:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LA1HZ+Sz";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8BEB10F596
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:16:17 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-853619d9956so138217b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791378977; x=1791983777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z/dj6Lb2IvVTeq+ptx1rfH6bD+cptgUsmqXSt2Gyxeg=;
 b=LA1HZ+Sz0F8C9IkYyCmOR9cNwj9M0YhacsOO1rLtx2A8XvLu4lVNO/iA2Jss8JGnzw
 rZQReQdOiDyNkTBNzIz7zSo+Y9YxiQFERXaaOn47lKZnVjDUpiAtJLuzZDxHOepRfMJA
 v8Hr0SAXk9CazD3czBp0Odiyu5Z2oD35zlaYi3eCz/GfJhu1aWCf5j/3lZw+dMZPIir6
 k9UwPuamu3a3hWxS1McUjXb8iuC9tVpZS1essengCJYJJgle/V5Uln/5WGAeYUp72Gl3
 T6r+yDlFRJ+PWL64x+x+bGyIrxqpcHFRF5GSmoMfvxwApuJz34OcTzJ/9zpkLJizWhoB
 LKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791378977; x=1791983777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z/dj6Lb2IvVTeq+ptx1rfH6bD+cptgUsmqXSt2Gyxeg=;
 b=w19ErNJbz76AlWiiHp1ystWRDJGHYhUgpPJ0hQ+qloYBPEDZ4M6TOSBlhIMUir3+QJ
 tOXGJN3VxHch3Jz+WGzSn+0V7uoG8BuDR9vVAKLcXNZb+ZgVEl6NIqxEnuA13LtsBUcS
 RHpxSK/UOjxSB5VUd3Zh9rVzqG8SpKAk1Nt0ocB+gD+7w2UvCfs8s3tSssyMlgZDU3hY
 F8HyzgvkoL16Pe7j1KKQUXaO+gX7wORHQHSRgHGfc/HOyiTB4W1hDPx8CcLtqXaXhYTf
 Rk0plV5NaCiPPScry/E6hy6rz0V7NkZ3IUWRky/5QEH3zA+wJpyI4sBVAMRcsB48P9Mf
 Nv5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3L11c2dflSwAipB1vheK/MJib1nIXLL0QchFWSJhMfuZG36384d68aHycKW4WVIFiIdtqlozxkwY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++liEQUo9q9ehDVKPhaW1nlfecONKmKVf8J9+/H3jNLmS86lTE8z
 eDY3rMq0aQmyBGgkA33T3OTQE0PblktddmbJi0nz2FAmQaYV7IuPtwUzwJ+Unzz+dZ5rqw==
X-Gm-Gg: AYBFou14Myg2mQziwTeRufGhdzq6ZyIVIt7a9H6GdTaNHFDJCz1aC5cpm0voPuUMeHc
 LMe/gxHSPWZmvTBsSB7LNi4NH6YoqEji0w8t6RRlHzLNkGBCklCbLw049ZzmKMdIMOVpJGVZWqR
 n4fmiQvFE4bv+aFtjPqjB3pOzCEt1OGv5NzRbQnvjLJrpy8ZtaWxXHRdipfa6g2y2B65N6cRrXv
 wZzBIK1ZXkZogD2ZmvsmbVlgNAUQwLipB0uU5aWgO/l2YOzDJhxz6dWhlgavHrtviOdIkgT7Pes
 i1ZzkG3gMlQp/BaKktGW4/KZvWuRjBx5Wv26A5MFcaSsrsWwkgOtombu0SHERuteyQU2iGXpUbo
 QKRk+ny7Wus9T7TEdrw3wKUgCC6xCEqvNRkMI/kmHinh3QkkWMawa3t75TL1x0wyQFkyKbzHtH2
 MqUq4/9ddIprxrOY8FeQlq9yJmATlCQKuzOyzqo16zCLZPG8aNKMR3ooufalVqA5ifgEwIA1O8n
 hNN6Mm8ANOH+Q==
X-Received: by 2002:a05:6a00:4803:b0:888:400:7fcf with SMTP id
 d2e1a72fcca58-891b3b4c652mr1740386b3a.3.1791378977074; 
 Wed, 07 Oct 2026 06:16:17 -0700 (PDT)
Received: from jfliu-sfa1411.. ([240e:36d:b09:1810:7fff:6550:13f4:b6f6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-892bba97a22sm80118b3a.49.2026.10.07.06.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:16:15 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: robin.clark@oss.qualcomm.com
Cc: abelvesa@kernel.org, abhinav.kumar@linux.dev, acelan.kao@canonical.com,
 airlied@gmail.com, akuchynski@chromium.org, bleung@chromium.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, gregkh@linuxfoundation.org,
 heikki.krogerus@linux.intel.com, jesszhan0024@gmail.com, johan@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, liujianfeng1994@gmail.com, lumag@kernel.org,
 marijn.suijten@somainline.org, pooja.katiyar@intel.com, sean@poorly.run,
 simona@ffwll.ch, yuanhsinte@chromium.org
Subject: Re: [RFT 0/5] drm/msm: DMABUF_DEBUG fixes
Date: Wed,  7 Oct 2026 21:15:43 +0800
Message-ID: <20261007131543.7634-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
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

Hi Rob,

On Tue, Oct 6, 2026 at 6:09 AM Rob Clark wrote:
> With DMABUF_DEBUG=y, the page information is stripped from the sgt that
> we get for an externally allocated buffer that is dma-buf imported (as
> opposed to an exported GEM buffer that is re-imported). [...]

Tested on the machine that originally reported the breakage - this
exercises exactly the externally-allocated-buffer case from your cover
letter:

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer
  SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y

Hardware video decode in chromium (V4L2 decoder capture buffers from
videobuf2-dma-contig imported into msm and rendered by the GPU)
displays correctly, with zero arm-smmu faults and zero io-pgtable
WARNs.  For comparison, on plain v7.3-rc5 with DMABUF_DEBUG=y the
same workload logs UCHE translation faults and a __arm_lpae_unmap()
WARN storm (~470 traces per minute of playback).

This is also much cleaner than the translation-based approach in the
follow-up series I withdrew - mapping from the DMA addresses is where
I should have ended up in the first place.

One small suggestion for __do_map(): panthor treats "map_pages()
mapped nothing" as an error (panthor_mmu.c):

        /* If nothing was mapped, consider it an ENOMEM. */
        if (!ret && !mapped)
                ret = -ENOMEM;

With the DMA fields now populated on both paths this should not
trigger in practice, but it would turn any future regression back
into a loud failure instead of a silent empty mapping - which is
the failure mode this whole series fixes.

Happy to run more (heap-exported dmabuf import test, kmssink scanout
of V4L2 frames) on any revision.

BR,
Jianfeng
