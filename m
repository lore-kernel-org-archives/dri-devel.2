Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC1BFED3E6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FC810F666;
	Fri, 24 Apr 2026 17:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EEJvTcyu";
	dkim-atps=neutral
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C134110E197
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 14:09:30 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-7b37d84a6b3so83094137b3.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 07:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777039769; cv=none;
 d=google.com; s=arc-20240605;
 b=D2jKytb05XCqVhMfCvFbrV9OMwb6TTdyT45JZBVh8Rs1e2/4Ll80VU5c9qqdymhSJH
 781scXCMjwNrxum0MwshQSAq0DF5ISKijZuyBk/kx1dEEDr1hVgy8X0zb8JCjnqA5D7a
 GRdAYVwHbo43IefTJEWUMA8SNpgaxnnw5D8C+WVjnUvCVwcDZ3r37Ot+Jk1NwygjN0Kh
 wk18nfQAFNoriugxpjCMDi7mtD072i5gB5fiLD2SKMh9OB5U+QutLPtGpvUXHQxRmYhK
 047ol6D9q/4t3I17OV5F4baDcFTIVgiAm9UzisasQkYdGBZ92RjevalzZIJp3MMmuPvK
 v68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nrVY5/hXTJTybzdAV1IdtBG9uJlQHxtIzaRBftQYQTY=;
 fh=x2vYtYK9Y5EpGNuDLnfI5KEbZwWgWPGHyiqB47tkbbQ=;
 b=E+XY4G5O7R9no4ADfdNLqFj3HYEtweWWbd0vzir6TnTwcIwa2HX0YnZsX+tpoEaSSj
 gvIUSOFupLzRmAtDgo3y394SDN4SV9Gdl9OwpoEclWkFD+mu3T0Vup3ZY4Yqb2+xQ+2M
 W2I2ffD4Y/EmWD+tj+stCGgNbWJJ0eBshBFS0104D/QegDfNyy3f7gO4OMvdypw3zXdN
 iYvUwo1SrO7u+AoSTcKwyGA9YN+Dyb79QJhbN7nSTRRIey2/P/bthhbORp8igS0J6j/c
 SaKG61olJOUFXQDOPe3Lp70uwSv8rVhOBOPIRhHh8lCFfekD9GEoenMTiSNldV5N7UPG
 Jbbw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777039769; x=1777644569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrVY5/hXTJTybzdAV1IdtBG9uJlQHxtIzaRBftQYQTY=;
 b=EEJvTcyu6RwWAoPeSRb8P1KwAVivmoOD9TnRQrL1wsTATsHUYF5CRba3xOYGO+1Wmr
 pek0zSLDqKvYFJssMT45L4TnGeLK8doAuCrSX6jd2ItETWxA7PSJ8z5ppnrsDB8M63v2
 0xr2OcNcl/JhiVuN17GWKKW0pyO9dHMkt1jal8v5Kpe8x6T8+K2/0oKKMWMDf9h7MB5y
 S8UPn0WNCJ5/c8HZXzKFTcbgLRyWDEKIkXKK1LHY1OKFVU2h4Qk12Aq3m7IehAQGZyKI
 hdX0ZGnGvKby9LhhfKbmoOiMU3e8xhcZ8lcX9Ix6x8IYREkjBd33P5793nVzyaZ0id2U
 fJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777039769; x=1777644569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nrVY5/hXTJTybzdAV1IdtBG9uJlQHxtIzaRBftQYQTY=;
 b=d3AHCLI8a4Y0mmvcPYg/QEnNYM16J7PLn+zrPAUjpxRWg/iUKPqjutDlQh7zb8DlsH
 pUGZWxwTOrAsTDlS3UELiiuAvw9sBL7Hanm0aSd2Y4/xxEeXx9aQmafEZsBrk9uutDpS
 +2uXNBVrrCeJnGJkUnXlukxsY5LDFozrxuE2k1wHNvR5MaoADESiJvfcEp5b0lTo5L5U
 O5RBRQS1FwJXnWkDc0cUn/lA2HeEADGF8ON5WYOHAy7TBUOopNsA11di1eG7mkULI2Mk
 mRhEVe8WMaE/RZYcYJPud7db2FARMitC+WRhYXLWQzPKSateaQkhsWeK20NlfzJTR/bE
 Hzlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mR7msG85+Vk1YCE/8sLccwaLvsC9XeYURBltrgFnRSFIgqIVXz5iXOk5ScarjBuOIn1dnxtMZZnM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyI8txVzyplMH/Vkpl8ao0rvFYj2PW3wcWQ5QZceO97aFRWxREO
 Wue0Mf7RK6YjZhbxGqFlKZAytnqLvTowjZesg/atcODb0IsbhbygdM+0Sp69yGvekbbVrBgaHnb
 +hVASWjmmG32IbQ1RahWcYMDt4XXWlBg=
X-Gm-Gg: AeBDiescirEZjNYVobsiOeJ0FTu0nmwSTFvR5TA4HTx0BYSCtXVPc4kIn5TX7t2moXa
 g9pOual3m4Nz6VHo2vc/AkuVRrLPcGKrheZ3MFnpjepYVtP4HqMlXr9iKJIIfjDZS9//xZFEF9h
 Vfhjv6PzSR+BXDDCv9MLMunldbDSUT8YJYW3NcR+bVrml/XQo1lPDIQE7uozYBaXlKir432te7J
 601eGIQRCr+M6SUfpAMoAESZzM6G5rzXmuLzxS8BAN0KSQTRfFNfwYYzyp274Jx8oKbcwA9G/Lj
 xoNx7WkQHBaxxAx0EyA+2IFg7wUP
X-Received: by 2002:a05:690c:7283:b0:7bb:11a4:2e65 with SMTP id
 00721157ae682-7bb11a4346amr108458067b3.21.1777039768034; Fri, 24 Apr 2026
 07:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAGp+u1Y42cwE0RHhtoMEneCRTuM4k9aqKtzvXOVc9-_px49N0A@mail.gmail.com>
 <CAO6MGtgE+MxeOv5xDhRoKh75tJgfvfaxoevMHJ_-AJZUc5vQyQ@mail.gmail.com>
In-Reply-To: <CAO6MGtgE+MxeOv5xDhRoKh75tJgfvfaxoevMHJ_-AJZUc5vQyQ@mail.gmail.com>
From: Ginger <ginger.jzllee@gmail.com>
Date: Fri, 24 Apr 2026 22:09:16 +0800
X-Gm-Features: AQROBzDy899PdyW7fL4GnBAimCxZ4OvoOmYMMaAfqrTWBHkGv-r9qPgQ199ewsY
Message-ID: <CAGp+u1ayZdGY3yGh7-ADYYZk_4VjUbz_CkXZq_SpwBYo9fTNJA@mail.gmail.com>
Subject: Re: [bug report] Potential deadlock bug in
 'drivers/gpu/drm/vmwgfx/vmwgfx_irq.c', 
 between 'vmw_thread_fn()' and 'vmw_cmdbuf_header_free()'
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: zack.rusin@broadcom.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

On Fri, Apr 24, 2026 at 9:08=E2=80=AFPM Ian Forbes <ian.forbes@broadcom.com=
> wrote:
>
> T0 is a threaded IRQ handler so it should not run in an IRQ context.
>

Thank you for the timely response and clarification.
Sorry I missed the point when filing the report, which was carelessly
neglected by the tool.
Thank you again for your time and consideration.

> On Fri, Apr 24, 2026 at 2:45=E2=80=AFAM Ginger <ginger.jzllee@gmail.com> =
wrote:
>>
>> Dear Linux kernel maintainers,
>>
>> My research-based static analyzer found a potential deadlock bug
>> within the 'drivers/gpu/drm/vmwgfxl' subsystem, more specifically, in
>> 'drivers/gpu/drm/vmwgfx/vmwgfx_irq.c'.
>> This deadlock potentially occurs with the involvement of hard irq.
>>
>> Kernel version: long-term kernel v6.18.9
>>
>> Potential concurrent triggering executions:
>> T0:
>> vmw_thread_fn[t1]
>>        --> vmw_cmdbuf_irqthread
>>               --> spin_lock(&man->lock); [t2]
>>
>> T1:
>> vmw_cmdbuf_header_free
>>     --> spin_lock(&man->lock) [t0]
>>
>> T1 does not disable hardware irqs in acquiring the spin lock. If T0
>> (i.e., the hard irq context) occurs after T1 acquires the lock and
>> both happen within the same CPU, then T0 will not proceed because it
>> cannot hold the spin lock that has already been possessed by T1, yet
>> T1 cannot proceed because the hard irq runs disables preempts.
>>
>> Thank you for your time and consideration.
>>
>> Sincerely,
>> Ginger
