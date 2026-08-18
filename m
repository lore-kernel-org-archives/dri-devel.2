Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DCDC5DF80
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6AA10E3F8;
	Tue, 18 Aug 2026 08:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xk8gS0MX";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFCE10E3F8
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:31:39 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-66c70f05859so6766072d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787041898; cv=none;
 d=google.com; s=arc-20260327;
 b=XdrABcGBzlhkab153fGr0R2mXCG8AObfeCLlibC025k3grTcAQAn8/cR205rM5bTLC
 CLtgyVrMiOWVg8Yy158F491/Swy/7eEbIN3IX2+Yvxm+5QLHlmKAaJYHF3I9IoXn4+jj
 MB5y1VyO45eBiAQMOdwjkP5vN4UdpUTFUggfiZv5Ih9hLv0bKuOaYwKetZbKI3ilx/5x
 HmrbBLoL55ZX0t2wX6aN7WqHn6VHh4acTU1eM2daAfzWEW8azTkH9V9SMcHHq/5G2tXG
 m4I/we5bRn2wCobyzg+2FVjmvzm6TD/zorVwP+FNftfAyvTEyRgj0HFOfR1/vBfKrbxz
 SrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dfdTY8Y/98iAgDoWrwX8Ta02qcU1bB1m8ST5vvrqUQA=;
 fh=KumhMlnpO5lvf/rNx6jghJ8XvChBox5bOfMGfRt0Kr4=;
 b=gveVLX5ihO7hIOuEiUbwJDnluLiHsAXJ3MMnBdDJ2jULfqfh6FcFrWA1M4lOyuqCe2
 8CsfYf+4Eq65PkK8iwEvw5d3ikHa+1VIkmeSI7kkFqGSm7AXRmFXI3AFXYRpyPcVirid
 lDq830vvzBLtnClLe5HMNuJnV0YY+36o55KVoWJeeczz2OFGBUcvjp0THXUZwBa5fQHw
 T7IYrOTIGvGEcaFO4bZgalWEWSgrbr+prmfY6mwK+2UPZrA6KMCixev1/c3k447qKi9k
 6O2ghTTgL9M6zkDa2K534lONBJ3gmhQVZOvACSkfDnzHPsvoFuoZhvkCsrCE6WzXTbLF
 FH0w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787041898; x=1787646698;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dfdTY8Y/98iAgDoWrwX8Ta02qcU1bB1m8ST5vvrqUQA=;
 b=Xk8gS0MX0HMRbu5sDO+WJFyCh4hoEAJYuuAs4UN1prWl8nVVtp0b8xB72cET72qJee
 kgAKEig/RAgkScH19ciKA4UruyZ2wUZ+nZIklOn5SB/bTRRjwaD5MlN0MknhdvkhJGXP
 gFWAZzYxx2hRY/Ll4RS5fdbAQkJ8V5e2zhTVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787041898; x=1787646698;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dfdTY8Y/98iAgDoWrwX8Ta02qcU1bB1m8ST5vvrqUQA=;
 b=SAcJ/P7EmbMg7k+34wYOmVJcWj7Nj5PuKQrYo7G78uFt01iMx1+Bs1VtCxOe4fzx3u
 wXeP+RQDtGxa62z/FzzexvZ1swdEtGkgKaWN6C2Hi6x3n2QPD+OTiFzOE6rtPRLEU8ZI
 6G/lGje1IK8+gBUnk/Aqo/G31V+QzypUM2rsjO0LLi3bs+Bl8po8IYGlAxuMMwD0z6IQ
 EXvwWYyymvT0d/IHUaS2BVPPTkup+tyMibTPghxOMNQSBKs7DxQKeU1huu3Kh/PTc1C3
 a0fBUiG1w5dF8YqzS4PO+51TCz5FyNEWHNeTw6Bn0WZfkNVV0TORdvFvygVsrhbKIyXS
 vrwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGUP9wOdOddcoejv3p/7VEzQir8rmipjhvlLWmSndDa+SPtyOdVg+42a1NWL7z9Hb2pcSOLOH0CRU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZ6beRSyziIJN0ScbW7GRrJbHFz8qmppyg2nSZc27GlBxnFldD
 N0zQl+QRdUABjSE54VliQKPLYTIV8I9m4y+/nfOAw1u/kCPNRp8ScRQ8mhEjDVFF0ZmN/019Aiv
 PfIoRw2HMesbS70zn3gzH1PQ/QBKQxhCIp7nozyHi
X-Gm-Gg: AR+sD11Las5wzVMpBZ/kxIFAyrIbTx1Wz+S8Td1Sb7C2LWPxefV4yYvkAauV/CJV3m2
 hteXM4tZ0ih/FTddSTdfhNGuAIHakJg6eVjYOFpN/AEpC+a1h9YHaa9D2nbcRNAue4VKAo5ju5x
 v/r2HyJy/jDKP+eVtwySzAsk+3NMbDAdDYFxdDkXIhC/H/VMzqPgqg/mL44dbtNFUWp3pvpKy43
 FFojB1um+WSgn3J22xR9tPo2/ZfxcJvJ3ueEaqxL3Dv2+4u/pjO/aU3u9cxLHin8j+CuUXI0rBW
 QAaSPsnYDYLWn15yuAcWJy6MR4dTK8IjeYE7vGmSicrsD75D2YB098OAn5K10zLiXdMLpQTIfQ=
 =
X-Received: by 2002:a53:c4d1:0:b0:66c:4efb:6518 with SMTP id
 956f58d0204a3-66c72baf01cmr8580735d50.21.1787041898396; Tue, 18 Aug 2026
 01:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260818020559.961335-1-xji@analogixsemi.com>
In-Reply-To: <20260818020559.961335-1-xji@analogixsemi.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 18 Aug 2026 16:31:27 +0800
X-Gm-Features: AcwNN1VGsFRcmxBd0eaQBErQ1j0aAV9aqPfggU0ckpHIe44jjjRliakIjKjafgY
Message-ID: <CAGXv+5HYKJtC-3Rj9u-9AucAYQiSB4DjR=Z1vv_fRuHobY8Cpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add right justify
 property
To: Xin Ji <xji@analogixsemi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 r.mereu@arduino.cc, bliang@analogixsemi.com, jhuang@analogixsemi.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Aug 18, 2026 at 10:06=E2=80=AFAM Xin Ji <xji@analogixsemi.com> wrot=
e:
>
> Add property "analogix,audio-right-justify-enable" to control
> anx7625 to enable right justify.

No. The standard DAI link format properties ("dai-format" under a
"dai-link" node) should be used.


ChenYu

>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../devicetree/bindings/display/bridge/analogix,anx7625.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,an=
x7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7=
625.yaml
> index 6ad466952c02..f1b08c6b4877 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.y=
aml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.y=
aml
> @@ -82,6 +82,10 @@ properties:
>      type: boolean
>      description: let the driver enable audio HDMI codec function or not.
>
> +  analogix,audio-right-justify-enable:
> +    type: boolean
> +    description: enable audio data stream right justify.
> +
>    aux-bus:
>      $ref: /schemas/display/dp-aux-bus.yaml#
>
> --
> 2.25.1
>
