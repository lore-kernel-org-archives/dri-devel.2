Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0888C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C4F10F8F5;
	Fri, 25 Sep 2026 07:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pt2ffFSu";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84E5110F36F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:30:14 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so1224443a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790235014; x=1790839814; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kgip3jFcH5aQqUb4V/BMgffhYqMwWeXQnhdcCBzw/vY=;
 b=pt2ffFSugHQ1m49FX1X7BDixxp6s1tfxdnd6VgC4c4gha/ix3z0po267SRueqHT843
 DiJZXPXZKv9zzztLYfZmeKWhUEyI2ltIfwRYXI2Ir9YEDSSs74sLhN8cHkkM6SPX4Qp+
 5WadZ0+ZditKljVLw4shhWIaAa7pIi+YinWqXjsontMVXa9o045JlNUqx37BE5+6+Ixb
 +YZdK+MtCtQxQMAjH8ahlGoIZQMdgc8s3qnJimQ67nHv8wxJpyhIjsqdlq0/Xt8ebsgB
 kBUFeVpoOc4RFgorZ6x3eG/4VvtQIjmTBLZwEZElxsLmG+lhZxI34I+zF5Df/iX++kLX
 r7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790235014; x=1790839814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kgip3jFcH5aQqUb4V/BMgffhYqMwWeXQnhdcCBzw/vY=;
 b=pVjxksNA1BQQHHZUcbP9jrG3v3xCm9Pjzfi7Ap5+BpbFUjIRxCl50+dTXsVKEOTC0K
 0u5LLEkF27jqNY6EpFcgfbZYEw8GOhJLJiyY0B6O45+08lPVHdAMhclREMSx8xLMrLHZ
 gzjrATr6/yhzEWQsWzi5PA4PZlc0rsa4ppXhSfpjhspZNowLWwiG3189WWHHxs/l9Piz
 F/ISFC2k/DvTaefyS1cQHfdLFqRJjCNk0iA7q6zQbRVB1Ir1PI6n4fr/AvY0Keccb+uL
 QOa+kiM+H9tbRKflis6fiqaVZm1494mnHtdLu5Nz075iAdJJwvP5lzloZyVzotJPJwgB
 luOw==
X-Gm-Message-State: AFuF++nLNgkMEI8ZEfL/iAyQYKri8sSBDDaJip7RI2/QFVb6868NzPX+
 D2UXRY14XQQbpA5U60GYcX7XkNKER1CCPXT+LAh4CXpqQQT6/nEA9BeH
X-Gm-Gg: AYBFou2D3nCHgBB4p9H1WK1ueHg4RrNYIvPi/AYXxqkECCUwrmV0KrzrR6VuCmbaB6w
 uwD6mNpvoXStRPTdt4h5QiXoX/OrUnmM4IlAXOkojvGcNtth8vc+pOpD8sVD7AOtua03GcZjMC5
 yEntA2YRpSYnXralg0M8oP8/BWbXSOWyLtKvId7ectqu/Lu0M8ejZIM9T2JytDBtBWrmnxyhEg8
 pGBSvAV8oqtucvW52dEN+rHEDRsc0RmAtmHQvioaaPaqvEu6W34gsf8U3vQticbWbSFLk30wO2H
 z9WqVL4tJ/HJ/Dhw4vM/J2TVf/OoA+K/UBiaG3ZM4yeEc7zzTWDrJEPU9vE0QhR2sTI19qm9oRQ
 O/0kuaJAt2w/nXwYztj82wwjzMh3GiHIofiZ22e/jY93PT6W+xhiPhkKrGXQA1Uf0MYoYUf7cst
 fg/OEiV50tBpCRSE3rbi5ViKNusRZ5c4f2XlLJQKf3QGHd8559u9G8+IAJAivNcWLhPuAX4FCH4
 z/0kCXChlggjJW+1Ug737fhnNeWAE3qz6/ec0IU475JR/v10iyOGQtT91OXAjk0rcmpRwA0vQQI
 6b57us2cj2Dq4ZBhdTpM
X-Received: by 2002:a17:90b:388d:b0:3a0:9640:803d with SMTP id
 98e67ed59e1d1-3a09857005dmr1361485a91.4.1790235013787; 
 Thu, 24 Sep 2026 00:30:13 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972efa0bsm3184726a91.8.2026.09.24.00.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 00:30:13 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jani.nikula@linux.intel.com, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 0/2] drm/udl: fix EDID short transfer check and probe USB
 cleanup
Date: Thu, 24 Sep 2026 07:30:09 +0000
Message-ID: <20260924073012.2742968-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924064434.2541959-1-benquike@gmail.com>
References: <20260919223511.3889061-1-benquike@gmail.com>
 <20260924064434.2541959-1-benquike@gmail.com>
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

1. Reject short USB control transfers (ret < 2) in udl_read_edid_block()
   with -EIO so uninitialized or stale bytes from read_buff[1] are not
   copied into the EDID buffer.
2. Call udl_drop_usb(udl) when drm_dev_register() fails in udl_usb_probe()
   so the allocated URB list and DMA buffers are released.

Changes in v3:
- Change (ret != 2) to (ret < 2) in udl_read_edid_block(), as requested
  by Thomas Zimmermann.
- Add Reviewed-by tag from Thomas Zimmermann to both patches.

Changes in v2:
- Split into two separate patches, as requested by Jani Nikula.

Hui Peng (2):
  drm/udl: reject short USB control transfers in udl_read_edid_block()
  drm/udl: clean up USB resources if drm_dev_register() fails

 drivers/gpu/drm/udl/udl_drv.c  | 4 +++-
 drivers/gpu/drm/udl/udl_edid.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

