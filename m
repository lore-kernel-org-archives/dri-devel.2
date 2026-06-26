Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15F8C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 17:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E904210F6DA;
	Fri, 26 Jun 2026 17:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rsKfqsh4";
	dkim-atps=neutral
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1273210F6DA
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 17:55:15 +0000 (UTC)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8e05aa49693so33978556d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782496514; x=1783101314;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mM3PnInI6kX1xpwl2VR4RCLVCiH8w3J7RjvmONcxlFw=;
 b=rsKfqsh4yFESoahwnymZHu4xmqpRl8aUMd888FjtwSRGsi2DVN+Q+yrTfxm1vkpoib
 avz32Da4EFS3YjnWLmSgsPoAPUjeBFEByMDiHVPUjlmCT6qCzI3O2BRQwWvNokn7bmfE
 PsTEzdWHHxsbolWDBIg8KaUisvpWd2IqKQ9V2DkEURzXNNo0mVYs/VerOP6YWpuJ4M2/
 MMiFP6YVfdJrJ2MmWvQJ6A+pepG3UmNPMQXmuuJnzK4H2zFgCMG61+6EoP/MgsL8542E
 TzD/O1Rs2m8MD2UINUDNbWkxYAfddHiK3QL0yMt8QxxkoSe5UYmXLS5MruR5OxzlCwzS
 M5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782496514; x=1783101314;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mM3PnInI6kX1xpwl2VR4RCLVCiH8w3J7RjvmONcxlFw=;
 b=f755tIfGAyIJ0b8spThsB2yxF5zbC9gmYnXB36T1c2z6nM7iFYlUBcsw6xTRwO2BQ2
 F8tuQ0P6CXhvoOUBPvwf8dcX9K79p0sYLw6oTZyd7j4sz9HqJJSPNcsJ+Cia37TNE9uS
 tIsByvC+NQGa2c475IMnBtlL/a7LqMC7aZI4AlcAoenOdQqtNZm0bjeUtgQB4ZaZJqlF
 cY/STRBtevcZfLL07dtbanyASia3BYsfEiBydqStOAGpAbdsALO9C8jjvz0hCAqYSe3x
 3LweO+5JHqLfLnq6JuhMA7jk+lFrPyxNTSaMy8Lunq1PZ/jdTVoTTWp2ZvG08LMNL0oF
 RJew==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EwH4V1Bpso0c1sEO5WLS7qDz5kijVwiv8XQA99JzxEejJjxXAdzsYaW9EUy37KlNlwu3+jsx2Kvw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywe50+yz6H2e2a4b7r7Zcp5sxNE8xF3zSXQJbuBzH7vk692yhPq
 F5z0tII/P59LgdmWLLXGQ1H+ZHw78Pv9vuX2Udy82aSLdwYdq62O4YmM0ZllETpoFji479h16Pa
 Y0bY2IH+lXPff0A==
X-Received: from qthg1.prod.google.com ([2002:ac8:701:0:b0:517:6e82:6e87])
 (user=gildekel job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5851:0:b0:517:82af:3d4f with SMTP id
 d75a77b69052e-51a7275af9dmr109755031cf.6.1782496513323; 
 Fri, 26 Jun 2026 10:55:13 -0700 (PDT)
Date: Fri, 26 Jun 2026 13:54:21 -0400
In-Reply-To: <20260625160020.2873859-1-gildekel@google.com>
Mime-Version: 1.0
References: <20260625160020.2873859-1-gildekel@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626175510.3899476-1-gildekel@google.com>
Subject: [PATCH v2 0/2] drm/i915/display: Enable HDR over DP MST
From: Gil Dekel <gildekel@google.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: uma.shankar@intel.com, jani.nikula@intel.com, imre.deak@intel.com, 
 khaled.almahallawy@intel.com, navaremanasi@google.com, 
 Gil Dekel <gildekel@google.com>
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

Changes in v2:
- Fixed critical Werror CI build break (-Wunused-but-set-variable) by
  removing unused display variable in intel_dp_compute_vsc_sdp().
- Resolved checkpatch warnings by hoisting variable declarations and
  restoring missing blank lines.
- Gated attaching MST HDR_OUTPUT_METADATA property on
  intel_dp_has_gamut_metadata_dip() for consistency with SST.
- Removed redundant direct max_bpc assignment on connector struct.

Gil Dekel (2):
  drm/i915/display: Cache DP colorimetry support per-connector
  drm/i915/display/mst: Enable HDR over DP MST

 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c       | 25 ++++++++---
 drivers/gpu/drm/i915/display/intel_dp.h       |  8 ++++
 drivers/gpu/drm/i915/display/intel_dp_mst.c   | 44 +++++++++++++++++--
 4 files changed, 68 insertions(+), 10 deletions(-)

-- 
Gil Dekel, Software Engineer, Google / ChromeOS Display and Graphics

