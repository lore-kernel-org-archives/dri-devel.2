Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7378EC624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C7910EBAF;
	Tue,  1 Sep 2026 07:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ppBahKxx";
	dkim-atps=neutral
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC0410E8C8
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:47:28 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-90cd4631090so39902836d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 06:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788184048; cv=none;
 d=google.com; s=arc-20260327;
 b=bnPZQHaXEMoc/rTioCwxyR+0hk+HFRApg4UamMui5/lX9U/SruvbVVxx3DTDKdvfrQ
 wEXGhBO5OXHukLcGC7XH+11hCLGrdjSip64wVgMbeVAxtvMiSOQ9h8YoRIjHZt5BEylN
 wg+nQS7p8rGlgdMy6yuuLn3/sgB5gHoMYu0r0qwTlQKL7XpTzwEGCxwf/U8EpKxsYhky
 nzQBmepA94uRkxjGxsC1tbyF+dnoXA1+qiC742JJGc9NdOfc9CkwYzqrKXUJeHOSTI8D
 uFVidyvHGkRuvI5JqOheb0+y7TK5s6HorB2IijzFqz3GeaGMWzyW9pzvbHhriByLgfOb
 LMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=cFSV9KhWwH8UTBQ/C/MspQ/RwmMPKmn69329QrcNpjg=;
 fh=SsNuG3LS3a3jfigRLhhJiTUkTYLAIGSTxKoWPGY4jVY=;
 b=jA/hz5gvlwm/87w8ZHegJOu0iXUzEeRPb8TELJlCwOjFvVAhKF75ENXGJpBpP+nUQ7
 6fAV3frpe1LgbeX+Zh14SOuyf8Umk9y7BuWh6O0SSUxI2Q00vDCkvucr3bio6EwrgCge
 llSWODxb09U0FkV3BUsFRwBN0Y/Hz8q7hINKHPJQiaNN0djQKCrYkOddkKbo9gwiRGOI
 9zh4skFj76Uu8KGm0EW0zxywzMoWhKomIK+NvKh/mdvBuMvkCD8U2I+almw6UbQv9L/Z
 uaJ6FRPkrWacatKpUaf7kAP3LIVc908Ld/qUezynPttrvMLJyjFCiLWeljk7imkntevT
 Knjg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788184048; x=1788788848; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cFSV9KhWwH8UTBQ/C/MspQ/RwmMPKmn69329QrcNpjg=;
 b=ppBahKxxYaHPHOlS5qfRbO5gdoHVTlwolbcnLhXFDwW0/GwNtAIZhTIn0IrSIRC6ag
 GYi8616Pz1KwEvY6gpa1hrMIMRqBVR9HWVsGMdvELCkZ20zy3c2yRCeTv1sBYznt7BgB
 xRK0RFgslDAX+JL4YEDxsw4MKUklBJD/zj/1WY1160z+/J2CbcfFpzcxfbnOp0yvmeqW
 TebvZp1m2k0oE+XUplpfEEaIPouRkJBohl0RHhnVdlhR5+MDrvUkreuLPLK8YsWjkSOm
 BDmxgoDorA7E/sfOKXL9euryKTn0KYtxhD2SGZLQdOYRK/BB0hV+efoOidG7iHVMeYfz
 5Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184048; x=1788788848;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cFSV9KhWwH8UTBQ/C/MspQ/RwmMPKmn69329QrcNpjg=;
 b=OEQVRq6QCP8J61A3K5qDt9vmMeLRd4pI7we7OqV8Axn33nGnDFnx6fJDnrmuErtzNr
 HO9kSpfz+GJZs5gwLG1HORQ09E6tDy7aOFVtGlFRn7993simWnrnyZapbKl0n104umxD
 rLTzOJQyxbe4H+ARlLWbUaRF/831f7Jh6o7jGQV14wsh116W52XqU1e/U0ShVWyIyQdR
 psfGy1T+0gBIzjsLDaEPPW6neDYl7/CMWfF6KNPVGpoUaeaQmNxyt8MQgRdBkgDlUHlR
 qCUslnx2LEfaT73aVpRja2XAjjfFU5gTlymbYd5iADx+edByo/jImxsFeWjpmId/fg1W
 TUZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2LttgPyfUxy6s+FKknOlJD4NSDWaQvp4uJtaAXYcDGJe3fpo0cbwGGIDgK3I8kpnLBy0rGHLCddY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++njIdYFSGPpzrxj3nj09q4LxLho5DFeltVtM4T72Kkg9c56RdJE
 4BAgW9d466aG0/4HCMbGBvCeAo3WGTYZzFmltbmPgVqSIbh+KuoFJT3Tj8UmOKtRSP0EnX9pBAy
 hLX2RLA0Bg03odMAjcPiCE0Yi4MrKk23Wfwk=
X-Gm-Gg: AR+sD13sLlQVn1x+vvBUALRsN1r4IwyezCSODYSn53f2Kmhg7mfJXTH3OQsU8oyvl29
 kK1gi+/7crima1QJtwOgbl3yAh3gNoZoAfl34UxD0SoW08xYK/AX2yxmIooW4eMwMwYBphD3FWG
 xhf7wPTFJZ8xy3vE27Pybikyiq34o51q/k+IterB4RHpbGDLOFsi+4X1ry24Mdk/CIlSPeKixB4
 e84Sw5JcSh/G0s2RLtb/HBYccojzwpEOqOPBtWXk83m1bw3opaiw1RKRCEW9X7M6eLK37or1qTH
 7JTY9dkumG4i2xIm+kCla146Vukl1C72LNs2bDtA0hkg
X-Received: by 2002:ad4:5c46:0:b0:8fe:57d4:69cd with SMTP id
 6a1803df08f44-90e87197c3amr94853606d6.14.1788184047385; Mon, 31 Aug 2026
 06:47:27 -0700 (PDT)
MIME-Version: 1.0
From: Robson Candido dos Santos Alves <robsonalves.us@gmail.com>
Date: Mon, 31 Aug 2026 10:46:50 -0300
X-Gm-Features: AcwNN1XiVRIDsV5MvmN1_ctjQnb_kUYK7ID-dXE41cp2gLJaxtcLOJ1RhzUegpg
Message-ID: <CANkdJ2VvJQSBzyOq=LgSW1=Z8-YiN_r9Py2iJ0UJDo55+dbfuA@mail.gmail.com>
Subject: [REGRESSION] amdgpu: "pixel format with alpha exposed but blend mode
 not setup" warnings introduced in v7.3-rc1
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

#regzbot introduced: v7.2.2..v7.3-rc1
#regzbot title: amdgpu: "pixel format with alpha exposed but blend
mode not setup" warnings on Renoir/Barcelo

Hi,

After updating from kernel v7.2.2 to v7.3-rc1, several DRM plane
warnings regarding unset blend modes for pixel formats with alpha
channels started appearing in dmesg during initialization.

Good Version:
- Kernel: 7.2.2-070202-generic
- Display Core: v3.2.384
- Result: Driver initializes cleanly without plane/blend mode warnings.

Bad Version:
- Kernel: 7.3.0-070300rc1-generic
- Display Core: v3.2.392
- Result: Driver emits the following warnings in dmesg:

[drm] [PLANE:44:plane-0] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:51:plane-1] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:58:plane-2] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:65:plane-3] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:99:plane-7] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:104:plane-8] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:109:plane-9] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:114:plane-10] pixel format with alpha exposed but blend
mode not setup. Please fix.

Hardware / Environment:
- Hardware: AMD Renoir / Barcelo APU (DCN 2.1)
- CPU Scaling Driver: amd-pstate-epp
- Kernel cmdline: BOOT_IMAGE=/boot/vmlinuz-...
root=UUID=87f96fe9-4a93-4725-95bb-dd53087bb7a8 ro quiet splash
crashkernel=2G-4G:320M,4G-32G:512M,32G-64G:1024M,64G-128G:2048M,128G-:4096M

Let me know if further logs or tests are needed.

Best regards,
Robson
