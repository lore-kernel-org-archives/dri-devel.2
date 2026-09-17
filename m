Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD78BC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B40810E4C7;
	Thu, 17 Sep 2026 21:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AyDmWgQI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DACF10E500
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789681908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5OvxCFItIFtD3/YQ1DNKRbPAETGxIRVmjMNCoI1VGNM=;
 b=AyDmWgQIIhtMnHLpDDOD5KGYgk6VHgn7YWicCEW30ocEkUP+Ha5+Jlj7bL2J5bKgjWfK6F
 xcyt22SiV0oFLkokhhoweff7/Yf+jiVKLKBrHxjIEzywPeJAY2eeA1vGldVBCH/faYB0J3
 X4ANzlH5n3XAPf8/pCGx8fL/IoeI35M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-_m3wMZHZMaqDMCgcUKhqwQ-1; Thu, 17 Sep 2026 17:51:47 -0400
X-MC-Unique: _m3wMZHZMaqDMCgcUKhqwQ-1
X-Mimecast-MFC-AGG-ID: _m3wMZHZMaqDMCgcUKhqwQ_1789681907
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9104ba8bf51so4223346d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681907; x=1790286707;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tt8WLUmC8MzD51c/rGvlTmZw5aHynyLZDMykNoT0CLY=;
 b=gcajT2ey4ruHiCYU3TnwTxNVvKOtUq7TRP9zmvEn4hurqXrl2c//LHUsd/ucHQgNpQ
 jiLY0b4T4afxBbCGYN5A6yytCWiuwXzuNsTKwvf9yGK5Brcvh482VQMYqwo7TBxtYYs5
 8LepZjekPu/Fl4Sw2Mtw5gtoUFMv5A2tbhYX7k6Kz5YmFjcb9A+oI+mP/gJxlD7fsGLC
 aSIQyFaEhoWoMcVuxnEGxZAlDUnxLzePGx0UdS/iAob9eKoz36VVOwacPJhmVLVH/eMf
 f4YRyb6nZxuaE6cEUxZ32Be/6hw6Sl63Te5+BHmEPw+rbnZF3MiJTch4iYHfWsK4qadp
 zWgA==
X-Gm-Message-State: AFuF++nDZz7Ld5pzoyNIePd/CDz8Whr6CkTiixg2B9FJxe6qShwQ0p0Y
 YuKI+x/tDmHDWg8ENJgq5edL84XfO+JCN2AtIzttGQ/HTJSVMqA3Bx6rVSrRO2BOZiwuMc1pZfl
 Jea6bOZpH8b4BqYkNM5fmPmayJC+8HDiw5AwwBrqWtRg2828Wr4dfHCVKql7VV5yKDwCfKQ==
X-Gm-Gg: AYBFou3FqcfbXe0hqiLdY3sXT1H8G2iTEX3zd6om/es9CTUNM5U31+cb6TpZmaG58gI
 NMIuQgfrnoBZkcFXjOv97Si73oPsmM44r29ZlD2aZR+iOgJRWLRKiJSF5QGz3aT2unYOVD9l10i
 P2zxQ354iz4Gmqj4mRJBdnpuj5y/BjD7nD5BZoBOgH/7sBp2lYscQWx6iQdzZ/vwjx4gCRYp/O6
 CZ1ASsMAzRpaGFQbzKf+8hLGeTfQVGsAztTq5HjsQ/Ahhtb30YzPXeWmIm+HAZTHB4khPz4ZY5K
 lB31HoTwvEx0n3/+r9kaJijI7gMYF+oEwsLUmSbPuZAtf4UribNQocu6IFDB9UoNSVjSoDxs
X-Received: by 2002:a05:6214:5b02:b0:910:346f:1027 with SMTP id
 6a1803df08f44-91254cb1252mr10497266d6.37.1789681906664; 
 Thu, 17 Sep 2026 14:51:46 -0700 (PDT)
X-Received: by 2002:a05:6214:5b02:b0:910:346f:1027 with SMTP id
 6a1803df08f44-91254cb1252mr10496896d6.37.1789681906238; 
 Thu, 17 Sep 2026 14:51:46 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252c5bef1sm7946836d6.9.2026.09.17.14.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:51:45 -0700 (PDT)
Message-ID: <b020f35ab8adda3907ec2be57057996be40717c5.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: RCU-free the scheduler-containing
 nouveau_sched
From: lyude@redhat.com
To: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 17:51:44 -0400
In-Reply-To: <20260902012717.880724-1-malhyuk97@gmail.com>
References: <20260902012717.880724-1-malhyuk97@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l_AaCwbLffIJ8XJskifPBHc-SI3Rs83ifaqAFY8pAts_1789681907
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

Will push to drm-misc-fixes in just a moment

On Wed, 2026-09-02 at 10:27 +0900, Jonghyuk Kim(MalHyuk) wrote:
> struct nouveau_sched embeds a struct drm_gpu_scheduler (base).
> nouveau_sched_destroy() calls nouveau_sched_fini() (which does
> drm_sched_fini(&sched->base)) and then frees the object with plain
> kfree(sched).
>=20
> drm_sched_fence_get_timeline_name() returns fence->sched->name, and
> the
> scheduler fence keeps a .release callback so it is not ops-detached
> on
> signalling.=C2=A0 A finished fence exported to userspace via drm_syncobj =
/
> sync_file therefore keeps pointing at &sched->base after
> nouveau_sched_destroy(),
> and a later get_timeline_name() -- reachable unprivileged through
> SYNC_IOC_FILE_INFO -- dereferences freed memory (KASAN slab-use-
> after-free
> read).
>=20
> Per the dma-fence lifetime contract the exporter must keep the data
> backing a
> signalled fence alive for an RCU grace period.=C2=A0 Free the scheduler-
> containing
> object with kfree_rcu() instead of kfree().
>=20
> Fixes: 5f03a507b29e ("drm/nouveau: implement 1:1 scheduler - entity
> relationship")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_sched.c | 2 +-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_sched.h | 1 +
> =C2=A02 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c
> b/drivers/gpu/drm/nouveau/nouveau_sched.c
> index 2cbae003d6de..48dbb851df2f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_sched.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
> @@ -516,7 +516,7 @@ nouveau_sched_destroy(struct nouveau_sched
> **psched)
> =C2=A0=09struct nouveau_sched *sched =3D *psched;
> =C2=A0
> =C2=A0=09nouveau_sched_fini(sched);
> -=09kfree(sched);
> +=09kfree_rcu(sched, rcu);
> =C2=A0
> =C2=A0=09*psched =3D NULL;
> =C2=A0}
> diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h
> b/drivers/gpu/drm/nouveau/nouveau_sched.h
> index 20cd1da8db73..51ce8dcf6285 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_sched.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
> @@ -98,6 +98,7 @@ void nouveau_job_free(struct nouveau_job *job);
> =C2=A0
> =C2=A0struct nouveau_sched {
> =C2=A0=09struct drm_gpu_scheduler base;
> +=09struct rcu_head rcu;
> =C2=A0=09struct drm_sched_entity entity;
> =C2=A0=09struct workqueue_struct *wq;
> =C2=A0=09struct mutex mutex;

