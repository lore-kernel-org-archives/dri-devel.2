Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FBCCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 444D510FF05;
	Fri,  9 Oct 2026 07:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="PENFuB0O";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0E010E94A
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 19:13:14 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-33e6279a1d7so3244691eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 12:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1791486793; x=1792091593;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gGgE3kKeoX2vWEaOMwOk44hmNWlNe6dYYIaxJ66sqbw=;
 b=PENFuB0OhmG80Nk8itINi0rywZoARZUr+obGaeVs/HAdX7BMWPxpHQ6aBUt7MqpOQE
 cJxuMzVAkHZmtKx7MjSpE4Bc7+Z/hGOqi2La1/3p22xMcvDzrBpSAYZSeRsrlA1QTRv0
 aTdvRwNWGMy47F84OfPeipvyPgmqa2Ey980I+L/6WBWOUnVu2IOp05v7dBCffenz60As
 VLc5bBGCi0kzbTv2KgXxMPvzd8GOYDmYraRY2UGH0v84GrNxo8crHDG4JH5MuBfuskHM
 qZ98eSpu6a9+hJS1U52tIyF+wJYWMf2hD9nZUyuxvPsHaSLiO8EqDlnozvFxjIR/22a2
 gYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791486793; x=1792091593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gGgE3kKeoX2vWEaOMwOk44hmNWlNe6dYYIaxJ66sqbw=;
 b=T3vQXhFi/3W1TaWt96lT8IfF4vwqQqO7wjbhN+pP3U3fhfnmxZ25wF8D3sE4AsUa7Z
 AAxdhyrUhLK0CMxQLZU4MFglCmGJ4tuRVVqZlO4sLSOFEWOVWHzqKyOVfrQ58q+eJ9Gk
 5aWRFp3ep4gfEuCIN0K9aSKvXt7Q0iO65MNwYLbCgmDLglLIiNqI7/5NObdBtbcmujvU
 CIR/x5RZFrzHq947fsXjGS2iJqdp1Ti4z0P7Mcif3HQ3ukOXz6Va+BcgLo8C9D0VkQBB
 foAjpsinOl/nZRWxe1Fg095uoWBTST7czSvxZRHl45dYfGt/wusZhT26WY4k0jQEv37p
 s4EA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWQgOJd3w1s/3PUizd0RT4hFMRrvMEpDWG9sALLbcvE8uaCwFglQZkXiHO0OKU8hFB75SNNKbQrsM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJV2fmmeInGffKqY8cyjsD0JKDo8NhhWwhHHgLbqK9Ug8wxqvm6
 2MujbZKDd/0kdQdV6JDrjemBoRoWnGzEaX9A7S3NvbQjxypYIPAadU903qL2bWABHdE=
X-Gm-Gg: AYBFou22fUSi4b+9XrMD4ayPO7j/Sqe5+eHQMKA9v9Ay7a4bqwctXhPZqR+2YnAz9zP
 +03+HV88gZeduCOo5I2yUdSpbqdyzgo6PQeocweFodWPu8wd/f9K/4rGxImxMo+MBUoUvOZ3Gmn
 /0tsVj5qTu8ODHVifVdkpBeQezZNPSn2GBwnuRI1hOhXsCA/SNYL62TetQCgnb3pDwtG3W6OXlG
 wHnY+S54Fl39HpOw+LjeawxjkfE7zX9ckUgmmyexZ4WWJLQyJ48jh3ZctGKHiw+85By4F9xVV/A
 iAwzhURV3Wlqwi5HQOmEMoHCmBFSHAj/FrAxyAv6aO8dqD8FFeT92pP62JfIWC4H3OEFPEh/bhK
 wGJ59fsLytQacEfpDpdiw3yAiaYbaCuV1Vx/AkDfjhPk2NeGfZ6XhFfz95RyH2LkYLw+qmHnqfT
 nkd6JQC0njOsQ+BxqXEFP0r5+OjMD3c+uQYWYL7eIjVzCDdKRFVKEbIoanGZNEzdpVSaPeBYglf
 HGYToOVZsn4a04XHPp3IAer3f5S2wcWYjvBtQkUDL4oMPm/us7Ep8aktEAUq/xnCjvMH30n2TnE
 eUWqHQ==
X-Received: by 2002:a05:7301:c8a:b0:351:7ec0:cd4e with SMTP id
 5a478bee46e88-3517ec0ce24mr3629562eec.41.1791486792986; 
 Thu, 08 Oct 2026 12:13:12 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841579sm94214eec.4.2026.10.08.12.13.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 12:13:12 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Helge Deller <deller@gmx.de>, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH 6.6.y 0/2] fbdev: backport CVE-2025-21976
Date: Thu,  8 Oct 2026 15:13:03 -0400
Message-ID: <20261008191309.98263-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 07:17:39 +0000
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

Hi Greg, Sasha, and maintainers,

I'm working through the smaller CVE backports still missing from 6.6.y.
These 2 upstream changes belong together for CVE-2025-21976. They must be
applied in this order because the later change depends on or completes the
earlier one.

The complete series is already present in 6.12.y, 6.18.y, and 7.2.y.
These fixes also affect 6.1.y, which will need a separate backport; this
series is only for 6.6.y.

Could you please consider this series for 6.6.y?

Thanks,
Artem Dinaburg

Series:
  1. fbdev: hyperv_fb: Simplify hvfb_putmem
  2. fbdev: hyperv_fb: Allow graceful removal of framebuffer

base: v6.6.157 (79643295eba17affbd16ca97f3ef04c90266b28c) plus stable-queue
revision 958ddf240a33ef26b1771be944f0ea6c3b597472
