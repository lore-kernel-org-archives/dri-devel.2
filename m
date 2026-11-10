Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F29606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MkV4TRck
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE78210E0DA;
	Tue, 10 Nov 2026 12:22:34 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF2F10E0DA
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:22:27 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so297862f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:22:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794313346; cv=none;
 d=google.com; s=arc-20260327;
 b=JeNtrZpxHg5DXA0rAIpGjIo+YrtmnmJhahp3SP+ZRq7Cr7qV8FdUGl29dj8bJ7SBvB
 CrMrKzYWuNMlJu4nmIhULeWMqEU9fl1HSCOPAJcYwyvoD33naG1apQXY/V53yDYlUrEe
 4eARubAoQuETNSpML+1oE/btmFHwQvEjiWxNj/cI1cvuXl9+RnwuIx8miRkdK5wWXFhy
 mqdh9SkPNpZIBkRWqSy3cK4zqgamJHbh/5ADkuq75sAPKMuyezjasMckY/jXJT4YlB7e
 UVYMhYqVTlIssnzihgujQi2jK8TP4IHnW4uODm1pXAVoi1q1XusRXlPeVmggb3rzR0ry
 +TKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/+MHJzkrQTBa0PMMy0ZmVpPU2O2nIABhjZj+wACly9s=;
 fh=lxDfkl/mmDs0gL8m6ldWbSGlTmVE26+tE1+BY5K1Drc=;
 b=BDRdniyClH1ijOjEttYTxpBJJNe6sORn46BXwNAA+kN494yfjXj5bL+HdeFmKpBHjH
 +MZvF6lgB0ZZtk4620imFPLJ0CMMLMTe7zOTffpnFm27uhDTOvb1ddCgDab9L/yIVSkB
 +PPzvjUZbNYDxja4+uBEjghR3MGVkS7ZE0PHPJwBU7TfVlpDWq/u87zB9mHk8+Tehtcu
 BpqAG9mPAcpsJPAb5k044zfANJRNejztLXy1GPC9ZFdiYwOCPnS4WeBl8BLRcaNgADl/
 McRiewNuVp9+hi2WhD4K94FJaFynjy1FE1HSgPK26WrucuYK2W+NoJSUEzDRw7WVFDei
 KW/Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794313346; x=1794918146; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/+MHJzkrQTBa0PMMy0ZmVpPU2O2nIABhjZj+wACly9s=;
 b=MkV4TRck1hmrQ75BLx9BL2IPK7QDEhJBJdwpDmonp1viTZuATAvFwzffo7nDZ5qzJM
 Ad7mG7pCeHBRWcVY5zgd5Xr6T/5fnNQ5rlxG1Ii6gjrG+JRwukvyobf6f5YoDsOft9vc
 GpCYFp6zfCeWyIX+xFdkF6KWJaT9TSxuK2k7T1hNLV7Jr8yGgld2q7Z6YF5P0/JbbNpn
 eUAsvJlvPbLqqsliY7fjOwDiu/Oe5qC80Mw5Mxdfy2MRWYV9yKlgOBw6Js6SuoSqzUNw
 7gnpSidsn/y3iFO7L71NjL6ZcTwh+1yj/xHh/6KB/dWdmrJ5oEhp2xtLE9W4yUurNunK
 wRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313346; x=1794918146;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/+MHJzkrQTBa0PMMy0ZmVpPU2O2nIABhjZj+wACly9s=;
 b=OwB+0v1W5t5Ww38CuSG6T9GiD30zrvZs1iwtb1B2mGc3u5HxLVbu9JeHkwNaU56z9v
 OqfanGKagNP7B04D93tlthdnflAEdWlgQXS/TvDBrrWBXsRlMsJpTOLJ0fMXxDA9G3uJ
 iHFRJ50lBLdZT5tHn5qsmcjxRZRa/4UENniN3wYe9vI0bkGcueUlrykXDlS8qplxMdW8
 OIw/RyAjUIH88MtCojj/61YAqRxFmvSvVGcHzPynL2BEeUGMwRaECmdXT5suBYxzISGS
 D3M9pa2KBDrOL1QxWsarSYszecgf8wrEsSygOkgoYpIzJxpQFbk93yn8vHd+4Xssr7rq
 ZYSQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEfyJFTIVMOt3erwsMG+WRy5m13GVYCc0RT8TpeG76cGKtzLk0jdnfaVzcmBPZ2lNYCkaSqt6yJWzw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9+aNxLOB7+dXKfn+fF/gxbfmauM9C2nqJNkJJfQtUC6/dTlUHN
 xS6x4/Xj6JokS4a+Cts5PtpO6y0iftZjCCm2IDxcVTb9DJWQZJpR6nuvRqP0W3+wQGf1cZfoUtu
 PjEyIAn6JvQEbTXDShC7ohHA7aW32WxE=
X-Gm-Gg: AYBFou128ZZR/5X4+y/oBfKuxN/9+JPDquIQSYmABdB4UEOFpggKMUCamyKke9vxH16
 Cl9m4WhR9LgK2hzQHWYz/LV51CMRSWb/7JI2XvRqiqeqo+cY5u9lmm0EHVUbf8mDVGkLmTjY0jd
 SE+mAg/Hu0TkGRiimxrZ/TBxg3IOy7VVE2YQZNkYMlOjYYkYH1oIbvA4s9UNcGISvEa4QIXHpoC
 6QcSBYz6+z0Xbjt5xYAaxy8U/sYOCneIxNUZv/8pIXeqWCXANHV6hFAZoZ0moC6eJRhvZxGXaTU
 eGF5EakswWVL3DtgeGCWvIFhEHp0PqBmT5W2Cm89gaDSsNQtp4/S5ab5C+HymXE5MD8hVKHy2GH
 lR63UfUwdEkBAlke15Ft7BJmyra7Ekvo/bEWHyNNfcBc/nWtWkkowrtHeAFihi7JFAjgHVH2nY+
 jaGL6vsXKYuNgxSEdWLtKaxbTxrUMiqbArfv2TzgG7D3r2KlnA/U3jDxMOnA==
X-Received: by 2002:a05:6000:4555:b0:485:8cc8:1f5f with SMTP id
 ffacd0b85a97d-498309ae1c2mr3208558f8f.42.1794313345655; Tue, 10 Nov 2026
 04:22:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110114622.229608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY3PR01MB1134683B4AB5DC97B70F76FB586722@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134683B4AB5DC97B70F76FB586722@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 10 Nov 2026 12:21:59 +0000
X-Gm-Features: AclHuK9UoXtdtc2HXij8q8Oj65-CKlwzKWMQawTDZRBatrdmul0O7w180edoOrI
Message-ID: <CA+V-a8sZovqjaDTDFUrw7WJ8kqP4sjk1p0erV5A6tDL3qZNr5A@mail.gmail.com>
Subject: Re: [PATCH] drm: renesas: rz-du: mipi-dsi: Drop duplicate
 platform_set_drvdata() call
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Biju,

On Tue, Nov 10, 2026 at 11:59=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.c=
om> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch.
>
> > -----Original Message-----
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: 10 November 2026 11:46
> > Subject: [PATCH] drm: renesas: rz-du: mipi-dsi: Drop duplicate platform=
_set_drvdata() call
> >
> > From: John Madieu <john.madieu.xa@bp.renesas.com>
> >
> > The platform driver data is already set earlier in rzg2l_mipi_dsi_probe=
(). The subsequent
> > platform_set_drvdata() call uses the same arguments and is therefore re=
dundant.
> >
> > Remove the duplicate call.
>
> Some thread related to the patch [1]. Can you please drop the first one a=
nd keep the second
> one?
>
Ah, I missed this thread, I will update it and send a v4.

Cheers,
Prabhakar

> [1] https://lore.kernel.org/all/TY6PR01MB173770FD0BA340F5A50633E21FF322@T=
Y6PR01MB17377.jpnprd01.prod.outlook.com/
>
