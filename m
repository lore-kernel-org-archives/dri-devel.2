Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB91ACC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E32310E7C1;
	Tue, 13 Oct 2026 11:58:26 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3511210E7C1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=RXZipy+fUyJE4tmfdVmFNE5i0PV1F24TRbxaj2s7BWs=; b=coIeN+ZVk9rzeh4fwrzxdIUGxg
 NsXihkcvVcMD90BovGsabSbtQ6Zx79cu+qsGLfFDGHQZl5g9O5/ElmF45eSBRLjJizpP/refSAJea
 lB1UdHq9PSwif4+moDtCLzO8Yna8fiOGxAg/ENjFir7l6C9IZYd1Kqn4rI5sJPZqdMkYqwwWd7ikq
 QttHtScVhiw6qO2v6qLtCXrW5DboVG12t0ECHezfeSBtSIgX18B8oXPduTjEOYSpUv/23VszGaT72
 Z2Tv9KavsAhmY6LWPGN+GHJJ0qNRJKeszbn1CjJB5ivaOTVtJ6LAMx4jB7PVGop0o220+wUpeyHUt
 DWTbACxA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Igor Paunovic <royalnet026@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Sidong Yang <sidong.yang@furiosa.ai>,
 Jiaxing Hu <gahing@gahingwoo.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: search every core slot when looking up a
 scheduler
Date: Tue, 13 Oct 2026 13:58:09 +0200
Message-ID: <179189268364.3989522.6809230134424233060.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260905150432.7477-1-royalnet026@gmail.com>
References: <20260905150432.7477-1-royalnet026@gmail.com>
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


On Sat, 05 Sep 2026 17:04:32 +0200, Igor Paunovic wrote:
> sched_to_core() walks rdev->cores[] up to rdev->num_cores, and
> rocket_remove() decrements num_cores for every core it removes. Unbind a
> core that is not the last one and the cores behind it fall outside the
> search, so sched_to_core() returns NULL for a core that is still bound and
> still running jobs. Neither caller checks the result:
> 
>   rocket_job_run():      rocket_fence_create(core), core->dev
>   rocket_job_timedout(): dev_err(core->dev, "NPU job timed out")
> 
> [...]

Applied, thanks!

[1/1] accel/rocket: search every core slot when looking up a scheduler
      commit: 89c2c777df17eb0201c8e22afabbf3691f2a28fe

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
