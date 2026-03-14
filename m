Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA753D58B1A
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 11:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC1A10E290;
	Sun, 15 Mar 2026 11:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XqdTqPXA";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32CEA10E0B9
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 04:15:54 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-7986e538decso24183047b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 21:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773461753; cv=none;
 d=google.com; s=arc-20240605;
 b=Pdqt8h0sEoeWFJqyjaP4JTEAv9Pb4CGz2T/aonVFNGHnTgDAAtT6bwd+eM94ZdDFRg
 zk7sbnoR54A+U763AYFsvh8j2sLzAJ6kr41FltGYZJquEvGCPPcB41NvjxbO68wOBS20
 u67fkw1zKhQMKF/RtNYnQyKPcUCZwzLHP68K4mi3cBiKNwlDvcC321tY9UrMHxRdqHtH
 KUkr6qzZWcQMHjHiN89nFh+x89uUyvB9Ivyi5QpQF/ij6KRYT0KHp3FHWsGpEakNA4+a
 AO2mUpORU9Db6CKzad4MCBfLZluVwlz03ToQOaz4rcgc1h51B2jkJh8E30mJRzjfnzf/
 b3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+8e5HjZWL1f+eKxnwGMxsaWkOM5jvTDdVFwjfWylFQQ=;
 fh=eIL1z2t//WQ+eW/WB2MCP8iDLVvm0TklD1pMjkV4jN0=;
 b=YOADXgao1Q9ZuZVavsRSYrWwaUWN2wK5IZJ76JOQDnkjmdMfr93T2drtjo7E/Xd7hZ
 RPMB/Bt2Xp7KsVVCCkRTLp3ekERQwnXL+NzNAkiJPoEchBM6MVeuDrCXkaEI7L5i2zZ6
 13omlCOMQX3h/JG1GqSBcHj09oQ+QENMo7DRTw6ZHhC5et5wxCM4QdUu0vIRxsbNrUyH
 WdtPPSnNqRI0fbEZo0abySl1y4zYiYqIO2BjEq4ltYp23OPqq3KiMV7vw7ixhloedn8w
 DBP3NKFt0K2s7KsFgrCg06Wrjr5+g9SDReE4cgCxyjclUonXCFnhAr9s9MnFn277Rl2P
 mBtA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773461753; x=1774066553; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8e5HjZWL1f+eKxnwGMxsaWkOM5jvTDdVFwjfWylFQQ=;
 b=XqdTqPXALRUUbJPIkloSqWo0qfRhsATU4Eo/iV8Tzm/bQyItmusgtghsEBwlkpcf30
 FgrUjQZkPzMHjxsCd5MBBFsCVYLNXpAgFB3XcFSJ+G7/ZBBtY1ph2WKo8TsmSVAwVMqa
 qC7s4wmWjZdmmPRdjouqaCFTk8bp0cdn03r+1PcLlD1C2Du/uN+lyMdbB4+vSK8mHIut
 CubuXhsrwlKNvYaJ9V8yZcmWMoY5XqcyJeAG7yBGybcBRi+KvWabHt6BQzICPe5W5QfB
 NvpGhNha/PmAKgOVu4YvtrwGjb/zlC42RyRZI9BRV+3oLne8ap8OPnhtmh6Ttctpw8go
 zu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773461753; x=1774066553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+8e5HjZWL1f+eKxnwGMxsaWkOM5jvTDdVFwjfWylFQQ=;
 b=gV3Uocr2Tc9VW6B99+wrZNTKMd40jNsaVJPWLE+AInGUkd318HsPoUroHoIp2wcRek
 P36H9T83V3S/awp5bxmRaQFmGllVNUSyqYsxMEMa9Bq8bdWPaNqxQF9vtyFwO+Ff0e4V
 UpGm/iyfa3v7aFybWXszdRg5xeRrM4/lsDktCp3ZWgWVgifI1PZYw67jRYsOcj6q+UK5
 POZFkNTVvcsulDNGl6wBklMp7jbYC5cd37Oz5ahD3UCNsHpxKNZLvTPsej3OGmqE1/Ai
 95O3rNDcV3LZnLwImA/vcaaPwUGPQNm5+HrcPR1dKu6aqxAYSlD4b9Hg+Q3lTnOfYMsD
 eRkQ==
X-Gm-Message-State: AOJu0YwLF1YhrvXqSrN/0fXUNluxv6b7HazBDOUqC+NXoCJigHFejTPK
 h9sa7k7caMYmgElikRzde6oqJrXvByh9FVS30E+S1wCj0uikEB1Ml2R69UcY0IokQ+RxM73U67r
 Xh10tanvgX+SEIZVgZW1RpCBLf8tP39M=
X-Gm-Gg: ATEYQzw3QZqAkOhWNg6tWNPy9JoiCpEcIeqn+KAVHb98zQXVhU9fOnP4RpAyKW0Dqny
 d+mLHLwHbrIXTA8lRC+cYKPBwtF56z3zyJmC2QTfl/pJr0TZWlsgI/zdD0p7nkE/PCr39jqVGeh
 R7wqa6jLzzohqi4OaToWi/pSAbyyDJjLwBtIV5000exCjXisLeleC3PqJq+sYPPHEApFtXfwAi4
 pOf5OKaFehyV1S25d8KhWiD64lEwkkTWKfJKKgK5KOTuft/rQgaOvLhgv/M2noUp6HAyN74endX
 YjV3dWcq2Mq6/NVWozavHBJ2b4+VxNPr/BQCxA0=
X-Received: by 2002:a05:690c:7344:b0:798:dbaa:d989 with SMTP id
 00721157ae682-79a1c1888afmr61159867b3.36.1773461752999; Fri, 13 Mar 2026
 21:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <SEYPR02MB601492D054783E9F4F18AEE5FB44A@SEYPR02MB6014.apcprd02.prod.outlook.com>
 <CAO6MGtjZ3nrZ=71MCE0XKvFAkR3iGHq5G46QXquSXL+vYAe8bw@mail.gmail.com>
In-Reply-To: <CAO6MGtjZ3nrZ=71MCE0XKvFAkR3iGHq5G46QXquSXL+vYAe8bw@mail.gmail.com>
From: Yuma Kakei <yumasansansan@gmail.com>
Date: Sat, 14 Mar 2026 13:15:42 +0900
X-Gm-Features: AaiRm52IX8MxKvzUoW7G-a5zJUvySPKgbYJmZNOrcgmk0gZC8iCi09mOblZDcKE
Message-ID: <CABTSbfc=NYV8RU6C1RRgdr8OubR4aG4EVoZFF=CzX1Fb=JWQVg@mail.gmail.com>
Subject: Re: [BUG] vmwgfx: Severe Slab memory leak (radix_tree_node) with
 Wayland Atomic KMS
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 15 Mar 2026 11:20:58 +0000
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

Thank you for the patch!

I applied it to my 7.0-rc3 tree. To be absolutely certain that the new
module was loaded and the modified code path was being executed, I
added a custom DRM_INFO printk right next to your if
(surface->res.dirty =3D=3D NULL) check. I can confirm the code is
definitely being hit during Wayland usage.

Unfortunately, the severe slab leak still persists. When moving
windows, radix_tree_node and the 1KB kmalloc caches (kmalloc-rnd-*-1k)
continue to grow rapidly per frame, eventually leading to OOM.

Just to double-check, setting KWIN_DRM_NO_AMS=3D1 still completely stops
the leak, so the missing reference drop (perhaps a missing
drm_framebuffer_put or GEM unreference) seems to be hiding somewhere
else in the atomic commit/cleanup path of vmwgfx.

I am ready to test any further patches you might have. Let me know if
you need me to enable specific drm debug logs or use ftrace to track
down the exact leaking objects.

Best regards,
Yuma

2026=E5=B9=B43=E6=9C=8813=E6=97=A5(=E9=87=91) 21:56 Ian Forbes <ian.forbes@=
broadcom.com>:
>
> Can you retry with https://patchwork.kernel.org/project/dri-devel/patch/2=
0260302200330.66763-1-ian.forbes@broadcom.com/ appliecd to your kernel?
>
> Thank you,
> Ian
>
> On Thu, Mar 12, 2026 at 11:48=E2=80=AFAM Yuma Kakei <yumasansansan@gmail.=
com> wrote:
>>
>> Hi vmwgfx maintainers and DRM developers,
>>
>> I have encountered a severe Slab memory leak in the vmwgfx driver when u=
sing a Wayland compositor (KWin) with Atomic KMS enabled. This issue eventu=
ally leads to complete memory exhaustion and OOM within a few minutes of no=
rmal desktop usage.
>>
>> [Environment]
>> Kernel: 7.0-rc3 (Mainline) and 6.17.0-14 (HWE kernel)
>> Distro: KDE neon Unstable (Ubuntu 24.04 LTS base)
>> Compositor: KWin Wayland (Latest master branch)
>> Guest Graphics: VMware SVGA II Adapter (vmwgfx)
>>
>> [Symptoms & Evidence]
>> When moving windows or triggering screen updates on the Wayland session,=
 system memory is rapidly consumed.
>> Monitoring with slabtop reveals that radix_tree_node and kmalloc-rnd-07-=
1k objects are leaking aggressively per frame.
>>
>> It appears that DRM objects (likely GEM handles/IDR or framebuffers) cre=
ated during the Atomic KMS commit are not being properly freed by the drive=
r after the frame is rendered, leaving orphaned objects in the kernel Slab.
>>
>> Earlier, before disabling 3D acceleration, dmesg also showed:
>> vmwgfx: mob memory overflow. Consider increasing guest RAM and graphicsM=
emory.
>> However, even with 3D acceleration disabled (llvmpipe fallback), the Sla=
b memory leak persists as long as Atomic KMS is used.
>>
>> [Steps to Reproduce]
>> 1. Boot a VMware guest with vmwgfx and launch a modern Wayland composito=
r (KWin) that strictly uses Atomic KMS.
>> 2. Move windows around to force screen redraws.
>> 3. Run sudo slabtop -s c and observe radix_tree_node and kmalloc-rnd-07-=
1k growing indefinitely.
>>
>> [Workaround]
>> Disabling Atomic KMS in the compositor completely stops the memory leak.
>> Setting the environment variable KWIN_DRM_NO_AMS=3D1 forces KWin to use =
legacy DRM API, which works perfectly without any Slab growth. This strongl=
y suggests the bug resides in the vmwgfx atomic commit/cleanup path.
>>
>> Any assistance or guidance on testing potential patches would be greatly=
 appreciated. I am happy to provide further logs or test patches if needed.
>>
>> Best regards,
>> Yuma Kakei
