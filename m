Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9092AC624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2947610F3FD;
	Thu,  3 Sep 2026 07:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U0nHkHDX";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1E410E058
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 05:48:27 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5c7afda4515so1153833e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 22:48:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788414506; cv=none;
 d=google.com; s=arc-20260327;
 b=UAfTDJSA+kjUEyKUMEdW8vgJbINwufvZd6iLw2R/f0LClAYPjNyMFUcBIeVi/2o3Iz
 j0sY9oF6PtqO1c+bKT0qxHeSAPJFv/vh/rFFXnyUqnAtQsotOVHmo00gZg11w7qLc1hW
 iOj1EFhAc/nvsfYuF2QC/nHamcfISwE4WDn838g3mRQrHeWFXaVen6lHUoirzuQEyHHs
 qrHpK6fsN/LjmYUGdtCwRZBa5HjPpT/xrl2DJk8Y20YmIqtJ9CsPpQUJjU2wNCcwSJ25
 kXdWJSqCPeYYA4zBBZ97v31wG/XcRPFRsodGzu6urjvNUM4AKD8az7OcSTJ7TiwmdwPU
 jzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=RZptjE1dHM7nqCVLqhvT8YD6h6GAKlXNHkP07+9Kp8g=;
 fh=RbilkMqVzUMbipR9LjMxW6saqqPEDdsiVLj7ZMcuoAU=;
 b=lE1Ow5Y7aBH2eVgdz8lIG1H1iCsD5x8ebBVWqJVY/fld498kokC5zghfKNrlLTagbh
 zPyKxtNxIh0Ms2ZJAU56P16jFy1hTR4WVfwKq/63NnDG7A3ZIbRTh/laC97xW4ONsKvr
 KCB+MHplVE1TW6uU0AyO68v9ajchWBs5quVdG39DUbVYZ4e+4YArHi2ijaqfzq2YD/ls
 Um2+/gKCnwkN1O/7pBYWYj5nMCB0vdeiHGKeFVVCZMscHvLWczlpp42sILwjgND+HLxT
 7R0tQHkunUhnXAlA2iF1aNUTF75F5pXt+melq/VFqPnWs7+9jakNtqbWQ7UNF/8hhnJd
 Z6cA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414506; x=1789019306; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RZptjE1dHM7nqCVLqhvT8YD6h6GAKlXNHkP07+9Kp8g=;
 b=U0nHkHDXhRxE9I5vJAchS0oJUocCVP82xXFhD2MyOx9+kD3ZABgiiLbZpdzL1/fU7C
 ZN1BgFv6lelSnmOC+6KWKtEOoO7yVoUvd5mPoNQ84J1ApO1l1sHp9tFOXih5yvWsDHK1
 Upplbi8qw32oSZod+UA9284mQMZt3p3j5WzgvciLYnm+Ofm/jJ9h2TXH5J62iRaWhvuN
 OyW+tF28Av9H0PDZwY30YjaLa0RFxD5QWjqRxiZrlJxtWstXdCW4xsbIYX10ny/P+Gi9
 DFDhpBlb7eo2vQcP5yAqMfEDvRqX8c0NAfq6sEh0yNhACiyDH71wXcSZs26I7d16uUV/
 dx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414506; x=1789019306;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RZptjE1dHM7nqCVLqhvT8YD6h6GAKlXNHkP07+9Kp8g=;
 b=e9XpAZglqc1I7Eb9vNSW9/xGCarVWGWRDvVWNtusGWAl6bqX2V9WusfrVMvDkHyAL9
 rQPloM9spTcPK3iWNwUGXKhgnUh50CAH5ywJgebqsh/R+aty8INKXlPmnP1Eh9FViwpQ
 jg9QE0u6I0Fblbsp4LvZCwbJOu2wmchz7meSRJURVIOUUmd0178qdVC13vA+sdm+G2Jm
 e7dV9L95c6df0uMcQ4RwCZ1M+pjQvZDJawOcjVOWscQToMd0D7Yv2wqYNYqxkQmovJ7i
 22312biqHleAHhWhj3FpYg5Iwd2+YnOnl/wsIhHArCG2hPkxuEXi1txbXxkIeCoIEJFT
 G0mQ==
X-Gm-Message-State: AFuF++kCKPFKXrHiw7jUCNxqcv0SKc5QMt9bDTTfFTpq8g9JY5E+YO1I
 4/jfFiBuODONWUKvT9b11/mFSp69bczxzTgjOUk9jOfUMpRcRSSvgWoIMzynIja0uyiSRoPTqFI
 WQyegBfIvWRtCv+HdnxagZirc6nqZX33N9gQqQoE=
X-Gm-Gg: AYBFou3iKjkJQGhFLUdIeB4dbSmY3XaMTN531yetVMAtr8YHmklDFxEeWQ4qyymmjwz
 3i9ra6asgERYPSya2grLEeIkYpNgzd49I/bnenoVszdgFGhLXUUWTqHWg4f4i5T317KIPAOqexC
 fnKBT8LLqiWpPO9bdbdu7t6UnrFSgSeAzWBxdA8oHcwPcK+NamaOmJuv+VoF8clAzjLtj3p6Ckl
 O9vu+SkyzLp8kH8VcpYtkmJ38lpTRSdkKTuM15YQwf37qc1rGBpvpHu3KHC55sPuR2LpIDS/1uB
 hmnb5nvfn5eK9Cf/de0J11lpHPcOH8iqT9l/Lyy/QG2kA06jSKkZZjZVesJvmSlGkt0GDJesInD
 JVQ==
X-Received: by 2002:a05:6122:1d86:b0:5c2:ac92:eb18 with SMTP id
 71dfb90a1353d-5c7d2886ac9mr3761005e0c.7.1788414505831; Wed, 02 Sep 2026
 22:48:25 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?7JWI7Jqp7Zi4?= <nanhosoft@gmail.com>
Date: Thu, 3 Sep 2026 14:48:14 +0900
X-Gm-Features: AcwNN1WtR2XRbfyxUYjrKM5_BwO_pTTpfee00ZPL-VRfcQyqTu_mL8VqZFxe2WU
Message-ID: <CAGehT5fQWOXgftdfmq+GDZf9wHJacQ_g93iKGRKvsY0Dm0r0Lg@mail.gmail.com>
Subject: [QUESTION] accel/amdxdna: AIE2 maps unspecified QoS priority to
 PRIORITY_HIGH, AIE4 to NORMAL
To: dri-devel@lists.freedesktop.org
Cc: lizhi.hou@amd.com, min.ma@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

Hi,

I was looking at the hardware-context priority path in amdxdna and
noticed a difference between AIE2 and AIE4. I'm wondering whether this
is intentional.

In aie2_message.c, aie2_get_context_priority() maps a qos.priority
value that matches none of the AMDXDNA_QOS_*_PRIORITY constants to
PRIORITY_HIGH:

```
    default:
            return PRIORITY_HIGH;
```

The function also returns PRIORITY_HIGH unconditionally when
AIE2_PREEMPT is not enabled.

The XRT/xdna shim zero-initializes amdxdna_qos_info and only sets
qos.priority when a priority is explicitly specified. Thus, with no
explicit priority, qos.priority reaches the kernel as 0. Since the
defined priority values start at 0x100, 0 takes the default branch and
the resulting firmware context priority is HIGH.

For comparison, aie4_parse_priority_to_dev() in the out-of-tree
xdna-driver maps an unrecognized priority value to
AIE4_CONTEXT_PRIORITY_BAND_NORMAL.

Is the AIE2 default intentionally HIGH, or should the fallback be
PRIORITY_NORMAL, consistent with AIE4? I'd be happy to send a patch if
the latter is intended.

This is against current linux.git master and amd/xdna-driver main as of
2026-09-02.

Thanks,
Yongho Ahn
