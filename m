Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334E6C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6593A10E082;
	Mon, 21 Sep 2026 14:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MKEwlCrv";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA91110E082
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 14:34:33 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f1744fso5044107e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790001272; x=1790606072;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=up7la13N5P698qqLdVjKevYqSqg9Pb2eoFO9uiD7Mlg=;
 b=MKEwlCrvlO7JXXcb+sBdsm8Q2rgleihAyjDLa95lXaf9lVFZHB7nlsf/91bvjseowO
 SlUuhIUxvNePMMSzjP89syVye/+07E2NdqAcNZKihIKIVUp3P/8rrBYuuds1KKJ+PzB+
 3DRQo4W+NnneQB+9jg66ZdrMdy93YW5UkmxHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790001272; x=1790606072;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=up7la13N5P698qqLdVjKevYqSqg9Pb2eoFO9uiD7Mlg=;
 b=klzj2G0eXTcpja5nEHuJzf7z1ehdLD1VRr2Zu5b+iCpr52ZXAW2HfiquLPIUjyBAzS
 jFCpUGmN4jQwO9+VcE8KdIZGmH1y4cVK3/zCbNAyawURYsyuZ5oyFH9Wu9uG1YSJmHC7
 3xt0f+0l6j6EjHsRxKVbUGX4pqoi9tQchvFeM5Z/o4aPIokKISH8FmLT9EXjNTmot3YP
 K7yeAR63AuizQecPfNpiy4JVsCERdXdXpwo9CBbQgSby6/UjmYStU/N7xPrSwAwH5lfA
 FS76Yl+z+hq8hrMhGrvm8s3CObTsDoY7lLDX3tSyNrxwolmVeW558wYQh0esFf5xpwHj
 Vnww==
X-Forwarded-Encrypted: i=1;
 AKwUvBxW0D8FhiLfkLjYOFI0Md3BqefUi0DBJfE2nPaQfbZAoc0345klXcGAjP0GnavDIWw+sg5UK37umHc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kPulgpvk2z4nx1MIHS6FFlCTNjmEaCJ/l/KaLV40Qb0bfMflqx
 ZEKBc8rQsfkjnVNP4iCWtgG5aQexPcJIMsvv0HiJEX6kVjUJhj6yQ2oUC37I5YxLJLsNwBQ7rcq
 DpJFv7Q==
X-Gm-Gg: AYBFou0dP8PgpxylNiNfiNfy4z4Jxtv/ufT9Ag6Ah6jQ0xsWUKRTS6xCjERHMux1db+
 LCdxgQWtGmVwEFcMzxAXxefEDgUhL4XN5KeuSXhBrACSfH8alXkY30JaTkAXGx3ESkB5D1LaZLK
 sb0X7K7gtY86RbpXDBsTbTGWuZYwNmngbp5nBmY5P3cJvN/aeVlaF9mS7z4nb6tBwg0nK79ne7R
 /naW4G7ipN/tqUT0EC9hk8p8bPZUNG9U2QfsSZSwqFApd038OfjkHJyIOsX/55YWtsqJ0kw6b4H
 zBNVV9dKblyVwOjiUM7i2M9CTBTzAi9+Egu6p5lomjg1syKdA4D3Jsrfb7n1GXEX+uEBzWUmtwR
 zK2u6wNHvVkuKzXjLxTZoj0vXaaKgrB0+Kbi/5WseMRChKjbZZaMq6o9rn46HFfpgacSnNUvC53
 7YRitKWM3oaA5eSJxoxcqxiiFu1ou0sRc2iFNS6wHhx0BBsGn4PohhdV4L4DoZ5AlwlTVxL51Ir
 p1wpSVVPpS3fg/0yhK0Ql3Xz12q2UwZNePgodQ=
X-Received: by 2002:a05:6512:1384:b0:5b6:183c:5c98 with SMTP id
 2adb3069b0e04-5b8c194e143mr3525027e87.54.1790001271665; 
 Mon, 21 Sep 2026 07:34:31 -0700 (PDT)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com.
 [74.125.229.204]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8c85c8833sm1978254e87.63.2026.09.21.07.34.27
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 07:34:28 -0700 (PDT)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f17452so2451112e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:34:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBw44Zog8nO5zkFa7qo+FQsile7D/WEsvz80iQNUfc1xMiFMpd/SmPAUuvCIWQEpHDYgyNxOjowGFts=@lists.freedesktop.org
X-Received: by 2002:a05:6512:33c6:b0:5b6:177f:b86e with SMTP id
 2adb3069b0e04-5b8c18055camr3271431e87.19.1790001266246; Mon, 21 Sep 2026
 07:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260918120515.595782-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260918120515.595782-3-srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20260918120515.595782-3-srinivas.kandagatla@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 21 Sep 2026 07:34:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1wkKjXi06HDKtmCZfBSF-mrUphFSUHZHz182Lv55GGw@mail.gmail.com>
X-Gm-Features: AcwNN1XkYY9zKiJQugffglLcLBvktTTAOkyuKYc5ncbh4pswEfbFSP6yXWFImyw
Message-ID: <CAD=FV=V1wkKjXi06HDKtmCZfBSF-mrUphFSUHZHz182Lv55GGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/panel-edp: add CSOT MNE007QB1-1 entry
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Abel Vesa <abelvesa@kernel.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

Hi,

On Fri, Sep 18, 2026 at 5:05=E2=80=AFAM Srinivas Kandagatla
<srinivas.kandagatla@oss.qualcomm.com> wrote:
>
> 14" 1920x1200 IPS panel used on Lenovo ThinkPad T14s Gen 7 (Mahua).
> The panel identifies as CSW 0x1465 over eDP AUX and is not in
> edp_panels[] today, so probe falls back to conservative timings.
>
> EDID, read over the panel's DP AUX DDC bus:
>
>   00 ff ff ff ff ff ff 00 0e 77 65 14 00 00 00 00
>   00 23 01 04 a5 1e 13 78 07 37 3a a3 55 4d 9c 25
>   0c 50 55 00 00 00 01 01 01 01 01 01 01 01 01 01
>   01 01 01 01 01 01 35 3c 80 a0 70 b0 23 40 30 20
>   66 00 2d bc 10 00 00 18 00 00 00 fd 00 1e 3c 4a
>   4a 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
>   53 4f 54 20 54 33 0a 20 20 20 20 20 00 00 00 fc
>   00 4d 4e 45 30 30 37 51 42 31 2d 31 0a 20 01 6a
>
>   70 20 79 02 00 20 00 0c 40 8b f6 65 14 00 00 00
>   00 00 19 00 21 00 1d c8 0b 5d 07 80 07 b0 04 00
>   3d 7a 54 cc 94 99 66 52 0f 02 35 54 00 80 00 80
>   00 80 12 78 26 00 09 02 00 00 00 00 00 01 00 00
>   22 00 14 0f 5a 02 05 7f 07 9f 00 2f 00 1f 00 af
>   04 22 00 05 00 05 00 81 00 15 74 1a 00 00 03 51
>   1e 3c 00 00 00 00 00 00 3c 00 00 00 00 8d 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 11 90
>
>   Manufacturer: CSW
>   Model: 0x1465
>   Made in: 2025
>   Display Product Name: 'MNE007QB1-1'
>   ASCII String: 'CSOT T3'
>   DTD 1: 1920x1200 60.006199 Hz 16:10 (302 mm x 189 mm)
>
> Datasheet was not available, so timings are not datasheet-derived.
> The delay_200_500_e50 preset matches the sibling CSOT MNE007QB/QS
> entries already in the file.
>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Pushed to drm-misc-next:

[2/3] drm/panel-edp: add CSOT MNE007QB1-1 entry
      commit: 8a43738e56d9eb76a573cabab4c9c0e73eab23b2
