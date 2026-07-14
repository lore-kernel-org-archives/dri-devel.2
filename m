Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21794C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81DD310ED56;
	Tue, 14 Jul 2026 13:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rYVzMl2y";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC1410ED56
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:40:52 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-ca679f747f5so549243a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784036452; cv=none;
 d=google.com; s=arc-20260327;
 b=e3Hy7DNdojhYTdimAA4rxvwvx8dJYc3PgqxQIGLcpahXYrQALSiM6HvC8Uebs8eYUe
 bq+lUbLKJKU1xvKVVTm4gKwjaqLo62oV2wjX99FcCF+OasGjDIO6BuFAlQ3d93TKDM/f
 d1IRHxL5NSv9S3AsLfc2ZM1YmRbzWF5yk7UxD+8tLvyXSe9edE1rGjFxLrP983J/9XL7
 n4Pbx6IeJYv6TzY/hrZr03mqChQ0nJg4KHB/2YxZFSuBevYUzTXxNevo9RkNDTF7blci
 mA8VQwSwSPnHyJXdD1fqpwRMbKL+/RCLGQKXp1tmcwmI5844DuMmzt+WYTVmZz3mHTh2
 n5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EoE5E4v2bdewNclLVvGL95rHSltmNPxTCq5J2nM8KwY=;
 fh=LtLhAgOWozT1omRRMXBtfbDmUarMS71U5w2Bbv4eazE=;
 b=i1AevrhA2/h5rTDnuthL1xyJvuMWkUIn3QKoErkdc9T0bBkcKVQJfamPpwMDBEyGUA
 XRtmAOd2u13KeFEJ5blDPTqE4Hk3ZuFXoMBp76F7R/091vMKxXeJpduiQLTJ07oSw3Pc
 IAUBjYlBOpIKnEJcLtvT3cEvpBu80y6zWZt4UgLqvpkL9l9jrsMgnH3UG3d4RQlsf+1p
 6YCf1VCjY6ktmbccDAd/jjnBkY7FE8bs3AyVulSzpxelzhOYPL/UHrfcDz2TBnnPRmFg
 Zc4T9AdDMlC52RKSLSbjhDHT3urGsQvzbAXUWLGhCW5rk8OQ3vF+xmAV9oLHgOW6/WN6
 hO9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784036452; x=1784641252; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EoE5E4v2bdewNclLVvGL95rHSltmNPxTCq5J2nM8KwY=;
 b=rYVzMl2yVlEWd7bCVeR+p6TyE13xNb47PhDOHjDhR/tqW8MwMzPx4lYV6J9s6HV43y
 5y7Y6GoxCssakiKCAwGIVHmJFmaeckv3cllxNWdEGsYtPtfv0TNMngUNsO9me3JTmY5l
 D3WMFbzydtVEYw3VdaP7MxJu53UiXhQGMMyNio6HsdfIOK9LBHdQN/vGothwvD03HsXz
 eMXwbe7KaJbJJQfbYHRNzWQVP+NEb2+115OeCtM2V0oz/GpH6H1Ooxkt5lhYhcLs+UFC
 1BVqKKDUe7AOltUwUc8r8fS/kCin7gWAoL+bSpiZTnPIuAGu9DBLl0RDiwArFybVMdXX
 w08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784036452; x=1784641252;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EoE5E4v2bdewNclLVvGL95rHSltmNPxTCq5J2nM8KwY=;
 b=bi+GJ4886eLLshHrFVD+K2xzjad7Y1ki4V9WNDz2O+j6ceAyOxEGWIoof3gE+5XqOw
 UQ/1j74lqF1D8XPVPWLr86oqX2ABlkR/2YA5R2SYfYkScEn/vr9t5gxlYDk77RcWljaE
 hqNxzmWT2NfZ2WdR8Z+WpoM2tqqpzJLyl5aAb/k12moMMhXD2ndJFpMnjkDPnUFs1Z0g
 4j+WaOXFNv9+KQN9QPUB7Pc3d+2XIPS7Gbvt4F5e2/i260MHNVTB2CdDf38Q+sKhl8Yo
 aiZdcbbwMiS4rsJ+ZExNOQpKCF3Pmmo0vEpLkHUzSuVZgBAXqZAi4KKtzGa1OYCdocNv
 ELBw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1Ydw0daZRpp8bcWXjEzHH079zZVPz4lGKu75ytDpPKz/7TFq08nJ/Obut+oMequHBgYgOKurn5kc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxlogypz9M4en5s8fcne84WPzhiuXzjOqaJWF48m5rlOu6f2BDt
 pY8z0i09QiK4fy1Traj3kxVjdGoT6y6ODk4v4Us8GF+qyz3yzvgC8G+JvLqaxX200eYhUm9LAU0
 hzPazoGP+12ZwvKFP30KMAjjnuj1fWRs=
X-Gm-Gg: AfdE7cmzyWgD9q6+YCFQVNR9t/J/5wxhaD1fbvz2jb7ESWJK/6a5I1SYgLppzquU78M
 4nQ/O+6p50+G7ALKGfaLKPvOEf5kmdNFyDGf7a6jnQsDSYovCQSQzDLhpbPPSEWaMug7gSZh9mN
 byiCLusI4HN16zP7kHsmIlkUQy6eio3aldx4VWjdt50poEY8lgBUdi1hUnXmMSXNMJG07yXPAKc
 +kxG3s3JjTCUG5i8wfFJhIDGu9deRxpSF1dgDEkt3cYIylIrdESi5TepF7ZPZRjf7UqRUZiiAaO
 6MojQv6+/5HRZu4C1JaG5vfy92wFyagAEVBw6Dq7DivluATXwOXl4OnN3HY=
X-Received: by 2002:a05:6a20:7287:b0:3bf:95f4:dacf with SMTP id
 adf61e73a8af0-3c110b15ba3mr10056038637.7.1784036452154; Tue, 14 Jul 2026
 06:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <98fff9ff-f013-404d-9d92-aa1dd6160f63@gmail.com>
In-Reply-To: <98fff9ff-f013-404d-9d92-aa1dd6160f63@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 09:40:40 -0400
X-Gm-Features: AUfX_mwhHVjEGHPCpoUA7DyyfTA1nc_LbivSjVnxBUEMSxVShl02R1kThL-Za2g
Message-ID: <CADnq5_Mv_ojWBD-=g60EaGMV_HMzodNs2K8XC8n-Okm4fzr0wQ@mail.gmail.com>
Subject: Re: TODO: Open-code drm_simple_encoder_init in amdgpu
To: Gravias Panagiotis <graviaspanagiotis1@gmail.com>
Cc: tzimmermann@suse.de, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, kees@kernel.org, felix.kuehling@amd.com, 
 jani.nikula@intel.com, superm1@kernel.org, pierre-eric.pelloux-prayer@amd.com, 
 mripard@kernel.org
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

On Tue, Jul 14, 2026 at 4:39=E2=80=AFAM Gravias Panagiotis
<graviaspanagiotis1@gmail.com> wrote:
>
> Hi all,
>
> I am looking to get started with kernel development and would like to
> claim the TODO item to open-code drm_simple_encoder_init().
>
> I plan to implement this for the amdgpu_vkms driver. Let me know if
> anyone is already working on this or if there are any objections. I have
> a patch prepared and can send it over.

Someone already did this last week.

Thanks!

Alex

>
> Thanks,
> Panagiotis Gravias
>
