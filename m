Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BFBC624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A00F10EDFE;
	Tue,  1 Sep 2026 18:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T93IWhY/";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0886C10EDFE
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:03:40 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5b4ab0e4da6so32592e87.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 11:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788285818; cv=none;
 d=google.com; s=arc-20260327;
 b=eZs2JpOMZgoF9kAxM1V2vERnL83mAOqK9JG9sC8zg209/JlyHZ33UbXUDMdGqueWx+
 c1dU9UiT/EYbsX62LpN1iPmDNqxXIVMaZnjj0/SZCMZG1acK/l+7F6wLpDfKl/c/sNQr
 sk3iaFmdNofl3KzfFWOQtlSMqgMfnv6jAXBMv7CoAWA0ZWtBcc5vOu5gps5nT6/fsbAk
 u/ur9Hlxi/GwdqZXPiJDbPHHe3tsgTn7A6LdzzM/2lqr2RR5m6z7udTHjJEc87zHwJDp
 VJgV/6LGOI0Sk61yVkLxJ3DvltGPkARfsg2EnR3sLMU9bZ+Mb9vHcLhQicR1K2Ph81q1
 JTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zp3t4ns9rDeXNWCehIDZ8V5jUGovTfPKtzx1minoERw=;
 fh=hxCxJGx7HQae5H5IJunuhdSIzWDnseYCFnY14o/Oa2k=;
 b=STpODMy2RK8a0Eq75JePCWrIomrct1fXEQffwlmAIU6J7ByneN4ZM5YuaRZQ2aDjJd
 +YSOPw9Xva7M2kWV9T62yoeoHQ9lb7xJJ507JE1zji9G0sqLrKMeHNb8WEjq6KGhfMCo
 Eb8vDFDkdogALfD8XQSJA5BLVdKpZjuSiedu5UBMVrHQBDln/K8ARLvh9vZe2eIkh5nf
 +MfvVB3wTBWePVNTlyKRuMvhiRF3eHSXY4b9GM5OkMXflVvAIZ0HrOvPwGQG+h56BVHd
 fDFSBPFzoGdC62zSpEBsik928NN/Itr81aOliHb1s/RyfX3FSQT5XuBP3bhVl/sPz4IR
 MavA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788285818; x=1788890618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zp3t4ns9rDeXNWCehIDZ8V5jUGovTfPKtzx1minoERw=;
 b=T93IWhY/uZeQ/ZOFTAkST/RHh8uav7kM+cS/XQAvuE3ocKnCg6fxGp29IIoSyvpRap
 Mb4jPGQMDEg9vGJRsJzGk0Kwf/bFf2pK4Y7s+tDziZ9RSKQ1TsQqYkZEkqQhkeaVaf3j
 I9rM9Q/GfXCaAf8qFx98OMjnY47sqzsqS5g88KOFWXO1SgI8nhyVSpgkEzPmZ9ERByTD
 +DaeogdBRZsw8EakNH0qoiv5vd1VTtmMemTwbt7HrUZ8aWgY9sP7Stbr8Due1W491CYS
 YBTzttkt/O3XhrZN+U/v4avgN3w1hNAaMySBi95fOAfPuStRdpLjzeFOrQaUWEHBSGGX
 Qw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788285818; x=1788890618;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zp3t4ns9rDeXNWCehIDZ8V5jUGovTfPKtzx1minoERw=;
 b=dpiBtZCWSKP+qZ6aL/b6IvtJBg/EgV+cyRebfo/zvlrz9vLSF3wuiSjJkWcg3jzulh
 0BnISTUzGLKvnnS5ImH+BSfiwLh1CRwx+F/Ln1KMlFVDCAh/+7wmBE9vfOHtWTAebvFY
 2hiyVCA2swRpygf65/kF4MvHRcAsI/U9+TDx/3I4Si9R8t/Mo4Ysmag1nYEo6VQw3I2L
 u3I/rNLFUY64rfgnZEXHeqEybwHpAIa9MqxbVbO2LG1hcCmXRMBREYOv0spV7WVceDwe
 w2FcWsr5tTvem4gZa2hCQqirUIsETaY54PupRAhinFw2YehssT8YlJTw3mq6Cwcz1vFc
 kxRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpxvSyzCx1yCPurvAIHAXeNGgvTaXqWK7WhJEiPHLLIi0DgCSZvxDRTAf01+2IWzOL9p7WygRyUUQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ktEcpeXPwUEXho+OGt2ycrTKFsUdv2U6O4LXjEiGGVzqP4idV/
 OZmFK1vmc2+j5T2jDZmm3j3DSQ36EoxV2ZoKRi4v0scaqLqdA9bP6pLn46BabhhwQr5TarBfZj8
 zY+F73pZ07VSGAPcL2iwkFAFUKLiypHg=
X-Gm-Gg: AYBFou2Y0CWSRHk04siADnrggLQHk0I3vFZQft6FxcO8wIFwEhnI0+ODJCl/UvsnJZZ
 ptyxbFUpkg1TT/HaDcdXShP6RPSmsIz+Yeu+LnyH/FaoAsFZs19Y5A965aToZt9RKmMI3+X0P+I
 NewYKj8ZRQ6MV6ZcGFX1eu6LVEVbOdBO8YubsnequnOeaEMeFuw2WOEMl2YTrX2X58eBEy7xo81
 VOL7jpIkiAgJZQaiuc6D1df3g8zpq/lLsH+EcEMN6qIQ+EKBgp3X3baGsOscewtEbll6qlBb5qR
 e4WwT4uSV92JJCgoQxszgOu7bmVJdmzzjiFa8WKEC/zDp1fb7KEW7g5PCMB5wKIg19dDiUi5db0
 hJj+rtiBDYcJsh1S63I1fw/hSetvEww==
X-Received: by 2002:a05:6512:244f:b0:5b4:9d34:eb7a with SMTP id
 2adb3069b0e04-5b5e68ec8ddmr10066116e87.12.1788285817744; Tue, 01 Sep 2026
 11:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260821-tegra-coherent-wc-v2-1-2b1ddb67bf18@gmail.com>
 <8cb96c08-2d1e-459e-b356-c6fd97ef869e@kernel.org>
In-Reply-To: <8cb96c08-2d1e-459e-b356-c6fd97ef869e@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 1 Sep 2026 13:03:24 -0500
X-Gm-Features: AcwNN1UfFd2C7LhFi9P5RtZmsw7QIyATqmXfPGvR_SqmFvKwrPXswsVPF47uIXE
Message-ID: <CALHNRZ-JmYx-PhruhDZ3L8aPVu51cJrqP_FeNtGTyMHCH_esgg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/nouveau: Use write-combined maps for coherent
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Faith Ekstrand <faith.ekstrand@collabora.com>
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

On Tue, Sep 1, 2026 at 9:07=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On 8/22/26 6:42 AM, Aaron Kling via B4 Relay wrote:
> > From: Faith Ekstrand <faith.ekstrand@collabora.com>
> >
> > On Tegra devices, uncached maps traslate to device memory, causing
> > unaligned accesses by userspace resulting in a SIGBUS. Instead, use
> > write-combined maps to ensure proper access.
> >
> > This would also affect discrete cards on any Arm device. It was
> > determined that discrete cards regardless of cpu arch should use
> > write-combined maps for coherent anyways. Thus this change is made for
> > all gpu types.
> >
> > Signed-off-by: Faith Ekstrand <faith.ekstrand@collabora.com>
> > Co-developed-by: Aaron Kling <webgeek1234@gmail.com>
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> Can you please provide a Fixes: tag? Also, please remember to Cc: stable =
if necessary.

Looks like the tag is:

Fixes: 1b4ea4c5980f ("drm/ttm: set the tt caching state at creation time")

Should I send another revision just to add this, or can the subsystem
maintainer add it when picking the change up? For stable, I would like
to see this picked to 6.18 at least, since I primarily work with LTS
forks.

Aaron
