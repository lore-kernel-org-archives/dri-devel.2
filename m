Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A61CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D0E10EC9D;
	Tue, 23 Jun 2026 20:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VqXZ6o1K";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2AD10EC9D
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:28:48 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso3431145e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782246527; x=1782851327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUvOpAp1AnoH/UC2gSkhKh0euuT0oHxArLADJwiZt64=;
 b=VqXZ6o1KfGn49AXZCPGsC8g6B8dtSnWYQBE71SE0WX+Z0K0twMDEWJ6fS5AWxktAOo
 2tlP2lhpBNQxQNH6vUX+HLHYfh5Kp/uJERWURZ3YzovC5Ofu6OjH2Go4cWJc/bn8DTaT
 L+qeM0J/RCvxLGSJu+Xe58goiFfJMepxuDKAmWVM4gkXgnpP66DeJDfLMPtnaw4jIC68
 /DO4onLFyTYcy3yrUTFaiWwcoKTfogRi+E8k0BIZFtvBSKMNgbbB1/TUTZpdKsu2qj6b
 syhdQaWZjISFFCsMjYf1srYDlSA3dMcg1i3yg7o6j8E0261B2IwkDQmFFUsLJEM7psA6
 QKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782246527; x=1782851327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HUvOpAp1AnoH/UC2gSkhKh0euuT0oHxArLADJwiZt64=;
 b=QWAw/K3/pPRDmb6dz89dwN17lXaPGYMDKSO49b3oi3Efvzi7+1gf9eEIdEcb9xRtIY
 CZu+4/MbY40/9MpIJ+NsFhOb1YI/u6EEatlAEZgfWgLkH7Hk0xbjBcOfrT7T5Bgr6lkB
 8Ui2NyaEqMAqhYM9TcIdykkJlXQ2nMMqBLU8JnjweomPIk4yA5kU1SO7rqq/ZJq1g/Uf
 lLiuUQi2vwvjUHD21WSl9V9Y+5oPF99+oyD007ThpMfx+bAbD9bMhOOEYFMal5qMhiUP
 EP453o2BgvHNwuQyxe6LWLINj/44aaZ68n5hi0WLes9qgPgc4ysf+iT2Zr64/cxFZJQw
 v/FA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gkXxx/DbTQZYWrDcmgnGleHBLy67D0zi6rXnNftunyNuc3uFH0oBFyCJ9nIm3GgyiYvUj65iQ+EA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCUt11dNlzZYouvbMt1SE/eWAbo3KWNuLXkf0z35mcl/CmUzIP
 3yzCHplvTCF/gnLq5wfBcG74zuHkbAGnIIaVcl7alx3tzagO6FwPyQJe
X-Gm-Gg: AfdE7cly3JVphD4beioXkNDsjjbsKvMxNuGpa/DdwHMKUaSQpBCpGALKa87iurnkGHm
 TERe6cLUkQ3MsZzwTw9TCci6DIO3hL20dOMCfKg9Pez8ofQIoYY09nd51YkU3t4yGzKLWkXm6lC
 7nYifqdU/+J0xgemAiuRx93GzmUHRNaq3BZrmhF+IoPZ/ZZkvLC+CCzuau9DYMKEJTdi84W8zZ/
 qAAkMZPiJSLKHgansHzWUTdzrKuiqM6zd5gBaMLxyR0GbwmfeFJ7ByniqZdbMwEkp8F5fHO7d1u
 kzBID+MfWcrFGZsb2F8EmN6PxQzw8B9EiaOVbFajQxSquSU6jiuoxbEY1NBLLaQSuQrNRckLYbC
 77KoNKqP6NKNRVU8gZuF24UBk6eMgqdf0uGEEr7xJPSz8hMIk0OHj6PcPK790ZM24nsBYjWTHzt
 TcuaSKIDuQ3t298+pVrB/3CmTyWr7jg/Ck8D5AxA==
X-Received: by 2002:a05:600c:6308:b0:490:b8c0:d470 with SMTP id
 5b1f17b1804b1-4925b37eb4emr62966205e9.19.1782246526525; 
 Tue, 23 Jun 2026 13:28:46 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249207dabsm570397635e9.0.2026.06.23.13.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 13:28:45 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com,
	andriy.shevchenko@intel.com,
	mripard@kernel.org
Cc: airlied@gmail.com, andy@kernel.org, azuddinadam@gmail.com,
 chintanlike@gmail.com, conor+dt@kernel.org, deller@gmx.de,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, krzk+dt@kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, maarten.lankhorst@linux.intel.com,
 robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v2 4/4] staging: fbtft: remove fb_ssd1351 driver
Date: Tue, 23 Jun 2026 23:28:11 +0300
Message-ID: <20260623202811.16262-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <87ik79iqsz.fsf@ocarina.mail-host-address-is-not-set>
References: <87ik79iqsz.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Javier Martinez Canillas <javierm@redhat.com> writes:

> Andy Shevchenko <andriy.shevchenko@intel.com> writes:
>
>> On Mon, Jun 22, 2026 at 06:25:06PM +0300, Amit Barzilai wrote:
>>> The SSD1351 support was added to the ssd130x DRM driver. To avoid
>>> confusion and irrelevant updates, the staging fb_ssd1351 driver is
>>> removed.
>>
>> NAK, the fbtft has two drivers in one (SPI + parallel), plus as Maxime said,
>> it has its own binding.
>>
>
> Yes, I agree that we don't want to delete the fbtft driver.

I will remove this patch from the next version.

Thank you Javier, Andy and Maxime for the feedback and explanations.

-- 
Thanks,

Amit

