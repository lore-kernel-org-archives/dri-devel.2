Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859F3C55175
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C0310E46B;
	Sun,  2 Aug 2026 22:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.srl header.i=@kernel.srl header.b="jYflg1Y/";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF7B10E431
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 17:06:55 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47fdd674e17so359093f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.srl; s=google; t=1785690414; x=1786295214; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lHAtSD2vdw7vGnmR70Y4vTxd424et6OwpRuM3OOoWnc=;
 b=jYflg1Y/f86FgDMvfTWPGiD5gyKizi08FxVB6GMrOF+19HlY9eqE2A1CPFHjfmpDTe
 UMF3a9l+8KGiz7TCWb9LeV1T94ofJktJu46FpXCza/ZqYpOg/QG1lIxz4iI628lCKSxU
 XOW5lNsWku1XPw4z/5FkT8iHYZEcAx1D/6RCZcSPv++LjQy7KRP4yhf9c2HFx2DSMuqL
 8idP3lzaibyU8I/iRpiBWldkJx8eiAGYm2kGsMM3FsIqevtl/kC+OblPjbe4h+4Uc8GU
 1GvJq+aUWm2W1gmXTAb2DHldOL4RSCdpcvtu4FMeJTvAq5rkVm8JIfv8g+3YUdYIJ+Ft
 u9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785690414; x=1786295214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lHAtSD2vdw7vGnmR70Y4vTxd424et6OwpRuM3OOoWnc=;
 b=JG5HuXRNcBGJ0kX30XhaqNKdWKJjujPrs4qG4QrEaVso8cth+Hcl0Cf4XqcrTMhsYH
 Pi1eBIKETV5LVT0jK+JhNkDoEJ49TxjjjF8hda/Zg0UAHUfWSoNq3TrgDuucFsLxBKFj
 OuE6XSIt7z2SMARMnJ8RM+zhaR3R13Nf4vprddBLSTQN4oa35O1PS4MdKKUR1kbN5OLl
 ZNjQhfjWsC4Su78vusgq0VKzEPZqnF8XdHwvOP+05vUdR0mBN7YO9N79svV6tMFHK/kU
 Rvxon4ogIiaTjRRL06S1jOybb8HzDnN33JnME9OeWA+tIM82Cew/T+GRfHMCku7DxKTP
 NyZw==
X-Gm-Message-State: AOJu0Yz1IN88ExGMuR45Gm/pQMsg6vbcIB6oisDBeaqJMwiX8U76j7bh
 MtLJYyC5F6eIkjfOq5TRMlysW/0VsRmWVzMxQnyPed0871uIKiOfpf+YOC0TstLtJvE=
X-Gm-Gg: AR+sD10ASNagopfEcIShgcHzArSgw1PXE6+hReQ82+Qb9UffzoyoQ0aZz74qzPrciVc
 tMU7Db0xPZIZsZXMMIr1UQ6b5v8rGWCr0WkXsVEFRspyTntwHxOcRDgVjarUB8+KnI2J4T7tXOX
 cdclwn1TtHLor0WgkwwS442yY0RzYj3GOiEaXozByDcDKbr46nFjyNRn98FDdnM6ZkgHeyolPCZ
 iWHmeILZKBRNqs/4h5gRPhSbmF4r84wM432AnyfkP/Xfw7yLsZ94hDbybBSpLJfo8zyfEjghOKf
 tIAdscBBGO2+FyhcLBUMN3DWIhAzaP+iQ0p+7CigHNg9NWKzXAlwN0XbRMsoiYw6mEccdYrygPD
 TuVMaumNxMGb9TLqY+Sh6kkGiAYxhpkrjrgTG/2B0nXlgt78Jd/nMlfFhOp6NlQAyZEm+jjjODH
 lKLGRGzl6dSSkHgJzA7sYyJvpQ6pqfUFQG6yxsYMe/CJ1mv5/1EWF+EL9JjtBoPZt4t+4CjroU5
 aeUmisCUpXOzY2VgH2WJBEOhJpzpg0HsA9AdtwHS43v14/iCdsgXzViVDmJh8rpfco6uxpqMvpP
 9NLdg0KX+XWJXXDmJ20ROx8+tZ+aaRZdFLSGUm48TjIBZJPp5nIpVVt/vyRto/2aVDmnboqRp2D
 4A76bbG3uldtjEn1fbSmFbu1pCZiOQSddAUGaQNmNEfeqXLMnvQ==
X-Received: by 2002:a05:600d:8492:b0:496:c2fd:1731 with SMTP id
 5b1f17b1804b1-4980c64b96dmr102723465e9.1.1785690413324; 
 Sun, 02 Aug 2026 10:06:53 -0700 (PDT)
Received: from KITT.minareto (host-95-230-187-130.business.telecomitalia.it.
 [95.230.187.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b6745csm161687225e9.7.2026.08.02.10.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 10:06:52 -0700 (PDT)
From: Cristian La Spina <cristian.laspina@kernel.srl>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Cristian La Spina <cristian.laspina@kernel.srl>
Subject: [PATCH 0/2] drm: luminance range from DisplayID 2.0
Date: Sun,  2 Aug 2026 19:06:45 +0200
Message-ID: <20260802170647.206880-1-cristian.laspina@kernel.srl>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Aug 2026 22:41:01 +0000
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

The eDP panel in the Lenovo Yoga 9 2-in-1 14IPH11 declares its luminance
range only in the DisplayID 2.0 Display Parameters block, with no CTA
extension at all. The core ignores those fields, so i915 refuses the
Intel HDR backlight interface and falls back to PWM, which drives
nothing on this OLED panel: brightness cannot be changed at all.

Patch 1 reads the range in the core, patch 2 lets i915 use it whatever
its source. Patch 2 depends on patch 1, so the series should go through
one tree.

Based on drm-misc-next.

Cristian La Spina (2):
  drm/edid: read the luminance range from DisplayID 2.0
  drm/i915/display: accept a luminance range from any source

 drivers/gpu/drm/drm_edid.c                    | 47 +++++++++++++++++++
 .../drm/i915/display/intel_dp_aux_backlight.c | 17 ++++---
 include/drm/drm_connector.h                   |  3 +-
 3 files changed, 57 insertions(+), 10 deletions(-)

-- 
2.52.0

