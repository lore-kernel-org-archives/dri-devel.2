Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61F4C98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B883010EAC9;
	Tue, 22 Sep 2026 08:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Rnwu28PA";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970B410EB64
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790065995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F96J7DJJAKJfcMZddwK3W30eQH37p3jCY4JYz68S9D4=;
 b=Rnwu28PAT+G/CsoTmR+bmrSn7GdiJ4foUn865h6RlOgI8LeH/veVmObF2MEDStafE3A+ot
 2D6HPr3l+KbJt31vZtoQ+4puR0zXlNgKALioGXW/iPQvZWf4AEC/JofsC93KGgfojJBEbA
 dm3PO/KrRhyJk1YdQ0g5kJXtY1DbhHM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-fZtxuWh7O7CgzQhzH3b_sw-1; Tue, 22 Sep 2026 04:33:14 -0400
X-MC-Unique: fZtxuWh7O7CgzQhzH3b_sw-1
X-Mimecast-MFC-AGG-ID: fZtxuWh7O7CgzQhzH3b_sw_1790065993
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc51591102fso5514066a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790065993; x=1790670793;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F96J7DJJAKJfcMZddwK3W30eQH37p3jCY4JYz68S9D4=;
 b=dqHbDbOhsrN2k2Tnmfd+6xvbuxzdxPFqeBxP5S+9AX3VHVsqHpoP574QCXkZQe8YdX
 3w2tVei33+UcnKwYBoRZmWz/liwJB8aK/rSZGjzg0cHfx5WkbIz7qRiFLMybKWPSKq9K
 DBzk+duFMU52Wk/o1liUJFFN5Jlolcuf7kdjCi/hZi6BPPH5B2/uUuZhu3o31sGVNLHl
 NS6/ub3PJEN8p7Jb9VO7QRWStVYMVFmqBDJ6lgqgUxrQHxuHNVOgmFtSUzlG4PQZsiwI
 Uf/WlvlveNhkFWH4DYl55FMnz0S9rMngjTVYo+pIszH+/H3tWcjhlYz0yQx0BKkSZVaE
 LJpg==
X-Gm-Message-State: AFuF++mnCmT3NR2FwGUqF5B8mQ/DGudhVS4R30K0mg0T6QNBApNYGBCE
 MXFU11ubGaoEyayI9owyYdSEclc9JE6pEu8Ec/a+Q8coVHu98ImNSDBE23+7V9BbXehch8YjKFZ
 FtOEL/x7GEPPigVPGq+v/v57xv/HlIcpywA1pXZ4rj5dYJpdcQVT0aZKBCDLR35vF06kXqGbpwO
 SwC+Ba1zmbyDQS3oWHEU4MuAck/EoFLalAzh9+ecGRgQd9
X-Gm-Gg: AYBFou0Q3agruR5XKy0v6dIzV3LG+/j6TbNpmMSx7aa7f6hH210WBHqqQ3H5Q8jrso2
 XxerGS1cZxmd2H9UHzP4r83gF0+TtZ1m2IjKEjzN4VR1ozaqxsWyPN4ylksWRkzDRpfOGwHnE5u
 sbK4FIrkp71CwvDWEfCujPaaWxh8k/v0qTkAZe8OlDy7lJM3jmDNE12FfS
X-Received: by 2002:a05:6a21:3997:b0:3da:1e7b:ea27 with SMTP id
 adf61e73a8af0-3ddec64510dmr599417637.21.1790065993054; 
 Tue, 22 Sep 2026 01:33:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:3997:b0:3da:1e7b:ea27 with SMTP id
 adf61e73a8af0-3ddec64510dmr599341637.21.1790065991877; Tue, 22 Sep 2026
 01:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260908044035.62093-1-mario.limonciello@amd.com>
In-Reply-To: <20260908044035.62093-1-mario.limonciello@amd.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Tue, 22 Sep 2026 10:33:00 +0200
X-Gm-Features: AcwNN1VtA49KGh0oWUGKjHEN55TPH-cQU1mit2FWLOruyptSR0tnv5cErAS2kZM
Message-ID: <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com, 
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: taatc3biHR7kDx8GihH7fzLFh1LQAK7yMN_XyMm4oh0_1790065993
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

Hello Mario,

On Tue, Sep 8, 2026 at 6:41=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> At Display Next Hackfest 2026 we reviewed progress moving brightness
> control into the DRM connector properties.
>
> There is a range LUMINANCE property that will default to 0->0.
> Once a driver attaches a backlight it will be updated to 1->max.
> If the panel supports the minimum backlight turning off the display
> the range can later be updated to 0->max instead of 1->max.
>
> The legacy sysfs interface is synchronized with the DRM connector.
> When a compositor using this feature is loaded, sysfs writes are disabled
> to prevent legacy tools from going out of sync with the compositor.
>

I don't think I agree with the direction of this series. The main
issue for me is that if the sysfs interface is disabled, then I don't
understand the value of doing all the hops between the DRM and
backlight subsystems...

IMO when a driver sets the DRIVER_CONNECTOR_LUMINANCE feature and the
client advertise the DRM_CLIENT_CAP_LUMINANCE capability, then the DRM
driver should be in full control of the brightness control and not go
through the backlight subsystem at all.

It would be better if the hardware specific logic to do the brightness
control is factored out and used by both the struct
backlight_ops.update_status and the atomic modesetting state check /
commit.

--
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

