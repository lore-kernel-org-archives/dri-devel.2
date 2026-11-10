Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18646606A339
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ih23mt5/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E9210E938;
	Tue, 10 Nov 2026 12:39:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3E710E938
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794314365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUu0h9arLHi+h5Yn+kYOg06kGKRl9ThCJwlOdeMMI08=;
 b=ih23mt5/mkDp5+ZpAh+H1dl/mORgP+E21Y3hGGD0hdOeGGlDc/9YHQ6PXkpr4aWqTmLnjB
 QOuzS1IiAN6HtLscXiQX9yOAvxDjXha4fsDbcJ5/47Ps11f0EgxCbMdvxk0k9yYmrzci4y
 +dUWL6XtOTdc1IMEWSHJ3W4s79Hj1x0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-1ue-F9H2N4-vvZQwxcGGFw-1; Tue, 10 Nov 2026 07:39:23 -0500
X-MC-Unique: 1ue-F9H2N4-vvZQwxcGGFw-1
X-Mimecast-MFC-AGG-ID: 1ue-F9H2N4-vvZQwxcGGFw_1794314362
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4b64722b5e6so23331275e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794314362; x=1794919162;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pwtPeU2sWzznNclKxCvFDxDPXTNBdV+ezO5+7hunkSs=;
 b=gRCgLxpY3iKaiL1v0NTqMCDEXJoMWwWFSIcoW74e5+0LYEZdPVnUXhPe5PKneuzMD6
 SmKpdJuHOrsaMLqilVdBl6NDEo5Cqm6uPB9LfiM8XSBQC7SnXIw/onwwBaAj3DBOJ4iM
 VJAFkxCIU4+JNIR3lxYOfh8tOZIJy0g4gLWIUiRToRJ5LjM5aBAXbUgYX30DyV1RhFFJ
 u9JVsMORSmEJlaA/AN9qQnp5CSj1063BXFWdcwODVihP4OHmZDjkmG+vbDfx71+9Syzt
 VQxoKRJAsyWE/p0IhBERjmAqvaWkv92o/QiZ+ejpTz9lPntHFu6Us2W9xj7EY0J7VzfI
 3WIA==
X-Gm-Message-State: APuU4Z+txRF0bfivCle4zt92MNOEAgMVZ298nZPM/MBhPcTPg8WBXeuZ
 jYFBZkoI3ePUQ4L5V0D9iWSGQB75fFKEZJkLDrM2N9f6Aqo1kihvOsop9R60azNoDI5fzbWtnGA
 n4Y2O8d9Eg7P/h6FzIrJbsl/41+h/KZQtjI2BucoaUuYdjqZkCHzEQdF26i//Vm5uFGg+Ng==
X-Gm-Gg: AYBFou0TSaPEBUu3E2W42/6BizGOPMsN1rVJSlb3owmKxgmGNPJ+NIxQCa5Pho3zao4
 miPHBRg0V8/PK77cAZ9e3aFFHF2RWNuc+QMpOC8j2u5VrzwwW7Jv80zM3zeV2LcEYsIlOiNfvjJ
 XLV0E6R4/tHSle2TSh1nt3/fWiKZtS2bChpLsL2k/3CPTy6jTzZMJ7+N3cOsd7QMs9/U01053eD
 y2VZyKQ1G2rY6U83G6bMOUAnEqM+MGQux/rAzWnH28GOTimJuUr/hXz1M89GJGcqESMAIp3db+I
 nABI8RYUKiv5XzeEwVYJEoobg+fqHoV9Y5olhis4yte86HPoHH9y4mUfaUPgYZb3eQxJlBBqw4U
 Z3vRHAXwi8jyUizZ9c6xGDsnYkRLzCmnv6w7s6lXElVMzHMRxlWqE7spV87PO90KP+XPKGCy+Nv
 j87PPG1un4D8DP0dl7m2D+aAMhBjuiIxt1SRw/rhU=
X-Received: by 2002:a05:600c:818d:b0:4a1:c5eb:b445 with SMTP id
 5b1f17b1804b1-4ba023584f5mr45491425e9.35.1794314362107; 
 Tue, 10 Nov 2026 04:39:22 -0800 (PST)
X-Received: by 2002:a05:600c:818d:b0:4a1:c5eb:b445 with SMTP id
 5b1f17b1804b1-4ba023584f5mr45490665e9.35.1794314361627; 
 Tue, 10 Nov 2026 04:39:21 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0204342asm71937455e9.6.2026.11.10.04.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:39:21 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Devarsh Thakkar <devarsht@ti.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devarsht@ti.com, LiangCheng Wang <zaq14760@gmail.com>
Subject: Re: [PATCH v3 00/14] Add DRM driver for Solomon SSD16xx e-paper
 display controllers
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
Date: Tue, 10 Nov 2026 13:39:19 +0100
Message-ID: <xlv1o6bweu88.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: inX2yukEQ9pedmXANBU6u8Yiw8QgYE87iOVV1uBRfkE_1794314362
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Devarsh Thakkar <devarsht@ti.com> writes:

Hello Devarsh,

> This series adds a DRM driver for the Solomon Systech SSD16xx family of
> e-paper display controllers (SSD1673, SSD1680, SSD1681, SSD1683), startin=
g
> with support for the Gooddisplay GDEY042T81, a 4.2" 400=C3=97300 black-an=
d-white
> e-paper panel driven by the SSD1683 controller.
>
> The driver is designed and architected keeping the bi-stable nature
> and low-power requirements of epaper display based systems in mind
> along with having adequate flexibility to support varying use-case
> requirements for the e-paper display use-cases.
>

[...]

>   drm/solomon: ssd16xx: Expose refresh mode as plane property
>   drm/solomon: ssd16xx: Expose color mode as plane property
>   drm/solomon: ssd16xx: Expose session management as plane properties

There is a fundmental issue with these 3 patches. They are adding custom
device-specific plane properties, but the KMS/DRM subsystem requires all
KMS properties to be generic and standardized:

https://docs.kernel.org/gpu/drm-kms.html#requirements

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

