Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD6606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iQr6ehpA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2026D10E5CB;
	Thu, 29 Oct 2026 20:58:40 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDD710E4B4
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:58:33 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-53c4b82919fso35626301cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793307512; x=1793912312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vJc9UrlLUv+S95tnCqwn/5femZD84UlV/9ya3KCITd4=;
 b=iQr6ehpACZiuvluXKQpdj4v93jo8PnYtMKgnCaeU8ehX8u7EV0vsw5Ht+vrXp9siMY
 nbxV0JLGeuiiYpfwo9Q2ywkzsWB/deIqlYZdWVk3s8QuF2ZGwHNtzmHdWJ66SNdFrRga
 iNpGR1MZdR9nbpch3u61c5WsNtEE84CMGv5MBD39oJNJ9EJGYomEnIiHDi9j+SeXnDB4
 7sc4/EiYZ4TjnXlk1u9xDKhuQvlH3ew4IBQFMbtiQk49pkuj0k4H5hz74JB/GtzzGFR/
 PhKilal2Oo+z83nR8E/aAw231Cf23ATbRIHHbxdJPOfZa2qVLpqseKNXFHogiPuAiP9Q
 9pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793307512; x=1793912312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vJc9UrlLUv+S95tnCqwn/5femZD84UlV/9ya3KCITd4=;
 b=kkkRRpQQLb5wQyLYnoVGOmPfFQKhSEofr5tSeH0NAjipB/uLl0e+cTAGHcRdGLrqxJ
 y6LYy/ai6KmcBMpFRf3hYUuH227pusMRkKekViUXF38F13dTtT3qdGzdF7pxQigcyveh
 fRmPuUqGly6OnFFtK4MtJJu7lHQrLnE297AfRW50ixrZ9YftPIqBG0gI5Y/Kg+OQpYOQ
 /AsuDNEItjHtmtWqsvwCYY6qy5Yn2Q/1gg3Y7JS4r9CDKAIHGrUWQI3wJkCCL723+jFH
 +y54SmjWUame2nD80gyXjRpSYnwclfSgb9QDQQT6XAEsiNc2tnLbl0lkh0SV4AnqAE65
 UobA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwthnvOC9X3s7bzg1nqef17+1TasOrpYZxe14T8+YvLW9c8x+kBZ5lTC4qJVcmMZDHp3LAunyI3IU4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIES3FJ4LZHFunPwFFQS3lOhLMBYN7s96UXSDv/SYryhhggchLZ
 L+F2kh4AHNMFZ2qzqDKuiQbg4bwSGp3tn6YYdinKcOyhdXwSFlbRV5QL
X-Gm-Gg: AYBFou0vCh5moiyHvzAGDDHQQSX8ReJHkONaSR4c9lLmI5uR0KhkJVA/aItZfpuy93v
 RXT/dQjtVoisSYDmdP8yTXjon8aMUvUgiMZUNX+EmZuWHq9B8Nyr4nyXhoE8Konb47kkqL1iVu3
 KtS18DkwFCFchjhOjggJdct0uZDJtvcPHWFW3sDxGCVR0sa2SesQCYFn4ZZ+bc75kK+8IpdhHu6
 XDQFL+kO76F8Wx7L62qMeC/nCeD8o210LQrClzHxZqEVhxqZlTiaNnWWE5tGueUx7iNSD7/qIuT
 M2IMgy/op8jjFwwCBWVHx6z41Yme0BXfDDKoFr0h/UreIurz6jlh08bWppQYAFAmtS96iawIjpA
 JJUyUfbRMWiQLNIH0By2Zryt+FAM459Qf/qtwgRrMRKQldqwsAu7Wrxbc0zCMwOgnsZpsNFYvHN
 kdo7jaBpV2cA7xfJ/N1AJorysuTRIhFWcU9qxXyKAjxgTDLDY1YB1aU0yeOUlvaj+z7FlFylm7T
 HCvSbscoqnNtVcIvJHWGBzWSmLlXWNMiP901bj/yH71stTP2i0G5JaK+bzF4STeLUXcyWexwAFs
 Jy0alI64TrflnU6KyK1QHIyMvm+2dfDyjBXFijCBl9HD4kDMUp6Ad+jTTLTya3cEs0OA
X-Received: by 2002:a05:622a:50f:b0:536:71ce:5d0a with SMTP id
 d75a77b69052e-542b83f1f2amr3961121cf.74.1793307511973; 
 Thu, 29 Oct 2026 13:58:31 -0700 (PDT)
Received: from holowork.tail3176d.ts.net ([71.104.86.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca31032c9sm6006136d6.21.2026.10.29.13.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:58:28 -0700 (PDT)
From: Fabio Piparo <holofermes@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Amit Barzilai <amit.barzilai22@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Piparo <holofermes@gmail.com>
Subject: [PATCH 0/2] drm/ssd130x: Make the SSD1322 work
Date: Thu, 29 Oct 2026 16:57:49 -0400
Message-ID: <20261029205751.3513474-1-holofermes@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SSD1322 has been in the ssd130x match tables since the ssd132x
family was added, but that family was brought up on an SSD1327. The two
controllers share a RAM layout and many opcodes, but the SSD1322 takes
command parameters on the data path and differs in several commands.
This series gives the SSD1322 its own family, shaped like the ssd135x.

Mario Limonciello's connector luminance series [1], not merged yet,
sends the SSD130x contrast command to every family it does not know.
The SSD1322 does not have that command, so whichever series lands
second needs an SSD1322 case there.

Testing:

  - ZJY 3.12" 256x64 SSD1322 module on 4-wire SPI (mode 3) at 16 MHz,
    Raspberry Pi 5, Raspberry Pi rpi-7.3.y kernel (7.3.0-v8-16k+) with
    the ssd130x files from this series in tree. That tree also needed
    commit 3dcb0564c509 from drm-misc-next.
  - Without the series, a modeset and a full white frame leave the
    panel dark. With it, the frame is white as expected.
  - A KMS client at ~200 fps matches its rendered frames on the glass
    through a camera harness, at the default clock and with
    solomon,dclk-div = <1>.
  - Backlight brightness 0, 64, 127 and 255 moves the contrast on the
    glass.
  - solomon,dclk-div = <3> is refused with an error and no init is sent.

[1] https://lore.kernel.org/dri-devel/20261002190030.211356-22-mario.limonciello@amd.com/

Thanks,
Fabio

Fabio Piparo (2):
  dt-bindings: display: solomon,ssd132x: Add col-offset and dclk
    properties for the SSD1322
  drm/ssd130x: Add SSD1322_FAMILY and move the SSD1322 to it

 .../bindings/display/solomon,ssd132x.yaml     |  29 ++
 drivers/gpu/drm/solomon/ssd130x-i2c.c         |   3 +-
 drivers/gpu/drm/solomon/ssd130x-spi.c         |   6 +-
 drivers/gpu/drm/solomon/ssd130x.c             | 277 +++++++++++++++++-
 drivers/gpu/drm/solomon/ssd130x.h             |   4 +-
 5 files changed, 310 insertions(+), 9 deletions(-)


base-commit: 21803a577cc692d01307102799f795a606871212
-- 
2.53.0

