Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3C310706DB
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 13:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA9C10E168;
	Sat, 14 Mar 2026 13:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o6eSe+7r";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0549D10E168
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 13:13:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B20124099A;
 Sat, 14 Mar 2026 13:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F947C116C6;
 Sat, 14 Mar 2026 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773494024;
 bh=6gcZCrWNBMWCJ2rVIp8u8DGpdWLgEe3iegnZ0nHqqPE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=o6eSe+7rRxpimIhRgJz0UD0ujM1PWgKdkdaQDhvJyAVm7CYaFoMzBl91PcrcLVzKv
 rLswmURYOYRA2p8X/mTAuARSDSOPqtbcLnR4Drl2laA7xUC38nBicD8Ccl18mnzRdw
 HKPtQsl1vq0EyCgDPtCJ6pPF4J1cFyeCcw0QE7+jGwMLt0JQtitClQ981Y9EAyy7Qv
 LSW2xnOYX4MdqLYjYkaD2pQ2N+D1HYba5v1HuSCgyN6dU4CFm0/cONKJoxlY6AJig8
 o4cgmPCMr1Uti3yc9DTYfq+VQEuN6WBp4Y7K67vr4aTOUW8ZW2UR/0EsQn2dxbjAHT
 sdo79JRByBvzg==
From: Chen-Yu Tsai <wens@kernel.org>
To: mripard@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, 
 Ethan Tidmore <ethantidmore06@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260226163836.10335-1-ethantidmore06@gmail.com>
References: <20260226163836.10335-1-ethantidmore06@gmail.com>
Subject: Re: [PATCH] drm/sun4i: Fix resource leaks
Message-Id: <177349402208.44870.10275878012349571806.b4-ty@kernel.org>
Date: Sat, 14 Mar 2026 21:13:42 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 26 Feb 2026 10:38:36 -0600, Ethan Tidmore wrote:
> Three clocks are not being released in devm_regmap_init_mmio() error
> path.
> 
> Add proper goto and set ret to the error code.
> 
> 

Applied to drm-misc-next in drm-misc, thanks!

[1/1] drm/sun4i: Fix resource leaks
      commit: 127367ad2e0f4870de60c6d719ae82ecf68d674c

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

