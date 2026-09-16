Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFD3C982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E4810E0F2;
	Wed, 16 Sep 2026 21:13:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="jHuJEF74";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E4D010E0F2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 21:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789593185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g2VZBiIhAndeip+NGRI8TveTvXF5sUhhIo3CK7DVi2o=;
 b=jHuJEF749TvEbINF9RIqHHWiK85UucfgZgbJ8VRzj5FhGOXI4jwTH44x663gVFkWIPERpY
 yl4rIHaG2cpQQtCg8xdyTOOSHXK+l4QXkbsa+V3oCH6GKnyZDp31IfVUM0W/m3sESUkpRy
 uWntUTwNpSfPOu9tYIJGqBbTLh5i7Fg=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-CjFzdm4uMGix45kNt4VtvA-1; Wed, 16 Sep 2026 17:13:04 -0400
X-MC-Unique: CjFzdm4uMGix45kNt4VtvA-1
X-Mimecast-MFC-AGG-ID: CjFzdm4uMGix45kNt4VtvA_1789593184
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-98304865f02so113919241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789593184; x=1790197984;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g2VZBiIhAndeip+NGRI8TveTvXF5sUhhIo3CK7DVi2o=;
 b=JY8TrvzukGfF43XiWpw7G7PrDJZ86jDOv9Ls0rE2KwSDxKJtqJappYjFt551Etsp5Y
 /8lo8WID0ceON4oNavC22xpYG5P55p7/gRK/8jNGqhHaVHIHhCWgRnbCHVzyKIovI4Zw
 oOIKpNtZuxbMgFH2u0Jfw+ZGT84Iwej/ypsMppt/saXeKn5f5asDkiX5SV0fLGkwCUog
 0CxOrkMo3odHeC10JTqrfkj+ej4Py39U/3OOsVBl/9AztRQECBcahdnanGCFmde6sFM7
 8WPEZoM4hzGSk3w5+zCxT1/8523yIIJ6qX0ZFSEQufFf0bO/VneGmT5OFBH4UKXn9emB
 cDBQ==
X-Gm-Message-State: AFuF++lk5ogxb9CZKFGnuCGaFDRmqd2jJReoGyWDaGH/SI4RYivjIgU0
 pHX2HMnOrRjLmFNlIud+G79KFkmBKiyuOBN7QJLQ00xf07TXh3rlYI0QFcrkcnoek5Db021xDrl
 rZf5S9FZYrFimns15BrEvhl5aOaeVFQtAzKmYw9pCxtvfWU5IAveFlg6YR9Zs7v5qSiAlYg==
X-Gm-Gg: AYBFou1T7sDdq8wQoSaDmQMmEQVJuJFBQ4v8kqqATjhtAy9R7Ywn+d7kaMv+yUaDF4w
 Hha6DBsPS5+Mkg8NYNLvUcOp9UJfJyA4v2pdw/8aJBBH8f4fvnAxwNvZJwBlrwomRbJBW5+pqEd
 AkCOJsNLd42cie/YyhOxhdGqf0uFBYkPwzBtTdFZrYjkTiV6vmmObQFiK8gX4GTnlrf9W8FhGa0
 WnFmC/ETdPXmz9zPFJfm0NiPP7Q/o4NdVoDYUbW/ovSKJEhBtMh1veaMkoH37mOnV+f/NwUd/zP
 3UvTa1b+Y1ckTyvVGO4DXC/HvuGEbKKTbeaJoBkI7Hr6J4RN4nSL7yf9PvECilybNFuaYTXc
X-Received: by 2002:a05:6102:1628:b0:79b:f57e:ea17 with SMTP id
 ada2fe7eead31-7a201fa284dmr272255137.3.1789593183913; 
 Wed, 16 Sep 2026 14:13:03 -0700 (PDT)
X-Received: by 2002:a05:6102:1628:b0:79b:f57e:ea17 with SMTP id
 ada2fe7eead31-7a201fa284dmr272241137.3.1789593183541; 
 Wed, 16 Sep 2026 14:13:03 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7a1e384dc10sm1123769137.11.2026.09.16.14.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:13:02 -0700 (PDT)
Message-ID: <b143ac7a1a911146f3569b934a8da54734610728.camel@redhat.com>
Subject: Re: [PATCH v3 1/5] drm/nouveau/gsp/r535: Add support for
 INTERNAL_GCX_ENTRY_PREREQUISITE
From: lyude@redhat.com
To: David Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, Mohamed Ahmed	
 <mohamedahmedegypt2001@gmail.com>, Andy Shevchenko	
 <andriy.shevchenko@linux.intel.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Kees Cook <kees@kernel.org>, Simona
 Vetter	 <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, Thomas
 Zimmermann	 <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 Hongling Zeng	 <zenghongling@kylinos.cn>, Mel Henning
 <mhenning@darkrefraction.com>, Danilo Krummrich <dakr@kernel.org>
Date: Wed, 16 Sep 2026 17:13:01 -0400
In-Reply-To: <CAMwc25rP6u9=0PxN_OpYUs33cNqoiYYEFpwN4FKPQyHvNb+=Cg@mail.gmail.com>
References: <20260916001603.22394-1-lyude@redhat.com>
 <20260916001603.22394-2-lyude@redhat.com>
 <CAMwc25rP6u9=0PxN_OpYUs33cNqoiYYEFpwN4FKPQyHvNb+=Cg@mail.gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bULdVRzyqmJ52l73qUBaWg3UADxTck4PTBoSv0x0itw_1789593184
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



On Wed, 2026-09-16 at 10:42 +1000, David Airlie wrote:
> > +typedef struct NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS
> > {
> > +=C2=A0=C2=A0=C2=A0 NvBool bIsGC6Satisfied;
> > +=C2=A0=C2=A0=C2=A0 NvBool bIsGCOFFSatisfied;
> > +} NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS;
>=20
> Have you confirmed this struct didn't change in r570,
>=20
> Thanks,

It would appear I have made a mistake - this struct isn't even in r535,
which I could have sworn I explicitly checked. Glad I double checked
before responding, thanks for noticing this :)

