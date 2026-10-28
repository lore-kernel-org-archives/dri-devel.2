Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EFB60A3820
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JNukZkoD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07BEC10E0E2;
	Wed, 28 Oct 2026 16:37:53 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9385710E691
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:37:46 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c40e02b2ebaso185977666b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793205465; x=1793810265;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bf6VlzqIelltC4HInAeut/3dEsLUfeHdqWRYHEEbfmc=;
 b=JNukZkoDbcj2ymQELS20gTWznntR+RxqxMD/vwbI77miuVsG33nh3kv8v0uaP0ioR+
 Lrq+rFaH3Zo8kB9etAuBjRSZOsyKLrbtbncf2Txf4oLQ/gfctedJRRXvYul4hQ2R6rjx
 w168mCkOn8DdkfM4PM8xtniO5aM6l5mP2tpXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205465; x=1793810265;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bf6VlzqIelltC4HInAeut/3dEsLUfeHdqWRYHEEbfmc=;
 b=dtM1T2B00zssBE1YFbQAZ7AEUGx5wR0D+l0YOd36MMh0R9nL4jcTgxC3WcmQA5VVE+
 ItXOlp5QffAW7NP19z9RhRwFEBY2xjHrV+VO5ScKz7JIoWRw4igCO4JULBcHtoRZp/MZ
 bdiuHLYkzBuv5wRZWI1+c4J/9XEjq3H9P92RWPxg10gPwUtjWggZF2Gi0ZM6VgwPfjsw
 OBqbfKbMuQXXwikMdvIW5O8Odb0IJiMSA5Anwjma2rpkt6FhbS2UpXtC1XwLKSDqAgnB
 DD5AV0Jk20PNAWaDUAC+oVMzCZxDtdRiugjFFyFxcm1CN04dEDuv7I2Leb0trFK5Fafn
 y/Hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2uS5epJFb0HSGfSzp3d/+sV2YY1LFdyGyOjAEfReYpHz4zsbefP3JdvFEsw0bUPPhijSIBw3ua0Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL4Uj+Z2dPYoOCT7T6Fz+Uy/oqL6Gd68a0t3JAMa1z/6FVIDzzO
 12uf1x5MxK/R4Inrix/Q6OtazlA05ijwKEciP63mXw4LadpfOzpKtaLaBqFdV7mAUdGFuFmfU1f
 z2tgy8g==
X-Gm-Gg: AYBFou3+4DeLhI4sWaXyYG3AjvmkZSXM/3m5VpGaW8q2V3v6+wGU0+CsNSUTeHOArCA
 7dGoV3GSaGHHbVaO0dDWEbISq1hTM5EGmi9uXIfpoN1CLX/bsteeRpcpmStiwUGrpJqjqlOUE+d
 Py/29u3QrnSWNYjI9U6FSWrWpW9WWK0Ty8AcOCixdf6UHWW7x4G9J7l6fv/QEVPJziPxU2AUMm9
 Nem5H3AKpz/P9xYvnYIf9OX1CK5jBvLFoyutnwQV7rJWo8lYSuj3k2qklXBJnhqRjPWQIPwwKN9
 lNBXugD77B8ExQIGpMkCOxVsZHdeMpKw5d2apX2dqKMG4ptOVYKoFgShazwloP0HeqPrz14owBK
 CP9LBKgp2V8bVl+5pvyq/Frb3hcTqqsvRzNYcbfLYswhSwyYUuFQEEKavdi5v/1mR/xibzws+8W
 py5xROL2Z8S9MV6MFZXYbvjZ+bnOJjQvKHPRMBH0BF2rD0hFGAoyj3QXZPTNJfScCe1pGQ8qTYH
 eGbvtcNPNF8aBZ57vGaQ57SpuW+8YwNawpNpKYfb5z3LFwQxV/IhfLwhttVqfyBT/kXC4xXTlQk
 ajJP+SJQZ64oEl57jK/cZi2jelVHVq+BLWuqlkS4tT0AuGVX9YfC+lGimEHNLWikzl4oBhQg3/g
 6+NE5OKMezJ67Jw==
X-Received: by 2002:a17:907:7250:b0:c2a:b1cc:158d with SMTP id
 a640c23a62f3a-c49bdf67b9emr265002066b.32.1793205464751; 
 Wed, 28 Oct 2026 09:37:44 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c49a50c434asm313305666b.5.2026.10.28.09.37.43
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 09:37:44 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so800813f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:37:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxd8BaII7QUbCcSweOOLf5IQJ+5D0nBzc+NUpAczVnoFjGdOoSn8/oZWmhRGWuaLWyXfMvatGAe3sQ=@lists.freedesktop.org
X-Received: by 2002:a5d:5f43:0:b0:48d:f14a:9177 with SMTP id
 ffacd0b85a97d-48e5d5b838cmr7401457f8f.56.1793205462358; Wed, 28 Oct 2026
 09:37:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028080153.91945-1-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20261028080153.91945-1-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Oct 2026 09:37:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UTJx=Y0cj8Snhej4opuVdZtBbKgk0pi8VJap=mOSfo6w@mail.gmail.com>
X-Gm-Features: AclHuK8Rw9AaJVpQvgc6dBg2SyVzJC8J7fFPOQkaqeSrUGkiELb89y4WGXE1g4w
Message-ID: <CAD=FV=UTJx=Y0cj8Snhej4opuVdZtBbKgk0pi8VJap=mOSfo6w@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel-edp: Add BOE NV116WH2-M32 V8.0,
 PNB601LS1-3 HW:1.2
To: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
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

On Wed, Oct 28, 2026 at 1:02=E2=80=AFAM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> The raw EDID:
>
> BOE NV116WH2-M32 V8.0
> 00 ff ff ff ff ff ff 00 09 e5 10 39 00 00 00 00
> 27 24 01 04 95 1a 0e 78 03 0b 55 9a 5f 58 95 28
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 96 1d 56 c8 50 00 26 30 30 20
> 36 00 00 90 10 00 00 1a b9 13 56 c8 50 00 26 30
> 30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0d 40 ff 0a 3c 7d 0f 0c 17 7d 00 00 00 00 c0
>
> PNB601LS1-3 HW:1.2
> 00 ff ff ff ff ff ff 00 0e 77 10 11 01 ff 00 00
> 13 24 01 04 a5 1a 0e 78 03 a1 35 9b 5e 58 91 25
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
> 36 00 00 90 10 00 00 1a 06 14 56 dc 50 00 28 30
> 30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 3d ff 0c 3c 7d 0e 0b 17 7d 00 00 00 00 fe
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add BOE NV116WH2-M32 V8.0, PNB601LS1-3 HW:1.2
      commit: 21803a577cc692d01307102799f795a606871212
