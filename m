Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86F3C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5DB110E0CD;
	Mon, 31 Aug 2026 14:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="wEas0RIm";
	dkim-atps=neutral
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4AC110E0CD
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:01:20 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-52e2d1bdbc0so24229431cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788184879; cv=none;
 d=google.com; s=arc-20260327;
 b=XqReiDoiKr+O3bjc3g0oA4LymAS+I4VAj3FqKpDNSxXS05tt0eO2z63+q2wL650x3N
 phC/jrE351SxhWElHe6drl2ZFINWIFxBUngCwHDpHkfUHbrd0qn1totfGX9g0NbUKXXk
 5Ia+Jbp+AZAThK3jmjezb/0ka/f0QAK1VNFEot+JyxxHxWjqUcm2e+n3jDL7VTrloJbc
 Y4OdZA7BxM2ZbemGyg4O+/yaEy4emiomk6qVMBbELieZnT+fWR3rB9Lke9yXAypyh+Ge
 FZ+DSkwngN5/YEo8RAndHDJVWKvShIpoJp5qu4BsqeNOM9qIq/2owdB1Rt21r1HvLOTc
 qKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H3BurnIf1acdo2QjyF+5k+gl4wMqU1+wSINPn6qNRGc=;
 fh=pXS/lQlupyoBJ49gPvPLM+bWbxt7j8XR8nJDz4ZhJUo=;
 b=sSjQUdhiJGg9hfVxjq0bBhMZpsVrBSOILoIrv+lhUebp4P7UuuIawH7QdDEXtImpwu
 Ca4Z7iSy9c2CVGWJ2EytDp6kklFPSJb1lGbsTteK88/dVA3j330HTbR9P9vT+GoT93Rs
 Ux68LSRy8QNLGgxTx90km+U+WG7Ch40lF2qmCDv//0YWNlktS3HjOFx2mEv4vFFyTGn7
 4IkAD9TZys+Uk0p0ltGWN9QJ0dcvGgZtAGk1WlqFKIXa2yt3ardEFF3dZYUGeEIzo9fq
 VbQAtuXIbE/e97IFvArP26JxEdNX75ThUrigInZsR8T58sBQNc4mTCj4bVai8uyw4Ui1
 zD7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788184879; x=1788789679;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H3BurnIf1acdo2QjyF+5k+gl4wMqU1+wSINPn6qNRGc=;
 b=wEas0RImegpNN1Tc1XFc8GQs/+9Muo6tSVH/WIaidxRIEqT8YH4mB1hPudtXwS9vXz
 tAKx/WqvZRFCo/mOfHOzert4UC450KiLx+iKkedSL5aJ5ED56sluj9Elz+RoDgkxTKE4
 h9RQM4lAn6RZkLw0z3jQqxXfhY8eHh9LYa7DAFBhvFP2adK8YHpLT+rSUaoOJrDezt5p
 H/I/0B+mqkmxpUQk0GUIlvOYPmt/t8S6lzE1nWIm7WuO7BoQFaYuJIrJ9yFC0yRZZJsf
 tgQaQK9YfGruOt1XvYi35J8sebXmtWuP9D7zLNab21uJMb/GplmZ5sVY24vVqr0JhSdc
 QDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184879; x=1788789679;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H3BurnIf1acdo2QjyF+5k+gl4wMqU1+wSINPn6qNRGc=;
 b=U7DEWrXkk+DnKMyTge+rp+8hZZCIoX4oyKlkkwJTCDbDlYDpgCpg+fBH5nyXzFSxw6
 a40nTTz61mJY+BcxXdg8gO+k/gqO8z7vk2W1+3giPT33K1+IVgP3U5O9Te+FfUHgdhpj
 tDtD//0hACfBk7FtBJAM1kpftaBUl2zytFYdPonUg+4BuGOtGS5sm8aXBD545AIgqm0W
 tNuK4lwBi2ngYAcewdQ0jXP965m1ElQYIB1cZkoF6rQLOx+5GxGre0GxZKYh0Q0vn0Hu
 TLfLsYgMUqChlJ+hhfw863HFRz1RBqIfna39xjcJ0TUvgl8a6sms5fJRGmf8bSp1dZCl
 kcZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRYW4N+VM18XY2zgnjPBWiYV0p92Dt42kvXvkJSDcmlqV54mKgmoIuZ/iVh9MDwyAptpQlakWLQBE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l/e9+ZjOejZigSGw9akeHVe33rFOPuIkWksvxqqqkkgZ5drzmK
 fvYRVdxctrfCPoSy7yzfkYbHT9YxhpNDVVxTd5BpNjUeY3f20gktV3WdXK8G1FUavXAgj7J2GGH
 KQTjs5MHvx0lSMjVKHFu8lxfUesK56RW6fHle96G0
X-Gm-Gg: AR+sD11g5QNbIy2Lh2FCQO0NPmkB8n7P7x8KzgcfrhBCXRzNhZy1FkRxWb1EgtjiBzr
 OR5NK3RH1GX0s9U2DLzhh+vz2C/4ydZwN27niZtNm4suQNRz9d3EqyQR9J9KCIF4sTr5FmMaReH
 kCNueMqgxxfFkQSy1ib409bBYacoE2eEdbUQ9I5PX+kilwM1Aes6JHSoAXXSo2MrTvLC4Ry3pLh
 Zr6Fw9kR+gYZESnr4kTYh5iuD+eFbqD0oZTr3m6SNNtoLu44CcLy7ZJ22DgbgeZ2WpYAvJtDBI8
 YlL5Dnn5+8uAWMV8HvbUwrEHDy/zB/EtdvLtyi3Fj172etIbbYu5hKyknLSXvmYSQ7przZHSVbM
 =
X-Received: by 2002:a05:622a:258e:b0:51c:849e:e222 with SMTP id
 d75a77b69052e-52fb96da379mr358321001cf.36.1788184878614; Mon, 31 Aug 2026
 07:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260828-vkms_virtual_output_fix-v1-1-789718f4cb00@igalia.com>
 <5443fa9f99309b0ec0afdd98319619a63d5467a3@intel.com>
In-Reply-To: <5443fa9f99309b0ec0afdd98319619a63d5467a3@intel.com>
From: Mark Yacoub <markyacoub@google.com>
Date: Mon, 31 Aug 2026 10:01:07 -0400
X-Gm-Features: AcwNN1Vm6DxVVD1vouZsBNUj-qN4Y7_859ULhcLF_n0YRIHtkn2r1qeGBi_noIU
Message-ID: <CAC0gqY650NvYr5_NwKXM3sFNYQ=G7T9kx_=8GZWE7faveSZwRg@mail.gmail.com>
Subject: Re: [PATCH i-g-t] Revert "lib/igt_kms: Do not treat writeback and
 virtual connectors as connected"
To: Jani Nikula <jani.nikula@intel.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, louis.chauvet@bootlin.com, 
 hamohammed.sa@gmail.comm, simona@ffwll.ch, melissa.srw@gmail.com, 
 robin.clark@oss.qualcomm.com, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, 
 sean@poorly.run, marijn.suijten@somainline.org, 
 Kamil Konieczny <kamil.konieczny@linux.intel.com>, "S,
 Sowmiya" <sowmiya.s@intel.com>, kernel-dev@igalia.com
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

On Mon, Aug 31, 2026 at 4:51=E2=80=AFAM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> On Fri, 28 Aug 2026, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> =
wrote:
> > This reverts commit 321448df7fc9af29b4c6697dc74e6c5e2100af6c.
> >
> > It has broken vkms testing, which has only Virtual connectors.
> >
> > Cc: Mark Yacoub <markyacoub@google.com>
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>
> FWIW,
>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Mark Yacoub <markyacoub@google.com>
>
> But you should solicit feedback from the author, reviewer, and committer
> of 321448df7fc9 ("lib/igt_kms: Do not treat writeback and virtual
> connectors as connected").
>
>
> > ---
> >  lib/igt_kms.h | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/lib/igt_kms.h b/lib/igt_kms.h
> > index 695f666bacb9..27f8877a9f6a 100644
> > --- a/lib/igt_kms.h
> > +++ b/lib/igt_kms.h
> > @@ -669,10 +669,6 @@ static inline bool igt_output_is_connected(igt_out=
put_t *output)
> >           !output->config.connector->count_modes)
> >               return false;
> >
> > -     if (output->config.connector->connector_type =3D=3D DRM_MODE_CONN=
ECTOR_WRITEBACK ||
> > -         output->config.connector->connector_type =3D=3D DRM_MODE_CONN=
ECTOR_VIRTUAL)
> > -             return false;
> > -
> >       if (output->config.connector->connection =3D=3D DRM_MODE_CONNECTE=
D)
> >               return true;
> >
> >
> > ---
> > base-commit: c0c86b23b316bec7d22bbb95e433a8dc25884a1c
> > change-id: 20260828-vkms_virtual_output_fix-c82298792438
> >
> > Best regards,
> > --
> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> >
>
> --
> Jani Nikula, Intel
