Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0953C54FCD
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D2410E2A0;
	Sat,  1 Aug 2026 07:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=choiharam.com header.i=@choiharam.com header.b="m9YrIdPq";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="SQKPdkbO";
	dkim-atps=neutral
X-Greylist: delayed 536 seconds by postgrey-1.36 at gabe;
 Fri, 31 Jul 2026 23:06:21 UTC
Received: from a6-247.smtp-out.eu-west-1.amazonses.com
 (a6-247.smtp-out.eu-west-1.amazonses.com [54.240.6.247])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE0110E23F
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 23:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
 d=choiharam.com; t=1785538644;
 h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type;
 bh=Lc3rIjAAFzIvGt9WsHawxcDTOpbs6Y5hCWwvYz32lnE=;
 b=m9YrIdPqL4EikU8yFmPLPFUDwloarmIsV75f+CdRQFMMUDEi3pPLVS8xyz68ia45
 +FNBwc6SYWy24HusJkJ+CB7XLJvunwiRY9iivJZZNgAzUrIwi6JnVBBQ+mErSDcaKYC
 Z7U52tKYboVUKVNXbk8MhI/+n+2OdmfvbO8sSd3g=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1785538644;
 h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type:Feedback-ID;
 bh=Lc3rIjAAFzIvGt9WsHawxcDTOpbs6Y5hCWwvYz32lnE=;
 b=SQKPdkbO2xsYxXgilLhXKLOrJBcMMXSEwJ9klkoFbR4N1/eeuwIx7hQ/xUpXzs/f
 CCIJqqcXWYyhL5lhla+HRFaz5uY3WzcjH9IjoHQZox+/aRuTHdTKjy020EntCpv6kNb
 bwJ7D+8vIIA8Z399D9QzfE0tthud0fGg5Kl86zao=
X-Forwarded-Encrypted: i=1;
 AHgh+RrO1KZgjOgZtStE4XgJ6s35vyp0eHjsloQKoBLzOiZKOlhlNvaomzVDxDsbkdn5YmRY9S8XKRgb7yI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRCG8IqEaNXwunY8gTVv8T0OQ3iMIiNtlZMe/grwz7BWW4tVRZ
 C562ix1vMMikmx6NkYjp1flIFaxu1tKFlaN/KSQ/MtexohEdEbKdHpR5JO8rdbZL0jFZ/H15qMO
 Q5Gadm0LuA4/tQZSKYzSLx03PQrR6sVs=
X-Received: by 2002:a5d:5917:0:b0:47f:6fbd:89eb with SMTP id
 ffacd0b85a97d-47fd73157camr1920700f8f.57.1785538642220; Fri, 31 Jul 2026
 15:57:22 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAAKWd2_J=V2U-2m1Nuie8MbT7eu1HSLjkWr4Ljh4LksvoB46qQ@mail.gmail.com>
X-Gm-Features: AUfX_mwG4SQqZGV7ftVTbzZA8LqMmDTmhOrQewKnDznaL_jWeAowMP4uJ_wmy3c
From: Haram Choi <haram@choiharam.com>
To: dri-devel@lists.freedesktop.org
Subject: [REGRESSION] 7.1: apple-gmux backlight dead on MacBookPro13,3 -
 PCI bridge left with VGA enable set and VGA 16-bit decode cleared,
 aliasing legacy VGA I/O over the gmux ports
Message-ID: <0102019fba65882f-45046e0b-9860-445f-a179-c6a1d2acfd1c-000000@eu-west-1.amazonses.com>
Date: Fri, 31 Jul 2026 22:57:24 +0000
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="--_NmP-27909390cd5e0791-Part_1"
Feedback-ID: :1.eu-west-1.EpC9yjino5Os4TD+7+raLa11nzZLZvHiwV019QcZvg/F5tRE61/OoDvSLCzTswf7FgUYGClMifYLSHlPtef6pX2oIiUiWIw7D3iBfeLsACYDdVP2XYMjQqpq9pquO8y/Ll8CCsU3paAfc5BSRIugOpXQgvi1qP9naMr/nZxXEn4=:1.eu-west-1.mn4CV6NdxyxonKM+/Hjvd874GJxbRQyaS3Zo0NapPlc=:AmazonSES
X-SES-Outgoing: 2026.07.31-54.240.6.247
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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

----_NmP-27909390cd5e0791-Part_1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

# [REGRESSION] 7.1: apple-gmux backlight dead on MacBookPro13,3 - PCI
bridge left with VGA enable set and VGA 16-bit decode cleared, aliasing
legacy VGA I/O over the gmux ports

## Summary

Since Linux 7.1 the backlight on a MacBookPro13,3 (15" 2016, Touch Bar)
cannot be controlled at all. `apple_gmux` still probes successfully during
boot, but a few hundred milliseconds later the VGA arbiter reprograms
`PCI_BRIDGE_CONTROL` of the root port `00:01.0` into a state where the
bridge decodes legacy VGA I/O with only 10 address bits. `0x3c0-0x3df` then
aliases onto `0x7c0-0x7df`, which is exactly where the gmux "indexed"
protocol registers live, so the bridge claims those cycles and forwards
them to the dGPU. Every gmux read returns `0xff` and every gmux write is
swallowed.

- Last known good: 6.16.10 (Arch `linux` 6.16.10.arch1-1)
- Also good: 6.12.51 (Arch `linux-lts` 6.12.51-1)
- Bad: 7.1.5 (Arch `linux` 7.1.5.arch1-2)

## Hardware

```
DMI: Apple Inc. MacBookPro13,3/Mac-A5C67F76ED83108C, BIOS 529.120.1.0.0
03/14/2024

00:01.0 PCI bridge [0604]: Intel 6th-10th Gen Core Processor PCIe
Controller (x16) [8086:1901] (rev 07)
00:02.0 VGA compatible controller [0300]: Intel Skylake-H GT2 [HD Graphics
530] [8086:191b] (rev 06)   -> i915
01:00.0 VGA compatible controller [0300]: AMD Baffin [Radeon Pro 455]
[1002:67ef] (rev c7)             -> amdgpu

gmux: PNP HID APP000B, "Found gmux version 4.0.29 [indexed]"
```

## Symptom

```
$ cat /sys/class/backlight/gmux_backlight/actual_brightness
16777215
```

16777215 is `0x00ffffff`, which is `GMUX_BRIGHTNESS_MASK` applied to an
all-ones I/O read. Writes to `brightness` have no effect. `brightnessctl`,
the Touch Bar brightness keys and the desktop brightness slider all fail,
because all three go through this single backlight device.

## Root cause

`PCI_BRIDGE_CONTROL` (offset 0x3e) of `00:01.0`, read after boot has
settled:

```
6.12.51-lts   : 0x0012   bit1 SERR, bit4 VGA_16BIT set, bit3 VGA enable
clear   -> works
6.16.10-arch1 : (not read at register level, but backlight works)
7.1.5-arch1-2 : 0x000a   bit1 SERR, bit3 VGA enable set, bit4 VGA_16BIT
clear   -> broken
```

With `PCI_BRIDGE_CTL_VGA` set and `PCI_BRIDGE_CTL_VGA_16BIT` clear, the
bridge ignores address bits [15:10] for legacy VGA I/O, so the ranges alias:

```
0x3b0-0x3bb  ->  0x7b0-0x7bb
0x3c0-0x3df  ->  0x7c0-0x7df
```

apple-gmux uses the following ports on this machine (PNP resource
`0x700-0x7fe`):

```
GMUX_PORT_READ         0x7d0
GMUX_PORT_WRITE        0x7d4
index magic sequence   0x7cc / 0x7cd / 0x7ce
```

All of them fall inside the aliased window, so the bridge steals them.

## Direct verification via /dev/port on 7.1.5

Before:

```
inb(0x7cc) = ff   inb(0x7cd) = ff   inb(0x7ce) = ff
inb(0x7d0) = ff   inb(0x7d4) = ff
```

Set only the 16-bit decode bit, nothing else:

```
# setpci -s 00:01.0 BRIDGE_CONTROL=0010:0010
```

After (gmux_is_indexed() magic sequence, write 0xaa/0x55/0x00 then read
back):

```
outb(0x7cc, 0xaa); outb(0x7cd, 0x55); outb(0x7ce, 0x00)
inb(0x7cc) = aa   inb(0x7cd) = 55        -> gmux responds
```

Then:

```
# modprobe -r apple_gmux && modprobe apple_gmux
apple_gmux: Found gmux version 4.0.29 [indexed]

# cat /sys/class/backlight/gmux_backlight/actual_brightness
118
```

118 is the value the panel had actually been stuck at the whole time, which
confirms that no write had ever reached the hardware. Writing 100 / 400 /
700 / 1023 afterwards changes the panel brightness, visually confirmed.

## Boot timeline

7.1.5-arch1-2 (broken):

```
[  7.947] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[  7.947] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[  7.947] pci 0000:01:00.0: vgaarb: setting as boot VGA device (overriding
previous)
[  7.948] pci 0000:01:00.0: vgaarb: VGA device added:
decodes=io+mem,owns=none,locks=none
[  8.005] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
[  9.494] apple_gmux: Found gmux version 4.0.29 [indexed]          <--
probe still OK
[ 10.059] i915 0000:00:02.0: vgaarb: VGA decodes changed:
olddecodes=io+mem,decodes=io:owns=io+mem
[ 11.150] i915 0000:00:02.0: vgaarb: VGA decodes changed:
olddecodes=io,decodes=none:owns=io+mem
[ 11.150] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed:
olddecodes=io+mem,decodes=none:owns=none
```

6.16.10-arch1-1 (good):

```
[  6.785] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[  6.785] pci 0000:01:00.0: vgaarb: setting as boot VGA device (overriding
previous)
[  6.785] pci 0000:01:00.0: vgaarb: VGA device added:
decodes=io+mem,owns=none,locks=none
[  6.839] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
[  8.339] apple_gmux: Found gmux version 4.0.29 [indexed]
[  8.348] i915 0000:00:02.0: vgaarb: VGA decodes changed:
olddecodes=io+mem,decodes=none:owns=io+mem
[  8.349] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed:
olddecodes=io+mem,decodes=none:owns=none
```

6.12.51-lts (good):

```
[  8.480] apple_gmux: Found gmux version 4.0.29 [indexed]
[  8.487] i915 0000:00:02.0: vgaarb: VGA decodes changed:
olddecodes=io+mem,decodes=none:owns=io+mem
[  8.489] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed:
olddecodes=io+mem,decodes=none:owns=none
```

The relevant difference: on 6.12 and 6.16 the i915 legacy decode goes
`io+mem -> none` in a single step. On 7.1.5 it goes `io+mem -> io` and
then, about 1.1 seconds later, `io -> none`. The final arbiter state is
`decodes=none` for both devices on all three kernels, yet only on 7.1.5
does the bridge end up with `PCI_BRIDGE_CTL_VGA` set and
`PCI_BRIDGE_CTL_VGA_16BIT` cleared. The intermediate `decodes=io` state
appears to leave the bridge in the 10-bit aliasing configuration and the
subsequent transition to `none` does not undo it.

`drivers/platform/x86/apple-gmux.c` only received cosmetic changes during
the 7.1 cycle, so this looks like a PCI / vgaarb side change rather than a
driver bug.

## Workaround

```
# setpci -s 00:01.0 BRIDGE_CONTROL=0010:0010
# modprobe -r apple_gmux && modprobe apple_gmux
```

Setting the 16-bit decode bit is enough. This machine is KMS only and
`amdgpu: vgaarb: deactivate vga console` has already happened, so nothing
depends on 10-bit legacy VGA I/O aliasing here.

## Notes

- The breakage happens after `apple_gmux` has already probed, so the driver
reports no error. The failure is silent.
- A machine with a discrete GPU behind `00:01.0` and gmux at `0x700-0x7fe`
is the affected shape. MacBookPro13,1 and 13,2 have no dGPU and no bridge
in the path, so they are presumably unaffected.

#regzbot introduced: v6.16..v7.1

----_NmP-27909390cd5e0791-Part_1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"># [REGRESSION] 7.1: apple-gmux backlight dead on =
MacBookPro13,3 - PCI bridge left with VGA enable set and VGA 16-bit decode =
cleared, aliasing legacy VGA I/O over the gmux ports<br><br>## =
Summary<br><br>Since Linux 7.1 the backlight on a MacBookPro13,3 (15&quot; =
2016, Touch Bar) cannot be controlled at all. `apple_gmux` still probes =
successfully during boot, but a few hundred milliseconds later the VGA =
arbiter reprograms `PCI_BRIDGE_CONTROL` of the root port `00:01.0` into a =
state where the bridge decodes legacy VGA I/O with only 10 address bits. =
`0x3c0-0x3df` then aliases onto `0x7c0-0x7df`, which is exactly where the =
gmux &quot;indexed&quot; protocol registers live, so the bridge claims =
those cycles and forwards them to the dGPU. Every gmux read returns `0xff` =
and every gmux write is swallowed.<br><br>- Last known good: 6.16.10 (Arch =
`linux` 6.16.10.arch1-1)<br>- Also good: 6.12.51 (Arch `linux-lts` 6.12.=
51-1)<br>- Bad: 7.1.5 (Arch `linux` 7.1.5.arch1-2)<br><br>## =
Hardware<br><br>```<br>DMI: Apple Inc. MacBookPro13,3/Mac-A5C67F76ED83108C,=
 BIOS 529.120.1.0.0 03/14/2024<br><br>00:01.0 PCI bridge [0604]: Intel =
6th-10th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev =
07)<br>00:02.0 VGA compatible controller [0300]: Intel Skylake-H GT2 [HD =
Graphics 530] [8086:191b] (rev 06) =C2=A0 -&gt; i915<br>01:00.0 VGA =
compatible controller [0300]: AMD Baffin [Radeon Pro 455] [1002:67ef] (rev =
c7) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; amdgpu<br><br>gmux: PNP=
 HID APP000B, &quot;Found gmux version 4.0.29 [indexed]&quot;<br>```<br><br=
>## Symptom<br><br>```<br>$ cat /sys/class/backlight/gmux_backlight/actual_=
brightness<br>16777215<br>```<br><br>16777215 is `0x00ffffff`, which is =
`GMUX_BRIGHTNESS_MASK` applied to an all-ones I/O read. Writes to =
`brightness` have no effect. `brightnessctl`, the Touch Bar brightness keys=
 and the desktop brightness slider all fail, because all three go through =
this single backlight device.<br><br>## Root cause<br><br>`PCI_BRIDGE_CONTR=
OL` (offset 0x3e) of `00:01.0`, read after boot has =
settled:<br><br>```<br>6.12.51-lts =C2=A0 : 0x0012 =C2=A0 bit1 SERR, bit4 =
VGA_16BIT set, bit3 VGA enable clear =C2=A0 -&gt; works<br>6.16.10-arch1 : =
(not read at register level, but backlight works)<br>7.1.5-arch1-2 : 0x000a=
 =C2=A0 bit1 SERR, bit3 VGA enable set, bit4 VGA_16BIT clear =C2=A0 -&gt; =
broken<br>```<br><br>With `PCI_BRIDGE_CTL_VGA` set and =
`PCI_BRIDGE_CTL_VGA_16BIT` clear, the bridge ignores address bits [15:10] =
for legacy VGA I/O, so the ranges alias:<br><br>```<br>0x3b0-0x3bb =
=C2=A0-&gt; =C2=A00x7b0-0x7bb<br>0x3c0-0x3df =C2=A0-&gt; =
=C2=A00x7c0-0x7df<br>```<br><br>apple-gmux uses the following ports on this=
 machine (PNP resource `0x700-0x7fe`):<br><br>```<br>GMUX_PORT_READ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x7d0<br>GMUX_PORT_WRITE =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x7d4<br>index magic sequence =C2=A0 0x7cc / 0x7cd / =
0x7ce<br>```<br><br>All of them fall inside the aliased window, so the =
bridge steals them.<br><br>## Direct verification via /dev/port on 7.1.=
5<br><br>Before:<br><br>```<br>inb(0x7cc) =3D ff =C2=A0 inb(0x7cd) =3D ff =
=C2=A0 inb(0x7ce) =3D ff<br>inb(0x7d0) =3D ff =C2=A0 inb(0x7d4) =3D =
ff<br>```<br><br>Set only the 16-bit decode bit, nothing =
else:<br><br>```<br># setpci -s 00:01.0 BRIDGE_CONTROL=3D0010:0010<br>```<b=
r><br>After (gmux_is_indexed() magic sequence, write 0xaa/0x55/0x00 then =
read back):<br><br>```<br>outb(0x7cc, 0xaa); outb(0x7cd, 0x55); outb(0x7ce,=
 0x00)<br>inb(0x7cc) =3D aa =C2=A0 inb(0x7cd) =3D 55 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0-&gt; gmux responds<br>```<br><br>Then:<br><br>```<br># modprobe -r =
apple_gmux &amp;&amp; modprobe apple_gmux<br>apple_gmux: Found gmux version=
 4.0.29 [indexed]<br><br># cat /sys/class/backlight/gmux_backlight/actual_b=
rightness<br>118<br>```<br><br>118 is the value the panel had actually been=
 stuck at the whole time, which confirms that no write had ever reached the=
 hardware. Writing 100 / 400 / 700 / 1023 afterwards changes the panel =
brightness, visually confirmed.<br><br>## Boot timeline<br><br>7.1.=
5-arch1-2 (broken):<br><br>```<br>[ =C2=A07.947] pci 0000:00:02.0: vgaarb: =
setting as boot VGA device<br>[ =C2=A07.947] pci 0000:00:02.0: vgaarb: VGA =
device added: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone<br>[ =C2=A07.947]=
 pci 0000:01:00.0: vgaarb: setting as boot VGA device (overriding =
previous)<br>[ =C2=A07.948] pci 0000:01:00.0: vgaarb: VGA device added: =
decodes=3Dio+mem,owns=3Dnone,locks=3Dnone<br>[ =C2=A08.005] amdgpu =
0000:01:00.0: vgaarb: deactivate vga console<br>[ =C2=A09.494] apple_gmux: =
Found gmux version 4.0.29 [indexed] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&lt;-- probe still OK<br>[ 10.059] i915 0000:00:02.0: vgaarb: VGA =
decodes changed: olddecodes=3Dio+mem,decodes=3Dio:owns=3Dio+mem<br>[ 11.=
150] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=3Dio,=
decodes=3Dnone:owns=3Dio+mem<br>[ 11.150] amdgpu 0000:01:00.0: vgaarb: VGA =
decodes changed: olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone<br>```<br><=
br>6.16.10-arch1-1 (good):<br><br>```<br>[ =C2=A06.785] pci 0000:00:02.0: =
vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone<br>[ =
=C2=A06.785] pci 0000:01:00.0: vgaarb: setting as boot VGA device =
(overriding previous)<br>[ =C2=A06.785] pci 0000:01:00.0: vgaarb: VGA =
device added: decodes=3Dio+mem,owns=3Dnone,locks=3Dnone<br>[ =C2=A06.839] =
amdgpu 0000:01:00.0: vgaarb: deactivate vga console<br>[ =C2=A08.339] =
apple_gmux: Found gmux version 4.0.29 [indexed]<br>[ =C2=A08.348] i915 =
0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=3Dio+mem,=
decodes=3Dnone:owns=3Dio+mem<br>[ =C2=A08.349] amdgpu 0000:01:00.0: vgaarb:=
 VGA decodes changed: olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone<br>```=
<br><br>6.12.51-lts (good):<br><br>```<br>[ =C2=A08.480] apple_gmux: Found =
gmux version 4.0.29 [indexed]<br>[ =C2=A08.487] i915 0000:00:02.0: vgaarb: =
VGA decodes changed: olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem<br>[ =
=C2=A08.489] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed: =
olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone<br>```<br><br>The relevant =
difference: on 6.12 and 6.16 the i915 legacy decode goes<br>`io+mem -&gt; =
none` in a single step. On 7.1.5 it goes `io+mem -&gt; io` and then, about =
1.1 seconds later, `io -&gt; none`. The final arbiter state is =
`decodes=3Dnone` for both devices on all three kernels, yet only on 7.1.5 =
does the bridge end up with `PCI_BRIDGE_CTL_VGA` set and =
`PCI_BRIDGE_CTL_VGA_16BIT` cleared. The intermediate `decodes=3Dio` state =
appears to leave the bridge in the 10-bit aliasing configuration and the =
subsequent transition to `none` does not undo it.<br><br>`drivers/platform/=
x86/apple-gmux.c` only received cosmetic changes during the 7.1 cycle, so =
this looks like a PCI / vgaarb side change rather than a driver bug.=
<br><br>## Workaround<br><br>```<br># setpci -s 00:01.0 =
BRIDGE_CONTROL=3D0010:0010<br># modprobe -r apple_gmux &amp;&amp; modprobe =
apple_gmux<br>```<br><br>Setting the 16-bit decode bit is enough. This =
machine is KMS only and<br>`amdgpu: vgaarb: deactivate vga console` has =
already happened, so nothing depends on 10-bit legacy VGA I/O aliasing here=
.<br><br>## Notes<br><br>- The breakage happens after `apple_gmux` has =
already probed, so the driver reports no error. The failure is silent.<br>-=
 A machine with a discrete GPU behind `00:01.0` and gmux at `0x700-0x7fe` =
is the affected shape. MacBookPro13,1 and 13,2 have no dGPU and no bridge =
in the path, so they are presumably unaffected.<div><br></div><div>#regzbot=
 introduced: v6.16..v7.1</div><br></div>

----_NmP-27909390cd5e0791-Part_1--
