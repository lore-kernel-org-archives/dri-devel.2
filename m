Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B37CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFA410ED37;
	Thu, 11 Jun 2026 07:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MWHABnq1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC0210ED36
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:35:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E042443EE2;
 Thu, 11 Jun 2026 07:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8B31F00893;
 Thu, 11 Jun 2026 07:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781163305;
 bh=NedeNJ8O8q2mH1LBp+XUUGW47B46q0klZNROJC8QyLE=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=MWHABnq1Z81Doo8SXmG+JKZ2J7sT8/AQa5MAtGCxGl/2WyqIiQHX76QEySG7bYqIv
 Ugh1TwXou1Y6G9FW5TwZBVPkhVHefRlIs0ydizpw6h0vIejyw2xtrfmXLRvn4+knsc
 6c4ofiZGtlTI7+XH7YOonTIYrMaMPSSHPrPHbvCv+f3p5P79OqhW+6+JxOttd3BEW9
 zyJCIrQAxSOZr20KlqKeLnpCPCXFi4vMoKh8Ded28wpXt9xIYEF4z/c6WeZCVpuOxp
 8j36hwO/EhLpmM3mUxNc7lv2T8xd5NQYVYJCw4EKhnEE3ltz/XJgmJy1w788dbSTxQ
 KsLVwcisfrx+A==
Message-ID: <a940e00a5774c8c409a9338163cd125c@kernel.org>
Date: Thu, 11 Jun 2026 07:35:02 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2] drm/tests: Move test EDID data to separate .c file
In-Reply-To: <20260610-test-edid-array-definition-fix-v2-1-9de4605c4869@collabora.com>
References: <20260610-test-edid-array-definition-fix-v2-1-9de4605c4869@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, "Daniel
 Stone" <daniel@fooishbar.org>, "David Airlie" <airlied@gmail.com>, "Jani
 Nikula" <jani.nikula@linux.intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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

On Wed, 10 Jun 2026 16:31:08 +0200, Nicolas Frattaroli wrote:
> Having the test EDID arrays defined in the .h directly will duplicate
> them across every user of the EDID arrays. This works fine as long as
> there's only one user, but may produce build warnings/errors when there
> are multiple users and not all of them use all definitions.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
