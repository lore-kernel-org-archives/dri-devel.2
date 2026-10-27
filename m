Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC3606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cJI6xLvn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5863510E4A2;
	Tue, 27 Oct 2026 21:17:47 +0000 (UTC)
Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com
 [209.85.161.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B739910E4A2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 21:17:40 +0000 (UTC)
Received: by mail-oo1-f100.google.com with SMTP id
 006d021491bc7-70b875f6f13so291303eaf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793135860; x=1793740660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n/iR/WFNJ2rwkGCOY35ZbLqawiVfCOCBpcdvgZAlRIo=;
 b=b1z3qA/nFa8F4I8wv4h2Wqhfrl04R9VURjebr/5WNrJ8a9OmvGmCRztdu76hFxc5HL
 ntHjwBAW2MXoV7BdY0tn6blGVsoi7vxY8aM1i+B9cwF3d+BRVbfrHch5rGtppxbk9HbB
 6tZP7nCI5XpsEQpPDEQq3pJIOOLoaRxTZaslSFcfFnORPrTr3gk587AOtNp5lFI2oe/q
 3wrjk54yxh/e7gp3lBHFM4eSq1dU43Oj1YbuskhH0BorZKy5yIdy/ArYK4iGvGaONmVn
 NV3zXlyT2B3kYa6rGbpRdsZdGlAaj80SDsGin8Q+5IS7hVO42xYjlNcC9+TvPLq5st7F
 KC8A==
X-Gm-Message-State: AFq9FYIm0RfXNKEqzBlFxJxxPuUMP6JxIdmeiQRP2WTjWJMab4aTZE1u
 XB8o+4d9WwHG90LyEZ3arpFJup2xEoNyzKS+L9Gwb1cM1FFPV/S0ox7sOZOu0fMp0gq05xQMwbd
 XCoYZlQyIKVaXzD8yb7WiGrn0PVOdfCmlMGNHCtyNolHw/TO6PCbv/RPxqYN6tBQgB4+RiETH3j
 UNrgbFQZDtNBO4sJvtrJaR5YzxmKq8OP/QRj7Gdthp/TzR+/KxiIjgbMorWfy+Tfrd04M08Pn86
 d1UZHiF7rqbioS1uScr
X-Gm-Gg: AYBFou0dB4KQyCCTjRYz5lFUGjcPQSFy1ui9r6hRjvGJghWGbun4k/VnxEWRz++C/lz
 O1MfkdUIlJFiOVl0M9osc8T21kMMaLOYa24OeLrgwbvP/T6+LdOxsxlUnIWBTY/s5mJ9fxOOixT
 JzrOu7fvb4l2tNkIyU/eVk8Dz/WpvvOJ1Yn6df8bQh723EQHicOwHPhYNuxJ+P8DutZ7dFXknx4
 dK0bhZg6yDzQgbp+rqFMJYUJr4xjI19tNaOzbig2qJ3h0bW/WpCzVxcbDdHO5dFEYuQSOaMN56O
 hc2qbs5Bl9czKHC8+QN1esIYPAhberuZ/tGwDVon7eVGPeCKenR1gjxMkAnlDqjpi7KstCPjqvp
 j7Eu08uwxVY37olbpi9DhQbgm+5GqQvzNgDh7Qc4jL8UKSjbdbibnVXOaPlKD1w4lvC8hy09vYY
 f8/vp6Y/0vUPeH/vdP6m0PFF5ku9v5M1Fp
X-Received: by 2002:a05:6820:351c:10b0:708:ec28:6fd1 with SMTP id
 006d021491bc7-713f213ef01mr142282eaf.66.1793135859707; 
 Tue, 27 Oct 2026 14:17:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-4a8b7869b87sm11559fac.22.2026.10.27.14.17.38
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2026 14:17:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso342714eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793135858; x=1793740658;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n/iR/WFNJ2rwkGCOY35ZbLqawiVfCOCBpcdvgZAlRIo=;
 b=cJI6xLvnA8Br2F6Fdk1DkGe3TxdlwA+ZNYKjP8QfJaVOj/JPoNCoQ6ykT3JnGTQBbV
 YO8oHf3R5q9y23QDEr1msHf+M8DSRPEsEt+TPuxNVrTK9TivWB88ScmMJ4bPquGoedLY
 blzDlLlbj+Z1gR02Hi6m0A7P26xPhCRsAwEu8=
X-Received: by 2002:a05:7022:b0c6:b0:144:fb87:5b91 with SMTP id
 a92af1059eb24-1a6d05a0768mr517482c88.44.1793135857690; 
 Tue, 27 Oct 2026 14:17:37 -0700 (PDT)
X-Received: by 2002:a05:7022:b0c6:b0:144:fb87:5b91 with SMTP id
 a92af1059eb24-1a6d05a0768mr517443c88.44.1793135856830; 
 Tue, 27 Oct 2026 14:17:36 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 14:17:36 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 maaz.mombasawala@broadcom.com, yunfeng.li.nb@gmail.com, tomas@slax.org,
 Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH 0/6] drm/vmwgfx: fix cursor validation and buffer lifetimes
Date: Tue, 27 Oct 2026 17:17:23 -0400
Message-ID: <20261027211729.646988-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes cursor validation and buffer lifetime handling in
vmwgfx, including guest-backed devices without cursor MOB support.

Each prepared plane state keeps its own mapping, reference and pin, so
cleanup of an older commit cannot release resources needed by a newer
one. Cursor MOB teardown and dumb-buffer surface detachment also hold the
buffer reservations required by TTM.

Validation uses the newly selected framebuffer and rejects zero-sized
images and surfaces without backing storage. GB-only cursors use the
define-cursor command limits, including the 32 KiB whole-command guarantee
when using command buffers. Legacy cursor-bypass hotspots are included
consistently in the image and position, fixing displaced Xorg cursors.

Thanks to Yunfeng Li and Tomas M for reporting and diagnosing the GB-only
cursor issues, and to Tomas for the hotspot fix.

LLM assistance was used for the fixes, tests and commit descriptions;
the patches carry Assisted-by: LLM.

Tomas M (1):
  drm/vmwgfx: include legacy hotspots in GB-only cursor images

Zack Rusin (5):
  drm/vmwgfx: keep cursor mappings and pins with each plane state
  drm/vmwgfx: validate GB-only cursor command limits
  drm/vmwgfx: reserve dumb buffers while detaching their surfaces
  drm/vmwgfx: validate the framebuffer selected for cursor updates
  drm/vmwgfx: reserve cursor MOBs before unpinning them

 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c           |   3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 166 +++++++++++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h |   4 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          |   1 +
 4 files changed, 125 insertions(+), 49 deletions(-)


base-commit: 8ef66514d7b993c9fb96a5886f001e3556610c1c
-- 
2.53.0

