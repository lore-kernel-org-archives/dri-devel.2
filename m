Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD7FC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DEE810EFE9;
	Wed, 23 Sep 2026 12:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ETQq6E0d";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD95510EFE5
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:07:11 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4aac929eso772492d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 05:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790165231; cv=none;
 d=google.com; s=arc-20260327;
 b=Hqd82FmNTV1EnBdwB7Q0WB/zka6L510aBDpgoI7VDp3goGypatl5T9QZZs8+ZACBwn
 7O1oVm3K/uvVQr/YioW8cS8ol2+SnwyOjkEAeZqaX2wj/5KJELaneD3LKiwW9PUdwD0x
 TZ7M16KuxUyqfbpig1RSD9QFMmrtoOIlzQ6/tPaXxXfns2RNWCmofqf7aIcB652uvjDa
 khRUP0JIl5rMXva2u+XpgwpsHlRiXLHfSefUGcnPyuutaK2uYr/161pd1+QlmiV3FY4g
 /qN47/yltWhRS0ONKDOneIYDX1IVuzjyDNw25rurdE519bjq+SXXeeMsYFldGWnkCYkW
 cp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=zpU/XY8e48Q2+0PRyBjZnlyv3POmacflBmWvv14mODs=;
 fh=iWB8eoZaEtFUfyS8gCVuwN5Nh5L4hc6WcwwIs2fTYdY=;
 b=Zcat130go6hDbK1/AoXgAO1NnYN0BfJycWKKd+pez2hWn+pR7kBFl92xU6akQwkE5d
 XLV1FySE6lHEKVJ8S7SiCuFL8FipcJ4+gpK+DzmpZ0oeCNTSGzsT5TkBOuTucE/FhbKb
 RjydUF7d0Tz3LvxYEP5StK5hHPjIW5MZm730pav0wtRKDCGVw28LiUdE9YXrQKcNjrrI
 e90mdvtP5IqjCUxbj6kfkLfxtx0tesw0XbcB2N8aTwDrunXmBobS2bGjs06smf271P90
 tDPCYtpjkMhqEKjUsAC4Td7FyIlI9tAKzDJ6RoUboV1j35wfXZNHLsJZ6y4GqXua9o6z
 bPqA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790165231; x=1790770031; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zpU/XY8e48Q2+0PRyBjZnlyv3POmacflBmWvv14mODs=;
 b=ETQq6E0dUCKBsZqbLAKpk3oVqyYWPAAOTlvS40FIGPc6CZ1PJtHAC/TYPPQMHYAEbq
 kOIfPv1k0wvuP91muP8xMRh0XFPc4amdseELmJNcOLIiP8/iaZ8bPo58YuwaYDh8vYMY
 FUrrDIIF8pGhXKXU7jNsmacVihYvFLFg40wjZWedhsUXg9iCjxFhaS9B79ql1C2yWK29
 5ULzNlHIxx3LsNgCNlwrBvnJIOuCZzLPe5JWbJBtwAgSJA1lnsSXYLgPhcelP7aNz0bW
 3gAdSkTbhBW9maGnFN/2P3M5G27Pd94hzDuxoBdFk+A3DidveMWGQPLiAdNOrUaQJbIp
 PGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790165231; x=1790770031;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zpU/XY8e48Q2+0PRyBjZnlyv3POmacflBmWvv14mODs=;
 b=D37ZhcRD8FOqvQG3fJFvBqNYMNRV+yE55KFnLCEk2FreaIY+nrRSUCMz61PK7J89zD
 Pc2cgd26fKOp6IGroJfFI/rPhTsI+lvWQTZEjkF9cpLucu4aeiqOfEYFxTXeQcA1ijPI
 TNa0J6aH2YYaIoaxBL+OmFNqPbDQwu1g6WsTcWqSBEV3A9Vi2RBWQOZr1PmDbuZQ7yYw
 o5/lUrY6NUZLo3oC6RiFTzyJkO424SusOMcJABIN706NLbYgk0QKb8NfOQEPoEZDeocs
 WRTkP0/XaJ68suWOqH5er6bHK6tr93aRk4ndmJ7M3qqp+qSzcdtpiMrriq4e6ZDhZlB3
 PUPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/3Hb9THe+dj+qv44wiBCE/d18DOoQiodO2lgBjymR7WlBC0UVLDOnFOmmHuTBZef/elO6xpaV93k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kWWk4+Bp+GZH6V4qUpqJbYsU35ouA82XSBFLkCeBtd4/sWAJoL
 5L5/Tn9hi0FtozliDUUtXtrtRDZUZ2rxcw7gsAkMp+7B9p/1TSoYoGWOKKvubdB7cfrb+KqebWP
 YEaFp4DBMQz+zH0OICbQPVS4X16Rprl8=
X-Gm-Gg: AYBFou2J4JkbhSbKtFWbOM1n+c3wYsfLcRz3aNhoydFBlnTQFANVrGBHkiRxYJyoS3R
 /978d+tBYdCR+gzYfRcDIAlt8a4NcZyllOKgZID13GHDZoEs/sZwPAhbsnPrxmA32HoYJRHwmXS
 G07KMM7fjgAz14+5RpclY1Fk6j7GiUhF6yrtZjTqh/Drh/4Mp6OEIaHVhYZrHq45uJVT6Sg4tVr
 t5XLHk791MFVt3kfzHhFrpLybBjDZjeAdyH6hC1L9JeYecn8XmjjbxtQuibcV5Z/a43jncTP9JR
 syh+RsCsXa3ylQq6zb3fR+QgErqebGnAhpCydo8lC9e86JL7Rdz3bJTPk70Rb3rbhDIwxMxOp8n
 U9AD+KKc=
X-Received: by 2002:a05:690e:4384:b0:671:3b0a:824 with SMTP id
 956f58d0204a3-672d57d6d11mr847519d50.42.1790165227328; Wed, 23 Sep 2026
 05:07:07 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 05:07:04 -0700
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 05:07:04 -0700
From: Aldo Ariel <qwe.aldo@gmail.com>
In-Reply-To: <20260809132514.421679-1-qwe.aldo@gmail.com>
References: <20260809132514.421679-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
Date: Wed, 23 Sep 2026 05:07:04 -0700
X-Gm-Features: AclHuK-58wn5g3d8ztI9Ghj-cBrDeCaoJg0rvfYiYY-rd0knaQKL3ToQHNyiLiU
Message-ID: <CAP48HfvqpeMhxJZwzcjXo9akVvV5WU6nN4xVuNaAvX07q2OBEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: reject SURFACE_DMA commands smaller than body
 + suffix
To: zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000076d850065c255293"
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

--00000000000076d850065c255293
Content-Type: text/plain; charset="UTF-8"

Hi Zack,

Gentle ping on this one -- vmw_cmd_dma() still dereferences the suffix
without checking that header->size is large enough to contain it.
A DRM_AUTH client can reach this from execbuf.

Any feedback?

Thanks,
Aldo

On Sun, Aug 09, 2026 10:25 AM, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:

> vmw_cmd_dma() locates the SVGA3dCmdSurfaceDMASuffix at the end of the
> command and dereferences it:
>
>         suffix = (SVGA3dCmdSurfaceDMASuffix *)((unsigned long) &cmd->body +
>                                                header->size -
> sizeof(*suffix));
>         if (unlikely(suffix->suffixSize != sizeof(*suffix))) {
>
> header->size comes straight from userspace through DRM_IOCTL_VMW_EXECBUF
> (DRM_RENDER_ALLOW) and is only bounded from above: vmw_cmd_check()
> rejects header->size > SVGA_CMD_MAX_DATASIZE and commands that do not fit
> the buffer, and struct vmw_cmd_entry carries no per-command minimum size.
> There is no lower bound. When header->size is smaller than sizeof(*suffix)
> the pointer arithmetic underflows and the read of suffix->suffixSize is an
> out-of-bounds read ahead of the command; when it is smaller than the body
> plus the suffix, the body accesses that follow are out of bounds as well.
>
> Reject the command before computing the suffix pointer when header->size
> cannot hold both the fixed body and the trailing suffix.
>
> Found by a syzkaller instance fuzzing the vmwgfx command stream:
>
>   BUG: KASAN: vmalloc-out-of-bounds in vmw_cmd_dma+0x508/0x5b0
>   Read of size 4 ...
>    vmw_cmd_dma+0x508/0x5b0 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
>    vmw_execbuf_process+0xd06/0x35f0
>    vmw_execbuf_ioctl+0x1cc/0x5a0
>
> Fixes: cbd75e97a525 ("drm/vmwgfx: Make sure user-space can't DMA across
> buffer object boundaries v2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> index 6b921db2dcd2..02eb383f91b5 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -1524,6 +1524,12 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
>         bool dirty;
>
>         cmd = container_of(header, typeof(*cmd), header);
> +
> +       if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix))) {
> +               VMW_DEBUG_USER("Invalid SURFACE_DMA command size.\n");
> +               return -EINVAL;
> +       }
> +
>         suffix = (SVGA3dCmdSurfaceDMASuffix *)((unsigned long) &cmd->body +
>                                                header->size -
> sizeof(*suffix));
>
> --
> 2.43.0
>
>

--00000000000076d850065c255293
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Hi Zack,<br><br>Gentle ping on this one -- vm=
w_cmd_dma() still dereferences the suffix<br>without checking that header-&=
gt;size is large enough to contain it.<br>A DRM_AUTH client can reach this =
from execbuf.<br><br>Any feedback?<br><br>Thanks,<br>Aldo</div></body></htm=
l><br><div class=3D"gmail_extra"><div>On Sun, Aug 09, 2026 10:25 AM, Aldo A=
riel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmail.com">qwe.aldo@gmail.com<=
/a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">vmw_cmd_dma() locates the =
SVGA3dCmdSurfaceDMASuffix at the end of the<br>
command and dereferences it:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 suffix =3D (SVGA3dCmdSurfaceDMASuffix *)((unsig=
ned long) &amp;cmd-&gt;body +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0header-&gt;size - sizeof(*suffix));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(suffix-&gt;suffixSize !=3D sizeof(=
*suffix))) {<br>
<br>
header-&gt;size comes straight from userspace through DRM_IOCTL_VMW_EXECBUF=
<br>
(DRM_RENDER_ALLOW) and is only bounded from above: vmw_cmd_check()<br>
rejects header-&gt;size &gt; SVGA_CMD_MAX_DATASIZE and commands that do not=
 fit<br>
the buffer, and struct vmw_cmd_entry carries no per-command minimum size.<b=
r>
There is no lower bound. When header-&gt;size is smaller than sizeof(*suffi=
x)<br>
the pointer arithmetic underflows and the read of suffix-&gt;suffixSize is =
an<br>
out-of-bounds read ahead of the command; when it is smaller than the body<b=
r>
plus the suffix, the body accesses that follow are out of bounds as well.<b=
r>
<br>
Reject the command before computing the suffix pointer when header-&gt;size=
<br>
cannot hold both the fixed body and the trailing suffix.<br>
<br>
Found by a syzkaller instance fuzzing the vmwgfx command stream:<br>
<br>
=C2=A0 BUG: KASAN: vmalloc-out-of-bounds in vmw_cmd_dma+0x508/0x5b0<br>
=C2=A0 Read of size 4 ...<br>
=C2=A0 =C2=A0vmw_cmd_dma+0x508/0x5b0 drivers/gpu/drm/vmwgfx/vmwgfx_<wbr>exe=
cbuf.c<br>
=C2=A0 =C2=A0vmw_execbuf_process+0xd06/0x3<wbr>5f0<br>
=C2=A0 =C2=A0vmw_execbuf_ioctl+0x1cc/0x5a0<br>
<br>
Fixes: cbd75e97a525 (&quot;drm/vmwgfx: Make sure user-space can&#39;t DMA a=
cross buffer object boundaries v2&quot;)<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable@vger=
.kernel.org</a><br>
Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmail.com=
" target=3D"_blank">qwe.aldo@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/vmwgfx/<wbr>vmwgfx_execbuf.c | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_execbuf.c b/drivers/gpu/drm=
/vmwgfx/vmwgf<wbr>x_execbuf.c<br>
index 6b921db2dcd2..02eb383f91b5 100644<br>
--- a/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_execbuf.c<br>
+++ b/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_execbuf.c<br>
@@ -1524,6 +1524,12 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool dirty;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D container_of(header, typeof(*cmd), head=
er);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(header-&gt;size &lt; sizeof(cmd-&g=
t;body) + sizeof(*suffix))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMW_DEBUG_USER(&quo=
t;Invalid SURFACE_DMA command size.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 suffix =3D (SVGA3dCmdSurfaceDMASuffix *)((unsig=
ned long) &amp;cmd-&gt;body +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0header-&gt;size - sizeof(*suffix));<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--00000000000076d850065c255293--
