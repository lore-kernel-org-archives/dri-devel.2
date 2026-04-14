Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA59F9D0CD
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F01B310E609;
	Tue, 14 Apr 2026 13:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qHfQmuE3";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8ED610E605
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 13:38:27 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1273c690e5bso1082732c88.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 06:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776173907; cv=none;
 d=google.com; s=arc-20240605;
 b=Yq67oAQgQXA6lpaV44FPsjVt9l2RIdZw78h8oJG7Tr1sDib7XVWOgONsvEoLtGdeD+
 hDL/Yjnz3YuCcrwLaOrHn2Gkgk+X86ls/65p+RbozQhIxbPMnLq6TmY6eRpx32sNk7w6
 7yIyJRItinUVvQsMrRFZiHxRZgjgFvN+oq6Qd5lJWxzUtWhtrdOWUbsrL/4JkUxejpVh
 4ytSxqa7G2jQ4hKy1BLIkRilKXEBxJPXpolPasNNdXgyp29CZFWsZKNHjfnoR2JZwHvd
 iEA8Rd18iuGipX5JD9ZknmZLf9R9uRkCEGBn007Rniq5ZPVrzvz8SpUYL51UMOvtC7zu
 IHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dIoiF5V2YbGoZ4kfaN4IqagNytkJk7Qy3rMBDOcnJOo=;
 fh=t6wxqu5LW0dgqNIzJCYRsBMD6wrpUam5iBRvUZkkWwQ=;
 b=bh0T+o+TKuuabHLgLKHcDrbMqXqcyPlVAVnwoh9mzLWAddet2gNJ7p94bEgpAddhLF
 LNm14tZ3G4qxiKRs2l2G/k9FVpvhgKPTYjRuVWMjeATjTEXAL7K0yxxOk3AxN0K0Bp2Y
 z9LqX4YIdHpSgcOBM2/MqyJSBFuqGhLrLPdTY9uSFavgGt2TXFe2nN96AvfLw/lWGSL6
 Y6Sg/2pY3tJRD9oNchhEikFYxFbkxRIySUsr8XC85JuknkCLLqgqms8k5SRdk9cPBKd/
 +Saw48ktcZ0HspOqsWFM3EqqPhu4eWk4bP1tzUblOQtkKquz/SfdK5pUE3lCHl/RYoyB
 ySoQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776173907; x=1776778707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIoiF5V2YbGoZ4kfaN4IqagNytkJk7Qy3rMBDOcnJOo=;
 b=qHfQmuE3K39MlamrwO2CTB0X8aSFxvy/kyTf7qYAQX5MUxngnbH0Jepu016olwjLYc
 2EkeZt+LeDpTEUP9MeFLdeNAeyHaNHnpZogiNzrY9t2wVJaCjO1ZJqubXl9zWINdLKlp
 3vPThkiKyOsKwmy7iBLINsGhOlaV7pH+TztHK2Mg5WAO4Qx96iUsSV2ZalU7i5BmMQDm
 l3csMc9gwuBLIhjhfbMnZNoYj9oysI7PiZRSijfZ6VvtINumjbKZAQOI7hzrZnzyYSrC
 xscBgR+oALbSg/CZge0PN/K5oO/pzvP8BFHVN7Vyiag4GyTrErPoSSOiJ7nGGlKPVoQH
 cYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776173907; x=1776778707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dIoiF5V2YbGoZ4kfaN4IqagNytkJk7Qy3rMBDOcnJOo=;
 b=M3aJT6Apn3eZFeWrUSJLmDlBB+vi2/GO6eWrWBTxwJQryRSCpJcxkqk9PfrKECaH/V
 qLW1+i+nnjUSCBmAeVd/GHWPonRIjb0rw9KEArB3eW/odTBxEHorX9M3e6rGik5Ls1Pm
 LRceeSJwmNaEczf7mmvH7aBPTafczi77+u/3dilkyH96P7MNYm0xaRYF7Sd1w7TKyX+j
 1K9+2c3YeVEftFz/N3rbbaNiQgSg/3cKE3tP5Jvt34cFAza3G/uEX2y4k9SqRw3C662/
 o8OV/TFRahfSKGdOSgpunAmef3RMDRUle6KpfqOpCF1jDqg4coaHq3v0YpoOerLKsolw
 Tr4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/26Gs8/crsU9qAmdekR2omTbp9kH4GzudVvnqUuRXJh7prGmzYJjwhDpH8AFAbNkSh0nI3fsAqfwk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8KRXXPDWmabLtmssdIN5rRO2UEncjLTkVFfnOgtii6iw8kF9i
 ggrvQxlFDESAYCKkVHsqvRAWYiEfpQfxUUld21iJsohSomMxndcVk7r9zh2+58Obz5h3IgH6GbZ
 yU6EcnAhbcq8kAizBVKKDUlo6Ix4muKA=
X-Gm-Gg: AeBDievC7Y1oEBRcl6mr2fSwjyKKa7SMhplMJw4OBOCugr7wgVu1lbaBtIV9CTByor/
 7nb5cumBSX2l1Tavevg2GLa8IfCYVMaS8phM0Nj+BilNGXNOA23kzcaB8f044cHSIffphkGeT6t
 +J/Nd0g4+ukR73T5ACGLpRAcZAbsdhEfelO2RmKg4CvyVyAYmjDwglRM3nCM2Fe/+qCcRqMY/Zv
 5oltsxcR+gWMZHji+38qP+cS217BPp2C9FubTMX8yOWaEqMDoYoig9o/j0ikqSYmpwfziSF/nw/
 kglJXTcF04R9prcNcS3UnEOocu/AJ5Jt/f4y5wLSH4Z/9XD8kjbnc/PK1ZDvig91vMFP4w==
X-Received: by 2002:a05:7022:2209:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-12c3599013emr4006614c88.0.1776173906885; Tue, 14 Apr 2026
 06:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <1be91839e8b3e41003147a8cdc99e6efd1a87442.1776146550.git.michal.simek@amd.com>
 <e097b12e-6800-40a3-a015-c1b9a52871d8@amd.com>
In-Reply-To: <e097b12e-6800-40a3-a015-c1b9a52871d8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Apr 2026 09:38:14 -0400
X-Gm-Features: AQROBzBacNxmabWprMR1XN8TMc8po3nTXuHOwTNUm7Nu3wu6BSQS5zQ1T4svqvs
Message-ID: <CADnq5_PY75d2377cA=t4N1qhSP7=X4dzA-n+Qg+tE8WVv0t8hQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/jpeg: Fix sprintf buffer overflow warning in
 jpeg_v2_5
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, git@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
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

Applied.  Thanks!

On Tue, Apr 14, 2026 at 5:39=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/14/26 08:02, Michal Simek wrote:
> > Replace sprintf() with snprintf() to fix the -Werror=3Dformat-overflow
> > warning when building with allmodconfig:
> >
> >   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:47: error: '%d' directive
> >   writing between 1 and 11 bytes into a region of size 7
> >   [-Werror=3Dformat-overflow=3D]
> >     152 |                 sprintf(ring->name, "jpeg_dec_%d", i);
> >
> > The ring->name buffer is 16 bytes. Using snprintf() with sizeof()
> > ensures the buffer cannot overflow regardless of the integer value.
> >
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v2_5.c
> > index 20983f126b49..fe2b049afac3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > @@ -149,7 +149,7 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block=
 *ip_block)
> >               else
> >                       ring->vm_hub =3D AMDGPU_MMHUB0(0);
> >               ring->doorbell_index =3D (adev->doorbell_index.vcn.vcn_ri=
ng0_1 << 1) + 1 + 8 * i;
> > -             sprintf(ring->name, "jpeg_dec_%d", i);
> > +             snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i=
);
> >               r =3D amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[=
i].irq,
> >                                    0, AMDGPU_RING_PRIO_DEFAULT, NULL);
> >               if (r)
>
