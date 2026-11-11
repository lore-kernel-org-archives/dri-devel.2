Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBD606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IwOMmVDQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF2F10F952;
	Wed, 11 Nov 2026 08:23:41 +0000 (UTC)
Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E659710E280
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 02:47:25 +0000 (UTC)
Received: by mail-oo2-f9.google.com with SMTP id
 46e09a7af769-85f2bfd7a07so1061899a34.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 18:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794365245; x=1794970045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0Jnm/5z8Q1yoIKS0OWVHvnc1/e7g1Ta22xUQi/ka3a4=;
 b=IwOMmVDQsjXv52mV4h+o/vFQTMccBhgCLVC3Vpuk4dotCzs7zq9XoCO1ShU0O3ZKMe
 vs3RNTMQpl9tAb6u8IzDYVOlU+GStU3EUUlzcg4oEKZG8OXHuAUYP9Eo69mUEi1HKHiJ
 F0PxpQZfJxf7gVTbuz3VmWyhdTaQ3l1NPO+E7Zp828CHihNbC1PxiR6tDUHkLsw1JpmU
 mhU433bRMaXdRL3NeGJR3AHTH4t6cN4E3TBAErfOSuOTsBMYYvRgAciG9xjx13NhU5vw
 m3Iv4G7TCp7405gefhcn4AyCRNG+SHxLWJOHJnj5abvnL+OH7VwyogWJLe4RkNgOTL85
 GNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794365245; x=1794970045;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Jnm/5z8Q1yoIKS0OWVHvnc1/e7g1Ta22xUQi/ka3a4=;
 b=pYQ+ZMykV36RpqZAge0hUPMFOvkRrBPE8ZiCIbm8qk8urrjh26WyNecii0k+Gl3xKp
 32mpQtrDe0NDN/OvxT1+mE3WDIbRZrQddXVuLtv1xpw90cWw/K11iv/FLzG0MNfng3r+
 e6fTAKT6bt2Tia6NM3l3uU22fL9z6mlcyBbVBWJHBXmt3X2WjQWCD5vFbsZQtFMe/g9/
 qAJaE89dL7edcbq1VgijkLOChSeixjVAnBtPZOIfrg6JtWxtAa+10l58B464Xa/Ypww/
 bLx26ZRFKYrawP2M0UECj32jJCiLgR24I1v1uqQY44GBWcL9kzfHavVLLYAuY7J+xlBG
 zWoQ==
X-Gm-Message-State: APuU4Z+jQM1IK55n6p7pa4DN9PGooAfSXxVpyrztLk2Bpkgjc5DBdEsG
 ovCR27l34/bKzCzblC0+BcjeVGlQwhNbGoNouxT5L4LRK2AVXQvFfmKY
X-Gm-Gg: AYBFou11FfqZx4i2CD87rDaU9FLZZmU1mwEriiDbymuU7J9F3onN1brroPyKzdkItz+
 8d8UYAZHIUhxvKQVK+qdKkrcSMgZRS9KH6LTFEMlG+2QTlSf9ZSrcI05KGD2YxmMN8zx/pgmF+v
 eywMt39Xl5lcffxdBJ7BfEmWO+TKg1mxfRIu7tFlTr/SR20uq7c2+VwAqRNt7x3P/50HyHaEwvE
 ZAb8//1/8ljIJ2ri1+BmYjcowZwKsrO5c+echSWC8kLtB6ABDfHUgy7RDYRmeLDsnq1Tr4rK750
 GlXrgV40m1+NJlx8he9D4zexnicj6Jz0+sxzfS/RgKu6Y3mmyCoM0+Ym44hTHk/LfCMKlRwHJir
 eX/YCbUEL03rZRdXXIHm0WU4mFMSkAhYXvNIe+czX2Tp/NVLitv0Lr27K0XA/thCgFz0Sct6fgJ
 2RCnUPfrFPHHcd2uItj+mLh9C7nTbTgJdIXNggL6oMeUCHNLTJhr1JitQMLeUqhE+qby5++et1T
 kk1a2pzlOi+JgaP4vdg7QUDcOvF5SRxr15F+B491t9dP6hkuzuhFTQamILxwooAjFuaZdBB0o28
 WCZWAXalf7Xpyl5RFFdN7KbizdWyelevA2LA3zoxxP/C/Q==
X-Received: by 2002:a05:6830:914:b0:80c:d30f:97a with SMTP id
 46e09a7af769-860f294e49dmr1058089a34.27.1794365245058; 
 Tue, 10 Nov 2026 18:47:25 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::f01a? ([2600:8804:5716:d800::f01a])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcb5f7b4sm3385800a34.4.2026.11.10.18.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 18:47:23 -0800 (PST)
Message-ID: <9d13c622-4e8e-4a69-be47-31861f6972d5@gmail.com>
Date: Tue, 10 Nov 2026 20:47:21 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/mediatek: dsi: force command mode in
 mtk_dsi_poweron()
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261004-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-v1-1-53a4f46ca489@gmail.com>
 <8c8ff7e2-d1a4-45c8-aacf-bca93439a32d@gmail.com>
 <524b9675fd10d0d21880821c10a4f0e188d24956.camel@mediatek.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <524b9675fd10d0d21880821c10a4f0e188d24956.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 8:43 PM, CK Hu (胡俊光) wrote:
> Hi, I'm Chun-Kuang [1].
> It's not necessary to resend.
> I would apply this patch later.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93e97f715b24114169d18654e09c646fd9e14979
>
> Chun-Kuang.

Hi Chun-Kuang,

I'm so sorry, my brain must be taking a day off :p thank you for the 
response!

Best Regards,
Ryan Brue
