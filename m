Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84908606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CIT2t2t7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A171121BD;
	Thu,  5 Nov 2026 08:40:54 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498201121BD
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:40:48 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-93f3c895a0eso150169285a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 00:40:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793868047; cv=none;
 d=google.com; s=arc-20260327;
 b=N8KLiR+xcvteo38eggmZvzd3veC8C0NSvEkycfLDaPCrh24Ht1iO9NLpIevJS3NEIi
 GAPQyRRJaBK4hLGxLY5myxw6eiJHEnFsWoIHdt8VM1GuhsblBdtaIwsyN6HKhPJKN0Rs
 BgByRe6JrgAjNVI+SovVnx5/KNM6tl3RaQxpPSmVqhFFMcE1WbK1hQNMvPlnk2XV9H5n
 QR1/YsrPj/ux07IkVoFSJwy2I9NbycveCiadBWQ4KhAF7sM0+HnD/oKEDsBvUv19NvAp
 HP3iOFDrU9upZh8IttmWz1SmeWelE5+uAfNN60zCcYqqCOT16bpcmJK0/icmAjlWGK/o
 O9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DDWemAYLpFySPEhpz6MZnQPpQ/I0i4/WwxV7qkmL+Ig=;
 fh=/1aKwgeiSnSC3mR+KjgcQNx2t8n4UX+nuEBynB4xUbM=;
 b=ossfeXntvw7KTAL578u9gCtVsUZi961Wg+0H6Cz4jcPNFhKIC6VvkPQauHjU1U+mSK
 u0A7VB29hglA8jG/hksXfqdcyyWfKO2eaasJlOVTshoYyKjXJzkZwJpbYl+Ur3pBiGSi
 HUP2nC98S7r7+lhf4yb/GLA4Pfv19go7mkGy8BHdy71MLPUKQZ7lb1S0F0unp1Guocp5
 byVm/FvLAEcW26/shKISYfITpq+cHlok8vj16Wli/foLCm29ISV9RpTDKfdp/XRyX2Q8
 f/AOVeLEyGb7tOjwlYyMPEdGOvj148B3hBrBojLjZlTSULE8KLi6z7yJtIY6QTAR3flv
 C1Lg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793868047; x=1794472847; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DDWemAYLpFySPEhpz6MZnQPpQ/I0i4/WwxV7qkmL+Ig=;
 b=CIT2t2t7PvEMgSUDNczWOo2CZWEU5h9hmwQ0PDngInupApOz+i6izWELwXNb5BrARY
 mbT61xRs1tS1kUX6tnHdwsh3QbO0Ak97b00ZuX1Zx7QJfXri0OYMV6gaBpJgLnTn0Kaj
 IVYRzZBySLDIYLGOoMUgMHljOJRHULC9YITTEBntPVue7Y/YqOwyN+iJrdG3BqrV2Piv
 I6P/mnQJmykJZ14iaEGi4jsdfQ6i61hYcnWWJ0hrKP8eU5PXCsuSSZgbictGbSfw6bWY
 1uvM9YE6TCTwLaLjMDV+M+lQWlzkgpyegaWm5Dff4ObpJKgWcu+iL4XgrfEGQajgmFEk
 Vnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793868047; x=1794472847;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DDWemAYLpFySPEhpz6MZnQPpQ/I0i4/WwxV7qkmL+Ig=;
 b=nOinfO3rvkkIzO0vZtWtlS4MPd+eI93sVA643lp9xRgOli+05Ao3N2qIoSt+1QSBZM
 qQRlD8Q+T3jh0d01znEV3mmUB4JZWrG7OxJq1zwuldOroqRtJ0rnYWRBsbD3GQ7cvUHX
 d1euHEb5WQgf9OADmxWchDIhd5Vbbl8IHz0FZ34vJyfVA4JxG518A7evvHzqK7hdYXBV
 5GdQ8nlvah4wBrNbJyTr0P/yULdaI4w3o+O2/22UqfaH5jPgORITDp9J7Ax7wm04cVeo
 bL4zcXvIvwHxbJ1dyrmVweNI88YIcUhDboNkuX7urLMUgvVnmpsu9vnJhpMOvngHOlce
 WlUg==
X-Gm-Message-State: APuU4Z8f0GoRbSyn4dgYv2ZOs/bQcXckMe/kCkHIoc23irFEI9Su/RlT
 gXLaVW51uAroRjqMgTw4vxJORSC39UpklcUlHoEaqIQrhFHZSABBvtIv/GkPg9Q6JtcwVwjgvev
 KiqkC1allOwFinD/14hu8YIcfCWRoU6A=
X-Gm-Gg: AYBFou0K0n833eptuovc8vgnLyhrf99iLTl65IyVfRO9ZJpIV51SjQkouWVHoc4TIJl
 tPvepJZVySyw83rvEQ6WZpSC7oEtuc2d0W8fP9yGmZr6nkFa6q+0+haw1BiwkcG4xniZjO9IW9H
 ZyEZ2UvJDGRKH53KRjsnlrowI3w0W1hIGzjJ9539ZciV3BBtQcfMFc/0llnwRhX3NwmN89wVQxG
 yZZIoAoVBsWaeJ88qePaFmKnAwUwid3GEICzSeJsL/4IBrgCpgKgWVdTi4qAmg+zMGhxnGhU6Zc
 MzJtrZlD25bhuJ6pMA0xI/251xsn1ex1UTG79114vzckI1uKT2WWsLduG+MIPYCmh6X/JOrsw7b
 c/uGl3UPC+Oh4AnIXkmGIH48YMV7FudP7glv+wEGebV8aqTj85BqVnxDF94vJscp31BvB5LRevO
 lPd3v78zOBvOwKflIn/R0tcQ==
X-Received: by 2002:a05:620a:461e:b0:93e:f930:5ed1 with SMTP id
 af79cd13be357-9442174519amr2850724985a.82.1793868047051; Thu, 05 Nov 2026
 00:40:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012220728.14861-1-fzeruhn@icloud.com>
In-Reply-To: <20261012220728.14861-1-fzeruhn@icloud.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 5 Nov 2026 18:40:35 +1000
X-Gm-Features: AclHuK9rSpudI5xPUp8K5FrKXjgGz5azoUEdbeTlyuitC4ycwsyAChqMlEoBybI
Message-ID: <CAPM=9twX71mND8dKKjO8=ZOKAkcVD-zcpvcMEL9hv5z5b_-k-w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/dp: keep MOT set between messages when
 no_zero_sized is set
To: Finn Zeruhn <fzeruhn@icloud.com>
Cc: dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 at 08:07, Finn Zeruhn <fzeruhn@icloud.com> wrote:
>
> When aux->no_zero_sized is set, drm_dp_i2c_xfer() cannot use a bare
> address packet to close the transaction, so it clears MOT on the last
> data packet instead. The check only looks at the position within the
> current i2c_msg, so MOT is cleared at the end of every message and each
> one is terminated by an I2C stop.
>
> This breaks E-DDC reads of EDID blocks 2 and up. Those are read as three
> messages: a write of the segment pointer to 0x30, a write of the offset
> to 0x50, and the read. The stop after the first message resets the
> segment pointer, so the read returns segment 0 again.
>
> On a Pimax Dream Air (three EDID blocks, native timings in a DisplayID
> extension in block 2) connected to an RTX 5070 Ti with nouveau, block 2
> reads back as a copy of block 0. The checksum is valid, so nothing is
> reported, and the connector only offers fallback modes.
>
> Clear MOT only on the last packet of the last message, as the commit
> that added the option describes. Trailing messages without data are
> skipped when looking for that packet, since nothing is sent for them
> and the stop would otherwise be lost. With this, block 2 reads
> correctly and the native 7104x3840 modes are listed for the Dream Air.
>
> The same problem was pointed out by the Sashiko review of the patch that
> sets no_zero_sized for all DisplayPort connectors in nouveau.
>
> Fixes: f0ddbb1eed18 ("drm/dp: add option to disable zero sized address only transactions.")
> Link: https://lore.kernel.org/all/20260827015758.0B4FB1F000E9@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Finn Zeruhn <fzeruhn@icloud.com>


I've applied this to drm-misc-fixes.

Dave.
