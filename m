Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028426082BE4
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O3tB29bg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C1510EB8A;
	Mon,  9 Nov 2026 09:31:34 +0000 (UTC)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE03A10E377
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 03:08:04 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1b244fb7fffso64033c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 19:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794107284; x=1794712084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rR8VPeK3FB85MnmDJy6ge5uqblGvqjmVoHJKO5NZYkU=;
 b=O3tB29bgvIpxxFa0S5WyWn6KYf/1/dCRr2Jsds9kq8jfO5UdkkQ1vLFQEXnG/Yix3e
 xeYvv71Nw2XW8Df0FTXMUFq5hTw5diL/Ncbyo33yQqKtGckNPcjmYcES2XWGhFWZUV+V
 1RnBeiLC58o7IEp/oewUEZ0CwLKQk20Ssbcbqk95rqSbPlbHKfFe6bbHiFSNElHEYOrA
 w5Zl9XbW9CxEKo9qAATaLYkTYZoy7t25yO7WWsYJWckthAxu7dX/VOf+eB48PMZCCNZM
 Ob6mMhqshRL9rcnsXBOFYc2QkAY2X6zGtXjm7azS+74Ohe58yn6JjxkmGkyFSJF1l9/e
 3a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794107284; x=1794712084;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rR8VPeK3FB85MnmDJy6ge5uqblGvqjmVoHJKO5NZYkU=;
 b=w/psoMrMwqAJMtRmzfxy7PQpiflVmnZ17y+ADaZ/AVs06POWFASn9kFaTmHOdS0fCv
 0OCmPRkO3GORQk3MfSZnmBjJKzy8ohGZAEYU6H3b36qHyDxDICHrkIExMXZCw8AfFX64
 DV/QQwPa6NjVAcMBTXAqIJgWOaoDwIwFPV3yuHacWVcNx4Y2+OR6+OdSRnhYoLTA2Zg1
 yR35wFbglxThEIoHJiGW52b6P20BM5bDxRIvNStAMBqpskhvggvBPkqdG/SqXVQLus2z
 3b45fKkfBFaePSmj3IHboarE40+fvnugChoRvIV4uyxOlFrMWbr/TYHuX8DrczM1MoFR
 kz3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcJQJDWfxvBqAeEpaW4tzn4L1QRE63mho6PUOFBTL2fDlK/ZPqdhxEH1yZoA35++xVxVBAhXrCLlU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/AnuC661mv20yYhnmsMh8FJ7c8+zgRVzTw4vDxITG8y/vNHe2W
 VrMaUULgzYojpSZHCtbsRt9Q/JMgfy42/AMhKdoaM6t7lDNc97v20EDB
X-Gm-Gg: AYBFou21joSQZ/+txjIS0VWC3POm2Fd789aGFZ1llkzJl/bzuUYJVwZKG9pi8eBBc34
 Q80bAZ3glktk8q2eHMYlhulCUKa1IeihnqtpBJvVI6TQpg6JW1BGo4Nd8ByS3AtfIeuhZHaOVeU
 2Fa7Q67Ln7E6Av2n/nFdG2iFnnGyKoZ0WFPY2T9DXQcVVvsoLfETkXfXc5d/gYWIhvAOme2cHTX
 U8rQnuzM47hQ4pIuhh94J0tZ/P6xudU05Gwu3KjLYR97DolS3FQvql1sQs72hL8iHAXu9P84txT
 MwINgfXKrnxb2MiJ8SDhq+9Ubtdatt/d32GXPPSJFKVhrw+AM9/CVgfNCARQTlLzzfepb9xITqQ
 bhVvAHscN6ITeRMTv7HjrPU2FBWtEl9pMXWGwhOerTI3pEwJ0fRi0ytI6he4IHdE/SPgBCpvXPh
 FvyxnWVWojM5ECYT3W5aHzT9uibXUiDSKPC4W277tFhqcOaaet9njKf5N4iCdKFIGDGW4wAaN3m
 8p2hD13E/wHQuNQ1FCHO9I8EECU3iF9Nx0XJ27R7G8m4ydOGQ6JhLDxrHVtIIyjT0/5/lSAZbrX
 ONvLqmOMms+ZjurZn42TkunqsmOm2zikp76fTkeUbJ/ZHQU1GxwoJb7wq4wME/R950EaCXVpmav
 jzvF4Bo51CvcFPEve+GVptUvHNl0=
X-Received: by 2002:a05:701b:2311:b0:15a:4155:3d9d with SMTP id
 a92af1059eb24-1b39feb42fbmr606928c88.31.1794107283863; 
 Sat, 07 Nov 2026 19:08:03 -0800 (PST)
Received: from ?IPV6:2600:8800:1aa1:b100:c803:e868:a462:afb5?
 ([2600:8800:1aa1:b100:c803:e868:a462:afb5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3755e8838sm2123586c88.8.2026.11.07.19.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2026 19:08:03 -0800 (PST)
Message-ID: <13083638-9316-4d5b-8590-f104de3def3a@gmail.com>
Date: Sat, 7 Nov 2026 20:08:02 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/vkms: support more formats and fix RGB565
 regression
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
Content-Language: en-US
From: Sidharth Saha <ssaha2000@gmail.com>
In-Reply-To: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Matheus,

I tested this series on top of drm-misc-next (7.3.0-rc4) with vkms in
a VirtualBox VM, running IGT with and without the series applied.

kms_writeback: writeback-pixel-formats, writeback-invalid-parameters,
writeback-fb-id and writeback-check-output pass both with and without
the series (writeback-check-output passed 4/4 runs on each), so I see
no regression in the existing writeback path.

kms_plane: pixel-format-linear-modifier fails both with and without
the series, on the assertion in capture_crc() (crc->frame != vblank),
before it reaches the new formats. This looks like the existing
kms_plane CRC issue listed in the vkms TODO rather than anything in
this series.

I wasn't able to exercise the RGB332/BGR233 read paths or BGR565
writeback with these tests, so no Tested-by for the series as a whole.
I did test the RGB565 rounding fix with a KUnit test, and I'll reply
to patch 1/5 with the details.

Thanks,
Sidharth

On 9/27/2026 5:52 PM, Matheus Alves de Almeida wrote:
> Hi,
> 
> This series adds support for RGB332, BGR233 and BGR565 writeback. This
> is done with new helpers added to make conversion easier. It also fixes
> a regression in the RGB565 write conversion. 

