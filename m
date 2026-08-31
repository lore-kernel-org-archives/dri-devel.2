Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371A3C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770A010E910;
	Mon, 31 Aug 2026 14:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b76LD9bh";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9988310E912
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:29:27 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so35704035e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788186566; x=1788791366; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6E89hI6dDsHxKquITrLVBigGlAGgfkia7MnsBoaZjOA=;
 b=b76LD9bh7B52KVCn+AOxYVq1oCEXM+zdPxUZdL2QdkPx2E+qPdlvQbvS9ULqHPkbrB
 D4iSiP8Jhma39SnidsWE2axLh+WLgRSEp7YceKM9l3vcfpRM0qS/gx5Xsz0L4ANMngyG
 Wh4RAcdKWhOxdk6mSVue9sN4mUW1+Hbv3tK5E+7uTXxhuOYft5dgkjR27kaYjsm3ORO8
 vt5XzuC/9vBZwT4J+oAuuI6uauZ/1Es2zCyyre/xYAkYJmHa/p2lC8YNvBxjuSy4Fv03
 Dsj1vrc9e0OPjIg3QWvnCh/JhWXKQPcMHZEBNDPUJ68Ahv+56wvNqPDcEgwqmOPJPDu5
 9aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788186566; x=1788791366;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6E89hI6dDsHxKquITrLVBigGlAGgfkia7MnsBoaZjOA=;
 b=ooYFoo4hKVe1SLQljvCqXlQWgYkX/RmJf4mrppo2stmOPsZEstT949pLeG3jYfO0Ej
 uYX+NVmidY1PhQ2n53E7UIm7d+C28g/mcdrCkjHrRvf8h7Z6n55OSeID6ARmKPa/ZxUL
 okZ/Azb9RvtByBdNHWa3UMlux2jnMt3zAPsWAi1xqOne/2dQFrzfJxWyqAvhEYH5GZ+5
 Z85T/jslaMuTP5VDNXEsucVL0f4EA+nLbbz2uDJt/QhPawT8fSUVO6x0qKP7+WNnScpq
 64plIqaeZMLOQhAnPA851aOa3u8LL34EdBGC1WIYuUUD++Y4Y6J4pSInRbEtkjNHs/Cb
 f8zA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpegOpPIaHWb5U/KKD4TrGSSLwLTwwY6lY2cQNdrFCFPN4y+rawUDVu2KBCky/4RE4/lni0BruHkew=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mEaCzSaM7QJmcnndEWCjnVhhXexbjdOAsPyetbgf8w0uypGb8t
 wC6fuWYbAU2fAoMC086uxLAtQm4wnNPG2c/gi1zge3+yFVqZLqSvIGFQqvs+gU3Rnrk=
X-Gm-Gg: AR+sD13cw2q5SaxyX+co64z4nqX2451Vep7Y7hpGFevT1X0a0eNSpnhb9pejeNyTgus
 4mE7UJyKYwfOl1e3Ak0LwnqU28l1bq8YHiuh3lvUhapu4VoNszapdCdwAujEYRX4Dgx3+rHc8tF
 u0WLsBtXQO+SZbKyVNZ3BMns8MGBkQOu52xQ8YjoY53Tr4owzzr5cMFFUC5btpTEDqV9zKvhbjF
 ecQEw0yJNA1HhykQekgUIfKfOCZHmJcG2rzVR92yConJtvdyPzjapknAD31Iq39oWsJoGiObI8s
 d9hJgBv4RJDIldozNhOgCfFDl6tmSdsnYDO/u5u07ADXMkm3f4kMLJtLZeqYuGqXdSuTv7RKI2w
 eEegXUxoONEpZwqK+GBdWQk2Bc23EK97RZTlbV534Tpi8U+70P3R0zNthx9neT+iQ82SqrwydN4
 J9OdlXjBFWSeDQ2v3o8OkbbOJBhcHxvgZswPtOgvQBtR/2+G1wtlNp0+fyzmzamnMPAtWUcFHUh
 cg=
X-Received: by 2002:a05:600c:1d11:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49b91c25414mr366990155e9.7.1788186565847; 
 Mon, 31 Aug 2026 07:29:25 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0e:1005:fa8b:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccea87e1asm145266605e9.2.2026.08.31.07.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:29:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Junjie Cao <junjie.cao@linux.dev>
Cc: dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com, 
 mitltlatltl@gmail.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260804073419.84727-1-junjie.cao@linux.dev>
References: <20260804073419.84727-1-junjie.cao@linux.dev>
Subject: Re: [PATCH v3 0/2] drm/panel: Add support for Novatek NT36532
 panel
Message-Id: <178818656440.2615924.7721380988384497454.b4-ty@b4>
Date: Mon, 31 Aug 2026 16:29:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Tue, 04 Aug 2026 00:34:17 -0700, Junjie Cao wrote:
> This series adds support for panels using the Novatek NT36532 Display
> Driver IC, a dual-DSI, dual-DSC controller that requires DPU support
> for MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT.
> 
> The first user is the CSOT PPC100HB1-1 panel found in the OnePlus Pad 2
> (OnePlus Pad Pro in China) tablet: 3000x2120, dual-DSI in bonded mode,
> DSC 1.2 with two slices per line.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add Novatek NT36532
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1c523f0a930107191c95d96340c69a295a086e5a
[2/2] drm/panel: Add Novatek NT36532 panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/47b823940e38607dad180eb2f82094ae65565a4b

-- 
Neil

