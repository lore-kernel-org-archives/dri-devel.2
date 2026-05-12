Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC18CCD484E
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 05:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF3310E0A9;
	Tue, 12 May 2026 05:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TN0FQL0J";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0542810E0A9
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 05:29:48 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5a40b2bc96dso4684588e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778563787; cv=none;
 d=google.com; s=arc-20240605;
 b=MCN3oU80tDsvCW3sOnCqjnKzlefBtT/jhmiVV0vxFJkGDquZVSbqKZi1QA/HXP40gF
 QwBzwkfRxl9b6hegtpDw9HNvu5ftWsNqUSeizH3uphH41E2Q7bT+MP10oX5ihkq+ZHFE
 oewmd6+xzHJr52DQtzmkwP2HDyJoIgbjKsa92kvkNNOJ/3gMzzb8JBYs6KXrtYJ5FKDt
 3ege50XJ/VfKm8ORasVSMlIXB9VOiLSg6i5HDsy4Afh4JIAH/PXIXrfnNnpZ4wjqM1v2
 yEk99etfmzRIdM/TZBrcIHFzPqqoU6e4wN5j/uIKS/6LhGqfvmXPymRVok0OI8Z1DLyr
 unVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=dfl2eq4XdvwzzwMISw+3fb93nWUCpKg9Ggc5uZLfkQ8=;
 fh=CWD7ccu9nVmXT8oJTkVeFFSgCRnjE/pksoRp80iBejQ=;
 b=UpJLkHIyHBgY4WH197usqvxl6N49cvO9GoJhF2U6A7+Z76BDBmGhr9hQ7udzIR4u1h
 nd0EqG791WpWjsyiot9pv35bKc+q6jBOGVg+oOtHYwGM18dLzG21ZfeiV8MbwqeuCG3v
 3ssXMe+ACH9+L1q4OzHGnkXGgJECm0PkRuRTE8lTGNswd2/36sDyhr8Zmeuz7xD85SJ7
 rzxxUZmvCuUjkeIWahiD0U/ZPBi90vvvXZA/lUxburs48VqSOCoQiF66p1d9RPP8XFkv
 lmz8szjpYIQckQuw89VQfHytVpWW13MDvvofQFQaOnqa1FFCL//aE6luBSVcHUrrTYRK
 ZpaQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778563787; x=1779168587; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dfl2eq4XdvwzzwMISw+3fb93nWUCpKg9Ggc5uZLfkQ8=;
 b=TN0FQL0JUtOETai81+0Fti7dg9wKaF/5+VlgBm+TDVkw1VLNqRF2JxTmC5iObJcCZP
 j1C69UC72l34aE1TpCdFh4VP7O6yf9i83TMkZYVtwrB6jYLEgbQ6mfIaz6Sk4Wvy0kaK
 ajOYMCHxW5SmyQfegUJLAVKhk74XjnLRo9Xvkqs77xUj3wsLfisEf2SR4IElPVbyZQnv
 3+m6yFBodvJjQHMjXmMg6eQjy6P1uSRCcYH1beR2xpHSbmRIcYFCJKZ6T9c4TPp4M1O1
 HjYLulx7hn0E7BQ7rBUD1VbtH3sCXwQoDs19HwqEOgaWPjW7cB1fwN8EiVFoe8DU3cMi
 HV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778563787; x=1779168587;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dfl2eq4XdvwzzwMISw+3fb93nWUCpKg9Ggc5uZLfkQ8=;
 b=E6PeR/SqjOC+rB9Sh62BWqRzvKwp96MCHig6CIl7MqFZ2sihkvHB59AVhEbGKrlvnz
 6dGAS46Ub+zQzdmT6nos9rgm6IyHxK9U43Hhy6dVhJHprBAs62nd2HAjwWyEI3HhfnZT
 LTh5PC+qlwNGS+xk5cje11fIehMNjg8+4nCbtmFH7LQVO0HUibT8nxbiGbCessX0+fT+
 2QlSeUHdCEDQNOvyj0zosH//H3O+TVsnuOqsa+6U5RWrn8xibRneYpOc3aCksDQA+Ex5
 SXMY20hkaZ9z3O5V9pvNbo+UkoPGEPc0QCGo/ttE2A5d+ZoBkKr1KJqfYKOtJVcssLu1
 0+NQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ96xjfLXsQGWYhQPgrOArONp5vlFOOESw/AUIJ74m+SxV3vVyHKtyqNwnpHBtKA/CBycJvEUiRb9UE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEMU7PbPsslz1TcOJdCxVDQdHN9P2EWSAQ+JfDH/pvkD5nAGNo
 1ey4N32lcG8aOJx41JqLUrGRxbcVpsMpH5Npd7hvRzvTCUI4OmsvbP4NnEpwd2dC6gDJv0mDR7w
 ORZXrXA4DL3w9unGd1kPE2EvR5k+/sM4=
X-Gm-Gg: Acq92OGz6LBrKsP6ORnPwG0vfwUXXgXYcAwqevQ9lX/9TPrD+sfDAxOiQZFaG05spZq
 2r3erC18MuxXbawYpvQutsvj09aDz7o5F4fzotZo5iSKN7jafQpE7IgBViePZHHctgTS+cqiZNi
 FpoFxEVCkhAFAf8DuZd6OlAPZJM4IOrbnDqNu40B0qvCwRZDocyimgkmxmI/+WAZS/9SR++nTX1
 MlA3jfmlsyqMtQwCsNTXeOsmkI+7CuqQNQ3k9PHBeoHMbKgeDjBGEvFHhEkp6OBlgKyUuOMSXR6
 HNPpOzL6LIzXaF2RjuKbjDzBkthigw60Ybnkqhtu1PIYbyQi+iI1sOjuntwIQiIBg/DG
X-Received: by 2002:a05:6512:2252:b0:5a4:52d:4abc with SMTP id
 2adb3069b0e04-5a8a949f19amr5519345e87.8.1778563786826; Mon, 11 May 2026
 22:29:46 -0700 (PDT)
MIME-Version: 1.0
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 12 May 2026 00:29:35 -0500
X-Gm-Features: AVHnY4Kwsv7b2fXRf5ywwfias53-xE1lZIqqHODDodSMGEK2NJ1hWGs7ABH5zC0
Message-ID: <CALHNRZ9mmf_4OagcooO-s+SU1KrggT5_ZwM--ambxZKXN-oQDg@mail.gmail.com>
Subject: [BUG] drm/tegra: DMA buffers are not always freed
To: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

There is an issue with tegra-drm where some buffers get created, then
freed, but the dma buffer never gets freed. Causing display controller
memory allocations to start failing after the leaks fill up cma.

I created an issue on the freedesktop issue tracker [0] with a patch
with some debug logs I added, then a log from Android that contains
these logs. CMA is set to 512MB, and when allocations start to fail,
the unfreed allocations add up to just shy of 500MB, where it's
reasonable to expect that 8MB contiguous is no longer available. The
log was generated on a Jetson TX2 NX, but I have seen this leak on
other archs as well, this also does not appear to be limited to soc's
with nvdisplay.

This does not appear to be a userspace issue. The graphics allocator
works as expected for other soc vendors. And as the logs show, the
delete dumb buffer ioctl is called, but is not always followed by the
dma buffer getting freed. I have also observed this issue with a
gralloc that uses the tegra gem create and such, this is not unique to
dumb buffers, that's just the last log I had when deciding to post the
issue to lkml.

What I primarily intend to ask here is how to further debug this
issue. I'm not finding any direct path between the delete dumb ioctl
handling and gem release or tegra bo free. Can someone point me to the
pieces in the middle I'm missing, where the logic is to decide is a
buffer should be freed?

Aaron

[0] https://gitlab.freedesktop.org/drm/tegra/-/work_items/9
