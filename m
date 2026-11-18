Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E560A2635
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=K1IYRGQP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370CA10FC21;
	Wed, 18 Nov 2026 13:41:02 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187AC10FA50
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=9g7KvO8us85H6N24ga2RiONwD8RDdkdpwC8qeCr66L8=; t=1795009256; x=2110369256; 
 b=K1IYRGQPbRMiLyxH8MUOd10nI5MKexUQj/ImS5wY22BPux2283tebiv7pOL6Nb6b/r3EDfUB+SD
 nPgx4DXd0UPI1hjFtF2TcQ1cuIE43FnCtvWzEkVyoPePbpXSdCXr1/LPk4uracRA1KY3xCntRv88r
 M9cKykHVMm3737cS3ZkOeoVdVH7rHswmdk7IPcNakT/rk87f77tqzTMSqGb+i4PVt+MXsoNOuWBsn
 rL3GYJPpUDN1MkwHpWCj5JGgeWoN04RVswBoJhdqbi6KreDpySg6kYrCHSYexdRIkXIBvXup05FqF
 OnesFC+rS2d8X9Kyo4NwPgpkDpNuLP+2ZA4Q==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xTfu6-000000011Vj-1H4x; Wed, 18 Nov 2026 14:40:50 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: mripard@kernel.org, dave.stevenson@raspberrypi.com,
 Henry Zhang <henryzhang62@gmail.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 kernel-list@raspberrypi.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: dsi: Register the PHY clock provider with devm
Date: Wed, 18 Nov 2026 10:39:10 -0300
Message-ID: <179500914537.2054070.4093937938217881883.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117234107.1298575-1-henryzhang62@gmail.com>
References: <20261117234107.1298575-1-henryzhang62@gmail.com>
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


On Tue, 17 Nov 2026 15:41:07 -0800, Henry Zhang wrote:
> vc4_dsi_init_phy_clocks() is called from the component bind. It
> allocates the clock data with devm_kzalloc() and registers the clocks
> with devm_clk_hw_register(), so both are released with the devres group
> that the component framework opens for the bind, when the bind fails
> later or the component is unbound. The OF clock provider that points at
> that data is added with of_clk_add_hw_provider() and never removed:
> after an unbind it stays registered with the freed data, and each new
> bind adds another provider for the same node. A later lookup of one of
> these clocks, such as <&dsi1 0>, would call of_clk_hw_onecell_get() on
> freed memory.
> 
> [...]

Applied with the AI-assistance note in the commit message removed, thanks!

[1/1] drm/vc4: dsi: Register the PHY clock provider with devm
      commit: db9a489077cbe9217b7bc2b47ebf0fabc5f1a56f

Best regards,
- Maíra
