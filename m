Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99A9C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C074110EB41;
	Mon, 13 Jul 2026 22:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kRYOFmK/";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A584810E655
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 18:38:55 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493e8d4f4dcso27722325e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783967934; x=1784572734; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6DtghhdTtGAGyMOfw++Q+YSFv47tiRopnFCf1YJmgL0=;
 b=kRYOFmK/w00DA/N22XKG3BrjyFHIENc1RMKApJGXCTADdtzPiiS1iWaOSNV1ICX1no
 9G9dbJTnR3/ToubA3WPXIuzP5+XkGN+Q0pGESE3Ioa/4HyE4ANF6NhcUcXQt01m5KZTg
 Tpw4aFb4bYp1QwDCwguVpYsvGIY8FtYgo24y+8TPn725WsJwipHcjVRdF9YeNGFRxxD6
 Jt5C94XiJ2PMcqI07OPV0/ChcScfrKMXCjxEqESkB9gaboIguYJq4Aw1+pE/y83tj2LZ
 Mci8a+xos2rJlRiI2P9ONtMjcyk5A5VhDswkZudqKBd2qgutnhZOqIcAR8eNsjp3xzYY
 8tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783967934; x=1784572734;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6DtghhdTtGAGyMOfw++Q+YSFv47tiRopnFCf1YJmgL0=;
 b=jgMphViUqdORZUvvfUkNrCAB/PRpoB+67jpuQIvG8TbvkHzgTvlz9voKZf9BWbW9p/
 QDFz3tccrn9Gk3ExPyEksU9CN3FQfMC7oyfMLs8yoHCUgncldF0ONRyxKiXxtJWFvJKk
 CpfrOJljzajSK+bOYVhXvTHBqm/4cxTWQ7r4oAm/Z2vIO2e7x9YgQZFp38FUgMXIyS+c
 eXqaaZ4qVZAaal17HcIUkFWfR3HvWYIKnXSSHRUyDzCdSqbj6jobEsbwJef5HFI7HtyG
 aG1AjiSvvY0AOGB1pI9li7/J0smZ5YrIIMQrcHIOsgp8ozKaW5ofPEsh9iDv7/9s6ifd
 vELQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqedC++9j/ixoCyBXvk6ujUSBzJcKkApEy2I3IOz8Nk+031P7SAx8rPwb/1tRuS3bFq0kKGHfqA/zc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytmSeh8mqsCjePPUpAdp5Zkl58YwZ2cP7aMFVLn+ALQOL2NHkt
 lZKeqmn/8MEekwWDZFWc36Z+vIznwjOfai3jfnmNZCwRi/Wme4eM/s8l
X-Gm-Gg: AfdE7cnaOXkLZL8ZKMfck66O1GBvOcvmAGp3oYVFNye5QUaokNdwjwsvjxTT4Ia9NX3
 uIusMkw0WgFNYT95EzjEJLbjAmLpiSRzULT1nXn8L9TCleJB5U8FEQOXdeFBbzwuFApOxsAon/0
 HAup+8OqJ19vhmaMipzmZ+aE6r2HWuZjwQaWMm5k8QNDicRXHk/uC3HFb5u7C6DDKVQQ+zX8vSL
 aukDcLKJuGNz/14ZUO+pXbXyC1qWP33XD8Kh0hnBY8bIkkP6yPyUE6bnlSu9u+8qXwL/7IX5jue
 MpC0nMexlocVhz2zNDrvAbcgjDU6TuBsoLhmPrbyjArZZGYQaftVNMuYEE8prQ2nQVHpsVQ5Ibm
 scvjViI64YJY8UTvcsi74Zh0rlukB0J7SrmOMFYUi1XpNZf7WvoTLWvLLJnfo3I0khMPx2+MEnz
 11kOg5w5zw5wGs/VCUuT1xNaEOOUI/anFfZzFzz30=
X-Received: by 2002:a05:600c:3b0a:b0:493:f6f7:299e with SMTP id
 5b1f17b1804b1-493f88241d7mr105526565e9.20.1783967933785; 
 Mon, 13 Jul 2026 11:38:53 -0700 (PDT)
Received: from timo-z13.fritz.box ([193.30.163.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm14702455e9.4.2026.07.13.11.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:38:53 -0700 (PDT)
From: =?UTF-8?q?Timo=20Pr=C3=B6mer?= <timo.proemer04@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Timo=20Pr=C3=B6mer?= <timo.proemer04@gmail.com>
Subject: [PATCH 0/2] drm/amd/display: Fix missing HF-EEODB blocks in EDID
 copies
Date: Mon, 13 Jul 2026 20:38:39 +0200
Message-ID: <20260713183841.5921-1-timo.proemer04@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

Fix an issue in amd/display where devices with HF-EEODB blocks would 
be missing these additional blocks during EDID reads.

The driver previously used `edid->extensions + 1` to calculate the 
number of blocks to copy, but the base extension flag does not include 
HF-EEODB blocks.

Use drm_edid_block_count() directly to get the true number of blocks, 
ensuring that HF-EEODB blocks are properly copied.

Timo Prömer (2):
  drm/edid: Export drm_edid_block_count()
  drm/amd/display: Use drm_edid_block_count() instead of raw extensions

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 5 ++++-
 drivers/gpu/drm/drm_edid.c                                | 3 ++-
 include/drm/drm_edid.h                                    | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.55.0

