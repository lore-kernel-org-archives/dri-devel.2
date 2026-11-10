Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30329606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=FiNvcPRL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9446610E1C7;
	Tue, 10 Nov 2026 12:48:51 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB27710E1C7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794314923;
 bh=7wwMww4yCB31QVSkiplgT0aOfc1KXC3ISCzbDNSdBdE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=FiNvcPRL4Q9c26/GdRuyWhKVtLZwsg/wxRGqyg8p8iZSA1JnZbvszJVbnqfQDLoom
 n/AsJRTyYYNc1/rWI95hpQ9pBqxfeEOtEpW1X5ahPMsTWCBFikxDPExQlVD6uawNHd
 hrpi1PLT4IqdpNs87BF2kF5veCOYspeNBkv4pWiyMKZoVTa+FGghJx1nudfNFEM/kO
 pBPZJJMtINTSYc03JMTi1EZRdC7lqSUpRg3TBp3Opd2318agYb7o3a73AlBiMM63Ao
 Mllw64ZqEEBXJ4YkQmbdBK8FJbkemn9+bGFbnAcwybEevxLKs7rfwNIn1QCJaSvltC
 TwhSxo2vstr6g==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E112717E003A;
 Tue, 10 Nov 2026 13:48:42 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Lucas Tanure <lucas.tanure@neat.no>, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261110-vc4-common-scramb-v4-0-eaa141a0da0f@collabora.com>
References: <20261110-vc4-common-scramb-v4-0-eaa141a0da0f@collabora.com>
Subject: Re: [PATCH v4 0/9] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
Message-Id: <179431490625.565535.8973973008684301876.b4-ty@b4>
Date: Tue, 10 Nov 2026 14:48:26 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-36e3f
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


On Tue, 10 Nov 2026 02:13:37 +0200, Cristian Ciocaltea wrote:
> This series includes patches 42-48 from "[PATCH v11 00/74] Add HDMI 2.0
> support to DW HDMI QP TX" [1], which convert the VC4 HDMI driver to the
> common HDMI 2.0 scrambling infrastructure as a proof of concept for
> reusing the shared code.  It adopts the shared TMDS character rate
> constants, switches to drm_hdmi_mode_needs_scrambling() and force_ctx(),
> fixes -EDEADLK handling, and replaces the driver-local scrambling
> implementation with the common SCDC scrambling helpers.
> 
> [...]

Applied, thanks!

[1/9] drm/vc4: hdmi: Use common TMDS char rate constants
      commit: 946fe5be9731d31e703f8d003c735dd85fcdc0fa
[2/9] drm/vc4: hdmi: Switch to drm_hdmi_mode_needs_scrambling()
      commit: 0ed2309a731a53c712442ba7379723023b6b7582
[3/9] drm/vc4: hdmi: Switch to .force_ctx() connector helper
      commit: 2cc4f77ac0a865a4bb0a7a0d2408545d43222d67
[4/9] drm/vc4: hdmi: Propagate -EDEADLK to the top level
      commit: 64d51eeec09f14af2fbadff3db1c9fa67403da07
[5/9] drm/vc4: hdmi: Convert to drmm_connector_hdmi_init()
      commit: 9a20b50406fd58bb557ba4cde8dfdbbb415acd34
[6/9] drm/vc4: hdmi: Convert to common HDMI 2.0 scrambling infrastructure
      commit: 1ab014b2002d05d68b8f86eeae7e4c1da7148b2f
[7/9] drm/vc4: hdmi: Clamp CEC clock divider to its register field width
      commit: 2d371302c633487482dd3ca510dbb26d01383a3f
[8/9] drm/vc4: hdmi: Bump BCM2835 max pixel clock to 165 MHz
      commit: 797dbdf80f7fa104b32216891aec9184308fe95b
[9/9] drm/vc4: hdmi: Defer pixel clock validation to HDMI helpers
      commit: 1116f4aee916ca13d3e40ce87e67835f51576fcb

Best regards,
-- 
Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

