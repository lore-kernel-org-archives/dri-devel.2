Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08247CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA8810F59A;
	Tue, 13 Oct 2026 07:53:53 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB45310E5B8
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 19:03:22 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-33c2520ad38so5026085eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791831802; x=1792436602; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2NkKyRW0wfIM67u0LXIiGPjl/Rwt9skgi7xkmQC6+0Q=;
 b=AoSOOievz/Nhxwudnkpi1225dq9NKDTnHhjGdngfN3NupHuUf+k4UBOnoEkXJYFUUe
 1mD8jTdh+mKD6Zwo98/oxEqVt0XIX7ZeXDx9EOrrGbWTRAxf91qdQ9t4b6kHHkyDnSAN
 ISTFCiAIjJfQR0pSRfszU3YtEDVdMj72cSTKcCcltF4j98lTamgILYdJFDA1QcqZMX0N
 GzJIN1Z29VbzAAsVFN/TzquK6x6nSRoPQihUunxFxafaGrictRwJrlaqAYRj55i1/Iy+
 1hkCKMa3qBIVyNf9htdl7S47mEbc0bf7qBW4sQE/I+h9Tps/c/ipBPK40640scXFRBUk
 oghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791831802; x=1792436602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2NkKyRW0wfIM67u0LXIiGPjl/Rwt9skgi7xkmQC6+0Q=;
 b=dOWHTb2Yu9MZXI8OFeEBueWAh+1vAVClbVYSpM9sbkJmYda8AY2urCuY7aXMZYw98p
 UBC66rjf9Hs6ieq0fPMtNp+XqlmXgmz+xWYj3AnaAVuj/0o/zN9KofR0GZfhnIp60w06
 z8MvLrpVVhaOyqN11jdPJ++iWkPD5Iv2A88IIx6/c/1iyrSbDZDjY+VRpmjtRfIuNtb7
 Llv3QCslk1eP/iJ+/hdkR4Be7WbohE+cAn1aloolNVnBgdE7Ujin/crxiC02QF3UYY+J
 sqxWIm4CVPKZufrjOnrHDLJVjPMrLpODRB1YEWVvzTzTtePreKbiomzrIKonB15nMEC0
 BkyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBydHHPnFJCXeLaBNRdIFGmOOC8bAtDNlXnMzB9/Ll7daao48H6kKHLK32NX7nnvKz2U/5by0Y2zEjU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJFsny1YpTZ+MzJgdtd0/rZ+8FUDxVbTkjyfNvOIPCKk28hSqle
 sAaQO7PGGPyKKKFOsFQh1mpY1+A2k+COU6t4OTdmldxOOXaQhe5Fr1EY
X-Gm-Gg: AYBFou3PR8hvUM9h4VUSEdJy0xbHdhtq7/zik+5PsMgoJTaAjmkBciCQLaHAywnX11N
 /E+ItJ9PXJPIKzYCnaw3dfwaZGdPkJmcIC8YubYj6WnusVo+SRAcEAEkb/mZ4qk8IJYjUJVDxn8
 6z2EAQqD85bDQLXjQDuOUW4Or2K/7PaYOm9Wcckz1Aa5Up31OFgPktWLMbkRRgbwpP7xOuEuuVy
 RM1DLFeVf4yUuEXXrDq6liotj12Uj4pseJTkNW+bFnrtPUMW0VajSiUE6ciAaN95OAV5J7R4gIr
 yanp3yv1R5QSBAwfmy879DYZ2BfrWdV+4CRiF7a4S9QDy1ylEEOb4Ds7b2XxTGXhyBMUOLZpqtq
 qq/R8FGTaT6KtdPJ/XBIv9in/7QisZeBcxvcnYc5PoZLA5gGmNHqRn1CSt/SwAD7HZN7ok6iZN1
 oBwFA5AZ4bHs8vNkqHV8GI1n9T1cXDvCKUXuMeSTOufRuX8cVtsthnQ9tkwHqFmDSoy5FfEyEWJ
 ZMbADheMl6lKcdznQfizAjmMuYB7TrjEtc6POY=
X-Received: by 2002:a05:7300:f582:b0:353:5ae1:b0f5 with SMTP id
 5a478bee46e88-3537e101bf0mr14461668eec.26.1791831801912; 
 Mon, 12 Oct 2026 12:03:21 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb6a279sm35501602eec.30.2026.10.12.12.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:03:21 -0700 (PDT)
From: Henry Zhang <henryzhang62@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Henry Zhang <henryzhang62@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/vc4: dsi: Make failed reads visible and recoverable
Date: Mon, 12 Oct 2026 12:02:41 -0700
Message-ID: <20261012190249.3167-1-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

DSI reads on the Raspberry Pi 4 (vc4, DSI1) can fail in two ways that
the caller cannot handle:

- A peripheral that detected an error answers a read with an
  Acknowledge and Error Report. vc4 copies its two bytes into the
  caller's buffer and returns success, so the error bits look like
  register contents (patch 1).

- After a read whose bus turnaround times out, every following DSI
  transfer times out as well, until the display is switched off and on
  (patch 2).

These patches do not prevent the timeouts. With video running, vc4
does not keep commands within vertical blanking, so a read can still
collide with active video and time out. That is a separate issue; this
series makes such failures visible to the caller and recoverable
without a modeset.

Tested on a Raspberry Pi 4 with a 2-lane video mode panel at 120 Hz,
using a backport of this series to the Raspberry Pi 6.18 kernel and a
panel driver that retries failed reads up to 8 times: 499 of 500 reads
with video running and 1000 of 1000 with video stopped returned the
expected data, with no lock-up. Without the series, the first timeout
left DSI unusable.

Compile-tested on drm-misc-next (arm64 defconfig, DRM_VC4=m, W=1), each
patch on its own.

Henry Zhang (2):
  drm/vc4: dsi: Don't return error reports as read data
  drm/vc4: dsi: Recover from a timed-out transfer

 drivers/gpu/drm/vc4/vc4_dsi.c | 114 ++++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 5 deletions(-)


base-commit: 3e32932d3626d0279f9b3531bd648f8c0a16cb08
-- 
2.47.3

