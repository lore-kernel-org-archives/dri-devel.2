Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434C606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f3XOzxne
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4027E10E4A6;
	Thu, 22 Oct 2026 21:22:02 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2CB10E4A6
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 21:21:55 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-846566246e8so145783a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792704115; x=1793308915; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZbdQtj8aRv8Qaqx0U63gfrGuX304wgT8my2VMv2KCwA=;
 b=f3XOzxneBd5/k2Xjq5jpBR42OtilyN2tcTcfBuJt5xBeWXp8jB3NLp0ATzyXc1wcF6
 fsxOu9oz4RUgMPD9J5eV+JNowGw0vwcSGypb03clOOZlS4aErEnkk69WAEXcLqcEZLwj
 PmQmZFq72uLkof8Z3DG8DEyjmk5bouPEO50VodFapmABfVFdgA1jybMJEmIoGwVi1OHN
 i+0boQ2yhItdQiWoGE3gTHwoauI1mWrk6zYLGmg+OxhP5++miwmeFotMqxa36OMGJir8
 sONhM+EslmGBNorUoTr59OdDqZ4JpOgHKDWVGRQKlHVbBetAp7OcuHxZdzQuU+OnJlg3
 S18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792704115; x=1793308915;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZbdQtj8aRv8Qaqx0U63gfrGuX304wgT8my2VMv2KCwA=;
 b=IrxG95MX0aWiJuarO9rzfAYf9cCccQiNRk1awlh5jHLGHTnCTI6CDT0XNz4kkkBMvi
 1ig/PsBMSJGw0LDDqfPcjTiksEum0xXjb1tvA6jnSUin3LWKDjXefnOrR7qUGrEEK3YM
 mpMaDhwXl5H5Vct7L+FB2pzxKGKZJYGfypjG/NECGnD08uZ22LacE2yOrgsl0czGa4tp
 WZ/7MvyvHdG2kBWlFUYdCRgHm6PoPzfoKhytmS+nGPslqLQPZMlMrtpzyLBkqkguIvIY
 97bJddPkgzOzN9LDlpuiO9rHftOTaWXa6fphyO6L7c+kf0yKO2wM4Zdzt1gMuQaTFGtk
 p5mg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfB9KATsIpq7zizjMK5pLj5Zk5VFyeY1l1/kOnGDidpUkNk/6LyFogKBGbD8MgjNOWR4On7zckKGM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKVYUZX9eJIlGKwtRSknW7MRsXYvRtG2nXWqQbBC9s8iqNNMmiF
 nHHqH17EI93TKXETXU8jxLcUAgUDHlcl9+3IKENPs2lrM80YxetwCfd4
X-Gm-Gg: AYBFou0425Q62Z00hSsK8b9UxSp0sLAa6I5C+znRu47hkA9gwkI1Ii+GHMGm4cZQNVg
 qITmAMfqfZbMia6PFaLNLZ90PQjm0Pj5QEyfULd+db+9ct27OOXbVwcccwPfV6E3ADKhcPrM5y1
 7gyDJ+G5xxZwyT3jXsjQ7UpbY1FPNp1+Pyf2Xa5JNqkpF5rijynQEFa5tpryr5+5J6EY6tIzv3Q
 OjZrl9Hw2ZDnvaZLJQr0OXHVsK233tuFf5Vs9MNVlVYl24yCxRtoEcd1n36dnPS0QuCfQmyuCxp
 Ug9DNQQxPJSUiGpFVyx3NqBpqluu+me8yshwJtub/cezbhbCFIMBXmohvHWhDpGTpxXrJfXRoFD
 ALZoPQUUZowf7TSM95Rzzl8YQnFrvJTmEH9HcaD34qM9O8uaD7dO9SgD4PK1afIf5UhUQ1lVWfA
 BwGRKqhEL8TevVDyFGTxQSbLrrm3jv/jVB6uzsfa2/i3XvbxMV2tTo2niF5Hn8GRHtOh+aKGfwa
 ltPx/WAgpavuDLr59eOvuGgGFiQQdFAdQPx4AW8P4eEAMQWeV8NTvO2+HaFZ2Hp5g==
X-Received: by 2002:a9d:640f:0:b0:846:6f06:33d9 with SMTP id
 46e09a7af769-84e345f009dmr1665705a34.31.1792704114689; 
 Thu, 22 Oct 2026 14:21:54 -0700 (PDT)
Received: from timur-max.localnet ([2806:105e:c:c9fd:4410:7a5:8e46:9c0])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84fbea6667bsm197377a34.24.2026.10.22.14.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:21:53 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Matheus Tagliari <mptagliari@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/radeon: fix VCE1 encoding on SI by handling the
 VCE interrupt
Date: Thu, 22 Oct 2026 15:21:52 -0600
Message-ID: <9yQu5OqOSQiEjRU6vUeH3Q@gmail.com>
In-Reply-To: <3c11368b-06a3-4f25-8dc3-f57596b4f627@amd.com>
References: <8c60afb2-cb0b-4aec-9237-2ea3404d2793@amd.com>
 <20261021153346.124285-1-mptagliari@gmail.com>
 <3c11368b-06a3-4f25-8dc3-f57596b4f627@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026. okt=C3=B3ber 22., cs=C3=BCt=C3=B6rt=C3=B6k 4:00:53 k=C3=B6z=C3=A9p=
s=C5=91 =C3=A1llamokbeli z=C3=B3naid=C5=91 Christian=20
K=C3=B6nig wrote:
> On 10/21/26 17:33, Matheus Tagliari wrote:
> > On Wed, Oct 21, 2026 at 04:10:04PM +0200, Christian K=C3=B6nig wrote:
> >> The fence handling on radeon should work completely without interrupts
> >> since those have been rather flaky on really old HW.
> >>=20
> >> So no idea why that actually crashes for you if the interrupt is not
> >> enabled, my educated guess is that enabling interrupts actually doesn't
> >> fix the crash but makes it less likely because of timing change.
> >>=20
> >> Would it be possible to just switch over to amdgpu instead? Or is there
> >> any support still missing there?
> >=20
> > Thanks for taking a look.
> >=20
> > On the interrupt: I agree I have not shown why the hang happens, and a
> >=20
> > timing change is entirely possible.  What I can say is limited to this:
> >  - stock radeon: every encode hung within about 100 frames (many runs);
> >  - with the VCE ring semaphores disabled: no hang, but fences are only
> > =20
> >    noticed by the wait timeout, about 4 fps (~256 ms per frame);
> > =20
> >  - with the interrupt enabled and handled, semaphores left on: no hang
> > =20
> >    in roughly ten minutes of total encode time (up to 1080p, plus
> >    several minutes of KDE's RDP server).
> >=20
> > That is correlation, not a root cause.  If it helps I can test enabling
> > VCE_SYS_INT_EN without processing the fences from the handler, and run a
> > long soak test with two concurrent encodes.
> >=20
> > One difference that may be relevant: on CIK radeon does enable and
> > process the VCE interrupt (vce_v2_0_resume() sets VCE_SYS_INT_EN and
> > cik_irq_process() handles src_id 167).  Only VCE1 (SI and Trinity)
> > never did.
> >=20
> > On amdgpu: it works for me, I found nothing missing for this use.  I
> > tested it on 7.2.9 and on Debian's 6.12.113 with the amdgpu VCE1 series
> > backported: h264_vaapi encodes up to 1080p with DPM and runtime PM
> > enabled, no hangs.
> >=20
> > The reason I looked at radeon at all is the distribution situation.
> > Debian 13 stable ships 6.12, where SI is driven by radeon by default
> > and amdgpu has no VCE1 support (that needs a newer kernel, which Debian
> > only offers through backports).  So anyone on the stable kernel who
> > uses VAAPI encoding on an SI card, here through KDE's RDP server, ends
> > up with a wedged GPU.
> >=20
> > Since you are considering dropping SI/CIK from radeon, I do not want to
> > push a change you don't want.  If radeon keeps SI for the 6.x kernels,
> > what would you prefer?
> >=20
> >  a) this series;
> >  b) disable the VCE semaphores like uvd_v1_0 did in 013ead48a843 (works
> > =20
> >     here, but slow);
> > =20
> >  c) leave radeon alone and just document VCE encoding on SI with radeon
> > =20
> >     as a known issue that amdgpu's VCE1 support in newer kernels
> >     supersedes (even a one-line warning pointing to amdgpu.si_support=
=3D1
> >     would help people on 6.x).
> >=20
> > I am fine with any of them, and if it is (c) please feel free to ignore
> > the series.  A v2 of patch 2 that fixes the CIK register issue found by
> > the automated review is ready in case you want (a).
>=20
> Yeah as Alex pointed out trinity is not supported by amdgpu and never wil=
l.
>=20
> On the other hand that APU was the first one with VCE and I widely rememb=
er
> how buggy that HW was. So it is probably a wonder that this works in the
> first place.
>=20
> I would say we take the patch and see. If anybody starts screaming we will
> probably just revert it immediately.
>=20
> Problem is more than I have no time at all to wrap my head around that co=
de
> again. @Timur can you do me a favor and take a look?

Hi,

I skimmed the series and it looks OK to me, though I don't have the energy =
to=20
actually test the radeon KMD. My 20 cents say we should apply the series an=
d=20
see what happens. It won't impact any users who are already using amdgpu, b=
ut=20
hopefully if we backport the series it will help users who are stuck on old=
=20
distros like Matheus says, or old pre-GCN APUs.

Best regards,
Timur




