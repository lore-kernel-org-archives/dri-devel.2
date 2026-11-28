Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E8606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ex7dUKSB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B13D10E2E5;
	Sat, 28 Nov 2026 07:55:47 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24CDE10E2E5
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 07:55:41 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso18922264eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 23:55:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795852540; cv=none;
 d=google.com; s=arc-20260327;
 b=rSm6Sy//rN+5FRrWSx6mX6A39dMMD173YoX2UFQyZ48fvX1nfETsTuAxJ0W3HtCqRa
 hP0Z6PSiE7h0j9MpmSGxD7a3TzAVCD22RiVxvncHNrvFA9ZNS3RhgvfFE1XZGS6+6Qn3
 l+TCtXdmBPqcBz/2EAQ0aBzQeC4SD/K1gTwkgiwh2ue+qVKh7vuMoAWTi8Rw3Nv6QrsA
 EqX2ZjeYmM7MdcoxvNO8SI+uWEnn+45oAMFC4BEUHWWyNDWoufWg4j71yekRWGsSRBNc
 suir+QN3vO5Ygc0TmJ+EwSrFpl0dEXw6U1DxaLShSFFGCPf/LAR6uy9uYj4oyFepA3fm
 WO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kdXJuxT11f4xHYQZt4NsB8ndiDlb6V/GAbpnGwwxv7A=;
 fh=2udiHUIxc01YnE/9UUr4jy7FhzqWD/U/6ikXngtNgLU=;
 b=lilYyR4hVUlc80uWXUTx3OGsrNG8kxRCp446ofJcPJw2INxkChaOCFLGYDTnRiG+hx
 OL91+3VdVZvPEtGRkw9DUBb2T12dR7sJ9o+eCXU+miEgM7jdrdriJQb7Aml67T5dRKm9
 cmx1VVlFS0EbEkvO12IdFdUpwHvQBR4LQIVABubJiWZx1rqIw5Z6a9tns9UBJmXKlh54
 Bi25xJgSXgAorFJgRHmimEC81LNl8JPCK5bqelpH04Znk6Lyp3LqVvPBvBzCSfhURMvU
 Myt0txvyeJJK7JZaTNfT6ug04JfJQkxQApYtuJoVnrHYAswougzy1px7tXS/2GiGL0tH
 HfzQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795852540; x=1796457340; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kdXJuxT11f4xHYQZt4NsB8ndiDlb6V/GAbpnGwwxv7A=;
 b=ex7dUKSBV0B1gI6l+fjwZzvOhglgNYLjuXM+xO7lxZWmQBZdTNhrf5AFk5EpGyNsmy
 S5ibOKOfpSkr3MtOxfifmJFUyVviPNnZUQObXpcniucbSVgq5/lUDK8rp2hHQe1AskPU
 XvIhvffPMYR86iA9gy3z8txNupVt0LYmr49dYnJzHSkjg7DEJOCBo5e/DunzD9RVuLLC
 raMmwFfzEqosIn4xxM5BRwh6akavqruesmsqvFHK8y9EKgcJ7A5eHXkn1dBxG5kuqkjf
 qa+r2BOxWU69etQ+6Tak7mBeV44fI+yt3vYzqatkWRf8X5oYveZ7A5ynTux1Hr3sATAl
 1Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795852540; x=1796457340;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kdXJuxT11f4xHYQZt4NsB8ndiDlb6V/GAbpnGwwxv7A=;
 b=sszErG6l8W7dGVeEBI5UHa43HnmdP1cnbu1sDxlQGQXhzdVololMEePPQ2XyhKU8Kt
 GtX3NwUgESPe5QRtzEE1MNqOyk3qARe6vILQJ85+GbZHevaTn3X0SSVhTlPZd+k15nua
 zOuX3jNhdCBFfe6MKZYA8oONm9eQ4WTzQTydrODFNl5IK1eyMprT1Yk/r3HyOanxKhYR
 cS9wPqbD/alT35gikiz/mh7SwziMobkd0xzH7DiIiBjtwBFJGOTfZUW52bJxgksA2uNH
 RRpnJcS/ZM8j95zIOKllv2qhmKlzio9sou1BLxQX8WiQJ3y3Uf1DnkwChQCPjj+uAIxk
 axSA==
X-Forwarded-Encrypted: i=1;
 AL+hErGWciavi9+UkReIoMZVE9IRpKiHnxFxmoTOPfveKRILPPI5aXdjiQuWoniEUXKwkvpG056ItZduTgo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+r72+d+n+mnIZsUkiIcTjqXDNVq4ignF3isqgdI0apIDbnMFD1
 1hiivdVVX+4+lI2dnkWGq79q4FQnKOMtvrtRjDslAvIbqs/uxWZlm8C7JPNmZP9PCI8pHMAaMxf
 JqMi1GrxEG/zKoQMs9ze/e7Z/y6QdmPY=
X-Gm-Gg: AZFdTZcc8JqeULxaW+J5s2v0owUFYc5oEa0Y3AGi0Swo94/ODsgFMagm4pr0NnbuFim
 uzRL+yMR7xDbcWr69y/PF1CBF4mGVLji82z+HFdmoMyVPIN5+DI+JpaUzOh8s2G11pMVyPgWj23
 BI+jYTRzVQsdlZ22XH/UL3Ck5PBKc1nh3SZ9UDBpp6XF88MJ4N/9QhRo4d8+MR5YErLUkgssjzj
 x1frvP9xEAbO4vsR+5xzWE+QWKQ01A43YXX2WwBdVpRwpAr3QsYjikiWq0iHsEqYHZz3ns/1ou+
 d3I7URMOjGUIFdhpKsSYLtR7xOOKf6LC0Df7tApXvRRmwdfPSflhqviiFfE5lc+O7ODy6ts/CCu
 v1Ym62prOOAVXCRVXT8DXctbTusHa7wbq+5xKR07amELQtA2JZvycKLEBXd/tGp+ckQ2Sbi1yRj
 wFNTrqPxxSsBvax7FamSVbyFt9ib92obh5CoPYCFegssFtxfKZ/q4+
X-Received: by 2002:a05:7301:c005:b0:386:a0c0:5e59 with SMTP id
 5a478bee46e88-386a0c0757fmr23973057eec.20.1795852540349; Fri, 27 Nov 2026
 23:55:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122081820.53199-1-clamor95@gmail.com>
 <CAPVz0n3YEoq5dg4+sHfd74rT8x_R9DEv1eTzW7UHVKEABGa-BQ@mail.gmail.com>
 <CAPVz0n1xeNP=rv3qDMG06aSWRLTVvCfuo5tFyt9fz7KDTySV0A@mail.gmail.com>
 <kaWzD58LSXePk8E_XcD28g@nvidia.com>
In-Reply-To: <kaWzD58LSXePk8E_XcD28g@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 28 Nov 2026 09:55:28 +0200
X-Gm-Features: Aa3M54oteGux7ycBFDqaQLj_8yYFVhcMiRkeiuuEM4I0oXp7dJIyrqrkoXPQNzA
Message-ID: <CAPVz0n2S=LVqgXdQsFX-A3q92YNpEu-S_NWm5Sf1uYJexEEkhQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] drm/tegra: rgb: Parameterize configuration based
 on bus flags
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:2=
6 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Friday, November 27, 2026 6:41=E2=80=AFPM Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
11:21 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 08:22 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote=
:
> > > > > Parameterize configuration based on bus flags passed from the bri=
dge or
> > > > > panel. The list of supported flags includes now pixel clock polar=
ity,
> > > > > display enable (DE) polarity, and data alignment.
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > ...
> > > > > +     /* configure DATA order and alignment */
> > > > > +     value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ORDER_RED_BLUE;
> > > > > +
> > > > > +     if (bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
> > > > > +             value |=3D DISP_ALIGNMENT_LSB;
> > > > > +     else
> > > > > +             value &=3D ~DISP_ALIGNMENT_LSB;
> > > >
> > > > DRM_BUS_FLAG_DATA_LSB_TO_MSB does not seem the correct thing to che=
ck
> > > > here. According to the TRM, DISP_ALIGNMENT doesn't swap between LSB=
/MSB
> > > > bit ordering in a classical way, instead:
> > > >
> > > >   // DISP_DATA_ALIGNMENT =3D 0 (MSB)
> > > >   LD[23:0] =3D {R[1:0], G[1:0], B[1:0],
> > > >               R[7:2], G[7:2], B[7:2]};
> > > >
> > > >   // DISP_DATA_ALIGNMENT =3D 1 (LSB)
> > > >   LD[23:0] =3D {R[7:0], G[7:0], B[7:0]};
> > > >
> > > > I suppose MSB is more natural for 18-bit panels and LSB for 24-bit
> > > > panels depending on the layout. So the correct value depends on how=
 the
> > > > panel is wired to the SoC on the board. Hence, I think we should
> > > > describe this with a new property in device tree under rgb/dbi or
> > > > endpoint node. Something like 'nvidia,rgb888-wiring' for LSB? And
> > > > document that this means the above kind of wiring - not all RGB888
> > > > panels use it.
> > > >
> > >
> > > Ugh, why is this so confusing...
> > >
> >
> > Using 'nvidia,rgb888-wiring' may be confusing since as you mentioned
> > not all RGB888 panels use it. I can add 'nvidia,data-alignment' to rgb
> > properties and set 0 to msb (default) and 1 to lsb, or directly set
> > boolean `nvidia,data-alignment-lsb`. Let me know which is preferred.
>
> data-alignment is a very ambiguous name if one isn't deeply familiar
> with the hardware, hence I was thinking something a bit clearer would be
> better.
>
> I agree nvidia,rgb888-wiring isn't the best either, but I'm not sure
> what would be the best choice here, off-hand.
>

'nvidia,disp-data-alignment' to match exact field name it refers to?
'nvidia,rgb888-wiring' is too ambiguous as well.

> >
> > > > > +
> > > > >       tegra_dc_writel(rgb->dc, value, DC_DISP_DISP_INTERFACE_CONT=
ROL);
> > > > >
> > > > >       tegra_dc_commit(rgb->dc);
> > > > > --
> > > > > 2.53.0
> > > > >
>
>
>
>
