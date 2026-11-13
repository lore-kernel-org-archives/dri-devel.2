Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84392606A330
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=L2MwCXvH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF0110E551;
	Fri, 13 Nov 2026 20:44:24 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FF810E551
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:44:19 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c45551fa84eso358201366b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794602658; x=1795207458;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+uv+L7OAudjAmToaLXTh5oGW0PlHMIwK3Z4W9S5viPY=;
 b=L2MwCXvHvYCLxV/qfKEIjoQb8RGgEhZadP/TkTwEnHy+rxijfyMiyVCmLSIY8qH8++
 ZCqpJcw9rXWvNXoZqDz2BhHZpcmMmgjkx5E2zznv9oObesbxJydVu0Qxo8axgloXNW5h
 U7z+3vW8SfqGwDjxpvzLpIxJx6+QXKVK8I19E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794602658; x=1795207458;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+uv+L7OAudjAmToaLXTh5oGW0PlHMIwK3Z4W9S5viPY=;
 b=RFcniDGIskThWm5E/l/vSHxXLypa+AjSH2uBeDwLRflRi420/NzfFzgeDLTc7hCl5s
 zldjXEs4xcBURF5wFPzolzBd1WT1+EFb7XeXmqHF1zAyGMgTpRmxdWhqrTki+rhkR9Tj
 qkebgvdxmtYcNansrYdOGf52T90QpnyGUUfJNck9/M/AZjMHcmKVgMSJg1tJWLkMgBCY
 dYMvjpwfx2jhmez9wtsdYRksshHRD9C1hZWkY/3vRccaN2jv8XNikXtim8o7jLKfvNbK
 ktFz1C57y5Q2mZ3b3iVzfydgRzQRWZ/sSVWFqb5y2+1Xvx3/T0RT4sF0mgneFz8d0YyK
 P0Pw==
X-Forwarded-Encrypted: i=1;
 AL+hErGGj34IQKWPy1M8Y2/PsGhMN+9T/X2Ap9A1w6UFiFg3o0kMg8deSQLpe8W9azEIWrYHNnv8rh4h/gY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8lohUBTmQD3bJ0JufCT0KsQz56+cp/d9sIZb0zy3xrVboIePaM
 EmHfgtqQH9sP2U3SBOz3vZzOpNCHK3XLJ6nmZIIGegxPvlj9bhEYzsOk67C0++8sAVTZXnhPvlJ
 4fGPUux58
X-Gm-Gg: AYBFou17p+XWEHWrzv9gjPchWn73NY6kTk4yzcs4O/LktpGkV/3BMxwBDFEb0eP7DHP
 LOdl2bme0sHLF2OPvdlDNOkkxQKK+sk9uQcKSPfUJyTZU55h4Pwz0ca9BULHajk3XSbaIsV0JCv
 l1LpT18MLYlTi/1/W0GBk5eT1YmDvzryRYFep4Km+gzeiMxyKlHpBTrSrg7dgc4IxzZtLCpzY+I
 9dHwFG30Abkr/iJjlxFVlrMY9Nfr6P4HZagnMR7kDLKnVXOVvxGUbCRVvgs3AlXbt9ZnpYv3s5o
 v5+ZpwAQRDnG4pHvGn6ojp53IPvPXioGC3csQXhEMp2OOmWpTqo3Ejtmj02BvTW5WJSqhGrZBqm
 mnp9yAbWCmjiebKZe+WSWIKgOnf9jg+04hRcxYfwkF+kMDZgsOcwnk+yxsCk8Ni0CiAM/+Kmt2k
 sYowiVx7HifFabSO9UubOJik/aVlrB9jgijeiSxZ/N8Jt2gsbTtt4ow1q+5HaQftrmpXjkgK3E7
 aIbxL/H+0qYgKlbfAvqhojMp475u6YX7P6uBVDeGm8fsp8Cw/Huir1tacsrUMrmHeDyHk1LFf/d
 l6SAyc5WZMvr2YhVX+oe7wztzVUeFf5SGohrUcWLxuLG5+H1Rx84nJTUu6vfOTpFTbfa9s1Cc20
 OFmVoqjKfaAXTZQ==
X-Received: by 2002:a17:907:868f:b0:c40:9839:c892 with SMTP id
 a640c23a62f3a-c50963ce13bmr335751066b.19.1794602658062; 
 Fri, 13 Nov 2026 12:44:18 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com.
 [209.85.221.54]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095a5c78asm141942466b.10.2026.11.13.12.44.15
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 12:44:17 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-491aaed7565so635265f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:44:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGmSPYwnPq7dBOJOob0nROz7X3DXo1mtaMFXH9QYbAegZMYtoSUJZlcyZ2guiB4wNWoxAZGWnQOYt8=@lists.freedesktop.org
X-Received: by 2002:a05:6000:288c:b0:49d:1ce3:1849 with SMTP id
 ffacd0b85a97d-49d1ce31d46mr5760381f8f.21.1794602654360; Fri, 13 Nov 2026
 12:44:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110092112.4262-1-architmore303@gmail.com>
In-Reply-To: <20261110092112.4262-1-architmore303@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Nov 2026 12:44:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XawknyTLYf03ZqZc60BDsNEDxAstnkV4QgYCeK18jDhA@mail.gmail.com>
X-Gm-Features: AclHuK9JxAszYSinmvA_zJ13Hp-Zoq-_E998DOGudeZBRwUONg1E-ifiWCpJu88
Message-ID: <CAD=FV=XawknyTLYf03ZqZc60BDsNEDxAstnkV4QgYCeK18jDhA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: kingdisplay-kd097d04: Use
 mipi_dsi_*_multi() functions
To: Archit More <architmore303@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Akash Sukhavasi <akash.sukhavasi@gmail.com>
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

On Tue, Nov 10, 2026 at 1:21=E2=80=AFAM Archit More <architmore303@gmail.co=
m> wrote:
>
>     The mipi_dsi_dcs_*() and mipi_dsi_generic_write() functions used
>     by this driver are deprecated in favor of their _multi() counterparts=
,
>     as noted in Documentation/gpu/todo.rst.
>
>     Convert disable(), unprepare(), and prepare() to use the _multi() API=
s.
>
> Signed-off-by: Archit More <architmore303@gmail.com>
> ---
>  .../drm/panel/panel-kingdisplay-kd097d04.c    | 50 ++++++-------------
>  1 file changed, 15 insertions(+), 35 deletions(-)

I didn't look at your patch in any detail because it didn't apply to
drm-misc-next and I noticed that it appears to be doing the same thing
as the already landed commit 7877fc6d086f ("drm/panel:
kingdisplay-kd097d04: Use mipi_dsi_*_multi(); fix minor bugs"), AKA:

https://lore.kernel.org/all/20261012-mipi-multi-series-v1-2-6a29add1ec92@gm=
ail.com/

I had some follow-up requests for patches in that series. You can see:

https://lore.kernel.org/all/CAD=3DFV=3DUSBt_pE--C0P1=3DPZt+iaoTpgNebZ+DXP=
=3DdKb-8VUcoVQ@mail.gmail.com/

Maybe you want to take those on?

-Doug
