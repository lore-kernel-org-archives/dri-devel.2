Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2BEC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074FA10E59C;
	Thu, 17 Sep 2026 20:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Lr/J5YVi";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7EC10E5FC
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789678608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tuPRIeEUeSpx2M/Op+d04joFRM2fDL04NuKxDNyxZ5Q=;
 b=Lr/J5YVi7YQupe+YkVUiDTn4ZI3yrInunQ4xOrO0ZqCnK88vJ91MQSBjnx6xS8wIn9N5G8
 tXfc1ofFucXsgf+zRYyCVJhtFGZ6wrMakWP6pMpkiSJJa2vyRYQhSEos3HfEzsYqvXLlUP
 QOitl9YtFjT5T9DTT5k2go/14QC1FSo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-RmGfnkrDPA2p63dsYVjDlg-1; Thu, 17 Sep 2026 16:56:47 -0400
X-MC-Unique: RmGfnkrDPA2p63dsYVjDlg-1
X-Mimecast-MFC-AGG-ID: RmGfnkrDPA2p63dsYVjDlg_1789678607
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a1bffc2eeso12207785a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 13:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789678607; x=1790283407;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K/Cg05CbpIvavYCVyx9/3zE/8H3+/AOemaPQ8wmlxF8=;
 b=y3MM09C0kwsz1rKHgUketI/HiTva8B6K1Iln+LU0UXwrAD3/rFG7uF4cd0YtnmxIxX
 XugtgmQ2Yaf31/Rmi5+SeDBesdU9d8dxxIXthW+oL9Mbw1nAB4TwjMCJBK1UDAM6IsDO
 dV8jAt3noHD4zq9p2akyZ0hEVuOlroV1lVDkgAkGhIbWuWqKdro0AXxLsoA+EEeBMJUi
 TrLlCw1dB4cs/7em9vYUK+VBMeBr+q9hZcVeY7B1k79WXLNTYFsJONoIKvU5sdxEgay9
 /pAXkqB/2skV0ubsuHdpnAIvUIzZUFAw077J7pDqNgJrz+p/nBHCCK69R6xmUBSx5KGo
 hyiA==
X-Gm-Message-State: AFuF++lTpcTzyufwzGK9s7G0hBofWgIl0h15E1sGmVdVrm7wxfuz3Q1w
 xSz8lhStDpsf1ki7ZIlkSjAN/GAxc9chJnZEljJ/+Bv2/Fx3SkE77Zek0ygLojUCy4yKOOqHdiK
 ShWbqNpXFnxVTT6W4RxMdqa6i0VdRNBLlS7ucMjiJgzA/U8VNIpvUnaaU6SBZn2uvPtg7dw==
X-Gm-Gg: AYBFou3Er8/obr31N5AN9z71gS+SJc/PgCKcdpHY/WNPN+ljjNuR7qkx7vKWvRi/eUJ
 FijrXRTARuizroheq+my9UxmHwQyUTQbczBKA4zliHahka9Jy5xdvsWITymX3kH//ZNJkVc+Wkm
 ZUDFUB+/rTiFCHkUNXOemCN+4Edsbbe4iKItl/VIpPkX6yzmQwsyktfQs+6F+LTXweEpqFe7lLP
 D858hNzwnTCwT/c0X94p8aQGE5K05r0anvrq3NRYd5uf59JJHxCZuU+MonjNbwm2Q2E2zqMzNyp
 qvbv3sEYiIpuhnANWPTvSAsOqiMZahu3vl15fhM0K73vxd+80L1HfvI3NZ2yiqLHk5AyAwHn
X-Received: by 2002:a05:620a:8086:b0:937:7836:1501 with SMTP id
 af79cd13be357-93bdc6a7a23mr29333685a.10.1789678606743; 
 Thu, 17 Sep 2026 13:56:46 -0700 (PDT)
X-Received: by 2002:a05:620a:8086:b0:937:7836:1501 with SMTP id
 af79cd13be357-93bdc6a7a23mr29329085a.10.1789678606225; 
 Thu, 17 Sep 2026 13:56:46 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b781d94c0sm539461985a.10.2026.09.17.13.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:56:44 -0700 (PDT)
Message-ID: <ad023b5df1495ced25aa681d10f57628df41ac13.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] drm/nouveau/clk: fix list cursor use after loop
 in nvkm_clk_ustate_update
From: lyude@redhat.com
To: Francesco Magazzu <postadelmaga@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Karol Herbst <kherbst@redhat.com>
Date: Thu, 17 Sep 2026 16:56:44 -0400
In-Reply-To: <20260712123616.1180830-2-postadelmaga@gmail.com>
References: <20260712123616.1180830-1-postadelmaga@gmail.com>
 <20260712123616.1180830-2-postadelmaga@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xcXXYBZZyEQVS_tZ3g6eNypzFtOeREFX9plBJMXGc-k_1789678607
X-Mimecast-Originator: redhat.com
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

This patch looks fine to me, but but if this was posted by Dan
Carpenter originally would you mind switching the authorship over to
their name?

On Sun, 2026-07-12 at 14:36 +0200, Francesco Magazzu wrote:
> If the requested pstate id is not present in the state list (or the
> list is empty, e.g. broken/missing perf tables), the
> list_for_each_entry
> cursor runs off the end of the list and the subsequent
> pstate->pstate !=3D req check dereferences the list head cast to a
> struct nvkm_pstate, which is an out-of-bounds read.
>=20
> Track whether the entry was actually found instead of inspecting the
> cursor after the loop.
>=20
> Fixes: 7c8565220697 ("drm/nouveau/clk: implement power state and
> engine clock control in core")
> Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
> ---
> Note: essentially the same fix was posted by Dan Carpenter in 2022
> and
> never picked up; the bug is still present in drm-misc-next.=C2=A0 Credit
> for
> spotting it goes to him.
> Link: https://lore.kernel.org/dri-devel/YvSkKAdk8Pe0g2K9@kili/
>=20
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 8 ++++++--
> =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> index 572e63846..42f3709e0 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> @@ -479,13 +479,17 @@ nvkm_clk_ustate_update(struct nvkm_clk *clk,
> int req)
> =C2=A0=09=09return -ENOSYS;
> =C2=A0
> =C2=A0=09if (req !=3D -1 && req !=3D -2) {
> +=09=09bool found =3D false;
> +
> =C2=A0=09=09list_for_each_entry(pstate, &clk->states, head) {
> -=09=09=09if (pstate->pstate =3D=3D req)
> +=09=09=09if (pstate->pstate =3D=3D req) {
> +=09=09=09=09found =3D true;
> =C2=A0=09=09=09=09break;
> +=09=09=09}
> =C2=A0=09=09=09i++;
> =C2=A0=09=09}
> =C2=A0
> -=09=09if (pstate->pstate !=3D req)
> +=09=09if (!found)
> =C2=A0=09=09=09return -EINVAL;
> =C2=A0=09=09req =3D i;
> =C2=A0=09}

