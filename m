Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4640606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=o8Aspt50
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0457210E6C4;
	Sun, 22 Nov 2026 22:04:01 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B2E10EB08
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 22:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=wx3P+dKo4GM43A7D066wIsRvaq0/Fqq2FMKb809nRkY=; b=o8Aspt50Btrcq59EN1EuJxGvAC
 7/DZqL56mUJ8ZIML79qYWp+JQz1VwTTmWVUNzScFzs1lypU/JdXJbBPHxE4Lb7kidXyAYr1tiDlKv
 VMZdeicvXQoQR8mVKYLdj2n1+rVF8mJkLh2+FmU4Ru70NyZC4ugsbA12XwPZYRziHSLpxYIW0HQKv
 JJO4TIa1sBvgh9tEyOeXglZPCS4JZ8TiY8Kn7lycMfx3pHfc/eso/lvOMYmzcqj0X83wSijRqcTpg
 /4xsHY46QzkbAqt58b2CDkln0RCTbsicY3RyIFxTbc8xJQJDUwSo9qHGzkvqBqgq4Fw1bd8OTYoz4
 yL3WG0uA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andy Yan <andy.yan@rock-chip.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: rockchip: Allow single 'port' node
 for DP input port
Date: Sun, 22 Nov 2026 23:03:35 +0100
Message-ID: <GHrf8KahSYaDLPGqb0rYhw@sntech.de>
In-Reply-To: <20261109184759.467215-1-robh@kernel.org>
References: <20261109184759.467215-1-robh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Montag, 9. November 2026, 19:47:58 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Rob Herring (Arm):
> Existing RK3399 users have only a single 'port' node. This was common bef=
ore
> connector nodes were defined. Allow for this since there are already stab=
le
> users.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


