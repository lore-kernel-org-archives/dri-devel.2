Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8FCCA5FEC
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 08:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916D110E1CD;
	Sun,  4 Oct 2026 08:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jQD1od9X";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 623F010E1CD
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 08:50:01 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffe281cb1so6028335e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791103800; x=1791708600; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TBLGnJLwIPub+jgduJVfPnz8P8wgTaw89DxN0dlS+ZI=;
 b=jQD1od9Xo3KdQBnqPAXmNoSVBavlN981NbaRLhEV/gjL8gKsbUs2t1I0C35atRsMGi
 9YEF/zNwTd3XXLmCz4APcPUSK/fbIOuP8HcMX74Zzr3Yrj0+0he7yYUpmswYhyX6H4XH
 o7vNWe/vulE6WhWPiFfwpxrHHROTcv/Fv6TBU19XGiqfBeyM1W75wO1Qzm1pXbUBZ7na
 Mcdi8+KTOr3R/MAuOSmskE96nxm8gcXqEecOWwSi44I8ku6efC1lDGLTs27PJNH6z/Qi
 BaGzp6ehmiBZR8jHyuFz3CYojIzHbHzOtn6Ft7NeqYbA2xfiyKOMPunQhUNwptbAnpUD
 UaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791103800; x=1791708600;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TBLGnJLwIPub+jgduJVfPnz8P8wgTaw89DxN0dlS+ZI=;
 b=jEcaLUyLr5vdXgJqqGzbyS4947gouRup3rYgxseM9SPRV0z4jLlmgtMk/BOWa24zC+
 TvgcOKAuH+15H4NWK6SSG9FeFTHL4loRbe2eKFAxPs0pVIz1uIl6WVbQBCaLfZqD0nam
 yH7kBJUlnJwd0spD3DtakoUppqLPLP8bam4x/j70uhayyQOPT659bkCqnZVqGrqVuSEY
 LiQ78s3p1eNWhfKnOs7sXWZnbCXcH/sBtnw7+moNBlfWy87AYRWPVG6p8ZKGfBuY1IFC
 D6uj/2zoII4mTHO9d36i1WFb5Pc3IlEM5Q02mjU84qwEX6AZVQDTwkLynkReUe/r3Ny8
 k1dg==
X-Gm-Message-State: AFuF++lPZjANLvirFdcC3vZo+AVgJsdGHRVJNMklAjpixh3GaLCZzb0U
 o02kY+bufBhOxVdAE2D8qAZuvEkwRVEweIboRxkaGwTK1H5IA2lx0ZP51sESgbQd
X-Gm-Gg: AYBFou19tNbVsFNA/2naQB+TNDKnuKylY36yzswsz5p9k5OF24RwVGZrTdbbf/AhhyC
 0kMbZmx5DFq5sy/IMagUoiSPOcEw7CGVQ/16F4QyJxXl1r7C0hSfWZWSRvAI2A40eZY2MD+dMOd
 87OPWZBoo8xlhWhcv1yyBaAvfvFvzpWl+TDH52XuATf6yuaSZUsv7gid1Uve80nXUPvJmdWB6JT
 e8JhMMdTwFP0eNNLRSuaTKnuXBCtzAkBo8GfQvElpPAlzHPQLGtRGGSr0bzvCAjVZHXyo0qqKRt
 JYxNfYvMlOFOkfLnKh4dNSg8WIai752inKejVoijAhVjqPfERmTIMGPxA/oHMN7FydqfnHlw67H
 r9eJAy9p20UCnRVc331sX4BHb7i6Hu578VXg33IMESXg3L9YV1tPYGvp91tw7TR0SQaKwL9nZwB
 NxrdFTnbXGlEu/GP+MMaxkTyFE3WPhBtfjsv8tDv9F0AW+QC6z3yjWPoQyLLwZ3MDgZ8D968s/e
 gK3i+5oyK7gIt2imGX4IxzmEXbcjP/ADv8OIW8YQLQlVHHVji30p4UFHpIysXvKmE1GZ2X+45g4
 ZsbU
X-Received: by 2002:a05:600d:6445:10b0:4a1:6d21:93c1 with SMTP id
 5b1f17b1804b1-4a16d2194fdmr27595865e9.16.1791103799699; 
 Sun, 04 Oct 2026 01:49:59 -0700 (PDT)
Received: from localhost
 (p200300eba703ae00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a703:ae00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c57d9327bsm2076646f8f.3.2026.10.04.01.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 01:49:59 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [RESEND PATCH v2 2/2] drm/amd: fix HDMI signal type for EDID
 overrides
Date: Sun,  4 Oct 2026 10:49:57 +0200
Message-ID: <20261004084959.1441071-1-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003175619.722451F0089E@smtp.kernel.org>
References: <20261003161525.23600-1-johanneswueller@gmail.com>
 <20261003161525.23600-3-johanneswueller@gmail.com>
 <20261003175619.722451F0089E@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Sat, 03 Oct 2026 17:56:19 +0000, sashiko-bot@kernel.org wrote:
> Could this override check also be added to rgb_output_is_limited_range()
> so TV formats correctly output limited range RGB?

Yes. In v3, I'll move the check into a helper and use it there as well.
