Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9946A606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d19wo7gv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hkFs1SEo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CC510E16B;
	Tue,  3 Nov 2026 21:08:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC80510E21F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 21:08:46 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3IZHu82586656
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 21:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nqa2HWb+gMyhH1q5C2IS9vP6rX1bzS8fEOjh0AxXP0c=; b=d19wo7gvSskyJQtj
 zn04v+tx++jgkYt9Qj3cAJXvlgXV3Cw5+iqSdFqauPrwz43fXfVRpO/fPUEdYHfR
 lMZXWimqC7YCDZyC2i5j1lckR15gAHs+TZpOj0+lBBualPVy+7PPATGPhJOAlcZ9
 DAPOoMLFRRZUBrP6kgsKzuw4IZgl4jDopwcfMXLs95lcvlaSc/d7Vqds+CCiaafo
 N8m1ziwS/8lzMMCkvJrvqYOEeMEJHG2Is6G3UCCsTu0cWD3BO/zzfskc7cFopaTW
 avAtwGUCSzzcElg30NazHEu5oC0TDKWpUx/zI/NPtiKrnEuEISsT3cGolU4LS3TD
 i6lqLA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqmjbrp2c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 21:08:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2eac6e96bd4so66849105ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 13:08:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793740125; cv=none;
 d=google.com; s=arc-20260327;
 b=L/+t/RT698z20Zno+zERb1i3Ay0r1ocDVXMf53Y6wVFb8N96r/lX9cvrQ75457ZSNb
 rWD8bmJZJU2KD3w2x5WczDanjjoDWz//U4H3pPr5fVWEnOXo4SdPAqMaYI7+o3VbcFOa
 D1aKBCszfNzOWDZIOgPH6J65Nl0/Ph4ixuFKo2yngD12Xv+keU1et2Lt4smvAy3EzRXG
 PyDsD1qaUiHL1VEiGZXUz6KKLvaM8wy+3q5/Ze+8Ld1f8i97KlVkM+kbyJ8JZ0G1/WOV
 k7F5UFCgeFEFMbiJ3FE6Y776IOwjg+1TABbDL35RnwVNlOOKiFEOMufMWJokZyA8maCL
 sPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nqa2HWb+gMyhH1q5C2IS9vP6rX1bzS8fEOjh0AxXP0c=;
 fh=ge8WC0s90ardeOJh0circq2OQsXIesOq9/hsZodnKqI=;
 b=IrOQk9SHRR7ukuj0lzptoFK7MyOnxM7RO+VWWKXcdUzcSXZZWB9/z4VEFJnRbjYOkC
 A1JmCGGD+HzHv4TTjYKbu7HyoufFVivFgTLZ8zC4sgbCQSqUBwBM0Jnlr2soryE9CBV7
 nLArrjwuzdkTw9sHCLkn3DYS/zZyQi7PLgBU5OzH82PkeFtqCP6fwU1bu+P5qQj755r3
 D8UH/0VGq8Jv7ZYzPxjT5aFYGQg9AG9twf9m+NgLC10rERAAtySGd3uj4WJbjwomJLH3
 +qbNZOnM5tjJWw6Jb/NxkjIMlRRBBY8BFYR11XL7j/8XJQ8wKFyyjL6JVJjZuqeGf6kM
 jHtA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793740125; x=1794344925;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nqa2HWb+gMyhH1q5C2IS9vP6rX1bzS8fEOjh0AxXP0c=;
 b=hkFs1SEoLScFDymJmi+6FRs7FVx7kgM8IfCTMI4L5rkxTvapvo4Vjl8YY1/uP9IEio
 Ch701xmJ3lByhYawkWRJ4+po0qGxc/jymAsfuKQUZE/uKuyD1ZSga7BEm5Xo+hr5IhCa
 ODLOXLlY/v1PgRe1MQGhNsAnCAbhsPFk69rkV+9L+g5Wxv6ZLo9k8qGa9rA1E4jzO9qG
 lAwkrpTC2shE4xLPTuNklU2PEp40J3Cacp56EkTmRm+XouiNgajrtVTypPW3FmJg9HYH
 kK3C9mtEBAE4cgqnK+7l2Dj56geajBZ8YMvBbtPMiirk520hbxnApedF8DeTSnsYFsd8
 QExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793740125; x=1794344925;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nqa2HWb+gMyhH1q5C2IS9vP6rX1bzS8fEOjh0AxXP0c=;
 b=B56S8747awL3Clyu9kXHOH35io32E7Hlejm+/KY1BnURcTu36AL2i0/Dc/joXnxzHO
 6MWsR9WXHUK5Ww0aLxsW/VYqvnXoMDcWYd++KdYloINL+ZVjjBo3WXFrgF0NCAtS6XEw
 SBD6/WwuU6/8Z/OWcyvz8sHzDh+lQhlXVrtvEPQaARHvcskLKlESgpDmJf3PczXvp6N6
 563zgkuMuLwYdpwmtoxkHH3tc7eP0/2DFj88zz6c+M9I/ZCTbKyawUJdS1dJ9Ywn96r9
 SowNSye3IujTmtN/RrBxq1B6gxHqdkxr//9tK7GR8ytgC4bF88akZHuX/Lfnd8iLaXsx
 DwkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzu1mnZ2tz6PS2h3/gVcUydLhKKm6pfsWObCeaD/mDgVf90N2o/FAV4dRJmQzZ0cIVeoPz9UCfzHxI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/PoNDvdBJfn53uSyj4/pHX4L7o7Dops3mMNSS4yDO14qmJRzHh
 eMAIIfeAvdyAbetcnnP2WF2g8dpkWIr3fv9aZ4rJWLwvIWWQ6uWz1z/SObf+2SEgT332cPd428c
 pwcyofjI98WfM5G3M26FLH5WqrKyBb4xusPM1sFJWykFiN6p91oPe8T10nQJvS09MAclJlNR+hE
 f/ULyMo0CFzb0uJgSwr7xi9VtXrX6rm6gVny0akbHVHmrCVw==
X-Gm-Gg: AYBFou3FJvAErZ7hROiDeV1KX4bnzX7KvHSAWQ/hhIy0BO7kaCdLW312NLVv/Eift90
 rOKRDFgxmcRXyGqlZG4rC0zQHMJIF9i+R5vAXc4jymAEy1yzv7ROsKW5bzFScEWFRrvhSRWCnL5
 DMjw73DVbhl3fBn3Vvk9SN8R3jHZOnqOqj+rOspBVm0ZG/pCY/I9SZ3F3g+E0=
X-Received: by 2002:a17:902:f542:b0:2e9:9263:a5f with SMTP id
 d9443c01a7336-2eb36493707mr131781305ad.17.1793740124572; 
 Tue, 03 Nov 2026 13:08:44 -0800 (PST)
X-Received: by 2002:a17:902:f542:b0:2e9:9263:a5f with SMTP id
 d9443c01a7336-2eb36493707mr131781035ad.17.1793740124147; Tue, 03 Nov 2026
 13:08:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-15-9352be6b86b1@kernel.org>
 <CAPx+jO_KJJ6ORKuw6VJmtZAOEnzVz0+bq3bEFupAK_4UROKBAA@mail.gmail.com>
 <CAD++jLkC7XehyM3Qh4mDu1zB+_MKhmFn6ae1sA4XCxeS1btT9g@mail.gmail.com>
In-Reply-To: <CAD++jLkC7XehyM3Qh4mDu1zB+_MKhmFn6ae1sA4XCxeS1btT9g@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 22:08:33 +0100
X-Gm-Features: AclHuK986C4IgEa_un_uJ2N3V7r60Yd74MfgWjVPHQJYngYAYIhlhA3cS1R7Hj0
Message-ID: <CAPx+jO-=OXpTY7no36tLoKh52EyscohYqtwD64xsgAc4Sh-g8w@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] dmaengine: ste_dma40: Use power domain for LCLA
 SRAM
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
 Frank Li <Frank.li@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: YTSUipkGtMHnWaCyhvItiALto-hg6L30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4NCBTYWx0ZWRfX17bR/ws3z43E
 CxZPhuh6sBL4tYdjdszXP+cDDHEZTNxd52a5Q1K8DI8+67G5HhNmCRdybRHseigxmi5gVtvOhVC
 P8A06AUHq8iQatxjmBslIbgNFx34kGjGo8cqGrsBQrJUKHgQuJZf8LsF5uAoh46Lcwbb26i+JxY
 DYWadvwDmW4sV/4ZlTX6ToEIfB43+fMOUDF3Z/dZ0TFUiclq5yFzOqS+jON/80CxLl+ZPFrRefd
 H0/vMHJhBXroKLrQH/BA9+2BOBgpBj2zPEcvYfs2qbKOuPk3ycEUExApFBlNlvW8nm9GeTn94NB
 vw8UYbZ9TpJKKOTqj2tk10QF6Dk7PTy8fKnd1hb+rsPuP1svw+8dUITDCm3Kw5I+3Z/mF3o3aMi
 XELXw4IE0/iAyl6GK+CXPM8iKpGPsGs2XVr0DEC9rJD8YCsZUHr7EkLfLvsAMPswYR4VxY4mnpe
 YilsKibbBP7XTpguCgA==
X-Proofpoint-ORIG-GUID: YTSUipkGtMHnWaCyhvItiALto-hg6L30
X-Authority-Analysis: v=2.4 cv=NMhAaE6g c=1 sm=1 tr=0 ts=6aea4d5d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=neScOegWvRHQb6aK0P8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4NCBTYWx0ZWRfX5b0n/jdSBlIX
 F51yHY80evwRmK9bY5L1J6BBzuMiGJW65fnz3m7WdeHgfb+TLvcIa7xjqDAxWPGEHz9q0J+My6G
 aLhlV3/fkB8t1FrzH6HkC3E7QTNPP2Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030084
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 11:12=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> On Thu, Sep 24, 2026 at 3:27=E2=80=AFPM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
>
> > > Hold that domain while DMA transfers are active. The DMA controller i=
s
> > > runtime PM IRQ-safe, so keep taking explicit LCLA runtime PM referenc=
es
> > > from the descriptor preparation path instead of relying on a runtime =
PM
> > > device link from the atomic transfer path.
> >
> > A bit of an orthogonal problem, but related to the above. The irqsafe
> > thing have been discussed in the past for DMA controller drivers.
> >
> > Would it possible to get rid of the irqsafe configuration for the dma
> > controller device, altogether?
> >
> > I don't recall exactly, but not the entire consumer DMA API is allowed
> > to be called in atomic context, but perhaps that is not sufficient to
> > allow us to drop the irqsafe configuration for the DMA controller
> > device?
> >
> > If not, I wonder if the consumer of the DMA (like an mmc controller)
> > should be assigned as a consumer device (using device links and
> > DL_FLAG_PM_RUNTIME) of the DMA controller device. In this way, the
> > consumer (mmc) would be able to control the supplier (DMA) through the
> > device link directly using runtime PM. This could potentially avoid
> > the requirement of having to use irqsafe for the DMA controller
> > device. Maybe someone already tried this?
> >
> > If the irqsafe configuration can be dropped, in some way or the other,
> > this patch could become less intrusive, as all that would be needed is
> > to create a device link to sram device using DL_FLAG_PM_RUNTIME.
>
> I looked at it a bit, talked to the AI prompt a bit, thought about it fro=
m
> my (limited) understanding and while it seems possible it will need a
> substantial amount of work, so I think it's best to get this powerdomain
> migration in place first.
>
> Steps to actually go there would include getting proper consumer links
> in place and verified, remove all atomic resume runpaths in the
> DMAengine, handle requests without a device such as memcpy (I guess
> by simply using the DMA device itself as device link?) and some minor
> refactorings of lifetime for channel setup/teardown.

Okay, so it seems like it may be better to revisit this later on then.
No objections from my side!

>
> But indeed we could use the pretty well documented and supported
> U8500 platform as a canary, I think you have access to this platform
> too, the upside is that it is "simple" compared to some recent SoC
> monsters so it could be an example of how to do stuff.

Yeah, that could be a good candidate for doing this. Let's see if
someone get to that then. :-)

>
> I don't see much generalizable stuff apart from things like the
> pd-patch to the SRAM driver being pretty generic.
>
> Yours,
> Linus Walleij

Kind regards
Uffe
