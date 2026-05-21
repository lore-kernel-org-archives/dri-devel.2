Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9AECD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 16:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D865610E1D0;
	Thu, 21 May 2026 16:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ch3vvLdU";
	dkim-atps=neutral
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61BC310E1D0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 16:21:17 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-632a055fa9fso2327392137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779380476; x=1779985276;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7TyF/EJGvHCS2MVisqdtPtRiJMUTpIaFtZ3CYa/KXY=;
 b=Ch3vvLdUVdZKCY2wf3GJ3bAKS0qoDNzfCBLxQGfkIQ41I5wUbgHReYrovvbluvEZTf
 wP3tn3jIxu6QC92D/c9ceiVXrEODYpATQbd/OMN14R9EVhK1aPiUOC97R4Bw23pl9jcY
 ojuZlsiyeaOS15m0hrDqxzkzvz3Irrgl8MpAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779380476; x=1779985276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H7TyF/EJGvHCS2MVisqdtPtRiJMUTpIaFtZ3CYa/KXY=;
 b=ozP3CKGAK+YvvU6ddAgqk6hwGtX7lGganr+oVO+gxenoLuNyvqyElTySjmC4wxNQ2o
 XHFdRl5KfZvzaynh3KAuVgK4+RXaaKyUaPNF48Qc4T/f/DoF4E0hqC1E6/GLNsu408sI
 b45G9rt6M8SFMY9LXRZiHdfj9KFfG0eVs8PVVIWOWEspQV+9YvFvGHJwdexR/xoR6fWP
 mkdloO5k07HJ4ldtAD3FnaYT4zw9tWWYflx/VkMYh+wF2akK13UeMkKp271enxDAp/W6
 Xy9G7DUHsjDdTYvMd7iYO4+Po8ilg38OS3xXcum1tICQ2zVm8RkFfn//nyYPxbqMMXps
 tpgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9T1QZ+e2/eLyItwoK+Y9h5w7hQ6SBmel47uwivTzNXMOnfu9Fc4iPfJr/2g+zTtb4HCnxxHGQhymU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfhB83/IaSWsRXVzGjFuBh1h+/tf5ToGn7g7CptWo4tu4JKFj+
 7L27VAm4f0WYw9f1V9E3+QbFkLTJnLq2d3sQ4N59XIkeZA05NCI1ZKE9mejrdBtjORIv6uRNlEP
 v5ts=
X-Gm-Gg: Acq92OFdWQky+ImeHfuC/GLHXcpgh/6A6Gq/+h/2IO5G3qZ3v0gpXG4YL0h5QtQcZVi
 Syh8j3gSoHrcKuY6DbiiKLN1q71FtPGyhD9xb/2Kqnr4EMTrj8D8G9J4bPefszmMjzErudmrZ4N
 mLbN8mt2teJJ8TPCBuurl3iBGFJW3f7hszymzVyw3YklUzIOOixAHupwV9B17agJFLzdz+eTURT
 WfMZEzYWB/LTSEO3HDSH7YZuAMs/TUv5q1crzmWc/S6efgik5XzYe75Gz6Z4KanaJP0bqAvx+vM
 dkEg6PvV9XTfx0rbXYahpyA88NxExNkwxD79Wz6MP91tY0OZ0/kXGJhKG95ucm+LiLORA8JF6KN
 dlqfQ67QEtyFsLw7EmQlPU3T9EZKo5Wl5eljPwQUfcgkTCoojArlJc/JdzxRONYghtuSKZAOiEl
 Au+/QJIPpxbN9oAzMWxJrc1/BwwXdKdSoPj4x8QX3zJYQ1YVZiJp7TK+BJ0a7B9pKatg==
X-Received: by 2002:a05:6102:1586:b0:62f:406b:1baf with SMTP id
 ada2fe7eead31-6739b12b4e8mr2365722137.20.1779380476008; 
 Thu, 21 May 2026 09:21:16 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com.
 [209.85.221.169]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-679fa70c8d7sm1166407137.11.2026.05.21.09.21.13
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 09:21:13 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-57533363201so2002897e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:21:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ91j/j8SwzE1bbrstR7J8iVE8rRBpOfGtchEJQKW1iHTiEkrR7IMcmQAfteP3uIJvJa8vzlCVOLFa4=@lists.freedesktop.org
X-Received: by 2002:a05:6122:909:b0:573:a779:62cf with SMTP id
 71dfb90a1353d-5842700f977mr1997646e0c.7.1779380472617; Thu, 21 May 2026
 09:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-1-9df52552bf87@gmail.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-1-9df52552bf87@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 21 May 2026 09:21:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Va8xWkE3vSPG2rDnDqHHjjQhnGvQFbDCQ1gy7K9dOokg@mail.gmail.com>
X-Gm-Features: AVHnY4Jr92XPJH5Azjlc2EoNETWBXe5PFgKtRtjwUT48hIrAsQVbIHC8sZGU4zw
Message-ID: <CAD=FV=Va8xWkE3vSPG2rDnDqHHjjQhnGvQFbDCQ1gy7K9dOokg@mail.gmail.com>
Subject: Re: [PATCH 01/11] drm/panel: edp: Add LG LP129WT232166 panel
To: jerome.debretagne@gmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
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

On Wed, May 20, 2026 at 9:40=E2=80=AFAM J=C3=A9r=C3=B4me de Bretagne via B4=
 Relay
<devnull+jerome.debretagne.gmail.com@kernel.org> wrote:
>
> From: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
>
> Add an entry for the eDP LG LP129WT232166 panel used in
> the Microsoft Surface Pro 9 5G.
>
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 30 e4 b2 06 a1 25 10 00
> 00 1f 01 04 a5 1b 12 78 01 ef 70 a7 51 4c a8 26
> 0e 4f 53 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 fd 00 18 78 f1
> f1 48 01 0a 20 20 20 20 20 20 00 00 00 fe 00 4c
> 47 44 5f 4d 50 31 2e 30 5f 0a 20 20 00 00 00 fe
> 00 4c 50 31 32 39 57 54 32 33 32 31 36 36 01 23
>
> 70 13 79 00 00 03 01 14 56 16 01 88 3f 0b 4f 00
> 07 80 1f 00 7f 07 55 00 47 00 07 00 03 01 14 56
> 16 01 08 3f 0b 4f 00 07 80 1f 00 7f 07 2b 08 47
> 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 2c 90
>
> Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Touched up the subject line and pushed to drm-misc-next

[01/11] drm/panel-edp: Add LG LP129WT232166 panel
        commit: 31ac8899d1a9284fb50bd42c409f224788220e27
