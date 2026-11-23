Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5693606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LXQimsE5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF8610F33C;
	Tue, 24 Nov 2026 08:39:46 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 945C710EC28
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:48:33 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so28387485e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795445312; x=1796050112;
 darn=lists.freedesktop.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xZF0Y2fdOckMYZ5OQvo53Uy9aotpRIWurFGH1UvKcdA=;
 b=LXQimsE5dKUF2oKognGml9Was0Xnhntj9nVoi+rHnF4FDYiOUgd2wA6t5kyP004o3U
 ufdxG6JAVEQVlP3kXTcDVEbvspryMbEfxtFXob7N77cQPVmOR8GcOxhNIZFo24eKxIiZ
 bHoDH1oe6DCpcbej/az929k3ZHRis+7Q4Rf/G6ZAi5oJ/APyUoIxZc8axyDTMHNf7qsU
 9dnSF6P1kUuihPI+ygel/yrXmh8xl19PufsqMT+SIt77pEhHpV3y6E2X2j8/nK8Fozxw
 r0y14tJCQ9lES6KbL1NJXwWKZNdtA0xJ2S2QM7ZqgDC+H3URhC7PASKezNfnKRg1pb0P
 564A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795445312; x=1796050112;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xZF0Y2fdOckMYZ5OQvo53Uy9aotpRIWurFGH1UvKcdA=;
 b=Ygc5maU5Idrmtier0S5hc516pSxQ7Ga+1Y0Xsef43vlfyo4PeA/GxQHJGN+MUqZaVi
 ywdf45e4Rvn1qwiIzICIbJUJVrN1HywVNZl4sfroArzCamNNvkt3Kaae0xXGcDyKCQ0m
 5rGIiWIFC8i96FC2ZPh1TwCmb5Z3txDjzGhQXgcGSXxX5hpg4a1kiPot8VvHPvOIQ7rN
 oLgeDUNEJjThKsqFiZJ12rnSZ/rXVi3Dkp4k3TLJH/i0kXrhp2R7rm0KVSG15ygO0VnY
 CFnNjUfac8CuBLFGKev8I8EGoCmqGmlHztDgUtIGL+AqpqPS/N04sOsl4SUQFLiBca1W
 csyg==
X-Forwarded-Encrypted: i=1;
 AL+hErHhhuvXXiKfEL+cBib6Ooq7od3kbWx7lKQ9IJNtHXStizdmj+ugydqaTpEyP7UU5GiiAQCnuEvtfGQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+vBfBcFL/FGTpMEso0JKw3WrjoSm4fVKhBfDv98JN6cgd8aYPi
 kCNVj9NRMmEUh7p86+M+f31VTn2OAekuJegyg4k0z4+GqPPl+wpNO+rSsMWgfTPLIdM=
X-Gm-Gg: AZFdTZfhonY9w8+oWS0Uk2LaIYxPCMMeXOvXqLBNNxNOH3m8SyTi3/12W11FDKfEr8D
 v03xtXpNYmaHZmU7g7eWUi6PbgyG4J3BL/6CrK1d7dCeJD0T6Jah7Fg605s7EnFJC+QGiAU0NJt
 oy0g8MrkIDw2WwN/hr0Gm+b19arLuHG+p7ETS3YaM6yvn9whgqAD4m8NYqdmxr89n9WgAOC6X35
 ZjGdAdizH3+2JueEXlgFXtu/yk/IupdDkDnyg3eW3dAI58AQiZXikGJzV1wNyC2zeJMxRsST3/t
 52mKB20JQkrnCLbr3HycpYLkYjdYZYm+N4bIGQBAtKEhg6PoFMVpe1eYPKVEbo3p0oM0F5h8ntw
 XSxSST6QqL1AXJYT25LMjHJwKAuId3RYJiDOmzEqfS+F6jYvAuwlmhERnYR9+W+Rb/cWirCn9Lr
 xOeAMxdSFRouTewUM4zQYYM/cWfUap+To5IQBubr6BCykrIJJ/hgdb8miyztTe0U2ynojrCGrvV
 qdmxmyzD9ChGxGAPM064rCx9ovwBYCK0b/3soLgR+G4Ny1peiQJuBnoC5g+zWWd6ROKrxzKeBvN
 lbJqWgQanC9YvItUhO24Mc4UCl5DQcqY6zRlN4T33VQmxA+sNqU=
X-Received: by 2002:a05:600c:1c11:b0:4a1:e57b:667c with SMTP id
 5b1f17b1804b1-4bb8881c357mr274976895e9.26.1795445311988; 
 Mon, 23 Nov 2026 06:48:31 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b8b7888sm22471477f8f.42.2026.11.23.06.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:48:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] drm/imagination: Fix the value of
 ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP
From: Guillaume La Roque <glaroque@baylibre.com>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Brajesh Gupta <brajesh.gupta@imgtec.com>
In-Reply-To: <20261120-rbrue-suez-pvr-compute-overlap-flag-v2-1-ca2b0d3adb4e@gmail.com>
References: <20261120-rbrue-suez-pvr-compute-overlap-flag-v2-1-ca2b0d3adb4e@gmail.com>
Date: Mon, 23 Nov 2026 15:48:27 +0100
Message-Id: <179544530793.3861580.6891548435680251826.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795445311; l=806;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=00LSWVmN0FB1IQwX/OYvVQBvFJYhXx7VT3sxIQ7c0wc=;
 b=MxhtnwKz3q5p0JRhWOpgCiX3vyfV7rQQ51LTmpRjQM20hO7cKOSFMmrLXqJpDYOF7v7p+++iW
 v5Quzv11UhXD5dm2KIb64yezSzKCo6+m+F7XOlWpmN1sM7cpfqQ28Q6
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 12:10:21 -0600, Ryan Brue <ryanbrue.dev@gmail.com> wrote:
> The firmware takes "prevent all overlap" from bit 1 of a compute
> command's flags; bit 2 is FORCE_TPU_CLK. The kernel has used bit 2 since
> the FWIF headers were added, so the firmware has never seen
> DRM_PVR_SUBMIT_JOB_COMPUTE_CMD_PREVENT_ALL_OVERLAP.

Hi,

Tested on a TI AM67A (BXS-4-64) and a SpacemiT K3 (BXM-4-64) with Mesa
main. While a fragment load runs, a compute job using a workgroup
barrier goes from 19.1 to 8.8 ms per submit on the AM67A and from 47.6
to 20.7 ms on the K3, and is unchanged when run alone.


Regards
Guillaume

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
