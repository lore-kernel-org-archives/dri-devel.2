Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683CCC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A057410E6E9;
	Mon,  3 Aug 2026 15:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="IJsUVJw5";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F9D010E6F5
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 15:04:46 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 6C1F4330A3C
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:04:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1785769485; bh=bec7vQNQOVKg0g28IThleZ8LFfU+/ZLXxDRoimvaM/E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IJsUVJw5E4911zpmz2XaKpPLyI/gNaxtcbenEqB6B5by+yut2fsC38cX4Kn4m4Uax
 turaoc4WJOqUTg/anazRhyxUTaKNTjEWd/f3I/UK5tJ9SNXkuZImCBncLH++3fVIzj
 OdpbQHmJ1VfAA2mw7gjo/PzLRRNuKPn0qb3pQ88qfyb5AItWxRYp0Pq7FU5uDNrugH
 ot8GyI5bbn5i0W4kV9I8hAz9vHGi3iVMMewVHjd5rAU3WkyWAdfSoy6p0Ysn7kwnR/
 nZUq6VNTifKBe4xEYEfrrjJeUc2sc8amxXB1hkxBnFwpA4iLJa0kdOGxhlHVS+smfp
 EA7rezr4TrZgQ==
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-92e54f8c051so170968185a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 08:04:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YxLhYrjayPETAmVwU9A1p0rbmbmC/tfCNY7hcKzUkC/2dxAHGnt
 taO4MtfnwBlimXuMNAU0e/loheb9jTG22XUdQatRr58l94AnimH1kAcfFF0bv+gsoZAT99fl3Se
 UFVAIP8cHLR8a8bfHXs+1S2dgjcF0Tcs=
X-Received: by 2002:a05:620a:a509:b0:92a:dcf5:ba5b with SMTP id
 af79cd13be357-934a078ec66mr1874803285a.14.1785769484157; Mon, 03 Aug 2026
 08:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260803144120.11524-1-xaver.hugl@kde.org>
 <2353697f-b1da-495a-b043-7a81d875856e@collabora.com>
In-Reply-To: <2353697f-b1da-495a-b043-7a81d875856e@collabora.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Mon, 3 Aug 2026 17:04:33 +0200
X-Gmail-Original-Message-ID: <CAFZQkGyfDwjPuciiOvZM3Ha8Xj+YkgkMaveHZtBK2w_S+Z+Vcw@mail.gmail.com>
X-Gm-Features: AUfX_mw8sK2V6GPnRFO7u88fP9ZT8Klne3x4kZYGrMC-8pF3piipOttVIK9wP9k
Message-ID: <CAFZQkGyfDwjPuciiOvZM3Ha8Xj+YkgkMaveHZtBK2w_S+Z+Vcw@mail.gmail.com>
Subject: Re: [PATCH] udmabuf: vastly increase the size limit per dmabuf
To: Robert Mader <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org, 
 kraxel@redhat.com, stable@vger.kernel.org
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

Oh, nice! I should've checked the list before making a patch :D

Could your commit also be backported to stable? I fear I'll need to
find ways to work around this or disable the relevant optimizations in
KWin on older kernels either way, but it would be great if that could
at least be a very temporary problem.

- Xaver
