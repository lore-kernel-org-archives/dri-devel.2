Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A33606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JD87gYg+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD8B10EA11;
	Fri,  6 Nov 2026 19:18:01 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A69F710EA11
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 19:17:55 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b56c428212so1100715a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 11:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793992674; x=1794597474;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ymJzB0WN5FbKDzsluXNV7fmXp6O2GJpqiouyp8507gw=;
 b=JD87gYg+tZiKkKoDZKjNNMElNKagBRIqU4/BaugPvMIjkalmW3f/3jogYFKlHxIDKA
 pb3S6nXihMDIQZLBHzmZ1UW70UlKqlTWF0UHss+A2dyYpksyO2NoXMn6E2Tm3XlF5aKc
 txHtQR7siwkm/2aboU4wTLhtJA1WIaZAZKEvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793992674; x=1794597474;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ymJzB0WN5FbKDzsluXNV7fmXp6O2GJpqiouyp8507gw=;
 b=XBhoKIRc+qh3l8xTc12Dqe7kQA/ULTwQiPTssfU+SmAzjOaMHEvGmKkNBQV8SDm4id
 huwCd4s3oihjRgv7Hygha9swHaHJFnuLvk3UQdVq6sblO0sqkS5esmrroUi0fo4kVSGz
 7dQzaTFsiRablYrVQRlS9mbRijZf98l+8XWYqLmPdDK1tVEyz6UsuaYwBIklCJ2DVq9N
 qRHYkAlkVZVpGB5IWvHbOPrtOM2bEufSK/liejSYej2RsKH+/6xY1Swy/TyQr9JduSnE
 YzrAJ0xMOk3FaZg0hcNUx3gFGoQL81qBrld5BRUugdRCpC+6cNXnqkfzXJ1MmJkQEo68
 S0Yw==
X-Forwarded-Encrypted: i=1;
 AL+hErEeKbftMeyHPTilrekACT+FcQBOONF85tKnGvaXF8JaMCgtMIp8Lrk7SjA8ZvsRFGk3pTSbaBWPyAk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+tPid0sV/eIMwBzt2h8fawYX1Ux6Ndr9e8ytpWTZOmNJ1egBV7
 1vZhMRpk/hZfUZNAeYr52KVXtniSHgCWxz7Z8YfnqiG701Yicmw2aFuiUvDJBLZ5Js72EJKzv+i
 yELwy6E0O
X-Gm-Gg: AYBFou3mQiaTdzVdebzgPuPxQXTGV8hMZCVJKz3xha3CHNEsx7Dc2pi2weTrtkAI9N7
 eCIwvOo7FOEEbfWxHS3vTiNRkR+DAflF3L4m8QruPwnLICZqbIB+q17x7maCjPkJYH6sVAGLiYG
 yXFRn8chTyACemIbxGq0ngLaZW9JpAqCWjta7IUwEqkPw+3yLPLZg11/puv/xni+AGtqH283F4j
 VV293gPd3SCuik/62z3WpwBp6L59ohA73gxL7Fqwrhw9tzQyolEJxSFBMj8zINnv426C5PmR0k5
 piCiDakd4wLjN+LmbRN60u+hdYNi6XgvaNZfXQUO9GTSGAayYZ4bXKMDNQk/w6wdQlyQiD/+58w
 sMy1+aWM14LOHsHXs3OCPjJdZYMjSRzIuiWTjiAIB7RR2rpCdUChXEC9jVdk5Gk1xRDniFE6i+m
 91a2T+ps32ER+DfiacRAReLgtwVs5ztkh9lBtKM/2nG1W3ARUopH6tttC7tc0ZnjoS/FAqInTZI
 H+vpcr4XuMl0/yBywwBFkqLV1xwyKPnJ5MrnFOOFIiC47DkbegQk5ynQDog3QFkVc/w+WxUmUtq
 0S+dGgrRqolVVCeWNHtBryzshRCkmRkHT4kfUBmGVUhwKIzEWXPiRxmPOLTL++jr5T8=
X-Received: by 2002:aa7:d655:0:b0:6b5:6a24:6cf9 with SMTP id
 4fb4d7f45d1cf-6b5978230a0mr1885190a12.45.1793992673974; 
 Fri, 06 Nov 2026 11:17:53 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com.
 [209.85.221.46]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664b0239csm1066324a12.26.2026.11.06.11.17.52
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 11:17:53 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so648171f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 11:17:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEFA8DpFY389aUMciHab7gsyOevz72mwpvf0Jwja4C8mRTn3YS7Qu8RdLZZLUY3VTrDx490eecqm8Q=@lists.freedesktop.org
X-Received: by 2002:a05:6000:1869:b0:490:a3e7:8af3 with SMTP id
 ffacd0b85a97d-49277219a56mr7321822f8f.35.1793992671239; Fri, 06 Nov 2026
 11:17:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106-panel-edp-boe-ns140wum-l61-v1-1-4c9747ec9186@oss.qualcomm.com>
In-Reply-To: <20261106-panel-edp-boe-ns140wum-l61-v1-1-4c9747ec9186@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 6 Nov 2026 11:17:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UaXzyEbzE2iuz9_Sgsw8FZ9ueaTTwZkwgHFgLOJ-_dfw@mail.gmail.com>
X-Gm-Features: AclHuK-_kku1KjQXSkbP2droWmHGBLJtmBrXMtrNqV8mW9pN1c52FbMy49q66lY
Message-ID: <CAD=FV=UaXzyEbzE2iuz9_Sgsw8FZ9ueaTTwZkwgHFgLOJ-_dfw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: add BOE NS140WUM-L61 entry
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Fri, Nov 6, 2026 at 7:36=E2=80=AFAM Abel Vesa <abel.vesa@oss.qualcomm.co=
m> wrote:
>
> The Lenovo ThinkPad T14s Gen 7 (Mahua) LCD variant ships with a
> 14" 1920x1200 BOE NS140WUM-L61 panel, which reports itself as BOE
> 0x0d9d. Since there is no matching entry, panel-edp warns about an
> unknown panel and uses the conservative timings.
>
> Raw EDID of the panel on this machine:
>
>   00 ff ff ff ff ff ff 00 09 e5 9d 0d 00 00 00 00
>   0c 23 01 04 a5 1e 13 78 07 53 38 a3 57 4b 99 25
>   0f 51 57 00 00 00 01 01 01 01 01 01 01 01 01 01
>   01 01 01 01 01 01 10 44 80 18 71 b0 78 40 30 20
>   f6 0c 2e bc 10 00 00 1a 00 00 00 fd 00 1e 3c 4f
>   4f 11 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
>   4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fc
>   00 4e 53 31 34 30 57 55 4d 2d 4c 36 31 0a 01 2c
>
>   70 20 79 02 00 81 00 15 74 1a 00 00 03 51 1e 3c
>   00 00 6a 3e 6a 3e 3c 00 00 00 00 80 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 87 90
>
>   Manufacturer: BOE
>   Model: 0x0d9d
>   Made in: week 12 of 2025
>   Display Product Name: 'NS140WUM-L61'
>   ASCII String: 'BOE CQ'
>   DTD 1: 1920x1200 60.000000 Hz 16:10 (302 mm x 188 mm)
>
> No datasheet was at hand, so use delay_200_500_e80, which is what
> the other 14" WUXGA BOE panels in the table (NE140WUM-N6S and
> NE140WUM-N41) use.
>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: add BOE NS140WUM-L61 entry
      commit: 2d5a8313d9cf989b8f53a5689a96e891bf99fb2c
