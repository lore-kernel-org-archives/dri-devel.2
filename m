Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AFD606A333
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qs2qTNaU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C58112C31;
	Fri, 27 Nov 2026 17:01:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD472112C31
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 17:01:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDB3762361;
 Fri, 27 Nov 2026 17:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B061F00897;
 Fri, 27 Nov 2026 17:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795798901;
 bh=lCDljj3wqT2J645H5FJPnLcwZAVCPzo4a/dMK7Mj2yQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Qs2qTNaUEW4tdXP1qrDm3MoVcCegOA1yzJgMfvXD1f0mPTX9GEdsEFo5teTrUySWV
 fBIJVCg2QDaIFhB8FaSE7kyJwk5tHGwpOYVo63gPSpT5vIwT7naYp39QJUrCORrGcO
 2C/zaKByRtjc8f2CbF5BmOut3S0braDsHQ+aW8oDLNT3UTpgjum744ot4KuHgV2exV
 D0b8W0s74b707LHHrJ0EGz8H39E8N+zVQpPRgXyMQ95n7249yY3ildYWz+SOqUcD81
 HHvH8pFQnO3jLju/u2Y1EfGZofT/XMsmJFOkIdBMmgXJNJIxS14DjOd9l0M3zj5ki3
 YmRhThdgElUyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
 Daniel Drake <dan@reactivated.net>, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Thomas Zimmermann <tzimmermann@suse.de>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: Re: [PATCH 6.18.y] drm/gem-dma: Support dedicated DMA device for
 allocation and mapping
Date: Fri, 27 Nov 2026 12:00:53 -0500
Message-ID: <2026-11-26-1-daily-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124140251.4131801-1-mcanal@igalia.com>
References: <20261124140251.4131801-1-mcanal@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Add support for the dedicated DMA device to the GEM DMA helpers.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
