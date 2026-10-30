Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B5606A330
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=qbXUnsaY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA2F10E0C6;
	Fri, 30 Oct 2026 13:15:24 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C3B10E0C6
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=+2nvKM88jwoLfLwwyKqMT179aru67saPys7pTH9M+hw=; b=qbXUnsaYgGJOKfhy4lCxY4koQE
 ApDfE9QjUvUWKCd6RJ0OLR/qfKLzgHi6TGSwEVRh/qXkKQnpRAguHcNN3ccGRVeKPVVHO3veK7zeY
 wakKwef63z3j13AauGS0WDZnDPNjv6ZgGVFjfcLydZ0+XfjvUJ80Oknu4ApmCqdi99xquCV5DJG7K
 xwhPKVHtg60jR+FberxrUCX3IUfIJzWFcjmJD14i9RbPXhl3Cig3Ub6bQuOZoIp18NyfvV77B6QWt
 g1XLhwgCwkySfAbihuxHfDMJd9TB0yFZN3QwzkjGgx57wTBl4XQsz5zEV2zGasisC9ExMeTp27bPB
 88PbPhzg==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMmRi-00Ezw7-59; Fri, 30 Oct 2026 14:15:02 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Lucas Tanure <lucas.tanure@neat.no>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Dom Cobley <popcornmix@gmail.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS
 clock starts
Date: Fri, 30 Oct 2026 10:13:48 -0300
Message-ID: <179336602325.1953359.580164990520983023.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026164028.78792-1-lucas.tanure@neat.no>
References: <20261026164028.78792-1-lucas.tanure@neat.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 26 Oct 2026 16:40:25 +0000, Lucas Tanure wrote:
> HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink while
> the TMDS clock is stopped and to start the clock at least 1 ms later.
> vc4 writes the bit, and enables the scrambler, at the end of the enable
> sequence, long after the PHY has started, and clears it before the PHY
> stops. A sink that samples the bit when the clock appears never locks
> a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
> order work on the same sink.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/3] drm/vc4: hdmi: power down the BCM2712 PHY when the output is disabled
      commit: a59a60e6e9e3a1d5177b28577d935d5ee37ace66
[2/3] drm/vc4: hdmi: always cancel the scrambling work synchronously
      commit: 2e47848f0d076dec66df3bc403214073cd2214ac
[3/3] drm/vc4: hdmi: enable scrambling before the TMDS clock starts
      commit: 81383bd290a18f06ccf9b0bfb29e1a3ef73d9357

Best regards,
- Maíra
