Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57857C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98E410E963;
	Mon, 10 Aug 2026 18:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jSDPtljW";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D93110E199
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 18:20:36 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5aeb2bc82ccso2500968e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 11:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786386034; cv=none;
 d=google.com; s=arc-20260327;
 b=ZOIfT1RtD5g0YjZxjFuFPdKNqbMPytntrt62KS/20Ym0tVosFOpRArGo4I41rrwCwO
 EDOh+2pod4p+PqSKfDW6LPRJfBEON39QdaF2PMSjC8J2Jr6J1ozLDUUbENKYyL1csbAY
 VU1XL65Vcz30qdHGOXuSQye8T1rJkPfUaUkHDKMwOrbidhhQ/uf4WRkQFmf+j91+9eSs
 4lsMUV+dXZ1uITnZ6WtSrtuAFa7smviHGiHICnQy0rm/Fw/ImuEvaU4cKT67GNOt9Y/X
 xmdC9iBYeDjxWoq6XkbRidWD+3n7XozVivFG1B1yWmohIhVYVuB1LEOXW8q5G8Pjvdds
 skyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=GRKZQyIgAIUvIunVT9w7wqu2dy0LSt3JM4W0FMydkoM=;
 fh=AygVqdpwZ+4uZ4aox5MUGvgYzf768jTHBi41XrjcAm4=;
 b=mom/b7BR2EjwPyc6FyjH5yBoI2JRv/7Nq6Rhoss0dvgV505+9rsgiBsFSum5CXEYMT
 RHr2WeCfg+gFY7t1FVbjqG09aCpKIJKL/0WLTfHZHB/Uv6iTKfCY+VSMQYylcfjjkwVi
 rJQbDZzY4L1e/ydtV7n5byrX6PXHu+JSwI+mt3pUCdtEay2b4LsGPIUbVbZ4joWBESUg
 dokV8Ov56cdFJ3a4Q9DCUSEOJN+ULnzVDL02/rrUSk9jdzjFrQmA+vxN6rFni9pG60Uh
 43477MpmCuVWNoVDlTu95EOBKg217htBYOgijzcEH8QZdtbkT6OJ+ijeKfyfq5FFEo9U
 BuVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786386034; x=1786990834; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GRKZQyIgAIUvIunVT9w7wqu2dy0LSt3JM4W0FMydkoM=;
 b=jSDPtljWhCBgaMBlyix8OMvu4c4ISnTDeUNVhs302g0rfmRRH36rz0aRkBgRP3jCLJ
 jON+MPEwYTvid53LPYUrrvjComS14aplVj+qD042hNz81aQGy/gfUF4cfFWeqNXwuBPC
 JC01PMeRtX0TvdqzMo6hYEYUdtKFaMK3XFAGxnfzPbrFzFbxA4zfX2XBw+0ugAmiA5y0
 aSgoTJ/vfgHBDLTtJi2XdGSp+IDDyo4iRdkM+LqJwZOBHVo7YKPWUeZrWoDZwVklxbmJ
 ABQena5edeUIiDq92Y1i9H8OwUm+y3K9A+Z8UDDvyohtan3Ye+UAh+N96PXMxhX9xzZH
 SAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786386034; x=1786990834;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GRKZQyIgAIUvIunVT9w7wqu2dy0LSt3JM4W0FMydkoM=;
 b=QoqZH/aaBDTN9+A9HcPmVCPuszMTMNk0t8/9P3QChPGXHYg6RHUwHkk1Y4zdwjDvUp
 3YJWk8/w6B/TELSCIqwQqGzpk7srNX+4PGMGbIJ+vSXa44z+nt0572HClvxqbkQRMtxu
 b5u3X2rcDBzuObpzjXzR//ZCZNRcZVVNRmos4z3LrQ4hgsPkukUCT3oDaEXc9skzfetk
 F9EcUJFKvRr/1/jd9G44V0feJq+YDU5lJXK/zvsOqCSUxQqKGLSCxut/8R05/HYkXXOM
 XLCyCfLYkhmEZd+3nDSoRBHDli1mqgFtzV+ewaKtGxnWUaEx+OX/CCp/FoxOiuPWcN9N
 F40w==
X-Gm-Message-State: AOJu0YzWQjNu4KZ5Bo6qRaHxPRr2re+2CEukTxKLtX/doilA9s/q7WJU
 a+7JGafceqU7yHB2nKXQTfVHzPv38+RzBqot51Qw2AS+3xoRopFF2jBf/M/wRcNxjL2Z2ZExmZp
 VRhFTsorMUU84sr2fjreZWH5xZEknKK6F+TBR0QFNZg==
X-Gm-Gg: AR+sD13h2g5Ta9qmVnqucbnk4wTfq7eUPVmTvvNqWsDXKYhEg5k9erVJ4BXCpl6D5BE
 fnNx8Mnb9/Qxv0Nj9iZTYKo4RLQ10jT8DPF8xFlxsbXX1VdEjG8ap8Ntvru5x4EYXPU+trvVIsE
 iJw/xOMFN14PczLleaD09owmqUFF1PU61Rwimec65ZJXaNMWJLSt8WqEQ6U+qJJo/fkSoHj1+Za
 5/A1RAX1Px9t8uauqH6h+obQU+ULwmr+JN+eeGaBwZkGKl4BPDryHISGy6SH8m9gyno6ICxYUKw
 byY6tBH2erml79QwP2FC1WbhqYVr837CV9UST/7uw3+PeUCpEB+MPlexPaGWln8cVt9RXMqRBw=
 =
X-Received: by 2002:a05:6512:258b:b0:5b2:b85d:4821 with SMTP id
 2adb3069b0e04-5b30b786143mr2552860e87.51.1786386033788; Mon, 10 Aug 2026
 11:20:33 -0700 (PDT)
MIME-Version: 1.0
From: Samuel Ainsworth <skainsworth@gmail.com>
Date: Mon, 10 Aug 2026 18:19:57 +0000
X-Gm-Features: AUfX_mx6pXatgay6nY2-0AaEVhS7XtZZI2NnWZIjNrrj8v_2ITG5X2TNxFxYtSM
Message-ID: <CAHYiNPZtDJ1ftQ4-uxc4mFQLRKL_dEXK4f=0FmBWOX96b4+7mw@mail.gmail.com>
Subject: [BUG] accel/amdxdna: Phoenix hibernation restore timeout followed by
 SMU/PMF lockup
To: dri-devel@lists.freedesktop.org
Cc: Min Ma <mamin506@gmail.com>, lizhi.hou@amd.com,
 amd-gfx@lists.freedesktop.org, 
 platform-driver-x86@vger.kernel.org, Shyam-sundar.S-k@amd.com
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

Hello dri-devel,

I encountered a strange hang during hibernation recently, and spent some ti=
me
tracking it down. What follows is the report, produced with assistance via
Codex/GPT 5.6 Sol.

I hope it may be helpful, and happy to provide any further info!

---------------------------------------------------------------------------=
-----

A Framework Laptop 13 with an AMD Ryzen 7040 Series/Phoenix APU intermitten=
tly
hangs during hibernation. In the most recent occurrence, the first failure
visible on the kernel console was an amdxdna PCI restore timeout:

  amdxdna 0000:c2:00.1: PM: dpm_run_callback(): pci_pm_restore returns -110
  amdxdna 0000:c2:00.1: PM: failed to restore: error -110

This was followed by an unresponsive amdgpu SMU, failed GPU power-gating
operations, and a repeating AMD-PMF/ACPI AML timeout loop. The system remai=
ned
unresponsive and required a forced power-off.

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  Hardware: Framework Laptop 13, AMD Ryzen 7040 Series (FRANMDCP05)
  APU/GPU:  AMD Phoenix1, PCI 1002:15bf, amdgpu
  NPU:      AMD IPU, PCI 1022:1502, amdxdna
  BIOS:     Framework 03.20, released 2026-06-23
  OS:       NixOS 26.05pre-git
  Kernel:   Linux 7.0.11
  Sleep:    s2idle followed by hibernation after 30 minutes
  Hibernate mode: shutdown
  pm_async: 0

The kernel was built with KASAN, lockdep, DEBUG_LIST, PM debug messages,
no_console_suspend, and ramoops. It also contained Thomas Hellstr=C3=B6m's =
v2
nested-sublists TTM patch for drm/amd#5387. I have not yet reproduced this
particular failure on an otherwise unmodified upstream kernel.

Sequence
=3D=3D=3D=3D=3D=3D=3D=3D

1. systemd-suspend-then-hibernate entered s2idle.
2. The RTC woke the system after approximately 30 minutes.
3. s2idle resume completed successfully. amdgpu reported:

     amdgpu 0000:c1:00.0: SMU is resumed successfully!
     PM: resume of devices complete after 1356.807 msecs
     PM: suspend exit

4. systemd immediately began hibernation:

     systemd-sleep: Performing sleep operation 'hibernate'...
     PM: hibernation: hibernation entry
     Filesystems sync: 0.041 seconds
     Freezing user space processes

5. The durable journal stops at that point because userspace and the filesy=
stems
   were frozen. The console subsequently showed the amdxdna restore timeout
   quoted above.

6. The following failures then appeared:

     usb usb5: root hub lost power or was reset
     usb usb6: root hub lost power or was reset
     usb usb7: root hub lost power or was reset

     amdgpu 0000:c1:00.0: SMU: No response ...
     amdgpu 0000:c1:00.0: Failed to enable gfxoff!
     amdgpu 0000:c1:00.0: Failed to power gate JPEG!
     amdgpu 0000:c1:00.0: [drm] *ERROR* Dpm disable jpeg failed, ret =3D -6=
2
     amdgpu 0000:c1:00.0: Failed to power gate VCN instance 0!
     amdgpu 0000:c1:00.0: [drm] *ERROR* Dpm disable vcn failed, ret =3D -62

     ACPI Error: Aborting method \_SB.A010 due to previous error
                 (AE_AML_LOOP_TIMEOUT)
     ACPI Error: Aborting method \_SB.A032 due to previous error
                 (AE_AML_LOOP_TIMEOUT)
     ACPI Error: Aborting method \_SB.ALIB due to previous error
                 (AE_AML_LOOP_TIMEOUT)
     ACPI Error: Aborting method \_SB.APX8 due to previous error
                 (AE_AML_LOOP_TIMEOUT)
     ACPI Error: Aborting method \_SB.PMF.PMF8 due to previous error
                 (AE_AML_LOOP_TIMEOUT)
     ACPI Error: Aborting method \_SB.PMF.APMF due to previous error
                 (AE_AML_LOOP_TIMEOUT)
     amd-pmf AMDI0102:00: APMF method:8 call failed

The ACPI/PMF group repeated approximately every 30 seconds.

Frequency and controls
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The failure is intermittent. An earlier full hibernate/resume cycle in the =
same
boot succeeded.

A similar terminal AMD-PMF/ACPI loop previously occurred on BIOS 03.17. The
recurrence on BIOS 03.20 shows that the current Framework firmware does not
prevent it, although only the latest occurrence captured the preceding amdx=
dna
restore failure.

No TTM/list-corruption report, KASAN finding, lockdep splat, or kernel pani=
c was
observed. Ramoops remained empty because the system was forcibly powered of=
f
without a panic.

The known amdxdna query/autosuspend deadlock fixed in Linux 7.0-rc2 should
already be fixed in this 7.0.11 kernel. Its documented trigger and behavior=
 also
appear different.

Current assessment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

amdxdna is the leading isolation target because its restore timeout is the =
first
captured device callback failure. This does not prove that amdxdna caused t=
he
platform failure: it may instead be the first consumer to observe an
already-unresponsive shared PSP/SMU or firmware path.

Not yet tested:

  1. pm_test=3Dfreezer
  2. pm_test=3Ddevices with amdxdna loaded
  3. pm_test=3Ddevices after removing amdxdna
  4. repeated hibernation on an unmodified current kernel
  5. amd_pmf isolation if removing amdxdna does not change the result

Questions
=3D=3D=3D=3D=3D=3D=3D=3D=3D

- Is pci_pm_restore returning -ETIMEDOUT on Phoenix a known amdxdna failure=
?
- Which amdxdna dynamic-debug messages or tracepoints would be most useful?
- Is removing or unbinding amdxdna before hibernation a valid isolation tes=
t?
- Could a failed NPU restore leave the shared firmware/SMU path in a state =
that
  causes the subsequent amdgpu and AMD-PMF failures?

I posted a full incident report, configuration, and timeline on my personal
NixOS config repo:

  https://github.com/samuela/nixos-config/issues/4#issuecomment-5174630789

Some related external reports found in the process of debugging:

- Older amdxdna suspend/hibernate failure:
  https://github.com/amd/xdna-driver/issues/18

- Same later SMU/PMF failure cascade on another Framework 13 Phoenix system=
:
  https://community.frame.work/t/fedora-40-on-the-framework-laptop-13/47746=
?page=3D3

- Same later cascade on a different AMD platform:
  https://marc.info/?l=3Dlinux-media&m=3D175377491609096&w=3D2

Best,
Samuel Ainsworth
