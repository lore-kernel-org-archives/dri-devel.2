Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EA7C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E09910EA06;
	Sun, 13 Sep 2026 20:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c7nnbJyl";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14BA10E93F
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:13:07 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f1744fso1779198e87.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789330386; x=1789935186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pa8OFY4TTfkGf1f2ba0w2jmPlViOEeXI2aNAgx40u2c=;
 b=c7nnbJyl65ZllrxYXqtn3LAv7f3ID0ibIfE0JoHMm5BaGuJTDoOYobM4g+8nCed+f5
 D7HTf1Kq7f/GRlDZcnm1FNxisHtYc3kUSAbir1ibKhZbrRp4i3QoF0eUF/VZ3oWqqDEi
 PYq8I7g+4tcJGcO/nMEsnJ7ZXJfj9tKhm0110bZ7cnavZdMf6w2q3PFddd9JLKgiVPKw
 BxDJmRT4KLu2PVGUgnQJBOCXfFu761UeSV9ioTelCQU+G7+sYT1bR7ZHq5a885iE+dUJ
 h4LjbmHvbatkmMbYVU0xG6IrUbjAD2Bl4qQ5iAtFokOB9X7RRBxlzpzYa5omHo/9mWNv
 8ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789330386; x=1789935186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pa8OFY4TTfkGf1f2ba0w2jmPlViOEeXI2aNAgx40u2c=;
 b=SdnNtfyJtitbwgBl+fY18P+ri6HZuV6vNKASaZ3b4XCbNAhrrYaTa3DibYCFJ86MX6
 mE8+Jdl/H1cNzsQcahsIaIPv2zgZ0rvtobb5ocA3+V+PGC1fq2yWGGmJ5psTU4zJ36M+
 NETqunhoBtwKLnyyAROguQT5+1c6m7SckunRHsyCwLEHBpEhkkn4vh5/6H8JhN69djnR
 sW3FHuq058D7LiX9AW9YdQWskJFiolL+JxQR2r7HEdd3RfVwFrAifW1rphChhSl1yNet
 swXr/4YRbpHshs2dnMlFKVzXLUJNkrhRYL1lwBCM0smP2Ftk3iicsB7onAEEv0HYuyGI
 r0vQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBywbNfHXShn7KsbFC2PxfsHWPDjTySxbnR+tCddhtbhR4J5jfkN0EcVruYlFD7eF1TYPxm4hnouojY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m9/1laQraQgxJeCio5WhmslgDB9811dFq4IzeNU/8oR8Kk0H+c
 H/KzCMXmiL9jhJBu4YNYlUEJlfMjZFCUtxFpExOE34HzXI5RHuibkKv8
X-Gm-Gg: AYBFou18U4FK6wkcJmVmc7seWoWISzhp1H8wfDacmKbeKRwUG2rfmYXDcLAaKfDkj5U
 SaE2eKEL1gFMQy9llp2oPuEUrRNkgHU4u85E/+52iA/xw96mHuNsJ4upOUcM9ql3+pyLFCp3/gn
 ueRjWj09Gh1wlFQscpCkoq8zxC0g/hhvfBZRZS8G3tLN3vnG2NMtgwU4ni4e5eifjNEv2GftPFS
 6IeI2MIeGj/LkdoTYSzl9hAqkrXgv5+8ZVt7YA4trR6Vr8ztaY5azNZhlkxjiteqsGJP6LBJaVQ
 Yib3yNyVZc3aGA/Pb0xWMAFLHU/924u56bSkpk9iok7e7WkE4RIJWydLrA4pqMyllj/DW+tgIU5
 lJSLbFPyuX+O+nZWNRiiNFfANGQXPQDz+sOCMVIOUHQwx3SMJRgirZXCDskTYOCzPj5zHV6lVkA
 t2wBqeFSEdtVTPyjOSFsNntzaiOawCvAanyqix6fX8cvhZwlTi06gnXeugqqvGgPkmcPgn5sMEq
 8SuEyboK9hs6G6dqE/UIB3JiXdaevy0wEKPvKodgX7A
X-Received: by 2002:a05:6512:3e15:b0:5b6:183c:5ca2 with SMTP id
 2adb3069b0e04-5b8a8f0064bmr1551667e87.64.1789330385733; 
 Sun, 13 Sep 2026 13:13:05 -0700 (PDT)
Received: from tallipc.shacknet.nu (91-157-240-22.elisa-laajakaista.fi.
 [91.157.240.22]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a03a85cesm2003345e87.1.2026.09.13.13.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:13:05 -0700 (PDT)
From: Risto Pajula <or.pajula@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Risto Pajula <or.pajula@gmail.com>
Subject: [PATCH 0/2] drm/nouveau: fix GK107 VDPAU regressions
Date: Sun, 13 Sep 2026 23:12:23 +0300
Message-ID: <20260913201225.5975-1-or.pajula@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

Hi,

This series fixes two independent Nouveau regressions affecting VDPAU
hardware video decoding on NVIDIA GK107 (Kepler).

Patch 1 fixes engine context mappings for the legacy MSVLD, MSPDEC and
MSPPP video engines. Since commit 8ab849d6dd4c
("drm/nouveau/fifo: add new engine context handling"), privileged engine
context mappings cause FIFO PRIV_VIOLATION faults and kill the channel
during VDPAU decoding on GK107.

Patch 2 fixes a fence/progress hang introduced by commit 55e1a5996085
("drm/nouveau/fifo/ga100-: add per-runlist nonstall intr handling").
Legacy FIFO implementations use a single global nonstall event at
index 0, while channel event registration was changed to use runl->id
unconditionally. This can leave fence completion waiting for an event
that is never signalled.


Tested on NVIDIA GK107 with a Linux 7.3-rc2 based drm-misc tree,
Mesa 25.0.7 and mpv using VDPAU_DRIVER=nouveau and vdpau-copy.

With both patches applied:

  H.264 1920x1080:        PASS
  MPEG-2 1920x1080:      PASS
  VC-1 Advanced Profile: PASS

All three tests completed using VDPAU hardware decoding. No Nouveau
faults were reported in dmesg.


Thanks,
Risto

Risto Pajula (2):
  drm/nouveau/fifo/gk104: fix legacy video engine context mappings
  drm/nouveau/fifo: use global nonstall event on legacy FIFO

 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c | 14 ++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.47.3

