Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275D0CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 04:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8579C10E2DE;
	Wed, 13 May 2026 04:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YAahhl2I";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE9010E2DE
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 04:26:31 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5a4113ab355so6016851e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 21:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778646390; cv=none;
 d=google.com; s=arc-20240605;
 b=AbQpBMvEMrtnKR+/wLVJYYoWha6WklhpAYAYz9sUQGbXGeP2ZuDJXrD1gyR/dOz2aG
 Kpako0CboWkGQMkEsZ/OeUv75mmbNWd1jobWxwjEwx7iiI8mi+hGZZ0H+asefU8PFwFU
 z9quVzBgO7T6xveqGtR9i00i/QNBA3lvBCatQl4gwOppWk1scaUoiisSJWKLxaFYRzMd
 fGWeaK6G9yenRzxAyKx3gv+EeTRK10u5mX5tQ5U45KXc9Ub8xmcsURLqo121BDIRwToa
 Mer6bL3QgzSdjO+g9ipePS4gd2Tyem8xCe4HYRaWvbol95w0L3KjF68r8QcqZfGIiwC6
 jLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Od/jy1kSO8cYiVwYqYVgfsO6PcYARFxGf8hhuSZCNSY=;
 fh=/rq8FVLfPK6Wt4T8E8RmywVgpb8HjNVqRXZJR34WcgE=;
 b=Pcrnt/jQ7BPaMek7zMjiHF4LY3M2uETOXM8QvWo36EuVQEWzDqbijMAbHcUTS2rZrY
 E/bTPuFZlzLGvplGUaUnb33dNT3t4cg8Bm0/l7lv5v89qpzZri/B6+cflDRqaQVAuVew
 HXKO86lAet1woDk8XoPoOKuldabsNoxyFwERwjVWeJyOnyxalcEo38l8Sj3zqjHA3vr2
 5Klc3ydqbKrb9lV9rZ016IVaQ54jt/YD/7HaHIHgurdbV14D0jOQwKdMvWzzbC0lDMJy
 qFL1afzppgIN8ItxmOi0VC+8ejPv7+LH2ru08BFk17OnMGnDjCvSsoerKG9PiRA30+IL
 EMkA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778646390; x=1779251190; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Od/jy1kSO8cYiVwYqYVgfsO6PcYARFxGf8hhuSZCNSY=;
 b=YAahhl2I4fPK6QgvrE8DzQhCX0u+mn0aJdB/VUwJZ2UB1hBGDcE3dbOwI4XeNm7k6Q
 bnQJtFdG29DnoeW1QyG+N0iqwZzkIlNS7rXhAMXM7Jw6v3zBhLV60F4cd176SDSPwTCW
 I+x6eX8YfDeWZj3cnovGP4KW6t/MCR+RDD1GTwAq7DEOYwVtypEfFxpRE3jeqfM9Gg/H
 zdQrXBsG7P85O8+UXnbdIGV26b7060IqkVi6ZttCXSpUzMcGygrocmVnmV3rTpf0dlKV
 8movLLlNaStIoGOWmDwSKZrRZEwBzRw/zhPIbbADKrdRo51wsvR/GX/B50jiaBcPr1Sw
 B1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778646390; x=1779251190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Od/jy1kSO8cYiVwYqYVgfsO6PcYARFxGf8hhuSZCNSY=;
 b=Jc7mRrlxc6yTQan0TeGz6eD7xQd2NRs6M6CDh9lmLwGWu9Gv0FjoJr3jS7qgI/uQ7S
 ChIpLhLuyAmypvz3UmqSXleHT4kaP3Z/n8NinlsD4uBnDesZeBDshONOEfOI6c6uNHk0
 IIdBaC7HiWYnQNUJ5dBqR9omy3KPPYfUqw0eVeM6m5KfqUTuqMzwSQaW0tu4Jep5Op7D
 9MqzMUg8PwIvNn5APfat1xpztwOVDWva9AovVn0YqF9tTDGLD7sEBHpcU277G+U+6Bn3
 IPAIXHkcZAMPssK1GHk62iSkbF1CHWx4D4Ahj9fGQtmfu32VxhNRg0IVSesaDvoiCLdK
 GPFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qi4NSvSYTAjTWO4WiB/VrAu4FZtK1t24qh5Cpq+dLsQFkJc+YiwPky7sOP3O0RFtvd/d8iu3eknQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrGx/sTfFFew7TKS6n2k0albdmD2CTkqQpOvJl6DWQSKryS8eT
 eAT/JGwP2aQf2Ywd7EVtsbsy+OjD4+JahBnUiTQPfltXcpXf3nHrZtePRqGC/eNWoazpN077PWK
 oYMRxUByBuaMBTcgKiJgyGH2eccfTDog=
X-Gm-Gg: Acq92OGf9ejjXuOGnKQJru0AWyxh0Mlb33eS6E/lfc5p4rQrkTHOMqUfBtNXpkP1ofp
 WkHiQyaru+0FPcKmC7zOlBoxZlwbSj9Ka76dx/Fzdyfm+peVL5kmC/C/jd4eDKGNAXWofjmcoXD
 MGN78HzIy9MG74ZWIM6Xwt5SbasQ8HQOFpF3Gg0YDRv+guxetCwrUp2hOxY8nu8d2/fYfjEonSK
 BVjyIYqu2KvYx2swZAF4SZc7uVrpAcJRqkPyqvaDlUKvmCneQM3fsgCWu+kTzk0FYP9zgNu4nFI
 WSH7vFMfy4cHVRuejGIKxsmgm5vwy6YQImahdyCczArJBxH/oUljqGjDGE5tdWgzyZEn
X-Received: by 2002:a05:6512:3984:b0:5a8:9909:50a3 with SMTP id
 2adb3069b0e04-5a8ef9b33f1mr558092e87.32.1778646389282; Tue, 12 May 2026
 21:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <CALHNRZ9mmf_4OagcooO-s+SU1KrggT5_ZwM--ambxZKXN-oQDg@mail.gmail.com>
 <I47hlmySTbquW1VgZFOofQ@nvidia.com>
In-Reply-To: <I47hlmySTbquW1VgZFOofQ@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 12 May 2026 23:26:17 -0500
X-Gm-Features: AVHnY4J05I14Pa6Vt4Ngz3X_e3VtIngTjwNHxIsqjoQPHNK2DwVj1oFmnqeuLK0
Message-ID: <CALHNRZ_EjqA4aeqZhmicRwdpMxjKp1QpwLW98dyRa36HBX8aDA@mail.gmail.com>
Subject: Re: [BUG] drm/tegra: DMA buffers are not always freed
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Tue, May 12, 2026 at 10:26=E2=80=AFPM Mikko Perttunen <mperttunen@nvidia=
.com> wrote:
>
> On Tuesday, May 12, 2026 2:29=E2=80=AFPM Aaron Kling wrote:
> > There is an issue with tegra-drm where some buffers get created, then
> > freed, but the dma buffer never gets freed. Causing display controller
> > memory allocations to start failing after the leaks fill up cma.
> >
> > I created an issue on the freedesktop issue tracker [0] with a patch
> > with some debug logs I added, then a log from Android that contains
> > these logs. CMA is set to 512MB, and when allocations start to fail,
> > the unfreed allocations add up to just shy of 500MB, where it's
> > reasonable to expect that 8MB contiguous is no longer available. The
> > log was generated on a Jetson TX2 NX, but I have seen this leak on
> > other archs as well, this also does not appear to be limited to soc's
> > with nvdisplay.
> >
> > This does not appear to be a userspace issue. The graphics allocator
> > works as expected for other soc vendors. And as the logs show, the
> > delete dumb buffer ioctl is called, but is not always followed by the
> > dma buffer getting freed. I have also observed this issue with a
> > gralloc that uses the tegra gem create and such, this is not unique to
> > dumb buffers, that's just the last log I had when deciding to post the
> > issue to lkml.
> >
> > What I primarily intend to ask here is how to further debug this
> > issue. I'm not finding any direct path between the delete dumb ioctl
> > handling and gem release or tegra bo free. Can someone point me to the
> > pieces in the middle I'm missing, where the logic is to decide is a
> > buffer should be freed?
> >
> > Aaron
> >
> > [0] https://gitlab.freedesktop.org/drm/tegra/-/work_items/9
> >
>
> If the issue is specific to buffers that get used with display, I have
> an idea of what the issue is -- there is some circular reference
> counting with the BO cache in the host1x driver, and that means that
> BOs that end up in the cache never get released.

As far as I know, this only affects display controller buffers. Though
unfortunately, I have limited ways to test the media engines right
now.

> Let me do some testing locally and I'll send out a patch once ready.

Sounds good, thanks.

Aaron
