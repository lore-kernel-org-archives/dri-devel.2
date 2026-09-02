Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE04CC624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E1410E046;
	Wed,  2 Sep 2026 17:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c65VC8Ha";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B95F10E046
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 17:52:55 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c160420289bso174495066b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788371574; x=1788976374;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dqcEgnSp496NGWBXKeWsq6JvKnN2nbWQ3UmoRMRb+5w=;
 b=c65VC8HaAAkolMPKXd1rXT//i4mElvmjptuRvZYindxsuoKssjQYnKcJYgQXqsRtlz
 kML4V+Gaa77BkAN71kn7gcIYp32O09gFA8/IH/xWrct6IpQLlNY55Zmv62uh0bkY2sAF
 bSjlouTSw3wnP4tgrIy4aKqX+XVvUft7+lQbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788371574; x=1788976374;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dqcEgnSp496NGWBXKeWsq6JvKnN2nbWQ3UmoRMRb+5w=;
 b=hiMa/pEQ6V4EDy5MzTlVPuhFk7B5XwIjIIEDlYgdRYOP6f/ucwl33fx/JH+DOCcX/T
 Z6SYRz7pBrImE4RslZ/cxjAQEW8eyorKFlHLX6rRC5FEGOfgWli6/yIas9wfzHBIkhx5
 BOtYMbUvtmI38Mi+/N9AWc5PCaXSZgcJ5dxFNDi2/XoKKIJPKIFSteD+DPUUUr/dMHQN
 Osw9dQW3kRy2t2pCMoleTypUbm45Vti3ZcIsj+69XAtfr/pOu8NH9ACc1JYN4SmlDrxT
 Lvad2OwyUwJBhd5KBGAnF42wG22a10E7pFwXS0BsEEbNoOHKbNCPr8DujFHmJMl+5Wke
 qhbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxY+48OZt81w/vh6kvccY2NUHstEgWaMbULtHo/X9IkABTaRYP45bHk6b1h7TPRKOcYbpG1gFszkA0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nIjedr3u38jZIjAeiFNYJlwP8TS+AriOVafpz6oR2254vzVusC
 qYWgRu2qPj925D7cSA8KcJR5VxbUCASVjqG+9+hTPw3bJYwpJMzwbXat57/QBPRybqrVD1fEEfD
 u2arHoQ==
X-Gm-Gg: AYBFou0whlTUFtpV4UzSTjRqIKqkWWpyIUDQm1L71kMPYWnjxYAwe27G6rpGsnvY+90
 oUxtoGe721QI4g9aYXXut5uMSsQkMBg5OxMJtXpNBtL9tqBTIdqIqD5nWxG8onAzcxiUwQ7ghqS
 VfYrLgQXQlNytItTDBxnNO0LpWio7GhJXzolsKrLQag7+MfeXeFq6MBqlAttOWKvQkcERhS10/W
 OiGZPRYAXb4Amywf6QaBOOVmHW9I1fc2irBqfRYYYH9ghZOeYgsmAm1pEDlK2N47zOdfRg9Zup2
 lKONYXdKv2mQuiTQnmromuc2gpHLw+PRids2BLHS7HijqCFYFob0bFgzNyZIj2p5QMsUAqqAQ7R
 /hfswD+JP8QK655jviOm+S/t3lhjwrc6wuqpBuD7PVGU3y8/gV8sh8Hw69i0vAEsriFxqEj4r3C
 gwh7XUNHfnOvry0J4dfBDGQNmfW+7xdlrGpNrwCOIi1Py09IU5oA2GL82VRLo/PiNAcd/5KQGJl
 NhlUQUzeepPEZdjuh7hBipmbL0=
X-Received: by 2002:a17:907:c5c6:b0:c25:2e93:289e with SMTP id
 a640c23a62f3a-c25d5508331mr462056066b.16.1788371573923; 
 Wed, 02 Sep 2026 10:52:53 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com.
 [209.85.128.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d041d4a8sm171369566b.54.2026.09.02.10.52.51
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 10:52:51 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49b9320423cso14001955e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 10:52:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzASxh1Phww9dY5bEcaBxn/6l6VeYhs4Z8rr4evjaROZ4rn3d9ksicVO/1pX3L2wqCuh9O+ABkz95I=@lists.freedesktop.org
X-Received: by 2002:a05:600c:1987:b0:49b:4d64:bbc4 with SMTP id
 5b1f17b1804b1-49ce58211demr106617935e9.8.1788371569940; Wed, 02 Sep 2026
 10:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-edp-id-boe-v1-1-f5e2c44255f7@oss.qualcomm.com>
In-Reply-To: <20260901-edp-id-boe-v1-1-f5e2c44255f7@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 2 Sep 2026 10:52:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXC4VyCdohiRVj52bavaQtesW13uyyXj-Li-ij7vo4Vg@mail.gmail.com>
X-Gm-Features: AcwNN1W_4cKZwuAryLEB2kcdCtNaHsnbG0L3B66rdonHzP6OA6JFUqslcE83jio
Message-ID: <CAD=FV=UXC4VyCdohiRVj52bavaQtesW13uyyXj-Li-ij7vo4Vg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add support for BOE panel used in
 KD116N36-30NB-A001
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
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

On Tue, Sep 1, 2026 at 2:14=E2=80=AFAM Yongxing Mou
<yongxing.mou@oss.qualcomm.com> wrote:
>
> Add the BOE 0x0b21 panel entry used in the K&D Technology
> KD116N36-30NB-A001 eDP LCM, place the EDID here for subsequent
> reference. Timing values come from the KD116N36-30NB-A001 spec.
>
> 00 ff ff ff ff ff ff 00 09 e5 21 0b 00 00 00 00
> 01 1e 01 04 a5 1a 0e 78 0a 24 10 97 59 54 8e 27
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 b2 39 80 d4 70 38 4b 40 30 20
> 36 00 04 8c 10 00 00 1a 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
> 00 51 56 31 31 36 46 48 42 2d 4e 38 31 0a 00 b3
>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 2b455369ed70..591e0ed03612 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2060,6 +2060,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0af2, &delay_200_500_e50_p2e80, =
"NE140QDM-NX2"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b09, &delay_200_500_e50_po2e200=
, "NV140FHM-NZ"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b1e, &delay_200_500_e80, "NE140=
QDM-N6A"),
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b21, &delay_200_500_e80, "QV116=
FHB-N81"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80_d50, "N=
V122WUM-N41"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV14=
0FHM-T09"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140=
FHM-N47"),

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add support for BOE panel used in KD116N36-30NB-A001
      commit: e7dee5c0ff819034092befc1cdba2e008a5c5ee3
