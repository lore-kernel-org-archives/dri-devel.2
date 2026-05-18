Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F51CCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 17:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B8410E345;
	Mon, 18 May 2026 17:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S8ZOWFIB";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2097F10E345
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:23:21 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8b74b460d77so35793726d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779124999; x=1779729799;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QbJKB2lw5vG8p4X0Zp1dtcwqkjeJLsy09spRbfmWxU=;
 b=S8ZOWFIBUVwY8ygHf3miHdpyVy03wHv28AwFLVNXVvAL/K2xmRMuyOxW0fAGCQAj+1
 a2AsAeHGWVq8tIv9w8Jp5fEck7mku229bZv5GvpCIkb+J9776rZG8BTylv6Y7AfCMqEo
 t3Mogcb2XcsFq6zH3WMbZLhCQF+JMaIhqItI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779124999; x=1779729799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0QbJKB2lw5vG8p4X0Zp1dtcwqkjeJLsy09spRbfmWxU=;
 b=KB+74cg89jSoE/OBzIgYNI/64FUFD9E9o2DyaNRAKXzh78kd9BnE7tJZKzsJIdRpqX
 yu0B0keX5n8pRaiI9egYQxQYyTjsto9g5ttXzrjqiq4I28X80aFRL0eoThsUxgNRUseD
 m3NUa0FHQ0+F6u2xgdLiILeH6F3srB9eUHML90BrrARojNi0lGxXiIDarbetmei11oae
 bkhlv/9VMY+zcI9sPFK/I42XqYDsSTqB7JY87OrgxhItWrhx6qc9F8nOIV/ZVRj2esQP
 habBnR6v0i2TV+dVZWCVCzjzvqH/ZpuGUB1tfgbNBqJJUhkLWCvwKbLz1kYyhIrvl/DL
 vMXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JM8bw+S5PKzudNzEr4BD7cM9C7lWfc8+7WLa1st0DfIR/s8IBHtXA9WjWHvV876xJHn4tau2txqY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPe9zHU0VR4MvPZWsUzYq5ufkEjDjegurJrzGeZJL6asBLARPE
 BwVO/ZBLyLJDDunDnrqhfgg6lSNKBjg/Vbns09c26WnBZ5c//X7GQpb0oFOIWO9bRoQKpEzH+P3
 dXoc=
X-Gm-Gg: Acq92OFihCO/kWPQzrklca+RdmRyH8bJ2LbArXnPbo3v333yAT+TApafPDdv5EWcZTz
 kim7SNfQqS17+8kIlEgnKnklwnOMZVSzDCEpBPY7G/YNqZPWIAIxMy4+VZduRtFvAbrQ8bK+5+w
 tHdrJxh5WRXEFzpp9fOKjcYsuVTU5jDgh3jMW155oKLp8bRdkrH1xExyfXR7tRGptuw/NBL9ofp
 3ppu7tzFolXtXoSNJXjSkAZo76wHtgMiJCVt0Js+Z53B4E9B0oXdm/0H1Z8/zen+cuQEwWcfRjG
 L47EZbcz/qH3cOFIy3VzTOFxKHwef8VAMOMtkDaV/L7585YQTCOumYuSmkZZ91Ki+/x3Q9Da2PF
 N0Pc8amULZDaEjB6jZjU5VMaqmBmIZou8/4m6qzZvg1aUofOuRgYEUIuIbS6n5G5+Ia2T8N4bRH
 pRi05jw2sC/S4f/HwpUj2eYE7sLOC3rgiY13MWcZ3lNltvvldrkJcmhBEPATkwnPpU0QK/FXQdv
 jAe
X-Received: by 2002:a05:6214:2f82:b0:8ca:21b5:2e3f with SMTP id
 6a1803df08f44-8ca21b54742mr167064456d6.6.1779124998941; 
 Mon, 18 May 2026 10:23:18 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com.
 [209.85.222.174]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca36096575sm61861266d6.13.2026.05.18.10.23.18
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 10:23:18 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-90d13fa59e8so273965685a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:23:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+rBNO/amGdm4b2ggXpma38HVSoHmayedOCjKe8INZkD4xsjwbHADHoQzzMrffv6uC9ls5knqqvtHM=@lists.freedesktop.org
X-Received: by 2002:a0c:ea46:0:b0:8be:1620:a95a with SMTP id
 6a1803df08f44-8ca0f67c3d3mr193127066d6.27.1779124505831; Mon, 18 May 2026
 10:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
 <9e749a3a483e4a3c684eac3ee6a4b241c94a0362.1778822464.git.harrison.vanderbyl@gmail.com>
In-Reply-To: <9e749a3a483e4a3c684eac3ee6a4b241c94a0362.1778822464.git.harrison.vanderbyl@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 May 2026 10:14:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W-T3gnhsPY1TPaShBcj6MtXhPntAm=ecZ8pK9aKg=LFg@mail.gmail.com>
X-Gm-Features: AVHnY4IADEBlAYng-Vk8ynfnLq-alsFZFnj4hN5gU5NdDYItYKJ7p8Mb41QcTng
Message-ID: <CAD=FV=W-T3gnhsPY1TPaShBcj6MtXhPntAm=ecZ8pK9aKg=LFg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drm/panel-edp: Add panel for Surface Pro 12in
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, 
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, 
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 jikos@kernel.org, bentiss@kernel.org, luzmaximilian@gmail.com, 
 hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
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

On Thu, May 14, 2026 at 10:43=E2=80=AFPM Harrison Vanderbyl
<harrison.vanderbyl@gmail.com> wrote:
>
> Add an entry for the BOE NE120DRM-N28 panel,
> used in the Microsoft Surface Pro 12-inch.
>
> The values chosen were tested to be working fine
> for wake from sleep and hibernation.
>
> Panel edid:
>
> 00 ff ff ff ff ff ff 00 09 e5 c9 0c a0 06 00 07
> 0a 22 01 04 a5 19 11 78 07 9f 15 a6 55 4c 9b 25
> 0e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 62 53 94 a0 80 b8 2e 50 18 10
> 3a 00 fe a9 00 00 00 1a 13 7d 94 a0 80 b8 2e 50
> 18 10 3a 00 fe a9 00 00 00 1a 00 00 00 fd 00 18
> 5a 5b 88 20 01 0a 20 20 20 20 20 20 00 00 00 fc
> 00 4e 45 31 32 30 44 52 4d 2d 4e 32 38 0a 00 0a
>
> Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[5/7] drm/panel-edp: Add panel for Surface Pro 12in
      commit: 02f48ffdf96c83ca3e6600fe5dec872b34b68775
