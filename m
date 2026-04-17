Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231AFF436BD
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E58F10E090;
	Fri, 17 Apr 2026 17:01:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IVhJzk8l";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D64B210E090
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 17:01:52 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c555f886dso1218540c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 10:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776445312; cv=none;
 d=google.com; s=arc-20240605;
 b=TNncySM9N9zIf3eK0aGdoY+MBPnCrBD6FzMsEzoiKzGoGTkyeQz24aD7ECqLaS67/7
 y8rnk1rJ1VmWoJQilRCFb8Min1QIZdzr6vrP5sIEOusydM/46+wiGfakodgBrpWjFITD
 Ndtyk9Af3TEG9fxKWFBYdHqkjpPAAJArv2uFH50b4hwuZilVrgTtEQcZaHxCAruXcTbB
 NqEbFnsc7AmGjDzmwcIYQHZJ9fjYlh6AorXXOa6PZDGuk9/UUKjS5uAGrwTALwXdqgAl
 FKTjUrAOoaXFc6Yww1wmUIcEqmLMFezrJUzjvcMlNMRBCDF+3OYYXMTfQ885SyNG9tJq
 tvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EdXbw8ruQnDuxyXud9pqLO7P6ne13TbWgACZPF9q6l4=;
 fh=8c0pJb0x/JHrOQoX6OdtVDGrRgtF8ToMKcgmDIYzc7w=;
 b=d8rO3NdWwvyR+8Hjl0XSbIafjGq0SdxCqRuxu0k+fz391C7FozLuLytdwa/mzxXG9n
 iQaYnGnoA2URtCbtSHWqN8dOq7SpWAwrh2ESlQe1lnnFuKRqtWgQ6h4EIDR5dljfc63U
 TaHhQtflf9PmfmRoGuQCX7s5DFhwdg9ow3tcKbcbQs2dmuR16pFLF+aORaxkJWajnvlQ
 ezs1smg2SVPV8kRaTmpq9JXAE0e3Ol51/pFW0PjwxoZfdNQEdK16gUQFZHeeSwLRMdLh
 BWXJfDAIeGHMj5ZW1zg9+t3LvjmD2AhRvlqk2QDd3e6JoXVEGN1NQVQAFd/NjPT79UyI
 BKKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776445312; x=1777050112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EdXbw8ruQnDuxyXud9pqLO7P6ne13TbWgACZPF9q6l4=;
 b=IVhJzk8lHeUGwH5W0txwihTJyqn8aLB237xGIAJwev0RPWeV29fDcI1CbESwVVGCse
 jUMl8mjyHc+WOjI0oIV3Ji/B9DyrBjYKBEnzzNoI99kHWo4msguwDCChp+xcalc+fjg3
 /hdu143UBbvfcvAX7Ack3dausZEwmmTmK/hrMZHsYgNsUqGIgJO/PFYfsh3OdUo0U13a
 cEQafrJc3xGb6hgpycrZlu5+Z5pAqdgLsU4FbZfnM/G8FaaCMeQC4qTz4qJgYsYPSDQ6
 8PH7IRpDRF3Kt1X5d0qM7XF8MjVUpG2slz7VnJGMpDf8Yzd8eLPNAbYP/R48MBWKFKk7
 IFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776445312; x=1777050112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EdXbw8ruQnDuxyXud9pqLO7P6ne13TbWgACZPF9q6l4=;
 b=b0ByXQaOyV7cWg2/btLk6Re91B6dj6g515pS9LZ1OAJE96fHQW7lvbSUm/wZR/5P5u
 Ik6kcVdrWuBwnIqlctl/WFu63tM3AK0TXGUF4AeigR23IdRtH6aOIKeWY2R4/bIVmCLh
 HQb3tXOyiFtPuiGXDJJ0YtBb5L90ryI3SqngZ7m1+xFTVNiVJ8pvgXxcSnf22VKu8/C9
 tkXtPBkBmeXmSdwNdH1N0ueffupwEgWvT7FxaLtySm7O8wor687fF450nApNti2yAeh9
 Cg+aOqe5dh/sBvO4gseDWwhQcjsc/khG9qa2VqaABGurkmPyfessaQvNQ47fzOFQInZw
 26yQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ//qiDZ9whe2UBZkeE6OU1zNBg20TS+3z39biEeSjLBmPLmOc6+jJgCULU+NSYJeSqRbxdUqk8NV10=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEjk3LYJouNH8hGpNmdDQ2/sjTbs6zKEd7mf2WerY2D+5jJ7zz
 yqj5gZet6oDiTSPVH4YHDJrFpD0424Sd4cxAWacVH81qV0KkpiLhAmBVwgzeEI381v77dGk1Bxv
 MtTy3x+KQMGIhoqzxXlazScaS4EqA9og=
X-Gm-Gg: AeBDiesuBsgxRQbDs18nid3pxfpWQbeTPM1xi0WQt3D9e8RbdbAFalOSz5eS9tYmiZP
 a+hwJVC6turKW+T8idToU4QQ+yikI94ZidpinG+vXB9tIwD2XfJ7+DA+xBY78MQphuZDbbwCz19
 H5Us8cKXTQ/IUlgGNtVdKYpMvLxuh77mRSOjT31fzdRjihXHk2xYpO0ttzuv1gZrQ+HaIj4cpMP
 HNYnmLGu+HIwPF7P9R9gG8xhWr9jVoZwonJlvVKjjNCpTCPqN8z2uNiXM2N1n0d3o3KZFGTkijg
 EsEhspxSbt+WiuzwM47jlvgy2SB+UALgrwFK1JM7aQ+9QaNRHxtU3/dfzdMMZVWsKZ18kho6vrq
 tDUkuQ16jQWIKGAxpkNAWGltztS5vg3fi9agqKpSimShPXzHK
X-Received: by 2002:a05:7022:985:b0:128:d7a7:526b with SMTP id
 a92af1059eb24-12c73f957c5mr1805488c88.22.1776445311456; Fri, 17 Apr 2026
 10:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
In-Reply-To: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 17 Apr 2026 12:01:24 -0500
X-Gm-Features: AQROBzAmoDifysD6gsakq-ejyyvsk094ITMTDrSQ37RcrzyThndYubnsOWLSElk
Message-ID: <CAOCHtYg6_Gob1uQ3RBp_vrjunJ5F2qi_Yvd6Z0OpKktVXuSuXg@mail.gmail.com>
Subject: Re: [PATCH 0/8] drm/imagination: Job submission fixes and cleanup
To: Alessio Belle <alessio.belle@imgtec.com>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, stable@vger.kernel.org
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

On Mon, Mar 30, 2026 at 3:21=E2=80=AFAM Alessio Belle <alessio.belle@imgtec=
.com> wrote:
>
> The first two commits fix rare bugs and should be backported to stable
> branches.

Yeap, that triggered on BeaglePlay v7.0.0, Mesa 26.1.0-rc1 and xserver
21.1.20-1 overnight..  testing now (and updating xserver to 21.1.22 as
more glamor changes)..

https://gist.github.com/RobertCNelson/5e1dcf4c648a5bffaaf970c5a50e5c96

Regards,

>
> The rest is an attempt to cleanup and document the code to make it
> a bit easier to understand.
>
> Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
> ---
> Alessio Belle (8):
>       drm/imagination: Count paired job fence as dependency in prepare_jo=
b()
>       drm/imagination: Fit paired fragment job in the correct CCCB
>       drm/imagination: Skip check on paired job fence during job submissi=
on
>       drm/imagination: Rename pvr_queue_fence_is_ufo_backed() to reflect =
usage
>       drm/imagination: Rename fence returned by pvr_queue_job_arm()
>       drm/imagination: Move repeated job fence check to its own function
>       drm/imagination: Update check to skip prepare_job() for fragment jo=
bs
>       drm/imagination: Minor improvements to job submission code document=
ation
>
>  drivers/gpu/drm/imagination/pvr_job.c              |   8 +-
>  drivers/gpu/drm/imagination/pvr_queue.c            | 154 +++++++++++++--=
------
>  drivers/gpu/drm/imagination/pvr_queue.h            |   2 +-
>  .../gpu/drm/imagination/pvr_rogue_fwif_shared.h    |  10 +-
>  drivers/gpu/drm/imagination/pvr_sync.c             |   8 +-
>  drivers/gpu/drm/imagination/pvr_sync.h             |   2 +-
>  6 files changed, 110 insertions(+), 74 deletions(-)
> ---
> base-commit: 3bce3fdd1ff2ba242f76ab66659fff27207299f1
> change-id: 20260330-job-submission-fixes-cleanup-83e01196c3e9
>
> Best regards,
> --
> Alessio Belle <alessio.belle@imgtec.com>
>
>


--=20
Robert Nelson
https://rcn-ee.com/
