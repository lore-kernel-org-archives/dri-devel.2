Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B96BC43327
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C1E610E5E3;
	Sun, 28 Jun 2026 11:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=yeah.net header.i=@yeah.net header.b="LJWJ7WI8";
	dkim-atps=neutral
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10D310E4D6;
 Sat, 27 Jun 2026 13:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=tw6vHd1kpotBxMS/R2XHC2hK5mWlceulqu+FlD1T30o=;
 b=LJWJ7WI8NIEqO2XToldTO86DDmhZnJ4LwRTfkTMmNKpuJUBKXZbFYXwNP2u39i
 zbs3wIi5EXoPHJEmN4V/YKSEI9Z8n6UYADzzVerCaj4/fxAFXF9JiKpg2p0UZrG/
 lBkr62UpArvUAm2BmV4xCnhCkQNT042uN+18jGK5KydHs=
Received: from zhang.. (unknown [])
 by gzsmtp1 (Coremail) with UTF8SMTPSA id Mc8vCgD3vy05yz9qcWJiAA--.32977S4;
 Sat, 27 Jun 2026 21:08:12 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: markus.elfring@web.de
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 linux-kernel@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, zhangcoder@yeah.net
Subject: Re: [PATCH] drm/amd/display: Remove redundant NULL check before
 kfree() in mod_power_create()
Date: Sat, 27 Jun 2026 21:07:03 +0800
Message-ID: <20260627130712.4339-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0d82b2ff-5451-4ba5-9a02-fec93b93484f@web.de>
References: <0d82b2ff-5451-4ba5-9a02-fec93b93484f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgD3vy05yz9qcWJiAA--.32977S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-Originating-IP: [116.149.202.60]
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiNhxsLWo-yzwqdQAA3W
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:42:36 +0000
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

On Sat, 27 Jun 2026 13:53:13 +0200, Markus Elfring wrote:
> > kfree() safely handles NULL pointers, so there is no need to check for
> > NULL before calling kfree().
> …

> How do you think about to append parentheses to another function name
> in the summary phrase?

> Regards,
> Markus

Oops!  I will send a v3.
Thanks for the review!

Regards,
Ziran Zhang

