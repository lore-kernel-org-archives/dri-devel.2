Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F1606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JesHCTMa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF46510EE8E;
	Mon,  2 Nov 2026 13:48:05 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4440710E63F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:47:59 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so2448739f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793627278; x=1794232078; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Eg5KcHtt+GEBPeZnp3k0m/Hd/Q0QnL+NV035hcUkwMc=;
 b=JesHCTMa85mNZqYLU/fi/5lQFhM9R/8KNzv9cyN5Uj4l0zaEVFvKpzAp8zcaJNkmyc
 1cSoIicDdrEMXrQh/0/xswatw3/mZfkauGrZcU/Lm0IZ29tIwt/7KDeJgzgX4lppP6vt
 ZSmklu05NoiAITYmKvJs2AvRzc0Jih+2ejEuVYy6y2hISpqyPagNQS5VprnUGuy14EUv
 OwijqXvN3lj2gcnW+H1bzwgTScgQzfMUYNCL0KAL7hQa2qvzd43HKbMb4AE83mEolAY4
 rkK7yKq94MLJUYsGmCk9+d1gAXwieZcfum8gEctpf/kFVVUxBA5dizMyN/HotPF1T3qr
 2w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793627278; x=1794232078;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eg5KcHtt+GEBPeZnp3k0m/Hd/Q0QnL+NV035hcUkwMc=;
 b=XSzhoxWu0DGAy3xqUzyyuMfmO+wbBcC89gVWjnkF0m3o0wHZkR2mvMKUFbHDfm8kKb
 BVOJiGncd5Wg9FbJDnE2G4p2Qb0v/xPMB1XGw5MIbEz3GgZWy0Yt0+i6DLpNDTNCEjeU
 ZKhZ+tpbC2RI8cRfeE6ZnMhz5XQxh18BC2LSSFtKevUj9KkmXMQH0H3zzJMZwmAkGav8
 A2ImiLsk3px/fXJz5k2l6FazpUpxcW7w/XATTNUJAWgrAgXvIEEd6kfrpaXW3qhn8QRu
 5X7EGT0TcTPnx81DPu2YKvXmd76bK65KD2vtW8wKHeYSvMp7QVu0qFQGKD+me17HHV+Y
 8vQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBgdrKTk40I82yn1qmozgjV+/PiCNwwoSn1tvfIYBEEAqSCKIj3ViO3ivFqswEfDwj1nwcL1bKq2E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9cMnJqIse9vkJYQmJLNK9Zb36j+RqSDmYek72rgbxvYG/vguFx
 ht8p8aOeHKsWMhJgGxUjOSEtX3Z6u0cmE0lbsAfP8lXFuqLTdDDy4zcy56HwA2n6LOU=
X-Gm-Gg: AYBFou0DpgqNntd8dXKxF9W8uDnPT4EndPq0IoZCtlr1gJG8UgWdMe4YQNTBRZaUKXQ
 P0Xyu33/PzAzGve7vK2esCzU7pJt3yw35FEZ3bYnmVdvdrIQ4DA2hVss4a8NunPz0XPwDhj3rxW
 CgQLkMR0BPSfFrVKarYVkPP43NokI8Ebi9QEwlFe+o2dhSKkmfPqG8Z/MZoIE/jlvS/BmU2ed1l
 t2SAgDXV19VOOJIdTodiDe6FXdZEJ/b9hzN1jgj/86Kng1dvugif+1YzRDQhzM2bHM9XTBS7POi
 oZKCnhMEsqPHWNvwDrhL+RND0kAjt28TvIiiz2WgGbM2M8t/bwpAAiYRYrdVY0B54OrT6F/6mWF
 R3cspOmF1R7eUI2EWn9cVIBI21WUFBc4WoleiSAT1UCJVMOnrk0MnKoFQhSt+ZhN4D8rRdJVMMp
 0cwpE6x7QK8NW9l2WqJFOiUyezjB8d8JTst8fWKIdWYDyLLilUMOZOYtzSjvLAMwIs6f8Oo11c8
 UelMESawQDSvQim0moUnJkDdFFDFqxFb90VEJW5n+QmYVbTqqCVC4o8WvpaZMQdogq4d5QN6MOD
 F4sOyEf6nChRSAprbWKX4DpHiKNZA3bF/WvozjVVEgI5ld3Wef4=
X-Received: by 2002:a05:6000:4710:b0:48e:eb5:4976 with SMTP id
 ffacd0b85a97d-48e6e306dedmr21941079f8f.53.1793627277505; 
 Mon, 02 Nov 2026 05:47:57 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8011csm22557569f8f.31.2026.11.02.05.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:47:56 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, Vladimir Zapolskiy <vz@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261101212458.2431191-1-vz@kernel.org>
References: <20261101212458.2431191-1-vz@kernel.org>
Subject: Re: [PATCH 0/2] drm/panel: visionox-r66451: Fix brightness and
 power on
Message-Id: <179362727655.3341282.11401838010991830979.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:47:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Sun, 01 Nov 2026 23:24:56 +0200, Vladimir Zapolskiy wrote:
> Two fixes for the Visionox R66451 panel driver, found while enabling the
> panel on the Qualcomm SM8350-HDK display card.
> 
> The first change sends the DCS brightness value MSB first, as the panel
> expects. Without it, the brightness does not follow the requested value,
> and the default brightness is received as a different value.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/2] drm/panel: visionox-r66451: Send the brightness value MSB first
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/00fe6be187ffde738fdb71ea7deb671fc939e583
[2/2] drm/panel: visionox-r66451: Wait longer after the panel reset
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b4b2778d5e175b166e4a27e5df5d61da468ad004

-- 
Neil

