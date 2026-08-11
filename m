Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDEFC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3878410EDBB;
	Tue, 11 Aug 2026 21:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SxMSZEMQ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D7910EDBE
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786485390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfO5GTjXHvoFpUxirelLBunZxdJGiurIwuNIlIkF25U=;
 b=SxMSZEMQAaeEHAiU58GdJ2VMYi7v+PzvBQQ6CPfh5Uid+oSX1wOZYMfpzaHYQk81KG+37+
 GMUuEXPTHL5b1pnIev7/q39yplfgJcIQdPwXK4w0J7YK69GcbdeEG9nStLr/gpMxzLHDas
 ug5M3f9GW+58eobUiTrXofDQNh1lV70=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-S8xrD1BFOyqFT5HfIUKc3g-1; Tue, 11 Aug 2026 17:56:29 -0400
X-MC-Unique: S8xrD1BFOyqFT5HfIUKc3g-1
X-Mimecast-MFC-AGG-ID: S8xrD1BFOyqFT5HfIUKc3g_1786485388
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-907b38aaad2so2144276d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786485388; x=1787090188;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UfO5GTjXHvoFpUxirelLBunZxdJGiurIwuNIlIkF25U=;
 b=ZGq5e/GBXzcpbKYFh7cJlbJvIkpQZ2C3t36iqKBJqkdHFGIk6Icln20BDNEGzJMmWG
 Vbk7Y4IMyRarJGU5WRYbf26BrSzQbe3RDEJEgaXQHEqkUj3+ypQFQWRpz7/Cgv8k6udK
 JQ7TsCuwVfHoa9yb5GOw3t8cS+Sm1f7KTojc5gO7VHLd6o0l+EDijjIIleNR3tV1lR5s
 RDlyTnDBUT2JUYeFaFCS3pdVuh/X5fSosJjR07u+uINrtJm3vYy6AG811978+wZba2Qe
 oeeu4Ck4u7QtJ26F6mWWzArPvseJfCQSj75f7IivMsUQn+eYcZuYDaSENlRBxb29uFuz
 7ajA==
X-Gm-Message-State: AOJu0YxOkP5kgPQr7HZTUD06/KtQQ0vhIFtCqzuVQj+BgtUzn+PudUwD
 kKDsOYQsffVZpRfpuqMlpVBveXB8sOEKj2mUaZF5JoHDq4piK9MvhuN6xZNOXY3rRzaJNFrr+JH
 u2eNe0bGwmibUo53Fu5dtDQqnvALnRYyyc0yniKNG/Fz8RDUGgwBwSxMhLRfvbmCY4HYOmg==
X-Gm-Gg: AR+sD121xPCnib+YA7wUMGqlFeT+5n6gGVDwrI1oNRGBl69mjbmN0pXBYXhBttZ/wUz
 0zfjO2RuoUFOhlAFi/9Nm3jfKAebH3keOOr4HyeGGi4KKeeJ2yx3deDuOaLKK7HfQJyeaaWcMLw
 LeKCe+yB94qiMYYr3XY8PnfOlN7DsQqcKd0XvQneT9qDP1eH8JEDRSefpi4a1Hhz06rMjD/CoH1
 s1mHsl4v+KQhMwJzwaM7HPn9QJogw7OWx+b6L3Jb+VcWNaF/r1s/hGzSADP6uqHPlryO5oll+km
 ydG0/azwxdI9Crl5rtveNIOoeJEnPZho/f4LSwWnMD8vO/sqrfKoXjLh/TxC5+kUeVB4QWzV
X-Received: by 2002:a05:6214:44a1:b0:907:5150:a2dd with SMTP id
 6a1803df08f44-90a6ff95966mr2475526d6.14.1786485388320; 
 Tue, 11 Aug 2026 14:56:28 -0700 (PDT)
X-Received: by 2002:a05:6214:44a1:b0:907:5150:a2dd with SMTP id
 6a1803df08f44-90a6ff95966mr2475246d6.14.1786485387868; 
 Tue, 11 Aug 2026 14:56:27 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c26d83fsm8495466d6.4.2026.08.11.14.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 14:56:27 -0700 (PDT)
Message-ID: <1fb27dc24b3d01c9a6318b0dabc0e7571adb7cda.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] drm/nouveau/uvmm: fix VM_BIND submit/unwind
 error-path bugs
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Dave Airlie
 <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
Date: Tue, 11 Aug 2026 17:56:26 -0400
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iAzivQtLMBywsEeyEN3KYQtpfr6lo8ugJM3C2zX1jcc_1786485388
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

This patch series is:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2026-08-11 at 16:46 +0800, Zhenhao Wan wrote:
> Three bugs on the nouveau VM_BIND submit/unwind/cleanup error path,
> all
> introduced by the original VM_BIND uAPI (Fixes: b88baab82871) and all
> reachable by an unprivileged render-node client:
>=20
> =C2=A0 1/3 NULL deref when the unwind loop frees a never-populated
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OP_MAP_SPARSE op's ops list.
> =C2=A0 2/3 premature free of a region on a failed OP_UNMAP_SPARSE, becaus=
e
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op->reg is left set on the failure paths.
> =C2=A0 3/3 a sparse region left permanently marked dirty after unwind,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wedging later binds over that range.
>=20
> Each fix is minimal and self-contained; all are Cc: stable.
>=20
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> Changes in v2:
> - Add an Assisted-by: trailer to each patch; no code changes.
> - Link to v1:
> https://patch.msgid.link/20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c04=
6b49@gmail.com
>=20
> ---
> Zhenhao Wan (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/nouveau/uvmm: fix NULL deref unwinding=
 an OP_MAP_SPARSE op
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/nouveau/uvmm: fix premature region fre=
e on failed
> OP_UNMAP_SPARSE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/nouveau/uvmm: clear the dirty flag whe=
n unwinding an
> OP_UNMAP_SPARSE
>=20
> =C2=A0drivers/gpu/drm/nouveau/nouveau_uvmm.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
> ---
> base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
> change-id: 20260811-nouveau-uvmm-vmbind-fixes-c2dfab359df2
>=20
> Best regards,
> --=C2=A0=20
> Zhenhao Wan <whi4ed0g@gmail.com>

