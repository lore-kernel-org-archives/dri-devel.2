Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82169606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEOvtT6V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBEC710FC4B;
	Wed, 18 Nov 2026 13:10:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39FC10FC4B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:10:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E6DB60D5D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1191F000C4
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795007408;
 bh=TcFys4tC8qfabSvXxf+CmT1+4z1i3gFD8QHazQU8beg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=gEOvtT6Vpf/b3ewVzqz+PZYDWpgxPoXN1xxy7L3hs7QjCw1ooXsJ6SyuFKVDMRHmn
 duN5FkPhA7O1MdUCcqXOBBBESs0mju3UQtMy1fQokYywDnhzR23NPycsUz3TZJM7yA
 lGjLuLlLYTIHEixnt6AG2/QYytzxKKnO2H9V1dKm+8VocvyFC0POXuhjomaq8MRF85
 1j7e3cNcjesPMgX122aWPO/mGQctO4FghyqYJb3ZO7071TELH0JxIsKJJsWBbXMJho
 gpG0s4Mhshap/7i0FhQrvZITgev9EOx+mdGqjt0yhjs8qbxXfIUAZzk5PXzGObybz+
 BvDZxieYErK0A==
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5be3d5927ceso1102913e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:10:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEvfkdAdZ25Sj3QCC2X0qqz0V5zPqySvTMXdp3R9GahHk3wK3S4DjhUKJCylIQz4l/+Z6cENvvAwm8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ZlWEW225NSZ9M22Bd5LBVpwN/icBw5+XOSkE78kcE4c0xe28u
 pmadJNE5T0JW4y6yA1dHj95HYsUklVRSUXC+BJo1AvEKDCtmsHu0gXFJAQyqhLnpLiNaQe8zp2q
 La+4Ehc13JzQjoN9xCGD9MKTegdJEpqA=
X-Received: by 2002:a05:6512:3f2a:b0:5bc:f2fb:f50c with SMTP id
 2adb3069b0e04-5c1aa1af200mr850838e87.53.1795007407666; Wed, 18 Nov 2026
 05:10:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1795002467.git.ukleinek@kernel.org>
 <69cc3ae97cac70a5178befb171205bf6035958ff.1795002467.git.ukleinek@kernel.org>
In-Reply-To: <69cc3ae97cac70a5178befb171205bf6035958ff.1795002467.git.ukleinek@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 18 Nov 2026 14:09:53 +0100
X-Gmail-Original-Message-ID: <CAD++jLmjGwCVk1+Q6fJweajFoZkuufGQg61Ksy9kJLTLhkDfig@mail.gmail.com>
X-Gm-Features: Aa3M54powyDl4C2n7uvr3WWo_h0xVhjYTGn6oV1tZXwMOIX1HBrJW-7o1vSTp90
Message-ID: <CAD++jLmjGwCVk1+Q6fJweajFoZkuufGQg61Ksy9kJLTLhkDfig@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] drm/pl111: Use an empty initializer as amba_id
 array terminator
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 1:08=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:

> Rely on the default initialisation provided by the compiler instead of
> explicitly assigning zeros.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Tell me if I should just apply the patch, I'm just assuming you have
DRM commit rights.

Yours,
Linus Walleij
