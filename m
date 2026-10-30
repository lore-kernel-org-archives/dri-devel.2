Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B45606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=jsOW9vMC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8B511276D;
	Fri, 30 Oct 2026 11:52:55 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064B411276D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:52:49 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3ac9f49b984so358339a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793361168; cv=none;
 d=google.com; s=arc-20260327;
 b=hQfjKtHaUFPpy8eHgfXV3dBh77f1Sjwsjzwcw6XIs9yfTwZ/wUzlzbACj6DY74XaRC
 K3ljRuzgsZ4VTK8U8QxhfDO2gEAbgrTZxbmksRgtzCGKMIngIKS07Vody1QkvN0qitQj
 e/MkdZouFd5JLOdq6NQCtynPs08X8nAXHruM7RzOMX9NxDltdrue56rofcax1xS2sNJn
 rlkjZxsmomN3EKBZLrQxE+qK0gyxjMJbcZ/Qz7Qr5FPgvAn8bbF/gJajZI91XaeIa1+6
 wUkwLUkpwbo9eJ+KqbNSP9raJKXmvHO4KdfRXx5iaE34Tb17rplA0evyuqZtMLJmrowU
 194A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/PX9RtW2X0oN+uy2podVJ42Ja19q2gn1FASRjTAuuRE=;
 fh=H9Zrr+2u6mAIO2qwhg4jHNWYOFOi53Fh4oXv9RSUyXw=;
 b=HbADVXV8tk4mOy0pfcDKe2I00gm/IQtZglvy2Gjdm7agM7KClYc1wfhfyWoj6dFul4
 ofN5SuszQOc+wrFSGM3MQOnK/hZTYvbbHRB9sy5kKgT4VPtdpJbFIeY24phmEB3QSQ6Y
 08HQ/TCFJpnCLyi9sRr60OYg8Vy1n/MPzgchS3HBm9viQRckD4fNumpdAEdTcTjZlnxe
 9PGIdczg+MbRvZN4E/qiNUtvRnZiM9E2q3Cf2BCakXYurUsxtQTPIqg6cZeEsT7OSSOL
 qsQyOdeYghWLE0MJzLAavfmBk46s1x2pXeoov3/oVAVOJAalSwzythgIPfDaUnideiow
 kNuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793361168; x=1793965968;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/PX9RtW2X0oN+uy2podVJ42Ja19q2gn1FASRjTAuuRE=;
 b=jsOW9vMCaCDZ0LWwn+7CV0PddgYpQaTUed8uVjQJcLBcr4006+waIp87gql+9x57RN
 Gfejw1ZDRI10hh45Dp18MdcEdurz3P9LibIF4R4S1iVssZogY7PQWb0Kp2rriBKXdkk1
 85kdm++PwkuCun8jC783BMqGF8MBKpxDHxSAw6njdM+ukLKLGOnEOMPabaTfLWVmURMN
 n+u5r1xUpBqZEQ6TJkMHk24KnM1jA6S4Iha7WHAjAZRpFHven5gbRGH48ih1X14R3Mmt
 k7KSPjwjOA5S+LNEtcMwvfE6MVOmsLaPKcdHoxCwq42otkIjyHWgcVRqXaoLFrf2pANY
 H+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793361168; x=1793965968;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/PX9RtW2X0oN+uy2podVJ42Ja19q2gn1FASRjTAuuRE=;
 b=gcsuf28qrq2T+MqK8NBH76o6elK4OJv3tZoPVFVf3lGGK7RhbL5ee0zg8Wi2XyHmM1
 JVsDJtT5c8qmX0g9k+3bz6yAURCbZ9qha0J04YOTPntvtvBwKzVEtbMUdXftpcF3dqn9
 gXnJrSjTzvXgtU1pSsKJVohJIYe/ZHfUgAccWYFZkvQrMWIHqx/aJlqO8aOjDw011JNd
 Fp/WXk1ZxZhsCJO/MAiZGAN55wiqQoQSsshpsVQUo8hf+lgAbPIzjUgxQBQNILS6IH0U
 Cemi50I8R/cDgdAq6hYb/9IoGIV01Hu9CVJ1nOSdWViDikZXPzOmnvFNUueO0R5AWcTC
 GKyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVwdnUJBRo/f103e+zVKqSt2wW/ye6oc6hHcQm9tAc4ocJ9aSmsbbB75IqqRDZIOFrsLqn7JwGqkI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKT/UI47kvKoSMamQThaG6bTV8fES6R2OA+Jng9A+Xsk40cyEdZ
 mwdY+o6BJxMM6+7xKvskoa3pbbO8dKCSj9Z6bR37SODw3fmZg541bg91B3a1HnhBSwplPdIbXZg
 +YKBpTarDr8yWzBKP/Ca0YHoWXI7LuQGbC+4aFhT/dA==
X-Gm-Gg: AYBFou3ozwYB4iCjPcctggRnT1ACkHyk/Z+E6CI43tg/OPXH+OqSbRngpvyI8+znBHH
 1rmnMXgutUct/0RjJZjoFdtjomiXoAWf0KINTkl9VZhiGd6si4oTi7seTEmLsvHxRQUaWxcrKW2
 ukqWWYRok4GJxH/Tk0u/w2o9EOb4lyvSdaHkG12O/ARWFfUt2TM1QTLyOgv2Ua6gz6p/qSYPrlj
 ViqIYteppgs07qhMJyTXfOjfWlL9caGBaFhpHl0gMPFGMVksZlYZLQf9Ik11jlNAUdDVEfAxxaH
 mLdy7oM3fkTc4IT/9Ux+9ATr9pUzE3WyPNmwhLWow/sA5ujDOA2itO3+9urRY9wd83a/jEAsOfB
 rkEM47zgiM9J3LH0ZzHXGirIA50SYPOT2wM5O
X-Received: by 2002:a17:90b:2f0f:b0:3a0:e568:ed63 with SMTP id
 98e67ed59e1d1-3ae896d7af2mr1070361a91.8.1793361168540; Fri, 30 Oct 2026
 04:52:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-13-6fab0fe43a9b@collabora.com>
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-13-6fab0fe43a9b@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 30 Oct 2026 11:52:35 +0000
X-Gm-Features: AclHuK-idMrAXuG27Lf8hdgtB5yVIMARZUjc-ne4rm8j_v5CZmkmZ5d54vPJbms
Message-ID: <CAPj87rOMjFEjOQ9TVgbGWu3gTwVjmjuFNtnFiyxbWO+g_RPqeA@mail.gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 13 Oct 2026 at 23:52, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> @@ -229,7 +230,14 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
>         }
>
>         phy_cfg.hdmi.tmds_char_rate = conn_state->hdmi.tmds_char_rate;
> -       phy_cfg.hdmi.bpc = conn_state->hdmi.output_bpc;
> +       /*
> +        * YUV422 always transmits two 12-bit components per clock cycle,
> +        * regardless of the color depth, which from a rate perspective is
> +        * equivalent to three 8-bit RGB components.  Force 8 bpc here to
> +        * keep the PHY PLL output aligned with the TMDS character rate.
> +        */
> +       phy_cfg.hdmi.bpc = (s->output_mode == ROCKCHIP_OUT_MODE_YUV422 ?
> +                               8 : conn_state->hdmi.output_bpc);

Same question as for the VOP2: why only special-case YUV422 when
YUV420 also needs special treatment? And presumably in a way which
can't just be mashed into bpc, because the maths doesn't work. So
would this be better off being handled as a separate output-mode
adjustment?

Cheers,
Daniel
