Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019D8CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE9C10E639;
	Mon, 12 Oct 2026 17:44:02 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD5F10F254
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 17:43:56 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa29e06bso1891997a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 10:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791827035; cv=none;
 d=google.com; s=arc-20260327;
 b=jQ4Hova8cRtGu1KaBIL3GZZUnPizaxXo+xwjMIcIuskUu4jFFzOz0HyURfOIwlNp+Y
 Zn1zd+7q0gP59ImHNgjJ4woGt227i2wpYqBcXSGFYBurwsIli2mC8wyt3270fYRxgc3d
 MvLS0fofGzf6Dd0cp+Ag4DoVtz+eHet/pL61lho/48EJGjlKI7Il2RPWXj6yLJBOnhTM
 FnXf2cl/fG9eLLT5+I4VuCwFdMzhTEqmIAkA22Jldpy+cZTQ4AydHwsZaomA+gkEQRTy
 ZfjccFCSN4dLBqsr7RODyhWk70+nrf//fxWcReeCnZlxpo27g0jepcMB9FHdr6rX1Xkl
 MV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aQmNTGROGdvgxfWPGJ1OogqSDxU0dKMs1Ijyj+pgCT8=;
 fh=WeYrEzwt+wi6iIjZEuqFRjvUWUXy6Q1R7ae58JKipHM=;
 b=Cbq/KQANakUbLLysuft+KVX2jkAVW3pEjcAAw1ZfbOE8lRJNjyxi2P23HQiglmWixt
 v3vUfl1QRufELyCxn3kznKPaL9NFhvWD2XqoJLEUWW4HDHobvJlsERUpcZDtpj4FY2zW
 GpXLb99fho8qLmhKoAOACpFrRoJ8zfB1ErTdBDf1SD2z32VEIpAmbzM8ZV4fRysNNw0N
 LhYbmyrWnLMVxpmsxbOMsx53IEgVQWvSexv9Y60WeJ5zEZ0//6E8f5k6+jztzpnZG5Gh
 TdVLZiuXlbciOfOqSPCowB6VU1eYYZlBgVMg+//iB10wQRoz/8gonlQNfKlOzxiajyBI
 1aCQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791827035; x=1792431835; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aQmNTGROGdvgxfWPGJ1OogqSDxU0dKMs1Ijyj+pgCT8=;
 b=TWMxDzg/8MTcGCdgFLaxfli8S7QLc6q7/kAe/1fAJUsuUwsk5BrKEvPuC0dIIg/kBb
 iZCs8AYo6PHcBr6pUi300UushQGKczyynCETZqqCY6JS4UPnbHVesRWJs9fcNa7Cy6hd
 nGRgWsa9wUsP/POJfJw35kBJLLL5Eqv5gEMteK7idmjl01NTUddYuGz+OAovhHHfURJn
 HpILm/pCLmnDnSfX45XySTKCJcO8A7rDuoClcJoZHjnA+L62JvNwL7hiDBQdS62dUs6t
 EkVz6S47DPoVj95cMoLTT6VzvXFlfmdKzPhZa2B/lMyxLA+lGLqB4D4BoxRT3OKUG7k9
 UMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791827035; x=1792431835;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aQmNTGROGdvgxfWPGJ1OogqSDxU0dKMs1Ijyj+pgCT8=;
 b=OTRUPr9icTKT2qq3wdcYWzzUf1+djFL/o9NNyUnICqIRCZsEeqX0QuoSoxMbFYm0+g
 MRyOEmyuH+RExkF0f3Fb0dTpLiILg3RZEklKjzqgKlQ5ppZss3lM3KANn9TTVP08UlM6
 BVssFg7xt/R7gdLGsEMN6U1roO5newXa0tt1vtaxY2mOG/A8dOCSWT4UgAWH/dMjevUt
 Ow5Xe9+IEINySKipqy2aPQOsLH0e2TRI6lBgtHX0fmr3A2H8og8z0gvNK0BXdIaNcLgQ
 zbllK6Aw8ReBMi6l3SOKkK3zB28PfOKpIFzPOQ1Y+LWud6ZjjEe2sgelGkI6G6MGSdZF
 HlLg==
X-Forwarded-Encrypted: i=1;
 AKwUvByhfoS3CRlLjRaAFNgMJVZ7Zo5nodSNHC9Vch2z6mJ47HVEHCd1kJv6ziR4/VrxpPMXpYXjCNdgZlk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLJ7OVtZKudlL9k/+PZpxhHjcCdBkY4T5WGK0E8G4CmdqjJXDSy
 3x3Fyg+cZSX0T/noVZJ3PJ9uHSrDnCKKD+xD7CMqTrkonLgq5eYKmu05SIysD2cuBxm5BZxlXqF
 0sI812dIO/2h10xzhdwu5CmZjKmCjDNA=
X-Gm-Gg: AYBFou0rsRfIYcViIzOYZzzU+QcaMYPOC23ULYmoEGOTppMcKXXYZsiSW550cgTBWWW
 Lyx/mKpIfwEgxLk52N4yB1pBV/xEjBsWtqQ7bu3O0AT1qOjgyZ/PoA1BflL35s8tJB1gIVCeLao
 CQMD1hFc6Y6l92wi9J1huWeb84G5QGYUiAN/6Sh33U7tNL+8dzmvrhCm5oOgIw9Y6BZkNxLgBzO
 A8Cdcuid+jKvLxQfl/5lrfXMltxnIxSkKQE/TBzfObRmqigqEzYpsXUy2lIXov3+PZxCEvAYScX
 Eq4Di3iuOk/dry64r1fh1thjW0UeT2q0M+REsAr2iUkqoj9gzl6s0g==
X-Received: by 2002:a05:6402:4341:b0:6ac:8761:17a1 with SMTP id
 4fb4d7f45d1cf-6b17c27a7famr8072014a12.36.1791827034421; Mon, 12 Oct 2026
 10:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20261010115539.9237-1-l.scorcia@gmail.com>
 <20261010115539.9237-2-l.scorcia@gmail.com>
 <20261012-quirky-emu-of-renovation-c217dc@quoll>
In-Reply-To: <20261012-quirky-emu-of-renovation-c217dc@quoll>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Mon, 12 Oct 2026 19:43:42 +0200
X-Gm-Features: AclHuK-aSGZTx-4HZF0vtpTq6BBo_BN-ay9Tv6iz0b611lBgirjVShAwSUrYMCA
Message-ID: <CAORyz2KgX-7=gfax06+Pb5SFq4dVTtcTY2pbH+FDCRNZ+AVXOA@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: mediatek: hdmi-phy: Add compatible for
 mt8167
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, 
 Fabien Parent <fparent@baylibre.com>, CK Hu <ck.hu@mediatek.com>, 
 chunhui dai <chunhui.dai@mediatek.com>, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

> Why do you have flexible clocks?

Hi, I'm sorry but I need a little help in understanding your comment.
If you meant "Why isn't there a constraint on the clocks' names", it
is already provided by the existing conditional block [1].

If you meant "Why does clock-output-names have only the maxItems
number and does not specify the clock name", it was there before [2].
It could probably be added back with another conditional expression.
If you meant something else entirely I apologize and would appreciate
some additional guidance.

Thank you,
Luca

[1] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/phy/mediatek%2Chdmi-phy.yaml#L90-L102
[2] https://lore.kernel.org/all/20251217-mtk-genio-evk-hdmi-support-v2-1-a994976bb39a@collabora.com/
