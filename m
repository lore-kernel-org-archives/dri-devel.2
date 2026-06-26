Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9427CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B1E10F46B;
	Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="nhr6fhie";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB39910F3F4
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:51:22 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30c6874d295so307432eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782442282; x=1783047082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K4ytSY1eyQvTl6UG4nVit076xPC5OGBl0m+lhuK6BuQ=;
 b=nhr6fhietvhcSYsLK4ph3IHlYKBaFafGE1lPgqZT9Mucaj4odkkckS2uTP7lqROW59
 qOzPSl78xrT8ckGs4knkukcAGac2pAxnEVjoIsaHDwz8HFb+EchAmriJFENVws4prNoo
 9H1WVuFpMUaxmBhHvHMbeiNu9I0pVAQSsPjSux56PHsYMlJvvv4A/XyOrpfZ2NrBNrQz
 UorKXSqpnVhZ10KH/z738yQ2TdIfaFWApizsDTGEQlUCvJBHcf0Oka5x0e+XVFfWLT4l
 xjwTVqVMwWCVQ1p9LvJl5eSeN91qh/XitQxOz6hPh6CCy0oXieBsooQ2nwrxDqFEz4U6
 BmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782442282; x=1783047082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4ytSY1eyQvTl6UG4nVit076xPC5OGBl0m+lhuK6BuQ=;
 b=NFLPUJOrWrR3+WOsZVT+bWBucMDlRGf91W35ahzUooswvgkrg7vP7wnFgfVqkePHkl
 qfoByOFyiVwyMQGwzkJCOJCuuO+oh5/laV7xdh6YWjpE/wFUqnrF+0boG1XelULz8gMs
 bWlGjvJWMGD+CifNQ9RNteoDo1l4Cpv7LLQ78mM5kKUZ2H5Tc4bs1rvvh6Gl6ard1MnU
 IbAxhKqW17tGZgZf9nAFPDa6Rvr6nFmSMzLyc5Df3srX8Knv9AQYJqr50dJVmxKqBL+d
 kbhx4k+qQIFr+igVZiAW26hoHo4+IprcRQ4KWxNyMx2aOCIVng0yCo4xHzFxWgk0r+I3
 9tZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwUjun8Bhq1avjjOBbxzD+6kuOf445zQwmj0kwSCa3jKFX9Jn3HLjvP4Z8GSPBge/rchP2rxwXovw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvXzQ0xHhEbyMcOTnmk2fxBhHbm/4PwEF4Dyh7KmmmS/fb24lh
 gTg9KgeFexuF/EbwY593UzoiptQnhuGo85KN7MOC0NRuljcZCgLdvb7F3NfSj8F4XkY=
X-Gm-Gg: AfdE7cn6LIqfKRrxMb6w1mGZbAKTMy5IAJIuyQQF2p1DjHG2ux1I+uCtNHdVoZxo0Wv
 5OmcX9FdwpNHa9nruL0i+QOVATMKDxxfh67u5QtZ7CanHWlUAX3T7Yp+JXkxS5o/pslDIK7+ucj
 /kWrYtl22yRbPO4QzRV/o+CdB1uKVjJZXKDsCxxDaDiZFwAio/DlfdBiLi4arcmDW43Anb1QGmE
 NX4HObXg5b0ErGCbGMS4t53q/7i60RzrzG0SX1EWzvhWdqte3X1FtpFf8KuGRHPRyb4GZuXi7Fh
 PVcPxC7QS/Xom8OLGI6oWxN4sicM+MfzEpR+qXd2e9rnVqrkcx572lmFWJbzNN6zOtax31ogujx
 g4+rndr3AuSjj6ESHRtHvy2PoOppr+VuGrhGAt9rTAMpeJ77m0WE5bru44Crl1errTtmrswOUp7
 dcqyv5pOVWHbREI6txnJR5Zm5g1FrDo1wRkxzRNHQoS5dic3iy/svcVJmTFxd49G4dWVKb4Q==
X-Received: by 2002:a05:7300:d407:b0:304:e587:50b8 with SMTP id
 5a478bee46e88-30c55641f4dmr8168585eec.18.1782442281681; 
 Thu, 25 Jun 2026 19:51:21 -0700 (PDT)
Received: from voyager.. ([179.119.40.186]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7ca438ddsm12905797eec.23.2026.06.25.19.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 19:51:21 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: amd-gfx@lists.freedesktop.org, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, simona@ffwll.ch
Cc: luiz.f.f.fernandes@usp.br, Tiago Dourado <tiagodourado@usp.br>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] drm/amdgpu/jpeg: deduplicate process_interrupt across
 JPEG versions
Date: Thu, 25 Jun 2026 23:47:22 -0300
Message-ID: <20260626024948.19131-1-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

The JPEG versions v3_0 and v5_3_0 have process_interrupt implementations identical to their predecessor versions (v2_0, v5_0_0 respectively). This patchset removes these duplicates by exporting the original functions and reusing them.

v2:
- Replaced macro aliases with direct function pointer assignments in the irq_funcs structs, as requested by Alex Deucher.

Tiago Dourado (2):
  drm/amdgpu/jpeg: deduplicate jpeg_v3_0 process_interrupt
  drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0 process_interrupt

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 21 +--------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 22 ++--------------------
 6 files changed, 13 insertions(+), 42 deletions(-)

-- 
2.43.0

