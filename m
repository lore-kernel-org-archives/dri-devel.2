Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D05CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9ED10EA39;
	Mon, 28 Sep 2026 13:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wy187zvz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C30E10EA39
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:20:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6161E601EF
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119A71F008A0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790601601;
 bh=k8NaUNezwm1OqIABpDqgi3K1HuGNVyBGjeIJUA1Vp/U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Wy187zvzjuSDW/E2X5EUV6MGN8P3JLVGAgiMq34FslO1Hkv5k6DRJy2nVuOE+tOYD
 sZF6r5UP4XLiLVzYgvE9Wmg3NZxgNMZ4fW5StrGWlRLR2szQg3+yRQWfGdfyWs1GHS
 bzBju9cUq6DFC/KGBLlr3dAC0BCKN7JroSur46qeLYnNz8r7/qsD/4QLwi6hvyHSij
 GzRWd3mk4pZl9Y7tMBy/zP3gFbZAtVSVI49c3NNMc6zoklUchFqDrJN1RHDVsYyXsk
 4oTD/vFz5aN435Pi5K0vjKXJDlJ44n7DO0WL0gGIxsCJpLu/wFaNA+bR2w6xNEMy1n
 8YQlO6nNSFS/w==
Received: by mail-oo2-f13.google.com with SMTP id
 006d021491bc7-6d7a52c9d62so607339eaf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:20:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBy6XeYyMEQykCAUSp1Qf6UWkbTqxBnE4hIw16vskKnHXE+N93tUMyBqjTQSoOdTfysM14XxbMBYOzE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lgc7Fs/BGvAVEhpVZPzRwRdlHT9X/hoCA1AlfzhMmZzuxyMWCd
 MAcMTlSWrwSuKM4D1MJYXOteUzfixq1ILzO1mXV193ZivSFX7xOSNQ2Ff2Py0IR/ykmcdkN7yHt
 9Mf9+rq/LNcJ4QcUeBtSjwk0g4VUY8uQ=
X-Received: by 2002:a05:6820:2005:b0:6d7:c2d2:3ba2 with SMTP id
 006d021491bc7-6d7c2d23f2amr4986734eaf.52.1790601600291; Mon, 28 Sep 2026
 06:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-gemini-tve200-fix-v1-0-8be03ac2a8f7@kernel.org>
 <20260921-gemini-tve200-fix-v1-1-8be03ac2a8f7@kernel.org>
 <179060141842.3905299.18293784781944970746.robh@kernel.org>
In-Reply-To: <179060141842.3905299.18293784781944970746.robh@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 15:19:45 +0200
X-Gmail-Original-Message-ID: <CAD++jL=VRVEo9h1aiF6-1fBA-eEuNjAdhiNHuagBw71=ZGrpmQ@mail.gmail.com>
X-Gm-Features: AclHuK8N4y_x-2Pp53B3CGwLTjOtb4DhwJwJ3Zwoh0Xaz47DE26TzaOXVbr4nRM
Message-ID: <CAD++jL=VRVEo9h1aiF6-1fBA-eEuNjAdhiNHuagBw71=ZGrpmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: faraday,tve200: Use a
 level-high interrupt
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Sep 28, 2026 at 3:17=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> Applied, thanks!

I applied it to the drm tree following Kryzstof's ACK, I should have
said. Sorry!

Yours,
Linus Walleij
