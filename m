Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473C4C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2F710E50F;
	Tue, 15 Sep 2026 21:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K9lfdrhH";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC9B10E623
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:19:29 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-8620ffc9ec7so21467b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789507169; cv=none;
 d=google.com; s=arc-20260327;
 b=rrw4xZ4EBqIh7mz94WuQvpvUUvGNMLV9CIMLba5OnMbMeg7Jl5SfVc/Al0hnFniprJ
 1HnZO8lQ6gBeJcyU17wsUvziMi/fJI8TLhu5GuYGoNSI4yduuYKO1f5f+GI9lRt5wwp9
 QFyedl0dAK7wJvhJ78gY+5uHKb4sxAiBqOyaiJ2zoIeEmdhWuxqWGEi8yKfVwXtW67e5
 Yz0jp7F1SJvZuQOOpJtFVv9GdQ2Ew1Ix1sY6wkSSVCA//a4K7sj1Ez6dHgnmrIkC9Iem
 MqwSK5C+v78+VIUm2qXFrwl2koTOKyZrc6KicXbtkmZO8UNktFCDMWx/xcld3oHha/Px
 tgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=27RlSNmJ/rh6QBvW1joFS9tTEzX+MG2zy1HOT3+SmIQ=;
 fh=QorSRqwjUTu054QVP+gecli/ccIepi2TXK/JopHz9hY=;
 b=YQB9PkRZq2s2PDK7InIuubkGPo7JdW7Bpg2vqN8zaZXmihuFQkCDwzGOjtY30bF89d
 x+S0ZSx2cbZDh4uH/2vkg1ird2oDZ8n1kgU1sx7FlYPHXTH+UoqrJdt3X3aOVX87IbND
 3xq/Or8C7v+vJyQ0pkjWKERv+PRXDDLm5yqtY6szany8+PewIdD2ed9by+IQSfNIz02E
 jSPEX1JDsHHLgroSlTi4CZzzMEIIqXnOZQIwYv/TlhVvqUbelSR2MrgjVohlTQ7t42Zu
 zi9CY3/brRdeW+YgYlwBds1JNc3fwNiBtCDt+fSdcBvuoPIRpGsUSoU566PYW7OLzPcH
 wBDA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789507169; x=1790111969; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=27RlSNmJ/rh6QBvW1joFS9tTEzX+MG2zy1HOT3+SmIQ=;
 b=K9lfdrhHL5H8OUuX0jauBSq++j6KJm2i5jGQghvCdy4e15OaiPWWPrXAMvAQ5xRx8N
 TiJYhUmoRYOLYJZ08yM4BriMSPDrTDqNJxWBU9razJ6mqrrDtejEUARiGkcK3RJdR0TS
 bFEM7tJ+bqFgnE1nolYeQgB5jGMTWYJUZfhNTvkI06v89QT+mG2VRl1HNztAFf7H/hxz
 30264Ny7QG8fBhTpXxRfjwuDkvQvzmf55ElPbOAGoNNTRyMvJRlqGoCI3jyIXBVRJvN3
 DNoW8P/LuDGUbp+owAblIP6afdGgxEeNyfP/zZ5JgB3x9GIwTL6VeB05Oua6o2gHyiRm
 X1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789507169; x=1790111969;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=27RlSNmJ/rh6QBvW1joFS9tTEzX+MG2zy1HOT3+SmIQ=;
 b=Oid1vwkGeja9f0NlF0UYNtGZpajVi9KVrEAuk1uH7+sGRjhVk+fIeB6cmthZCPgEbs
 kBrcI7MZU/EKMqb1E8fiG4uglsCK7yqbSOtJ/x65/q9B1yyomiOPqbGylbUWIIsVAeea
 qlQxgKe9dcbnFfbcAWtHAglQRCUd78pDDSF2eXyDqiLQCxPrih6+hm3l/juqHGo9X9iC
 vZ2YhITv3rrYiHWjwqcnPJW+CTWfBsQR6/XGTdSsB2t9GyiSvwhv8hkAQYEGjpCdD3jf
 ewNQxrFz+gEgqVEYrA9YvrW9XSjSliYg6il4FP0vEeHp3JdwUkhWqmW6l0a3NwTFZgHU
 BAbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbZM8q/9EPmNTlL4jdUrduU2pe30q5CLdprK+XsQlcmRwnYDhlXqz2aLnSdLh+cRmbxIfFWyo0020=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ka6laYO/TBpy6bziki5vzTYYCIqNlO9c6UtXJHEuZcL99MF2PO
 DFx7Lpe7IjyAFS1Js43OrZZZpVdF/XPBXq76J8DkSWDvJBfNfpc5/gq1OGF1j0huZC1il00H80U
 TStkFo3EFO3dn5k+hTCs5sErsCr5O6io=
X-Gm-Gg: AYBFou0otxhxqik+Mp/nJPIK2ZslMDJlBAdC5l0Rfh99u8puvjJ4+1MAkLOCb4MSOVT
 XFpE17HLzWPMTSDoE4jUYCeQOvLCz85WRAQDOBY3H7EWgBAR7wGcBfhMn5hU7EDMnMF12Ki0vPp
 1exK9qqnA32DV1oGTTBFXn4uX8aqDc4jIaKFjOAZormf9j8L0ok12OKiLbXyTNdZjSrcr8DAZFf
 59dp7z5VL5eAj/+VIXaqtuiw4shqotvM2+V+WPE0Kuroxgz5a12jBAqVcj/8ONCdEeqPQ5hrW1h
 tTSYjRA63H+0MSqIX0tCIt2yhMciZQzDpGCPr62fd+EgaVx4ZMCLJJ1HEAVf6QgEeGF639jK3j8
 rx6IrpYW/h/5el66KxfhG9C0xKrUtWvNlPO8/5cfFmw==
X-Received: by 2002:a17:90b:4d86:b0:39e:fbf:e7b5 with SMTP id
 98e67ed59e1d1-39e1ed3a90emr151963a91.6.1789507168853; Tue, 15 Sep 2026
 14:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <aql0WF8CnlzgS4nz@stanley.mountain>
In-Reply-To: <aql0WF8CnlzgS4nz@stanley.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 17:19:17 -0400
X-Gm-Features: AcwNN1UIlmrWYu-j75aUFWIeZN3UW5lDNCOHYA_6wiqw4odajfx7LULhYdnp4hE
Message-ID: <CADnq5_OhB4DVhvyGtQ2yCi12xg5yMUtmT0sRGuU-AxZk2ox0LA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: delete a stray tab
To: Dan Carpenter <error27@gmail.com>
Cc: Yang Wang <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, 
 Asad Kamal <asad.kamal@amd.com>, Kevin Wang <kevin.wang@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
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

On Tue, Sep 15, 2026 at 12:46=E2=80=AFPM Dan Carpenter <error27@gmail.com> =
wrote:
>
> This tab was accidentally added in commit 6c9e0328d1de ("drm/amd/pm:
> refactor PPT limits by controller and power source").  Delete it.
>
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index a29e76b03476..6beafabf1306 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -3077,7 +3077,7 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_con=
text *smu,
>                                 return ret;
>                         }
>                 }
> -                       return smu_v13_0_set_ppt_limit(smu, limit_type, l=
imit);
> +               return smu_v13_0_set_ppt_limit(smu, limit_type, limit);
>         } else if (smu->od_enabled) {
>                 ret =3D smu_v13_0_set_ppt_limit(smu, limit_type, msg_limi=
t);
>                 if (ret)
> --
> 2.53.0
>
