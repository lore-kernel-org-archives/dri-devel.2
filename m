Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED7606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=sf+EaGfX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 272FE10E6DF;
	Fri, 13 Nov 2026 01:51:56 +0000 (UTC)
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FDE10E6DF
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:51:49 +0000 (UTC)
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
 by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 89D76120351;
 Thu, 12 Nov 2026 22:51:44 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
 s=dkim2026; t=1794534706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VCakxFlvNf3r4xnqgVMZN0r27Eu0M3U7AunJ84kfgbE=;
 b=sf+EaGfX37dcNR3I0sGYwVUnbdihTv66gpXJwcfpYPbpMz4h/1vcxSieHEcXzP5egnDEnF
 rijjeU5zytFrIp3ZRNXWq0VQpbKj9+pyOvC1+7ELIFyE6iNJp9uYNQOQ7SsTok+MvW3QV8
 gfJbfYOpfplkXjsz8HKDoyuYH6Rv0bUpgxkZQUBMB0bZw17jDRVyfmBM2mXSl7/lAgB/v2
 VxkUAOsGsNwTISN+7co4ThSohguiV0Y2Tbj+ZGupgFY2e0rZV89BurTqqRn/NM8u3IYK46
 yDnB4KYWwq4zLuWGZQREn/Us0bBEJRM+g/gwCw5uQsoJ9TcpDOxcSuWmDSr2sw==
Date: Thu, 12 Nov 2026 22:51:41 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Sidharth Saha <ssaha2000@gmail.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/vkms: support more formats and fix RGB565
 regression
Message-ID: <avZsvJCsjIck1MRd@DESKTOP-PJTTJ93.localdomain>
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
 <f3707b72-07f2-41ae-aefa-c46ef84de3e3@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3707b72-07f2-41ae-aefa-c46ef84de3e3@gmail.com>
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

On Thu, Nov 12, 2026 at 05:18:56PM -0700, Sidharth Saha wrote:
>Hi Matheus,
>
>Following up on my earlier report: I've now written KUnit tests for
>the conversions in this series - argb_u16_to_RGB565(),
>argb_u16_to_BGR565(), the RGB565/BGR565 read paths, and both the read
>and write paths for RGB332 and BGR233 - against hand-computed values:
>zero, max, single channels, the midpoint, values either side of each
>rounding step, distinct per-channel values, and a read/write round
>trip.
>
>All pass with the series applied. Without it, the RGB565 writeback
>midpoint and rounding-step cases fail (truncated instead of rounded),
>and the RGB565/BGR565 read tests give identical results with and
>without the series, so the helper conversion in 3/5 doesn't change
>behavior.
>
>For the series:
>
>Tested-by: Sidharth Saha ssaha2000@gmail.com
>
>I'm happy to send the tests as a follow-up series once this lands, or
>you're welcome to fold them into a v2.
>
>Thanks,
>Sidharth
>
>On 9/27/2026 5:52 PM, Matheus Alves de Almeida wrote:
>> Hi,
>> 
>> This series adds support for RGB332, BGR233 and BGR565 writeback. This
>> is done with new helpers added to make conversion easier. It also fixes
>> a regression in the RGB565 write conversion.
>

Thanks for testing!

I would be happy to add your patches in case I need to send a v2.

Thanks,
Matheus
