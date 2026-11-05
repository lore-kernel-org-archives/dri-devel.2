Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1103606A32D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=oY6hUsF2;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Kzv9OIGZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B82310E088;
	Thu,  5 Nov 2026 21:56:39 +0000 (UTC)
X-Greylist: delayed 560 seconds by postgrey-1.36 at gabe;
 Thu, 05 Nov 2026 21:56:32 UTC
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C5010E088
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:56:32 +0000 (UTC)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1793915229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWEq7ANjuAxT0SsQWCA6NNqlsk5fygPVddvQlmahPzI=;
 b=oY6hUsF2Jx+NRaoHk81kEfoNEY+zkReOYRbyvhWrJy4CqaCVDc/BA2X+16JJnZXeTPyy5K
 rnI7LOgaXmNRBNvXnGM+EgGTyQOBt8xy/GPCJJQgaXzTHvc7YbxvJ4P6tk8gUAgkWAlsmf
 sNr9aArKBucyyonucqvG9lGYA164GHmgyRp09lEuQIQWmaIW1MF/zmnBWSXF/Xj/QF5MUF
 X4yocNFsZcXQ+IAchbLZ4X70PhEHRpRBxSGeefm1GAopDbSo8s3fyeOCVTnH/EEe1rA1ra
 ApljPya+O4QdZIWd0iQpY1uie2Jn9IvWO6fry+v2OK1AqHjstIqp+DhfZfJCIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1793915229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWEq7ANjuAxT0SsQWCA6NNqlsk5fygPVddvQlmahPzI=;
 b=Kzv9OIGZXm3GfDja/e1kGOPpANmqPEdnG3/UWpLWsZ3yo+uGUbKbLNxSzBkZkOCvBFQ7qN
 Yv7wNl+KWROkx+Aw==
To: Daniel Matyas <matyasdaniel006@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Daniel Matyas <matyasdaniel006@gmail.com>,
 linux-staging@lists.linux.dev, Andy Shevchenko <andy@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Lanzano
 <lanzano.alex@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Conor Dooley <conor@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [RFC] staging: fbtft: Moving fb_ili9341 (and others) to DRM
In-Reply-To: <20261105201154.37294-2-matyasdaniel006@gmail.com>
References: <20261105201154.37294-2-matyasdaniel006@gmail.com>
Date: Thu, 05 Nov 2026 22:47:06 +0100
Message-ID: <874idv2bol.fsf@yellow.woof>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel Matyas <matyasdaniel006@gmail.com> writes:
> Questions:
>  a) Is removing fb_ili9341 acceptable, pointing users of other ILI9341
>     modules to panel-mipi-dbi? The KD233 node would then have no driver.
>  b) Or should KD233 panel support go into a DRM driver first? I don't have
>     its init sequence or physical size, or the board...
>  c) Is removal of all of fbtft already planned?
>  d) Several other fbtft drivers have drm counterparts. Should I inspect those
>  to see if removal is needed?

IIRC the main reason fbtft needs to stay is because it supports parallel
interface which is missing in the DRM drivers.

Nam
