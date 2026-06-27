Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FEEC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 06:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D836210E08E;
	Sat, 27 Jun 2026 06:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oZUVgRVb";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8304F10E08E
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 06:55:08 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49263703c6eso15848225e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782543307; x=1783148107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0YInxvP9vIxrkKOfsq0a9A7RdBzE89fDRN/Cs8YIhM=;
 b=oZUVgRVbVKiW0acUKQAUJCC5K8C3dkb277v0IhK03z1s2jNR6RPXs5dJ3b9/dn8nkn
 3BfT5G8t66B8o88k+jzebhLkLE0uLcoGEHTk5bCAG6cR0OS/ND0/bUPdQYZ45gU09iM2
 pC/JQ5HpNEUHq9aaGf2VUTYwN2srr0w5lPCcR7phha2Km5L56fm4AzyLDlqR3eS3v0wH
 kqUOKB2OhPNDfwnL3sbrAwQjbsgYICt87Z8ZF/oxbDaVBCTTxATntMnB9hMpTM7W6Mv2
 ZDPGYuIakOw4TX4sfF2j4S91PEoHm033d19WeB3N3ecM3FvGYOmgpr825AIdC2NQsyVY
 1NBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782543307; x=1783148107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a0YInxvP9vIxrkKOfsq0a9A7RdBzE89fDRN/Cs8YIhM=;
 b=iY+zbjK2naAO+eBEGa4ZGJrEvq9EdrdxjvviLehSmz9fq9kzo7+B22fUSCixUf9f/h
 E1CQw8spduxP7yGAWdla1gPSshwbApRHKbBGfJcruLkKfd6XdktkpXLLAjCPww3+GrtA
 N1KPoPK/6jr+mBq8Ppp6qZ3GK3jQHFW4CT2R3TJn8MuTRq+bIksK23eghafjcxZnWWO6
 AbXox5J84WK1Cq7AZbw5rhJmXNoRQ7TXTxlHyYFYIjKCdUEQD296Bkcec1IzIGzNF6ao
 CyV4YtKVqW2gGKdlRYDzEcALCeIUOD+KOCzZ0Fz1H534sSjlm2h0ZITDIOTYpQsB8gpF
 ySKQ==
X-Gm-Message-State: AOJu0YzV2ZdcTGYEoNvwPoCP3GeqqePgl4tONfws1dr/DGrJKECWpgJg
 snHk878NdAxXiGX+caY3NDkByz/QMBW639w5Sysr5qM8SBc9ZkH8T7zt
X-Gm-Gg: AfdE7cnGL1wwnDBsrJOj1SSvYAeKcq6FerpRfn3CfNl30sdi/Ukgzv0pxS4ALyduQ5p
 9Ot+2w7dXazlOx55JAIdrECbRd0zI9X3Os9BQ/BGojaSBtowHO7VlnVNzJBoJdzQfm3hONmHbGC
 6gyQl7r1El3uDPUHHHYBiT9eXpJjdlHkmqruu8I7HmLCFvFDovr0iZ6JFOgt8JOfgNoTn+AxrVe
 RDn8qnxIZjRstd7DuFwDVdo8y1oXGv0Y99yzdb3LITrpWjHF2e+xMuKK6g6TTOEFT0XzY0KN6jN
 zNaNdmSE1SEkqvQq4kNi1P346iYtgN58YRfSlqmKasclRFpdaTiUnUOwPTsr5FHojZqoYw/b/8y
 kk9fBAgX9AJLCTl0Tp5WV1pqJ3cVjomQ5dNUGlEIeURNdTS9YdOBMCLGAVDNQquBXiroTSvANvd
 Eq0TaIi1B3krcQkcdstWoX0nw2U82+IFx9SOe+KFcQCUmALdiH0FXDts+dCPxR2Rv9Tw==
X-Received: by 2002:a05:600c:4f8f:b0:492:432b:d78b with SMTP id
 5b1f17b1804b1-492668710e2mr151774915e9.15.1782543306582; 
 Fri, 26 Jun 2026 23:55:06 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4927038578bsm69037185e9.4.2026.06.26.23.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 23:55:06 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Samuel Holland <samuel@sholland.org>, Diogo Silva <diogompaissilva@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Diogo Silva <diogompaissilva@gmail.com>
Subject: Re: [PATCH] drm/sun4i: Remove dependency on DRM simple helpers
Date: Sat, 27 Jun 2026 08:55:04 +0200
Message-ID: <PMdb9FVETQuPUnyh12NM2Q@gmail.com>
In-Reply-To: <20260623-sun4i_simple-v1-1-fa6696df1fad@gmail.com>
References: <20260623-sun4i_simple-v1-1-fa6696df1fad@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne torek, 23. junij 2026 ob 22:34:40 Srednjeevropski poletni =C4=8Das je D=
iogo Silva napisal(a):
> Simple KMS helper are deprecated since they only add an intermediate
> layer between drivers and the atomic modesetting.
> This patch removes the dependency on drm simple helpers from sun4i
> DRM drivers.
>=20
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>

This doesn't look as useful change. Is this tree-wide attempt? If so, it
should be done in one go in one patch series, coordinated with DRM
maintainers.

Best regards,
Jernej


