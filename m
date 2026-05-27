Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DB5CD6E43
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 19:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCB410E986;
	Wed, 27 May 2026 19:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PNRyHXT1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1722810E986
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 19:49:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E998605A8;
 Wed, 27 May 2026 19:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0170A1F00A3D;
 Wed, 27 May 2026 19:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779911380;
 bh=RH+3FisZihLI78Vcaiatt7xW/7ToH+vAU53c73eVHcc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PNRyHXT1j3ul9W/Rvz8Cr3GjHayP3KPKeatJzOjgi04b4YUPkAu36t+0fRU7leIE6
 qf0GRbFz7IUDIg2fxzIrxb9vmMLzo8kMT2LfSY4EnfC3ufhx0iw/o7yuu+EYVFlh7V
 MO/wDe5iix1VZt9mdoIHlGJx1DvW1bIla3mNRN4Vi0nssVu/eAN2MHFLxl/7oVGNZR
 gZPpym8ryAtPVVi4UU/VsLpmaXXFFLJ9u7gtIlRfxLWlISCr/0/1pB3sVBAa58VQ/c
 6JvmZ82ce6zm8YCK0N9n+ojkm+R1R0J0J0/JqKtBv+NIL3FH1DZL4dM2N5yc2a9Tbq
 jXTxmnqv0pK5w==
From: Sasha Levin <sashal@kernel.org>
To: Alessio Belle <Alessio.Belle@imgtec.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, Matt Coster <Matt.Coster@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 Frank Binns <Frank.Binns@imgtec.com>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] drm/imagination: Synchronize interrupts before
 suspending the GPU
Date: Wed, 27 May 2026 15:49:12 -0400
Message-ID: <20260527-agent5-item008-imagination@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <08d2dcf562adb5dcc2153dbbb97dbdf16dfdbc84.camel@imgtec.com>
References: <20260522-sync-irqs-6-12-v1-1-b0ecc9675078@imgtec.com>
 <20260524-stable-item014-reply@kernel.org>
 <08d2dcf562adb5dcc2153dbbb97dbdf16dfdbc84.camel@imgtec.com>
MIME-Version: 1.0
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

> >   - Signed-off-by: Matthew Brost (the upstream maintainer SoB that
> >     landed the patch upstream)
>
> For this last one, I assume you meant Matt Coster?

Yes, Matt Coster - sorry for the typo.

> > Could you send a v2 with the upstream trailers (Reviewed-by, Link,
> > SoB, both Fixes:) restored?
>
> Done now, with the assumption above.

Thanks, v2 is queued for 6.12.y.

--
Thanks,
Sasha
