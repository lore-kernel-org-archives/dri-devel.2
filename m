Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593CAC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27CFD10F0D8;
	Wed, 12 Aug 2026 19:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sA6Zjstz";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448D310E45F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:41:43 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-381f03d7be0so276055a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786563703; cv=none;
 d=google.com; s=arc-20260327;
 b=BTGrCY9/bzkqzAWIQu6pmdye+dLw+WxGz5KBg4o5KmUBCQB6TZGpBSBl/7C6wWXrIP
 6Ck2H9ujkwC7145hk5KWdjaZTLEwqKgLVW/pXjhIeor280bX6na2R1s6q4RpKSigxAXs
 Yzj6MENf7Qxa8pd2lQl18SKupcBoN6OcJy7eX3yJl4dGi7+KX1mdgVQq1p3qm94VF8d4
 5gcg0xxEloJsRaJ//JxcvMpk58vEcpMg98HB+D1klv/BktIRf36JW6p7wGoju9ug47IV
 Kga+YAwrZvaX7dI0sW1qUmjIrPP9Igz0YqMW8HAY2Qb7D3c+pbSV768rsT3wplbv2glX
 C2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mks4PzP7z/JjESfLTgfrdXVg51XLNmx3p3liUgg7Kog=;
 fh=YED6nRsDx4uUUSexnBP70LbBnvKjZf5fxj4yfGCZ44U=;
 b=G6O5vJVAPBoP/f+h/Le2RR9JPCRy12p2F/SAA/toQky/S5x2ccsg5rLhEyjmMrGTBG
 Dmz+CtWDfaQ8QtOrqDRprKLoHk7k/kkXuudZoLJEpMAsfFQj8Zsl33biBF+AUi4PACGD
 mrd2u9bZ/ygnuiUl/GGyafJM8dYrNEez+obYCS/TlXIwH/kBvOMI5Hs6h7VkM+hfDvWF
 s4lgzxmZi3P1QTLC58tM1IxgCIhcS9qTxuMor7/ztP7v7w/EsjEK+uRAQRaiedks4sLY
 K5yPidwYMszNhD7tMAgygFKNea3WrRiWv0P1fx+DBuoz6SOYc+KCqztb2z1wLBEEDHkN
 hTCA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786563703; x=1787168503; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mks4PzP7z/JjESfLTgfrdXVg51XLNmx3p3liUgg7Kog=;
 b=sA6ZjstzlmH05AL9nWct5x99VPWzIzZUy2kcqlbvph99HQV7RIJot8x63roLAGt461
 3S9kxPcO5e5UzaEpduBCmnaDzKtzVMRLNiu7v1YCamQbowngUtqWYLddtjIwDcWf8Hj7
 /3SvS5dvJYk3TBzbk48sf9cVxSER/l7COYoZCpSX29ptTDxwqk1C3d42pjQWX+jxsf/9
 hDQCOXxhag1q0H4wkxwjwprJORtYcBbO8bdmZWjJd0VIOUXPdJxen4JRj4mteEJX8rD1
 4/mCMBmjBNV8b96JXoGNL3Tgq/UI4O+bd7IxA458Zh3w82ksCTTABmSKZgO7ahICenWG
 TEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786563703; x=1787168503;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mks4PzP7z/JjESfLTgfrdXVg51XLNmx3p3liUgg7Kog=;
 b=gWCC2L6mZqIWwx9LDBhSfjp52F2D6fjM0ziqFGar2H0/f/PZZgGKf7dDuEncT/WoZs
 rPQ7GSm9MX4woMD8rwvQnrvRC4sw7ckucJI27W1WtzCeYeYyWkIpyrD83+gw5klW3H6O
 Lf5cOtpl1mwjADuCTxXs1mW9TkNvme65HdNuF9BtFlT7qYvwcTIm73EMGgbYAZO5WEgN
 H8HmPLGn4PcS0+XnXLpFPcbRZpmbZjctAN6zDUoyC1VrQInCJ8aolICP8bLbcyYnFP3t
 1Bs3ZQQadexYFLL/T0ojfDgeUEa5CcTqijqd2kBZOrBtCS5n5qlgeHxCh7h3qFcUvkQh
 sCLg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp01uY/0aemL5vxYG/LMnET+FWgFDlDTRKkrxNEQg/7LuvicxJdWK/S2Ku2GqUxJZgqI/uBdQ5LOfQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywpo1utM0tl2ewRdev+LB6ehldpLB06xQRTo5bI15lVQw/7lB48
 H0p4TqYUt1lDD28dpkQILcK/HHEOiRcyctdZK57J/yc/9bZ5e2zQBxgnRjG/e5Ig+imcTo5Og8S
 MuPhc907HqqU/m+B385Fdv4EsrCOZ1Ts=
X-Gm-Gg: AR+sD11SqZGtelShKkoGZg0hg3xVz8w+Xt++FY5GiEpAVbPlLVbE72nVfjpIRp5KiCd
 9IFufeW+g1viQrsuTs74gHC6edTTAnVT/51TbZmjCl5JvJdgybLC4NT7hpQwSti/E5WcTCU/CfB
 kRBPfhFe1SY06/0xKNyNkibY5/MmD4OogDS/PTTqutQA5LR3RU+DuRY+8aCvqkF0IPaiy8OrpcL
 vWnwdlCl84VYlHRS8YDIKvPK/DrJeSm8GSfd8tN7dujE8+xNycD91WzNfI20/8W2SR178HPXN0t
 /kToxdlJFZ7fxd8WIaPK8T3Ja9eaI6cUnLVYqlhPGsQQ450quGkF7iVeLvplkzxoPSK0B6Wbt35
 TvnznAjupCjZv7fMCt3sdEply9sXkQNvw3qxAOC597A==
X-Received: by 2002:a17:90b:4a0a:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-3931e305cbdmr422812a91.4.1786563702713; Wed, 12 Aug 2026
 12:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260808120934.2813010-1-lgs201920130244@gmail.com>
 <a5b4bb17-db2e-4bea-ae45-7bb3c5dfdf5a@kernel.org>
In-Reply-To: <a5b4bb17-db2e-4bea-ae45-7bb3c5dfdf5a@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2026 15:41:31 -0400
X-Gm-Features: AUfX_mwe2SLWRO9VELEw_R4SIZIRE_5qbm3M11P1fljWz8oDoEOEenfY1vc_vKw
Message-ID: <CADnq5_N0MVecwbKSJa9d4UFzagNzQJ4=qxGvVGFfvzDBOSMaMg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix autosuspend cleanup during removal
To: Mario Limonciello <superm1@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, "Jesse.Zhang" <Jesse.Zhang@amd.com>, 
 Jammy Zhou <Jammy.Zhou@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

Did this ever land?  I don't see it in ASDN.

Alex

On Mon, Aug 10, 2026 at 10:35=E2=80=AFAM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> On 8/8/26 07:09, Guangshuo Li wrote:
> > amdgpu_pci_probe() calls pm_runtime_use_autosuspend(), but
> > amdgpu_pci_remove() does not call the matching
> > pm_runtime_dont_use_autosuspend().
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> > path.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> Also applied to amd-staging-drm-next.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index 1aed121f4ddb..e814701bc8fd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2548,6 +2548,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
> >       if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
> >               pm_runtime_get_sync(dev->dev);
> >               pm_runtime_forbid(dev->dev);
> > +             pm_runtime_dont_use_autosuspend(dev->dev);
> >       }
> >
> >       amdgpu_driver_unload_kms(dev);
>
