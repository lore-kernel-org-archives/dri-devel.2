Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533E606A325
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=L/XmS78J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A208310E033;
	Tue, 27 Oct 2026 01:24:12 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F1C210E033
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 01:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793064243;
 bh=GUNzZfSn47QjR6+3HlGnMBktD45Xq2bwEqIQm3r4QF0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L/XmS78JSeNbSM0WkCRl140w6lDTbPs3lfozlZFm8BwqrzVuH3NChgQ9yB+0U4JlC
 43pfHnIRWaNVTQ9StdKqHcfPkdJwPHr/K/CKbsEuBZld4Kz6st7yUCsoTzreyGXKs8
 pyOyhZarS+hMtfl5iymgpzJZ08anN1V38p8ZKUej2b1a0SqsnUy2ArD8liDPNACYeX
 ipgejZcT6xPVYBy5eCAPb1M7amd+UFffavzrVoSicdyAjQpf3yw9kYomnCMpRQXyfy
 2wuxGBnU3Y1yX/fS8wIpHGtmmLMuc72TaoV/JdEbr2Fx+ZVHWYsD5918IP1jJWQIig
 hY/shSv8EmZfQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 65C8217E013E;
 Tue, 27 Oct 2026 02:24:03 +0100 (CET)
Date: Tue, 27 Oct 2026 03:23:45 +0200
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Lucas Tanure <lucas.tanure@neat.no>
Cc: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Dom Cobley <popcornmix@gmail.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS
 clock starts
Message-ID: <at_4EgWZFghkRHzH@collabws.localdomain>
References: <20261026164028.78792-1-lucas.tanure@neat.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026164028.78792-1-lucas.tanure@neat.no>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Lucas,

On 2026/10/26, Lucas Tanure wrote:
> HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink while
> the TMDS clock is stopped and to start the clock at least 1 ms later.
> vc4 writes the bit, and enables the scrambler, at the end of the enable
> sequence, long after the PHY has started, and clears it before the PHY
> stops. A sink that samples the bit when the clock appears never locks
> a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
> order work on the same sink.
>
> Patch 3 is the fix. Patch 1 is needed on BCM2712, where phy_disable()
> was an empty stub upstream, so the PHY kept running after disable; the
> Raspberry Pi tree has carried this since 2024. Patch 2 fixes a
> pre-existing race in the scrambling work cancel that the fix would
> otherwise make easier to hit.
>
> v1 was tested on a Raspberry Pi 5 running the Raspberry Pi 6.18 kernel
> with the same change applied, against the sink that showed the
> problem: plain enable at 4K60, 1080p60 to 4K60, 4K30 to 4K60, a sink
> reset and a sink power cycle all lock with zero character errors. v2
> and v3 carry the same code; the hardware test of the final form is
> still pending and will be reported in this thread. Mainline was not
> booted on the Pi 5. The BCM2711 path is unchanged except for the
> enable order; I have no Pi 4 at hand.

While converting vc4 to the common HDMI 2.0 scrambling infrastructure, I
ran several tests on the Raspberry Pi 5 and didn't notice any (obvious)
issues.

Hence, could you please verify whether your problem reproduces with a
recent mainline kernel?  If it does, could you also give [1] a try and
report back the actual behavior?

[1] https://lore.kernel.org/lkml/20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com/

Regards,
Cristian
