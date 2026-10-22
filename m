Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8A606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 04:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G65ziY+6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C979710E1F1;
	Thu, 22 Oct 2026 04:05:04 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE45110E1F1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 04:04:58 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso1363018f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 21:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792641897; x=1793246697; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h3ASAw4d1cV9sNAgpvrJRUDbXY+sRF2LCr9CRfecXT0=;
 b=G65ziY+6vB8CEJqXA9Wmq72M/pQW7TBxBas4xl0bfhEYjHPXfpyiYCFuWJN878RSn7
 RLSCFJGTfudB4JRM9P9aEeaeHGR+qKqOzEgzJ4qDfcd222DrhWI2cC9JUeoU/Lmi6Fpe
 EtVF3roSKSlXi1+jheUUUlEsVxrxDDmOraBTSJTLD57Jrc4lecroVc+9tX7TlvDaWcC6
 VikqTwEZNbcgU1tYVgd4JcmZzgyk1XGTQB19mB18M4AYBld9SzfoysUa0vdwqBb/jgsS
 aQd2rJNCHz1VjM4wjCao5I5E8RJRmnXKOGxq2gy4rlhy/YVT39tXPEXREx+CWcyjE51K
 +Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792641897; x=1793246697;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h3ASAw4d1cV9sNAgpvrJRUDbXY+sRF2LCr9CRfecXT0=;
 b=UT3zAAkhoBRB7NbtHvERgpY3T4xir2xT+nrmUuUbOy1wFVEvmnV5orMRvRm3kt38gb
 cM8R368EHBP0m+nWLAiyy4K8P4XsEf3Ubz0FVmwEzJyPeW8x74wJETytQii0ORxryjgN
 T/cKz6x2BZ0D+dbN5eealz+v5spieha6KbjMtzYw/gc0qo0qy88aTgpqyqr/d0Bq0EcI
 pyOCG4j2ytl2RA/16xBTeIr1wLo6ngSXZ2BTsdqAWCLBCmQKGlICHdRVsLADJwgMar+I
 9BgUN3PdYCCg1Kf8lDzFOwd7ByHVrASNF2KUwvl+B8Zo40OB3qRgZlNVGYk+ruNHRge2
 igkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzW5WT0MfVN88vTnwxrG3Vns1ZsEbqL1lM7LFYDY+hD1DryIT2BfXZBdlcRocI7pu+wx4MP00h/pj0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIlKdf4fADzF2CBqQZXwTRiQ+KUMcskjO4trH2gc8M2pxgWmrbw
 E2WMs83NRs8nOzxu+PjnhAbR8FoTDIsJr7T60LH7/GDl6Nj+BQ/BX5of
X-Gm-Gg: AYBFou2Jmzeo6dRbgTFwiTIwVrKVATLYHqzaHaEMXJzFVhd73W9er6H4On5D6c84Xnw
 RYvmeSqU1jcLbcoF9C1MEKlmwe4jxuPTz93S7X8/WhvtIk2gNk5OyuAr0RR7hUBwwcebxBgGoab
 mg9mc4hfopY6oEe97YDBjm/FvLzW0TTWG5vAlROuBgT2y33BdaPtEOZtVLNdaOIA2Y6c0W7OT5M
 +i5jYuoUCkPBqLRpBh7lMPc3qSo88iLyAYL4ySIPHjzJ2gTjR1KjD3KGijnUmbjwhatD/XOcACJ
 MOY1e9So3WIFkotkkyhXH5/fWXgrGeWU8q9zJU+coYCM0z4WvJrOJ4stdS8i3WT5LG0qu2D7N/h
 wigFnJ5WfBgeuQXXcoGHmdTpcT76i01g0pDKxurnGHya4qCwvnBH5Axx1+AggyN1NI9erl77qxb
 oZ88/YqAlDLJr4Oij/UP9iD6IdlhVzxPbAdHmBVBIarhEGbMk7usEqF5/KrLMQ3F2GLboS56zEe
 KQcPbMxoL2FbXkU0Rbgy/t/9SbHPS+eM5IDacTmATuCWanSE01taFeHrHIBXJBvgiEPfZUd2JLp
 ZxOrJHBPdnRciUFstdJxix8W0fsqV9UGniX54R9FartSAlw3ZRYGyhPdThwF1ew/Fbu2/TMbUY0
 m5v1X5OQB7dYepbD5YiawDFzz2vPY7vqdbniZb0p7gMYgt6eeHjOGKUcYM+WbdttR3L2toPxV0k
 M7iX7nq5A=
X-Received: by 2002:a05:6000:2dca:b0:48e:3d2:44ac with SMTP id
 ffacd0b85a97d-48e264a65b8mr7995973f8f.15.1792641897198; 
 Wed, 21 Oct 2026 21:04:57 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de.
 [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25b04883sm10144016f8f.0.2026.10.21.21.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 21:04:56 -0700 (PDT)
Date: Thu, 22 Oct 2026 06:04:54 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Tomasz Stanislawski <t.stanislaws@samsung.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] media: videobuf2: add opt-in DMA-BUF CPU access
Message-ID: <atmKXkOJiGJXgRz-@gmail.com>
References: <cover.1792392288.git.kmehltretter@gmail.com>
 <673c04ad9dcc4f12685c076193ebad9e48e5f08d.1792392288.git.kmehltretter@gmail.com>
 <CAAFQd5Djx0kjeFpzPWEgRV5_MhiJAW8tg-2C+cYxqMf45u_-RA@mail.gmail.com>
 <20261021175900.GG15441@killaraus.ideasonboard.com>
 <3084b9bc0d4b5593d2bfbfecb0ce272cb813ece9.camel@ndufresne.ca>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3084b9bc0d4b5593d2bfbfecb0ce272cb813ece9.camel@ndufresne.ca>
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 05:03:19PM +0100, Nicolas Dufresne wrote:
> > I think the dma-buf API doesn't give us what we need. Cleaning the CPU
> > cache through end_cpu_access() when the producer is done writting to the
> > buffer is right in some use cases, but not in all of them. It assumes
> > that the next consumer will access the data through DMA, which isn't
> > always the case. What I think we need is to track the state of the
> > cache(s) in the dma_buf, and perform cache management operations
> > accordingly when needed. In the uvcvideo -> display use case for
> > instance, the dma_buf should track that the CPU cache is dirty when
> > finishing CPU access, and should be cleaned on the display side before
> > performing the DMA. In a use case where the producer would DMA to the
> > buffer, cache management would be skipped as the dma_buf would see that
> > the cache is not dirty.
> 
> I also second this as the only viable option. Its not only about uvcvideo, but
> any memory imported by a driver doing DMA (which is not also the exporter). That
> includes udmabuf usage. These days, cache artifacts are visible with Intel
> display controllers, and Intel mobile GPU drivers. Note that GStreamer properly
> signal CPU read/write using DMABuf sync ioctl.
> 
> For most Intel laptop user with GStreamer 1.28, these example produce artifacts
> on movement. To me, the solution is to track the cache state according to the
> access signalling (either userspace or driver), and let DMA user/consumer decide
> if a cache flush is needed. There is a obvious challenge in keeping this state
> coherent whenever there is multiple consumer, of if some broken application do
> concurrent write. Result for the last will always be undefined, but the dmabuf
> CPU cache state should not be undefined.
> 

For a persistently mapped attachment, where would the transition to
device access happen? 

dma_buf_map_attachment() may only run once, while the importer can
submit the buffer many times. Would this need a new per-attachment
operation before each submission, or can an existing event be used?

I tested that distinction with one persistent V3D attachment on my Pi
400 and Pi 500+:

- If end_cpu_access() only recorded dirty state, with no sync before
  submission, V3D read stale data in all 64 frames on both boards.

- Synchronizing the attachment immediately before submission produced
  64/64 matching frames on both boards.

This only covers V3D, but it seems that a dirty bit still needs a
device-side use event. Is that the model you had in mind?

Thanks,
Karl
