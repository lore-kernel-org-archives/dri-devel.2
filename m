Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7D9C98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2D810E06A;
	Mon, 28 Sep 2026 05:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="h6tzgx8q";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9E010E06A
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 05:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Transfer-Encoding:Content-Type
 :Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
 Reply-To:Content-ID:Content-Description;
 bh=NSgjgIxlZWIP91WRA68CtWz6iKTotqGWktSzB7+lfPw=; b=h6tzgx8qZTPckLfOqRI7EEubF3
 6GL77s+pNOiJtc1K+lkLJjnRUrqM9D5UB39t3RF+kAwbWL9LszJF7J3BCsjmJm6xTkDWKMsxH4x2t
 9gH9fZ/CFfvqz2RlefvY8WEKlOiwee/2i/di5odjviFVDyVd1y4tF1bo6Kz1gaqkPSSOqyd7FaLc6
 jv6eCwwAsZGiewidIA5/C6EvIG4yqY/ITE3GtoB37xYS87SJdACpXzK307NDLcNq0CiKl1aDK/HGk
 bqe3RuRjc5kWsh39ej+UJKI9H6DTg/yuRUGStpxX5RVhCuAVD7jdUuuWe3cp/wWLwtvcqit8QjDGh
 j+5fpVoQ==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.96) (envelope-from <domibel@debian.org>) id 1xB3o9-007Od8-0K
 for dri-devel@lists.freedesktop.org; Mon, 28 Sep 2026 05:21:45 +0000
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469e25400so938727b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 22:21:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwe0H3psfmmBSb6fuuYgkb08uOP9JhpjaRIAM95Cv6vYGsKSBsu3/e7OM/T+UD+OhgNKeu/XrU8Lz4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mxtkiz+nYVYNi4QU+Z3svqpgXabTSDUTViIoEArmPsiqs34e4t
 vDSW25s8FvCmP313+vv5Hf+b8WR2iTWAjPOVU5gKHyQSfToCNCt0rEvKsdCrC6vbbbeqFb9Tf60
 1vF0tg2yzuCmAydItW+lyPhkinZEF8Tk=
X-Received: by 2002:a05:6a00:7096:b0:880:dfaa:a6d5 with SMTP id
 d2e1a72fcca58-880dfaaa996mr4280850b3a.33.1790572901657; Sun, 27 Sep 2026
 22:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260505042631.1916555-1-domibel@debian.org>
 <8d1e3735c40b452f7ab89228ad5a0040f5f41b35.camel@iscas.ac.cn>
In-Reply-To: <8d1e3735c40b452f7ab89228ad5a0040f5f41b35.camel@iscas.ac.cn>
From: Dominique Belhachemi <domibel@debian.org>
Date: Mon, 28 Sep 2026 01:21:30 -0400
X-Gmail-Original-Message-ID: <CAAvaLCy7jC-jFM5ZpPVeg7gKpweAW4nPKn4HXR+xpqUHD2soXQ@mail.gmail.com>
X-Gm-Features: AclHuK_UWybYUev4CCs0rM775Ij7Xct5Xij80ErUW_bz9ilg74HVWT_ebZnQGS8
Message-ID: <CAAvaLCy7jC-jFM5ZpPVeg7gKpweAW4nPKn4HXR+xpqUHD2soXQ@mail.gmail.com>
Subject: Re: [PATCH] drm: verisilicon: support non-coherent DMA framebuffers
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Simona Vetter <simona@ffwll.ch>, Paul Cercueil <paul@crapouillou.net>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, ganboing@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Debian-User: domibel
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

On Fri, Sep 11, 2026 at 11:33=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.a=
c.cn> wrote:
>
> I am still thinking how to decide whether to use dirty-tracking-based
> cache coherent maintenance or writecombine/uncached mapping.
>
Hi Icenowy,

I looked into this again and writecombine/uncached mapping is the way to go=
.
I used Bo Gan's XPbmtUC series and Michal Wilczynski's jh7110 display
series and finally got the integrated BXE-4-32 GPU to work.

https://lore.kernel.org/all/20260316060328.1173634-1-ganboing@gmail.com/
https://lore.kernel.org/all/20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@sa=
msung.com/
https://github.com/domibel/visionfive2_gpu_bringup

Best
-Dominique
