Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6326DC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75BE10E6A1;
	Thu, 17 Sep 2026 09:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="szqpXTwG";
	dkim-atps=neutral
Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com
 [74.125.231.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0814210E6A1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 09:22:21 +0000 (UTC)
Received: by mail-oi2-f12.google.com with SMTP id
 46e09a7af769-7f4f0d1778eso383530a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 02:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789636940; cv=none;
 d=google.com; s=arc-20260327;
 b=lpweTL8QgQ699uWagQ/zVpph4P5+e8TkpM2i64icJUvqnVtPge/YqY/CruFL3cM4g5
 3AYSQm3BpIRmP3NusZXY3ZhhpaBTIJoKmSrgdIpyahLpSnJYsSG3uHAtwmyPipDeYF9Z
 1URPww2306xoid2y7z2H3+rEU4EgDXPNyfd5lj0z6QyxWz2rClUxdcL5GkefLrcmuh6B
 vLgw/Pb8XEPXO+L1l4c2Xfp3mhYMGvnxGk7Bfk8dOwFTgEnRTrTKw9kUXcXbooBGe83s
 bjRsQF4gqU6kTlPVSbK6oseWJ6GU5iTEzEBu6X+SDkTKEQfbHtcaAr262XiP1Ehdtal9
 TnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xML49QZPU1Thc36BE9MAJyCWem50hfkHhyKIdhFthUI=;
 fh=luganF9mb60XCz/9L/xKrNowrGZPFn9aVGZiJYjfy4c=;
 b=FtChrW+xizc+mOMxyizi+gfms9wj4Nfcbmt23O1tB03Ok22jrmPh2/reNg+NfNODIR
 ZuOHTFF/qDFyTc1mNm0XIFPOH0h7iqK+a8q/XcO/lFUGdn3Gi/a4FvjtBgxSRRvdXYNa
 F8ievEoEMK8nsZwejUtVXRwganbEfA792zAsmlnAmjE3yuu2jsy5GQ8/JozVX7KKhOAf
 Jj526gxV99jsBLFM3YKoEaJw0TfO1Cis+BQPNQbFvC4Dp8sKywQ5FlP04EKYF3EeAHHz
 rTejl6A+lsGKgd4Ser0MX5wBFvBQepRiM22z/tWtg4W+1Dz3DiMxRUuRTmJgruu3XuPu
 mAjg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789636940; x=1790241740; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xML49QZPU1Thc36BE9MAJyCWem50hfkHhyKIdhFthUI=;
 b=szqpXTwGMcMAqcUhRtyQmQY24+WkQlR/o48GR+k9Ia/Z+8ZwgTGEH8iqdBnj5W1sBY
 MfuNFmZooFbtq9ReYKa41wMC5iGDUiZBMGYgml2COTCRjlQelyuaRQ5s3LNeNAY2OaNo
 aVa2Md4UrpK0399MKt53NYcm2htCPnkM1qorIQ4OZsjpjKtSLUcy4sWp7f0G2zhmUr9V
 jqZUrJSGGkfGar25K5I+rYlxJ2nEkfaiNv+w4je7fbpgHBuNWXOeSJGY1n0KnYO+mDEC
 oBFPd5cAuDeIBrZHUgdhkg46XWSIE2It3kc5awsrL4mB4XBREhEWs4kn03ydx8fiONFH
 kXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789636940; x=1790241740;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xML49QZPU1Thc36BE9MAJyCWem50hfkHhyKIdhFthUI=;
 b=LLMo7sA0SPVEidAtJ8fFr50k8PiP6ENbyVdbs8Byb4BNm/YF+hYNjzYscgAFHqDY6t
 mW7H9lWcopmlBRQz7WZLChO15YtMQhslALBAb+PCuZYy/qlBYwQcZIDho8T0oGeZvMvv
 ysll3ek9tSU/AcH6+3X+QhVoYudP9I/JIdlPLZH8UZqfVrHOOZ43sN7V9AAe5DIjUjRk
 RjsRJ5Uu95PzdWfN/SDW6IW97BVDz4sFgIinBV76hWQ7BqvFO+57+dyDqB+Je9RJZjVj
 ek+maRPuqVDN6vBNdsNWjZ3k4BIC7qwDN881wLTskH2KPB59aIVvKAJxqu6QDPk+pUKU
 YGuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNWCejVydZALJzH35tvocFEpOklXoMIXD1w+uguMHHVQETd0bBFU1kKM3p7sbUDluT7E0dVorn5Co=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kXZyf7CVRArWkCDgeBwIApuX5S5/lJPxfHqD2MJg4bFnkOJ5lJ
 8mfpA7Zo6yV/kd5Hq8Vs+g4QO1KELebrddb5VsGE5oZRkAYUwBGA1XzFN9kHC3VCDRWiEFaf4WI
 mrUBZ1Zu62m57OtKuSm/wU7QTePoQtWA=
X-Gm-Gg: AYBFou0oBj06lw5VzCZnWQhUimwJmoBRQ7S+ioWWIp7oU6hiQmR4R4GLcCNxxPs8yJy
 mx8u6yQR8zQ6b4CBNR1btTRt61ObC+ChJyDEDzN7iMdXG+DaHPgU3c6vkYeUwOVy/D1ph/QUUgb
 SbC5+EZHYNCIhW2hXZYfZbI32lOi7/rfR67X7xgPMwh+1ZTeOHu65+cOGZiy0iNE+qCnFvFvmrW
 v+kFGZzn/n9q5aU3728szo2wKdDAjTNntn94uIWsW/ztYQRboK18poFW7yETj7W2cn26zLHuZPZ
 Mt0NtItfx1mr9VNJJlIOpu/2KDJO0Squp9esEjbfviB6XsJxYzz8L1u9lYxIlVsVlhx8T1HHYsB
 QIsdntc9rasSpH2q/0zPIKmayf+gM7jKdhX7BqO/8yA==
X-Received: by 2002:a05:6830:4c05:b0:7fa:ac4f:7a2 with SMTP id
 46e09a7af769-80b2fae21b0mr6132293a34.30.1789636940009; Thu, 17 Sep 2026
 02:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260829004608.25252-1-mikhail.v.gavrilov@gmail.com>
 <20260829085941.106318-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260829085941.106318-1-mikhail.v.gavrilov@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 17 Sep 2026 14:22:07 +0500
X-Gm-Features: AcwNN1Vv-J6lv17tD-bMi7gxggeLr8WQiXsU2DbcXEie7e_OqjgYjTWegQ9t7A8
Message-ID: <CABXGCsNQZY+g5AB17yiZP4aD3eKBpNWWNqcOL3_eh5JLxp=H3A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: add missing CRC engine 1 registers
 and masks for DCN3.2
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>, ChiaHsuan Chung <chiahsuan.chung@amd.com>, 
 Roman Li <roman.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
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

On Sat, Aug 29, 2026 at 1:59=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Opening the CRTC CRC debugfs file on a DCN3.2 card triggers a WARN from
> dc_helper.c on the first attempt after boot:
>
>   WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:53 at
>   set_reg_field_values.isra.0+0x30d/0x730 [amdgpu], CPU#1: cat/58468

Gentle ping.  Is there anything you would like changed here?

Since this carries a Fixes: tag for a commit that landed in the 7.3
merge window, I was not sure whether it belongs in drm-fixes rather
than amd-staging-drm-next - happy to resend against whichever tree you
prefer.

And if DC header lists are easier to regenerate in your internal tree,
say so and I will drop this patch: the WARN is harmless in practice
and I only sent it because I had the hardware to test it.

--=20
Thanks,
Mikhail Gavrilov.
