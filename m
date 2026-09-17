Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07579C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2B910E615;
	Thu, 17 Sep 2026 20:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UQYIDZ6i";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7963810E631
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789678282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mG07znBCfGZDJK2bgsmEc49ovAbR3moQOMqXGtLushw=;
 b=UQYIDZ6igFJHrP18aRSm3AprR8e3O46BjA3IbPG74sKgGcsO93ZRtAs911uYJ0ep8uO87P
 UObFlKJIURi3skIvcL8la7XMLf7CoGp012MypGERc41FRLChC3qdHptZyfvew8R8IagEMP
 VGc/IQu9ef2l7oZyI99ZUSI+LNs0CUw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-z2pmt4B-NkiRtAASdwXUDQ-1; Thu, 17 Sep 2026 16:51:21 -0400
X-MC-Unique: z2pmt4B-NkiRtAASdwXUDQ-1
X-Mimecast-MFC-AGG-ID: z2pmt4B-NkiRtAASdwXUDQ_1789678280
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91054f537f9so273796d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 13:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789678280; x=1790283080;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mG07znBCfGZDJK2bgsmEc49ovAbR3moQOMqXGtLushw=;
 b=rAaePTdvVlos1+gs+eDOWrTOqoyquMIZpWJ7LXgvYgVCgtLNMYNS09RXVSy8qmYYkM
 3xyB1SY7DL2kANxHfPK7DOPziN97kxLL8pjm2sPMbIept2rMVuG79Rp6vVspoP5/Eyfd
 E0q/4E9f75pAjIDeiYBWAyCtKHNERrrEJNVRGkQJdQ7qSla2tO9WgdjFAfOIkl5JVlIZ
 FGsJqpf43+UC7QzVQdNK8zp4YQvlFHxlZOmU4vkzxWWUZgLOu2A6bG7jV+gDKHpC2Pe0
 jOni32nRn3zlEuIfxNsMltF8/HFIf3pzHTNr+Qr1dc7VmyTk9l7PJEDyoUO5YNjXRS7H
 FOIg==
X-Gm-Message-State: AFuF++lCzgzdsJODZjrJ54lebnjIX0ORLrO+7KrZ5XPdBj81oFiHkZjv
 k2g73uItwEi+RLd2Be7jXz5bMMuPqRotiPqrbQ04HGmfhTpwvO3wnmQZ3cDP8OHbUpIwfeclsUQ
 PzxEnNpI0I8v1MDPbqqGOMsnM0szXPwukOAScqUXNz0+qVVBeFrIUgPFKZV9vQGggEeSPcQ==
X-Gm-Gg: AYBFou2ZnozCa636KadvAU24wBTrkhpLdiBDz1R8NzQqAP6CIvEg0fBQve5tpJoXGro
 JpRxAPJKYNEOobL8wtO+aLD3F0/Nf6Pdp2QkeQRXItqJ6a0RcXE085x1xp1FqelCvHUT0yhH7Sq
 y2lt8UFNwIH9tBR6sURRoNAcaupMG0ae8KZFMcME9sIwcIiVVi810/vAwlbbGyJMHkz/So6hLfv
 oCfatskarlju0vOaLf5VEf/2Qdim8+KY+nNcIwbYihMv0qgfIFXtxBL1e0mmPbC84cAQZPp1wz5
 1uzrt5YleW/s3JQd+XQneX+nyLuIHLQjmfHdfrEaOpP42JsPWdFtBB9xMwzk69fAFrkJq+B/
X-Received: by 2002:ad4:576d:0:b0:912:35b7:8a9a with SMTP id
 6a1803df08f44-912483188bamr72768486d6.20.1789678280325; 
 Thu, 17 Sep 2026 13:51:20 -0700 (PDT)
X-Received: by 2002:ad4:576d:0:b0:912:35b7:8a9a with SMTP id
 6a1803df08f44-912483188bamr72768046d6.20.1789678279742; 
 Thu, 17 Sep 2026 13:51:19 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252c9377esm6673096d6.24.2026.09.17.13.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:51:19 -0700 (PDT)
Message-ID: <27293a63217c3261c42d011cef8cf31e3d43fefd.camel@redhat.com>
Subject: Re: [PATCH 0/2] drm/nouveau/clk: fix RAM error handling and pstate
 desync in nvkm_pstate_prog
From: lyude@redhat.com
To: Francesco Magazzu <postadelmaga@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>
Date: Thu, 17 Sep 2026 16:51:18 -0400
In-Reply-To: <20260727152821.128432-1-postadelmaga@gmail.com>
References: <20260727152821.128432-1-postadelmaga@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hhEOGvk_4ZEFvi8AsDFM9wZz4MvMsjmCVt_LxQuMx3w_1789678280
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

For the whole series:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-fixes in just a moment

On Mon, 2026-07-27 at 17:28 +0200, Francesco Magazzu wrote:
> Follow-up to "[PATCH v2 0/4] drm/nouveau: fix list cursor use after
> loop
> in the clk pstate paths"
> (20260712123616.1180830-1-postadelmaga@gmail.com).
> Sashiko AI review flagged three pre-existing issues while reviewing
> patch
> 2/4 of that series; the third (clk->func->prog()'s error being
> clobbered
> by nvkm_volt_set_id() in nvkm_cstate_prog()) is already fixed by
> patch 4/4
> of that series. These two patches address the other two:
>=20
> =C2=A0 1. nvkm_pstate_prog() drops the RAM reclock error and falls throug=
h
> to
> =C2=A0=C2=A0=C2=A0=C2=A0 core clock programming anyway.
> =C2=A0 2. nvkm_pstate_prog() commits clk->pstate to the new state before
> the
> =C2=A0=C2=A0=C2=A0=C2=A0 hardware transition has actually succeeded.
>=20
> Francesco Magazzu (2):
> =C2=A0 drm/nouveau/clk: don't ignore RAM clock programming errors in
> =C2=A0=C2=A0=C2=A0 nvkm_pstate_prog
> =C2=A0 drm/nouveau/clk: only update clk->pstate after hardware programmin=
g
> =C2=A0=C2=A0=C2=A0 succeeds
>=20
> =C2=A0nvkm/subdev/clk/base.c | 9 +++++++--
> =C2=A01 file changed, 7 insertions(+), 2 deletions(-)

