Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636EE606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=mJ3AvM7L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A9D10F257;
	Mon,  9 Nov 2026 12:39:31 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E70010F257
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=n9bGePk9lrw7xV7HE6vQIA1MU1oWUPB9VGc2zWRd4WM=; t=1794227965; x=2109587965; 
 b=mJ3AvM7Lt1meTLXzfQusyWvhN5aBPylmeUglCZplbtQCLazz9tDSbnewI8CoOHgmz/DfYE5DU/A
 9WS/Y6mfAIYt9R9Zw0m/zYpld9Nw7of5AR4TVqVOFTNBArBQ4EjB2z99ZlPFJXBv5hrROhzJ+0tL7
 xytI0bw1eQBUxdzFo/Qnqbgr1P8r9O8O7PYljqSVKLG5lUO3piwI/ikk/MpxS1U4tXcV5Pg1kUlgS
 IwG9q1kuXtC39kPKMqubyGBd3+4Jkj2OvIWwujUgyv8d7JYHfaWcZNFaxeG8kxzb/vbs+VVz8USoH
 rx8b59l0s+kDGs63dVBsm8kOfMrJHwv8fppQ==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xQOea-007Gqw-OE; Mon, 09 Nov 2026 13:39:17 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: airlied@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 dave.stevenson@raspberrypi.com, dri-devel@lists.freedesktop.org,
 kernel-list@raspberrypi.com, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, stable@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Fix firmware reference leak in vc4_hvs_bind()
Date: Mon,  9 Nov 2026 09:38:46 -0300
Message-ID: <179422792408.2740537.1643509391861817980.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106092016.2282805-1-vulab@iscas.ac.cn>
References: <5f80ac77-c1f4-42cc-bdcd-e4222f72d853@igalia.com>
 <20261106092016.2282805-1-vulab@iscas.ac.cn>
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


On Fri, 06 Nov 2026 09:20:16 +0000, Wentao Liang wrote:
> The firmware reference taken via rpi_firmware_get() is leaked when
> either of the devm_clk_get() calls for the core or display clocks
> fails, as both error paths return without releasing it.
> 
> Fix it by moving the firmware lookup below the clock lookups, so that
> the reference is taken right before the firmware property is read and
> released immediately afterwards.  The rpi_firmware_find_node() call
> moves with it: the device node reference it returns would otherwise be
> leaked by those same error paths.
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Fix firmware reference leak in vc4_hvs_bind()
      commit: af200e91c7b996177aa90981b2f0e794b085d43a

Best regards,
- Maíra
