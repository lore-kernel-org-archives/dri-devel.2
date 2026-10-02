Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025E9CA5FD9
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BC810E2AE;
	Fri,  2 Oct 2026 07:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KwWcNgs1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9874810E2AE
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 07:45:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EA50C60A6D;
 Fri,  2 Oct 2026 07:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0764E1F00898;
 Fri,  2 Oct 2026 07:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790927127;
 bh=4pEj+dUpf/d2gtpJtogfdsGqq/vlK1UHl2zJvGkpm1o=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=KwWcNgs1MZlqMxkfT7IHQb0OgwD7uDuXfJyzPT4PoK4aierCb6akK8Ud86GORFDv3
 AeYTaWRJgaBprMblb4+8OSzCbmnQ561UFRCL3BwGU7ArdYgcmIMbGZv1UzGyVTvCSw
 BrH+8oQjNu5w6+x/NEtjGj4V0CYfvNi4Vt86NFe3RAesC8vfcabSS9YUnTgvWpqsk2
 o8kuO+P0ujBJtxcH9HgVYb9EeNa9mMTgEP6HQWZJbAKaPSjnnA6wUPGfTx3pl8/8d0
 heq3BkcD0Qsc3A3fIGSl81fovsXvgC8EhbdaLI0Fexpnk1Qd+HSAZ/xQLs87/HaJcH
 9VDQQjACNzo/Q==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfauth.ams.internal (Postfix) with ESMTP id 7A137198003A;
 Fri,  2 Oct 2026 03:45:24 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
 by ams-compute-02.internal (MEProxy); Fri, 02 Oct 2026 03:45:24 -0400
X-ME-Sender: <xms:EGG_ao84nIIcq10xNEojAybswkNjRDuAzPK8g6y_Rj5MoNxZJpy7tQ>
 <xme:EGG_arhit_jhYrvz4lnSPkVlz5C8Asx6LO543nX1kWA_1IKbVF6SLW4QXURGNcUa-
 k-3q_2kVg5zdRpAEMZQJNHm0EK4SUqo1CH5DiqfUSkq79ckJJTLpqw>
X-ME-Proxy-Cause: dmFkZTFkqu6HjImMUOMNeLbIKN4w3bg+6B0rzZnczP8X0ylnRs3MLgSfzeIYu2qbH5cZyb
 Bj2VyJyRPgPRhfGQlY39HXL7G139EP4EEHUdh6l0Wn/QcimQNWGpIfWt0UVWH8zMP3lpUK
 ez4LbVUVyWIVviWYqBYHlq52/gyKTF3eLd8kAHoe57a33p1LGn/X2FOWjFlJwUcemBor42
 98Xdk38Cz5LQNNpdGbXYydUjePzoVC3jh8U0zuLFnGUbawTFYuqSJhXrmBy0dzbJ5fZWb0
 AYAmbrf37DCnOWWlbazYPOIAVF6hSk+Cr3xdlzu25u60XCf4KhonTC8aDsttKBDIU9eWNV
 6NBwXYn2LePslm7eStEvf7j8T2HoHe+jyGr0dMFdudBfNrW2m5et70K9/TySyUNCHfnh9l
 oDReYD/YaAiHgseIOKpZa4ZP+801FbfiyYJ9zUdf6czikkKhFs653ByIszbuS4ETrl7HN+
 PdZS7TqLxGd8h+G/VHuZtH0QapgTSkSZTrxZRay+kzyBHZa2D8wG0v34DXGAxBJ02iRiR1
 Ygni2Cn4Hh3rjPoNtvH+d7ShdYI+XwrYIh0JczBkDqZTA+YZedtSE1VE9p5U0p132ynreQ
 EtlhGEJThFxig5pIWYbAoOTgFMJGI+zDGkyECUs7IQEbByXM7uJyoMNyZTNQ
X-ME-Proxy: <xmx:FGG_ajvuPZ5K4_AqhIkpf-74NH61GqjnXP4xFGh1gSVyabhuQePjLw>
 <xmx:FGG_amIMKGB6H_D1DSzkpQc2r9irEeWGZDA311vbL2tG18yucdVBjw>
 <xmx:FGG_aqMChE_8fMwucIVB6rlbURvBoZjNDTbPvIjcnt2jSUmDjX2AQg>
 <xmx:FGG_aiCHRpeqZUpVgt9iXRpCWpnFOng0CZAvLkn9mkgDToG8eSu_iQ>
 <xmx:FGG_aqWlWhyfWUpXSGhONnXV9US1aaqGAdj6cS4J_QbLOQf4jq968mMH>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id C7008F80084; Fri,  2 Oct 2026 03:45:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 09:44:59 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>
Cc: "Francesco Valla" <francesco@valla.it>,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 "Javier Martinez Canillas" <javierm@redhat.com>,
 "Jocelyn Falempe" <jfalempe@redhat.com>, "Sam Ravnborg" <sam@ravnborg.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <001eb42a-ec22-474a-83c6-371f1f4b2b8c@app.fastmail.com>
In-Reply-To: <20261001195847.141192-3-maximpedraza@gmail.com>
References: <20261001195847.141192-1-maximpedraza@gmail.com>
 <20261001195847.141192-3-maximpedraza@gmail.com>
Subject: Re: [PATCH RFC v4 02/13] efi: bgrt: export the BGRT table and image
 size
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



On Thu, 1 Oct 2026, at 21:58, M=C3=A0xim Pedraza Padilla wrote:
> The DRM splash client reads the boot graphics the firmware left behind
> through bgrt_tab and bgrt_image_size. Built as part of drm_client_lib,
> which can be a module, it then fails to link:
>
>   ERROR: modpost: drivers/gpu/drm/clients/drm_client_lib.ko: symbol=20
> 'bgrt_tab' undefined!
>   ERROR: modpost: drivers/gpu/drm/clients/drm_client_lib.ko: symbol=20
> 'bgrt_image_size' undefined!
>
> Export both. They are filled in once, early in boot, and only read
> after that.
>

Mind making these __ro_after_init while at it? Conceptually, they
already are and should be annotated as such for robustness. This
becomes more important once we expose them to modules.

Acked-by: Ard Biesheuvel <ardb@kernel.org>

