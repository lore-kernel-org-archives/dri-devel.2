Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3CF606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5914A10ECBD;
	Mon, 16 Nov 2026 08:58:48 +0000 (UTC)
Received: from sraa.de (sraa.de [85.214.240.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB39610E035
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 19:10:39 +0000 (UTC)
Received: from [161.142.148.162] (helo=ryzen)
 by sraa.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <basti@sraa.de>)
 id 1xSfcX-00FyWm-7L; Sun, 15 Nov 2026 20:10:33 +0100
Date: Mon, 16 Nov 2026 03:10:26 +0800
From: Sebastian Raase <basti@sraa.de>
To: Hans de Goede <hansg@kernel.org>
Cc: Sebastian Raase <linux@sraa.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Helge Deller
 <deller@gmx.de>
Subject: Re: [PATCH 0/2] Add monochrome framebuffer support to
 simple-framebuffer
Message-ID: <20261116031026.2afde847@ryzen>
In-Reply-To: <ae6f7b88-ea9a-49f7-a3ad-ba90185528c2@kernel.org>
References: <cover.1793758480.git.linux@sraa.de>
 <ae6f7b88-ea9a-49f7-a3ad-ba90185528c2@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hans,

On Wed, 11 Nov 2026 12:15:36 +0100
Hans de Goede <hansg@kernel.org> wrote:

> Hi Sebastian,
> 
> On 4-Nov-26 03:34, Sebastian Raase wrote:
> > This patch series adds support for monochrome framebuffers (1 bpp,
> > packed-pixel) to simple-framebuffer.
> > 
> > Monochrome framebuffers require far less video memory and bandwidth
> > than 16bpp or 32bpp framebuffers, making them useful for small
> > devices or FPGA implementations.  
> 
> Thank you for your patch-series and I see that Helge has just
> applied this to the fbdev tree.

This may need a revision because of the DT bindings discussion. I agree
with Thomas that 'mono' was not a particularly good choice of name.

> Have you considered also extending the simpledrm driver to also
> support these monochrome formats there ?

I have, but my target environment does not support simpledrm (DRM
doesn't work with CONFIG_NOMMU), so I could not test it.

It's a very basic Busybox-based system, not a full distribution.

> Most Linux distributions now a days have switched from using simplefb
> to using simpledrm.
> 
> But I must admit I've no idea how well the drm subsys / kernel-mode-
> setting API handles monochrome formats.
> 
> Regards,
> 
> Hans

Best Regards,
Sebastian
