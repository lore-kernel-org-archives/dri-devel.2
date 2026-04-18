Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524A9EA719F
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 14:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A760D10E239;
	Sun, 19 Apr 2026 14:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="Y0QEO0bK";
	dkim-atps=neutral
X-Greylist: delayed 1720 seconds by postgrey-1.36 at gabe;
 Sat, 18 Apr 2026 13:26:55 UTC
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8B710E32B
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1776518810; bh=m5ouyqDIJTmdLtIThsK4ld+YF2pYDh/eDqj8MzXUV1c=;
 h=From:To:Cc:Subject:Date;
 b=Y0QEO0bKc4BnBjd0Dx3fB6bWThMKRxdcZzVx4cE2Ayxd9d4s0JNVZLKyOXyr8U6nn
 jJFlRzEpmCxecATzJxEhFrAB29zi249dzqc5hH3oAqfx6ykKS+fSl229+Tk8pm5Prq
 sWfGAVpA91Nrt+0P0t/zD+qf/PjARKE4ux1DA7z0=
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([2409:8a20:c5c:cba1:8896:daed:9ee1:9565])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 6B085820; Sat, 18 Apr 2026 21:26:48 +0800
X-QQ-mid: xmsmtpt1776518808tclb0sqvf
Message-ID: <tencent_E64AD88CD05B6CF27EC7CC83D52A6C6E6C05@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAy2DsW+N/aFh0gHKaFuD6gqy7bkKVObDq9EXHT9mt6fDNoQuOxv
 3MrNiNTo4C3ZoFnPhAlmucl80CuxwMoEChfcbmcAUuOZ3RdS5Qt3W9CeDPvkYvpFkuAcpnA7sCST
 BSo3+n5xrrVQKqFU9AOmPZ0Heg80EH7ttDv7t9lOkjWrfbNxLvU6UsF9MxhH01SnyGNL8BQLU16d
 glDiT4W2/iOHE+ARhsRVWxanaQ5TUq9TrPgCT5/mxci5Gk8PDGzl/OBLSHjxnBAGwHQIuDFyTw3z
 Y+NnpoVRrZeECSqJsqCzf9vDiMZFepKUxUmH+xbX+v2I8Zymt8xLGC0hNcQePS1iuAzKAOULqI6M
 0EMpd9jYfy4M9Il5tNVvnXjWC6mQ+tjRGxBaA9XxsmB4C0WUCXpdBEwWXpvUcM8xMtLWgouZG/Y5
 zpOJEN9MvoXuCqpz+KSEL/b90UP4K9/yBiWZOgCy+wq1e4JDAOuaaAPBZN4GSdTxu0GkKR3ESMpd
 sP3+/XX/IFgkRI9KyVRYZDtK1SNLYnRo00UnjzqMoFwx25j8NOoB2UOuupGCj58b4QkhduTMCt7N
 Y8RKKrPykOR99o2F5LuMpYHapauc1yEtjpsmtQxJ6Pf5kTyoxn1xQ6gNV8hIGuSTUvqtEtYbZURK
 g8Nm9ouO0Tk9ABFA5IDU5L8GWpwIxmaYl1xc2/VXr/0tAUwC5hxOeMOSS/B2SiRQ8X/9i4iotbw6
 feNLoMJ731iaaZj27MhbNFUTDAk3ukkCJ9Lt/fu5u3qvO837gK42+Kf/dAQD0ooLfRN9oe7X9vvx
 Jj+vkLJSj/q+NSPo1gMbHCdO7RNWkbUz5TvLZIUXKmEjj2EwLijBxNbCq05E+x1YsETy8R77POW9
 K+p/MOpnZhujVFaNKENF+6o41FT3EnAZvBVXDVJ7Nw4uxHeaEkhHh9FhAcb3K6ub/dz45RLO4u5x
 zet4L0+ERY8xukNfZZu6f9EfmZx0DDBUdlsQKB/GV6BhVVTZ7QR15dJxcYdCgkLYdAmQHQQKmPup
 wA0wZIYquQN6FKLOnVYFLNMlWQI0iOdvIVA7AjVA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: wooridge <1063373698@qq.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [WITHDRAWN] treewide: fix occured typo in drivers
Date: Sat, 18 Apr 2026 21:26:48 +0800
X-OQ-MSGID: <177651880830.57357.17992021655739540869@qq.com>
X-Mailman-Approved-At: Sun, 19 Apr 2026 14:39:49 +0000
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

I am withdrawing this patch due to formatting issues. Will send v2 shortly. Sorry for noise. wooridge

