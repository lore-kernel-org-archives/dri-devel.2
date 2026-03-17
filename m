Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FDDFCD0DC
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCCD10E74D;
	Wed, 18 Mar 2026 08:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BEub/dV/";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 050A210E22C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 19:00:02 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-35b95a7444bso1948910a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773774001; x=1774378801; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1PcwMDnihsdnmKVOsfDRGKcGqZ39RTcsdWpVCxqwOIE=;
 b=BEub/dV/KEDCBqElcqY1iOT7telyykWiEskpih60A78hpRcaKAqkonDjbp/FfPnERU
 gNYFRqkTRb1BDz/wT34t5XhAVEtl6++7fhPl/vHLfgoRMHO7PaGU2HzgLV2XQhAvbW4V
 8c8dans6hLrK3tc/EwzY9lnFh256+3lLrGkrHghZuN4C5TRMIdk6Nm7T+EElgKi0S4nG
 jezs/OQJkE+O67njcjY0hKarERgDn0etL8nP6XNwVFvHLzzNGZJTXKewOnDleC0A7/LG
 o/RFdvhhLaFa4aN+Is2sE4mipG1QmjQwy5ABn4+jveIWUfyq44q62OPjphwAltHAaP5u
 KOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774001; x=1774378801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PcwMDnihsdnmKVOsfDRGKcGqZ39RTcsdWpVCxqwOIE=;
 b=NEBeuJnorIPlGX/LFCNDkiR5AXGkVfJn95f8jqRVw/w9VE9yAqXBnbgjZVeh1SkDlo
 CeKc8dW0/lpxvjxTkxk0W2QfnMbw2e6aA84wpcPJjlAR6EbakHJhsEUPLO5Ivvr4rTSF
 /l2hirxokir2L9jQH/VzSfoitfnCZ8+NWVCqdRAzHHUKVhdze9aKpwtRi36Ret7aytAl
 Y1aNHaXkh6MXVTnccOQuxLBIEwZhnEUnCRJBx/ehdxMZ3rdK0ao6B9zx3trb9XrRcEIm
 AAdMxA2ZHt4dQSiu9A/VKK/ej9E6gI73OiPOJunkodijyc0o/uI/3FBfh6yai77FXxzs
 dacA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxkcGXRvOlMKRvbguMgGW6Ah47KDzIoaNKfrIhn4waPEt+RzzYeaQFOtgizsBjITbYsGoPFYTgheg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCX1uDmmBgWVKM61L7hiKJYrNBRCyoRCvFSCcQlzvPobClgBzW
 6vVwb34lg036vtHT5vYOiSl5MRGxqXl7O0WGz3UxbqN54N4d7Rd5eeic
X-Gm-Gg: ATEYQzyyDLLajfJonFufP2FNRQnDENFKjjKQrljIYWtJwhC8SdQwmtgsJ0ZOClwHZlO
 0MDMoks3JPwstPbI1ormeC1Xcq/jadqY1gYBJeFaZeruRp2QnSYClON8t4EWyELab50BgNNGTxO
 oBp56tmYlYpMevS4BEeUSdQCHYxSKJD0tCWhoqgha9vsTVEyxjm/BMIASY5Gfqp2Zu86FON7t5c
 yDcrPYzuSyGlfAdbm8dbmn9yPO2hdlTFiUg2HIqxfvSVHNHKo2G37/NK+JNSIMAIGP6nhcnpX0X
 hnANY/17wdoa37sszk+BX50mlGxD59iGRR/N0AA2P4fL64jJWoC1baVRcFnk22tcl+6UZwVRK9b
 8GzGhKPgar1V7jD0YyINA6p37nFuG1AJkuPwp4xcjIZqh+spBBwXkWnOhTJQmBVBGTQHXFteDCb
 ShtcBKkS3t/yIsnIZV3eF5iLLfmoldXpd1/qe9KKNHZb3zd6cRKjkFMHZgsYjMvemVZBqtGFSvO
 aN4zWTEiiAYsgp2xFmSqyFTTDSPHHGi+jmcjFt5g8503UGRyWcjc1994EgO7ygCRNW4/Q==
X-Received: by 2002:a17:90b:1dcd:b0:34c:35ce:3c5f with SMTP id
 98e67ed59e1d1-35bb9e45688mr490920a91.5.1773774001443; 
 Tue, 17 Mar 2026 12:00:01 -0700 (PDT)
Received: from 2045D.localdomain (76.sub-72-110-123.myvzw.com. [72.110.123.76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5a2c60sm196240a91.9.2026.03.17.11.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:00:01 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: gregkh@linuxfoundation.org,
	dakr@kernel.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 akaieurus@gmail.com, me@ziyao.cc, Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH 0/4] debugfs: disallow NULL string creation and fix callers
Date: Wed, 18 Mar 2026 02:59:09 +0800
Message-ID: <20260317185920.43387-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

A recent bug report [1] highlighted a NULL pointer dereference when
reading a debugfs string file created with a NULL pointer. The community
discussed the issue and agreed that creating string nodes with NULL is
invalid and should be forbidden at creation time [2]. Since no fix was
submitted following the discussion, I have implemented the agreed
solution.

Patch 1 modifies debugfs_create_str() to reject NULL pointers, returning
early and triggering a WARN_ON to expose offending callers.

Patch 2 is a code hygiene fix. While modifying the file, I noticed the
EXPORT_SYMBOL_GPL for debugfs_create_str() was misplaced far away from
the function body. This patch moves it to the correct location.

I carefully audited existing callers across the kernel tree. Some
drivers passing NULL have already been independently identified and
fixed [3]. The remaining two subsystems (soundwire and drm/i915) are
addressed in patches 3 and 4 by initializing their respective string
parameters to empty strings (""). The existing logic in both subsystems
correctly and safely handles empty strings.

[1] https://lore.kernel.org/lkml/17647e4c.d461.19b46144a4e.Coremail.yangshiguang1011@163.com/
[2] https://lore.kernel.org/lkml/2025122221-gag-malt-75ba@gregkh/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8cc27f5c6dd1

Gui-Dong Han (4):
  debugfs: check for NULL pointer in debugfs_create_str()
  debugfs: fix placement of EXPORT_SYMBOL_GPL for debugfs_create_str()
  soundwire: debugfs: initialize firmware_file to empty string
  drm/i915/display: initialize string params to empty strings

 drivers/gpu/drm/i915/display/intel_display_params.h | 4 ++--
 drivers/soundwire/debugfs.c                         | 5 +++--
 fs/debugfs/file.c                                   | 7 +++++--
 3 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.43.0

