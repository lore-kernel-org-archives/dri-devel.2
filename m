Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827A3105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC10F10EC38;
	Fri, 13 Mar 2026 14:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cw2W3XLQ";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EBD710E153
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:04:51 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-128eb45835cso54603c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773410690; cv=none;
 d=google.com; s=arc-20240605;
 b=PYiXvi/R1a4psLs4pomdXj4z6hoCtcDEo73PLZby2kkm1uggs2fWnftUgHlcemaeP1
 jtncFV+4ZzfPvdbwBdinsx2xJuEPwMkciLI4vcgvCAUFVjBNmTtNBRaPVZDinQAs25wZ
 PFPQ55SfqE8wvlMxnPYPZJ30NtEpQYKisEFBSDpWtp8vSZl6EIRkj9aAyaqhuYB+Fhmt
 GmoYzbZzmDPI9vud9wPgQ4CcaDEma1Ps4nSft5r4uBVtoRrNIyJxJYDXJbFHxsy7tPvc
 CF4TxEu/obbn8Aluig7BWzA+14IjkMWGAt07QAXloNLlh5bBahDk2ZI5TTqHO7mgK5I+
 Bx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5E88w3jX+YSLLylZTFGH+to3tZ27lkENQ9LYovk5WCw=;
 fh=4qhlJdTwEnbLCOBWhg/URjj8CfjNQ3GXwOKg3jbnbZI=;
 b=Ic7M3u7jt9jFmulx5GfdgdUh3AowPBGmDZueh3waVV1ryf3x06/c/TfCcxjNDONwmb
 SQitkLWEht4F0c3WgpPe2UVrkxeVywuUxcjlk2ZgMLYjD57c1v42cXNOXeYfu9dwzQp8
 w2pKP21IAoCGclNy1+dO2ibbAbm+g89HbieiEuKoHLErOUIGuevplYWiADd9ehOwNQqg
 yhYYtndFUZpdUBoDKVsOj9VxCeIboTMUl/STGZ0kXAeYiY9fgTO0VLku1XSfZ0WjJf0k
 NiyRWwSxTV/Cqn222v3nkgQuxO4RptdqFnAlmmDBKjZvPjvT7QWjq36lrLOROlcCLJY6
 h4xw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773410690; x=1774015490; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5E88w3jX+YSLLylZTFGH+to3tZ27lkENQ9LYovk5WCw=;
 b=cw2W3XLQocKGWFmvdO3nn2yKb+60GiM6NiskuCbCYqm1HJb1yR7f4BeiJwU714iwHW
 ex/82wipCBzJI85H9tZm9q8JJynHw1i3J/mgXksX6jn04I5b4WDYoFgDPmGkpvRVkoD/
 JD1BT6iU3mzJ7DHQtyydC/3lXM6eKSpnV0vFs2wrf+7lZTQxoQope/13tiJBIF5iUvwv
 fvWAheonQdvcWzPSMgd370fG4IO9SR0r/zy6K68YrN/I7u2vi6XJsyBCsbuXlwSRamG7
 biRDbsHfxeDBwcHnIWI3A17Pm0/j9Xq1DQ/4riJNt+HH6Es07VbZX/JLMtiFFDkQiOB5
 jk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773410690; x=1774015490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5E88w3jX+YSLLylZTFGH+to3tZ27lkENQ9LYovk5WCw=;
 b=Mi3f7QAlHlQpfxB7d3jCY9/PwafWhx5fDjHntiX36BUkWDDfd6Xgqj7qD1CH+KLiol
 3diPppb608S6Us+6sL7TY1yuCD+Tb6eAIvKGf9fEdkqkUTWl+4ME9P+Wjjstjtfnp/yT
 NGqqyS5VMYmjGnn3KVJ+0FY6aWcMPt4FrPOdOLdr6ZXG83pgTG4zMHkee26pkiRKGNyl
 Nt8G5/WGKYlXAjtepEbXaDVCPObp4ZJzUSKFB4e5kZKihI11Aj77bnDq/bJA1U7C/GSy
 +cy+Qr0A0oIAFOR1BAwM3s5zAf6LrJv0Kv/rQU0G15Bts9a10xs+Ur3YIcPYHEclXMLc
 ubxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+KJjN/v+k+BtAGYhdez1oYqIoJPTi059W89mNxH+WWbb+/8b74Rrz2ToWRXooVbsZwGJENRJHtek=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtSJRXOJgewKP3uKnPQMWajUWsep80Hyp8hGPxy/DNkeeWSvQ4
 UrI+IWjbhtixp/CNjbn4aYIi278nsw0n9WdJ/ta8x+SMneUCqgfOAStHPBZoHDqBS7C0CXDkq0t
 c/UBEyNRkbAYup+8pOJalE+meJeYSHUI=
X-Gm-Gg: ATEYQzyUax4bC31fU/b3jaWUWamWJBf2hWrLXwQvJh1zA3+kRJgv/BMT8+lO+M2i6tI
 y3oR0fw8yHWmWI9fo48bcsKVRAmPKzx/u1xAtHM4xUGxrAE7O1yVQQyx/BoXogvGO+w+ArfLlEA
 1slKjUkLHu5o92fgR9J3I3B1AzrQnTOTZjznRG4qjUUBye+4i3ouxrHHYOCDPR1OSfjbKnCinTX
 RHXJ3JL6f69Vgsq6HY6drM91YZhVHdRbdKfWnsW8twx8dUJ1fm9JQZtObQqCqW6aC0v3b7iErRz
 9l36qWHfqLGDzbtGnduierxwIODPnfAb+iLFAIH8rpPPgL+5n+B+pmAL7SWsvcuy952l7A==
X-Received: by 2002:a05:7022:418a:b0:123:2d38:929b with SMTP id
 a92af1059eb24-128f3e33d01mr793389c88.6.1773410690364; Fri, 13 Mar 2026
 07:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260313015226.39727-1-davidbaum461@gmail.com>
In-Reply-To: <20260313015226.39727-1-davidbaum461@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Mar 2026 10:04:38 -0400
X-Gm-Features: AaiRm50d_WEY5sRN59yLf89uD38vQ-LQP7kESvNrj1X-FqVXwJ8QeTLcGXASPgE
Message-ID: <CADnq5_O=Ycrhk1uXO2EfPimZ8EP=nVX4sJ4BUkaB8e0Hwp3_eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: switch XGMI sysfs show helpers to
 sysfs_emit_at()
To: David Baum <davidbaum461@gmail.com>
Cc: alex.deucher@amd.com, christian.koenig@amd.com, lijo.lazar@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

Alex

On Fri, Mar 13, 2026 at 4:55=E2=80=AFAM David Baum <davidbaum461@gmail.com>=
 wrote:
>
> The XGMI sysfs show helpers amdgpu_xgmi_show_num_hops() and
> amdgpu_xgmi_show_num_links() currently populate the output buffer with
> sprintf() and then call sysfs_emit(buf, "%s\n", buf) to append the final
> newline.
>
> Convert both helpers to use sysfs_emit_at() while tracking the current
> offset. This keeps buffer construction in the sysfs helpers, avoids
> feeding the output buffer back into the final formatted write, and
> matches the style already used by
> amdgpu_xgmi_show_connected_port_num().
>
> Signed-off-by: David Baum <davidbaum461@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index 11e56df1d91b..13fc7247fe23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -469,12 +469,12 @@ static ssize_t amdgpu_xgmi_show_num_hops(struct dev=
ice *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         struct psp_xgmi_topology_info *top =3D &adev->psp.xgmi_context.to=
p_info;
> -       int i;
> +       int i, offset =3D 0;
>
>         for (i =3D 0; i < top->num_nodes; i++)
> -               sprintf(buf + 3 * i, "%02x ", top->nodes[i].num_hops);
> +               offset +=3D sysfs_emit_at(buf, offset, "%02x ", top->node=
s[i].num_hops);
>
> -       return sysfs_emit(buf, "%s\n", buf);
> +       return offset + sysfs_emit_at(buf, offset, "\n");
>  }
>
>  static ssize_t amdgpu_xgmi_show_num_links(struct device *dev,
> @@ -484,12 +484,12 @@ static ssize_t amdgpu_xgmi_show_num_links(struct de=
vice *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         struct psp_xgmi_topology_info *top =3D &adev->psp.xgmi_context.to=
p_info;
> -       int i;
> +       int i, offset =3D 0;
>
>         for (i =3D 0; i < top->num_nodes; i++)
> -               sprintf(buf + 3 * i, "%02x ", top->nodes[i].num_links);
> +               offset +=3D sysfs_emit_at(buf, offset, "%02x ", top->node=
s[i].num_links);
>
> -       return sysfs_emit(buf, "%s\n", buf);
> +       return offset + sysfs_emit_at(buf, offset, "\n");
>  }
>
>  static ssize_t amdgpu_xgmi_show_connected_port_num(struct device *dev,
> --
> 2.50.1 (Apple Git-155)
>
