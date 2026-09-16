Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB011C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A0D10E1C1;
	Wed, 16 Sep 2026 08:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ES3g8zm9";
	dkim-atps=neutral
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B14A10E1C1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:29:31 +0000 (UTC)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469b2e1d5so522078b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 01:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789547370; x=1790152170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=idOsVahZustf70E3vcAEJkdJDD+K7D4L7o1uL+BpNms=;
 b=ES3g8zm9VMJ1BYc7XUjV1RyZSC3TP6bqFKUqdoSF6CcQoAkshRI+WGlcm84QWFXDdB
 gOzxOwjE61468HLI03gexhJ1JgwFhE8gaRSTcMYc6vQgbvd9neekYJIKJvF+NEldOTt9
 NBRgvE5k/rwz5/9AMxL0ylUw14KTN2st/aYRh6aJjxuUmlGXyZreGbS+UzBeqO1uHjXH
 b3BJdTiSM14/iKER1+z7j5HQB9g0ib1DYKc1b72AgC/p1GsbtXiAm7B0NJrvhiTIDFSr
 YEb8ZSvWHynsXgDBc3XF+VAMjYllse6TA9ucLqxSv7eL4am1v+u18yazV2Ix0Le9BRDG
 B08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789547370; x=1790152170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=idOsVahZustf70E3vcAEJkdJDD+K7D4L7o1uL+BpNms=;
 b=S9oWdR/S5+zHkcAhF4rrmSSvovbDUZe/wzrMvMjzMmZFOHU9uA/LeuDVuj4Gvktsql
 xTU/5JIIG8V6QTpx/XXyqhJmlqQnjc/KZeLgkca2mxQYIUfbksAXEem9jX9UYAqKZYSa
 X2HEB1OAHk7f9gIEAkbegfj0M+ehBrvT6NmsKTMHccQ3UL3jHnJreSIF0lUXwEpfhQle
 Pgxic76FNzyPnwYjJuf6/dxoNVHQ7StBg+afsqus2kgbFyGvZfKkQZGK0V1z99RTneHj
 Vhtk/pRBG9I1n42O+ck+LXoqVHJPhfqvvqGq2P5deXunwa4re2zwiEeUW5wsjUqQd3Er
 KYMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwK6Uq167YjvqNf8BeYf3afujB5+sWfPxmtjJMHkB6YVKejYT3bAxz6mZyQiZhtyOkVvKlOXK1vJxM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nGQXxqiSEx0f6o2nsa3WX3EAeVaI+yc/4aTtEJYF/3kFuv94dM
 miBFJbT5NzL3JiMXj9Oy7CSy6AtAveiSZ/jgl4mITJENOHwXKy3DsNbB
X-Gm-Gg: AYBFou3hG0jHjyAgrj466oIX0Q3ot9LCn4JnzwywrtoAW7byvr+29OHyBpTJt3WOpsK
 tME3Wgki3m5MYURkqHMUlFVxTzoJ8lq3SlRFIPuKW8TJevQVjPmJfEL9Ci+D661CtosK5paK6B0
 G26X9qXrL7louWYrxBmq2uo4Mb3rnhaUTZu410jBzVAcu5aUQ3psrhSwC4uj2I3s+agp8KY6ubV
 v99gN4ERd1JoPU4CxPFPUbCn35XvkYNl0sjYKDeq/IePZgS65GNIufWYXXnqguIaLiUXjJQ7Sf6
 gNEI+Ap5vUemzkQJw3PdDjNRoQ+cPipodViIJtjFbgmH68MPZFt11J2XxkFCMH1/kxxr275aJzH
 aQvA+R/4UYo856PIEW/gOoiEGRxAZZqkbgelyXcedpYZ0rsZ8/LfOv4ywvQJGOnkhkbUwybyWWT
 UdQfucqWhFe63PVIaDz5OT2E4aIlhIz/wlQ8xVgu2+t0+IPAYzRa5MHkE75fpivOCJM724KxfAD
 w6zzI3fTK8hXWIWcNPHyqovXgstJtyhRWDb0mL3UMIrmNosbjOSuMGLajOEkGrX9jv2E7wAFloL
 2YDNLgDHXgg=
X-Received: by 2002:a05:6a20:7d9d:b0:3da:34a7:6444 with SMTP id
 adf61e73a8af0-3dd5f7ad642mr4109891637.26.1789547370506; 
 Wed, 16 Sep 2026 01:29:30 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower..
 (125-227-154-99.hinet-ip.hinet.net. [125.227.154.99])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc50aba9dbbsm1157594a12.24.2026.09.16.01.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 01:29:29 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: Devarsh Thakkar <devarsht@ti.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
Cc: LiangCheng Wang <zaq14760@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
Date: Wed, 16 Sep 2026 16:29:24 +0800
Message-Id: <20260916082924.956116-1-zaq14760@gmail.com>
In-Reply-To: <20260731035705.3198816-1-zaq14760@gmail.com>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
 <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
 <20260617020926.114947-1-zaq14760@gmail.com>
 <8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com>
 <20260731035705.3198816-1-zaq14760@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Devarsh, Thomas,

Sorry to come back to this thread after a quiet spell, and apologies in
advance if I have missed something obvious.

Devarsh, the three fixes from my July testing on the PIXPAPER 4.26m are
still available:

  https://lore.kernel.org/all/20260731-ssd16xx-pixpaper-rpi5-v1-0-18ffc0dbf59a@gmail.com/

I am happy to rebase them, reshape them into whatever form fits your
series best, or retest on a newer kernel - whatever is most convenient
for you. There is no hurry at all from my side; please just let me know
if anything would be useful, and thank you again for making room for the
panel in your work.

Thomas, may I ask your advice on how best to handle the panel support in
the meantime? The PIXPAPER 4.26m is the only SSD16xx hardware I have, so
everything I can contribute is limited to this one panel, and its support
has been on hold since June waiting for the shared driver.

I wondered whether it might be acceptable to merge the standalone
PIXPAPER driver as an interim step, on the understanding that I convert
the panel over to ssd16xx and remove the standalone driver once the
shared driver lands. I realise that is not ideal, and I may well be
missing a better option - if you would prefer to wait for the shared
driver, I am perfectly happy to do that instead. I would rather follow
your judgement than guess.

Thank you both for the review time so far.

Regards,
LiangCheng
