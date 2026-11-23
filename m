Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B1606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=ROaEf9fG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C628C10F304;
	Tue, 24 Nov 2026 08:39:45 +0000 (UTC)
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A312910E038
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795455714; cv=none; d=zohomail.eu; s=zohoarc; 
 b=SwreKrU3R4DY5UQLmxROrMTAvJOzV/bwy1uuct9TMHcJUdUJpWZdG4gEz4KaLfNI5D/7ld90JoIM2A9iBDHIT2k8f3/56g4fwn+1SjuwLHw2MzOm2J2Kmaihy71CspObQaFmDHD3gyDbGqmkWMmnrw3JdsKrAI5r7FxyteusvSA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1795455714;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Wm4D2R2fUZcmyfdUwMn9Zrbt21Lpi8FA50NzkPSXeJk=; 
 b=Zo6r7cdYaLdgg5Tn9B1qBjoHM0yvdYKpb3+YlXkId9vOgnFJyafJtPY3oANQpi7WOK+L05F1C/sb/XsxWZdRHYy+8nN6p7UO2TPYZM+OPnxQ8dkBreg9Lgw270p+QWWIF0B47Ho41x/Okkw+9v47gwxVxeUBRJb1qqPJ+eXBwjA=
ARC-Authentication-Results: i=1; mx.zohomail.eu; dkim=pass  header.i=iav.lv;
 spf=pass  smtp.mailfrom=iav@iav.lv;
 dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256;
 b=ROaEf9fGu9dgnJESKk7Pq+FC/c3IEsHSaFpIRF6suDhiDwHvAsC7hdJ4NYMkH6AhU504mikDfbSfwu30qklszRLOEvphSa3SQMkFt7ewLIGi7BbvAEOIxnbCVIbhMAIWWw5hZfygAECqRgJZbUi1ZcPuflRNFR8mFOPGo8CxlK8=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=Wm4D2R2fUZcmyfdUwMn9Zrbt21Lpi8FA50NzkPSXeJk=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795455713979281.6369456863033;
 Mon, 23 Nov 2026 18:41:53 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Steven Price <steven.price@arm.com>
Cc: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/panfrost: Gate the RK3399 GPU clock in runtime suspend
Date: Mon, 23 Nov 2026 19:34:34 +0200
Message-ID: <20261123-panfrost-rk3399-pm-rt-price-reply-1@iav.lv>
In-Reply-To: <a9a404e8-66fc-4595-9d14-7ab97cd08583@arm.com>
References: <20261030-panfrost-rk3399-pm-rt-v1-1-e94437159a9d@iav.lv>
 <autNWETrwrHbD2H9@sobremesa>
 <20261104-panfrost-rk3399-pm-rt-larumbe-reply-1@iav.lv>
 <a9a404e8-66fc-4595-9d14-7ab97cd08583@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/11/2026 15:29, Steven Price wrote:
> Other than the somewhat confusing commit message (e.g. a subject of
> "Enable GPU_PM_RT for RK3399" would be clearer), this is fine:
>
> Reviewed-by: Steven Price <steven.price@arm.com>

Hi Steve,

Thanks. v2 went out a day earlier with the same code; v3 [1] is
retitled as you suggested and carries your tag.

[1] https://lore.kernel.org/r/20261123-panfrost-rk3399-pm-rt-v3-1-04c7c58d1140@iav.lv

--
Igor Velkov
