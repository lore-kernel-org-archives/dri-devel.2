Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8AC606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Wmgl2w+X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36036112552;
	Fri, 13 Nov 2026 11:22:17 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06F8112552
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 11:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=g04SOYmzklvge6qxNQH5eg0kIpI49Svgnw/i8VcIyqE=; b=Wmgl2w+XvtWGckmCuoRoG5OllI
 tGDVKCzWK2RRDqtu0qJaA5E973VmfiepWjZJCsbCaGUVaQW/ruaOh8lEoUakcEv4c97U1dijQTkpL
 Zm/aCRqgaet+L9FS95Vc1YOwyL+x+QFcIxOa/AX9QnqPb9LXRzYSee4NkXeDZA+n7FjV9rfBRmkRe
 G2mIz9O9MCioFTZW/PseerarAV0rFGM8kyiQUxicV+j1VNkBM/JzYTzkl3pBPfyQoW/elAGeesodr
 IMfd2XG8eWooY7SF1MFSyyg6m+vCo5QSXeIFyJ+TGCpBKRZSO845HC1fHNcsWJkKAnOy8VR4zL3Ts
 mwRwyY+w==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: royalnet026@gmail.com, dri-devel@lists.freedesktop.org
Cc: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 tomeu@tomeuvizoso.net, Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v2] accel/rocket: request the core clocks by name
Date: Fri, 13 Nov 2026 12:22:08 +0100
Message-ID: <vdyoxwjeQRquzXX4VbEghg@sntech.de>
In-Reply-To: <20260831080356.80952-1-gahing@gahingwoo.com>
References: <20260729130743.128876-1-royalnet026@gmail.com>
 <20260831080356.80952-1-gahing@gahingwoo.com>
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

Am Montag, 31. August 2026, 10:03:56 Mitteleurop=C3=A4ische Normalzeit schr=
ieb Jiaxing Hu:
> Hi Igor,
>=20
> Heads up before you see this patch arrive as 01/14 of my series.
>=20
> Tomeu asked for it on the v10 cover:
>=20
>   "Sashiko is not reviewing this series because it doesn't not understand
>    yet prerequisite-patch-id. Can you please resubmit the series with
>    Igor's (presumably) patches bundled in it?"
>=20
> So v11 carries it as 01/14. Unchanged, under your name, your Signed-off-by
> first and mine underneath as the person passing it on, with the four tags
> it has collected.

just citing here too, what I said elsewhere
https://lore.kernel.org/all/13701281.ZYm5mLc6kN@diego/


additionally, while reading the followup patches, please introduce some
constants for the indices. ROCKET_CLK_ACLK, ... or some other name.
Because when you access them later by index, that makes things harder
to read and follow (especially in the future)


