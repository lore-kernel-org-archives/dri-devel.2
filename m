Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192A606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muJRJI/c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C111125F3;
	Thu, 26 Nov 2026 16:53:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE931125E4
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:53:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6D1560CB7;
 Thu, 26 Nov 2026 16:53:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795712009;
 b=xf6gH+sv2vHGsrELHMJoDEU9kaiOGhRhFjcODuWnLz4aQNXCMTmkPecjmlZQTsQnrXgK
 cZvvUwEXphi9H376iKuKZhVEfp5hhGZOMtEa+LF6z0c2kftKhW/3bMJepCosE+fkMJ/Zb
 caY1ifCLMZ2qgatVt8Nu6wnBdSZxG/BHnSK7rCEenMcS0Gib4CYFf9xP2rpNCnGCVS4wF
 vcTH40Ceqolw0UjJs6P3+T517SSZjOOBCnpRjM5eFBjRDU6o1ycVD313WwNaTJomSllqT
 ah5SoBWkuh6a8pCvbh6Dc6p4RVz4pLlu7Nu1pcqnEvrioMIUQjIZhzQhUN7PyOCzzSw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795712009;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=WMaZovrqFePOxFZHi6LrHIJhAI8Su22jubOvzidTT10=;
 b=lM6GFaJNNVUz3pEvJokl4Hm8XxfNcwJNY15UwBzdO9/ULKK0mr1/cGMm7VTf6AuK27FM
 5sOsAkTVR70UBn45WR38sbJol/Z/xFG/3StehWtJ87OaLZppbF2CdyaPws2JW6ZYyFQOw
 qS3qGiFW+MsHHBXqdKa8qxUhBKPc2zZrwOW3CEkLRQ+EtIlDvSD+hrt6xinr2p188aAjX
 8axmolemLYgYi4MJDig261oFA7zHyvoIR6/eA7cL+0D46DoFXZcgGplRFK5f7Rcn399cD
 N3ixi6ggUDgpiyaQZx/djs5xvGP2slNknO7Orqao2rT3TBXCn3xGVi8Cp1Gxk/WDY/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 01BE81F000D3;
 Thu, 26 Nov 2026 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795712009;
 bh=WMaZovrqFePOxFZHi6LrHIJhAI8Su22jubOvzidTT10=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=muJRJI/cbX19ZFrGlYuwcuqOHVHJtiGvThi3DpYOqxr/GOBqBnVZ5MucxNrv6nQPr
 nBRtLFazfQ8fdDHrpQV64Kkomwb470A/kPLBIY2ntPQZol4Q681ypixUUGAzRXOvXm
 5OAO1EaRcDgsDxxhyio9GGHWjaM2oAUZJMzCd4KfAVFD5Gj5jKBVwz0zecQuDYZvvN
 k4oDwoNJcOxkKULWfr6aL3Dsyo/ttLZufWdfcYSKtRQLYOTElXhav2g+AjSXTpWYl8
 JWhGZYrp5Sm70oIAwq41dauzWkpZCdFIOW7fA+ahbFxnGGOFs1Azq8gCTGREQ0ca9R
 NRbp+P8Dcp4cA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 856C44D725;
 Thu, 26 Nov 2026 16:53:19 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Subject: [PATCH 0/3] drm/panic: Speed up QR code encoding
Date: Thu, 26 Nov 2026 17:53:14 +0100
Message-Id: <20261126-perf-drm-panic-qr-v1-0-51856937dc4d@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPpjCGsC/1XMTQrCMBCG4auUWTvYBhPUq4iL/EzsCI1xUqVQe
 ncTXbl8hvneFQoJU4Fzt4LQmws/UsWw68CPNt0IOVSD6pUZBmUwk0QMMmG2iT0+BfXRmROFPh6
 0hrrLQpGXb/Ny/bm83J383ELtw9lC6MQmP7ZT4/4v2TBx8ZhomWHbPoSdYyOnAAAA
X-Change-ID: 20261126-perf-drm-panic-qr-58b69ed0f455
To: Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795711998; l=1688;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=iDsLMb9aE0AlmFCf+gA2dXKbpkU/dhpl3hq2AY5ctqI=;
 b=40xnObcbPohCg/rGboSbRgdZHBAKadpaSbTlyOBgw/YCPJSPXbZ6WunLCvCJWFT1bbaIPdlLl
 qv8dqwinY1KCL/FRNXVcX6qTtgl81Iyvns5c79/Zzh/SAemijqXyg3N
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
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
Reply-To: peder.bergan@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DRM panic helper encodes kernel log data into a QR code. Speed up
encoding by searching alignment centers per axis, applying fixed mask 0
during data placement, and simplifying exponent reduction in
Reed-Solomon error correction.

I benchmarked the extracted encoder with Rust 1.100.0 on an x86-64
Ryzen 7 9800X3D. Across 12 paired warm runs per workload, median
version-40 encoding time fell from 1.778 ms to 0.277 ms with a
2,900-byte raw payload and from 1.782 ms to 0.284 ms with a URL and
a 2,800-byte payload encoded in numeric mode. Both workloads produced
identical QR images. The timings cover encoding only. Log collection,
compression and framebuffer drawing were outside the benchmark.

In the differential checks, each patch preserved the returned width
and all output bytes across 6,002 raw and URL test inputs. The mask
traversal check covered all 40 QR versions, including the remainder
modules.

I also ran the drm_panic_helper KUnit suite in x86-64 QEMU/KVM with
the QR URL empty and with a URL configured. Both runs passed all 45
checks, including 15 QR cases.

---
OpenAI Codex assisted with coding and testing.

---
Peder Bergan (3):
      drm/panic: Check QR alignment centers one axis at a time
      drm/panic: Apply the QR mask while drawing data modules
      drm/panic: Simplify QR error correction exponent reduction

 drivers/gpu/drm/drm_panic_helper_qr.rs | 59 +++++++++++++---------------------
 1 file changed, 23 insertions(+), 36 deletions(-)
---
base-commit: 5ce32a0c94a827ff44ee60898c28060714dcff75
change-id: 20261126-perf-drm-panic-qr-58b69ed0f455

Best regards,
--  
Peder Bergan <peder.bergan@gmail.com>


