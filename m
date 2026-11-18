Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85BF606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUpqBtz9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093EC10E708;
	Wed, 18 Nov 2026 01:31:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9920810E708
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:31:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 467DF612E2;
 Wed, 18 Nov 2026 01:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C121F000C4;
 Wed, 18 Nov 2026 01:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794965491;
 bh=hxu0Kog6fvOVhGHwXrl/5dON3Cga6+iVACXUigGeFls=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JUpqBtz9yGFNz59lhd9NsgIErbHPPStkr/DbfUaaCFRd312w/22s4SsxoqbRoppmI
 ESmlzTR9V2eVCPIll2zpLTLbfNOokhf2rX55nS3AhvZa5SooqFbEnRJehtpcNoHWwv
 j4djhAJ9sa0WgkukVG2AUADb3hq4f6QgmuQeYoCoqdvb6Z2le5hevpRq6AwKn73AD9
 hfBeXd81GpvnrLysQU4lVLKOyV7VskQWq8s1gQeQWlz+zoX8XnNNR+dC/E2u4NJBR+
 WpH7nIIVbfcTvWT5cfe+RCr7j2KN0EPgQHcLAik+jhEu02VZFlqljrud1a8yWQPIyb
 SMHkbn2KLXIWQ==
Message-ID: <sashiko-outbox-219903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: macmodes: compare the pixel clock of each
 candidate mode
To: "Tim Douglas" <me@timdoug.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118012557.79419-1-me@timdoug.com>
References: <20261118012557.79419-1-me@timdoug.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 01:31:30 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] fbdev: macmodes: missing Fixes trailer for mac_var_to_vmode()
  bug fix
--

commit a5693e36289da1dfee41e154db2fb9b39fdc0554
Author: Tim Douglas <me@timdoug.com>

> fbdev: macmodes: compare the pixel clock of each candidate mode
>
> In the second pass through the mode table in mac_var_to_vmode(),
> the requested pixel clock period was compared with the first mode's
> period at every step. The last mode at that resolution was therefore
> returned even when its period was too short. Compare against the
> current candidate's period.
>
> Tested on a Performa 6200CD using a kernel with local platform
> support. With video=3Dvalkyriefb:vmode:10 (800x600 at 60 Hz), the
> measured refresh rate was about 72 Hz before the fix and 60 Hz
> afterward. At 640x480, 67 Hz was also selected for a 60 Hz request
> before the fix.
>
> AI assistance was used to investigate the mode-table walk and draft
> the fix.
>
> Signed-off-by: Tim Douglas <me@timdoug.com>

[Severity: Low]
Since this fixes the second-pass pixel clock check in mac_var_to_vmode(),
should this include:

  Fixes: d876c11a0fd4 ("fbdev: mac_var_to_mode() fix")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118012557.7941=
9-1-me@timdoug.com?part=3D1
