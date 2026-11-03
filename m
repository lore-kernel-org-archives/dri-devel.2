Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4A606A32F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e5ADhrrK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD5B810E51B;
	Tue,  3 Nov 2026 09:02:23 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6629E10E51B
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 09:02:17 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-3514b90bb89so8124392eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 01:02:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793696537; cv=none;
 d=google.com; s=arc-20260327;
 b=Ub0AtZJOtPA+vkXaAAGVjM9Dl1CJsyGOuPK5A+iNuzrcL2r/fRiUjG4bUtQ2HQfsyQ
 sBM9Ts3sefhpN0OvLGpNKWhk+5D/GCN5Q4SKqRQls5Pso88pRA+U1TzaR6LqLuPvChrM
 flfCIKJ/DuqXbxQS57RInNzKNz39FOl1wo/hbR/abQt6+7Qss7FuoiH7tU98HbOBtGXc
 qV9DWzwBFe6niHbSe2zz7tAgefUR9F1acWWfPau8wsh86EKq4LZ9hgtB/WfqYSHC6POK
 wSBUIEsNMN080IVozT6hLCRrJrbz37F8IB/d0H7aoRuL5/E7WfRpypWZHP7GpBAPZMDq
 /sBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I5KjhCza7OLCRkoYMN0mD1Q2oGVJGpZNaMPYaatrZlM=;
 fh=YDfPEPlf8QZdhaJlDwtk4bTvEeZNBDzOHKypWSpfXUA=;
 b=X8EYPXlD5oxkpZz/NgTimqBiIMdyHoYlzDlTkzOwIxdXIVp7QJMfp/T6Vjid2rQBDv
 NUMnPVpOfjHDWJUi8b9fDFZkuPq85nRxNTxb2moGf7c/phBWxk95bDcpf5QA5/J8AhKt
 fFBYC2chF11DQWXZxCKdL2ATM07quwXXFbyIh7g1Lw3ilHcK57XKCGyjQKZsM8CkkALq
 JSY0gcFp2MbTweSVc26wuC1rF90NH/Mb75kxo5QsBE/+2/f8OA+NfYaWJ1MaJVL2+Txu
 H+muGnoZVhyfzBiawygp67V7M5EOTLFjnsATmuerUtbOVLjRlcGbTld0z+o+hrhiis3Z
 HLiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793696537; x=1794301337; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I5KjhCza7OLCRkoYMN0mD1Q2oGVJGpZNaMPYaatrZlM=;
 b=e5ADhrrKOGeKkCGE9m/vj17tGw5KOk63Nm1zyBjhQ6xIaiBd/5Z8ow7FKitjELbpcw
 TvFhwPn3oNULalw6S4OOHnV4gw/18HUYHTHFHPwSwnKYtuaxujuaOmZOs/xKRQ4q3WPU
 K4sAtaOLqddYFCjCFmGpX/hzVr8sFJho4yPXWQcrrG6G3F/PuUbuA1osJxcyLkRpK90D
 xe+n1YgjosNcOFMaUJOS/ue8FOybPRj09rrsmJBWLbiMQOZ/1vPDNQ8YRouHE6jD2CmW
 POoNaEGxwURlTjhikUNrFas1OO6diGtDMpaROMGMDHkmjK17sd2hY9Ap3yK5Teen9Lc7
 VEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793696537; x=1794301337;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I5KjhCza7OLCRkoYMN0mD1Q2oGVJGpZNaMPYaatrZlM=;
 b=MMrcGp5w5xnGvoG0TCzxb4vvh+Qsb8Z8ps7czvGdL/AtGzZEVQNKUeJYHytEyhIWiZ
 2D814dFLqjOVE1aiErHEMcL29nW38lVtgg3JaamFD/5u1BMphbS+DaT+DM3JghH4n0zL
 kDRJDg8AgxYXjqvLkPtJ/Rj1hRvvMYUYXHZ7PNSZEVLL/UAASvGwBLKNzqxp0x0jQ63F
 6rle+LBfo/0b9vTI+NoRBHvcWrCznOrIocODQAAi0KfEuodx27iUm4IWvrGnuj1nKYw2
 YU//9Sl+hn57zwxmjIIJmj4bhS6rSG9uFd6FDTfw477n41syNiURrxrIttlporrUDZ57
 /ziw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0niboAo1i2QTUhQ7RyWU2BJX+UEswGF7TATg1Ui7h8IFL+hVHTMzRvaCMMOk3u8keI3SmN8DMk4s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/BjufQ3o4H8aFgib7uDLcUOjqvQBuVPpdozvoHbCYI5J9DtNCD
 +BpuX4X4oC4E0k8nmcUgzSpuP2SsO22/qxBgIE9kJgkgKtVqFRxYivJ0Ma+eFkoAEVOinUMRoOW
 nSJTSln4Rg0QZeWGW+WyERMiE1GxLS4I2MQ==
X-Gm-Gg: AYBFou2PhKQNuFl2Ko6MvL2S/nA+mBBAP0zZcDVLSOFUeH7IzhjVhp5+AMArMtCo9LD
 r4SlUpq2aRng+htcXeP0OY9FNGVrBOuX3Bm8CzqM/7s1gfFhUgRx6EaPWwh/X/9xC7RXHf2lJ8D
 bDZueRJtkeOS/klHUWPhSAhR/ysHypqoQhs6wbK9BSVi7dql1u++bzrkQ1/THCDlgZhahNEiUiR
 Pc7/0wgiru7Oq0X1irq2+FCt06j+C04eFl4b7nIIZiNzQq1uoIEImxE0isJQqob2igkcaDCtpt5
 wf+1MxoAF36xH+SJteNEevsN9p9Nq5EhXjcLClZtP8lZQLo+/XgKjoOF8h2mzWMj5Ax5k9+a3Fq
 2bzj0EKLK4BQXLJN6uwQmbG8nZgD5CdW5GDYjgbMmewde3SQ0wPF3ly7WlXh+JnAtZkSfUw==
X-Received: by 2002:a05:7301:1a05:b0:36a:11e7:a11a with SMTP id
 5a478bee46e88-36a4236241cmr19980626eec.12.1793696536533; Tue, 03 Nov 2026
 01:02:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022132259.240717-1-clamor95@gmail.com>
 <179362684510.3310106.12424997423646231725.b4-ty@b4>
 <HUi_TWCnQA2WP19xCg9CEw@nvidia.com>
In-Reply-To: <HUi_TWCnQA2WP19xCg9CEw@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Nov 2026 11:02:04 +0200
X-Gm-Features: AclHuK9kP2YZS9qM8orBh3iwFzVk5JoYyyundAYGnDH-DFMvjVyJq8oHL57nrh0
Message-ID: <CAPVz0n0fpR553WL7bRYKFcHgGrc2pauMsKs1PTnuZVpN8UM5oQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v4 0/7] drm/tegra: Add support for
 Tegra20/Tegra30 8-bit CPU interface
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
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

=D0=B2=D1=82, 3 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 03:45=
 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Monday, November 2, 2026 10:40=E2=80=AFPM Neil Armstrong wrote:
> > Hi,
> >
> > On Thu, 22 Oct 2026 16:22:52 +0300, Svyatoslav Ryhel wrote:
> > > The display controller in Tegra20/30 SoCs features an 8-bit SPI inter=
face
> > > that closely resembles the MIPI DBI Type B protocol and is referred t=
o as
> > > '8-bit CPU'.
> > >
> > > Add DC parametrization options needed for fine tuning by bridges.
> > > Add 8-bit CPU interface in form of a bridge linking to RGB port.
> > > Add 2 DBI Type B panels used in LG Optimus 2X which work with
> > > the 8-bit CPU interface.
> > >
> > > [...]
> >
> > Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (=
drm-misc-next)
> >
> > [1/7] dt-bindings: display: panel: Document Hitachi TX10D07VM0BAA and L=
G LH400WV3 panels
> >       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/46011a636=
fd729c99781533e265297748b5a0b0f
> > [2/7] drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B panel driver
> >       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9fe804e2a=
3001fd024c0809678d09c5e0ed359ee
> > [3/7] drm/panel: Add LG LH400WV3-SD04 MIPI DBI Type B panel driver
> >       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d87ca1bec=
bb095b6204cf657508c91e5e995d9b5
> >
> > --
> > Neil
> >
> >
>
> Unfortunately these panel drivers are not functional -- they rely on a
> contract with tegra-dc that we've changed in v5 of the series.
>
> Mikko
>

Panels are functional, but they require specific configuration
described by Mikko. This is not an issue. Since We are working on mipi
dbi bus for Type A and B devices I will just add commits converting
these panels to mipi dbi panel driver. They will be as an example how
to make/convert dbi type a/b panel drivers.
