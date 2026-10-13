Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00416CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3A410E7E0;
	Tue, 13 Oct 2026 11:58:20 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE3C10E7C1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=lKACsLAyGXPz90AjWD9gI5JqgU3v+pS6AtZZu0XOmjw=; b=P1a6hQFrKwHR9mvjI4ZkAQOaBp
 OaCyhfDkw9r7YmdKesEdZ5AoU7dNav5HIoKrzH9ew4sX/vokKTR4qVd3EkKLIeTbbFozsF1hErlV7
 oCBMrDbv5bGv/lvcfVNW6tCEzsI4EHKxWz4fKkO214MX5wqpuLMmBwQy0eYLX08GLq3JnOUbzcX/X
 GnXDxt9Qkn8Gn0ZdedFXWpLP7V27ZCJPGLTQoqZAnNLHrtIFwcjEkc4arPSCZlXJcRxefWDW9Kd/h
 b6UQwm+xLYCFyxUDmEi+6+TjOQy4wOBnR0Gae77CMse0bBqwuY0gUiwbRkTmSZt+plW7GzIEEYadC
 QsLvcIzg==;
From: Heiko Stuebner <heiko@sntech.de>
To: tomeu@tomeuvizoso.net,
	Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for the Rocket NPU
 driver
Date: Tue, 13 Oct 2026 13:58:06 +0200
Message-ID: <179189268365.3989522.1948426775839326662.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013105757.3924282-1-heiko@sntech.de>
References: <20261013105757.3924282-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Tue, 13 Oct 2026 12:57:56 +0200, Heiko Stuebner wrote:
> While I definitly do not feel qualified (yet?) to tackle the changes
> to deeply IP-related parts, I can at least help Tomeu with the more
> basic changes.

Applied, thanks!

[1/1] MAINTAINERS: Add myself as reviewer for the Rocket NPU driver
      commit: 8642201f02e11eeb4ebcbccfa214cdf88318b06b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
