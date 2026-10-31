Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E1606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=sKu9laHm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD9A910E19A;
	Sat, 31 Oct 2026 21:20:59 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4AB10E19A
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:20:53 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b09e07e149so14563497b3.1
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 14:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793481653; cv=none;
 d=google.com; s=arc-20260327;
 b=XF9aRA/rPbh5FxgCYcQe0EIC0LmFonXl5xxd9kLZugfIsWIGBd3elUAx6M8I3a8aGQ
 2ZKSb1dA6T2tuel6/KWiOAuh4dAuj0ikcTZ/khCxbTEXG93k5x2nbLVTfHhjce+MkJqB
 qisM3fwNL47MjWs35+BduLzubMZ6yMgsbwtuTInMWcotw3lmjh92J/HChZh/za7q5F1V
 Onox/gWOa19Ivl39y3rq+bA6MB1Wh/umtucBr4+9UtmGHw2RGlJ/z5K1IG0cX1pDKMWd
 4jSiEyxBXGOl91QGZP+CvCf74kKjghbrNnAK/LSq6xJlF8qJuHTJH/IDlfze3fTn7T1W
 KFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ud1EjxEqe05dL8Y9bfg9SJI7KfE4+vpiplmoHtTB6gE=;
 fh=LvdLVBz3ykbjnJEN7A5maMPw5ohtZ7/GKOy5XlGGXY8=;
 b=VKwyTqF5NuKZmUqJCN0c/bvJDLrc+wNtje3O2Ttt77nTpD3oa1mdr2HxNZ9eNxRiJ0
 Z6cQ2y+r3nmlIzxVW9vZEghBvISSYqiZNL2kypw7cbXejPUq6Be1cXA4EVlRXqQbTNee
 vy1kbtiS5NOkBw8HGxvuI+56Xojz/eHGir/Wvxkwy4ZpUrqjOxjGuM5cbxrPHRdoIb+2
 OtVOsKjSy0DpEXGFTf3Efx3GIY/BERa5diLGueVKwII+QIbUs5JtvQi0kN3hTfP2xH7D
 Ob4V560KLxRQ3w37bl8/3FE50lrXAVJwt339nKXJclbGTlRzNb2kwR5iNySYdJf89xwK
 tSNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20260707; t=1793481653; x=1794086453;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ud1EjxEqe05dL8Y9bfg9SJI7KfE4+vpiplmoHtTB6gE=;
 b=sKu9laHmHwDGFqqIfaPgsy3D8zR/4x0M1lWPvMJ+Hp3QoqLhluYA/02HpVBVQR07CO
 BZoFrxdqJvRDvcxNLQaJuGYJXUSl4RMr7cfCJsqoiH6LLgeA81glsUSeDUhaoIMmBIOn
 WSZOKkJIg4bVaItZPKqCOc3fKq0dkZpnhoGSBEctEGTku5P47sxSPk9yFzEf44aWTVKW
 TiypkxLdwudQXM1DNAU6BUJ+yq7eSDUBW90sT+KnBcfrpyK/CzIGCY3SgxBpBlYXGZaK
 kHVAymhKxhrEnwbhcw7AHSm2DZvcfDCfRUufc23bWJimi+lCpd/ZYfuG0Jlf9TfjRnxc
 5z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793481653; x=1794086453;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ud1EjxEqe05dL8Y9bfg9SJI7KfE4+vpiplmoHtTB6gE=;
 b=UIFF8S4ZfK7gw1sjmjz0rXgUQgX5+lK73lsQT9JpDaxW1WNB7VZQcB/LS233HNzZ4Z
 MtOdDLQC1Y3rSvhM+IPbSy6+8OKnjY2eL6SEtUY+yCC36Hp6z7hn3x/d7p9FQDx6KPae
 Qip7Kj48IRXVi/vBl9Ywa8vJLM3dBNNMFhwqraK8TiTAVvpSUduOtoCKCzTbx3irQdQ+
 Z7FDkcqc8oCiEXlhD5VvnlQxILTrgsmco0ZLiI5YPRaNnNd+5xDc95vHRFruKdqXgo+d
 QMZT40K0ISBQAV/mvIdeWBN9pDxDNVxjahRFXYz7kkUMwPzaqOVKYsLOjlMaom62ADwB
 hp6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwemve7igbs0GZed3xqrHwvC0+77iHhwyN0H25MPNRuQBp+yFwiJs+2chQC+NHAlKuqzbL740nhg/Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+9z2RwR6jRV0z+JKtAeRkQr8Pyf8/o3PaNWlvJuTz5U2shAbpP
 ZvCksz8P1hJ00gmJUdszTlUd6EJvTFFFqI6ix+inC+Ss2K5t7ttHUnC6HsCP8lXYwEuWBQ6X4Il
 Oz4hPg4+cSKsL0ZI+gkrUGTzJtRAAks8=
X-Gm-Gg: AYBFou3mFsnQKYsndesbloaCS0hvbKmqsNkGUn1Liq1FU7jba/TPs5SJMDwHN2cE4Vn
 6G0i98N1/RJKqVRgnMS3wkRHZhduxOTWgQ/LL2boIUZDgvvA8chf+ivas+ewANo/T5Jb5o+4QLh
 pLHX26Qi6vC5WLXbL39juJUucViBoNGll3YgVSI4HRxibHXDjswx7bUx/VoEyD4aqqrX444sH4F
 LtWhVU/ACE7rxfx2319OEZYuxB1BkwyMOk+OEQlc4qmjM3rMYfGwo3pzyqU4d3qjURp/4Ia69VX
 0koP8CwfUavwOumP7Qd+p65egnmiEo/708kfLeY1Dr3EFElOVipnH1OCVUZ6XbBW7X6RlxRo0bk
 E2L7C4CUvTVaSPsCYeUEbv4FoQ+2BBe7HEEnOlpJqqnQ+QU7DWPEjzi2DTjlqcHOA0HyrtA==
X-Received: by 2002:a05:690c:c5c9:b0:8b2:9c74:5a0b with SMTP id
 00721157ae682-8b2b67c603dmr27030527b3.101.1793481652690; Sat, 31 Oct 2026
 14:20:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
 <20261030-drm-no-more-connector-reset-v3-27-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-27-30e71d92c327@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 31 Oct 2026 22:20:42 +0100
X-Gm-Features: AclHuK_1aBV6-GP554UtTNLhIhnLAZ8a7lXt6NTQKny-HERAzZi4MXk7N7DM8JM
Message-ID: <CAFBinCDqGoX-C=tSvQ_Onjb89ow+wrOL_P43XsoHRYfTgfHxOg@mail.gmail.com>
Subject: Re: [PATCH v3 27/37] drm/meson: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 4:15=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The meson HDMI encoder calls drm_atomic_helper_connector_reset()
> during connector creation to allocate an initial connector state
> needed by drm_connector_attach_max_bpc_property(). However, the
> driver only needs to allocate a pristine state, which is exactly
> what atomic_create_state provides.
>
> Convert to drm_atomic_helper_connector_create_state() with proper
> error handling.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
