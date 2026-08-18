Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4C3C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0021A10EC31;
	Tue, 18 Aug 2026 18:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XbjiPu+4";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A89C10E050
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 18:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787077465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NRSlLd9Q7zWH/n4ZBhenQN+P3DSgLgejYrqhKOuEwfo=;
 b=XbjiPu+46V6We+b6832JAQQKak8i5yZZKfFxD86DhLT7N/l4tAWXa/k/Iq8+hCLaVEd3aU
 ByKkiHT85LayZiDGf9GEWVgAR3QzuVrqZcr+oUUiGFO3a+R+XDYAOu9xfJY6l5QoEBBgLE
 G+bbj3+EwXGyC2cXNVPfguSQ76en09Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-jHv4PYKjNXCIuPj9Kwu2yw-1; Tue, 18 Aug 2026 14:24:24 -0400
X-MC-Unique: jHv4PYKjNXCIuPj9Kwu2yw-1
X-Mimecast-MFC-AGG-ID: jHv4PYKjNXCIuPj9Kwu2yw_1787077464
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f0ed4fe79aso4614166d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 11:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787077464; x=1787682264;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5EjK1grTNkC5kVSY96HRtQJcSC7mxO3Y6rELa2KIFGI=;
 b=sqLai7uFxYBNMEPiDGtp4pFKh3F34BCdiidmbblP5LnyZ7JxkosTs/FedVhYNZwfoT
 NiBN/o2fvJiClRgHVCfQiDTSuP+vHZkG/hpaSsbBx35/8+GDu8jVWaXWfOwUDoVPwpCd
 Dms8SLemZdE8/IwfL75fILQJqgFK4FNZzFNExiv6PWrT4xuKKbO0F2ZCYZfYCZrsJGQR
 Iv1hJJFbiFd+ybPb3pnoMfeu/KDNMd4SwL251nFxWKZZ3OqtO2ndJlSo9PKtHcLaX6H3
 nRBwRvdhjALkOhAYl/J5vfP4s5mcBxW4igk9NLhCYzwJx8TxgsYiGyvPzfN/Lujs93fq
 splg==
X-Gm-Message-State: AOJu0YzNgIIjhf7D4XdDejmHBp1Br8+S8b838UK0kj2be5qyi0qnwPgu
 T3ElOMRQul0zCmLTDHjwOk1XjyG7cgL1MfFXZe/MSqPqVtCBLuWN+4JJ5y7E3uuWE5SGNniMvs4
 l2TaYw0z/5MdFPKq0Q406nwzyD0NqXB6MNzVGEw8U4nkpcc4rsM72fN/j9hvWuphd2drTxw==
X-Gm-Gg: AR+sD13rJLhvVzzpVo8hu91LQDTu56Cv/5Y7G3ol34dhJdhNOAs5MvOhbe5StNO85gg
 aJ6yv9px6Qbyl0KCH/PjuisQgLED0jWLxbIIQgm0+Yq33YuoyeqXHkc9VxrsJuOkd2996bzxanz
 wmHjkKrKpF67dy9J2AA7bUGw+TGiy5WBOhZrzb5YGk6XcGXuGT2l7Yj7YQfDh8ObhJHoOxA1PVa
 eche5nSF62BiOqeZqTyRla0cFsjotggokAVCgBtAAb/wDNA42DjNSpKGbpU5l5cLbMH7eNwiQeR
 zS90n6Mdui/Qixh1RSWfbFfnpdhLNSrRYMFYj832Gnw1h10nHakOk1T7CU79R/ArfPiw30x/
X-Received: by 2002:ad4:5aea:0:b0:8f7:43f4:fe8d with SMTP id
 6a1803df08f44-90c5c423802mr2387056d6.29.1787077462539; 
 Tue, 18 Aug 2026 11:24:22 -0700 (PDT)
X-Received: by 2002:ad4:5aea:0:b0:8f7:43f4:fe8d with SMTP id
 6a1803df08f44-90c5c423802mr2386196d6.29.1787077461736; 
 Tue, 18 Aug 2026 11:24:21 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4597695csm37005146d6.40.2026.08.18.11.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 11:24:20 -0700 (PDT)
Message-ID: <25ccdb08f6d84982fb211444dd766d054258e41c.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/nv04: check cursor buffer object size
 before upload
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Dave Airlie
 <airlied@redhat.com>, Ben Skeggs	 <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
Date: Tue, 18 Aug 2026 14:24:19 -0400
In-Reply-To: <20260813-nouveau-nv04-cursor-oob-v1-1-3f3eb37d213d@gmail.com>
References: <20260813-nouveau-nv04-cursor-oob-v1-1-3f3eb37d213d@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zgZRD7plGRv2h6f8RPB0Qft-1HCs7G_PgS6vTQSctO4_1787077464
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

On Thu, 2026-08-13 at 18:35 +0800, Zhenhao Wan wrote:
>  struct drm_file *file_priv,
> =C2=A0=09=09return -ENOENT;
> =C2=A0=09cursor =3D nouveau_gem_object(gem);
> =C2=A0
> +=09if (gem->size < width * height * 4) {
> +=09=09ret =3D -EINVAL;
> +=09=09goto out;
> +=09}
> +

A good start - but width and/or height could be UINT32_MAX, so a caller
could still overflow width or height. Would you mind adding an overflow
multiply check?

> =C2=A0=09ret =3D nouveau_bo_map(cursor);
> =C2=A0=09if (ret)
> =C2=A0=09=09goto out;
>=20
> ---
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> change-id: 20260813-nouveau-nv04-cursor-oob-ad2b6001de3d
>=20
> Best regards,
> --=C2=A0=20
> Zhenhao Wan <whi4ed0g@gmail.com>

