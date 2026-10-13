Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2557FCC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84EE410F79D;
	Tue, 13 Oct 2026 11:58:23 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6236F10E7C8
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=pn2Qsm4zsY9uzWdZa3WLBDivUNT/7auvUl2gEUx5vw4=; b=pV0GK/JsihznfGMDXA48qwK6YH
 vxUBjCAUFvBcjXcI9UXE+zWBYJwtuTL1BYdKsG9fjDePRihpmJFsdWiwali5GIKrG/w/OYM80mhqF
 GsnRvPlCV8e/UKl84zpPoHCueiBlgzA5ZJrcuqdm/w1OZBy2+eocHjGue6LLQmigqH9HUJEZqP/rw
 bx0inYlAtZAqrsnF6RytNcfmcb8tQFLLBizTa2HA1lJIyTtbN3YQWnX9FYL4Wjem95eOhm+UB443Q
 ZpnN6o9ey3wN8aanFsZrWvAFpBDZGlAiCRR8/XQC0jwiYpUNHMVX8MU1gSdAvcxw9q2RpXyzP/Wpz
 FaP5OoaA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] accel/rocket: clear rdev on device init failure
Date: Tue, 13 Oct 2026 13:58:07 +0200
Message-ID: <179189268360.3989522.17128985650422979074.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708062845.716487-1-lgs201920130244@gmail.com>
References: <20260708062845.716487-1-lgs201920130244@gmail.com>
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


On Wed, 08 Jul 2026 14:28:45 +0800, Guangshuo Li wrote:
> rocket_probe() stores the return value from rocket_device_init() in the
> file-scoped rdev pointer before checking whether it is an error pointer.
> If rocket_device_init() fails, rdev is left as an ERR_PTR.
> 
> The rdev pointer is also used as the marker for whether the shared rocket
> device has already been initialized. A later core probe can therefore see
> a non-NULL rdev, skip rocket_device_init(), and dereference the error
> pointer when reading rdev->num_cores.
> 
> [...]

Applied, thanks!

[1/1] accel/rocket: clear rdev on device init failure
      commit: 4ac852419f0d317c7bd8db5b8acb3cc78be7fe33

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
