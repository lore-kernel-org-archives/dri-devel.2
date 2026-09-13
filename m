Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE40C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 00:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0490C10E7A1;
	Sun, 13 Sep 2026 00:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jR6tOLvs";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0089710E7A1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 00:13:59 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843af75de5so164059f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 17:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789258438; x=1789863238; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KLBe/OOwpVUGn9wvmYKnhyUUthdVTu/kHIljamopULo=;
 b=jR6tOLvsjnRlRwZG1in0p0hz94+RXVJQmrFV2XzuA8hL6iD2Tp7Np2Ob2XBWL5nPB/
 UZCAAZImnCxes/ZqlnVdKQw0XkQtKnZaojld6okccxcpWWjsvf4ma5d106wsRqiW27jI
 h0GoP3k+LzsmI9FmEEh9+v0Z+H/0gCYzoQjUGg7yx8eDSLkytKSr+NMXbkBqc7GKb9yn
 80hEh16EaKTK71GgfrZkS0dwFrjW0gH2g0565FMyl2/GW8XTNHTO6SNRuPBMcipsx+xt
 TBohPQ+pJVqsYdF7fi+2QokBmtyedXmOZL+Ud4V8Sf8aWutKQ8UXa65XmIkBX8px+1aT
 ukew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789258438; x=1789863238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KLBe/OOwpVUGn9wvmYKnhyUUthdVTu/kHIljamopULo=;
 b=lX5UUGM2cMrXGlNIgL/t0qxk5qc9dzPp3z/ypvvrwWZC5vGVp7FRTw4JDkLkEen2eg
 7IfR2nnb8MshBAH990CG0P7gxzT2RegJk/G/UycVQxNoHdvMQ8BU79A0pjKED3EBKH5W
 BsFbYslweDXRwS9E6zEkD52ApcOvA6qafO8W+Q887sR5ZJCGoL911j6HueW3V51WQhX7
 MaWNC0R/SHhqU9uG1xdXcxo723j4C/ReKTctnZ/QKJza6I9WTXwGFE3WWtB4r0lQlTv1
 gzRpfwb3a0xxdxaydqCKIBwaGUXfMG3fZjzNjXHMD1sJT2Zttxl9fQ5meaT1ipniV4bq
 a1vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8aqCMHWT9kaGTXWmQfzIA7e/AQ0XxKiJMGR6ExVvvDsyTIDsg/lt+fLCOJpiBN6ZodGDgvHsSJQo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mH8dF21ATZRee+QraLtq/ij2HYmOXWx55TgHCKKP1AMCitNOrM
 jHMY5En62fEG2Tvwo/jIC4oPXQoAHsi9XV5/oWmrZVI+7KrKLMd4wDTE
X-Gm-Gg: AYBFou02X2ZsKQ6yCF84m4vLMDpPA7pkT6zUUNi+DWWyYaDYWwxVPrX2aYk+XFxF7/r
 IuFjtOuaGzuMAikt6salr8SoAvLDKbc9Q3ob9VUs8jsJ+0yTDURVcH8u+KOtqu6GjjSoQ14cZFk
 v0qPz2axU6sv8Tr9TPniDUVANgD/0nNzHnXDpbXCnX53r6Jg34+AarSYalPjk1pj0916Bj2SI+9
 lKkQ+aid6VP+9kS6irpNmRODsJY+rwieHNpc7tmeW7CUx0euOZOPF1PuLm/ARjwowZZm51OzHtU
 IXQ6vnhwnhlWSJ8TAzIvBDdevgmLjgrryAUqjLvWh6V4qiywaAYfzvEfrGMf5Gudew3k7W9svV9
 b6iBXes6GbqRcmFpFLoLNtvfCVqoPcxxDvLq4v8LpoF0ejZihgMHYble1PjD/RuhtaLwNixUWCf
 WtDFbHLM9IaU09srsXCfe9XuW3Bq0oFN7qAs/ByujLWlYd+RQSus85akbDYZTVbmbF/VDwjxrEV
 vJyIYN5SphUeCfL07tBT6NTnqplZgAZ14OgVHxzR224ShkL+RKEy2BTdi8ynFxUawOPrpDnCB8A
 7Yc=
X-Received: by 2002:a5d:5d0b:0:b0:486:f768:395b with SMTP id
 ffacd0b85a97d-486f768400emr4396159f8f.0.1789258438177; 
 Sat, 12 Sep 2026 17:13:58 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8209007423DB663D3B2FEC.dsl.pool.telekom.hu.
 [2001:4c4e:1b82:900:7423:db66:3d3b:2fec])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34f1f7sm15970102f8f.24.2026.09.12.17.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 17:13:57 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v12 03/14] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Sun, 13 Sep 2026 02:13:27 +0200
Message-ID: <20260913001327.47121-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912224844.1614558-1-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
 <20260912065053.1519165-4-gahing@gahingwoo.com>
 <20260912113717.6819-1-royalnet026@gmail.com>
 <20260912224844.1614558-1-gahing@gahingwoo.com>
MIME-Version: 1.0
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

Hi Jiaxing,

Thanks. Please write the date, so the text reads:

  45 induced resets on 19 August, 102 on 25 August and 74 on
  12 September, every reset recovered, no MMU faults, no lockdep
  report from rocket or the scheduler in the runs where lockdep was
  still armed, and of the 420 inferences scored, 384 matched the CPU
  reference within 1 on all 48 output channels while 36 returned the
  all-0x80 buffer of a job the reset had cancelled. The protocol
  bounds; it does not prove.

Keep the caveat, as the last sentence above, so that "it" has its
referent once the paragraph around it is gone.

The tags as you listed them. Nothing else from me for v13.

Regards,
Igor
