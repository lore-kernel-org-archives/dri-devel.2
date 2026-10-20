Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAC0606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tBdUvLwd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4803910E4BF;
	Tue, 20 Oct 2026 03:25:05 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D341910E4BF
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 03:24:59 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so2273442f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 20:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792466698; x=1793071498; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bTIhfRXQ9A4fWivlb9V7+Dkt1Ju5gj489YBq7QLLDIc=;
 b=tBdUvLwdlrN/HlrhpIDVl6izHpRwTI4jbzV7d55zjrh5QNBevTa9XKAksMQ3pDRuh8
 JktxPQA07bNxvD6o0YdIGdWM7MMvYpdM4JRVuVUYpFJORnEo7AzshODpo+FOFoTtBdRa
 bntMICY1lMQZNU0VwgfrewEvJ8uQJnBnuN2679SRWQ/acZ/kJXbtgtsCjiLq0xjlSnPB
 Gpx+5jhuDiXXCJyoNVua2UsZVDVLO/YPwIuXucxmsr8umAA3nBaPoUnsfe7WSXdF5UKK
 cD/+5Tz0kslWZ5FfzuiubuU1xhLVcA7A2WgAMngTXyeEHTqmBNwoMyGUigB/JVYphCEt
 sxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792466698; x=1793071498;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bTIhfRXQ9A4fWivlb9V7+Dkt1Ju5gj489YBq7QLLDIc=;
 b=KlvxFDCJ7qXTql8azk0jz8y0RDe9LT67uXLDMtNPPBa+lR2XfpTUPuP5a38Jz4yklZ
 PSAjcBbIeP3JDqlX/LMcLdp+PawrGPJuhfu2XPhoTMdXafgivw+uiHVbCx7bzlH61Rk/
 i8nw3xPVjfCUL/zioLjOlfjMAXrxt1QMKzJZ/pziIYAZzAJNrJJvSmOkJyXP9lcenO9W
 qlk4Lz+K0/ThlRgQmJZyNzISE01Cxzl7//fF7qEGBbybXGzHCSXF7N/IlxWqc2Bs/W41
 OtfRvwb1XG/sn4kWxg3k3DdSMOjdJ+6X7t4t0qtnD4ACNzjO1PNBrxRNWAkF3SwXvIc+
 HyxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByCrnQuPH143I3nhebGHF6fq83xWNBDh3Baj7yKlu0RG1ckVTbOksT9wMAgGPwW0WAuqNFkVMhazGE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKLWk5vjRLsoXsuEav0Gk8sjXpatsuCNKbZd/TbxVRBzLdWfEll
 lcQV0tFyojz83dsyg85p6iSJJyRDx56vqqhpxLC/PI9hUhAgmR+zLQOp
X-Gm-Gg: AYBFou1F2KJ9Z9XD58iD6Z2/chlJIHuliTlLFSPREpGRlVDJHNd2IJ1Pml620+4SBj+
 5omwXypxK6L03jowNR9qkZ0MVmFBRxU9H2XfTvDdnf20syzNBG/b06aHcC0+YsocFt09+mbPvfO
 GUVjMdTHPn6I0e/b3ApYHfLY0YR56EhnwrMeOvZ7x5v1p7EcNM80hUVY46xZV6hu2LmYz4XLa42
 5dJDR07nEyjBoska91f6E49g6CHpNiYYeshZx48M9FrLAPOYjPl+z30l5TCyVFXR1d61f15PNzr
 OHff6mF2w0oNVPRWFRdECmmoziZPlIaE+QGblZwIFal6B8ghYE4RDE1qzH70GY1Qw/qm1ULxs1B
 sPo9pT0LgSjiE83qT1SwSrPt0FGnTbRV7IN8yDGwWkfsPgWrKUJQV60Qrk3TLN//awoJ6EHtYlr
 xhp4G2HzSaT9fP1Goch8Mnx85H1Dn4YwsFjnrFcAOCELBbT8YG7m74ziFgRlI1rcFwEqWThuHe+
 rCmQAni+CNrs1DAXVuwRSV4wawWGB5D+hUnSyAQHO+Mcjr++wK49znuWY7+X17ri8nBD9ybvM8M
 Yr4I05KVR3FoEv/mYGmIT5FBBdtMl2luEoPLlRL8yNsNZUr0y0/fSo72yebxN3H1Qsj+6hU29Oo
 =
X-Received: by 2002:a05:6000:2583:b0:487:490:8391 with SMTP id
 ffacd0b85a97d-48e07bb58aamr21758837f8f.16.1792466697879; 
 Mon, 19 Oct 2026 20:24:57 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-9c92-6501-cda9-90cd-4e49-75d9.310.pool.telefonica.de.
 [2a02:3100:9c92:6501:cda9:90cd:4e49:75d9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d818d61sm2909579f8f.31.2026.10.19.20.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 20:24:57 -0700 (PDT)
Date: Tue, 20 Oct 2026 05:24:54 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Tomasz Stanislawski <t.stanislaws@samsung.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] media: synchronize CPU access to imported DMA-BUFs
Message-ID: <atbbdKshkbmbMZMk@gmail.com>
References: <cover.1792392288.git.kmehltretter@gmail.com>
 <20261019124433.GU595565@killaraus.ideasonboard.com>
 <b9f5ee4d-987f-44c2-a1fc-2570f4500803@amd.com>
 <20261019150116.GA3705@killaraus.ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019150116.GA3705@killaraus.ideasonboard.com>
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

Hi Laurent,

On Mon, Oct 19, 2026 at 06:01:16PM +0100, Laurent Pinchart wrote:
> 
> This patch series introduces a big penalty in the common case where a
> userspace application consumes the frame with the CPU. There should be
> no cache invalidation in that case.
> 

I measured this on my Pi 500+. The cost appears when the DMA-BUF has a
V3D attachment that stays mapped but idle. I compared patch 1 alone with
patches 1-4 on the same v7.3-rc4 base at 640x480 YUYV. For the DMA-BUF
runs, userspace read every frame between DMA_BUF_IOCTL_SYNC READ calls.

Median process CPU time (us/frame), five 1800-frame runs:

                                      patch 1      patches 1-4
  DMA-BUF, no DRM import              129.2        130.6
  DMA-BUF, idle V3D map               130.0        153.1
  MMAP                                126.5        125.4

The no-import and MMAP ranges overlapped. The V3D-mapped ranges did not.
Pi 400 reproduced the mapped cost with vivid (+8.7%) and UVC (+7.5%).

The task-clock profile covered only the patched mapped path:

  Operation                              Sample share
  DQBUF producer END|WRITE clean         26%
  userspace START|READ invalidation      13%
  userspace END|READ clean               8%

I tried a CMA experiment that kept the DMA-BUF callbacks but skipped the
read-only END|READ attachment sync. The skip variant saved a median 12.3
us/frame (8.0%) across three alternating same-boot pairs. With private
DMA-BUFs, the full-sync and skip variants both passed 64 byte-checked
V3D read and overwrite cycles after END|READ.

That experiment still performs END|WRITE and START|READ. In a negative
control without END|WRITE, all eight V3D reads returned stale data.

Patch 1 is independent, so I can send it separately. 

For patches 2-4: How should vb2 avoid the END|WRITE/START|READ
round trip when userspace consumes the frame with the CPU, while still
publishing the frame if the next consumer is a device?

Thanks,
Karl

