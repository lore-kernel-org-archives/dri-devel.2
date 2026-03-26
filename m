Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F28810AB807
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6F710E277;
	Thu, 26 Mar 2026 19:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="rT+EojIP";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0995110E277
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=Dpb9g4AmMThBft7vkg8e6vXf6FuktuEf/tpfSoteEvU=; b=rT+EojIPKSXnKnUMTD+m1OTPSH
 A7I54JD6N8ZUJ6yk6wFwyNmv64ay6SzS5sYxnTBtXLbhN4nwxZybp2Ihq1MdT/ysS7UH7QMk3DDJI
 bsbVgBuavW9jusYW+Endx4CtvyE/gyRJ7c9RGLxqlHrYkNcFS20QWWoXOIv3HcD9hMxgZ1LmNFeEF
 ixWoEWh1ig/YSnfufxCqRIvYWG8YTGjlqfIRheOYMG48fIsUF33AUviOfWxOUIeBBfGxUbDXgm3GN
 xF5QZBVtvga3vddP3IHZkPvZMKaWl6KaPTXd/du74CUcWLBqASct75RH++pcJeMC8yesjgCZEkJdN
 dEgjoIig==;
From: Heiko Stuebner <heiko@sntech.de>
To: dsimic@manjaro.org,
	Chen Ni <nichen@iscas.ac.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, airlied@gmail.com,
 andy.yan@rock-chips.com, damon.ding@rock-chips.com,
 dri-devel@lists.freedesktop.org, hjc@rock-chips.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/rockchip: analogix_dp: Add missing error check for
 platform_get_resource()
Date: Thu, 26 Mar 2026 20:41:02 +0100
Message-ID: <177455405025.1277100.9154937580491920768.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260209033123.1089370-1-nichen@iscas.ac.cn>
References: <20260209033123.1089370-1-nichen@iscas.ac.cn>
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


On Mon, 09 Feb 2026 11:31:23 +0800, Chen Ni wrote:
> Add missing error check for platform_get_resource() return value to
> prevent NULL pointer dereference when memory resource is not available.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: analogix_dp: Add missing error check for platform_get_resource()
      commit: 45895f4d4d5f222d07412f90664f88b059627859

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
