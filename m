Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE754606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 00:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=UB1zumQy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14FF510E0A5;
	Tue, 27 Oct 2026 00:32:03 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568A110F1E5
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 00:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=LuZ8J1+EwnqAJ3eIOk678dN7X6UdAOavNda5TEGSsog=; b=UB1zumQyGAcYFjtAdXFujXnKET
 8V8B4xQf+mw+QNBOF08xM+Y9Nj06E51vKrPYPiG6ujvbgDzMPLd9o+TWzQgzDkHFZ4T/qX2W6QeUI
 J/tLb7SRqeUdbfH53fQQVATCwYim5mrl35K6HufvfRlsYaF9Dchb3SFEIOPjFrslhqNmbvB8Ob8QS
 naE/Awh0zdkmDNwTHlCwOI/QTEw3FEMqpbcRHd0kv4HVvArkhpMkvAajiKzdlaOegCS6IyS3sg7QK
 2DzcWRtsKVdpIGSs9myYWScMbQDkake3ABuZoib18wiWsrhRO6yhSgM5l1uM6WP3gRT1XlRTYLdYr
 KQsTm0zg==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xLV6X-00BEaf-BM; Tue, 27 Oct 2026 01:31:53 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/3] drm/v3d: Add TFU constant colour support for V3D 7.x
Date: Mon, 26 Oct 2026 21:31:32 -0300
Message-ID: <179306108786.1455836.7471392756978461071.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021-v3d-tfu-ccol-v1-0-4c99240cca28@igalia.com>
References: <20261021-v3d-tfu-ccol-v1-0-4c99240cca28@igalia.com>
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


On Wed, 21 Oct 2026 11:55:29 -0300, Maíra Canal wrote:
> The V3D 7.x TFU can fill its output with a constant colour, which lets
> userspace offload buffer fills to the TFU. However, so far, the kernel
> didn't expose this hardware capability.
> 
> Expand the UAPI to obtain constant colour data from the userspace and
> configure the CCOL0-3 registers.
> 
> [...]

Applied, thanks!

[1/3] drm/v3d: Validate the v71 fields of the TFU submit ioctl
      commit: 631673a0c24ffe8191f184c596e3a5bd30a6cf6f
[2/3] drm/v3d: Only program TFU coefficients when used on V3D 7.x
      commit: 14e47054d77a28e6e39da634505e48d95c9884b5
[3/3] drm/v3d: Add TFU constant colour support for V3D 7.x
      commit: 731ba09867520c047c7de53f92e384808e0b638e

Best regards,
- Maíra
