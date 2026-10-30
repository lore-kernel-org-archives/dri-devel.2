Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7FB606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=andres.codes header.i=@andres.codes header.a=rsa-sha256 header.s=protonmail header.b=FlbJDvrz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DB410E9EA;
	Sun,  1 Nov 2026 11:58:13 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9867110E240
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andres.codes;
 s=protonmail; t=1793385413; x=1793644613;
 bh=hQWb7TJsKWyoKe+2xRhxz4iuPIx/iKeV4EOEe75oHAY=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=FlbJDvrzu33nzhrIMp5epSrskjuDi5oIlM0QpGFHcmJZguAuUTCvL+oe/Jp3xP5jW
 dWOhrIHb/XGuLMnGK3Ikoboy8ntSBsYqkPrIUF2jdHKEW0afKlceiqLFQqAlMrIpTv
 UmzwwAdA+niUtUxVnPDm1smGiWbBkhC4a/UUjv+63yPBT9hBY1AQrVSDX7LiKkwObi
 W0zEwgkAC5lcqY9yGZk/fYFvkZ7s7/ukeo+o13C6XhplHEvuh8EIBUG4B8F+MWBfLj
 U0Q/idNMLO4IN702cPfZxjWTV1EsLK3HKCz+Jkb1ninsurGHeA+iJQnyu9e8P0a03v
 LCq0V4kSsXHmw==
Date: Fri, 30 Oct 2026 18:36:47 +0000
To: adrian.betschart@cinemaone.ch
From: =?utf-8?Q?Andr=C3=A9s_Rodr=C3=ADguez?= <hello@andres.codes>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com
Subject: Re: [PATCH] drm/amd/display: Apply the HDMI RGB range default only to
 HDMI signals
Message-ID: <20261030183450.31119-1-hello@andres.codes>
Feedback-ID: 74930084:user:proton
X-Pm-Message-ID: 116c1e407ddbb85253cb08b2e3ab49f6b92ff6c2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 08:45:58 +0100, Adrian Betschart wrote:
> Require an HDMI signal as well, as the original commit intended. DP++
> passive adapters drive an HDMI signal and keep the HDMI behaviour;
> native DP, DP MST and active DP-to-HDMI converters get full range again.

Tested on v7.3 with an RX 9070 XT (DCN 4.0.1) and an ASUS PG42UQ on
native DisplayPort, 3840x2160@120, Broadcast RGB left at Automatic.
The monitor reports full range again and blacks are correct.

Tested-by: Andr=C3=A9s Rodr=C3=ADguez <hello@andres.codes>

