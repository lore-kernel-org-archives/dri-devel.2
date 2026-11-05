Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EA606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=OwWK/whC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017A4112388;
	Thu,  5 Nov 2026 12:06:59 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590B610E201
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 12:06:52 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3ae691283ecso315845a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 04:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793880412; cv=none;
 d=google.com; s=arc-20260327;
 b=CwjMMmxAJLVgD74UoL2U73BRb3bjkoxXMPQwkVEt4w168UZyk1Lb78zYAD2A1yS670
 P9t9zxIxyLONqGJ4U2rRY+xdNVlqv17yqOBCUc2/rM9AEq4gzV18QXXT7LgwjgDI5pBM
 o+34n+NPI8ExzVaylyW1vQgJHf4+CASHCl+VMeaNs47uBSToY83nSuPDhbqr6iKVgEja
 BulrQoywRS5hC9ZFTp46wOamkzERdZ2lVqfKYBVcIl9bcTJo/jX+wyN61poprt0OLVPW
 xM5HDf+9csCzZO1+9aPn7kGlltELpfuw9bQ1hHNsaQDAs0MSrzF7DKZsUHhqenO+DzR8
 NbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SIhqbZ+2HotYam7MjDXog6M4P1fIwOCZkrn6io6yVIg=;
 fh=XC6NruNe045Pd2HDzsLG1y+1o6iCQ9/yzobrWSK0Xro=;
 b=i90ORhetiwesWIQulv4pkKWGjeQcKbECutGwD3FdWfPVSjEYc4epjvDd0zjrIYYiod
 3xav8COYH9QUbrHHE54AapsMyMSfXTjoc2xBRZzAjoqR7lr176upFyVObZPsVb7C80tT
 V8GR27KBJYMVxPAKukZx+hIIq2QBJCWM8eGxDlUCasstGaiw1+xmzxGcQKQsTeGfftWz
 +EortDxBcPAewvGdijg0ecPlvILlYxsu2inJ5H++x2cLkT67DJ8lBS6/adA3GynZ9/nq
 L2HOQDs0mSlTKXtyuKsWtWhNls2zjPESvKAEGMqWOidvECnhQRmSII9XkyJsR/nmSbPh
 O/sw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793880412; x=1794485212;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SIhqbZ+2HotYam7MjDXog6M4P1fIwOCZkrn6io6yVIg=;
 b=OwWK/whC5y38oZCJjgp/SfvMzbmnKlN3bqEiErxAiwoMAVBDKjqbdZNG+o1BpcCzkK
 FvUpkk6kMIJpzl13s27OT8xdoUczLXfHM9cR9QhllBbZl0ZnvBzF9lOpauvsX56ZlClb
 FPYJqQCeeTWhJkwWJ6hM+9Aa6GNmhDEXeJg4cshmESuq2WbY0DQ6WVWtBy7eq88CmElS
 vHj6ORxPrcGQRCsrUoTnYVcp5zKZpElIBHRP0F30UIEJbpqGzmrt1iurkoC1zIZWn2i+
 yLdR9/wCAOrNnm32nPE0Zil2VM8noyVbQvtZ4BCmNwCMegzxOT7Q7SPKChrsMadqZv+N
 HYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793880412; x=1794485212;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SIhqbZ+2HotYam7MjDXog6M4P1fIwOCZkrn6io6yVIg=;
 b=RE+bF2m4LreMrcvfFQixpYyBnCgYKKA9tSsuECBeuR/3FnCNupOcSTm4LSQNG6FtfF
 T3GyAC1yQwe7G0qZvxwC4V4JBVA54caKoyq1IVGvO0LHALQH3OdTkil4jAtJROO+KHJg
 cRNy8Ou8jhds+i3PgllCZgesdVSd3EQldYTOvJC+7qcNqiAE5aZPcTiDREXox7297FrM
 0gkWETene+puTjNBWtirZrEotWqC9XL2C6rS/DUF6RgEjDrm94AEmbDkHcrChjfUPePq
 qs9XTq5Cip89egW/BIH1/uoMIVGcGshN3/JtlOtaVI6EHSYdUqt22eS9rT2zqqC0zj7C
 L0eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw//FzID30E7jV2iHxX6krq49lcUc3boq9NGCtz/RvTebycynEqFFHf2ll1V5t2/VTVHgoyjZMqf8U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8LhF6Qrjt+yhrHs4SAthxRSW0GcyzWHzyXKy9/l88goCSUlH+0
 9tKp3ZxzIllCEfbJn/n0OdrFT8Da6Jhs8vpuZBEv+ErCVJx36R1bmeULvXjIS6zQ+bZ699iSZCL
 qTgRZgYxAkKsOaDyRJXDCzC9AimUymckXplmRp/u2/Q==
X-Gm-Gg: AYBFou3BllHT5BD9Mi0hQI7H+x4d558iqq9kegAhx962C9E28onZGurUzJOt1HriMxr
 YRohBkdQIiGQyQx28ZVa8HSgNibnzAsPBSOD7ie1j2Si3GTwvMgHH6+HVXn7rIjRb7nYrHnoaRK
 7PVdPFe9sO0nWiZ90Gz4c0+wXHK4cszEsRI8rDMO8FD4c3Vnchi8T+tw4EyLy9ujATM3c1LXVws
 N4BgIFP4d1p7S3et+2IIdHapKqRIXROmtV4oUvrZYx+bn1oDXN3+TAqJ7+bLagRJhK+2iPoGqPN
 zuKvBn1RUsRySkkIrH4x3CAsdMksZTe4zbRZsiYUNSlbW8fDCXjDnDlP5Bn9P5ayKvY/Sw4CYs2
 70sVLStOOfAq9zxsRc2kvhLsCIAM23pGDInv7
X-Received: by 2002:a17:90b:1fcc:b0:3ac:7406:b49 with SMTP id
 98e67ed59e1d1-3b0afc29351mr1335407a91.15.1793880411843; Thu, 05 Nov 2026
 04:06:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-13-6fab0fe43a9b@collabora.com>
 <CAPj87rOMjFEjOQ9TVgbGWu3gTwVjmjuFNtnFiyxbWO+g_RPqeA@mail.gmail.com>
 <f9797a72-2fd0-4127-b741-dfc6cf3306f1@collabora.com>
In-Reply-To: <f9797a72-2fd0-4127-b741-dfc6cf3306f1@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 12:06:40 +0000
X-Gm-Features: AclHuK_ucWApughnWJGAl5cPjcPtGno9PpRPUGuTDrBVFiQWtpP0tMXmnOOScVE
Message-ID: <CAPj87rN0944v4OyeJ+VNn5QBsnPsjGJUvNqiFmQFsO_wakOX=g@mail.gmail.com>
Subject: Re: [PATCH v5 13/15] drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422
 output format
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com, 
 Andy Yan <andyshrk@163.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Paunovic <royalnet026@gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cristian,

On Wed, 4 Nov 2026 at 20:56, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> On 10/30/26 1:52 PM, Daniel Stone wrote:
> > Same question as for the VOP2: why only special-case YUV422 when
> > YUV420 also needs special treatment? And presumably in a way which
> > can't just be mashed into bpc, because the maths doesn't work. So
> > would this be better off being handled as a separate output-mode
> > adjustment?
>
> For YUV420, the halving is already in the TMDS rate, so the PHY PLL output
> equals the halved VOP2 DCLK - no special handling required here.
>
> However, since YUV422 is not deep-colour packed, its TMDS rate equals the pixel
> clock and therefore the PHY must get 8 bpc.  This is essentially what
> drm_hdmi_compute_mode_clock() does, forcing 8 for YUV422 for the same reason.

I don't follow 'deep-colour packed' as it seems like a non-sequitur.
However, the TRM is pretty clear that a 2x pclk divisor on the clock
rate is required for YUV420 and split-VOP display outputs, so this is
fine.

Cheers,
Daniel
