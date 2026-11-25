Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38D8606A339
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=od6p++Gj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4561E10FECF;
	Wed, 25 Nov 2026 19:37:08 +0000 (UTC)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F9B10FECF
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 19:37:01 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-67da69e7c31so6804416d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:37:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795635420; cv=none;
 d=google.com; s=arc-20260327;
 b=NupLLURqv+3AxNlcoihsQAXaiGXqJ0jby3NwtZtdH+9QgL6Z7EkdV4evjwuoTNgrpX
 jVPzTB+a8HssM4AtJP6tOdoLqfQenM69Zk8sj3tsUyqPcV+sdIK1OZK04AC9H4+PxEZa
 xboeNczxZhSgi1W3IVcmeG2Z+N8oHL4qXs5W991yMosS7/a0KxK2PVe+HXbCKgCQDtQ1
 h1o0aE4jU1/e4YF8C0+NU/ZqbcDIJDOjQ2E6R/aab/ET63p4p4GvBwjW3/6RVZYfViq6
 ra/f9GvDU5FnKv5nKi8YSyy+8gBjdxJJVlyCC4Bpu7siVPHVjNFVrK8CTJq80g0jaFh+
 RJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B4yNxpgABznf09LyzRP7JtL39l7WlY564l5cIbDQ1LU=;
 fh=ukxj9G5NxVUR0MDS6dibODbUdKw/wvshK/rY/xA7HS4=;
 b=P/yaOOpucN5Ah8wJNLD1rFz3z4UXXWJD4SyUkgkOJOA9a+YLZHjbF6uj5c36JLQZrn
 7Rqbcdqb06diGTDGkF5XUaPMJoa09J6x2aa0iydT+pFjL9+Ta+VYSH6M359+2oyRnj9r
 YVs7G6ceCrzw9gugyCVyt/LhJjpUHRcN8PHuBlzFLyraf7MsQ4T5jCc/2FyAIuVuFygG
 fDuS8v41p/NviLIB7/8fi/1oWOEV128VCWhB8TWV/X1JR3vNdjvmB4muaIoY8ppfhhJ7
 HkkHdBPqhs9wb+4eIecFfPkvtfn2dpaBNqPZRiAk9gLEmyeu8SUlvb7cSkIkY2BMMxpX
 ul0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795635420; x=1796240220; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B4yNxpgABznf09LyzRP7JtL39l7WlY564l5cIbDQ1LU=;
 b=od6p++Gj6dc9CIc5Gm6prsTMbdnOLMM9Dwhg4PNH9eQmQ++SFzke+jl8kEaVUplplj
 W7fTjMm+r6hHJCv0kYuv113UEK5ILGSMXMwxX4ZsEnidBV7Rp8ypwy5gcY7ntvH7uhhA
 aptnOeNl33GluLWztUAtgwilDyRCBJ9aoSJmA7gjdViBF9IxLYev4Shz42+h5A+nkjac
 T1aDyZ7m7Mb9wKkKHT9fl/3bk31D86v3m9VCiIGuxIDrTRe//GVX7zaRxeVKvHOMmo42
 OFbmTXCnN8PauT+/22ex3iZUjSrWFMlq8LRis8YAKAuBimeYP3A+ZhACK5kp7XAsO8bK
 MJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795635420; x=1796240220;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B4yNxpgABznf09LyzRP7JtL39l7WlY564l5cIbDQ1LU=;
 b=b7sts/R/5IYd/B1w2GaZmCoA9iz+sZnx5nZZjxvRP6j7qD+0US8Xjqz4+BA9iCraNH
 WQ09xnpGJy005U18RbuEyvgo1P4owzN6zdPD7U2FoO9U5joDttRv43Mwibtp8hdynRIT
 +yyQbYJdGXaAwRdCaxsREl+XxvRxuYuKrEdCK7f2x7yw1L59btR8jmzO8H26G3UbXTce
 ZTKgTQppJT/9Y+8Ifl6lUUOOfXDRy/aMPZcd95h2B2rAn2kbxr7+w6C+klX2vw8TRtST
 RXwAiT0nBDtDVrMD0Q0bGcp1PLop0nPUjz0dTVURMaIn60+Rg8XOF6WjdByHg3Q8wPcT
 A57A==
X-Forwarded-Encrypted: i=1;
 AL+hErHkHT15TlK/SFngKaMo2JY1/l4Z959NRJ+cYRTghCDe5cOqXvAg4E16MyJxurPHUMwhzKzao05iSRo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/q77z77nU8AmzVnIfglHukpsQrm6zOP9+WOaAmCU10gMXLvY0X
 NZ88w6r4tb1Ol9P7x64RvY0dVAKxNH0XH/lRU1scfiOw5q+2FOMTP38AOyDSqx5TpXoj/idiyZL
 TGUUmmohsUzKShb9GA1uy96h+pPLoVvM=
X-Gm-Gg: AZFdTZcncyn9pY5duW2Q+zXoHOOHxVjqn9zFcjgcVoV3ccf0CH0twxsSMTugKsIdAEd
 FPSrW87lWyDQBS0M28I2vAQeX6l8A0NwVehMpZZElyUMt0Nybx2wr2glTafTKmKq/ZZB3EviO9b
 4u2x1iyLSVMbcb3jYOb/UuhdGlvqNKC+mIoxTGOAiklQuXDXK6HbvD6mBIstKL+cyYYvNabcOn4
 QxYxmWSGxBI2WUnBn1gs9RotPNI8ZBdhrZjMdN+CgvNZM7xJX0nqRWN5rhgPUwYoV9EhgOPCuAO
 GQs61CPhrdFBYxzkUn1gVf3dcUFgdki4+gZoWBMRYy46SIIELeCMWIaxu5ApzLNtUHElEw0c0rM
 Sfc8zyga2haNg3hlyS/OT7mly5VtZ7BB8hcYCBTdCpwJ/qfycujdlfTVI
X-Received: by 2002:a05:690e:418e:b0:67c:1dca:80f with SMTP id
 956f58d0204a3-67df4463ddbmr6813907d50.54.1795635420641; Wed, 25 Nov 2026
 11:37:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
 <114377fd4c275215e40c3991bb935b8c41aa3d36.camel@linux.intel.com>
 <CAKL2PNo7Vp7O4FRWGPV-ZuSqk60B4xh4pXUzcgYEEdqm_sUemg@mail.gmail.com>
 <ff8167523ddaa4b6e2d59be81cb06ff663251c0e.camel@linux.intel.com>
In-Reply-To: <ff8167523ddaa4b6e2d59be81cb06ff663251c0e.camel@linux.intel.com>
From: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
Date: Wed, 25 Nov 2026 16:36:48 -0300
X-Gm-Features: Aa3M54rausYHInCPOQFrbBMqqC66FycXc6amGeUii2hD8ujsrk7NPp1tLSgfXcY
Message-ID: <CAKL2PNqdc=mLi5r87uywkQDQz2eO7hnn3=g71cgKjrv0tq4OQg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] drm/ttm: fix excessive idle memory retention
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>, 
 dri-devel@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>
Content-Type: multipart/alternative; boundary="00000000000064bd6e06611ef3c8"
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000064bd6e06611ef3c8
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

> Did you actually see any instance of remaining GPUReclaim memory when OOM
was hit?

Yes. Twice actually. During a userspace memory-pressure test on my 32 GiB
desktop running kernel 7.3.5 without my TTM patch, the kernel reported two
global OOMs and killed kde-ram (the test I mentioned before) both times:

    2026-11-23 21:43:51 -0300. gpu_reclaim:10045728kB  global_oom
    2026-11-23 21:44:08 -0300  gpu_reclaim:10045736kB  global_oom

About 9.58 GiB was still reported as reclaimable GPU memory at the time of
each OOM.

The full kernel log for the first event is here:
https://paste.rs/ajafn

--00000000000064bd6e06611ef3c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><div dir=3D"auto">Hi Thomas,</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">&gt; Did you actually see any inst=
ance of remaining GPUReclaim memory when OOM was hit?</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Yes. Twice actually. During a userspace memor=
y-pressure test on my 32 GiB desktop running kernel 7.3.5 without my TTM pa=
tch, the kernel reported two global OOMs and killed kde-ram (the test I men=
tioned before) both times:</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">=C2=A0 =C2=A0 2026-11-23 21:43:51 -0300. gpu_reclaim:10045728kB=C2=A0 gl=
obal_oom</div><div dir=3D"auto">=C2=A0 =C2=A0 2026-11-23 21:44:08 -0300=C2=
=A0 gpu_reclaim:10045736kB=C2=A0 global_oom</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">About 9.58 GiB was still reported as reclaimable GPU me=
mory at the time of each OOM.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">The full kernel log for the first event is here:</div><div dir=3D"aut=
o"><a href=3D"https://paste.rs/ajafn">https://paste.rs/ajafn</a></div></div=
></div>

--00000000000064bd6e06611ef3c8--
