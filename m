Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE8A606A32F
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hDp4YDG6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BAC10EA6D;
	Fri,  6 Nov 2026 14:48:39 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2FCA10F2CE
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:48:33 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-36e795af1d4so623520eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 06:48:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793976513; cv=none;
 d=google.com; s=arc-20260327;
 b=g/mLexqBVVMbSjupSIPR2QQ/ZijUULS7c3YpJJrbdspLSlzuMP/OzRS3plDqrzjbbN
 g5fIPetcQoSSKiUe3FIFouZsUemUVR+U8cCeJlDDgNhuGLc6Hi1DcXp1ka+GseQSsKBD
 girsnSeuIMAvmn89OyTn7x5/09bYN+unAtVh1IXSgfrPmMPOLXK+Ym8hfxP3RJDHZqRt
 qzaX8LaXzCfn1LlSGenCXMfqn4+wWdgAinz8Y5lfrgvVx1+WTxCwWBiL2QnFEAhMhu8N
 2gI92dzdbooK3tVw8fCOVMjGmmuIqxW3H51r8TCcSl+tIEorUG41+ggNvwubL6YorCUT
 5L9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EVsynTIkUKlA3sM+VFVmSipU+rZiRJg3NzlUB6F6w3c=;
 fh=fA0MOqgbX0vY9/8JnsXX8Q2k9/3+uD5Vnv5L+qB+TJQ=;
 b=CnrwtJT6MUlL8fCOHzWPFodxy/yMEqimtXrgw1Ivu+1indHAxd6vQecO24TtBv3Uq0
 3sdJaOq50DK4ztOsI7hLU3ycUNraVvWqGNlFW/1OwgRtttO1ojaqoOAjxDQbXc9nT3Na
 f04Y+p1Jr3UhZGYB/b6vBvTaxl/UsjCuUZpUciwhcj0geuyGCW9Vh8Of0QUv7pJ88Jnd
 jatlI1L31sn8cWyzH08n72rhLAKORPq6xf2Ug63gw0/dR6ey+DbSOoIVazYWdrL9J7pd
 CdNfno+qvQTfi+zbc3U2k7z8K/oLT4nzpk78s+B/p10YJakH/emvOxuJrWSblpS48JDa
 EbXg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793976513; x=1794581313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EVsynTIkUKlA3sM+VFVmSipU+rZiRJg3NzlUB6F6w3c=;
 b=hDp4YDG6TJAIoXMvvIAc77YDCY0zrRDukIzPTx1klY2Stxw5C1laISMNtb3L4AtQgC
 /JnNctRkEXDkXmoRTwSVC/8d5j0ji94XwsCPfMzbcSUe/f4Esxv4+dfEqO1warGKjg1U
 2i6TN4imQlWbtwhh0t3WTw2Bwo0ye1gooptbWzC2GXXPG/Ka5766i6Pt+BPVqQrGcg8S
 Hqy0lWafB2nowxzyx938FV9bTm9Rtkul9YCdRzeX56WZIJm9cuxyh6e1BwFmdOA2YjWK
 SDgzezuLCqAdlcDxZ5W2pNuMJgpFyj9KHYko3xrKrC6SbBdfSGNmFE1uW7/RU0R8OniY
 sYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793976513; x=1794581313;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EVsynTIkUKlA3sM+VFVmSipU+rZiRJg3NzlUB6F6w3c=;
 b=jygyr03dbaMSrpLYhH0PWYbw5urFwbzafdRM5PjzQlCKeUUqb3bKOjmHEK6HUNwf0V
 Zktj7GExxnme8Y7GxIAr3Yy7LY5OFS6LU2JVqs5MBPe0nkej48tiygFr7iFBbrqEmxFt
 Lkrqip9zhSXuAv7bs2rgRKfYMVkVWT3zLdzgrslaKA4YvdiWUh8/o9p6vayiSl++REbK
 nnJ4l1vB+q6SnPqUBzGHLg5hRUigb3pVFAfY8/hA2JbHSZdzAuSPUxHHGzqOlFympOb6
 f8g1/9FK1+e8gpJdwRbeoFhOSs4zpIvy/Qa/dl8y15yEDEm9Hvj/mWKr5RacS5O6Q3CV
 PqjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHMMjOcsXKsfJmbxG82JLywpQ+g5FOp4uO9MmjTL1L7JJ6IA9qcGaI4tOhe1j1mGOGbaXp5D8u+roY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+afjYpyZUAKDuNuWU8P+6xs43PjzZcmFh/pDXMmAGSXOkUdMds
 w94Fz7omcSBUAtl/8f5lBOxHfoRIVp1BvL2BicSHoL2JDUdJXNwRzHoux1mPa7tDMSoE+zOQvUX
 fB09OxB2W8ffSVRd7HJbvhlCv5rr4nYw=
X-Gm-Gg: AYBFou0iO5UghoX5vDbaHuiSVd3KdPy5dnpmPUk9p3CkrtjkfwQ12d7K9oK2Jd2aCjL
 da4KvihqhAG7tnBMwbJXFmdGhiRmNWSSDsxC+vd/JxtfMBUeojUHloSkZgjF0XXxGjTm2LxWxJj
 A08svjHT+SkCMjcwaOPtYeo0eYknfKJfcC6NIk0lofZQrrQZZTmlOh37IJXNlpzdV0PxZ0FCyhf
 pVTNb9EU48kboeI93IZz79gUPogtHaW7dc6UEPTJwA+UMrZLH+x16bOLWldySQFPvtU8acayP30
 k8J8V2Y4srNpi0HBMM1yjlwMUs9AdW1WsnH1qzp7hzETHtsrVZ1UIdQwUTAEF2Ah6kdSXuC7kMP
 Q8Yo69pF+Vm9Htu5lTc2iZYcivaFIS8bbvUfVx3F2UU6/ghXXYpPcx2UD0hQhYcF+5PfUB2Serp
 dJ6PM5uxfcorIkAHV0eTMJGCvAca5iSg==
X-Received: by 2002:a05:693c:3881:b0:36e:ca05:8c3c with SMTP id
 5a478bee46e88-36eca058eeamr5256866eec.2.1793976512062; Fri, 06 Nov 2026
 06:48:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-10-clamor95@gmail.com>
 <au3etybQlb5CtjBL@orome>
 <CAPVz0n3o5pc62eF6gv+PYmJh1KN1a5s=qmjxpNGJfxbCC4tqzQ@mail.gmail.com>
 <au3mloMMzQFPUept@orome>
In-Reply-To: <au3mloMMzQFPUept@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 6 Nov 2026 16:48:17 +0200
X-Gm-Features: AclHuK8DwPrQnJ-dtjZgKOk6mQHPlCNwM8DshspgESp7qhKKTAtefGWbono97xk
Message-ID: <CAPVz0n1j0M1Zjj90pEGCYiNqUQv00N89oPcAxZbA7upuxhoF9w@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:40=
 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Nov 06, 2026 at 04:11:12PM +0200, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 1=
6:08 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, Nov 05, 2026 at 04:05:09PM +0200, Svyatoslav Ryhel wrote:
> > > > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > > > Tegra20/30 SoCs display controller.
> > > >
> > > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../display/tegra/nvidia,tegra20-dbi.yaml     | 113 ++++++++++++++=
++++
> > > >  .../display/tegra/nvidia,tegra20-dc.yaml      |  22 ++++
> > > >  2 files changed, 135 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/tegra=
/nvidia,tegra20-dbi.yaml
> > > >
> > > [...]
> > > > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia=
,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,t=
egra20-dc.yaml
> > > > index 69be95afd5627..ffeb124905dbf 100644
> > > > --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra2=
0-dc.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra2=
0-dc.yaml
> > > > @@ -79,6 +79,16 @@ properties:
> > > >    rgb:
> > > >      type: object
> > > >
> > > > +  "#address-cells":
> > > > +    const: 1
> > > > +
> > > > +  "#size-cells":
> > > > +    const: 0
> > > > +
> > > > +patternProperties:
> > > > +  "^dbi@[0-1]$":
> > > > +    $ref: /schemas/display/tegra/nvidia,tegra20-dbi.yaml#
> > >
> > > I think it might be better to group these under a separate dbi node a=
t
> > > the top-level, making it a sibling to the "rgb" node. If you add
> > > #address-cells and #size-cells here, I think that means technically t=
he
> > > "rgb" is now in the same address space as those new dbi nodes and wou=
ld
> > > need its own "reg" property and such.
> > >
> >
> > Only 1 DBI node per DC is available. Adding address/size cells means
> > nothing for rgb.
>
> If only one node is available, then "reg" isn't the right property.
> "reg" indicates we're somehow addressing the child, which applies to all
> children, so I don't think that would work here. A separate property
> would make more sense in that case.
>

Check v5 and talk to Mikko

> Thierry
