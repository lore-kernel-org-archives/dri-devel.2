Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490FECD4F21
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 14:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DA910E274;
	Sun, 17 May 2026 14:15:06 +0000 (UTC)
X-Greylist: delayed 596 seconds by postgrey-1.36 at gabe;
 Sun, 17 May 2026 14:15:04 UTC
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
 [83.223.95.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E019B10E265;
 Sun, 17 May 2026 14:15:04 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f1c:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout1.hostsharing.net (Postfix) with ESMTPS id 7177D35F;
 Sun, 17 May 2026 16:05:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 5462D60163BA; Sun, 17 May 2026 16:05:06 +0200 (CEST)
Date: Sun, 17 May 2026 16:05:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gilles Risch <gilles.risch@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/radeon: fix internal display on iMac11, 1
 (RV770/DCE3.1)
Message-ID: <agnLEk44qr-bL9K1@wunner.de>
References: <20260510185426.4264-1-gilles.risch@gmail.com>
 <20260516092420.3579-2-gilles.risch@gmail.com>
 <agiy9II5jkHEgPAq@wunner.de>
 <d5262f65-22b5-4ff3-b905-12bb2a4b587d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5262f65-22b5-4ff3-b905-12bb2a4b587d@gmail.com>
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

On Sun, May 17, 2026 at 03:53:51PM +0200, Gilles Risch wrote:
> The test robot mentions that it cannot find ASIC_IS_DCE31(); this is because
> both patches build on one another. Should I submit both patches as a series?

Yes, either that or wait for the first patch to be applied and show up in
the drm-next repo.  Then 0-day should not complain.

Usually people are annoyed if patches are resubmitted in short cadence,
so the polite thing to do is wait for 1 or 2 weeks before respinning
so that people get a chance to provide further comments.

Thanks,

Lukas
