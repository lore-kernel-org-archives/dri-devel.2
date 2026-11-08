Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972C606A337
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256 header.s=20240125 header.b=h4Yto5rt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB5310F133;
	Mon,  9 Nov 2026 09:31:43 +0000 (UTC)
X-Greylist: delayed 357 seconds by postgrey-1.36 at gabe;
 Sun, 08 Nov 2026 03:17:20 UTC
Received: from ocn-dfr-mts-118c2.ocn.ad.jp (ocn-dfr-mts-118c2.ocn.ad.jp
 [153.128.190.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E2D10E04C
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 03:17:20 +0000 (UTC)
Received: from ocn-ckd-mts-117c37.ocn.ad.jp (ocn-ckd-mts-117c37.ocn.ad.jp
 [122.28.128.102])
 by ocn-dfr-mts-118c2.ocn.ad.jp (Postfix) with ESMTP id 3CFF21C0001FB
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:11:21 +0900 (JST)
Received: from ocn-spm-mts-103c1.ocn.ad.jp (ocn-spm-mts-103c1.ocn.ad.jp
 [153.128.190.230])
 by ocn-ckd-mts-117c37.ocn.ad.jp (Postfix) with ESMTP id 974F34003112;
 Sun,  8 Nov 2026 12:11:18 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=docomonet.jp;
 s=20240125; t=1794107478;
 bh=GQvfNp65FBXmcF3uK/s2GXnfQ0y/t47EhDsCV7hVUL8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h4Yto5rt/S4/h7ZlyTQ/vq17Y7qA0reVKb/xAGxFXwDU7A8yUz95Z+5WvGn+N6HvZ
 A4Nb2mHlH8YR4FyUQuYE4QbF5Fe1JS6fqqLrQRpbuIGoGdeQOXK7NAL+pgf/Ih0UO7
 eNPJQblhEB8UR0kt1UFfFk/Ggo88Zgy27JSjtSmg=
Received: from ocn-vc-mts-108c1.ocn.ad.jp ([153.149.236.202])
 by ocn-spm-mts-103c1 with ngmta
 id 811bd508-18e5f33f0194fd6a; Sun, 08 Nov 2026 12:11:18 +0900
Received: from ocn-sdpx-mts-113c1.ocn.ad.jp ([153.128.117.211])
 by ocn-vc-mts-108c1 with ngmta
 id c06a01b4-18e5f33ec017da7b; Sun, 08 Nov 2026 12:11:18 +0900
Received: from docomonet.jp (p3688129-ipoe.ipoe.ocn.ne.jp [153.238.101.128])
 by ocn-sdpx-mts-113c1.ocn.ad.jp (Postfix) with ESMTPA;
 Sun,  8 Nov 2026 12:11:17 +0900 (JST)
From: "Shigeaki Asai" <y-asai.0816@docomonet.jp>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Nicolas Belin <nbelin@baylibre.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, John Williams <porschemad911@gmail.com>
Subject: Re: [PATCH] drm/meson: encoder_dsi: load ENCL gamma table while ENCL
 is disabled
Date: Sun, 08 Nov 2026 12:11:16 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: HidemaruMail 7.47 (WinNT,A00)
In-Reply-To: <022f5372-7963-41b1-ba76-2d89c51aa8c6@linaro.org>
References: <20261004-meson-gamma-v1-1-6347558e2bb3@docomonet.jp>
 <022f5372-7963-41b1-ba76-2d89c51aa8c6@linaro.org>
Message-Id: <5DD6F2ED1CC4592F3006A@docomonet.jp>
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/4/26 17:31, Neil Armstrong wrote:
>Thanks for figuring this out !
>
>Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>
>Thanks,
>Neil

Hi Neil,

Gentle ping on this one. It has your Reviewed-by, could it be picked
up for drm-misc-fixes? Please let me know if anything else is needed.

Thanks,
Shigeaki
