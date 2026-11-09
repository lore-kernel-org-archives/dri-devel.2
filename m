Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3E606D80A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GbKrSoDG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE01910F1E1;
	Mon,  9 Nov 2026 11:53:44 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA95410E89A
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 11:53:34 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso586131f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 03:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794225213; x=1794830013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PxtdLMr3sCtCgUOp13t31p5GiwnRhTgOXL5lwbYQ+4I=;
 b=GbKrSoDGEk6z+xZfIJvGn5cnPCqBNRJeBSJuLrQLCd/Mc8EBIF7PmBMfBFPX5CCKtq
 ohbzOvNjYek3qh0lmo/rRbK26DvC9MbQCoJGbfxE9hzSQsMcmsYc1NYRb1d3JUYG6oHc
 ikYEXEbSp0aFdZj4GRzI9+3a7p0zO9k0Mv+nPP0b4OBinNYUD/nBwj/z1Hu8802a4E4Q
 vF3ux+VnpzVV8KIN6mr31d+eV+De6tUAKbyLwz2Ny0HDY2f8HrL4Wv+VAPY7/z9nnWi6
 RAIx8XFoZR/vJuanMHyj1UjZqTnMrtDblOg9GkoN/6yRuZD4F2Aqxi9QQVyq0ZxwKC3W
 WbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794225213; x=1794830013;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PxtdLMr3sCtCgUOp13t31p5GiwnRhTgOXL5lwbYQ+4I=;
 b=hBSBuP2IQTnjkFj9UDYTbHoIErcmtm4T7diqnpkYINggd26JtZwrOki/Gc6mb/NYqB
 IMd1sBMbxNi08qaN7KGuzpl5d3xoRKfxpemDJwTCGLI3ZsWmfos57yU0z/rcTmjJd+B4
 /xzAhJ3L+RTrkneAl9oRMJBlVm5iQL4mYqnS+DNaT8tSE8DVByuMZOoBryGDG1vqDLBG
 xps9GpnOzzoJod1zh9Pk+XywDPF4pcEC2r5Kzx2LGJwM7sMkOoPDzYxC7Dq/oTJBgCrV
 X5QjhxbBASW6dJ5u63x5FgB6Hw2BfqLnFg7dnEYWP4muw+zQj5d1vx/NF0WYyo8yEDcY
 57HQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGAPzokYd7oOFuRs8gq7qu+bQ2B7RaCyG3e8dv0Zgu9En3y7KR+qXJo7zBCL1SEj/zmIgYb5CVsVd8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8spuOMiMddMebQ0kv8OomjJwSuqkTks/G+o6S9+JMPI2UebF3A
 CxGr9JmyvpjlIRRO8Ew6RME/mHjExYWvR1HL6H34znKKTp6P0T6nENTTYJJ21BdfO+sRpN+GznW
 4LTI8
X-Gm-Gg: AYBFou3pqf+GK45g7qbJqfRwjIrfZQlYo7ViD+KAOouK8Qjlqroqx58uFeh8/607Bwc
 nYWb84C7Ix7XpHKz/8B1R9xh9A/c2pVZUoL257sjjqdM0CZtfNn6WU4CayfWiZ3RtvaY8QKpoCQ
 0VbfXM7Avm4YYPtjOIpP6YfPigDQoN2z5BgvbiQWRtQYlL6uU4hDvA4bXwwTzD4tVKPr8tLw6ZB
 puDwPjs5pPSXaqZpniD2R7ja7c3xg+3fP4+RAKuSf1ssFUCLLO6Q7c360wdaUYF6e3CgxtSb9m+
 SCgubUYoriPYgfwV9qxkP4b7yMHFDT1W5KJHJ59d6GAON1y91YiJ/hVJPRF9byqm1ssexLnZU/l
 VjE8Diuf+KlkwhKQl5b868u7pR88z0CGrHqe8JM9NGsqvelZ8verbjAnHcjuOAzBgQ6X1FTz87J
 YeT4cPPoNj/FGnIVJFIH7Zz2QixEaSUDT9XJ0JLXsGrDvF4CDgFJ+dR6lNs3ywgMoHOzCNBolwJ
 PcXfvFg4vKUEMZ26b1iIVctqXxsCdA5M2nlrUVx6y1bM0kLJIrtBzaHm1CMBs1xYJQHlOe9CU8u
 8AjX2o5XDR/9uPAfhKxbgpUIb2XJF1GgZaIoStaOME8=
X-Received: by 2002:a05:6000:240f:b0:48d:f160:efad with SMTP id
 ffacd0b85a97d-49425566d13mr14507820f8f.30.1794225213002; 
 Mon, 09 Nov 2026 03:53:33 -0800 (PST)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea5008sm9527362f8f.26.2026.11.09.03.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 03:53:32 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-amlogic@lists.infradead.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de
In-Reply-To: <20261102212843.1213021-1-martin.blumenstingl@googlemail.com>
References: <20261102212843.1213021-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH re-send] drm/meson: add support for higher bandwidth
 HDMI DTDs
Message-Id: <179422521194.1645559.1387055395684042369.b4-ty@b4>
Date: Mon, 09 Nov 2026 12:53:31 +0100
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

On Mon, 02 Nov 2026 22:28:43 +0100, Martin Blumenstingl wrote:
> There's a report from a user with a DELL U3415W monitor and a Khadas
> VIM3 stating that 3440x1440@50Hz works but 3440x1440@60Hz doesn't.
> edid-decode Detailed Timing Descriptor (DTD) extract of that mode:
>   DTD 1:  3440x1440   59.972616 Hz  43:18    88.819 kHz    319.750000 MHz
>                Hfront   80 Hsync  32 Hback   48 Hpol P
>                Vfront   28 Vsync  10 Vback    3 Vpol N
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/meson: add support for higher bandwidth HDMI DTDs
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a5b5f29926498782f60441298e8a5442cd6a36cb

-- 
Neil

