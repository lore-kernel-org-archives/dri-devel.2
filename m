Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD931606A31B
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UA9O9L8F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0770F10E3E4;
	Sat, 24 Oct 2026 20:53:52 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1025910E3E4
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 20:53:46 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8a83d2706fdso15887007b3.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 13:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792875225; cv=none;
 d=google.com; s=arc-20260327;
 b=s+7aq9BLIW5TYv81h6J8dHuu82szLd9ENalvkNKE+aPwDfhQiQmT025h5MLGXP2KfN
 yZrXCrupsWYNwmWon7AbGxdNv1Rdw2nAgPSS10soTWga3oMeh2azBXAGwTsMQABcBK99
 OHKPvTNotgzpnCiGuoDwpvrdn0GHVTR3l8XnSoodJmaql95B79mFJBCWR4sbm3E3omMX
 blfo3ioPNEkflkjH6dhAnWG2pvQaDepgMP1AUPCDyzMauLlCEoaaZRMTseZGeVu7MDhj
 LWs68NJPJUmdvZI1W9KCXxpwQxDkekkqDdVMTEgieZIWDrjvauGwkuPJameER8Gmvfwn
 T3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Oi8O8tkWw2ut1vBmd8UOaGvUegnlQU34e0DlwvRl+PE=;
 fh=meLaPdUC+42xozn++xWQskq45s2yDajAnCnDFa7aJm8=;
 b=jOJsxWUkdeLOTw4mZg8zVsWGtaTElt5/ynnYW6t19d+B8iTGSx3i8Z7+85wpOtY8sC
 kd2yVYrA5rWHzso+aTQAdu3Z7h007dbPQucndH24sEnP39VczVtbSicxvMuIcH/G1Kq9
 GZUl1cdruxh3i88ilfcgXGsqq8WAFJly9tiziBqTJb8dxlzLnVHJlxzxe3XFJtpiJAXL
 cQjyc380VDKOzJt44c9JUKnaW+4jxqciiBV3V/LRheuEN+pGXkl1y///K24wzkeJUKcP
 ICV0CUsfNX8ym7jZfXsJjZJq0lyEm9woKHJUQFQyXYeVOnYkfhEpnoHDUyoBTwknGTlq
 pANg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792875225; x=1793480025; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Oi8O8tkWw2ut1vBmd8UOaGvUegnlQU34e0DlwvRl+PE=;
 b=UA9O9L8FWkMBs9sJp7D9AXVawcUwVosq2xyxevUB/9EllnOTeJWUXsJCzYzx9DVNco
 HMGW3ieQDNq/W+WxHFZ2fc+Rt1OojTKY970fHxjPxQT64DGWQKo698jqq5P2joSJNqJQ
 k9h4W7DQfkqwrukrAbZvfp6eYsMxkLEwOlH8SdvWpccBKBUgUBjQ/WJL6nKQCL8X22T3
 MZ/ULNOPP1439a7fVdNWuvp4H2YucIctZo7HBHBigNObRYQt+UnsE3imfSixvNmigY7I
 o6391EcDSOSvtsSoVsKCxjachRZwKFFTwAzO2l5jHu6cnTkWlktZ2MhdYM0w9oL1W1n5
 gL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792875225; x=1793480025;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Oi8O8tkWw2ut1vBmd8UOaGvUegnlQU34e0DlwvRl+PE=;
 b=VDQ/vpo8KdVkR2gFCDehgV0GovJeFEW33JeF0XDwq+7BqptbVFuIvoqjY2idI0J4Yp
 VmQaS4AHoWW8JoyLwFlyg0wgNuCTnDg6dxB9NIgtUk3gu+IJoj2ou/vXkbzvzXKnV8lZ
 Igl2X2idDMJZLFZxU9DxfXnmhkj3R0Elbx1oq909n8GHJ3VrGjjPiYvJVUCbWEVY8xg9
 0E7QGiQelm0a/tlrQh9F2d4DhsR/6/Sfzbad9iAhE869ctFElcNeMuVfOByPN1Akh0qg
 DST0wy2A/qE6ZntxoM26u6lRVmIuHoGptqo4CmmESA4Bt5phqBAo74L4haRHQ9qWN99+
 d5EA==
X-Gm-Message-State: AFq9FYKZs625ZJAj74mmuNGLMhUACWpe69ONo1uY1h8P+/J8gDWn7AFr
 X3UNZTH+xYcAlTXD1dEVBhHRwmg58GPBgwYfLDAObtgsxTqTJau3Ayp/CmH7vvWg37AbpPbD9Hd
 A//b/lOW5flDYNqAEILThbR1ITTceQhljZ4Vv59sBlGmX
X-Gm-Gg: AYBFou3pt753tW8HSytaI1rkOqss72zp6PTP6jV494nxMVSYuCXmhWB6kR1Ir2xoVje
 cE7D4ptp3ZnxCy+2NzJqInU09VzGbpWeJuwIi3CJQGejYeFq6biIrnShpDEtPXyBzH1k1bZ9ZFM
 f4nVQi+WZtMtAlfQje9S7rgzoLaqwZ8pPOc0n796Bj2GrBZL1h+43kWBa3IhVLHS42op/9wCaoJ
 OCabTCI/EHXFPpvx3tz5Rc5ULV5ODsUWzQ45RZZz1sFwDBrNBcYuXhwjutTyHRYDZSl7BzX6Shk
 W4cbs++KQXOCRDwr1RJvflBtOy1uX2TUP3pXevQwLiz5vtlBeYKSEAgBlcJHe/Wa4EeqfA4XcUK
 21OFj5QVSFL6CynIYWHlAwi1X2A6av5PWcAECVvw+q5Fb8XNIOnLH+xRh
X-Received: by 2002:a05:690c:112:b0:8b0:9f48:7527 with SMTP id
 00721157ae682-8b166cb98b1mr16287427b3.98.1792875225025; Sat, 24 Oct 2026
 13:53:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260923145018.1244740-1-qwe.aldo@gmail.com>
 <20260923152941.1297199-1-qwe.aldo@gmail.com>
In-Reply-To: <20260923152941.1297199-1-qwe.aldo@gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sat, 24 Oct 2026 17:53:33 -0300
X-Gm-Features: AclHuK9fSFfGCGVdfIjP3m2s4891s96SvVXKrHjclbvbw4S0svwyd3Plf9zeWD8
Message-ID: <CAP48HfvUkj30vaTRa9sFaR-fMP2_G=zapr8HhkCvRsSLwbj0CQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/qxl: use correct offset when stamping drawable
 mm_time
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000ea1278065e9c4a35"
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
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000ea1278065e9c4a35
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi guys,

Following up on this v2. Some list copies of my previous follow-up
were rejected because they contained HTML, so I'm following up in
plain text.

Would any additional testing or changes help with the review?
I'm happy to address any remaining concerns.

Thanks,
Aldo



On Wed, 23 Sep 2026 12:29:37 -0300, Aldo Ariel Panzardo <qwe.aldo@gmail.com=
>
wrote:
> qxl_process_single_command() maps the page containing the current
> release slot and copies the userspace command into it at the
> release_offset within the page:
>
>     fb_cmd =3D qxl_bo_kmap_atomic_page(qdev, cmd_bo,
>                 (release->release_offset & PAGE_MASK));
>     copy_from_user(..., fb_cmd + sizeof(union qxl_release_info) +
>                    (release->release_offset & ~PAGE_MASK), ...);
>
> However, the subsequent mm_time stamp casts the page-start pointer
> directly:
>
>     struct qxl_drawable *draw =3D fb_cmd;
>
> This writes mm_time at the page start rather than into the drawable
> that was just copied. The drawable begins at the page-relative
> release_offset (struct qxl_drawable embeds the release_info header
> as its first member, so no additional sizeof skip is needed for the
> struct pointer).
>
> Apply the page-relative offset so mm_time lands in the right place.
>
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> v2: drop the sizeof(union qxl_release_info) term =E2=80=94 qxl_drawable
>     embeds release_info as its first member, so the struct pointer
>     only needs the page-relative offset (found by Sashiko AI review).
>
>  drivers/gpu/drm/qxl/qxl_ioctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c
b/drivers/gpu/drm/qxl/qxl_ioctl.c
> index 591b026..65e9bfd 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -188,7 +188,8 @@ static int qxl_process_single_command(struct
qxl_device *qdev,
>                u64_to_user_ptr(cmd->command), cmd->command_size);
>
>       {
> -             struct qxl_drawable *draw =3D fb_cmd;
> +             struct qxl_drawable *draw =3D (void *)fb_cmd +
> +                     (release->release_offset & ~PAGE_MASK);
>
>               draw->mm_time =3D qdev->rom->mm_clock;
>       }
> --
> 2.43.0

--000000000000ea1278065e9c4a35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi guys,<br>
<br>
Following up on this v2. Some list copies of my previous follow-up<br>
were rejected because they contained HTML, so I&#39;m following up in<br>
plain text.<br>
<br>
Would any additional testing or changes help with the review?<br>
I&#39;m happy to address any remaining concerns.<br>
<br>
Thanks,<br>
Aldo</div><br>
<br>
<br>
On Wed, 23 Sep 2026 12:29:37 -0300, Aldo Ariel Panzardo &lt;<a href=3D"mail=
to:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.=
com</a>&gt; wrote:<br>
&gt; qxl_process_single_command() maps the page containing the current<br>
&gt; release slot and copies the userspace command into it at the<br>
&gt; release_offset within the page:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0fb_cmd =3D qxl_bo_kmap_atomic_page(qdev, cmd_bo,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(release-=
&gt;release_offset &amp; PAGE_MASK));<br>
&gt;=C2=A0 =C2=A0 =C2=A0copy_from_user(..., fb_cmd + sizeof(union qxl_relea=
se_info) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
release-&gt;release_offset &amp; ~PAGE_MASK), ...);<br>
&gt; <br>
&gt; However, the subsequent mm_time stamp casts the page-start pointer<br>
&gt; directly:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0struct qxl_drawable *draw =3D fb_cmd;<br>
&gt; <br>
&gt; This writes mm_time at the page start rather than into the drawable<br=
>
&gt; that was just copied. The drawable begins at the page-relative<br>
&gt; release_offset (struct qxl_drawable embeds the release_info header<br>
&gt; as its first member, so no additional sizeof skip is needed for the<br=
>
&gt; struct pointer).<br>
&gt; <br>
&gt; Apply the page-relative offset so mm_time lands in the right place.<br=
>
&gt; <br>
&gt; Fixes: f64122c1f6ad (&quot;drm: add new QXL driver. (v1.4)&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" rel=3D=
"noreferrer">stable@vger.kernel.org</a><br>
&gt; Reported-by: Sashiko &lt;<a href=3D"mailto:sashiko-bot@kernel.org" tar=
get=3D"_blank" rel=3D"noreferrer">sashiko-bot@kernel.org</a>&gt;<br>
&gt; Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; v2: drop the sizeof(union qxl_release_info) term =E2=80=94 qxl_drawabl=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0embeds release_info as its first member, so the str=
uct pointer<br>
&gt;=C2=A0 =C2=A0 =C2=A0only needs the page-relative offset (found by Sashi=
ko AI review).<br>
&gt; <br>
&gt;=C2=A0 drivers/gpu/drm/qxl/qxl_ioctl.c | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl=
_ioctl.c<br>
&gt; index 591b026..65e9bfd 100644<br>
&gt; --- a/drivers/gpu/drm/qxl/qxl_ioctl.c<br>
&gt; +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c<br>
&gt; @@ -188,7 +188,8 @@ static int qxl_process_single_command(struct qxl_d=
evice *qdev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64_to_user_ptr=
(cmd-&gt;command), cmd-&gt;command_size);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct qxl_drawable *=
draw =3D fb_cmd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct qxl_drawable *=
draw =3D (void *)fb_cmd +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(release-&gt;release_offset &amp; ~PAGE_MASK);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0draw-&gt;mm_time=
 =3D qdev-&gt;rom-&gt;mm_clock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -- <br>
&gt; 2.43.0

--000000000000ea1278065e9c4a35--
