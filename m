Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEE0CDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24DA510F314;
	Thu, 25 Jun 2026 16:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="nPgGaDjQ";
	dkim-atps=neutral
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D675810E21D
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 16:11:19 +0000 (UTC)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8dd3fe99e80so64996d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782403879; x=1783008679;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fN6nJqx26VtLTAWd5mMITPKoI2aS3irfqPoBFs2k1TE=;
 b=nPgGaDjQEEzQ2OqobMCqC9WGZbcavauEWyRUPrmM8sY/uzvbf1jmbuj1R+Ntd8UMOY
 w4M0JBOUDgspAO27h4vp9Uq1aOChqzxpAjbsh6pc401KwbEYOed4F9SG2Jdbk4ibTNaC
 +nOzyIfBjXZzg5Cs3RqOKg05ZOdI5utmplw7+6xs95bRWS/XvWFeLNJ1MsXkaGv5XOFP
 i2YY9qnT7gWNgjK58uuT8ZSZbZpDm7p4uCPFyh3FCjVhagdCcoaCxWDoE2byUO3Ve6eB
 dqP46cKjNKzuTlq3Yl2Cem6MRMjrPIdHtt9El8ptwjyKNHrmHboXUGloNH0uBukstm+I
 I9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403879; x=1783008679;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fN6nJqx26VtLTAWd5mMITPKoI2aS3irfqPoBFs2k1TE=;
 b=URJf2ll11FaWK3VA3+kmP3OwHNTThLGzPR4dIe48lRm8CysiZZlLSq3R5YdS/E77Hq
 GnalGm4GIDuAqPhI9tLmu8k5gV4LFf7rRPpdi/Kv/xpW4YDXVnIWH/FIRzm0CzngClm6
 wgZgOcsBifArGz+erEhQ2plBoXK4HZiNArSGGgctQQyXgSgG2wIngXXKL7elx+P4ycoB
 U/21Vqzc0zyCIJb9JDvkMrT7XZWWub9u27zexhi1V/v4Nyb+JQRQC2enV1uddtCDBB89
 qKAvtOlVMGix2uAWsbLviC4qWsbzrn7FixIMocapvWZcGODFGc8stnhdmuy4D4t2uO/F
 QCKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZiBoxu4OPLkQ3fqTar36lialnZloG8Mr9i3+1z4JxeiB7X3g/VwLZKwbYBRTDFu9Nkp9OvRKtzR8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGA/TbpLkRN1K+cB31p05NP53NgFlzv1uezRnsJlw5+tS5dmnT
 bXxfV7vzc4s5yXrJ/215YkeXKuv5HZ+EBQkOmMWTfziTPBFmAWzgZrjGvxHOs0gOEFcX3jr3xHb
 R5fMRmBF9829qpw==
X-Received: from qvoh2.prod.google.com ([2002:a0c:f8c2:0:b0:8a2:cf66:d55a])
 (user=gildekel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:f2d:b0:8de:1d32:bb5d with SMTP id
 6a1803df08f44-8e6d5e9e66cmr49004816d6.3.1782403877055; 
 Thu, 25 Jun 2026 09:11:17 -0700 (PDT)
Date: Thu, 25 Jun 2026 12:10:25 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625161104.2893517-1-gildekel@google.com>
Subject: [PATCH 0/2] drm/i915/display: Enable HDR over DP MST
From: Gil Dekel <gildekel@google.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, imre.deak@intel.com, khaled.almahallawy@intel.com, 
 navaremanasi@google.com, Gil Dekel <gildekel@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Currently, the Intel display driver does not support HDR over DP MST
connections. This series enables this functionality.

To achieve this:
1. We refactor colorimetry capability queries to query and cache the value
   on a per-connector basis (for both SST and MST downstream sinks)
   instead of checking the root port's DPCD register directly (which returns
   false for MST hubs).
2. We update the MST stream configuration to compute the required VSC and
   HDR metadata SDPs.
3. We set the transcoder's Video DIP registers on stream enable and during
   fastsets (update_pipe) to propagate HDR metadata changes without forcing
   a full modeset.
4. We expose the max_bpc, HDR metadata, and DP Colorspace properties on
   MST connectors.

Gil Dekel (2):
  drm/i915/display: Cache DP colorimetry support per-connector
  drm/i915/display/mst: Enable HDR over DP MST

 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c       | 27 +++++++----
 drivers/gpu/drm/i915/display/intel_dp.h       |  8 ++++
 drivers/gpu/drm/i915/display/intel_dp_mst.c   | 47 +++++++++++++++++--
 4 files changed, 71 insertions(+), 12 deletions(-)

-- 
Gil Dekel, Software Engineer, Google / ChromeOS Display and Graphics

