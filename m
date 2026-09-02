Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDDAC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02AB10F282;
	Wed,  2 Sep 2026 15:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="OXXp5E1u";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1FC10F282
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788363667; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=A+HMN+VO6bQYPSJYUhLIKM1Ib0z/aMMe5fClP58/ewqiEwbFsdug+bdvgRTnJtCJi02ay03icG/vjgD39s5GblcNEtvkMXWCLyvNK2TjwFcPaD4cNggjvYbva3Y8J9dWfnexG8BsalGQOJrryJf7czq675fJlAa1QKOwOIq9+Gg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788363667;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GLRqxEA1j3qsKDMBpPBCle1jQb1ik50lESvxhCezIpQ=; 
 b=X+a1aNU6K7/aWW48eR3AbjcZ+mZmFE+Wc1MLNSIl+eBeL/cQ1OjTB2AtAWwIwwFqprBOhvcFEF/Pd+OjjUncUsPCs78UClHvnm7aCeKgrftJ3UMiJhEQ6WxcTyAqDT+4difUnyM3IFu8kpPcp9V4z83SYh7VqcIeohYPBSbYoYk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788363667; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=GLRqxEA1j3qsKDMBpPBCle1jQb1ik50lESvxhCezIpQ=;
 b=OXXp5E1uCYJv7VQdUFYTP6MgnT8TUCZvZ774m6c/0qrEsGeWMYKohmF190453J28
 7dVzUL3+/1sbs9lR1RvcV2f/Ok0xZiQPQC3R9sjkGs6Z8hcO2C7L4ScE+Wv0FVv4qLH
 H2xI6EaMjZtU1UygVpq4T5cNPUEm/BMKH9PmUarY=
Received: by mx.zohomail.com with SMTPS id 1788363666107106.95548277591911;
 Wed, 2 Sep 2026 08:41:06 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:41:00 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 06/17] drm/panfrost: Consolidate device clock
 management and reset
Message-ID: <aphDfbyk2023fGQw@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-6-72a13b2c125d@collabora.com>
 <20260901143803.22ae33c4@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901143803.22ae33c4@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.352.18
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

On 01.09.2026 14:38, Boris Brezillon wrote:
> On Fri, 28 Aug 2026 21:56:46 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Gather all clock enables and disables into a single function to avoid
> > repetition. Also, as part of the same function, handle reset control
> > (de)assertions, since that was already the case in the PM runtime
> > functions.
> 
> I think I'd prefer to not mix clks and reset-lines. So basically, a
> set of helpers that deals with clks (panfrost_clks_{enable,disable}()),
> and manual calls for the reset line.

Acked, will do so in the next revision.

> > 
> > Also do clk (un)prepares and dis/enables at the same time, since the
> > clk_prepare_* family of functions can simply increase the refcnt of
> > an already prepared clock.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Adrian Larumbe
