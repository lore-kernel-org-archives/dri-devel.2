Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1942606A329
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Quvh53VK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1394010E3A5;
	Thu, 26 Nov 2026 12:09:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC9F10E7E7
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:09:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 24BAC60E4A;
 Thu, 26 Nov 2026 12:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E2D1F000CF;
 Thu, 26 Nov 2026 12:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795694967;
 bh=ufox2MWoi6eY6wvmUNiQ+WJPk+WOfJe/bj+EEBIBUck=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Quvh53VKotfKSVP935WSdNQDjs4m4Z0oHKehb0sQy0Sa37eEyqCn2Y202Q7/aecva
 G+gIYaEJs7Qc79jOhraSOLUiMCVBNAq9y03iYSqRwrAi04oP3X5olkUDNiof1iB7yt
 9t9THPVp8wht4fdIUSSu41tyn7eP4jdWUcOgn++1jd2EiBx+rLoeL/xBofJRWP87eH
 snlLhJpEjR/SUiSqvdk1Q2Iba7nXJVagAxZj3kkjIjuYRwKKKfDUaNxxe1V8RcLJy6
 EP4V3ywZMqOjV/Bz4RW5inuyXPmsyLZUuN+qqMtZZGmERfup6EgedKa6cD7pRL/Jl6
 SGtc+7bK8rUwg==
Message-ID: <sashiko-outbox-235479@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] phy: mediatek: hdmi: Fix potential stale PLL provider
 on unbind
To: "Tian Xuechen" <202300460064@mail.sdu.edu.cn>
Cc: dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261126120039.4049943-1-202300460064@mail.sdu.edu.cn>
References: <20261126120039.4049943-1-202300460064@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 12:09:26 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] phy: mediatek: hdmi: missing Signed-off-by trailer for commit
  author
--

commit 718919b222e67adb9c142555372ba4fbb7f8e0c9
Author: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

> phy: mediatek: hdmi: Fix potential stale PLL provider on unbind
>
> The HDMI PHY registers its PLL with devres but leaves the OF clock
> provider registered on unbind. Publish the PLL hardware through a
> managed provider so it is withdrawn before the PLL is unregistered.
>
> This issue was found by our static analysis tool under development.
>
> Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
> Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>

[Severity: High]
The commit author is Guangshuo Li <liguangshuo@mail.sdu.edu.cn>, but the
commit message only carries a Signed-off-by trailer for Tian Xuechen.
Under the Developer's Certificate of Origin, a matching Signed-off-by from
the patch author (or an updated Author header) is required.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126120039.4049=
943-1-202300460064@mail.sdu.edu.cn?part=3D1
