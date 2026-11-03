Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA339606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=qW4r69u+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC9710E0D1;
	Tue,  3 Nov 2026 22:25:40 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F0510E0D1
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 22:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=2OtdOcSZTvSavNsYKJF99A858FVACHJIK/aEw7q35Aw=; b=qW4r69u+iZjrqMFYtfGSCEGIEF
 /OO21vzusu7a89jbOT89Z2Rw76399SnyF1HpCIXIhbYg/2u6z7uxC/NxaRVFL5MMV0KIhb/pVIFgz
 oHNB4MECzBEqwZTDnzA8FUkR8jKd6ynHgCIqD4dM+b7Y7fxa2frc3VTZIbCi8ooaDUcEiuEZxidR0
 SVsyhj3ghYQpRUDayxhFIydokOBUUbcx4jWT7YjUGSoW1vkm/OyvSqE/SAjtAOpIkx/lFDnXoJHMW
 mg+pCv8RHh8+UuNqyZKVtbKDzJEgMjjZwE/kFXVZ4Kk/MV37EukHyI228jXYb/6XLscdy1UhstWvd
 nSiv6VCA==;
From: Heiko Stuebner <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org,
 Abhai Kollara <abhai@protonmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: use dev_err_probe() for MMIO mapping errors
Date: Tue,  3 Nov 2026 23:25:26 +0100
Message-ID: <179374472348.512720.15274017145976235152.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515115335.4104438-1-abhai@protonmail.com>
References: <20260515115335.4104438-1-abhai@protonmail.com>
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


On Fri, 15 May 2026 11:54:07 +0000, Abhai Kollara wrote:
> The reset and clock paths in rocket_core_init() already use
> dev_err_probe(), but the three devm_platform_ioremap_resource_byname()
> calls still open-code dev_err() followed by return PTR_ERR(). Convert
> them for consistency. dev_err_probe() additionally silences the
> -EPROBE_DEFER noise in dmesg and records the failure reason against
> the device, where /sys/kernel/debug/devices_deferred can surface it.
> 
> [...]

Applied, thanks!

[1/1] accel/rocket: use dev_err_probe() for MMIO mapping errors
      commit: 49f40f15d20f5b4073d517da7efbcea079f1b9e3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
