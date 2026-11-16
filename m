Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B3606A322
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=zHQYlXy5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C1C10EF65;
	Mon, 16 Nov 2026 19:54:36 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F55810E440
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 19:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=+A+OuaSdltzVhcrF6R+QybPDg9GpacOqmis4w1L1a2A=; b=zHQYlXy56n2/30uvpOok2L7Tit
 I0Uo7H+rcViByKxP/Vd92Hzt7q+bOw6AW4IqOsxJAf4SjWKA8QqFJ8/4U9xzK8UIo4uNWP7HyFgA4
 Vw/0rybX3AQbTt7FCOXUag9Q2YS6rdwIOP5iQqjUhywi2IlBSUdask7Q/UTNFOGpv8dL24UKMmXSY
 oAMjq2B8fUMTD6ulGZAs8Ych2Ogu60g8/uy7zHMK01rApCSU2JPgSp9iGGsmtfCQfHQ7i0K0YcswE
 KyC3bLUZvkRFjL47B9/ofLkyeILbUdu4L/7k185etOjK1N4T9cND1bGwOfM/pScebc9zx1iEBgx2i
 Zc+pzevg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, hjc@rock-chips.com, andyshrk@163.com,
 chaoyi.chen@rock-chips.com, damon.ding@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH] MAINTAINERS: Add two reviewers to the Rockchip DRM entry
Date: Mon, 16 Nov 2026 20:54:08 +0100
Message-ID: <179485884330.1574718.5658745486685817821.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110101554.1809467-1-heiko@sntech.de>
References: <20261110101554.1809467-1-heiko@sntech.de>
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


On Tue, 10 Nov 2026 11:15:53 +0100, Heiko Stuebner wrote:
> Chaoyi Chen and Damon Ding volunteered to become reviewers for the
> Rockchip DRM drivers, so add them to the MAINTAINERS entry.

Applied, thanks!

[1/1] MAINTAINERS: Add two reviewers to the Rockchip DRM entry
      commit: 43ec31efbc92b2ffa2f707b04acc6d7a6173c728

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
