Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF9EC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F0A410E62D;
	Tue, 21 Jul 2026 16:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="vgmqrEFh";
	dkim-atps=neutral
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44BB10E62D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 16:50:48 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-902fc790cd5so108576126d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 09:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784652647; cv=none;
 d=google.com; s=arc-20260327;
 b=bFAAgvLoGhSLpbmVk4ZJvIl4H9CJEB+c53+H4u9Rccu5Vuy4gBcy14+q92wiEspOK7
 0+791L9uN6AeY1OzNnPpC5rZFzC7Tm9IGHsmIsTcv4V9wZo400ddkgPk8wlovpT8b8JD
 A75FVe9+izk/azaP8siXhAERheENT3LsSUlQF5jqTZIB0YbkcA7dyAy6MuROuvdgpRnz
 tWYyg/4UW4DMjNMxTOxWr7p9foc34zyFQEh+1EITDJ9Q+QVkfh2VwxnWyteFj6aAMAo3
 2AwDFvrlBiQ9MLIu6wLQKt4JF5ThVCR0nn/mawukJ2i8DgEDt/KHdfz+0IiheRGsTL96
 QhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i+wT/ZA9Ht9CieO/I2/gNmtVvqQkzi9M/5d4RIXm1tQ=;
 fh=WjquBS4IZj0ocVSUfs+tfje9TzowoSVSzBDlxJULdc4=;
 b=DS3qb88Ez1ZPyJgMYFfFJrWUL7IskB0Q1WmEP5oPXBpb1v9zzPHnUP/Os4PC59TjuB
 2fyCi6JAJ1jURQwTsw1wTuPsVURAi1dde8uCA+r2/+Vye24BoGpkAt1eYeAG7joQTMLH
 Ys4qaQ+1wBfUo41JWbtisjGtRLMpal/x/hDS/vvx5PK0CcOuQco45GEwrkpSCqkV+X+u
 QMJ/jKb4AM99tdJSTigt2R282wGH2n72QjgB6cNKIXVb62BxCw6zn/faQ0PUoupwrCW9
 GKeCAVNlXE3KBm6Up8aoGnMKcKzuKgEEGuMGEpU50H8zYB2Yhn7yFGh5Ub5l9xjAAls9
 2XcQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1784652647;
 x=1785257447; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i+wT/ZA9Ht9CieO/I2/gNmtVvqQkzi9M/5d4RIXm1tQ=;
 b=vgmqrEFhx4Hqd3WrB0SpHwXZSs6rq41LLWi2Oi0JJW6PSh/gDQH22m35gbCF9pUFcK
 HOfMekL2+Z+k4Gq/tFyqFoenM9ATHmrAVd9NC+VcUPyWcCkeRPFO3g7qHwgIhLKYcEO3
 a1sFfeynL6TU3OXx3/zRzhW9DqkhBkJzRYRRqhdKamr425ZhTcCbee8hOwdkVn3ZWcGa
 HGv7If7B2S/Oda2JasTTwtVvVJCLSayFBIBZOodo49n5E6Llej7Lo/IbhiuNMgW5zMwW
 GwPAWYTNf8SlrC0CWjN9vyRv7HLVe4er1NKL7bTgU3jcCPSBStPrrRzewmXq5P51tGbi
 OiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784652647; x=1785257447;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i+wT/ZA9Ht9CieO/I2/gNmtVvqQkzi9M/5d4RIXm1tQ=;
 b=LsyCEJ/NLKslKfVAk2MNnIGH7ESmsGlLyij23XJWdBOfyWjIDbhzSIt5AWardoDOTn
 eZjCoHa8ahOKYE8PrpUSQ6mSxwJzzNKI8A692TwoPvO9uG9A1kUddgn+a8IfV27DOGkd
 bzgVsJj6+UpzvbzqFFS7+6jIlnqmKdzqZo3m8BUoQtQfsj5zCTn834D/XU2q0TblBEKk
 uKqJVuLBaVZJ457uyPoU38h9ZPooA73vPrB3SW85mmLiflz/+NHZNzSCJyN2HqZbzJFo
 6fBtMfql2Jzf9FUTRoDGpwPzGosCZ+KPzkPobEiMZuwAf6HiUV+cLhZ8c9kY9EUctLz6
 gdFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqy939r4T6ulIBZOhoiHy1ybAVRX/dFfmiKdTn19wW3M6f2+I8Yg2KX2SPI7aJvKYIKUKYh3pT5tuo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKMvTsyc0wxg8sTgz0bkXhEQYZYUNOSD1ENYq75YpC2Mu+Su2b
 LsgYPRzSaMvyzNEFUSbZXRKDoEc2PdNwy6vFLVij8dRfvGrtiQmGZ32PZRdRiVdDJwdRfeNvCY1
 zaLgU88GyFwaXirlPz6qn2R+AibXT0lGcI0OEkizg1Q==
X-Gm-Gg: AR+sD12CTujpCBfc1oqIYUlcatsP216HJKbQ8FmhB8H/xTjvhPBG1+A1zfXoi0hs4i3
 thebn+7PRXs3gpnBc9K5O06qRguMlY8vwmldj4JALfvxZnmYAG4iXqZu6KSnoKregHVF2Bh8PUc
 jjPmd/LavTyBdzkQ931CiT0QQ5MFjvldt2IXEYz8ZIHioodJ032qw18SGoiaXV244wfgA3QviU+
 pcLbbfhJWEtHgp3Z8DsWF2POftCXRxm0TtCTgyKp8T+GAAQPQJ+RsXzBWKEHidisNz6QA4=
X-Received: by 2002:a05:6214:20e9:b0:8df:6719:f646 with SMTP id
 6a1803df08f44-907783b4c7bmr207560856d6.37.1784652647451; Tue, 21 Jul 2026
 09:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260720231450.485221-1-robh@kernel.org>
In-Reply-To: <20260720231450.485221-1-robh@kernel.org>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Tue, 21 Jul 2026 18:50:36 +0200
X-Gm-Features: AUfX_mwXu0wWGpa-jcVB5ooKx0fi7m4DCqHbNwi7Xzv7z2GWVqmkimLKVF2FIAc
Message-ID: <CAPsqS2RE1N_TCYTRMt-PaSMhHB8vEdEbTz5+q_2pzhmJtD4faQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] accel: ethosu: Fix element size accounting for cmd
 stream validation
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Jul 21, 2026 at 1:14=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> There are 2 issues with the element size handling in the command stream
> validation which result in too small of a size calculated when the
> element size is 16/32/64 bits.
>
> For NHWC format, the element size is simply missing from the
> calculation.
>
> The bitfield for the element size is different between IFM/IFM2 and
> OFM. IFM and IFM2 encode the precision in parameter bits 2:3, while OFM
> uses bits 1:2.
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

> ---
>  drivers/accel/ethosu/ethosu_gem.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 3401883e207f..1daff32610c7 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -194,7 +194,7 @@ static u64 dma_length(struct ethosu_validated_cmdstre=
am_info *info,
>
>  static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *in=
fo,
>                               struct feat_matrix *fm,
> -                             u32 x, u32 y, u32 c)
> +                             u32 x, u32 y, u32 c, bool ofm)
>  {
>         u32 element_size, storage =3D fm->precision >> 14;
>         int tile =3D 0;
> @@ -231,10 +231,11 @@ static u64 feat_matrix_length(struct ethosu_validat=
ed_cmdstream_info *info,
>
>         switch ((fm->precision >> 6) & 0x3) { // format
>         case 0: //nhwc:
> -               addr +=3D x * fm->stride_x + c;
> +               element_size =3D BIT((fm->precision >> (ofm ? 1 : 2)) & 0=
x3);
> +               addr +=3D x * fm->stride_x + c * element_size;
>                 break;
>         case 1: //nhcwb16:
> -               element_size =3D BIT((fm->precision >> 1) & 0x3);
> +               element_size =3D BIT((fm->precision >> (ofm ? 1 : 2)) & 0=
x3);
>
>                 addr +=3D (c / 16) * fm->stride_c + (16 * x + (c & 0xf)) =
* element_size;
>                 break;
> @@ -268,7 +269,7 @@ static int calc_sizes(struct drm_device *ddev,
>                         return -EINVAL;
>
>                 len =3D feat_matrix_length(info, &st->ifm, ifm_width,
> -                                        ifm_height, st->ifm.depth);
> +                                        ifm_height, st->ifm.depth, false=
);
>                 dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
>                         op, st->ifm.region, st->ifm.base[0], len);
>                 if (len =3D=3D U64_MAX)
> @@ -277,7 +278,7 @@ static int calc_sizes(struct drm_device *ddev,
>
>         if (ifm2) {
>                 len =3D feat_matrix_length(info, &st->ifm2, st->ifm.depth=
,
> -                                        0, st->ofm.depth);
> +                                        0, st->ofm.depth, false);
>                 dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
>                         op, st->ifm2.region, st->ifm2.base[0], len);
>                 if (len =3D=3D U64_MAX)
> @@ -309,7 +310,7 @@ static int calc_sizes(struct drm_device *ddev,
>         }
>
>         len =3D feat_matrix_length(info, &st->ofm, st->ofm.width,
> -                                st->ofm.height[2], st->ofm.depth);
> +                                st->ofm.height[2], st->ofm.depth, true);
>         dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
>                 op, st->ofm.region, st->ofm.base[0], len);
>         if (len =3D=3D U64_MAX)
> @@ -333,7 +334,7 @@ static int calc_sizes_elemwise(struct drm_device *dde=
v,
>                 depth =3D st->ifm.broadcast & 0x4 ? 0 : st->ofm.depth;
>
>                 len =3D feat_matrix_length(info, &st->ifm, width,
> -                                        height, depth);
> +                                        height, depth, false);
>                 dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
>                         op, st->ifm.region, st->ifm.base[0], len);
>                 if (len =3D=3D U64_MAX)
> @@ -346,7 +347,7 @@ static int calc_sizes_elemwise(struct drm_device *dde=
v,
>                 depth =3D st->ifm2.broadcast & 0x4 ? 0 : st->ofm.depth;
>
>                 len =3D feat_matrix_length(info, &st->ifm2, width,
> -                                        height, depth);
> +                                        height, depth, false);
>                 dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
>                         op, st->ifm2.region, st->ifm2.base[0], len);
>                 if (len =3D=3D U64_MAX)
> @@ -354,7 +355,7 @@ static int calc_sizes_elemwise(struct drm_device *dde=
v,
>         }
>
>         len =3D feat_matrix_length(info, &st->ofm, st->ofm.width,
> -                                st->ofm.height[2], st->ofm.depth);
> +                                st->ofm.height[2], st->ofm.depth, true);
>         dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
>                 op, st->ofm.region, st->ofm.base[0], len);
>         if (len =3D=3D U64_MAX)
> --
> 2.53.0
>
