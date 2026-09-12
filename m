Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ACFC88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 21:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FDF10E4E6;
	Sat, 12 Sep 2026 21:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aDgmG2KJ";
	dkim-atps=neutral
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com
 [209.85.160.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB0F10E4E6
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 21:44:52 +0000 (UTC)
Received: by mail-oa1-f66.google.com with SMTP id
 586e51a60fabf-46ac530b9ebso1602506fac.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789249491; x=1789854291; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HhWhTVqsOkpUdCAWPzbi+pVqLfh+oq55gUD464xfMJg=;
 b=aDgmG2KJgQJPny+eUB7SAixSHYBcVZYRNf9EAB6fiCpFSQSogGkFKG6pMt2F+ABlZc
 281oCas7SmDStyb6jOPzfArMgUK7DEGoAYJFtVCKLTPsPZPlwnkYGcK7/8z6Be43mz/R
 MCaSFVLQkT31E4p70fztAhtz4Jbvl6bZnBQ25lKhoWiZSAcV4C1bMhByrRtTd/Cc3Dg/
 xaebXUPIx6ErKqg0p+4uzG3JHAAF+/S8XVloSuF2Gu66NbiwZeY6Bu7hiPvDmLxuCWX+
 rz3bp97F5VM1TW+c8ED+/YTNcsScaExZK+Cqmlr2XJqUsUFLNajrH/skBrLYBK6TE/kb
 MqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789249491; x=1789854291;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HhWhTVqsOkpUdCAWPzbi+pVqLfh+oq55gUD464xfMJg=;
 b=p7z1fITmw2wmtJqwvp/xXxj6YkRZ6VRyxPpQjfqr4uQjSIfvHWiHH7PvnABk+nXjoD
 1lwoEvSGOlakZgiqloMZ8cqm5QAYRbTbDo7QQqbuqnC0JR+WrMi+NFWrIDejexpBecjL
 eSmsd3lzCjcQfKR8pTo+k83juCsHQqkREV0sgWoylkk10aTtYMMSrGUPy/7lPpVLVVa/
 dKw+NHGWrIvoTgznOQPuThQkeKLDx2NZ6LV5oqR8y1ju5KaOZLmeJBT/tqJfqBMpL0kx
 j55PkIA+EqFrR6VM+hPu+s9MB9N4I1v3qQtvpVhs1LbvRN8gpMpjodKboDgw+2ESr38t
 MFSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz33j1ikC1FPjAXlq9V6Gb9TgRvT5gskIviZdkXNO/phQCsn5/9VF7zZLAwWg5ukZuuusBuELZ26Sc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mOq5kKAs9vjdl8anTId/mFXOBwo2Ylh1G2PZLwhkMAriIwe1bL
 H5wxPlGg7z/xrH1nEq1vJXXvnI214dDmjoyYaQcnBWZ2+h3nuNqJ2+FT
X-Gm-Gg: AYBFou19xZ/1QiiIEsd4Yg48h1xaPwi0kYpqIyqyVhcJF5tdDgULzfEgGSdi458GddJ
 bigvVBWxsRQXc0lSNvSMB0k3dnoVZGbc8xyxMUg1F9GLyt7zd/KbzSR99nA6F9Hf+i/pV0uacQ6
 3pVRsHTF6flrnpa6sJdkAYJbo8qGM/3CkDWgACfnFu2XNSmu+afDQhUNbKl0x5EAXT7niyCIlaT
 10+PifDGrx5SzNHzOpSVk9d0SbfD8wM1pjwrqhWxEMIJbMNzAISi0pRI5jmbZf7ypL7Wp3A+eWJ
 1lUKfASNPUmfB5Mrg8no53jM2v2imMPRN2exDliPdyK6nJ+49w9CI8WCZPBQTvVZeto9D1SI8mp
 7GlpX55WeG34cq+qQaJnEcLImX/++JEQnPkb90rIqsumQ4xOTKFqQR6b88q7gHA8w9xUPGUdmTC
 bXNnc1AwC7fBPREpkSIFO5pfzyuLvtv/LtD3SJDbfO1qUuYG/bX7DqxP1ycX4B58V8wVZCMce3k
 ElT/CMySHRGP5v4eKI2l/NN6GQ=
X-Received: by 2002:a05:6870:e89:b0:469:fb8a:b5b0 with SMTP id
 586e51a60fabf-47c978e0ae3mr8164063fac.9.1789249491570; 
 Sat, 12 Sep 2026 14:44:51 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::c389? ([2600:8804:5716:d800::c389])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df42b4699sm6246514fac.0.2026.09.12.14.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 14:44:50 -0700 (PDT)
Message-ID: <688b15d1-a85b-492e-ba1e-b4da548ebd06@gmail.com>
Date: Sat, 12 Sep 2026 16:44:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pci: Add broken-GPE quirk for Lenovo Legion 16APH8 and
 16AHP9 Nvidia GPUs
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Timur Tabi <ttabi@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, stable@vger.kernel.org
References: <20260821200607.621341-1-lyude@redhat.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260821200607.621341-1-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/21/26 3:04 PM, Lyude Paul wrote:
> On the Lenovo Legion Slim 5 16APH8 and 16AHP9, the firmware appears to enjoy
> firing a GPE on the parent PCIe port of the nvidia GPU very shortly after the
> GPU enters D3Cold. This means that every time the GPU is runtime suspended,
> ACPI firmware immediately wakes up its parent PCIe port, which then wakes up
> the GPU. Once it falls asleep again, the cycle repeats.
>
> See: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
>
> Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
> nova as well, and it even seems possible for this to happen without any
> driver loaded.
>
> This seems to simply be a bug. Luckily, there is nothing that we actually
> need ACPI wakeup events for on the GPU. Events such as display connector
> hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
> affected by this quirk.
>
> Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Co-authored-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
>
> ---
> V2:
> * Don't forget to actually use parent_adev with acpi_remove_pm_notifier()
> * Check if parent_adev is NULL (could happen if booted with acpi=off), just
>    consider it a no-op if it is.
> * Base the patch off Linux master instead, I based it off drm-misc-next by
>    mistake because I'm too used to working on DRM drivers :).
>
>   drivers/pci/quirks.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
FWIW, this has been tested by me, with positive results, on my Lenovo 
Legion Slim 5 16APH8. Not sure if this warrants a Tested-by trailer 
since I'm a co-author, but just in case.

In the thread [1], we have had another user report positive results on 
their 16AHP9 (note that Lenovo seems to have switched the P and the H 
around for the laptop one generation up for some reason). Said user 
tested on both OpenRM and nouveau on top of kernel 7.1.10.

This means we have tested 16APH8 on nouveau, and 16AHP9 on both OpenRM 
and nouveau.

[1] 
https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905#issuecomment-5444071160 

