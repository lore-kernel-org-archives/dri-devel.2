Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CA5606A32D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=l+XOTufO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D7210E859;
	Wed,  4 Nov 2026 09:54:45 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E7910E859
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=Cw/AEA9RUly+lbDRITFDwUsGwTqIHV3epLm2bzHHVIE=; b=l+XOTufOEsoX4h44xsZUeQJd9y
 UQVDTH1ZcIwsjWzDG9IAhHZZZROudzxDmWTRe5fqxP9BNQHxaefTD7xe0xXAh4yv6Rl/ylkjgSZxR
 LUFNPOSonghfbKOtC13S7/DdNMQR0ETOrTCFkr+4TT2zDhj2oYeY1GSun7OholDrhGQTOzHa3PgP7
 DqltQo4KF2KUZeQRaOrWsndiEP1eIVultVov0khVdbYyT85U/m1nh9ZInru8Ei8lmOK26bFB8Y6Oh
 AvKNrRTTtZIEUMXouprbvAyoZjJ3pBFNBrvyzgWBn51Muil4I2Ya3HaOC3W3sq6TPM8kVURpOI65E
 0zkY4ZCw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Igor Paunovic <royalnet026@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?B?SMO8c2V5aW4=?= BIYIK <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v2 03/11] accel/rocket: search every core slot when
 looking up a scheduler
Date: Wed, 04 Nov 2026 10:54:26 +0100
Message-ID: <3950609.VQhiAETyHQ@diego>
In-Reply-To: <20260922080114.44662-4-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <20260922080114.44662-4-royalnet026@gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Dienstag, 22. September 2026, 10:01:06 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Igor Paunovic:
[...]
> Search all the slots that were allocated, the way find_core_for_dev() now
> does. A core that is still bound is then found, and the two callers get
> the pointer they already assume they have.
[...]
> ---
> Unchanged from the standalone posting, which this series supersedes:
> https://lore.kernel.org/r/20260905150432.7477-1-royalnet026@gmail.com

not to self: I had applied the standalone version for 7.3

Heiko


