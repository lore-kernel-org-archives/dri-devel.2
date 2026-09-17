Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB9EC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA6110EBB4;
	Thu, 17 Sep 2026 21:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PD/B4aGC";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F8310E769
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789679675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38jxd0wQcDwbVDumJ2B589A/WlIbq9+EZCtolWKlhvg=;
 b=PD/B4aGCVugPwOpe/Y3p+hFV62uHWhu0IKrtaEHvff2L16Wlmuiom4qEsLzOWRVDezx5YD
 lJ8pPB7oGPocYpHdrtQxSVKKBVGi2LBCR6lVAjDDoS2SxqJM1xa3K+jWJHPQgFNh+jJZoU
 gfD0MqDLzm80mI68uT4JerXSZ2+3sHI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-jRKGUx6DOiS9rw2URwiBew-1; Thu, 17 Sep 2026 17:14:32 -0400
X-MC-Unique: jRKGUx6DOiS9rw2URwiBew-1
X-Mimecast-MFC-AGG-ID: jRKGUx6DOiS9rw2URwiBew_1789679671
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90e8dd8be81so1917746d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789679671; x=1790284471;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=38jxd0wQcDwbVDumJ2B589A/WlIbq9+EZCtolWKlhvg=;
 b=j+Q+zgM2WpQ/9TWPgfWus9+9ybLZldLhYygBgTOVbEIk4QViOBvyqTjNHNtyjDwEfV
 CsVz0b0UNjdSbP4cmjyeXRgSSX0ejOnQNLB4AoFN5BsXOvCK7b0S1DUOc7JAayhcI/Se
 fhifUg4WUOk5NnF1uJzBw5S+6sQn3kWWGuLUv7vBG3aKlCgrKZALrdq7lJTSVX3JtY5I
 W3dg7kq3Qlf+fgtAJ4/AWhp2kSiosrS3HGVXIZANSammcaRVqmvrX6A29Y+E0l+kJC0u
 XBv5o9xqi4cvM0hxnsJ/yEXxJDfwesKcqlZVBHpu6qjdiumeERFcxJoi/NVG77FshJ3u
 uYaA==
X-Gm-Message-State: AFuF++l5q7+O4U3sTrXleHKj7lnD7JK9ChHbe9h2bCf5NHac0u0XbGz1
 9k/gqypOcj7yQCJrB6SLDDkPT3nKHTdkug7sGcfTU+L+ukF7LljlLe82EstRLeK2DbYhsE2zqnE
 k0s5i6vxyjt2GQdiFNV32LgRS2XOvb+Q8hqpzfosgJdkBI4w8YqoPcU2/xuJ73VxADrcXLg==
X-Gm-Gg: AYBFou2hw3vBJ0W9IfCH7/BDjpCaW5mkkImqUwomQMwhY5hLmOTFanCfE/6VULAbiCU
 CNHmOpLsYRDT9mrj/5mn7FUiHZIvMy6JAKpfSi8eWx97ZBFjZjBpMHOFbSyBfVt87KeDGXgGbcL
 FZNYHps0Cbj5Xj///sKBbO47kI4TnvjHWb+DWkvOc2Lsy7rFujw5hWWg03uuxYu9+6Eq0SUyZNA
 0ecN6ptTsc+DRFAGkUBQBRN/f7h7pz/oZ8UDbeTKeOykaDMTz/77NJncYUJgSoQoPRqxZ73b77c
 zkyFK3DFjPJWuWkFLWuMuXoRMe4GHipmQc0Tlb4LkvyzD7XIw9AZouM58MYMgGPejhul2pRW
X-Received: by 2002:a05:6214:8087:b0:910:6407:4ccf with SMTP id
 6a1803df08f44-91254b85e5dmr10163176d6.24.1789679671338; 
 Thu, 17 Sep 2026 14:14:31 -0700 (PDT)
X-Received: by 2002:a05:6214:8087:b0:910:6407:4ccf with SMTP id
 6a1803df08f44-91254b85e5dmr10162576d6.24.1789679670867; 
 Thu, 17 Sep 2026 14:14:30 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252c5bef1sm7218696d6.9.2026.09.17.14.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:14:30 -0700 (PDT)
Message-ID: <1372e336906a9418352edcf552d899685fb9b1d5.camel@redhat.com>
Subject: Re: [PATCH 0/2] drm/nouveau/clk: fix RAM error handling and pstate
 desync in nvkm_pstate_prog
From: lyude@redhat.com
To: Francesco Magazzu <postadelmaga@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>
Date: Thu, 17 Sep 2026 17:14:29 -0400
In-Reply-To: <27293a63217c3261c42d011cef8cf31e3d43fefd.camel@redhat.com>
References: <20260727152821.128432-1-postadelmaga@gmail.com>
 <27293a63217c3261c42d011cef8cf31e3d43fefd.camel@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d3K0nXBSGCvTx1Tv4DX3caxrZSgMK_N_STKl4kv_8as_1789679671
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

Well, I -would- have pushed it but then I quickly realized I reviewed
these patches in the wrong order, whoops :).

Just consider these reviewed, will push once the series this depends on
is all good to go

On Thu, 2026-09-17 at 16:51 -0400, lyude@redhat.com wrote:
> For the whole series:
>=20
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>=20
> Will push to drm-misc-fixes in just a moment
>=20
> On Mon, 2026-07-27 at 17:28 +0200, Francesco Magazzu wrote:
> > Follow-up to "[PATCH v2 0/4] drm/nouveau: fix list cursor use after
> > loop
> > in the clk pstate paths"
> > (20260712123616.1180830-1-postadelmaga@gmail.com).
> > Sashiko AI review flagged three pre-existing issues while reviewing
> > patch
> > 2/4 of that series; the third (clk->func->prog()'s error being
> > clobbered
> > by nvkm_volt_set_id() in nvkm_cstate_prog()) is already fixed by
> > patch 4/4
> > of that series. These two patches address the other two:
> >=20
> > =C2=A0 1. nvkm_pstate_prog() drops the RAM reclock error and falls
> > through
> > to
> > =C2=A0=C2=A0=C2=A0=C2=A0 core clock programming anyway.
> > =C2=A0 2. nvkm_pstate_prog() commits clk->pstate to the new state befor=
e
> > the
> > =C2=A0=C2=A0=C2=A0=C2=A0 hardware transition has actually succeeded.
> >=20
> > Francesco Magazzu (2):
> > =C2=A0 drm/nouveau/clk: don't ignore RAM clock programming errors in
> > =C2=A0=C2=A0=C2=A0 nvkm_pstate_prog
> > =C2=A0 drm/nouveau/clk: only update clk->pstate after hardware
> > programming
> > =C2=A0=C2=A0=C2=A0 succeeds
> >=20
> > =C2=A0nvkm/subdev/clk/base.c | 9 +++++++--
> > =C2=A01 file changed, 7 insertions(+), 2 deletions(-)

