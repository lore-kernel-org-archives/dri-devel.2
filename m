Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEC5606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=WkRCID3y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC7610F752;
	Wed, 11 Nov 2026 12:10:02 +0000 (UTC)
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F2110F752
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 sang-engineering.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=k1; bh=+EtG
 8CyQ59kAhcLxDyXRX3sibsUSs2m78jp4eyjdC+8=; b=WkRCID3yVbwXRqKJohqV
 Reen4BzE0JuLOnYgLguV7+HYnRrzpAXfIcBbRX96w++mby2m5tXCx1HDPKfe5h8S
 hYeryuP54O9NrT6zZuJ6doM03pKU63M6lGkx16WzhowviJL3RcZuQuBiQOgBnsC/
 SRGHu1jk8X2SaH888i79a1juIRyiO7+PN/0IOB9GRp9ZJYbrU+906ocm/EwlmOY/
 jgN7rvBoLKMNGifpiOSCBUe/JUyXdQT6fU14rtUCk8Z4IFT2PEToJXjIJQUEQJOc
 mgXe68JCGLRUNnoYHip9McVi4UmUgYXLxCErHQToQ74EMUZzUoqaENnGtaEpx3ya
 jg==
Received: (qmail 603641 invoked from network); 11 Nov 2026 13:09:52 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 11 Nov 2026 13:09:52 +0100
X-UD-Smtp-Session: l3s3148p1@fXCIEv9fKq0ujnun
Date: Wed, 11 Nov 2026 13:09:52 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: phucduc.bui@gmail.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm: shmobile: Fix white screen after resume when
 LCDC is stopped
Message-ID: <avRbEGoPh3bqR93f@ninjato>
References: <20260707093004.987846-1-phucduc.bui@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707093004.987846-1-phucduc.bui@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Jul 07, 2026 at 04:30:04PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> The LCDC on R8A7740 may show a completely white screen after resuming
> from suspend (s2idle or s2ram).
> 
> After resume, both Set A and Set B registers are reset to 0. As the
> Frame End interrupt is not generated while the controller is stopped
> (DO=0), the hardware register switching mechanism is not triggered.
> Consequently, Set A remains at 0x00000000 even though a valid Start
> Address is written to Set B, resulting in a white screen.
> 
> This is a timing-dependent race condition. In some configurations,
> debug options slow down the resume path enough for a Frame End
> interrupt to occur, which can mask the issue.
> 
> Fix this by priming both register sets with the Start Address while the
> controller is stopped, ensuring a valid base address is available
> immediately after resume.
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
> 
> Note:
> It was originally posted in March and has already received both 
> Reviewed-by and Tested-by tags. I'm resending it to bring it back 
> to attention in case it was overlooked.
> 
> Changes in v4:
>  - No functional changes.
>  - Resend.

Still not upstream? Who is the person to pick this up? This is a
valuable fix we surely want to have.

