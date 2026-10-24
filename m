Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC2606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=huVrj1A/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A691310E3BB;
	Sat, 24 Oct 2026 20:52:08 +0000 (UTC)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D88010E3BB
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 20:52:02 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-6798c43a3d6so1370149d50.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 13:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792875121; cv=none;
 d=google.com; s=arc-20260327;
 b=qcT5B7ljf5lSY6Is8GQ3x7DH+/gyE/NG80l93FwfNAJHHcebpVuJQ/TmngMXhLjPxR
 Iz+KXWXmSw2cS+gFZ0J85VrPHkkojgBbvNNSQb2J0Kwg2AhDpOq4Dbld17MbAlm1jmew
 lzhLtpirVd7kFXlcExXIouo5NbVSiDSNAswQpYHuMx5UqyZh6OZtmQWAkux8AUjjicFI
 XfyHxLOqLz5pzC/dskL/GgBPo3naRIdgBL2hYF+/jY369n4oj0XyoltFhGnkJ4pUqosJ
 NcPrW0UxH69waVZg89cX74CPODOmq5SmMxZe0+C85NSY17xjti7puGIuDniLGpvFGpS9
 8aVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=owbfdbiMM0xyLLhMlMPvuq7smr4Uk22317itPBtwSl8=;
 fh=hv5RcvhCRwFVWgIax+Zn5u05ZOB9jUlVpaIqjeDQyAA=;
 b=rWmnbAjlIiX/kTk5hkY8PXcugS02rmz3L165aVA2Or/+B/CkI0NfmaRIIMuiZHwpB6
 t1bkbPhT7Y3RI878NUI+ggERwtYuIu7vGIn4aYG/zS89VH8SMZZXT89oyVT+LRAAOGS5
 WOSU3eX0bk5xhYrHU6d0jAwM2kbafSAzynuC6PUJha7DI2i82TKmTcGPjKiphJWizQHh
 aROmokcfQ4VAHwUFSZickpPLiXSEoannDycH0Tr4FmRGcn2ivBfQYx8S4G9TXuncpJAH
 TQYE/SHcvWGMGdQkuPW7PK/3x4eHcV0lteAVSsIAVMJPxLDqC9S6ElmjYD6q9NDEnpPb
 DfbQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792875121; x=1793479921; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=owbfdbiMM0xyLLhMlMPvuq7smr4Uk22317itPBtwSl8=;
 b=huVrj1A/8gwPxJtiHHbawlnuen/kzIyKy82T3z8aw+lmdRRwgZG3zeFsw8PB8HAlmJ
 DN37w/pDmcxfwY/gZ5H7vDeGnxcuimkdcOU5Dxz/ca9D128Rzo8iw0uP9WZm3cIwoAiI
 ip1jBSRsaOln/dUCeTj996g8jfl9jCDvmlXLE79E1aq7gi4zh/rsg0gBEZ30sAmndh70
 bh3fbMIFyIX7SlkLaRrRGObQsgTzCRoJJ34xC5EDU/KYGdtEqXpjhWmoEhrpeofFsP27
 j2HhwTHM37mT7dKwU2Qj7fChCTRnoSP+BA+ZsjBWU/B+R9GFA2QLGAhkg5/PeUiWKYPu
 y4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792875121; x=1793479921;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=owbfdbiMM0xyLLhMlMPvuq7smr4Uk22317itPBtwSl8=;
 b=iMq8r6k1YpQjoY9HE6SxvZ0JwVMUyL/fIN3Fj1GqZKvEAanPyFtpe4ooNjNq62IYZA
 6GA1x0JKGPcKKv4dFfi+Ef5HT96rxrvMihdjhqLpbYLHWaJcdBfYLEbnjBzIxuuOyfv5
 V9p4dGJNOQujCaT+uzfoeT0p+9/+bbubQW07lz6T/tL+Jm61AVsSyCLjOa/55kG5gWQ/
 zSI208sxLnYvQ/IWFvhZZJOvvqp9st/61EDaAEi4h1IeeYwLRj7sTHq96qnssLg8PQWr
 UmfZTMX/tBmu/1MbWEg8b2F+pomH5UR4CtMUx+Qblsfb7dupmwsJmDuhtWFvTm2FA9Zk
 HGHA==
X-Gm-Message-State: AFq9FYKpKVxcnbSPeKPY+GjLAUFiEKXhMUdRmsfE3O4Bqi3GaQcHnLat
 39rk1J0/s2tvBx8ffeBMx4Jpj+7DWvtlYC7RGWB+VMLOjk15Rz44WisiWVZ2bGa3zYP++Liv3kT
 gi86/iNEvEEEn4Lwv0GVPh25ObtIyY5o=
X-Gm-Gg: AYBFou1MZfLYeZ5uC0oXglygpwjDM+oQ6jCtSTPJZkxMfa01HFouninmESSN4Fk2+7I
 uO5ptwNEQh0yIuz3p7nJ4IhDeISnqeVbhPB9vzYHb8vfCExlUGQXKjLZHY+94hTORNopmvnzBkW
 8U4H1zxzmMwP1EdSmgtV3LJCNpMv1RgJ1nI+WpR2ZgzJ+Tm0LW5ZBRSNg97WmmEI2ZQKNEU37k8
 benhehD5qPLpC9xIce5zuMQxXg8lYVQj7aFBaHVQaKN99leg7Kkr6v634LpUWRcwZrR94SpGd8t
 W5Gu71P9d1P3aIGQQ0/vQ3BojRpDDx4+sxcxf1PxHG9L9L2zonkFz0pKa6bsQkWAZ1c+YzzvMxP
 KDMO2o/98lIGfba5AJsjmiDaDtV/lPycZXnCM28OUwnbLndk7YtuyX3le
X-Received: by 2002:a05:690e:4402:b0:677:aa92:759e with SMTP id
 956f58d0204a3-67a454c54f2mr1155074d50.76.1792875121647; Sat, 24 Oct 2026
 13:52:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260913222956.2050281-1-qwe.aldo@gmail.com>
 <20261009030029.3040494-1-qwe.aldo@gmail.com>
In-Reply-To: <20261009030029.3040494-1-qwe.aldo@gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sat, 24 Oct 2026 17:51:50 -0300
X-Gm-Features: AclHuK97JpsrcRehseqrsSidJ7MNhpIhsX8o6Rfc5z33yZiIDEWoiVAVEFf_m0U
Message-ID: <CAP48HfuBG+qT==ihpj91OZsTg9EFX-pGxdi6PcFYg8BkUkU9Jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] drm/qxl: fix multiple missing bounds checks in
 execbuffer relocations
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000c0a7b6065e9c4400"
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
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c0a7b6065e9c4400
Content-Type: text/plain; charset="UTF-8"

Hi Dave, Gerd,

Following up on this v2 series.

Is there anything I can help with to move the review forward,
such as additional tests or changes to the patches? If someone
else would be better placed to review these, please let me know.

Thanks,
Aldo



On Fri, 09 Oct 2026 00:00:27 -0300, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:
> Hi Dave, Gerd,
>
> Friendly ping on this v2 series (4 patches), sent September 13.
> It fixes missing bounds checks in the execbuffer relocation path:
> dst_offset validation, oversized commands, cross-page kmap writes,
> and src_offset truncation.  The v2 addresses the gaps found by
> Sashiko AI review on v1.
>
> Let me know if any of them need changes.
>
> Thanks,
> Aldo

--000000000000c0a7b6065e9c4400
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Dave, Gerd,<br>
<br>
Following up on this v2 series.<br>
<br>
Is there anything I can help with to move the review forward,<br>
such as additional tests or changes to the patches? If someone<br>
else would be better placed to review these, please let me know.<br>
<br>
Thanks,<br>
Aldo</div><br>
<br>
<br>
On Fri, 09 Oct 2026 00:00:27 -0300, Aldo Ariel Panzardo &lt;<a href=3D"mail=
to:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.=
com</a>&gt; wrote:<br>
&gt; Hi Dave, Gerd,<br>
&gt; <br>
&gt; Friendly ping on this v2 series (4 patches), sent September 13.<br>
&gt; It fixes missing bounds checks in the execbuffer relocation path:<br>
&gt; dst_offset validation, oversized commands, cross-page kmap writes,<br>
&gt; and src_offset truncation.=C2=A0 The v2 addresses the gaps found by<br=
>
&gt; Sashiko AI review on v1.<br>
&gt; <br>
&gt; Let me know if any of them need changes.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Aldo

--000000000000c0a7b6065e9c4400--
