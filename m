Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A3606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=RUBbrT/U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DBC10E12F;
	Tue, 27 Oct 2026 01:49:24 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0544710E12F
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 01:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793065756;
 bh=Wbi3NY9WnYJfeKXoxOhR70QLmxw4mM2jPoXXqAXFUT4=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=RUBbrT/UfeZQyQKecbvscc15wRIqp19C98IasaXLYH8nwqeGEVK2ly52sqBdShAbG
 RM0EUZRbamZfZAFyxfRo/GCdoaE9O1Ekzt3c3tTkwBNnwaBl89uypfNFRoughodKqi
 b4cbG+OXQXPJOjb1EWwGNkO1k9vjiBpDH9nVUUdtC+4y+OI0O/WPGxfK9tpgCmg/xY
 3mLRlzRDuiHf9Yw3oJU7DKAR1aag5Z8fcc09wG7Rsfg+DjaQIPD7kUNSGDEM+OxYhv
 IMrH6ueghpO9jyuI/GhvUg4hyfT+IETKiI2R3HpDpdKdxgHVuqiTXu60a0CbCpInPW
 eErCLtqHNyskw==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D429B17E0254;
 Tue, 27 Oct 2026 02:49:15 +0100 (CET)
Message-ID: <a6314959-1287-4381-88a0-2fbc3edbe3b2@collabora.com>
Date: Tue, 27 Oct 2026 03:49:15 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com>
Content-Language: en-US
In-Reply-To: <20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Maira,

On 10/14/26 4:03 AM, Cristian Ciocaltea wrote:
> This series includes patches 42-48 from "[PATCH v11 00/74] Add HDMI 2.0
> support to DW HDMI QP TX" [1], which convert the VC4 HDMI driver to the
> common HDMI 2.0 scrambling infrastructure as a proof of concept for
> reusing the shared code.  It adopts the shared TMDS character rate
> constants, switches to drm_hdmi_mode_needs_scrambling() and force_ctx(),
> fixes -EDEADLK handling, and replaces the driver-local scrambling
> implementation with the common SCDC scrambling helpers.
> 
> The infrastructure patches have been merged and there are no remaining
> dependencies, so the vc4 patches are now sent as a separate series,
> rebased on top of the latest drm-misc-next.
> 
> Tested on a Raspberry Pi 5 Model B Rev 1.1 (BCM2712 D0).
> 
> [1] https://lore.kernel.org/all/20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com/

This series is the only remaining blocker to finalize the infrastructure
cleanup. 

Therefore, may I kindly ask if we could get this merged, so that I can prepare
and (re)submit the last part of the original (large) series?

The only patches that haven't been reviewed/acked yet are 7 and 8. Those are not
critical, and I'd rather send them separately (together with patch 9) if that
would let us move forward sooner.

Thanks,
Cristian
