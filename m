Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68FBC98326
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9562710F932;
	Fri, 25 Sep 2026 07:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sjnrU4Wz";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9C210E960
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:44:36 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc0so559055a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 23:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790232276; x=1790837076; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=plhhkjlOjAprzRnn7KgX9Cl61oB+FHlc7TB72lMWDUo=;
 b=sjnrU4Wzatp58KzXXs4zBf2Ny5MYH68INvFUDi4vUHEVdmJMd1lAqiG8/6Q/kXMS1I
 TdpRE9W+dx3RnSKhG/c6NNQ8txGnxSCaKel/wntxE3pBROfjALhaXY/PCBfSsc8RIqmw
 8H1H+AC/lvw2rDRQBT9UZLejiAfs7jLwiljRKpiw5NbL+zufIKL5EE8ZbzD+b4A+0CiK
 wlNIqWetiR0x5Bm6W221DaZjytJlDYdNuYfGYJ5ROB0+Hl81aFLFl3PO1SFp3B/WxW1L
 YLujjPcbsFOvlynZDYNRZHzNMb8N6ou0uR6Z3/EJefXDmOlLJkSqc40shBPVkXKvc1EO
 ukBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232276; x=1790837076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=plhhkjlOjAprzRnn7KgX9Cl61oB+FHlc7TB72lMWDUo=;
 b=bw/4ql87x7cdHjuMLrTYP+gyK/Y7A4zR6GOf2ItHxDr0hbyx+fHfJ7BTcluWkMPI8a
 R5+6e9/pSmHi77hK58V1RuELaUkNGy1DLDoZHkLsBMVj6ZIonahciiJRaYXvjymR6SuJ
 19yZfzwfh8mR/wr14g5HVSTfJRwSJWOLtRYUFCT4BWWmcsZQjI6LLf/sv3Pcr9PIE9Xm
 gL37z7isSn7TnWn7qkeg92JwvHWJYpcAYkqzwVdSu8syZ5rhMOjf6Q/0lOZ+0ysPsAgP
 eZaFdTm67VeNdsuywoQI9qcsoaRP1HjcrFkDutXgnnh+nTD66OxcNtu42QMxVtYqhxsU
 +ZGg==
X-Gm-Message-State: AFuF++k/yLqQyLtW/K+s7faCJj+eoUhwlMS9XOa+B6IRDYFp2Gcx1BVC
 rJ8McdJUfVC7PKxAn6nBli/BilH8824zY8Cp/1/tx6PD27k6B6prMFsP
X-Gm-Gg: AYBFou3dDqC0PBrNjalih/D0GNKAqHDJmgvvqtswZdRbm27gIK/M0G6tZMzp2AlYplo
 MgDWIiBIbknmvk2wLI3nX1ajTABNqJoQZKH/BDCxckb/KQqMw4gcG24XhUU8//RFY5J2mrp0+3N
 oFk7zGuxhFW1wDRnn/vWDhpWTk5P0Sy5+dGvm6XYHbwxWlGuGhWLq9Qu+EbqpQwBIP7OGuwb+RD
 4VunZl6h7ImVayK/mGo0NwOekbMBmVMdkVYvKcLa7+C55TAHJUcZDKC+dFfTAVM9YM6FvSfMDMG
 pdCrw1J94TWmq0F0ldywJkbvolN0xIifcOeMIOxxGc4ipYrEydeUm7P4RcqTWwXyWQYzLj64aKa
 opwyLpPqj59yRDz8dwelA4DOiJcttDrx9IfrVskGWQoERV+AJLW62sdbzSX1h40ViTlpC0TYfvN
 G47PZfq0lYDcEAdBFt1aFnO0jc1v/AMpoyVu5Yq96U2QX+FvlDl6iMtEaYMs3R/Aup/WVk+Iwtv
 6Uk0TiNj+dtnxR6ovDmtSNv2va+Mgw9Yu9toI4ASrMQfLKZwqe8NG1uJK5zeevWRXDstRnwNue2
 XN6KXQ76L5o=
X-Received: by 2002:a17:90b:1b03:b0:39e:6c6a:4b67 with SMTP id
 98e67ed59e1d1-3a098dfb096mr1248459a91.49.1790232276347; 
 Wed, 23 Sep 2026 23:44:36 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972efa0bsm2960830a91.8.2026.09.23.23.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 23:44:36 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jani.nikula@linux.intel.com, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 0/2] drm/udl: fix EDID short transfer check and probe USB
 cleanup
Date: Thu, 24 Sep 2026 06:44:32 +0000
Message-ID: <20260924064434.2541959-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260919223511.3889061-1-benquike@gmail.com>
References: <20260919223511.3889061-1-benquike@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

This series fixes two error-handling issues in the udl DRM driver:

1. Reject short USB control transfers (ret != 2) in udl_read_edid_block()
   with -EIO so uninitialized or stale bytes from read_buff[1] are not
   copied into the EDID buffer.
2. Call udl_drop_usb(udl) when drm_dev_register() fails in udl_usb_probe()
   so the allocated URB list and DMA buffers are released.

Changes in v2:
- Split into two separate patches, as requested by Jani Nikula.

Hui Peng (2):
  drm/udl: reject short USB control transfers in udl_read_edid_block()
  drm/udl: clean up USB resources if drm_dev_register() fails

 drivers/gpu/drm/udl/udl_drv.c  | 4 +++-
 drivers/gpu/drm/udl/udl_edid.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.55.0.1082.g2b9226bbc0-goog

