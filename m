Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3DFF8A146
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC9710E84E;
	Thu, 16 Apr 2026 08:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=metarealtyinc-ca.20251104.gappssmtp.com header.i=@metarealtyinc-ca.20251104.gappssmtp.com header.b="oF/feQem";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7554210E226
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 13:06:30 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8d68f702851so1019755185a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metarealtyinc-ca.20251104.gappssmtp.com; s=20251104; t=1776258389;
 x=1776863189; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0gNoNrQVjNt0zcqpJEvCkIoUDFsKLs4nqY7HiFFeVWk=;
 b=oF/feQemJ4u+l8Ay3iIZ7Fw2GEkZGAH9uELgBZebilKu60LjTqyQfIxF08VS8y/IoX
 j41WNuTvdQddK2SBZfRVTLvPO14BBRvykmgZofoCLsUfioPy/DMvavljfnvp7SyQZF0F
 b5iQ96IgfUaZp4rvtQriD4ChWZG4ievyBCR2ScX6AXNlbZE7tsjkOgYKz3hamDzv5Jzl
 6W2xysaJYbFkktIVFq6QFji7uOofd4Auys05XbDeNWuQhX4OGZUTagjlvEFZjBgA0eab
 dHc1VrR455LxxvmJqk1XCOK1XY4RqbUOJqreCR7GxngT7d4VmrQqVnjFyQu163t17NlC
 w2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776258389; x=1776863189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gNoNrQVjNt0zcqpJEvCkIoUDFsKLs4nqY7HiFFeVWk=;
 b=ay+c81PYH8QineVbTQMKx1Mi+6qq+RP8FhPNRbKRizeMTXLKYDOa4uYyS9VKolc6a5
 YqkDU8vta832vkCpVZI9L/peRVK/dI7w6A6KtUXtQvuGC852UaOgfUoGsVTgbxdfIF0m
 uyMSZD1hcKu/up+owV8JUBxDfBlsksdxeXSLyjurcZBy56UbR394tb7KMskpb9q8Q4Iu
 l80axZsk+vbRq+61MXgTUGWhsUHGTn6gvJLDLH9oCielLLxjDuBvjsAyFEa4Inyh7tnA
 60w8dfy6f3DtW2vuocGHQ3DuAljrHKJRbXokgpzYCG7WUsVhZY8tBklWxab7OmBiTG2o
 xPPg==
X-Gm-Message-State: AOJu0YzETY0guDObb9ypahUEx/wMvMwJhsxNfYO92mA0AVPBjJeBlQDu
 6LZD4ZgMlV3T09tRwRzJIvogOkhG2Yv96/yxstQm2sUK5Q91diPeGRNASpRrikEmpfw=
X-Gm-Gg: AeBDieu9DnEE1IgHI0SibEQ7VT5T2IGR1ZLIHIWMCRczgIpdPkkuYFMPtwZtKyNXL6N
 uVdk3JzQh3A9nQRD2jneoJ2hZYONlppdeYXdhKJJwx+WGD56lMrsxti+FUe1J+DEwaKqU7agzKP
 gzAeS1vwxFXBUxLWi897C3+P4U2yb26VMMb/+9DAdMVy7vVkuGfEN8HwVlknH0nqIWRvoVqkUZ+
 VlVpgYYiYbD3KAiDkOQf0vCS01ken3+0bmA0+9c1oQuhUMr21G1vcAqolmFiRV51CueFpsl6dIO
 rqmU9GIqVtI9gRrp6S/9EftI/qEMq5I4fXF+ERctiF2ewswZK41B6OTAKl2hM37LlnW/vKriqef
 yzjQPtlL5RqKCMoLz81fNFqjUZn+t7UJjWF7fQ/CS14Zy08MnMXin7G0/CwNZIGuE8KfELBTN74
 RBZ4hoS+gwlq16ejotM/doPlCCSraH3TXkzeW3SXCQchyB7+ORRn+pkOi2V8TfzOonDEn+AiEHf
 ZARZhieGnjOptj5T8CWXrg2v5IxmeX7+SqMpAdIC2k=
X-Received: by 2002:a05:620a:4489:b0:8b2:e666:70d with SMTP id
 af79cd13be357-8ddcf7ae416mr3077721685a.43.1776258389235; 
 Wed, 15 Apr 2026 06:06:29 -0700 (PDT)
Received: from jake-laptop ([2607:fea8:e5:500:8e39:827f:e928:9eb7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e4f31f95f9sm125192385a.43.2026.04.15.06.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 06:06:28 -0700 (PDT)
From: Jake S <j@metarealtyinc.ca>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, rodrigo.vivi@intel.com,
 Jake S <j@metarealtyinc.ca>
Subject: [PATCH 0/2] drm: Enable eDP VRR for panels with DisplayID Adaptive
 Sync
Date: Wed, 15 Apr 2026 09:06:24 -0400
Message-ID: <20260415130626.10523-1-j@metarealtyinc.ca>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Apr 2026 08:39:27 +0000
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

Many 2025-2026 laptops (Dell XPS, Framework, etc.) ship with OLED eDP
panels that support VRR 20-120Hz. These panels advertise their VRR
capability through a DisplayID v2.0 Adaptive Sync Data Block (tag 0x2B)
in their EDID. VRR works fine on Windows.

On Linux, VRR is broken due to two issues:

1. The DRM EDID parser (drm_edid.c) only reads monitor range from the
   base EDID Display Range Limits descriptor (tag 0xFD). It does not
   parse the DisplayID Adaptive Sync block. This leaves monitor_range
   zeroed. AMD's driver has a private workaround; the generic DRM
   layer does not.

2. The Intel display driver (intel_vrr.c) gates eDP VRR on a VBT
   (Video BIOS Table) firmware flag. Most OEMs don't set this flag
   because the Windows driver doesn't need it. This blocks VRR even
   when the EDID clearly declares support.

This series fixes both issues:
 - Patch 1 adds generic DisplayID Adaptive Sync parsing to drm_edid.c,
   benefiting all DRM drivers.
 - Patch 2 relaxes the Intel eDP VRR gate to also accept EDID-based
   capability when the VBT flag is absent.

Tested on Dell XPS 2026 (Intel Panther Lake, xe driver, LG Display
OLED 3200x2000). VRR 20-120Hz confirmed via kernel vblank event
tracing -- display dynamically varies between 32Hz (idle) and 120Hz
(active rendering).

Related work: Adriano Vero posted a similar DisplayID range parsing
patch to LKML (2026-03-28) which has not yet been merged.

GitHub: https://github.com/jibsta210/edp-vrr-linux

Jake S (2):
  drm/edid: populate monitor_range from DisplayID Adaptive Sync block
  drm/i915/display: allow eDP VRR when EDID has adaptive sync range

 gpu/drm/drm_edid.c               | 53 ++++++++++++++++++++++++++++++++
 gpu/drm/i915/display/intel_vrr.c |  7 ++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

-- 
2.53.0

