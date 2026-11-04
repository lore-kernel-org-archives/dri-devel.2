Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4D3606A331
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=bY/HWDAQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A758A10E881;
	Wed,  4 Nov 2026 09:03:48 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5716B10E881
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=iHYdHhRmbjQcxscHDcCpZ8acQ3uHnfxu23ktn4nG4Lg=; b=bY/HWDAQ7lHwSJ9XPB6FqUu/AE
 wcwm0H9izENxVo4LThMrAkZiy0MutIj7mridbKtjUB3BXxoXTqd1q6nuQFEl2B3wIxvkpluq2tK7h
 pVO6dlRzHH+P+5d1XYcb6OlVt051mRhfQYqPAY7F6utvBprm6uu6mZ5Jkx1c8k1+sl2WtTucsh2oe
 FdDM0O5rcTV0AeBawde/oLUHPdbiVLYPOsywJ1HSpzpvxwgpvZE/OR3Nj2QG/ALgcj9oj8+KU3rU6
 LUe92DhkYZlooqVoC4MNJsgAdXUVODrATFTqm9MaZKE1hxd6QqKPDda3HdNKgIyYUBK+XnkpK6b0X
 n1jdwV1Q==;
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
Subject: Re: [PATCH v2 01/11] accel/rocket: search every core slot when a core
 is removed
Date: Wed, 04 Nov 2026 10:03:13 +0100
Message-ID: <49835528.XUcTiDjVJD@diego>
In-Reply-To: <20260922080114.44662-2-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <20260922080114.44662-2-royalnet026@gmail.com>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Dienstag, 22. September 2026, 10:01:04 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Igor Paunovic:
> rocket_remove() decrements rdev->num_cores for each core it removes,
> while find_core_for_dev() searches slots 0 to num_cores - 1. Unbinding
> the cores in the order they were bound therefore loses the last one: by
> the time it is removed the search range has already shrunk past its
> slot, so find_core_for_dev() returns -1 and rocket_remove() gives up
> without doing anything.

[...]

> Two paragraphs changed from the standalone posting, which this series
> supersedes: the one on unbinding a single core now points at patch 4
> instead of saying what is left, and the round counts are dropped from
> the last one. Posting:
> https://lore.kernel.org/r/20260904125936.26234-1-royalnet026@gmail.com
> The two Tested-by tags are from that thread. The round counts were
> taken on a kernel that carried the use-after-free fixed in 8/11; they
> were re-measured with the whole series applied, see the notes on patch
> 4 and the cover letter. The single-core unbind and rocket_open() cases
> in that paragraph are 2/2 of the lifecycle series, now rebased into
> this one as patch 4:
> https://lore.kernel.org/r/20260731064933.12548-3-royalnet026@gmail.com

Seems like I merged the standalone version in [0].

The code change is the same, so I guess we'll just have to live with
the older commit description :-) .

TL;DR this has been merged in 7.3 already now.


Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D6eff1d69dae808a1518aee5a58d0853a8db3f1be


