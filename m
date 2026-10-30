Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257D606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=hmz+u0nM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A84010E23F;
	Fri, 30 Oct 2026 11:48:47 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CAE10E23F
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:48:41 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8a39e5161c1so371748b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793360921; cv=none;
 d=google.com; s=arc-20260327;
 b=rnBmbksMH5Li+mCJ6A3mg/akDgVVnh/bfGll9jMSODvopqzmRTjpaY3CqL2bmbuU53
 Okzwiy9OrW0XS3GnQYnK+V+SHvZpVL8qAMxRfum3iDqAr0+rMIlkFtjTompnBxb9+BJM
 iD0RksAGc2jsLpnFCNj9HWTtnAnm7Z0k1XXmVbA8UBCQCJEp25Q1gsrvXv1+AG8RHyjd
 zfF9406iLK1G0I6KKggpLHRDuFLpCb+5QCNXccDPYOAppatT5Tcn57NBiMOLh9TaFx8A
 1CKwc6wbivnDcB0RP+MFbCO+0itJqgkEQ9MZYjoHWbzLpUcBfXkiP7y//iI3Z7njea6u
 p+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rytTxuDwmZaxUvmFDOrr2QKEaKAyu/0j3T9Yur/Ie+Q=;
 fh=u2b5h55O+zBzMnjFpcYZThRe6PFJOc/Ipp/xU4Gj8X4=;
 b=G8YXuMcgTkfz4wMx6NYDhrsZShCwtzE90GffPWYu/ZMpxzyZSMSr7S/RZsr1iiu5s1
 o4wG3vbeiSCPJ0Bq9NzHIXGAmH8o0cdsJas1XzZd/twK0b46i14nK+TjcLjLsZZqhlYH
 dRGJF4W1FNGU+9LSEpc1TH5LhWcYRqll4t2lhScpAkhsd0dVQdZjhAiT2sulgd98DF59
 hwCROgcodbMANm030AzRJwuklNRD0hmv3pDr3JtVNn/dRqRKW6PPumR3mE3+wLTvdLGx
 qg8rFULkhxpFF8o+pz6NbSOFQsjb1D+CKKbIlqd3LQKfE1e3UYxgKsTjluaQBzWBUKBU
 u1Jw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793360921; x=1793965721;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rytTxuDwmZaxUvmFDOrr2QKEaKAyu/0j3T9Yur/Ie+Q=;
 b=hmz+u0nMLaua4Fv8I5EXUXTCfhVMUEW87ChxSLQi1Vz6TOzhJ/P2AP9PR8PrKiE5Mj
 pUFXdivUYUaysuS+WcjxvxNMcZj2iaMba6hGcdO4kbU/kSJE0+eTZB+gzilrlaSLJxqU
 r+PW5U+omvcyL+u2QUWBdHp8V0ioSKmaBqdxtMtcIhYxyaeC1vLciPvR/vMgViySLgVA
 iTKxGZvSfhiGvjABjQypeGV9DrFaLXL9I8RNOrF9pn8wd+IE2Eg3OD+l2yD+uJauap7p
 Uf2fi4X6b81UwTlUwUsAOFARH4AReh/J9ZEN99JlOcrH6tHtFLs2SsgpEWr5DebDxvu3
 UTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793360921; x=1793965721;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rytTxuDwmZaxUvmFDOrr2QKEaKAyu/0j3T9Yur/Ie+Q=;
 b=IS+pd4jiYSQsTqjkoUvRSON/xvDmV2FVX9juCj7qLxTBl4rkmD9TogxP1yNe0O/qmR
 Vd9b4wHonhfR7uHbvSl4nn+ZqzHxWDStq2LLFLuYLnQE/ik6DgsLjr5UebDLJS0hQwLt
 JsmFicvpxv8hxbspOIJUXiOIeqMvp9Qr0HAcal0vTQPhx7whYb4eE3vsnACil61jP5IK
 wuCjx406/WPG+C3fDK91ggiCj2ffISceycZ86t4+8QuwVcOZ0DOH7Bclzm8fYjKi6wBG
 ljjZxOhdbiEfZ10lvvI9q2imOXLoHL7/kZySmNrQJ9/IZS5X1jd/PY1zlf9VeLR2/v5A
 uAug==
X-Forwarded-Encrypted: i=1;
 AKwUvBysnqUJnggRditvGQyoCwV3eYiXPakq3t5jJyISbrwEGdqtD/MlYlh1XPmozUGY3XHs8i+99Y4migg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKhIR69uatbI5DTBCtYvSk+anoPgvM8idmELACGLxOdrYTwaZbu
 w++aZ5t4RipC3+VWiod7rmNRFSl5l5mIAw5UWClcMyQfGNe8FcDvtNb6bcp9qv65xPAQwlHKo12
 Xuvl1sYSZNGY04Jo34UOgnOi8n82Dm4UDgIQs0gWfqg==
X-Gm-Gg: AYBFou0Ifjyk21EVMzI6U63Yg7fWVLUCz8ChHekdxS34zV27LNJOLPKSkvREYGxvVZk
 1+g+7Dtw7le+M18nZ3C71uzelC+MoWBLbHE03A4jIBxgwJXbaNWouygbsCvTgS2RDv9UQm8f7YI
 hCQ6NEMQaUbvj/sD3NE1v1HIB7Zfrl48rxfeRa4quUeMZ5wcQ3L9n65CfjX5z5B5sQSW6CsQO5E
 DnlxtOvbXWzsJ4+7Zl+lyZklkeck88g/Anx8seT8zvEdBVefR2e/zfupGbDdSFMbRJ8sQvKdNgu
 qnOx1QoHQvp26iWWRnjN2SyxMylct5ob3jhS9Z/B3f9w5JFxqz8/dqqrQoanRJO8Kv4MsTg/WiJ
 51UVLJXMpaJU+BzLd/0vmWyPrHsnCyH1qjkiO28nuJKOqLY3l24XOsM3UPA==
X-Received: by 2002:a05:6a20:d10f:b0:3cd:3e77:1dcd with SMTP id
 adf61e73a8af0-3e928a7e442mr2014372637.1.1793360921012; Fri, 30 Oct 2026
 04:48:41 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-11-6fab0fe43a9b@collabora.com>
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-11-6fab0fe43a9b@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 30 Oct 2026 11:48:28 +0000
X-Gm-Features: AclHuK9bHaRXHNAR7u16We-RytuEmqtwRDDQT6RAcbrEMxFejcbNnPABR9ssHjo
Message-ID: <CAPj87rN7RWfEa_YypQq+quER7V6pt2A3q4fYRuUXF3_Ch7yL8A@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] drm/bridge: dw-hdmi-qp: Log resolution and
 refresh rate in atomic_enable()
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 at 23:51, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> The debug entry in the HDMI branch of dw_hdmi_qp_bridge_atomic_enable()
> previously printed the literal string 'HDMI' as the mode field, giving
> no information about the actual display timing being configured.
>
> Extend it to include the active resolution and refresh rate by
> retrieving the CRTC mode from the incoming atomic state:
>
>   dw_hdmi_qp_bridge_atomic_enable mode=HDMI:1920x1080@50Hz fmt=RGB rate=185625000 bpc=10
>
> This makes the log line self-contained and directly useful when
> debugging mode-setting issues, format negotiation, or TMDS rate
> mismatches without having to cross-reference a separate mode dump.

Reviewed-by: Daniel Stone <daniels@collabora.com>
