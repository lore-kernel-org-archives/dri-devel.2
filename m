Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105B0C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 21:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3712310E4CE;
	Wed, 22 Jul 2026 21:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="degoy5Rl";
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395BB10E4CE
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 21:02:17 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-6a31c05e092so4095987eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784754136; cv=none;
 d=google.com; s=arc-20260327;
 b=jaI9baDjGp2QmvI8HDUBUPHZYleWiBbl9We8/h5w4Wo3vjkvDFRTnpiG3p70KUVCet
 AFBmRvMXGpxTeFZrwxZhemujgIu1d4h58E2lIrjOEItA1mkn2wdC8UcRp9uYGlHViIju
 rvpw1ARBxKAtHwqerg5MPymFEGtctQ+AJxHlgyzLkC2EXioeCbXtHvQIVhYmSqp6rf86
 NtTwvl+u4OcRojmZJDmBu78pDfJOVvBAShhLyWNTbozXpWoprQ2oCcwcRjrfTfVKfr8U
 GINw3PpbygJJzOYnNtW4Q3eXhHJhc5VHGO/4i8c6OssYIacP8RkN3OR0Mui1mjpIvFAt
 NkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N/J8ZRAJ2jKbGKOvxS4NGsMuN+C5DazJPN6FudGmP8k=;
 fh=qz99BHhGnsG+9767Jv+pwtFRu6ezssbmGxDpgwb559U=;
 b=eb4wCmJ5AjhRL/xkMlBO4OT4JhlI+Xi2eIjR5eF1+WVe+oDZEZBH/tIqAmYxRlSwBZ
 EjgRh/XCzk60rPcx91g1aJRBrRw1oUcckD+expgHAbZZ+xxRB0Rxinrqz8JIy3jTcsvd
 u+ZnHPDKE+cOTvsH0t2KyEpqsRuPqFtperZWzeAgY07TtHyAAl+cDvM4OMDoat1sIEMg
 hBKGX1j/J84eVN1qBRYeUVUK30y3/LslBGNOdfDDYBTW1G10wxr6sSkPP+rwLFL2BSFr
 SMmnqQHLwwgJPA8AocCOMQglKZzz5w/l3exZ295daW7OWZHNcgAebHmzm4AYSdoVO15q
 IrpA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784754136; x=1785358936; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N/J8ZRAJ2jKbGKOvxS4NGsMuN+C5DazJPN6FudGmP8k=;
 b=degoy5Rl69LEzH8WmebQthpEwX30JfwutprmW0Ie74W/05iswSXmAavcSISFh7W2Y0
 wG8VHMr3n53oAxkb8TtlZjKbR3C0Ey2zgCZWozgW5KDKJdGaovb4Q6JFCJOouvkjwyha
 It9V5V7kJHzEEvAk16r0amx+8lHePEkhsJHcnMaUg8wFBSyJPh4zZ7sAtCVAJ5FtqN9k
 DfvhjZQ0Y7THzXy3qBwYb1pQGuRryeG2qDzDpIcNRL/QiNwVUwvGjaXl2vKrAJimg6nJ
 GJaaq2gkyVpxMePe/x6y5h4nmeXAMp8jWrhyVePxRJhcnV8YT2m6C1EURNWXG4Hg++v7
 9Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784754136; x=1785358936;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N/J8ZRAJ2jKbGKOvxS4NGsMuN+C5DazJPN6FudGmP8k=;
 b=L6LxyWcK5lGw00N46eI4FOLmLs0qJEg6TQ88BoetjjXsbaYyfOjZvQoyVJJdzn1hdq
 ZC6aUNi+tuxFp85VzPCFTYBwA2E/M6VSEYc/SG3qAGeD23sJ/vCcd/wm9qFcyJXCyWPJ
 1xw7D115j5y/ue8rIG5LsMRtF4P53oHj2VUxn9E0fREvVvu7xh7pVrxsyTvMZm2Yev7N
 7B4RJpAlm80mwNI/Y8Khsv3vZJaX7srj9VpO5+8jaIWCeO+ykLvPtPZfJmuxYUdVju/T
 CKjbDgqT7MKeGlirOYwRs9itudASqq4obDnLD19o6wWDB4Z1xdvrqyfSROk0oRLtFRWA
 PIug==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZixBE4rbKgfYM7q5FYaYncKk8xcNiUoQh9G4XADS8leV8kL/dOLeQrW5f8XQXd/HWPpdc2WqMG5M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoURVYf8vHsFcwkbJzECn2/yGcRTcN0lga2BORCThuDEb4A1tP
 Zd/77baT266tnXrF0tOSQbi4YY7f331q6n1Oo+KzYqEJR5cFr1OYhzZPveQaGIktFkwIwwPYm2T
 R2tKyzhYRlHUDb2+kKhsBlr9qzz2JzHk=
X-Gm-Gg: AR+sD12UBUw5+p7ZwFAnTthU2gBS70n29p2/0HtiphKnKjTswSZ8It7nN3ORlu9M9nj
 REtaSnb16uhlsJPvAclF1nI3Ibb5Es+LQz2Wdid0t3mCo78Wm6uNSDsscb600vjDfHOpg+iH1wb
 IBl0iaICdCGYQQZKIQiXF8mKmieDKUwE+kdBKaB0vLxEiHH59MG/VXgOHgnO6lHP5UnF1CKv/K8
 rmZR1YnQrbmJWFHGdASCCSEAtzcnEr8/Ep7+nD13vs7jLbrehKHDtsmOT8z1g==
X-Received: by 2002:a05:6820:1527:b0:6a1:50eb:d512 with SMTP id
 006d021491bc7-6aad41ab5c6mr31970eaf.67.1784754135081; Wed, 22 Jul 2026
 14:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260625003240.6923-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260625003240.6923-1-pengpeng@iscas.ac.cn>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 22 Jul 2026 23:02:04 +0200
X-Gm-Features: AUfX_mzjZpVLlBqOGksC9aIWbYcd6g6WcpymMA2paAqZwq8-gY_67Zk4W6qVAhM
Message-ID: <CAMeQTsb8yaw4KDD=xoKrM8t0B9+AtsvqztdUB1z9BRLaY5ZxqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: return errors from Oaktrail HDMI I2C reads
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
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

On Thu, Jun 25, 2026 at 2:32=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> xfer_read() waits for the HDMI I2C transaction to reach
> I2C_TRANSACTION_DONE, but it ignores both timeout and signal returns from
> wait_for_completion_interruptible_timeout().  If the interrupt never
> advances the transaction state, the loop can wait forever.
>
> Return -ETIMEDOUT when the completion wait expires, propagate interrupted
> waits, and make the I2C master_xfer callback return the first transfer
> error instead of reporting a successful message count.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Thanks for the patch.

Applied to drm-misc-fixes.

-Patrik

> ---
>  drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c b/drivers/gpu/drm=
/gma500/oaktrail_hdmi_i2c.c
> index 2a7916ca5..a780643f2 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
> @@ -98,6 +98,7 @@ static int xfer_read(struct i2c_adapter *adap, struct i=
2c_msg *pmsg)
>         struct oaktrail_hdmi_dev *hdmi_dev =3D i2c_get_adapdata(adap);
>         struct hdmi_i2c_dev *i2c_dev =3D hdmi_dev->i2c_dev;
>         u32 temp;
> +       int ret;
>
>         i2c_dev->status =3D I2C_STAT_INIT;
>         i2c_dev->msg =3D pmsg;
> @@ -109,9 +110,14 @@ static int xfer_read(struct i2c_adapter *adap, struc=
t i2c_msg *pmsg)
>         HDMI_WRITE(HDMI_HI2CHCR, temp);
>         HDMI_READ(HDMI_HI2CHCR);
>
> -       while (i2c_dev->status !=3D I2C_TRANSACTION_DONE)
> -               wait_for_completion_interruptible_timeout(&i2c_dev->compl=
ete,
> +       while (i2c_dev->status !=3D I2C_TRANSACTION_DONE) {
> +               ret =3D wait_for_completion_interruptible_timeout(&i2c_de=
v->complete,
>                                                                 10 * HZ);
> +               if (ret < 0)
> +                       return ret;
> +               if (!ret)
> +                       return -ETIMEDOUT;
> +       }
>
>         return 0;
>  }
> @@ -130,7 +136,7 @@ static int oaktrail_hdmi_i2c_access(struct i2c_adapte=
r *adap,
>  {
>         struct oaktrail_hdmi_dev *hdmi_dev =3D i2c_get_adapdata(adap);
>         struct hdmi_i2c_dev *i2c_dev =3D hdmi_dev->i2c_dev;
> -       int i;
> +       int i, ret =3D 0;
>
>         mutex_lock(&i2c_dev->i2c_lock);
>
> @@ -142,9 +148,11 @@ static int oaktrail_hdmi_i2c_access(struct i2c_adapt=
er *adap,
>         for (i =3D 0; i < num; i++) {
>                 if (pmsg->len && pmsg->buf) {
>                         if (pmsg->flags & I2C_M_RD)
> -                               xfer_read(adap, pmsg);
> +                               ret =3D xfer_read(adap, pmsg);
>                         else
> -                               xfer_write(adap, pmsg);
> +                               ret =3D xfer_write(adap, pmsg);
> +                       if (ret)
> +                               break;
>                 }
>                 pmsg++;         /* next message */
>         }
> @@ -154,6 +162,9 @@ static int oaktrail_hdmi_i2c_access(struct i2c_adapte=
r *adap,
>
>         mutex_unlock(&i2c_dev->i2c_lock);
>
> +       if (ret)
> +               return ret;
> +
>         return i;
>  }
>
> --
> 2.50.1 (Apple Git-155)
>
