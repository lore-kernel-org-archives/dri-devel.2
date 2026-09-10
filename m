Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77304C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F4010E20E;
	Thu, 10 Sep 2026 12:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="+XA0UiRg";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3799010E20E
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=1Z/Da8tjBuPmssFnqSACSWOammFp9bJBt4p7tvLDT04=; t=1789042871; x=1790252471; 
 b=+XA0UiRgaGMmgkyJFVdBBjonMnGWWkb8bWbG+7qEfM5ris+qxy4ZIe5PoWP88gsWbVChQ1HxjIE
 AtWCyRBebRY7qNlY2Uh2h8Q+KNpAMqWTCqoYxlh6LkNSNeGmfAF5Ua7KcVbaIlNqgJIUiTVMU4YhH
 H2KQGjciELt0DdzpaZ+ctjwQxiyLwfVdXJJbfYMnb3r6tMHJp87MLUE6XRf+hTH9zv+NTRzEDXzVl
 qBmJsOMGRLAjQYpLdS7bGqgvazDYZGOirgL6CG/oOez3k56uCn2ml569ekhosxEB87zgIEAqn4GGp
 o2NQew48KawPc01XDFMN/t8l4ckh4aWMdaxA==;
Date: Thu, 10 Sep 2026 14:20:44 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dave
 Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v4 00/13] drm/bridge: tc358762: Various small fixes
Message-ID: <20260910142044.77495596@kemnade.info>
In-Reply-To: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
References: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 07 Sep 2026 14:27:55 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> While trying to get Raspberry Pi display v1.1 working on Beagleboard
> platforms, I noticed various small issues with the tc358762 driver.
> 
> The series also contains a patch to fix the timings in the
> powertip,ph800480t013-idf02 panel. The combination of tc358762 +
> ph800480t013 is used in the Raspberry Pi display module, so it makes
> sense to fix them together.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes in v4:
> - Rebased on latest upstream, fixing the minor compilation issues that it
>   brought

this sits on v7.2, not v7.3-rc
It does not apply to v7.3-rcX and newer.
Just tried to rebase my stuff for the Epson Moverio BT200 onto this
and found that this does not apply.

Regards,
Andreas
