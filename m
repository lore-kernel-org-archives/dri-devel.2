Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22440CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EA110ED0F;
	Wed, 13 May 2026 07:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pwlu8cvB";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A752010E959
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 02:08:11 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-7bde9d73678so53251947b3.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 19:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778551690; cv=none;
 d=google.com; s=arc-20240605;
 b=d+17PSCchCeEu5FsRlD/QhK8XIdQLGbn1BcFclrFJyCd2dM9eparbrBgAAbL//T2O/
 oCeGkujOZ6toya6BiNurqysWvQZmWcg82RBvKKq6ozhVhig8fJ/sWZ+eAlF+WgkbwGBh
 uZLiTIP1lTW0SbdHABawOGuGSNCDbuMBfr/0l5B7NOMUcD79jie01iHiCX5wEGxv/uvB
 LP9FdZ8DFvUB1NW12/stVHLDzxQRNlokD/lFi6bIIcOYwPT83HPI6AD9EusIZWks9CTo
 rTp9EiaeWNZ1GP8xkF+daoHmz1fzwcEtKxhUG9H+PjpkfBod9VkoO4Hl/eTValyLJURc
 Nogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=77FISKu6p2sK0Ty+tC1DOLiHarz8B8kEbkXuaAXpQYA=;
 fh=ahk+B6LdC52mS/V/l6cZ8StLBmBIMMhQlM550AiSJY0=;
 b=XTc2qTjf0gQVxwGKIA0wvHiKeTVDbO0K3GoKO59N5t38KjIfZozd1JK89T13ul3aZB
 e1Y+HY2zNp6kqtrKdhzIlyzuvdrqDtJ4qZb2B8cqT9z8qAXzyX3wEny+gDbwUNqI8FwU
 wJ0mrGLDqip/NJvLaMOAeJzvBThSbEe4HIet74134XEGfqB1aFKJnizMD9fM6VIsQgKy
 alKGBGHmDN5Ip38LezSOa7jIujy1UekqGagrmaH83h9DIXyW5ycCWj1uGBoHoDFzrEk3
 7Kc+OT64Zb/ONGBH68QHqTHJS/3tU6GhHUpaZ4/LqZg9dXcWo3z0FAqb1XI5EkszzUmL
 hICQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778551690; x=1779156490; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77FISKu6p2sK0Ty+tC1DOLiHarz8B8kEbkXuaAXpQYA=;
 b=pwlu8cvBopLmwqXZwvtA14npDuzRLmBtUJpwZuBHhGfJXcEYS9bzGmjPmmyFxJ0wzh
 e/JFou9kDArZ07pAkvlpBwtHPzQL9MT4h2JP+aY0AFEeTBHDCJmsGN1d53v5+EWjkjNV
 ulCEZtL6ih9/6V8xk3JxOSpWxouoc6StB7fS2pCPcIqC+F8S5ssZYTJ5hNREJ+/UZVGt
 FrpZFJgedasp+Zt4D+unkaLJgmCwcby/HPjxs0xzJOcKaZs+4lg/CgoR7EZggOqeP4/Y
 GLdxTJ6bck0DLMILtvOa0NAAQcV0AKA0tbzb0cfmpzJeAQDyp3whx5vN5L/jMtPDyP8C
 gxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778551690; x=1779156490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=77FISKu6p2sK0Ty+tC1DOLiHarz8B8kEbkXuaAXpQYA=;
 b=Ewt6atSjNjGuJGxq/8+bGPgnzSGVej9yl/gFkUnqd49HtAoCVcE3IYXZZZvdp6vjRY
 W6GPx3n8Myuv6K8fqqJZykDRln0lpRDVfonT/UWqbZ/VFfxGtyRvn6+ulnDM4pvyXhuV
 mP3v0EKdnJGlKL6sW9s3bL8f1ZKePWOf8QRYtbMnh5TNhyExjkoY2G/S3WqpUxYnGJYQ
 wF/iMJEpBcWY+aRUWEcirjP+RrFXnyZ+mgYwztE/0dhaoIbO/bB+A6GwO1CQaZ8uV+KY
 TPE9Gtw/YxTKB//5Yc1rMa+0u05WMqzNPbSUZhKDEIiaOBOCe5L9hFcRuvfleJb1tBFR
 tWIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eqohkBAKkfVcNl6UWvIdhQ2k56vpjhSgq9dt0wPj1KAPNmlUaS9GhT4YNZyu1Y2y5xSOvqG22MuM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiUtIpoT8Lim9QZptGxBOLynAXiN1/NbZXPJyQw1vVs2bk0sDE
 gxh8MdxNq7Eoe5etij7xaXutxBsd1WW5D7CoWeZvAIVRxmnjhM+1IfQsBkCE2NTnkmx47moIlsA
 LpbhL33UQbk5wu7zU/ui8OR8XMiNrXtw=
X-Gm-Gg: Acq92OHz9HNWb0RXtpNwclcx3hxn/TjvCOqA3vZo4tmg+A4qQBl8XjDc+kOpw0eZFjg
 S8SGdoR1hnvlfWwlEK9//VIxe/JxWNNy/QZOEVumRsdzXifIC3FpEivBlp0KciQXsycB9Hlrqih
 ohGxgftPFnGFX75qNoJT/2BObo4Po3kfH/ODUOlYQMFzmNUePrSMxcunRHPYfDatUXLWSon3MWm
 5C8OP8JwRsli3yvS7Nj8P560y/kNF4s/wlLyu1Sx8vpDdcGbEVjVwgOUFDHhYZy9Vc5iCTFV+vn
 HRlI8co/pbS3I+TGQl2uwOQQoO9KqY4pdBNA5Ld+Xw2I1R2nwSwtfw37LuBkrUqSaHlmtv/Z
X-Received: by 2002:a05:690c:22c4:b0:7bd:92fc:bffc with SMTP id
 00721157ae682-7c510b7019dmr17683127b3.28.1778551690519; Mon, 11 May 2026
 19:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260510053025.100224-1-kartikey406@gmail.com>
 <e1741cf2-3416-4464-bcae-741f0c87448b@collabora.com>
In-Reply-To: <e1741cf2-3416-4464-bcae-741f0c87448b@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 12 May 2026 07:37:59 +0530
X-Gm-Features: AVHnY4J2D1-C23A11f7UqzcVhKI94fEZIIYuSoxukd33EEp1xmrI8ysvEMqjWdI
Message-ID: <CADhLXY6wZfejdnGRKBy5raFE8U_VAivqx=oa+tmNAAOx-cSF9g@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: check virtio_gpu_array_lock_resv() return in
 cursor update
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
 olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org, 
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

On Mon, May 11, 2026 at 2:41=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>                        plane->state->crtc_w,
>
> Thanks for the patch. Atomic update shouldn't fail due to non-critical
> errors like on a signal interrupt. Could you please move this code that
> may fail in update() to .prepare/cleanup_fb() callbacks?
>
> --
> Best regards,
> Dmitry

Thanks for the feedback . I have sent patch v2.

Thanks

Deepanshu kartikey
