Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F5ECDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76AFD10E8C6;
	Tue, 23 Jun 2026 14:33:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KSbmA6kS";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C2810E8C6
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 14:33:50 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c0115a3794bso1029475266b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782225229; x=1782830029; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ehF4t4EAD/IAoOVIU9uPF+z2dKiiXJu9e/jUG/hiyTQ=;
 b=KSbmA6kSKrjyFEJ10WyBKjYgqYNgHV3X0ZKwIfk1M9UD7rTJrHVHR7RuS5XpPwuzAx
 JOXZtGSPlWT34h2lnnL8xq9ckoEvcz5GoiA1G0iMR3P52PLHo7bHuwC7XgzmcCeu0uGm
 lAFPfipIWROPax2sgbfu2Y1EgVv4sonzOU6HSIBn1SH/7BzqOsOhlXtvBbXwSX+lG9oy
 evZw3lZGIrDCDiPdv2lIlgWqwvCLZHoar+vIQ0qG39QhRp7MosTXo01bogG3UHIvhnIZ
 d+YSG5xEHe8e0wAqmPjcNalBulbMBkb0bRNQbAfh3eOzULLP/ZkEKo+3zrn5yYSbK6bs
 yU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782225229; x=1782830029;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ehF4t4EAD/IAoOVIU9uPF+z2dKiiXJu9e/jUG/hiyTQ=;
 b=BkHgcE5oK6SwdfkOZcNIoFY+6PSV3cHks+sVo1mbUXkYoh5HxuETVX/FUEXl8YQhpj
 1+jISvZvp4oCvDMPIOQ+LC7F3KHPrwwAonBADhQ3lh0LjZLZfvDmgg24zX3j/MlhI1n7
 ZGDU2j1RFD7LgnZtqYbj5S6luOtIb7NULbRojz4+ixvVx7QGNuVH+006yThLpy1TxclE
 sCCL3XC/FgI1cB/FuH2cVGU8n+FqLQJbEk++r1Vk16zMaht1fyZUPvj3zcyy3Kg08kkW
 n8QK8v/RI1fizUA13ixO0lCnqrA/9qxcOdwJdqexMi3hiplJwoOVF8aKwmLxb7yAYXcO
 5ejA==
X-Gm-Message-State: AOJu0Ywz15KKuOCdcDeYIblLlfBxkJL3FmqMWvAb1Wq5jrbu+0pPUfKo
 t0J3/SwDy2dT0gYUak7NpmDFvPOwKDGYcgmIqJHOFoilqolqtgEAnyS8kJpsZYvtkOwwSeYAGK7
 50EkZlNk=
X-Gm-Gg: AfdE7clYV78V0PRbiC0dcLLKjoHbjXg5uepSQhJvQp/ydPiDs0jhTVCVZNxNurJ6evi
 otvpHbnFD4dF4e1ECEMq6YhpIGr8fMNcFIhRKvy0sH0m4oqUyY67B8VN6Z3Rddgmg9EePx+Btbr
 BDhVHgs0hydOgHO25/3DsEtDppcG7viDNDCrzfO7jctsPTcUP/iTfI/CP7fWbg6lPh/TOOKngfp
 PYFCKffc5Pdh+DvLHhUkaWjeWdy+J0QZ6F1wrzP+TtOYsBSaw/sUi9NhYOXU22fty4YzCd+hafu
 8+wLjRliz7WXI/414FHtfbDU+hWZdhrt5hz4nzN4mg8fq5/rqeNAkd3gNvQkk6JRBHVtTBYSVvZ
 R3N033F5H/iQ2OBrCoLpACg2xqs/qmA9/6n/U44cx0PvzycTXWwSi7WMtan1pXhw+FyQRwpTgRn
 ZIQLc2hj2pX7MHEyYoq94=
X-Received: by 2002:a17:907:9486:b0:bae:d29c:4e28 with SMTP id
 a640c23a62f3a-c108db17724mr165292866b.12.1782225229090; 
 Tue, 23 Jun 2026 07:33:49 -0700 (PDT)
Received: from draszik.lan ([212.129.77.116]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c610e4c76sm536270666b.46.2026.06.23.07.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 07:33:48 -0700 (PDT)
Message-ID: <1467578694a17b2b4978a6193cf21db324daff98.camel@linaro.org>
Subject: Re: [PATCH] drm/drm_crtc: fix race with dma_fence_signal() in
 ::get_driver_name()
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: phasta@kernel.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>,  Boris Brezillon
 <boris.brezillon@collabora.com>, Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com
Date: Tue, 23 Jun 2026 15:33:48 +0100
In-Reply-To: <f59d6080cf31f424ebcf0e6086b4a93623813a6e.camel@mailbox.org>
References: <20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org>
 <1cfd56b7f1a166e25d6588d66a621524f3d983de.camel@mailbox.org>
 <6483098adae29787862473e39b1f9cf3c3f16625.camel@linaro.org>
 <f59d6080cf31f424ebcf0e6086b4a93623813a6e.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
MIME-Version: 1.0
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

Hi Philipp,

On Tue, 2026-06-23 at 13:58 +0200, Philipp Stanner wrote:
> On Tue, 2026-06-23 at 12:37 +0100, Andr=C3=A9 Draszik wrote:
> > On Thu, 2026-06-18 at 17:56 +0200, Philipp Stanner wrote:
> > >=20
> > > I continue to believe because of bugs like this and the ones I have
> > > quoted in the threads above the robustness of the kernel could be
> > > greatly improved if we could get dma_fence fully synchronized with it=
s
> > > lock.
> >=20
> > On top of that, sashiko highlighted=C2=A0 (via my other patch) that the=
 existing
> > code is missing some memory barriers:
> >=20
> > https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix-v1-1-801f29c=
9853d@linaro.org?part=3D1
> >=20
> > I believe Lock synchronization would resolve that (as would adding expl=
icit
> > memory barriers).
>=20
> That is being discussed in the thread I linked, where Gary lists which
> barriers you would need for (presumably correct) lockless magic.

Having read Gary's suggestion, that aligns with what I had in mind.

> However, if my issue were to be solved with barriers, the
> test_and_set_bit() in dma_fence_signal_timestamp_locked() would have to
> be replaced with the more weakly ordered test_bit() and set_bit(),
> maybe creating other pitfalls.

For the avoidance of doubts, I'm not saying that all the issues you raised
can be solved by barriers instead of appropriate locks (I don't know enough
about the code and issues in general here).

I do think however that appropriate locks will fix the ordering issue
highlighted by sashiko (i.e. +1 for your argument). Barriers would fix this
specific issue, too, but that is not a statement about any wider issues.=
=20

> The ordering issue in the get_*_name() functions plays into that.
> Setting the bit would then be done after setting the ops-pointer to
> NULL. So one would have to try to move the NULL set, too.
>=20
> Long story short, this is painful and subtle.
>=20
> But I think what we are realizing over and over again is that dma_fence
> has many subtleties to its API contract, and the implementation's
> sparring use of spinlocks leads to workarounds where people take locks
> manually or have to do an RCU dance.
>=20
> Note that Christian is strongly opposed to guarding everything with
> locks, in part for supposedly occuring deadlocks in the fence callbacks
> when the driver needs to take its own locks.

ww_mutex could help against deadlocks, but might affect performance, in cas=
e
these are all critical code paths (IDK),

> The community discussion regarding that problem is currently in some
> sort of dead end, where none of us seems to know what the correct path
> forward is.

Please ignore if the following doesn't make sense, I'm just a bystander :-)
How about at least adding the required barriers and related changes, and
taking it from there? This would solve some immediate and easy to hit
issues on Arm64? If they turn out to be insufficient, code can still
be changed.



> > >=20
> [...]
> My understanding of the current situation is that as an issuer of
> dma_fence's you, in general, should wait for a grace period until you
> perform operations like driver unload, or, more generally, have fence-
> related resources and such being accessed through callbacks go away.

If I understand correctly, simply waiting for a grace period in the
driver's unbind should be the way to go.


> Danilo ... Maybe he's got the time to share some details with you that ar=
e
> relevant to your work.

Will wait a little :-)



BTW, thanks Philipp for all these details, much appreciated.

Cheers,
A.
