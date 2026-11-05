Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E69606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=P97KjAJc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D957E1122B1;
	Thu,  5 Nov 2026 14:35:44 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5851122B1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:35:38 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8a058f74a54so867514b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:35:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793889338; cv=none;
 d=google.com; s=arc-20260327;
 b=nf7bw6x7AdTA2b8+icXQvpf+MGxGM9999d0oQIBVF/nP0lCCZ5WKszjLIgfG7IMrHw
 Sj2zQ8HFiZhNar77inYNlnPVeinib4tlPwY6N7JnKFmNmuo+PL9uNsREJKLOlOA0xD1L
 0YKE1xd1kcZ66GX4eYEr/S0YFhnOv43+28ogKhgF1PnuwhUU1OQ3oIPq5t90eFmWr0Z0
 jc3WQv3WosV6m8kLoYMaJqyxQtWQshP+ike8GQk+Wo38n7ePiaugpuxU6Ti4Wz5ntLRU
 Yc+Onwx2pcnFlKVwhl7laKI7NQcIRgx0IcHpU6J4a8zh1LCuEL9eVeK4hakC+OwqRt+D
 7TAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GkU9fJVYjw6koPkED18+RNmNCd0Pc4rVVHMltt2KuQg=;
 fh=0T6fVoE5b4hu48iX6C72BfKS8iaqGXuQPK9cIn/9vos=;
 b=V7T2PP4IOQSoOsW0YCzxFt0xMIQ8zmHxrUjXSM+bS4q2LQEXGAdqGA0e5q2I3XiMy3
 d05qgz57BDxVulLZI4VgNrZWIqZz3uCJbmeYFLh7dYqC34z9iVYPBzkdBm4xnuRreX7l
 v+Uh+wB3Bn+RfpDmDtTXzXwuMeGV0jLdoWnY7IegqbalgsUANksTsPYw3DE8bqkUoTpa
 qy4ITMsIgTUA32O/5/tHFmL++mepDwXHRsfgTnlH72jilm5eLMBBBpZp+Q+0R5ICgQmW
 n4mc0ZjZtxHuJlGLOcmlpNHOahfuXvtYd8VvmKBjxlB/H3y6VHNwbPzUC8Dz0bP0E5Zw
 bDWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793889338; x=1794494138;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GkU9fJVYjw6koPkED18+RNmNCd0Pc4rVVHMltt2KuQg=;
 b=P97KjAJcg18TUpaNe8wlUbpuriqyJvgulqSM2i/b+iRPpVMSBMIYnGlw4Wyq6ykjDk
 Xc/v71efPj/kzeRyi/BrVP5/Hf4Uh8fspZaINsLhv466kKwcgzgbkymIEVOLPpE+axgl
 o9DyAHzjsxhVuZiWBZwnfN4hVvrPgbGl4RoyDnthUYkC0jGVisJ6j6L7YWqik4GHTHeI
 jzH3l3TcmPmamd4H1T2d9NkqmBR9bA4Bv53fOUTiRVGs1HPapBKq848KrxklfXeyqiF9
 Q4FELIXpQ+pajU3YA4Tu9RZkA5d2ucN8AmQDgPuxCGaCwTkz63LlvPwfBk8HJdKWzAXZ
 1xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793889338; x=1794494138;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GkU9fJVYjw6koPkED18+RNmNCd0Pc4rVVHMltt2KuQg=;
 b=0Y8tQWTKAMqedNaF8BzIblECnpwl5ixZH1MkyDm9DJZ/ompyZKYcroyFFaL7M5Uzx/
 pSBEKTBZJ17u1oTWD+POGiPWPZsjmjiiN01tCCZVkPjVDnEpYh6CHcJqftC6Vu3xjAHX
 BnSswRRPrMonSoDgiIiuQPzsY7oKPqAVGoeXPSLTBiAC4mMQ5Y6CMPy0RFxn+yYViB2B
 IejzFm4tZkpCAWJcdCe54HRL35dWG9Wljv4zXifOqxDkcm1tt4AOKIEtOrneRB4q9NhC
 +LWW8RWDGzUtXz0J2hgJH+UHfYyjD89qkzb9f2lQQN0+nObyiGIlArfEYVm8+V3rT/hY
 FlFA==
X-Forwarded-Encrypted: i=1;
 AKwUvByG3PUCdhd9giGu0NDxm4qf9QLDVvbTdbsa6bg+1VrTGzIdWi529PyRxDFrSeujKWXZ9KCyq2G1A5E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z93LMvHSLGAgMyiAfqt2c0qGA9D2TqNtyMOqz041EnGF/0Z9SzE
 46KxKSiz95zYftM9uroqwJf/Czc/WpGdAnRq1wEdTgSXUC+jcB435KM4s5JJEW6em1C29o1l6H3
 AYILptMttH/kyOHpisZX03KHkL7nW4i4L3JQrQl4tKA==
X-Gm-Gg: AYBFou23yM1QVUA768J1y5Q8AMzxurCF/S4KxAs9SIX585dskLfOoR4Ol8MI8aS62o1
 1ljIzMeipxi8x1EoIDEsyDAAmNYfme5UvdOByFFMQX7gUwAjrfVnS9Py9RTbCUwNYcM/fQMwsPG
 fbe2w+scOXK7EpnTdR7dpo31DzX1BNZo7AVc5Gt+izNf8NAg6kqoc4MyvBVqAkdrugHLW3vwiNW
 nwRvwDis9x2Lw1TZI8nMw9tLsNRWom49DcU15J6897Ojwn1ZT6aLErTzTpd0B+9RiYbdDAihsjM
 m5mlBcj0l/oEkR9P+xc5pDN+oUB57qZFcxT7oupP061kSYrPIBhoWn9GHuCRfgKmzYg41W+UVZB
 ZH6QgVttHlBE0Kv2NE6NxgcwrpAuM8sPPg9YR
X-Received: by 2002:a05:6a00:330a:b0:84e:909:ac03 with SMTP id
 d2e1a72fcca58-8a9be48c598mr16519398b3a.10.1793889338094; Thu, 05 Nov 2026
 06:35:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <CAPj87rMQdE3eeUxGSb4oQfB4Adry6UV8CvhGoTKtdKGQHdSo4Q@mail.gmail.com>
 <81fbb960-abde-44ea-82ab-3adc054da836@collabora.com>
In-Reply-To: <81fbb960-abde-44ea-82ab-3adc054da836@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 14:35:26 +0000
X-Gm-Features: AclHuK__6TlodHOzyVdjm-UulEeYQ_S-cCkdzywOgk9TNIGTgV-C-tpWJDrX-8A
Message-ID: <CAPj87rOKJ_EEmSwkokjvqytgnzTi8V_EhtGywQHe7xeww+ECDg@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] Support 10-bit YUV422 and 8/10-bit YUV420 color
 format on DW HDMI QP
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
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

Hey,

On Thu, 5 Nov 2026 at 13:04, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> On 11/5/26 2:25 PM, Daniel Stone wrote:
> > But if this series keeps on collecting unrelated patches until Sashiko decides all
> > of VOP2 is bug-free, we will never get this series merged. Could we
> > please keep this series focused on the useful bits at the end, and not
> > keep on adding speculative new Sashiko-pleasing as artificial
> > dependencies?
>
> Yeah, sorry for that.  I'll stop here with regard to addressing further Sashiko
> findings, unless there is really something wrong introduced by this series
> (which doesn't seem to be the case).

Nice, thanks a lot. :)

Cheers,
Daniel
