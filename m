Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99953C43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 21:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B499910E40C;
	Fri, 26 Jun 2026 21:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="c2X0grSN";
	dkim-atps=neutral
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E2110E40C
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 21:45:16 +0000 (UTC)
Received: by mail-qk1-f201.google.com with SMTP id
 af79cd13be357-91931144870so304809185a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782510315; x=1783115115;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Cia7kgRPhjI1x3e7gMKFsSdD516IvT1B7tWFopyj8HA=;
 b=c2X0grSNJieDQ6nkHjk9KNLPa+bUPiFinkGPn2lUT6R4ZbjATgzkVGw6trGlBSP6Xx
 rBmO9lpyp0CnpIPhwjpZSOk7Jy/hsyLzO09J8NGFDLVfA1oLxNc25N/kfVA3k13qY0r2
 SDvMAkqTrCzsx7OAwWVvDkec9rgiwvZ651owzCsPY97BO+Yp6TPgafNVVEE9axEN9kYd
 J4fCFtW8VYkNlqKeb3NJc7oE+XmCk4Irumj+420DVXluCpxJSNfRTU8GDYQ8BEwERUVc
 ziagcgihPHqx8MpgiBQO66xdPiH0kvUcbhpKgp4da+dSduBDZSvDzvSxRI+pobAscZId
 s8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782510315; x=1783115115;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cia7kgRPhjI1x3e7gMKFsSdD516IvT1B7tWFopyj8HA=;
 b=U4YJ33Q2EOH6NbgHTg2anJwI583DyUxpI7a+aHNCvnTLb/V4fls7IAT40FGi4OL/N/
 DgUZZHPSWlr7JxWLi3ISVVtnwenI+3J+rnxnwFDfnwF/g96qsfM0AH+JdqB8JP5bwSSX
 5xumE5gOGLIBwRFFqHTv/q2lfJ6FkYtA6QDgo1eHqSf7s52sOrs5UcrDtYM1XqbfxMI2
 iar9GCXs2pyYQ0gvj3EHOEhBT+wbY/5XbdLyJxV+3ab0MIV3n+x9+2lMnciujQPkDzSY
 K8ndjYt38sUJuzJrPEDu1XHX9LoiwLi6Wma0+z+ZeUULTqIEdynjfRGdgVh2W2zXd89H
 wmAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CQcDGpQ7LS7R3Zolvzu841HEbBQnw0sT1+7XJ0FEIy6C/+eQKcLXpJYVmM+dmFNGlexof2Wo+dbk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtV1SbjJKVroK2OAJS/YqeJjM7Zf7qB8f4DI7IOAsvqtoEC/Ni
 ZCaBKNARw9HQ3cRsKSbfwHG+RZj1EeVxvOp5fm7TTgvFv2zKTyOlDrYVvqk9+sIda04mSgJAG/7
 FFJZx3qLaEYlGmg==
X-Received: from qtbea9.prod.google.com ([2002:a05:622a:5b09:b0:51a:8593:7099])
 (user=gildekel job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f87:0:b0:51a:9a12:9f02 with SMTP id
 d75a77b69052e-51a9a12be9emr9496141cf.36.1782510315081; 
 Fri, 26 Jun 2026 14:45:15 -0700 (PDT)
Date: Fri, 26 Jun 2026 17:44:40 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626214513.179943-1-gildekel@google.com>
Subject: [PATCH v3 0/2] drm/i915/display: Enable HDR over DP MST
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

Link to v1/v2 discussion:
https://lore.kernel.org/r/20260625160020.2873859-1-gildekel@google.com

Changes in v3:
- Stripped Gerrit Change-Id tags from commit messages.
- Added Assisted-by: jetski:gemini-2.5-pro tags.

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
