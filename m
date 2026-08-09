Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D71C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73EC110E674;
	Mon, 10 Aug 2026 06:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vt6LmgVH";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A9210E161
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 15:17:27 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso694785a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 08:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786288647; cv=none;
 d=google.com; s=arc-20260327;
 b=VPWAzctoSaiymgUfbCCWsaSiBar7jHGEfXFXIa/sWM3HILyfVYJba9TcD5mBDamA1w
 Qhd8YihXVhaXkUy2cbyOEwYOdzKTqEYVOP8k9mn8Cs3p9K6WIbQylhfe07aNwjjc0BTZ
 UQ3wXq5YE700PofweRQsDENEVNhJGJYN+PmAAjk96uEXQ182b0HEX+1eQ8IbWN6sX/Hy
 gfhvBd8H2/nZa1I9K1Zj+sr7l/pv1QHpWQZX0ajszpowlREiav07pjz7isdAQkgyO2XI
 oLdQdu+NMQd0+I+JrfhX6kQZuD/1TcZc7ByVavz44ogYzF1qUV3zylVklHpesoqgtWdX
 eB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=JFQbWlClRGX4in1gZnt780/D8c3Q8mZbWpBw8FxMqYY=;
 fh=QlsHHKM24ln1mksFhG3UC7NKYP29MvBYHjpz2V3r6R0=;
 b=W9vKAqWFutr2t0S5NgcchdCa3E1BMzFBt3n7tsOc25jLxmjJhSv04rXKsK030yJyH7
 PZsrd8/nb0R0n3XKitnUW0H/207iMrFQsnBqVSgkLnjblBBhqeC3qJOfnMAe+kyj+8rs
 mNN8Q12nbAeme817LYFnokvsgDlNYJHYeGVYhEAkpOIoyGcXN4sEA4f1VNk71T5REWzi
 znyVEKi0ySp+gHjI9b9Bp3yp/i0X/GJPZ4DDOfo1zAX7kyMpOyIo3tIYh1oliSP/CqrR
 8uB61pYJs2gMDeGKnIm6FbjhMJKi41iyMfa9JFvoOJVBfZOD+rNs3kZNNE+IQwIAidrs
 tiBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786288647; x=1786893447; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JFQbWlClRGX4in1gZnt780/D8c3Q8mZbWpBw8FxMqYY=;
 b=Vt6LmgVH/7e5tABU7Y05E7eKI4vDWgvbT0uqYPJgzrN6VzwP1uMpTI9KzFrw3anElF
 Vnz7S7t8+S3alSwJurI0nnYNj9x1UiRazr0Kcrb9uwIbb3VWXSYmot83ygjs4Dip3TGB
 8z/Gc4JKhFTvUOTMCFREUAUmYbF/rSHAeBgtDFSkOJlSWId+LBK4J94VT25OcFiqPQkk
 rY6x56sZt3eME4vqUCwx30bQhUia8bWdx5s9BsLsskVGw/nbOt+QTrm2uLDUYMydMk1C
 gpJ2wazoa/FKyFMdL6xJLQ/djx+127aIgU2Bic6OxnSY8j4iTOrUF8VENTls0j9eLi7F
 sYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786288647; x=1786893447;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JFQbWlClRGX4in1gZnt780/D8c3Q8mZbWpBw8FxMqYY=;
 b=o1YXLm9HG/giU96XVWodOpFUemaECLvG7lKMHhC/yXtJYYwLJb6G0FVTdbMAV+WMBP
 M9ssfBJMbXIadLWPZhe3v83oyuYLNg6LB+TIoqq9vWiIdDIpJWrOHA+zpSPlwUvgwuFF
 s3qR7ehDBNmXlghVE4fbG9ORFRiqAD30w0Ctmuh3WYMnL3tvA6abosaeeqCr9F/g0Cl+
 5rcp33eqJJVMrc8IJx1aYdObr4zldavn3fzkxFeBagjaVSddthdGp7cE3Leru8ow2byi
 hLbdp3LlsrwPQL7kUxFJ/fAiZRrlJtmsVdY6A/YRkYBcf6YxJ0Ax9Al9tU3uqNqrAEzU
 P7Yg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxDcQ2MKR0346CmiQi1Qz9aH2MrjwSiGDHTIjCMKUK3+xwa6a9MjzrqXV1j72u3zNddPGUv1oa6bg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcSCDAGLom+govsuVk7kmct2L6zy6TRCVgjK0FP2otL5jLcRH5
 X3FXXfHxi1MXvT7k1a+mNHNL9fW4LCZgyBAnhhwB+SjCWTw6CdxJoNZtcJpW4wxLzMg9zjEzQRZ
 cpCS/GoQ7Wyd1n3D93CfEP7GFxHqsE3qGv7XSmBA=
X-Gm-Gg: AR+sD13G4dM9OIfN5jv14i6kESrK8h/TMUMHGtXOi+l5xnOWB+WfIT9Fdj/3bpkmMdQ
 7nf/I+KiZ8zM8q2kXmE/eA+AUXeWDGILMdlzCWN0ILITNoFxI7QRQSqkVC+gJ/JllljCppQtcxH
 3UprhjArbrlqJC+D8f04Wv1U9BEgmy9wiNTKfOEVfl/4yqqn8nlrHty1s32HVDr07vogxJJzHgv
 UAW3F0sDP3mmeFdpCKjGZXxbuA3BPtoL/cq+AM9vz2yCI7qNKJ0yc8cJPKVGXiKsVJwVY9Eu4Dz
 G5lBUDoBrDwlxNLEtv84F3ZpVhq4Vu9biQPahMAzkG9UZl9nP5Vpl0iS36w5s556wfz2iO7Lx7C
 v
X-Received: by 2002:a05:6a20:7350:b0:3c3:f371:1ea9 with SMTP id
 adf61e73a8af0-3cb85df12fbmr40517775637.10.1786288646865; Sun, 09 Aug 2026
 08:17:26 -0700 (PDT)
MIME-Version: 1.0
From: youness hfa <hfa.youness@gmail.com>
Date: Sun, 9 Aug 2026 16:17:13 +0100
X-Gm-Features: AUfX_myogMOCmS1b6m9PddgO4WZiy4uo_IzQNMDkRX0WBVBCgGM_KTEsVSmp7iI
Message-ID: <CAP7KL_8Q-R38p5XxE1_DEGk1P5kW3vHvm8czAiMnPFRuq=f0og@mail.gmail.com>
Subject: [SECURITY] drm/vmwgfx: unprivileged OOB read in vmw_kms_cursor_snoop
 via unbounded guest.pitch
To: security@kernel.org
Cc: "zack.rusin@broadcom.com" <zack.rusin@broadcom.com>,
 linux-graphics-maintainer@vmware.com, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000043475906589ebc12"
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

--00000000000043475906589ebc12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm reporting an out-of-bounds read in the vmwgfx cursor-snoop path that is
reachable by any local unprivileged user via the DRM render node
(/dev/dri/renderD128, mode 0666 on stock installs). It reliably faults the
kernel (oops; a full panic when panic_on_oops=3D1, which is the default on
RHEL and derivatives). It is present in current mainline (torvalds/master,
HEAD b643e495ae92 as of 2026-08-09) and in all shipping stable/distro
kernels I checked.

I tell This is an incomplete-fix variant of CVE-2022-36280. Commit
4cf949c7fafe ("drm/vmwgfx: Validate the box size for the snooped cursor")
bounded the copybox width/height (the destination side), but left
cmd->dma.guest.pitch (the source-side stride) unbounded.

This report is not public. I'm happy to follow the kernel security process
and can provide the full PoC source on request.

*Affected code*

drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c : vmw_kms_cursor_snoop()
(historically drivers/gpu/drm/vmwgfx/vmwgfx_kms.c)

The source buffer is kmapped for a FIXED number of pages sized to the
snooped cursor (64 * image_pitch =3D 4 pages):

    kmap_num =3D (VMW_CURSOR_SNOOP_HEIGHT * image_pitch) >> PAGE_SHIFT;

    ...

    ret =3D ttm_bo_kmap(bo, kmap_offset, kmap_num, &map);

    virtual =3D ttm_kmap_obj_virtual(&map, &is_iomem);



but the slow-path copy reads at an attacker-controlled stride,

cmd->dma.guest.pitch, with no bound:

    if (box->w =3D=3D VMW_CURSOR_SNOOP_WIDTH && cmd->dma.guest.pitch =3D=3D
image_pitch) {

        memcpy(srf->snooper.image, virtual, VMW_CURSOR_SNOOP_HEIGHT *
image_pitch);

    } else {

        for (i =3D 0; i < box->h; i++)                    /* box->h <=3D 64=
 */

            memcpy(srf->snooper.image + i * image_pitch,

                   virtual + i * cmd->dma.guest.pitch,   /* guest.pitch
UNBOUNDED */

                   box->w * desc->pitchBytesPerBlock);

    }



The validation block above this checks the box geometry (x/y/z,
srcx/srcy/srcz, d, box_count, w <=3D 64, h <=3D 64) and the guest offset
alignment, but never checks guest.pitch.

The equality test on the fast/slow branch (guest.pitch =3D=3D image_pitch) =
only
*selects* the code path; a mismatching pitch falls straight into the
unbounded slow path. With, e.g., guest.pitch =3D 0x10000000 and box->h =3D =
64,
iteration i=3D1 already reads 256 MB past the 4-page source mapping.

*Reachability (unprivileged, default config)*

=C2=B7         /dev/dri/renderD128 is world-accessible (0666) on stock syst=
emd
installs.

=C2=B7         The trigger ioctls are all DRM_RENDER_ALLOW:

o   DRM_VMW_ALLOC_DMABUF   (source bo)

o   DRM_VMW_CREATE_SURFACE (allocates srf->snooper.image for a 64x64
A8R8G8B8 scanout surface via vmw_cursor_snooper_create)

o   DRM_VMW_EXECBUF        (carries SVGA3dCmdSurfaceDMA ->  vmw_cmd_dma()
-> vmw_kms_cursor_snoop())

=C2=B7         No capabilities, user namespaces, or races are required.

=C2=B7          Affects any Linux guest running vmwgfx (VMware and VirtualB=
ox
VMSVGA).

*Impact*

Reliable unprivileged local denial of service. The OOB read faults on
unmapped memory and oopses the kernel; with panic_on_oops=3D1 (default on
RHEL/derivatives and common on hardened/server configs) it is a full kernel
panic / machine-down.

Escalation assessment (for completeness): there is no OOB *write* here =E2=
=80=93
the destination srf->snooper.image is bounded by the already-validated
box->w/h.

The snooped buffer is only forwarded to the hypervisor host on a subsequent
DRM-master cursor-plane update (vmw_cursor_plane_update_legacy ->
vmw_send_define_cursor_cmd), so an unprivileged process cannot read the
leaked bytes back.

A carefully tuned, non-faulting read could constitute a limited guest->host
kernel-memory disclosure if a privileged cursor update later occurs, but
the reliable, demonstrated outcome is the DoS.

*Reproduction*

Confirmed three ways:

=C2=B7         source analysis;

=C2=B7         a KASAN QEMU lab (qemu -vga vmware);

=C2=B7         a stock CentOS Stream 9 guest (kernel 5.14.0-731.el9) under
VirtualBox, run as an ordinary uid=3D1000 user.

Unprivileged PoC:

1.      fd =3D open("/dev/dri/renderD128", O_RDWR)

2.      DRM_VMW_CREATE_SURFACE: scanout=3D1, 1 mip level, size 64x64x1,
format SVGA3D_A8R8G8B8            -> allocates srf->snooper.image

3.      DRM_VMW_ALLOC_DMABUF: size >=3D 4 pages   -> source bo (handle H)

4.      DRM_VMW_EXECBUF, one SVGA3dCmdSurfaceDMA (SVGA_3D_CMD_SURFACE_DMA):

       host  =3D { sid =3D surface, face =3D 0, mipmap =3D 0 }

       guest =3D { ptr =3D { gmrId =3D H, offset =3D 0 }, pitch =3D 0x10000=
000 }

       one SVGA3dCopyBox { w =3D 64, h =3D 64, d =3D 1, all others 0 }

       + SVGA3dCmdSurfaceDMASuffix { suffixSize =3D 12, ... }



Observed oops (stock 5.14.0-731.el9, uid 1000, VirtualBox VMSVGA):

  BUG: unable to handle page fault for address: ffffd1a050a13000

  #PF: supervisor read access in kernel mode

  CPU: 0 PID: 3750 Comm: vmwpoc  5.14.0-731.el9.x86_64

  RIP: 0010:memcpy+0x12/0x20

  RSI: ffffd1a050a13000  RBP: ffffd1a040a13000    (RSI - RBP =3D 0x10000000=
 =3D
i*guest.pitch)

  Call Trace:

   vmw_kms_cursor_snoop+0x174/0x2c0 [vmwgfx]

   vmw_cmd_dma+0xdf/0x170 [vmwgfx]

   vmw_cmd_check+0xb1/0x240 [vmwgfx]

   vmw_execbuf_process+0x4eb/0xdd0 [vmwgfx]

   vmw_execbuf_ioctl+0xf4/0x170 [vmwgfx]

   drm_ioctl_kernel / drm_ioctl / __x64_sys_ioctl / do_syscall_64



*Reporter*

Youness HFA from AGBS Pentest Team <hfa.youness@gmail.com>

Happy to coordinate disclosure timing and CVE assignment per your process.

--00000000000043475906589ebc12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"MsoNormal" style=3D"margin:0in 0in 8pt;line-he=
ight:115%;font-family:Aptos,sans-serif">Hello,</p><p class=3D"MsoNormal" st=
yle=3D"margin:0in 0in 6pt;text-align:justify;line-height:115%;font-family:A=
ptos,sans-serif">I&#39;m reporting
an out-of-bounds read in the vmwgfx cursor-snoop path that is reachable by =
any
local unprivileged user via the DRM render node (/dev/dri/renderD128, mode =
0666
on stock installs). It reliably faults the kernel (oops; a full panic when
panic_on_oops=3D1, which is the default on RHEL and derivatives). It is pre=
sent
in current mainline (torvalds/master, HEAD b643e495ae92 as of 2026-08-09) a=
nd
in all shipping stable/distro kernels I checked.</p><p class=3D"MsoNormal" =
style=3D"margin:0in 0in 6pt;text-align:justify;line-height:115%;font-family=
:Aptos,sans-serif">I tell This
is an incomplete-fix variant of CVE-2022-36280. Commit 4cf949c7fafe (&quot;=
drm/vmwgfx:
Validate the box size for the snooped cursor&quot;) bounded the copybox wid=
th/height
(the destination side), but left cmd-&gt;dma.guest.pitch (the source-side
stride) unbounded.</p><p class=3D"MsoNormal" style=3D"margin:0in 0in 6pt;te=
xt-align:justify;line-height:115%;font-family:Aptos,sans-serif">This report
is not public. I&#39;m happy to follow the kernel security process and can =
provide
the full PoC source on request.</p><p class=3D"MsoNormal" style=3D"text-ali=
gn:justify;margin:0in 0in 8pt;line-height:115%;font-family:Aptos,sans-serif=
"><b><u>Affected code</u></b></p><p class=3D"MsoNormal" style=3D"margin:0in=
 0in 6pt;text-align:justify;line-height:115%;font-family:Aptos,sans-serif">=
drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
: vmw_kms_cursor_snoop() (historically drivers/gpu/drm/vmwgfx/vmwgfx_kms.c)=
</p><p class=3D"MsoNormal" style=3D"margin:0in 0in 6pt;text-align:justify;l=
ine-height:115%;font-family:Aptos,sans-serif">The source
buffer is kmapped for a FIXED number of pages sized to the snooped cursor (=
64 *
image_pitch =3D 4 pages):</p><p class=3D"MsoNormal" style=3D"margin:0in;bac=
kground:rgb(166,166,166);line-height:115%;font-family:Aptos,sans-serif"><sp=
an style=3D"color:black">=C2=A0=C2=A0=C2=A0 kmap_num =3D
(VMW_CURSOR_SNOOP_HEIGHT * image_pitch) &gt;&gt; PAGE_SHIFT;</span></p><p c=
lass=3D"MsoNormal" style=3D"margin:0in;background:rgb(166,166,166);line-hei=
ght:115%;font-family:Aptos,sans-serif"><span style=3D"color:black">=C2=A0=
=C2=A0=C2=A0 ...</span></p><p class=3D"MsoNormal" style=3D"margin:0in;backg=
round:rgb(166,166,166);line-height:115%;font-family:Aptos,sans-serif"><span=
 style=3D"color:black">=C2=A0=C2=A0=C2=A0 ret =3D ttm_bo_kmap(bo,
kmap_offset, kmap_num, &amp;map);</span></p><p class=3D"MsoNormal" style=3D=
"margin:0in;background:rgb(166,166,166);line-height:115%;font-family:Aptos,=
sans-serif"><span style=3D"color:black">=C2=A0=C2=A0=C2=A0 virtual =3D
ttm_kmap_obj_virtual(&amp;map, &amp;is_iomem);</span></p><p class=3D"MsoNor=
mal" style=3D"margin:0in;line-height:115%;font-family:Aptos,sans-serif">=C2=
=A0</p><p class=3D"MsoNormal" style=3D"margin:0in 0in 6pt;line-height:115%;=
font-family:Aptos,sans-serif">but the slow-path copy reads at
an attacker-controlled stride,</p><p class=3D"MsoNormal" style=3D"margin:0i=
n 0in 6pt;line-height:115%;font-family:Aptos,sans-serif">cmd-&gt;dma.guest.=
pitch, with no
bound:</p><p class=3D"MsoNormal" style=3D"margin:0in;background:rgb(166,166=
,166);line-height:115%;font-family:Aptos,sans-serif"><span style=3D"color:b=
lack">=C2=A0=C2=A0=C2=A0 if (box-&gt;w =3D=3D
VMW_CURSOR_SNOOP_WIDTH &amp;&amp; cmd-&gt;dma.guest.pitch =3D=3D image_pitc=
h) {</span></p><p class=3D"MsoNormal" style=3D"margin:0in;background:rgb(16=
6,166,166);line-height:115%;font-family:Aptos,sans-serif"><span style=3D"co=
lor:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
memcpy(srf-&gt;snooper.image, virtual, VMW_CURSOR_SNOOP_HEIGHT *
image_pitch);</span></p><p class=3D"MsoNormal" style=3D"margin:0in;backgrou=
nd:rgb(166,166,166);line-height:115%;font-family:Aptos,sans-serif"><span st=
yle=3D"color:black">=C2=A0=C2=A0=C2=A0 } else {</span></p><p class=3D"MsoNo=
rmal" style=3D"margin:0in;background:rgb(166,166,166);line-height:115%;font=
-family:Aptos,sans-serif"><span style=3D"color:black">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i &lt;
box-&gt;h; i++)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
box-&gt;h &lt;=3D 64 */</span></p><p class=3D"MsoNormal" style=3D"margin:0i=
n;background:rgb(166,166,166);line-height:115%;font-family:Aptos,sans-serif=
"><span style=3D"color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0
memcpy(srf-&gt;snooper.image + i * image_pitch,</span></p><p class=3D"MsoNo=
rmal" style=3D"margin:0in;background:rgb(166,166,166);line-height:115%;font=
-family:Aptos,sans-serif"><span style=3D"color:black">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 virtual +
i * cmd-&gt;dma.guest.pitch,=C2=A0=C2=A0 /*
guest.pitch UNBOUNDED */</span></p><p class=3D"MsoNormal" style=3D"margin:0=
in;background:rgb(166,166,166);line-height:115%;font-family:Aptos,sans-seri=
f"><span style=3D"color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 box-&gt;=
w
* desc-&gt;pitchBytesPerBlock);</span></p><p class=3D"MsoNormal" style=3D"m=
argin:0in;background:rgb(166,166,166);line-height:115%;font-family:Aptos,sa=
ns-serif"><span style=3D"color:black">=C2=A0=C2=A0=C2=A0 }</span></p><p cla=
ss=3D"MsoNormal" style=3D"margin:0in 0in 8pt;line-height:115%;font-family:A=
ptos,sans-serif">=C2=A0</p><p class=3D"MsoNormal" style=3D"text-align:justi=
fy;margin:0in 0in 8pt;line-height:115%;font-family:Aptos,sans-serif">The va=
lidation block above this
checks the box geometry (x/y/z, srcx/srcy/srcz, d, box_count, w &lt;=3D 64,=
 h
&lt;=3D 64) and the guest offset alignment, but never checks guest.pitch.</=
p><p class=3D"MsoNormal" style=3D"text-align:justify;margin:0in 0in 8pt;lin=
e-height:115%;font-family:Aptos,sans-serif">The equality test on the
fast/slow branch (guest.pitch =3D=3D image_pitch) only *selects* the code p=
ath; a
mismatching pitch falls straight into the unbounded slow path. With, e.g.,
guest.pitch =3D 0x10000000 and box-&gt;h =3D 64, iteration i=3D1 already re=
ads 256 MB
past the 4-page source mapping.</p><p class=3D"MsoNormal" style=3D"margin:0=
in 0in 8pt;line-height:115%;font-family:Aptos,sans-serif"><b><u>Reachabilit=
y (unprivileged, default config)</u></b></p><p class=3D"gmail-MsoListParagr=
aphCxSpFirst" style=3D"margin:0in 0in 6pt 0.5in;line-height:115%;font-famil=
y:Aptos,sans-serif"><span style=3D"font-family:Symbol">=C2=B7<span style=3D=
"font-style:normal;font-variant:normal;font-size-adjust:none;font-kerning:a=
uto;font-feature-settings:normal;font-stretch:normal;line-height:normal;fon=
t-family:&quot;Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
</span></span>/dev/dri/renderD128 is world-accessible (0666)
on stock systemd installs.</p><p class=3D"gmail-MsoListParagraphCxSpMiddle"=
 style=3D"margin:0in 0in 6pt 0.5in;line-height:115%;font-family:Aptos,sans-=
serif"><span style=3D"font-family:Symbol">=C2=B7<span style=3D"font-style:n=
ormal;font-variant:normal;font-size-adjust:none;font-kerning:auto;font-feat=
ure-settings:normal;font-stretch:normal;line-height:normal;font-family:&quo=
t;Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span></span>The trigger ioctls are all DRM_RENDER_ALLOW:</p><p class=3D"g=
mail-MsoListParagraphCxSpMiddle" style=3D"margin:0in 0in 6pt 1in;line-heigh=
t:115%;font-family:Aptos,sans-serif"><span style=3D"font-family:&quot;Couri=
er New&quot;">o<span style=3D"font-style:normal;font-variant:normal;font-si=
ze-adjust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:=
normal;line-height:normal;font-family:&quot;Times New Roman&quot;">=C2=A0=
=C2=A0 </span></span>DRM_VMW_ALLOC_DMABUF=C2=A0=C2=A0 (source bo)</p><p cla=
ss=3D"gmail-MsoListParagraphCxSpMiddle" style=3D"margin:0in 0in 6pt 1in;lin=
e-height:115%;font-family:Aptos,sans-serif"><span style=3D"font-family:&quo=
t;Courier New&quot;">o<span style=3D"font-style:normal;font-variant:normal;=
font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;font-s=
tretch:normal;line-height:normal;font-family:&quot;Times New Roman&quot;">=
=C2=A0=C2=A0 </span></span>DRM_VMW_CREATE_SURFACE
(allocates srf-&gt;snooper.image for a 64x64 A8R8G8B8 scanout surface via
vmw_cursor_snooper_create)</p><p class=3D"gmail-MsoListParagraphCxSpMiddle"=
 style=3D"margin:0in 0in 6pt 1in;line-height:115%;font-family:Aptos,sans-se=
rif"><span style=3D"font-family:&quot;Courier New&quot;">o<span style=3D"fo=
nt-style:normal;font-variant:normal;font-size-adjust:none;font-kerning:auto=
;font-feature-settings:normal;font-stretch:normal;line-height:normal;font-f=
amily:&quot;Times New Roman&quot;">=C2=A0=C2=A0 </span></span>DRM_VMW_EXECB=
UF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (carries SVGA3dCmdSurfaceDMA -=
&gt;=C2=A0 vmw_cmd_dma() -&gt; vmw_kms_cursor_snoop())</p><p class=3D"gmail=
-MsoListParagraphCxSpMiddle" style=3D"margin:0in 0in 6pt 0.5in;line-height:=
115%;font-family:Aptos,sans-serif"><span style=3D"font-family:Symbol">=C2=
=B7<span style=3D"font-style:normal;font-variant:normal;font-size-adjust:no=
ne;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;line-=
height:normal;font-family:&quot;Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span></span>No capabilities, user namespaces, or races are
required.</p><p class=3D"gmail-MsoListParagraphCxSpLast" style=3D"margin:0i=
n 0in 6pt 0.5in;line-height:115%;font-family:Aptos,sans-serif"><span style=
=3D"font-family:Symbol">=C2=B7<span style=3D"font-style:normal;font-variant=
:normal;font-size-adjust:none;font-kerning:auto;font-feature-settings:norma=
l;font-stretch:normal;line-height:normal;font-family:&quot;Times New Roman&=
quot;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span></span>=C2=A0Affects
any Linux guest running vmwgfx (VMware and VirtualBox VMSVGA).</p><p class=
=3D"MsoNormal" style=3D"margin:0in 0in 8pt;line-height:115%;font-family:Apt=
os,sans-serif"><b><u>Impact</u></b></p><p class=3D"MsoNormal" style=3D"marg=
in:0in 0in 6pt;text-align:justify;line-height:115%;font-family:Aptos,sans-s=
erif">Reliable
unprivileged local denial of service. The OOB read faults on unmapped memor=
y
and oopses the kernel; with panic_on_oops=3D1 (default on RHEL/derivatives =
and
common on hardened/server configs) it is a full kernel panic / machine-down=
.</p><p class=3D"MsoNormal" style=3D"margin:0in 0in 6pt;text-align:justify;=
line-height:115%;font-family:Aptos,sans-serif">Escalation
assessment (for completeness): there is no OOB *write* here =E2=80=93 the d=
estination srf-&gt;snooper.image
is bounded by the already-validated box-&gt;w/h.</p><p class=3D"MsoNormal" =
style=3D"margin:0in 0in 6pt;text-align:justify;line-height:115%;font-family=
:Aptos,sans-serif">The snooped
buffer is only forwarded to the hypervisor host on a subsequent DRM-master
cursor-plane update (vmw_cursor_plane_update_legacy -&gt; vmw_send_define_c=
ursor_cmd),
so an unprivileged process cannot read the leaked bytes back. </p><p class=
=3D"MsoNormal" style=3D"margin:0in 0in 6pt;text-align:justify;line-height:1=
15%;font-family:Aptos,sans-serif">A carefully
tuned, non-faulting read could constitute a limited guest-&gt;host
kernel-memory disclosure if a privileged cursor update later occurs, but th=
e
reliable, demonstrated outcome is the DoS.</p><p class=3D"MsoNormal" style=
=3D"margin:0in 0in 8pt;line-height:115%;font-family:Aptos,sans-serif"><b><u=
>Reproduction</u></b></p><p class=3D"MsoNormal" style=3D"margin:0in 0in 8pt=
;line-height:115%;font-family:Aptos,sans-serif">Confirmed three ways: <b><u=
></u></b></p><p class=3D"gmail-MsoListParagraphCxSpFirst" style=3D"margin:0=
in 0in 6pt 0.5in;text-align:justify;line-height:115%;font-family:Aptos,sans=
-serif"><span style=3D"font-family:Symbol">=C2=B7<span style=3D"font-style:=
normal;font-variant:normal;font-size-adjust:none;font-kerning:auto;font-fea=
ture-settings:normal;font-stretch:normal;line-height:normal;font-family:&qu=
ot;Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span></span>source analysis; </p><p class=3D"gmail-MsoListParagraphCxSpMi=
ddle" style=3D"margin:0in 0in 6pt 0.5in;text-align:justify;line-height:115%=
;font-family:Aptos,sans-serif"><span style=3D"font-family:Symbol">=C2=B7<sp=
an style=3D"font-style:normal;font-variant:normal;font-size-adjust:none;fon=
t-kerning:auto;font-feature-settings:normal;font-stretch:normal;line-height=
:normal;font-family:&quot;Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
</span></span>a KASAN QEMU lab (qemu -vga vmware);</p><p class=3D"gmail-Mso=
ListParagraphCxSpLast" style=3D"margin:0in 0in 6pt 0.5in;text-align:justify=
;line-height:115%;font-family:Aptos,sans-serif"><span style=3D"font-family:=
Symbol">=C2=B7<span style=3D"font-style:normal;font-variant:normal;font-siz=
e-adjust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:n=
ormal;line-height:normal;font-family:&quot;Times New Roman&quot;">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span></span>a stock CentOS Stream 9 guest (kernel
5.14.0-731.el9) under VirtualBox, run as an ordinary uid=3D1000 user.</p><p=
 class=3D"MsoNormal" style=3D"margin:0in 0in 6pt;text-align:justify;line-he=
ight:115%;font-family:Aptos,sans-serif">Unprivileged
PoC:</p><p class=3D"gmail-MsoListParagraphCxSpFirst" style=3D"margin:0in 0i=
n 6pt 0.5in;text-align:justify;line-height:115%;font-family:Aptos,sans-seri=
f">1.<span style=3D"font-style:normal;font-variant:normal;font-size-adjust:=
none;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;lin=
e-height:normal;font-family:&quot;Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
</span>fd =3D open(&quot;/dev/dri/renderD128&quot;,
O_RDWR)</p><p class=3D"gmail-MsoListParagraphCxSpMiddle" style=3D"margin:0i=
n 0in 6pt 0.5in;text-align:justify;line-height:115%;font-family:Aptos,sans-=
serif">2.<span style=3D"font-style:normal;font-variant:normal;font-size-adj=
ust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:normal=
;line-height:normal;font-family:&quot;Times New Roman&quot;">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
</span>DRM_VMW_CREATE_SURFACE: scanout=3D1, 1 mip level,
size 64x64x1, format SVGA3D_A8R8G8B8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
-&gt; allocates srf-&gt;snooper.image</p><p class=3D"gmail-MsoListParagraph=
CxSpMiddle" style=3D"margin:0in 0in 6pt 0.5in;text-align:justify;line-heigh=
t:115%;font-family:Aptos,sans-serif">3.<span style=3D"font-style:normal;fon=
t-variant:normal;font-size-adjust:none;font-kerning:auto;font-feature-setti=
ngs:normal;font-stretch:normal;line-height:normal;font-family:&quot;Times N=
ew Roman&quot;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span>DRM_VMW_ALLOC_DMABUF: size &gt;=3D 4 pages=C2=A0=C2=A0 -&gt; source =
bo (handle H)</p><p class=3D"gmail-MsoListParagraphCxSpLast" style=3D"margi=
n:0in 0in 6pt 0.5in;text-align:justify;line-height:115%;font-family:Aptos,s=
ans-serif">4.<span style=3D"font-style:normal;font-variant:normal;font-size=
-adjust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:no=
rmal;line-height:normal;font-family:&quot;Times New Roman&quot;">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0
</span>DRM_VMW_EXECBUF, one SVGA3dCmdSurfaceDMA
(SVGA_3D_CMD_SURFACE_DMA):</p><p class=3D"MsoNormal" style=3D"margin:0in 0i=
n 6pt;text-align:justify;line-height:115%;font-family:Aptos,sans-serif">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host=C2=A0
=3D { sid =3D surface, face =3D 0, mipmap =3D 0 }</p><p class=3D"MsoNormal"=
 style=3D"margin:0in 0in 6pt;text-align:justify;line-height:115%;font-famil=
y:Aptos,sans-serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guest =3D { ptr =
=3D { gmrId =3D H, offset =3D 0
}, pitch =3D 0x10000000 }</p><p class=3D"MsoNormal" style=3D"margin:0in 0in=
 6pt;text-align:justify;line-height:115%;font-family:Aptos,sans-serif">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 one SVGA3dCopyBox { w =3D 64, h =3D 64, d=
 =3D
1, all others 0 }</p><p class=3D"MsoNormal" style=3D"margin:0in 0in 6pt;tex=
t-align:justify;line-height:115%;font-family:Aptos,sans-serif">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 + SVGA3dCmdSurfaceDMASuffix { suffixSize
=3D 12, ... }</p><p class=3D"MsoNormal" style=3D"margin:0in 0in 6pt;text-al=
ign:justify;line-height:115%;font-family:Aptos,sans-serif">=C2=A0</p><p cla=
ss=3D"MsoNormal" style=3D"margin:0in 0in 6pt;text-align:justify;line-height=
:115%;font-family:Aptos,sans-serif">Observed oops
(stock 5.14.0-731.el9, uid 1000, VirtualBox VMSVGA):</p><p class=3D"MsoNorm=
al" style=3D"margin:0in;text-align:justify;background:rgb(166,166,166);line=
-height:115%;font-family:Aptos,sans-serif"><span style=3D"color:black">=C2=
=A0
BUG: unable to handle page fault for address: ffffd1a050a13000</span></p><p=
 class=3D"MsoNormal" style=3D"margin:0in;text-align:justify;background:rgb(=
166,166,166);line-height:115%;font-family:Aptos,sans-serif"><span style=3D"=
color:black">=C2=A0
#PF: supervisor read access in kernel mode</span></p><p class=3D"MsoNormal"=
 style=3D"margin:0in;text-align:justify;background:rgb(166,166,166);line-he=
ight:115%;font-family:Aptos,sans-serif"><span style=3D"color:black">=C2=A0
CPU: 0 PID: 3750 Comm: vmwpoc=C2=A0
5.14.0-731.el9.x86_64</span></p><p class=3D"MsoNormal" style=3D"margin:0in;=
text-align:justify;background:rgb(166,166,166);line-height:115%;font-family=
:Aptos,sans-serif"><span style=3D"color:black">=C2=A0
RIP: 0010:memcpy+0x12/0x20</span></p><p class=3D"MsoNormal" style=3D"margin=
:0in;text-align:justify;background:rgb(166,166,166);line-height:115%;font-f=
amily:Aptos,sans-serif"><span style=3D"color:black">=C2=A0
RSI: ffffd1a050a13000=C2=A0 RBP:
ffffd1a040a13000=C2=A0=C2=A0=C2=A0 (RSI - RBP =3D
0x10000000 =3D i*guest.pitch)</span></p><p class=3D"MsoNormal" style=3D"mar=
gin:0in;text-align:justify;background:rgb(166,166,166);line-height:115%;fon=
t-family:Aptos,sans-serif"><span style=3D"color:black">=C2=A0
Call Trace:</span></p><p class=3D"MsoNormal" style=3D"margin:0in;text-align=
:justify;background:rgb(166,166,166);line-height:115%;font-family:Aptos,san=
s-serif"><span style=3D"color:black">=C2=A0=C2=A0
vmw_kms_cursor_snoop+0x174/0x2c0 [vmwgfx]</span></p><p class=3D"MsoNormal" =
style=3D"margin:0in;text-align:justify;background:rgb(166,166,166);line-hei=
ght:115%;font-family:Aptos,sans-serif"><span style=3D"color:black">=C2=A0=
=C2=A0
vmw_cmd_dma+0xdf/0x170 [vmwgfx]</span></p><p class=3D"MsoNormal" style=3D"m=
argin:0in;text-align:justify;background:rgb(166,166,166);line-height:115%;f=
ont-family:Aptos,sans-serif"><span style=3D"color:black">=C2=A0=C2=A0
vmw_cmd_check+0xb1/0x240 [vmwgfx]</span></p><p class=3D"MsoNormal" style=3D=
"margin:0in;text-align:justify;background:rgb(166,166,166);line-height:115%=
;font-family:Aptos,sans-serif"><span style=3D"color:black">=C2=A0=C2=A0
vmw_execbuf_process+0x4eb/0xdd0 [vmwgfx]</span></p><p class=3D"MsoNormal" s=
tyle=3D"margin:0in;text-align:justify;background:rgb(166,166,166);line-heig=
ht:115%;font-family:Aptos,sans-serif"><span style=3D"color:black">=C2=A0=C2=
=A0
vmw_execbuf_ioctl+0xf4/0x170 [vmwgfx]</span></p><p class=3D"MsoNormal" styl=
e=3D"margin:0in;text-align:justify;background:rgb(166,166,166);line-height:=
115%;font-family:Aptos,sans-serif"><span style=3D"color:black">=C2=A0=C2=A0
drm_ioctl_kernel / drm_ioctl / __x64_sys_ioctl / do_syscall_64</span></p><p=
 class=3D"MsoNormal" style=3D"margin:0in 0in 8pt;line-height:115%;font-fami=
ly:Aptos,sans-serif">=C2=A0</p><p class=3D"MsoNormal" style=3D"margin:0in 0=
in 8pt;line-height:115%;font-family:Aptos,sans-serif"><b><u>Reporter</u></b=
></p><p class=3D"MsoNormal" style=3D"margin:0in 0in 8pt;line-height:115%;fo=
nt-family:Aptos,sans-serif">Youness HFA from AGBS Pentest Team
&lt;<a href=3D"mailto:hfa.youness@gmail.com">hfa.youness@gmail.com</a>&gt;<=
/p><p class=3D"MsoNormal" style=3D"margin:0in 0in 8pt;line-height:115%;font=
-family:Aptos,sans-serif">Happy to coordinate=C2=A0<span style=3D"backgroun=
d-color:transparent">disclosure timing and CVE assignment per your process.=
</span></p><p class=3D"MsoNormal" style=3D"margin:0in 0in 8pt;line-height:1=
15%">















































































































































</p><p class=3D"MsoNormal" style=3D"margin:0in 0in 8pt;line-height:115%;fon=
t-family:Aptos,sans-serif">=C2=A0<br></p></div>

--00000000000043475906589ebc12--
