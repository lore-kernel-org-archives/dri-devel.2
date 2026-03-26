Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A499610AB810
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 734BF10E642;
	Thu, 26 Mar 2026 19:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="RweojlAL";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CBE10E642
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=DlmogNfOptQj89GJe9FVyLLtAKx7p79DNZYBO+JYw2Y=; b=RweojlALWVlzYQ6xNRx23B4sjb
 dPZ7vxiUv7SwltE2i+qrjrnh2hjDMUlkQBvx4EuxhvZZnkYr9rw0sHgbm2wMcXR7gTYhN4G9dRPKN
 Fb+w7jfPDXSITkUPkxml4T39yZQsDbPttBaX57TAwUgxUGBJmP/kwAAsv3tUN6ASs+9gaXSJNyJET
 XfrCUwKhH6+V4Rjfw80gLrDdO36kIC6J3Z9VsxmTXMCcTiQq1u1n0yYDtV9e1KBdfQDOkOEtd1arF
 DNncTtXMUc+q2TMQzqE4myDgbMdXRYgJlHZzYxEHKJ7YghMY4aTdDEgQoyLEeKaJu6Ba0KRewOEty
 DOhEwU/Q==;
From: Heiko Stuebner <heiko@sntech.de>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: Test for imported buffers with
 drm_gem_is_imported()
Date: Thu, 26 Mar 2026 20:41:04 +0100
Message-ID: <177455405023.1277100.4214243697444815661.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227133113.235940-11-tzimmermann@suse.de>
References: <20260227133113.235940-11-tzimmermann@suse.de>
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


On Fri, 27 Feb 2026 14:31:10 +0100, Thomas Zimmermann wrote:
> Instead of testing import_attach for imported GEM buffers, invoke
> drm_gem_is_imported() to do the test. The test itself does not change.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: Test for imported buffers with drm_gem_is_imported()
      commit: 9fc0da81916250f343599a4dd259f097196bf0fb

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
