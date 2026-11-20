Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FBB606A326
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.a=rsa-sha256 header.s=dkim header.b=hAH12G5b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1196510E27A;
	Fri, 20 Nov 2026 07:05:10 +0000 (UTC)
X-Greylist: delayed 727 seconds by postgrey-1.36 at gabe;
 Fri, 20 Nov 2026 07:05:03 UTC
Received: from ironport.ite.com.tw (itemail.ite.com.tw [60.251.196.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA13210E578
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ite.com.tw; s=dkim;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mXYQzIaaSv6AmSi2udnXwEZprmwNs4qcFT5JHKRMs9c=;
 b=hAH12G5bQ2UlaOx5NeJ2GMg6h0Koh4UF5Z5OI0tWBiaLKyzLiwnfo9vH
 yo6BdwhHRJ0/6BbgSUG6fYNIjkma8ICyl+ytbcoJ5GxmTEvsZSp/tcrPh
 AZzx/as8fjSpX3At0Yp3X0cvRO6lyb2d3GTVZ4MHXXpkykZBacbGVormt
 EU73YNezgPtUeNKW6Eg/Mv1UK3mSXP/f5JaOgwanUXJ+akEwrQW2v3mLn
 mj9Jdbqez1lV6r6RfY3VaCykn2ho5KE2jXCvXgAxAeoG4ZihRBJy3mxxa
 Fu/6sPyNhw0/L3r5ZbpzZJA2qwtYdiC7KaGBJBqX7qM8wA1OsYwdlveIi g==;
X-CSE-ConnectionGUID: bEqCvRHgRlWKXLF3WFlqxw==
X-CSE-MsgGUID: knnoYdR8Ss6NQAgog7IGlA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
 by ironport.ite.com.tw with ESMTP; 20 Nov 2026 14:49:46 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw
 [192.168.15.58]) by mse.ite.com.tw with ESMTP id 6AK6nfum040993;
 Fri, 20 Nov 2026 14:49:41 +0800 (+08)
 (envelope-from Hermes.Wu@ite.com.tw)
Received: from TPEMAIL1.internal.ite.com.tw (192.168.15.58) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 20 Nov 2026 14:49:39 +0800
Received: from TPEMAIL1.internal.ite.com.tw ([fe80::63c1:9095:c5a6:3291]) by
 TPEMAIL1.internal.ite.com.tw ([fe80::63c1:9095:c5a6:3291%3]) with mapi id
 15.02.2562.046; Fri, 20 Nov 2026 14:49:39 +0800
From: <Hermes.Wu@ite.com.tw>
To: <daniel@makrotopia.org>
CC: <luca.ceresoli@bootlin.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <matthias.bgg@gmail.com>,
 <angelogioacchino.delregno@collabora.com>, <allen.chen@ite.com.tw>,
 <treapking@chromium.org>, <wenst@chromium.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v8 08/14] drm/bridge: it6505: avoid division by zero in
 audio FS debug print
Thread-Topic: [PATCH v8 08/14] drm/bridge: it6505: avoid division by zero in
 audio FS debug print
Thread-Index: AQHddahmDGCOZ1R9702oMT4TMp7f/bczKViwgAHqqYCAAXcSgA==
Date: Fri, 20 Nov 2026 06:49:39 +0000
Message-ID: <da7b73e6ab2749438acd2909cc9deebf@ite.com.tw>
References: <cover.1790552614.git.daniel@makrotopia.org>
 <26ee2c94c42fb09c081201071cb5730c96c8c25b.1790552614.git.daniel@makrotopia.org>
 <179251509978.78870.2485132679226608837.b4-review@b4>
 <179481904178.211952.8076269834336042526@makrotopia.org>
 <9485b4a86b124cc3a528ca147609bf4c@ite.com.tw>
 <av8jL0W1vgdqPQhu@makrotopia.org>
In-Reply-To: <av8jL0W1vgdqPQhu@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-snts-smtp: 60F66699CD10F79D09AD0BF56ADA95C39007560D7B71D33B564E58776966AD952002:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MAIL: mse.ite.com.tw 6AK6nfum040993
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgRGFuaWVsDQoNCj5PbiBUaHUsIE5vdiAxOSwgMjAyNiBhdCAwNDoyNjoyM1BNICswMDAwLCBE
YW5pZWwgR29sbGUgd3JvdGU6DQo+IEkgd2FzIGFmcmFpZCB0aGUgYm91bmNpbmcgZW1haWxzIG9m
IHRoZSBmb3JtZXIgZHJpdmVyIG1haW50YWluZXJzIHdvdWxkDQo+IGluZGljYXRlIHRoZSBkcml2
ZXIgaGFzIG5vdyBiZWVuIG9ycGhhbmVkLiBJdCdkIGhlbmNlIGJlIGdyZWF0IGlmIHlvdQ0KPiBj
YW4gZW5saXN0IHlvdXJzZWxmIGluIHRoZSBNQUlOVEFJTkVSUyBmaWxlIGZvciB0aGF0IGRyaXZl
ci4NCg0KU3VyZSwgSSdsbCBzZW5kIGEgcGF0Y2ggYWRkaW5nIGEgTUFJTlRBSU5FUlMgZW50cnkg
Zm9yIHRoZSBJVDY1MDUNCmFuZCByZXBsYWNpbmcgQWxsZW4gYXMgbWFpbnRhaW5lciBpbiB0aGUg
YmluZGluZy4NCg0KQmVzdCByZWdhcmRzLA0KSGVybWVzDQo=
