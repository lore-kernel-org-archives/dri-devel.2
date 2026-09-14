Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBFEC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFBC10EFAF;
	Mon, 14 Sep 2026 16:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sZ+y546/";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FF510EFAF
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 16:00:54 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85368f1d484so203063b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789401654; cv=none;
 d=google.com; s=arc-20260327;
 b=B1vN5HYbunMSQDlJ50rSQQ62ToJCcvNz//8VsM8MLWan/6Eify7uB97OxMPCp7Ysas
 qitcTkADlqqG/ZsjA0XrWLhqG/mgZNwUvv6g1baOIh0A3TGiYjUiT7bN2qr0RBXotdA0
 P1CWVMY9MTEOu7oJXIvYYnMPAsiYpfzOLRdQT8Ylb//WbWF/Ri4UtYXBfIIrMxI/gNEE
 ihV+U4Lvwiw9IFN89On8+TQlAsIyfzQgYoC5VdQXKvODOwJm26wjOChjRHxOSJJhancQ
 QPWIuHJ3bJba4UCcQ/xsVahF0N7eAPkrh+UPS3zHf5D9MnbWhqksRUWi+sL1cTY0lrO5
 iQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DY2MERo4pqi0K0VhneHvwSpwoimTnvKFD3fY4QkQorI=;
 fh=I2RitJXFSpUsZs2zunymhY8NXrPUi0090KCJhV883HU=;
 b=cIqv02IOJ2piBHTlCSIY4G6KWngYYWZv4seWh41kApd+IBmT2Fu85GjoRrVucbXssP
 AwGIAyFJJLHNkUVKCgbns1hK4hvbiCu1raYnNZ3G6TxcEreCaHYtE5msDA58OxFvKBPa
 0lzUlFLvcbqqb2SAwnhehfI9OehKE4GPdBlRVKyK78AMEDlAU+x3Jdi9Zgyl1uNFwWEM
 L5KwHeq84Gua4TcA1Af/ai3wzs9cigkIR9YIVO2Sbqo/dCaUqxNcCaWc1Ji/R8E0PxxZ
 WGg6A7TaZ3EMrNVIURWSlzyFwTsvYINDY085IdarY87bR0wLdd4XZyLVdg5eXaKo0voH
 /KtA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789401654; x=1790006454; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DY2MERo4pqi0K0VhneHvwSpwoimTnvKFD3fY4QkQorI=;
 b=sZ+y546/Biw2v9r6xnQ32GNjw1C/V+WKTTMGaTU9nsqygVnJ1cRZ1bzcDphopwzkjX
 HFtyl4gZGGAOU6sdJAy5K0mVjxS/RSYfJ8hqMNq6H2IaNbjNIrGObC5/xTPMdsRFmFHf
 qmXPTOBdb4Mv7pSOGDroBDnwcOsVcN1PhlMPy6yNgwDbnjgHzfGGeosheG5CMqpT3ymL
 jFuzSLnM5U6KPo66rsH0gxUNDaIHsvAVxKoff+ycfzWiLV/YeoaVKsLUiqTGtRq5KYbM
 SusaKoN5hfwGRp04DnMyF2gZ0rOWpFb2TMpStU8jtGHWNVt4kOIu/xpjd8rKsLNVeCJN
 QsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401654; x=1790006454;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DY2MERo4pqi0K0VhneHvwSpwoimTnvKFD3fY4QkQorI=;
 b=nYP3V/ViDmB1VN23VL0BnjvaQM7Iw4dd0fEhnkIz2Ik6gwayM+cyB/W6SKSsrrfivQ
 ZBPxnlVbU56TuPzQM/7OTTyIJnRYjQzviAPQz7wOGSdwXyHIEi6/rxXSLVBTSe7E2f5w
 UdXYKeyof0bq6wi1vx4xb8Tl1FAQilFwjR3br0TXSavFraApBkfw4wwRQOSQV8kcJM+M
 UjDLxD28ASk4nXlCW+LOCGqkavDhTvcokG9jPtp6DwymYHVgDv1hCDVRmYAja4VFSo1b
 YTB35Rj5Vv8QD+SYDjG/6tudV0cZrwnML2yZdWtju3SGBIKuEuqkgNTpf2cJDwTuUnwr
 NWpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4LN6EIymY/Up7c6VDl6ormU9ft0EmgQS97WlHYqnUCg7wEb86sQc7KP+YkSDRmQ3cezJbxOcAPYY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kpa6KUllFIkERZr917bOZt41/MXod42Th6lj6IZXUaCNEpvNVf
 u+bKNJJ6jft0u6eWHz2WM1A48eJBlprtfQzWGK/D7e8vKk3/bKvRByJRdL+cAsW5q5XMfu1eSdx
 TYlPv/gW0stjiNQ8RhaDUWC0UVeT3ric=
X-Gm-Gg: AYBFou3HPWXhVPlZABlgnJr9gMRi8+DsZyJVMeVBg+SZTHOLo6RoxcAYHF9xkoL6S8c
 PiISKaZeDobZUHurAfuB2qX8LtUHn7IDtIu7YrMz7kIpqSVimBRLcs/n+67ow6V25ASlId69x/U
 VS0BLbe3sgS5P8kSOZtzW3AxDuTI1fVwc6Lfu0X0xvCFJYz2ZZoHLIFLyym3AvcXDmf6Ums5N6k
 Iv9gSHgo87pJSUxyNqvWdFVpsvG53GLThtHFuHRNgKdZF83Y1RsagP45UrNltRdyg5/jDnBGPJP
 iYCA1DMgLFF5soHoRRHG061sjDTxj/aHiBKTl9B5iReL5R7B3s/gpBRkZlW2JLtZr8MWo5ESdfD
 xd4zpYXC8ze4ii+QP6HUELrQciJiKET61wZZ6V7yxjQ==
X-Received: by 2002:a17:90b:1d4f:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-39dec1c3dabmr4866025a91.4.1789401653630; Mon, 14 Sep 2026
 09:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260914132920.10127-1-harimishal1@gmail.com>
In-Reply-To: <20260914132920.10127-1-harimishal1@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Sep 2026 12:00:40 -0400
X-Gm-Features: AcwNN1Wxf9uW0Stp_OdrSiy6kLoKP1kUMtA3NKxerasiMRbBAeEiR0U57Nj_bA4
Message-ID: <CADnq5_PKDe2dtDVsfzjNFwu+tjoH5DzE+GU7x+O8X=ymbDAmKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: bound SCLK FCW range entries to the table size
To: Hari Mishal <harimishal1@gmail.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Yang Wang <kevinyang.wang@amd.com>, 
 Asad Kamal <asad.kamal@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Mon, Sep 14, 2026 at 10:36=E2=80=AFAM Hari Mishal <harimishal1@gmail.com=
> wrote:
>
> atomctrl_get_smc_sclk_range_table() copies ucSclkEntryNum entries from
> the VBIOS SMU_Info table into pp_atom_ctrl_sclk_range_table. Both the
> source (asSclkFcwRangeEntry[]) and destination (table->entry[]) arrays
> are fixed at MAX_SCLK_RANGE (8) entries, but ucSclkEntryNum is an
> unchecked u8 read straight from the VBIOS, so it can be up to 255. The
> destination is stack-allocated in both callers
> (polaris10_get_sclk_range_table(), vegam_get_sclk_range_table()), so a
> count above 8 overflows a stack buffer, not just a heap read.
>
> Reject counts above MAX_SCLK_RANGE rather than clamping to it. Only
> one version of this VBIOS struct (ATOM_SMU_INFO_V2_1) has ever
> existed, so a count above 8 corresponds to no legitimate table format
> and means either a corrupted or a tampered VBIOS.
>
> Fixes: a23eefa2f461 ("drm/amd/powerplay: enable dpm for baffin.")
> Assisted-by: gkh_clanker_t1000
> Signed-off-by: Hari Mishal <harimishal1@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> index 4b796d60b03d..3217ad3c1d17 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> @@ -1025,6 +1025,9 @@ int atomctrl_get_smc_sclk_range_table(struct pp_hwm=
gr *hwmgr, struct pp_atom_ctr
>         if (!psmu_info)
>                 return -EINVAL;
>
> +       if (psmu_info->ucSclkEntryNum > MAX_SCLK_RANGE)
> +               return -EINVAL;
> +
>         for (i =3D 0; i < psmu_info->ucSclkEntryNum; i++) {
>                 table->entry[i].ucVco_setting =3D psmu_info->asSclkFcwRan=
geEntry[i].ucVco_setting;
>                 table->entry[i].ucPostdiv =3D psmu_info->asSclkFcwRangeEn=
try[i].ucPostdiv;
> --
> 2.43.0
>
