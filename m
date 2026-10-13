Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A5BCA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 316EC10E7C8;
	Tue, 13 Oct 2026 11:58:26 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DA210E7DA
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=ZykDT+ldOzat3VDDIfdr94Z8vYDUwlbjCPKhDjwqAq8=; b=beEAKW6+D9+iNxOMMY0U47alwX
 9IM+2guNvCmM+zaK7ZAK5V4YiBCz1N7/1xsrp9vpTMaI/swxy4BFxZ1ERfm4Gzaz0rsCcdpeznHQO
 sQQwDsEM+rbxRo5GOQ4TRZBE+EojBkkWgWWr8StSUeWPl0Aj90lkeF7b5oLGWdmBQeqJsED7wHRCL
 JcRIDDYZHZ9pSspM4AueDpJy68wDjkffQG6bbKTYypYB3tx0KItxaJWPRwExZrgtXrta3DWyb287W
 YzCpuU5OOmnVq9Ee55bAgfaaFoXIdaOT/Kqi7+XkCggOd/1XRWLgFFZvQELYdn2mLIBPe3fgNiShW
 8chlMX5A==;
From: Heiko Stuebner <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Igor Paunovic <royalnet026@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Jiaxing Hu <gahing@gahingwoo.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: search every core slot when a core is
 removed
Date: Tue, 13 Oct 2026 13:58:08 +0200
Message-ID: <179189268363.3989522.7509478122641676060.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904125936.26234-1-royalnet026@gmail.com>
References: <20260904125936.26234-1-royalnet026@gmail.com>
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


On Fri, 04 Sep 2026 14:59:36 +0200, Igor Paunovic wrote:
> rocket_remove() decrements rdev->num_cores for each core it removes,
> while find_core_for_dev() searches slots 0 to num_cores - 1. Unbinding
> the cores in the order they were bound therefore loses the last one: by
> the time it is removed the search range has already shrunk past its
> slot, so find_core_for_dev() returns -1 and rocket_remove() gives up
> without doing anything.
> 
> [...]

Applied, thanks!

[1/1] accel/rocket: search every core slot when a core is removed
      commit: 6eff1d69dae808a1518aee5a58d0853a8db3f1be

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
