Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D05C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F35A010F43A;
	Thu, 10 Sep 2026 11:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ekcny5/p";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264E210F43A
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 11:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789038889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4aJeoI50tbrmnYJ3Ms6Bai05KfSCa+A5Ag4laiMRAqw=;
 b=ekcny5/pdU/lc4halXfVG5i53fOZ4OKLBo64HYK/9ccAE0NqSJWMdhqH+2nbzrcNtvHsY0
 1J7H3u1ocBfafotkL0kMt4TuBH9ifEa73VWW7qqhjK6/qrnNmfyaMMYcf7kez1ct3neqU9
 gyTJ47IifSTTZ146tXtvTpvBIVClRcU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-PijFbK4sPPqWqnWoJPugzQ-1; Thu, 10 Sep 2026 07:14:47 -0400
X-MC-Unique: PijFbK4sPPqWqnWoJPugzQ-1
X-Mimecast-MFC-AGG-ID: PijFbK4sPPqWqnWoJPugzQ_1789038887
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49b7c1dc61eso55743165e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 04:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789038886; x=1789643686;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4aJeoI50tbrmnYJ3Ms6Bai05KfSCa+A5Ag4laiMRAqw=;
 b=k5sIy2YITQS4ZiZKtH73gVDdXrN4PIn+SQpFDimzBRe61LLoywOP18oUJcVQUAY0pz
 xel8stIxV+oUg1rk0oWAjJOJHGvATYdB7NHdCeunU4od5C/DM4zoVR4FnX0nnTYLl38H
 H4YKkuo3qZ2UqKCt5mt0aD8UY168qP2ZRWbGVKxmMjew3tHSwXyM2usZDppGxc/iQnVM
 kiyiLfYRhwvV9iZ4QfP+R+eP36l7mfUnT567D5zXpF6//ZS8aKwl5O8GwGyb2fqVoiXB
 7fARZTuD9wG4hzYEnZwMTN36biewV4CZ9H4rTNeZWMzsbN4TkESXuH3wt9u04QdWL6tp
 IpmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEn3Bj52cMJS7s9rCY3F2vpVBCFtPJROrBb589U27jBeQje08CIfv7nPHUchbP0S+oSIjoCtdvem0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mpmHJ2niAM7D/+QRii+7gNwROXKobplHDQsHY6iPgtfvhvn20w
 ogAkXQppACY/agIzNkQA4CbJDa5YF7Fs1wBfaMDh03CJj2GO1AbalLjDmXLkNhNexQx0Nw1iOSc
 74mpip80kiSnSe1LKQ+oN2Crd/yt5tbH8+GWSx2gSWMtMD98yiUBzVO9M9M5Ix5Mooy60sA==
X-Gm-Gg: AYBFou3KB6DMdynyuZlsWEX2+gve/+eydiTwRULdM+nhkXyk78+pCDM1zyYY+k1Bxm9
 AN9nh8i6+5r+cwcqUM37zRV1PkUJBFgzZkjp7V/GXTRMTt1xMpqFh2rvvpfvfAj01lDEDlR+FvZ
 70FrF15hZ94Chzz7yZLoCC0abIwoLTSLywWLwEeABSclnNWgHlpfJGrPB0/KUc2PtnMpkVukto3
 yC5sKw5BAThqBdpaNCk4JD4VI9NZ2GuaIMCDtWTq0hpbJVU6InNfg5YIiCFPWP0Qe/pZFAcxqHv
 N1v63bx6cq/vdUnJVaEf+BLgWQfDUd9GMRCLm9IBaycXY5KBMI8J99tGHGzJ0PkJ4Gjaa7zO1Or
 COHwG1X0ZtvsTnh5JprbdxI0N6bbX8QHaaJZY1rTF9UdI1H5vrO1IYT9Z0w==
X-Received: by 2002:a05:6000:29c3:b0:486:4fff:da40 with SMTP id
 ffacd0b85a97d-4864fffdc49mr4596031f8f.57.1789038886617; 
 Thu, 10 Sep 2026 04:14:46 -0700 (PDT)
X-Received: by 2002:a05:6000:29c3:b0:486:4fff:da40 with SMTP id
 ffacd0b85a97d-4864fffdc49mr4596001f8f.57.1789038886245; 
 Thu, 10 Sep 2026 04:14:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883959f0sm53587265f8f.10.2026.09.10.04.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 04:14:45 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai
 <amit.barzilai22@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
In-Reply-To: <20260823111959.17029-2-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-2-amit.barzilai22@gmail.com>
Date: Thu, 10 Sep 2026 13:14:44 +0200
Message-ID: <875x0dmk7v.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7S346idZCh7wA3GWIlBDiHg3-hlCkjajn68MCXkJsIE_1789038887
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

Sorry for the delay. I've been on vacation for a few weeks and just catching
up on my email backlog.

> Add a device tree binding for the Solomon SSD1351, a 128x128 65k-color
> RGB OLED display controller driven over a 4-wire SPI bus. The binding
> builds on the shared solomon,ssd-common.yaml properties already used by
> the other Solomon display controllers.
>
> Assisted-by: Claude:claude-opus-4-8

There have been recent changes on how the attribution should be done and
you should just use "Assisted-by: LLM":

https://docs.kernel.org/process/coding-assistants.html#attribution

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

