Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A8606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vfpxESRG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C5110FB81;
	Thu, 19 Nov 2026 07:48:40 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0EA10E581
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:43:20 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-380b40319bdso2159480eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 11:43:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795031000; cv=none;
 d=google.com; s=arc-20260327;
 b=mKKT0SJluT5a2mBDAX02QdhNaWTfOf+qSXBhEOAVIGygY/9i1Mkng2bpzWFj8qAuQR
 7eKDw5vxmpc5xS4QhcVNUsuGr/aekrd2VatIIEUEhXTUHXXXg8Z14C64EnAkMl1dh/6m
 m4TRdWtGVCwuNhAkElqC8V7kG240GQzrJ9DfzpmXjGuUveH0eWl/0yb7aL4ANOi5gZX3
 A9DOWqYHBzjUjctpcL26+EsUJdozPRSqcVLYzS6uQEcwTbfcJt1O0sYC7HMvowz+Mbcf
 tKXnYD/JS59Oty+F2CSbmgduptSFE2W6XeGKboyPaCVkKdQ60l3Keh3XTat9unQhxkb7
 VPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gifZMvAE7DM3i41UajDclxs+czdGYhGHD0kU/nIld8o=;
 fh=GRGly/7UcbQFV7NwhOpAQaRPSSHDvQiok2Rnmxl+dEA=;
 b=cgZZnE8ywBjo5tHAjS+3EgPJtZHQ91DeG8gSlpDVJ3bBwMLnISDJ/wasv3NWm3ZTkA
 6FepX/ou9cGSX+E0YuFeTrsy/xu/pbYDV8LTWEfab33fG2M2ucr3ft6mmT/GFc2wVgq2
 Iu4wUMdLpMMptYCUCBDfi95gr+E8Cveo3oOAMlkKQFlC+4dMZgOKM6tRooSOjbdf/UJb
 DOjZWBaY2xnmmZScoGIqA8pNkhC2Ru7g+sfV/AVLhXU6EjxvxV6OLBy7XARLyiF1/oDp
 X52BDupSMlzT5OBuX+We4/xD3+H7gSLfenZiRV7oH9YrCEP03vonREkuBzvM0Tq1N5Yw
 DaPg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795031000; x=1795635800; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gifZMvAE7DM3i41UajDclxs+czdGYhGHD0kU/nIld8o=;
 b=vfpxESRGZOjrqAGllr72kNcmb/4yzMdt8wPiuNCgK/doRGRbrLnCLe+1xV11NN0vGT
 1DEo5bDrwQpcfFflzt989Be7gm923cgpcsGBcRgNgG6o2gKEV2aVvKJ00YHsxSqGEOwP
 Mn+CbI1smppSBNv47OmxwVk0ifXb0XG+evzpc7JXZgi6P3d0t0IPZxzMjxPKkURZ/Ldq
 reKCHW//G+hfgVqTf4K6lChS/1c17Q1rflfj3KGFLvURy6x7M04VLUC2Yp6Rw6ZyE9Z0
 kmxXu4nnPmhUNEUQT1YdBLTz3iKdS52yMTBHmxbfZ0pYJYJGmc9c+VPLKnJCviwD29Lg
 s0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795031000; x=1795635800;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gifZMvAE7DM3i41UajDclxs+czdGYhGHD0kU/nIld8o=;
 b=X5dBPec+g+7NbtwWeymGE/EDLUDJlCuSMh1ceAEf5ds2qYwbNWpuq8hatSfK8m32Zm
 S0AguUCSgRWwl+acD0INIyEV37bSomg6/p0Ii/L6Qx8Uv8ySEEYnVKHnVSF3b6LdcMXa
 P56AvfceN1fGewWWYVvlsc0m/dnZ7OO4NVpqxMnaSYPijjBluk0uiTWP+Dzpho303Ffc
 FtXwsm14ONkQeVpTcPgvYpfkPRIfavx3iYouwz6qx8vZguweOaLHE10BrHhd9KQFnryV
 iwbhi87aENJKo7FLSuEFfbVDx6uwlKrIxqJypURDgV/p+LKnPK0SLfWFZjS5CSRxwyZ3
 nqdA==
X-Forwarded-Encrypted: i=1;
 AL+hErGN6+RvD/DzarBIESEewE9WBxzp/jPNY7jYFah5aXEyWm10KeaytfqJvjv9TopAlxWX8zPdz0zqmJ0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8n+uQHv2iFv8Vd9DOKe8eaM3RRy70rkbSPEVOsMwGwpHfoeqtu
 skR469XeHiKW7EsKS0xWTuIgnOWxPqidSIJgL9vQnGhtOD5qh5hta7AoFENDoLQp3aqMD5DyBM0
 HJuu2/NHJlixaLZgfRXCE69Huhf9nONY=
X-Gm-Gg: AZFdTZdA/UxZVR5GRR6jpTJYJNMMfnL/Fbpw4SJgslrTPCmRocYJUfMI+0FYpLAtOPK
 RJUbX0xl7ApRclcJ4nN8UJSmQG7/MlumuCq/oTKbviigi7V93HtlPOHxHePLfMOLsvUKQW6fBeP
 VCvuFCczdvS7upE94VYM2S3pT/ZAh9xoMNL1JYJWoWRC18772m2KJxK7B1iAR3YiPQ1ld/kArUM
 C1FBG0jDXPc42T+AZIA/AH5fxYF127ztecrmWlFbuZ5sOpWp7XRsKN2j/BNt/7FWC6uQ2oGsJGV
 jaPIzb2jyx5mQgcCjulSYzlJ9XbxjEE8wj3pIng1bdb36sXv5YZak1XWH9J+CEXi1/j1JigIPG8
 83LeVrhL2jWxiFWSTmG7Pq/haP//m/Zj6OlufBZ8=
X-Received: by 2002:a05:7301:70f:b0:383:d3d1:f315 with SMTP id
 5a478bee46e88-383d3d1f937mr474934eec.19.1795030999696; Wed, 18 Nov 2026
 11:43:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
 <20261028164539.3471833-5-henryzhang62@gmail.com>
 <CAPY8ntAXPpJbid2LXc6r0g-sr95uQ3hckxVqa09qPNMi5JSp6g@mail.gmail.com>
In-Reply-To: <CAPY8ntAXPpJbid2LXc6r0g-sr95uQ3hckxVqa09qPNMi5JSp6g@mail.gmail.com>
From: Henry Zhang <henryzhang62@gmail.com>
Date: Wed, 18 Nov 2026 11:43:08 -0800
X-Gm-Features: Aa3M54pTP0o_BnnWER0uO3IDxUQCM8btgNOU7uN-a4NdycqUs6X2Eb-qADeU9BQ
Message-ID: <CANTW0yo8CSV7StFmb1pB09sSQexJLV38weo5N1G7B8GJEpx7fw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] drm/vc4: dsi: Serialize host transfers
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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

On Wed, Nov 18, 2026 at 10:43=E2=80=AFAM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
> I'll agree that there's an issue, but as it will affect all DSI host
> controllers it feels like it should be handled centrally in the core
> mipi_dsi_device_transfer rather in all the drivers.
>
> One for the core DRM maintainers to comment on. A quick check says it
> would affect at least vc4_dsi, mtk_dsi, mcde_dsi, and cdns-dsi-core.

Agreed: serializing transfers against each other belongs in the core,
if the core maintainers want it there. I can look at that as a separate
patch.

> And your use case is genuine as panel-jdi-lt070me050000.c does exactly
> what you describe with the backlight functions are controlled via DCS
> commands. It would take quite exact timings to update the backlight
> from userspace at the same time it sends the power on init sequence
> though.

In our case it is easier to hit: our panel driver also lets userspace
read panel registers over DSI for test tools, so a second thread can
send at any time, also during a modeset.

> Do we need to take the mutex in any of these functions except
> vc4_dsi_host_transfer?
> This driver will misbehave if you request a host transfer before
> pre_enable or after post_disable. It's been on my list for a while to
> look into that one.
> But I don't believe there is anything in these functions that would
> interrupt a transfer, hence they wouldn't need the mutex.

For transfer-to-transfer serialization alone, the bridge callback
locking can be left out of 4/5. I will separate that from the recovery
requirements in 5/5.

It is 5/5 that needs the bridge callbacks locked. Its recovery runs
inside vc4_dsi_host_transfer(): it saves DISP0_CTRL, resets the block,
restores what pre_enable programmed, and writes DISP0_CTRL back.
Without the lock that could run while post_disable turns the clocks
off or pre_enable programs the timings, and the restore could undo the
DISP0_ENABLE change made by enable or disable. The lock also protects
the enabled flag that 5/5 uses to skip the recovery while the block is
off.

Transfers outside the powered/configured interval retain the existing
behavior; this series does not make them safe. 5/5 skips recovery when
the enabled flag is false.

For the next revision, I propose moving the bridge callback locking
into the recovery patch and explaining it there. If serialization is
handled in the core, the transfer-only patch can be reconsidered. The
recovery still needs a vc4 lock shared by the transfer and bridge
callbacks; a core transfer lock alone would not provide that exclusion.

I will wait for your review of 5/5 and the core maintainers' feedback
before respinning the remaining patches, omitting the applied 1/5.

Thanks,
Henry
