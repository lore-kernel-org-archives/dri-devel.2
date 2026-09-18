Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14001C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6478810F178;
	Fri, 18 Sep 2026 04:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NZQ6hzNU";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919E710F172
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 04:53:09 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4aac9321so329468d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789707188; cv=none;
 d=google.com; s=arc-20260327;
 b=A+d+TCqeETTmdPToR/Q6DgUBRfEu/lprvvermdDac8ueGT3FhoZNDubp6hLyQdqidx
 FQkjClE1Lce6AR1QIze4gSMTuq7zFGjGHpaHkNB+hZ9mZZVeawngdcgDfDdj5ZUmimHr
 fw00erpqa8tmusav/PABQXrJGkV08hoU+r4aSeNX5VV5UjI6NweeuFw9JrYA6UROuWLA
 9qvSVINvRIvEULuJVV6TgcZG47n3fKqPk5aOHqPb4vzgkdRL6hxXfVpX5yQYCAkJ3LE1
 bIJNdQeBHi7Q0b+xtGc0EHt1XFacCGToxs3uM+y2jdpKtlaHsdPPv9KHuyFbuk7rWL+K
 feug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z+CZ17DpPcTIMS3JOrKadGqKlhsKxoet5cv2gSH16lc=;
 fh=zpcXNQu5h3RG87tKMantZjV6SuRGpPwgS2YL/bWYVBs=;
 b=iP0KKsP4w88wGlUTztte/D7H5Gu51G87qIRpKbleCzWrMvHGFIteqFw5s4B4BokxPI
 VTAVKKGwVLMJpbLzv8hhAV6zVLFDXSi8OSKmd8ka7+D8dX1LI+dqPnpvH841nmw8K2je
 MamOjJpH5cFkMtNz258bmxWWt3lMft8J8DKgdgS2meJurc5pVH8nVqSpK1vE5mXTPmmI
 uB/K1wre3ca21RVym/F0+NwS75Qe5KYNvi6b0+PmvJSGms49X1mAPbcT1MsYNSQxoVn2
 NTY2NYZSn7Cz6y1OMIBlpkcHWCxJYp2P3IVcHDmOxyjxItd+07IrEQIypJJsg9iyYjVZ
 wO3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789707188; x=1790311988; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z+CZ17DpPcTIMS3JOrKadGqKlhsKxoet5cv2gSH16lc=;
 b=NZQ6hzNUSb5U5sHKjLLBZR9mD0yzQ2ZrC8956XAUMZQt5h9xuKu8YRgiE7kVkf82VF
 WG5ETOAAQ+mv7Dbo4y3Ht4hHQJvJKt0HZNh02q6284TGXfblzBaMDe2Jxrcajl/wn7NE
 eSjxSTBQnDkgb5wC3x7uwA3D+LdVoWbQJyOzJM+RiIXSDaWZTHI4bwkltbAIQ16UtIp2
 RgBOIykCvAclE4O+GRy2Q21VHXrfAJDlBox3Z5+RB3RLjzLTU4Pa4vIAWkhISNHfH7mK
 uUMJO11BRXyFT5LdQh6WxbVgloExeahCM5G2qDVzGrNIyPfDyNx2mZTkqzukDHtfDReT
 TEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789707188; x=1790311988;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z+CZ17DpPcTIMS3JOrKadGqKlhsKxoet5cv2gSH16lc=;
 b=OT9+AB8i0qk+biccnRgOrfFQ8ED5ZpOc2AW/7HuxPRkb/INAuxBEShH0uV17vFsCL2
 VmvOsu0Lev3sBdRWmg8rtxh3nyLUse83jJNUqeP7vGRbPr//Ncq07vsCcqykSVVPBee8
 BDyfoj27xXzyWekTaiOgOHic0XM+Tuv3ETnj9unVyLABESvLt94G7Q1vlbxmIjUkceAv
 zsOA0zlVs/tZGOvX64KNIX+nB9cT+DaghyxIJoS4q9iroUCXcmT6GiEknTk5KTCHJ7AM
 z+HVU757BGoU8j00VhW96jtnZNutU1lKN9psJwzmgQMDnnD+qTwXbagnQEDKpnX8BksE
 VHow==
X-Forwarded-Encrypted: i=1;
 AKwUvBwC/b94ZrXEZR5L3ONcbC2VuuaEhP0gCsyRZ8OPVySDvBkgieP8phGF7gXrSBS66xKxwErVYofI1z4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nJy7MjjnVcgBqP+LpZYRAWnGGwwhKYPvWzrvkWCfC00LW8+PLW
 JhoAEwkAcFf34mURP7Lm6HyNy7o7NhcaGTylABbstKTCFocWSut0+S64/ay20sJoE1qzpiXRrop
 mN6mVE/UtlwVYG/VEn41F4C5xYlVNLuc=
X-Gm-Gg: AYBFou3f297sLE3Dmkc0G3sDq47JbBA1zmZMps0CN/ILAhfCv9qHZQo8tHWxMXWHyp7
 dX4mx8Vv1yj2j6I0FxpWtuZ3dHdN6S5mrpJ3LQIeGMHF+7soZZ13fw2rWDEwRvymlz8mdfT9jl6
 G1RohnO96xwRn1HfjdpKLbLx1q+4zYQ8tAeaJal60lh8mXerrZwVpTiiEcGRKf0py2tBwa3xUEX
 WbH7rBS911EPLLZIEW2bsvaWsZTGOYRqToyAdtuEcBs+5ve4ZyY/dsjpZ5deKRqIo/jpy1UF2eN
 PrCL7Vo25xu/t/tSP/Y+8/fwiq9hg2JP9apZUm10/rpgrFYIHFtk4trEH2T53D8mBe/T5Crslyv
 sKnkP/3gJzW3hZRh7/LIyXskFsx/PfP5bLq/avtUq7jBC
X-Received: by 2002:a05:690e:bc3:b0:671:541e:2bc7 with SMTP id
 956f58d0204a3-6717fd8de49mr381411d50.58.1789707188354; Thu, 17 Sep 2026
 21:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260815-null-fixes-v1-0-0df9dda951fb@gmail.com>
 <20260815-null-fixes-v1-1-0df9dda951fb@gmail.com>
 <bd730e30c96bea38d8430460ee73f073e280374c.camel@redhat.com>
In-Reply-To: <bd730e30c96bea38d8430460ee73f073e280374c.camel@redhat.com>
From: jim.cromie@gmail.com
Date: Thu, 17 Sep 2026 22:52:42 -0600
X-Gm-Features: AcwNN1WDOVB-bJ1pAJB3qllpj7DcCDRyteoOendxDaWbzrIb47hYb-rm-3IA-rQ
Message-ID: <CAJfuBxwq83qUNd==gu+uK73guPfohN24q2-9iNamincgpt=EOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/nouveau: Fix NULL pointer dereferences in
 GETPARAM ioctl
To: lyude@redhat.com
Cc: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Thu, Sep 17, 2026 at 2:26=E2=80=AFPM <lyude@redhat.com> wrote:
>
> On Sat, 2026-08-15 at 11:30 -0600, Jim Cromie wrote:
> > When hardware or firmware initialization fails, the graphics engine
> > (gr) or device functions may remain NULL. Attempting to access these
> > during the GETPARAM ioctl (e.g., NOUVEAU_GETPARAM_GRAPH_UNITS)
> > results
> > in a kernel NULL pointer dereference, causing a crash when userspace
> > (GNOME/Mesa) attempts to probe the device.
> >
> > Add safety checks for 'gr', 'gr->func', and 'nvkm_device->func' in
> > the
> > ioctl handler. Return -ENODEV to signal the missing hardware state to
> > userspace, and use NV_ERROR_ONCE to provide diagnostic proof in the
> > kernel log without risking a console flood.
> >
> > RFC:
> >
> > These crashes may not be repeatable, they happened while I was trying
> > to build nouveau as a builtin module, with binary blobs in the kernel
> > image, on a laptop with an encrypted disk.  Gemini tells me this
> > won't
> > work, so I punted.
>
> "Gemini tells me this won't work, so I punted."
>
> I'm sorry, what exactly do you mean here? And could you clarify what
> LLMs were used for in writing this series? Code generation, analysis,
> etc.?

Gemini CLI v0.50.0 - or earlier, at that time.

these were drive-by patches I did while testing a patchset on HW.
The bootlogs showed a null ptr splat
I threw the logs to gemini, it tracked down the bug.
the null ptr b4 deref was rather obvious.

at time of writing there was also some FW churn going on,
and it felt un-repeatable wo screwing with fwupd, which I wasnt gonna do.
Plus the test scenario felt like it gonna fall apart.

Since then Ive been merging it into builds for HW installs,
I recently forgot to merge them, and one occurred immediately

Sep 16 22:53:28 frodo kernel: Linux version
7.3.0-rc3-rhx-00051-g3078971ab959 (jimc@frodo) (gcc (GCC) 16.2.1
20260819 (Red Hat 16.2.1-2), GNU ld version 2.46.1-1.fc44) #>
Sep 16 22:53:28 frodo kernel: Command line:
BOOT_IMAGE=3D(hd0,gpt2)/vmlinuz-7.3.0-rc3-rhx-00051-g3078971ab959
root=3DUUID=3D66f47421-b9ff-49ca-9257-0216463436c2 ro rootflags=3Ds>
Sep 16 22:53:28 frodo kernel: BIOS-provided physical RAM map:
...
Sep 16 22:54:53 frodo kernel: BUG: kernel NULL pointer dereference,
address: 00000000000000f0
Sep 16 22:54:53 frodo kernel: #PF: supervisor read access in kernel mode
Sep 16 22:54:53 frodo kernel: #PF: error_code(0x0000) - not-present page
Sep 16 22:54:53 frodo kernel: PGD 0 P4D 0
Sep 16 22:54:53 frodo kernel: Oops: Oops: 0000 [#3] SMP NOPTI
Sep 16 22:54:53 frodo kernel: CPU: 2 UID: 60579 PID: 2445 Comm:
gnome-shell Tainted: G      D
7.3.0-rc3-rhx-00051-g3078971ab959 #10 PREEMPT(lazy)
Sep 16 22:54:53 frodo kernel: Tainted: [D]=3DDIE
Sep 16 22:54:53 frodo kernel: Hardware name: ASUSTeK COMPUTER INC.
ASUS TUF Gaming A17 FA706QE_TUF706QE/FA706QE, BIOS FA706QE.311
11/06/2025
Sep 16 22:54:53 frodo kernel: RIP:
0010:nouveau_abi16_ioctl_get_zcull_info+0x17/0xa0 [nouveau]
Sep 16 22:54:53 frodo kernel: Code: 00 00 00 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 47 40 48 8b
00 48 8b 80 70 02 00 00 <80> b8>
Sep 16 22:54:53 frodo kernel: RSP: 0018:ffffd36e025dbbb0 EFLAGS: 00010202
Sep 16 22:54:53 frodo kernel: RAX: 0000000000000000 RBX:
0000000000000020 RCX: 0000000000000020
Sep 16 22:54:53 frodo kernel: RDX: ffff8c547be52600 RSI:
ffffd36e025dbc50 RDI: ffff8c545440b800
Sep 16 22:54:53 frodo kernel: RBP: ffff8c547be52600 R08:
ffffd36e025dbc50 R09: ffffd36e025dbc50
Sep 16 22:54:53 frodo kernel: R10: 0000000000000030 R11:
ffff8c5454600098 R12: ffff8c545440b800
Sep 16 22:54:53 frodo kernel: R13: ffffffffc31569e0 R14:
ffffd36e025dbc50 R15: 0000000080306453
Sep 16 22:54:53 frodo kernel: FS:  00007fa46fa77880(0000)
GS:ffff8c576ab7a000(0000) knlGS:0000000000000000
Sep 16 22:54:53 frodo kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
Sep 16 22:54:53 frodo kernel: CR2: 00000000000000f0 CR3:
000000011df78000 CR4: 0000000000f50ef0
Sep 16 22:54:53 frodo kernel: PKRU: 55555554
Sep 16 22:54:53 frodo kernel: Call Trace:
Sep 16 22:54:53 frodo kernel:  <TASK>
Sep 16 22:54:53 frodo kernel:  drm_ioctl_kernel+0xae/0x100
Sep 16 22:54:53 frodo kernel:  drm_ioctl+0x2e0/0x560
Sep 16 22:54:53 frodo kernel:  ?
__pfx_nouveau_abi16_ioctl_get_zcull_info+0x10/0x10 [nouveau]
Sep 16 22:54:53 frodo kernel:  nouveau_drm_ioctl+0x58/0xc0 [nouveau]
Sep 16 22:54:53 frodo kernel:  __x64_sys_ioctl+0xb9/0x100
Sep 16 22:54:53 frodo kernel:  ? do_syscall_64+0xfa/0x470
Sep 16 22:54:53 frodo kernel:  do_syscall_64+0xbe/0x470

if youd like, I can trim that part of the commit - msg
or just edit out the noise.

>
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
