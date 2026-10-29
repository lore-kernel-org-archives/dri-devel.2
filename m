Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58977606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7yjt7Rd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA1F11259C;
	Thu, 29 Oct 2026 22:09:04 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 402C311259D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 22:08:59 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-14388db1a6bso624c88.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311738; cv=none;
 d=google.com; s=arc-20260327;
 b=KvF581L1yA48vHsDwWBIdMWmXkRQj3QwQT29ijQHIWXMk78a1mvGTVV5L4Thnioy33
 dtM22pCoaCMEjpwJRTqPq35obRktCcnabCrFF9LX0Tf16+54AzX1nsoI/T28vsAxRsV9
 D5KfWLHiMD8bnYRBkHALBgbiYvYF5TajFat4t6FCFYpRODt0xo77rJCK4kPEbDHK4GMc
 md3WsB2LVB3l4VHyOq4npgZRoYR/bDNmh/2f5MBVHtqWNom1RI51OL1HCYgsl+slSUKO
 +4epvg8A7fpQwKRCFwixhqBPB5m4WHbBsTvtMJt6pxvNkUKAWRgKSUNdLNJtNagEatIZ
 J24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BNBRkMvcPM5q+NH92pjwUamOJbPLuAm/rYF5XAa5e1c=;
 fh=fG7SK+DXTKv1gSr+ksxcVAn3pIsoYPRhRVf9h09GA3U=;
 b=L67z49glqOWFBm9dxnUH+ZATbJAoOsegmZ1mskT7g8CQdyNqc7bVwcD1CEi3g/clJB
 zmFNAkK0IxxGiOz8tgYiBa9lzBx7RWrafw99m5Y1K/WdxuV6+XXWrd8ve3Z38ndmvXeg
 l4rHFRRDZkqCYFmNsBoRT8sJbuxp22THRo/acfF+82olShX3dDW4e6CNHtVLkpA2qXcN
 eHNVBO6OSg4/wvHUrLCi/9xbhX+1hhkGHXDkTmgqLwZ49ZVDttEHk5YC70ChRfKTQFhy
 l2Ejd64DbkQalK8ezw+rgBxVUgK5o1LbQvX962eQOsWS4cW7fHcNueobzHJHOLBsSG2/
 e8ug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793311738; x=1793916538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BNBRkMvcPM5q+NH92pjwUamOJbPLuAm/rYF5XAa5e1c=;
 b=F7yjt7RdF8TEPaHKN7GtYjAwHq0Xu06C4qqoTEDpCWxwIj0T2nNBF6VSixOi0OiSrN
 gWF15oUlmKpIdfDkyJA+uDo3PSLEYpb4DXUYK5qinU4b5vOIPaMm90j6o50Tm2vlpSaR
 WvFoGRtQLRVkqQaMFH50G8uM7hAi57QOg2c4OTz56z3xlrU0k1xd+uAtPYi+t3Ou3QoL
 cxi39OG/xiY6KywVkPED1+uyr8a7iLZG6svZHUjvc2ROGvM3Fa0Uc+wSSUhVr66rh71k
 dudAwfuORG18rLpfly0BPC9SagAvCePBgqfGgnrrL3duoDTJbUUpjmCT+6qYjXCpu4/j
 IrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311738; x=1793916538;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BNBRkMvcPM5q+NH92pjwUamOJbPLuAm/rYF5XAa5e1c=;
 b=JcZA6siCVPkKSWMa+7pc4tWsI42GEhUhyb0JWLSAxDn4otOwTzgyRNLQKab0wNjyt6
 algZNMjK6SGQgUaTYR8i4KKAkTv7ikCLmCtuf9ziCmnKsbpv3vEtMoDUCZwB0bXbQr8i
 J/6bB0SJ+Tw/oWHML6YZqGE+PTx3dOEXgaMfScSYSm2eMxBpFBLIatDoc4pikasW7D07
 w1x2CbTgIPwx6EfQSm4QlPZJRAOWl11u4gjQI13kYH48+TD/7k5WDZNuwAx9CmZht40g
 SCiCAknnWbFKIpGsmw6KrjK5Q1NaZDjVqj3f8fL+iksqFl39b4hDIIQAbQRAqoqzvTD4
 QkWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTW9DqzfBnwHMXLuKi2OdCjq24hNPOBTPnrrC7Vz5I9YWcITbFxKrGhUp2at2cAn5RBW+rbFOYwEw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJlWKcB+BEo7gH2z98JtRFHHRLtmB9yLbPBwHM6+h118s4ZqFNk
 H/gKX50iDpHx84JN/7BjVGdQa2pdfrcbIItEiPWQPHzEa2yz/J603GO08rWffsR10oeZYstyzO5
 UGGH3TBzZsSbym1A3gXGs24swdnP/4GA=
X-Gm-Gg: AYBFou33fT8Q210NUAudIfJX95J31tVR8UMSy6up4SdIgfKWJjkGC/+G6DXbSNrZxnR
 Mc3btEixx/eVTgWwJjEZ5F6Wc5HRlUJ4J2TaDSzl9Cd4PWf0Z6mEatnqFDZHKZw8sSef0fFb0I5
 2cIlwWw4vQQib7Zu5FFourTXt1kjPHW9h/8nz0ad6xTa04MsNDR5iMQn5V9aODDVFLWh8Y/2ujv
 VGN37ecrVOz7Ecg9N3++cKLPVtoUdaM2NLf7+VvxI2iMKY5m8kCpElKmI5V/dh7DYRSFjoyqM4i
 6oTfc6rceTbvu+5w30LX37J9fd+idqPId7OIpdshEEuZccVffBst7lbbsA06kebw70YsFRPazrD
 C9s33aSbJ1PKypuPXhEtyEoG7PvT/+gZKZk/toH50tb0BroiTOKjYXXkUuwVctBHSEhXfA2PzaQ
 TxkFV/3FqpLNNyui58MqoQlCE=
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1ac5b7dcb2bmr780931c88.2.1793311738368; Thu, 29 Oct 2026
 15:08:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027133727.748652-2-phasta@kernel.org>
 <54e6cd9f-57ca-402f-93b6-27fe2b15b29c@amd.com>
In-Reply-To: <54e6cd9f-57ca-402f-93b6-27fe2b15b29c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 18:08:46 -0400
X-Gm-Features: AclHuK-38z0ojG634j8HTvYSqjvHDIGJv5-1HW3Xm4xmKYyn6vnp08A2upfv47I
Message-ID: <CADnq5_M6s1TFgHgfiPeLS0bQ0iq+iJWzPKPbacyPvBGibUs_HA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: amdgpu_fence: remove ops->release()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Jesse Zhang <jesse.zhang@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Kexin Sun <kexinsun@smail.nju.edu.cn>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied.  thanks!

On Tue, Oct 27, 2026 at 4:16=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 10/27/26 14:37, Philipp Stanner wrote:
> > amdgpu's fence implements the deprecated fence_ops->release() callback
> > which prevents the driver from ever unloading robustly.
> >
> > amdgpu's implementation merely uses a call_rcu() that performs a kfree(=
)
> > on the fence - this functionality is already centrally implemented by
> > the dma_fence backend.
> >
> > The dma_fence backend invokes a kfree_rcu() on the dma_fence, which is
> > fine since this is always the first member of a struct amdgpu_fence.
> > Thus, amdgpu's implementation is redundant.
> >
> > Remove fence_ops->release().
> >
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>
> I have exactly the same patch in my pipeline as well.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > Just saw that this should be unnecessary? Don't have a setup for amdgpu
> > testing right now, so please take a close look, just compile-tested.
> >
> > P.
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 29 -----------------------
> >  1 file changed, 29 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index 3043ad041bb4..3f8b2571d74a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -892,39 +892,10 @@ static bool amdgpu_fence_enable_signaling(struct =
dma_fence *f)
> >       return true;
> >  }
> >
> > -/**
> > - * amdgpu_fence_free - free up the fence memory
> > - *
> > - * @rcu: RCU callback head
> > - *
> > - * Free up the fence memory after the RCU grace period.
> > - */
> > -static void amdgpu_fence_free(struct rcu_head *rcu)
> > -{
> > -     struct dma_fence *f =3D container_of(rcu, struct dma_fence, rcu);
> > -
> > -     /* free fence_slab if it's separated fence*/
> > -     kfree(to_amdgpu_fence(f));
> > -}
> > -
> > -/**
> > - * amdgpu_fence_release - callback that fence can be freed
> > - *
> > - * @f: fence
> > - *
> > - * This function is called when the reference count becomes zero.
> > - * It just RCU schedules freeing up the fence.
> > - */
> > -static void amdgpu_fence_release(struct dma_fence *f)
> > -{
> > -     call_rcu(&f->rcu, amdgpu_fence_free);
> > -}
> > -
> >  static const struct dma_fence_ops amdgpu_fence_ops =3D {
> >       .get_driver_name =3D amdgpu_fence_get_driver_name,
> >       .get_timeline_name =3D amdgpu_fence_get_timeline_name,
> >       .enable_signaling =3D amdgpu_fence_enable_signaling,
> > -     .release =3D amdgpu_fence_release,
> >  };
> >
> >  /*
> >
> > base-commit: 731ba09867520c047c7de53f92e384808e0b638e
>
