Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C5BCD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 16:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1210310F489;
	Thu, 28 May 2026 16:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YxinWkQv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EB910F48A
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779986489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XBGoB0L6+rOVHYnTM/R3c8pY5d+eoM/ES6oiySPeke4=;
 b=YxinWkQv+ASOm+NJUtnK0jWdGN+Wl553TfkpxfxmR5771CMLlCS70llTxBoJzsmS3ySQVL
 5n8XYYtsACil2WfcKIT7+t2QkIGso7pTBNEt/DjphRmSzgeOvxAE64rN4Rsx/OGaKy8daM
 Z1Ao+qcIPCIqX5hBdcsvHqP/f3qA5H0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-ZQ0FFvYuPPGm4D62R9Nniw-1; Thu, 28 May 2026 12:41:27 -0400
X-MC-Unique: ZQ0FFvYuPPGm4D62R9Nniw-1
X-Mimecast-MFC-AGG-ID: ZQ0FFvYuPPGm4D62R9Nniw_1779986487
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-914f037b7dfso644405985a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 09:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779986487; x=1780591287;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XBGoB0L6+rOVHYnTM/R3c8pY5d+eoM/ES6oiySPeke4=;
 b=eZ+Q4ZWErxzOiJ0phtDCRIstoYuV/qnBSrhIFAaVVwmVVa5vu/6zewl+cIHU5m6kTG
 KtDwYODPSJbZfC++w9sPF/plb+Uy3hP6L7LyP8ZSU21pVNxEg8C+CHnqm3bJ65M07/iK
 m3k0YZzaTODp2vzQ9Ah4P2zJZdjCM8S2/oceZbKkEP1usPdio1Um/kBDocP0Cwnpk8Bd
 g/Ynk1xtJDQehJeHg4ceHmPNkUMVmoOc3iETX1AimclwfEwmZoKanPeEb9h9yy9kPP1D
 x0qzA7YK577ZpSYnOpbr4PuIznP1qnXkElLkF9gAb2Mj21ronxW4EXZHkE+KKK4jecfr
 Wuvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ85ZPk+5dCRSBRSGTAg+tAAw+8p1fu07s0QkudyXR5sPFqGWSWK/Vk+AI92zwwJgHcwMJxKlArYGIs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtnEUd3GDNMrH9WfPME6YKPSVwPOxcSIB2SR6x+uyiyhp6HCZx
 vJ5JNZ6NBGICJ5fzX7KEp2ayhGErScCK33V54Bk2+K4TgBYZfTACD4RssdkSt1WUdcmig89UxaU
 qYouXcGQgirxIqZMeB9sxxBkcEpMj7HuxpossAE7F3RdaSeJAKy/BBmxQWzuu4dD0dCBXyg==
X-Gm-Gg: Acq92OH4NO0ZmXy4SOcUcWkFT+ovfwdfrmOVEqguyFqV+gR2LYlssIVuF2t6+9SvgJN
 4lzpcxU13SeD1MoU9+OpmwdtumuJEs9mJezJjo6R1X9Vy4qWAiX1Bi5/58uCTi7uWPtZfEOiRxo
 yChv3y9MINTXnS78ppniZpS00OEN81m4/3VrbqlxF3l/Jnk1Z2xP/1/lY65nWvhzl8eDabrDOIW
 NUB+8enFitCe3HzF0ArwaHQFcVCwy+z+ZtNX0+gm32Kvi3+YRxUqIn5ZuyIrj2xNbLuncyy9eML
 Woiuk7FDnyrqA76QSK2hmH02ld+DpGtmqrA18pKGcNb/0Mckz/3iz/fzLPWRvvsHtp93k++ru7c
 2dFrd0QkSeJgtzOI3r5u/2ysTnm2B
X-Received: by 2002:a05:620a:414c:b0:8cb:9975:cba8 with SMTP id
 af79cd13be357-914b49e13d7mr3947691685a.62.1779986487059; 
 Thu, 28 May 2026 09:41:27 -0700 (PDT)
X-Received: by 2002:a05:620a:414c:b0:8cb:9975:cba8 with SMTP id
 af79cd13be357-914b49e13d7mr3947687185a.62.1779986486633; 
 Thu, 28 May 2026 09:41:26 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86e9bf5sm862446485a.8.2026.05.28.09.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:41:26 -0700 (PDT)
Message-ID: <794dbd35fd81f03478cdd3238d3d506d0d800187.camel@redhat.com>
Subject: Re: [PATCH 0/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL() usage
From: lyude@redhat.com
To: Hongling Zeng <zenghongling@kylinos.cn>, dakr@kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, airlied@redhat.com, ttabi@nvidia.com, 
 bskeggs@nvidia.com, dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 zhongling0719@126.com
Date: Thu, 28 May 2026 12:41:25 -0400
In-Reply-To: <20260528062451.54107-1-zenghongling@kylinos.cn>
References: <20260528062451.54107-1-zenghongling@kylinos.cn>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xowdl9U0Q6N8FyBxB2r2ML8UFRjeIja8QYBusD67MEg_1779986487
X-Mimecast-Originator: redhat.com
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push them to drm-misc in just a moment

On Thu, 2026-05-28 at 14:24 +0800, Hongling Zeng wrote:
> This patch series cleans up redundant IS_ERR_OR_NULL() checks in the
> nouveau GSP-RM code.
>=20
> The core GSP-RM functions already return error pointers via IS_ERR()
> checks. Using IS_ERR_OR_NULL() is redundant and adds unnecessary NULL
> checks.
>=20
> This series is organized as follows:
> - Patch 1: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rm_alloc_get/alloc
> - Patch 2: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rpc_rd
> - Patch 3: Cleanup IS_ERR_OR_NULL in core implementation
> - Patch 4: Cleanup WARN_ON(IS_ERR_OR_NULL) across multiple files
> - Patch 5: Cleanup remaining IS_ERR_OR_NULL usage
>=20
> After this cleanup:
> - Error handling is consistent with the rest of the kernel
> - Code is simpler and more maintainable
> - The intent is clearer (checking for error pointers, not NULL)
>=20
> Hongling Zeng (5):
> =C2=A0 nouveau/gsp: cleanup IS_ERR_OR_NULL in rm_alloc functions
> =C2=A0 nouveau/gsp: cleanup IS_ERR_OR_NULL in rpc_rd
> =C2=A0 nouveau/gsp/rm: cleanup IS_ERR_OR_NULL in core implementation
> =C2=A0 nouveau/gsp/rm: cleanup WARN_ON(IS_ERR_OR_NULL)
> =C2=A0 nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL usage
>=20
> =C2=A0drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h=C2=A0=C2=A0=C2=A0=
 | 4 ++--
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c=C2=A0 | 4 ++--
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c=C2=A0=C2=A0 | 2 +=
-
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c=C2=A0 | 2 +-
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvenc.c | 2 +-
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ofa.c=C2=A0=C2=A0 | 2 +=
-
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c=C2=A0=C2=A0 | 8 +=
+++----
> =C2=A07 files changed, 14 insertions(+), 14 deletions(-)
>=20
> --
> 2.25.1

