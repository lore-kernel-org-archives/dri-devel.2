Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A80FC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDBA810F438;
	Thu,  9 Jul 2026 07:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gGze/otC";
	dkim-atps=neutral
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68AB710E61F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:35:12 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-7395b602bb9so30807137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524911; cv=none;
 d=google.com; s=arc-20260327;
 b=PDxDYVjbMZFxxKGiRk2yg6bvoEgGKjVSBRHGhazrZa436WBM4yuwMzgEPs7dgVsd7B
 ovd7thW4O7BeyKnmg2nxAxMdypimJUIL47KzGxvzeH7LX16l4fp5Axad1kF+iWSY8Jn7
 cuc49jlb+lGOo1H5EWuwKjr+FY+9/yrXNIBuLtLR6MhG+ePxlHbbNseEKIlzvSWTdRNf
 iohQE0fHq/CPHzfBjCDwPIb0FschmWnfsqaWBRE8AzPXqp24OtfLfmG8XQKEcMIshq7G
 ZH0EC+6RH0dgfrJ72RKu87ufj/zIkZ1dbpXhloFwl/+WKINeRdUX/SaOtXw33iVd024p
 4a/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7zCGQMgTxRSDwHGNj95VKzrTpGhHUfrTs6Y6MG1mxDg=;
 fh=TgauEZm5jmZoEooDcZakEhcG7FgZTNQXuyaSzggNsNQ=;
 b=UwjFvn2yDevZPMo3Rf5v/pMZCX3YS6E+iD7WGS87vkagPwIu+t8WeP+Qh6wuRRmqjv
 SU3TMe44SfHzDUWjh93VKIxONL2pJfIzZW+RwOFYfL6ew3aLJhv6aG7E48SqbcUSfzdx
 nCPp1UpcNQil7HNV23ClPwPMIIh4wDQR7iAMZn8RgLh8alofoH7I4L2xqmhjglOcJWft
 WFAFHJHzhxtx31iElCaetGB50ZkBbajIC8kVhVCvuMsf6qTi7TNxDH1iDdG2jU6R0fun
 nR5tOxD6pzQHQI1T3W7dY9w0avG/hwFcCXsCUfTFa4R3gQrBCF/ICKi/zKELlQYycI0L
 lqgw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783524911; x=1784129711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7zCGQMgTxRSDwHGNj95VKzrTpGhHUfrTs6Y6MG1mxDg=;
 b=gGze/otC61DPC7doYt7foMusPrtNdz7kE+EESGaitxgwGI+rBWAd/tS4/u6azhJLZc
 3Hr+RhlUDe8/Mhw+vToGXaJgv7dxRdw28QTcU9eX9NmgS4UeRC5+EqUHXnWz0C8gh4E+
 nNQvFPr8pfrxxd1D8CNn8nmDLNO1RPxiyK9MOre0cAS3dNPDzvydODh8dHjEb+LhoRkt
 jr7jVIdjcZ/DN00yR7NbSnQSCMZKxSdIwfewzBHOeBTxnBPGRjILH9Mxyp4JBWPUVmZH
 FXiIfE00lieirQPzdL8zz+x02+e9lKcc411S4A1CpTU+d78laJR2gZ9ixuG+Jb+3OODp
 SyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524911; x=1784129711;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7zCGQMgTxRSDwHGNj95VKzrTpGhHUfrTs6Y6MG1mxDg=;
 b=NdFU20K0kmQ5oqabNt341ZKKJ4FCPYBH6fCAablznJjEqhztfz84qzT9j3yRsJEs+v
 CxbUJKtU0XAa6UY20TQnsb0y1pffHOCMfbes9YsXeCvsppo/+inGWfZ9UPJN9MsPPtZn
 J9WClTjTOM2m2n37MohLLjpyV2eIogYd3k9GtOsp7usjnnBwevQiR3RREfqKGLKt8V3D
 QzdcpyDHaorv0ARABVzz0REMTAIUtDbWlbJmmzhD0ol42GMP6sYUgtlvI8acjMpY7Iw7
 nC0ME2Bh8Dh3N1CHzfArmwuHl6VJG5R2cFob/8qzIX+kUufkPnGg2y2OZ/FcDHPt3S4E
 UnyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoHLo1fLl6iVnipdhbtskOetjEigr6Qg9oQT6PNTuhKWGvVd6n1sqisMvYd07w/cAXEe9fbO6c90A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+8cyv/4e3QI4XknUcUzEHGL2tG4EafNHZdlBTx9q1pep97a38
 A5lnjdEygJM2n5YddRDMx1ctxde4sKdmaq8+CjwyAZx1oVT4f94NhvmY74Z81g6DdO0JLHi0NxA
 GnIKNk/zQkboeJw2qfiVW11DIUEg5jBo=
X-Gm-Gg: AfdE7cmGzgJcNyHu137O03EfIB3DlgFsyk4SmHom61Hh/pu75RHGqOIPZQpYMd08Qii
 BEd6vMJ8rQyyfrQGYgtb/Tci0543QFrx0DoswQn+UxH6izVTaNCw4Dt6Z6epE5YMF0rBanywwGK
 SjCPix0eIKN0lrM6Ud7JUQ46vDpKmXPB4ieiSlafFhlCoPdqp3fhDpYri6ecclLBiEcUmTe+uaB
 h0EDYD5nQ6Zd9LIAWkIQeBLR9A85+o8p8p7LXh6k21fKHEN2m5AKQCSxVdG7JH5MWrJh5hJ2xY=
X-Received: by 2002:a05:6102:41a2:b0:738:8d0f:72a3 with SMTP id
 ada2fe7eead31-744e038ad37mr647257137.4.1783524911174; Wed, 08 Jul 2026
 08:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260624184444.D4A401F000E9@smtp.kernel.org>
 <20260708061835.111986-1-jhapavitra98@gmail.com>
 <CADnq5_NyPb0XDxtJR57P8XNnhbBdpBjFFdq1zRVnzZLoZi9Vgg@mail.gmail.com>
In-Reply-To: <CADnq5_NyPb0XDxtJR57P8XNnhbBdpBjFFdq1zRVnzZLoZi9Vgg@mail.gmail.com>
From: Pavitra Jha <jhapavitra98@gmail.com>
Date: Wed, 8 Jul 2026 21:05:00 +0530
X-Gm-Features: AUfX_mx9zKL5wOtfHcAD-1pDiP_E1ouKJoE4uph3rDbmrtFeOMtdbTxZmhFyQyc
Message-ID: <CALFbBidWOJt34zTtc0TRtUCmNkxBj7iC_PFP76-gkHjr2SLG1g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/discovery: validate table offset before IP
 discovery header cast
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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

Hi Alex,

Yes, absolutely! You can keep my authorship on the patch.

Thank you for fixing it up.

Best,
Pavitra Jha

On Wed, 8 Jul 2026 at 20:24, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Jul 8, 2026 at 9:19=E2=80=AFAM Pavitra Jha <jhapavitra98@gmail.co=
m> wrote:
> >
> > Sashiko AI review of the previous fix flagged three remaining gaps in
> > the discovery blob parser, all stemming from the same root cause: the
> > ip_discovery_header pointer itself is constructed from a firmware-
> > controlled offset with no validation before the cast.
> >
> >   ihdr =3D (struct ip_discovery_header *)(discovery_bin +
> >                     le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset))=
;
> >
> > This offset is a firmware-controlled u16 read directly from the
> > discovery blob's table_list, with no bounds check against
> > adev->discovery.size before being used to construct ihdr. Every
> > subsequent read from ihdr, including num_dies and die_info[], is
> > downstream of this unchecked pointer.
> >
> > The other two items in that review (unbounded ip_offset advancement
> > via num_base_address, and num_dies exceeding die_info[]'s capacity)
> > were already addressed in the previous fix.
> >
> > Fix by validating the table offset in amdgpu_discovery_get_table_info()=
,
> > which is the common path used by all callers except
> > amdgpu_discovery_read_harvest_bit_per_ip() (which reads
> > table_list[IP_DISCOVERY].offset directly rather than going through
> > get_table_info()). Add the equivalent check at that direct access site
> > as well, so all paths that construct an ip_discovery_header pointer
> > from a table offset are covered.
> >
> > The check validates the offset itself against adev->discovery.size,
> > independent of any specific downstream struct size, since
> > get_table_info() is shared across ten different table types
> > (IP_DISCOVERY, HARVEST_INFO, GC, MALL_INFO, VCN_INFO, NPS_INFO, and
> > others) each with differently-sized table structures.
> >
> > Fixes: d0c647a6aae2 ("drm/amdgpu/discovery: support new discovery binar=
y header")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
>
> This patch no longer applies to the current drm-next code.  I've fixed
> it up and attached it here.  It was a relatively large change so I
> want to make sure you are ok with it if I keep your authorship.
>
> Thanks!
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index b4ee5fc8e..9b55c56cb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -564,6 +564,12 @@ static int amdgpu_discovery_get_table_info(struct =
amdgpu_device *adev,
> >                 return -EINVAL;
> >         }
> >
> > +       if (le16_to_cpu((*info)->offset) >=3D adev->discovery.size) {
> > +               dev_err(adev->dev, "invalid table offset %u for table_i=
d %u\n",
> > +                       le16_to_cpu((*info)->offset), table_id);
> > +               return -EINVAL;
> > +       }
> > +
> >         return 0;
> >  }
> >
> > @@ -766,6 +772,14 @@ static void amdgpu_discovery_read_harvest_bit_per_=
ip(struct amdgpu_device *adev,
> >         int i, j;
> >
> >         bhdr =3D (struct binary_header *)discovery_bin;
> > +
> > +       if (le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset) >=3D
> > +           adev->discovery.size) {
> > +               dev_err(adev->dev, "invalid IP_DISCOVERY table offset %=
u\n",
> > +                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offs=
et));
> > +               return;
> > +       }
> > +
> >         ihdr =3D (struct ip_discovery_header
> >                         *)(discovery_bin +
> >                            le16_to_cpu(bhdr->table_list[IP_DISCOVERY].o=
ffset));
> > --
> > 2.53.0
> >
