Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E4606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ro71Wbma
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FE310F444;
	Tue,  3 Nov 2026 08:22:04 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5535610E17F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 02:28:33 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-53653e30353so63926221cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 18:28:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793672912; cv=none;
 d=google.com; s=arc-20260327;
 b=K/+gsb1rd9ojBBA4jfPr/tMN+TsebDLqCPK6o7Ks3IKu85FG/w77p1XgFBpUyqHWIk
 +zNzaQGRfvdfOvdjqLn8fWfr0FItO2NKBf+x4WEgM3CXI2mkSIs4QoS+SHHW92n7lt7k
 HyuR+RbDfeq7HCL7gQ89WpP4tvB9mLbUUCxb1+C/Fv6pqAT5LiKM4TSY9FUOIMJFpI36
 C8G0CX2V23A38IjlVzXtxP4siO1fvBqLXYua4GY7wzTTn9H4jhkfEVFSFhV9ev+rVG+A
 av2B4U/dIYkjVTZ7X7vt4JD4BNrPs/MvUWquHpp/vGasM4GzDvWERmu2gsUlT3+IPxvK
 GA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=43k2JoRgmvLGktezxg5Tqe/6VKPUAsfo21mLYAXJ+uI=;
 fh=W/w6C15H5R5OIbLL6hocE/+yhMAVo+kJMh14lb1RWvE=;
 b=NFm4bO18P4joLLVgwc6/8YzmUv6mnLCHkkAnzV1DbE+BOEOcnKu8WgBT4B8RHqV0gk
 uknj2jmnVcweV8YvnKyAepXrA0J53Zoon3s0RJsGs7I3R6q9oWSbtwXmQalhMEoOle3+
 Vfh32ncokEH8RcSKmPljBAEo4nPevObUYvlFqaAvAOdP1BicJOxAJeg69DMoF9KiknIh
 YhTjlCqKpcBQoK/cTBZYW9jYWF3I6upHkyG2uZ5pXNYpum8u6UF6Tgu/uhrmXhOi9cIF
 jDM86O3R90NV0gEKBvJZazUwkxRuMkbsa/da77U40B+c77uzkD1xesLkHPaXCsYJxt9c
 uFEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793672912; x=1794277712; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=43k2JoRgmvLGktezxg5Tqe/6VKPUAsfo21mLYAXJ+uI=;
 b=Ro71Wbma+heNRP8rEdJSFMVQZSX/2JVT2YM6CZbDHw7m/u7nSRQAFVywCp21FUfGI6
 N5vWJlgJdeAIwaqq+Y45TidfvOtmRyVR0X54iwTd9TucVdvtzP1HpZOTQh8YtNMEmPgi
 mqfBOEkjI0DfsHG6qMBq00ni2N/gaOvUf0VI1a2a/dPRlCsOSgVGTwH/44//SJVfNwC8
 eAC74E5A7TfLv4DnoIhltrhuymWqCmly3rTB/wm78BAeDV6YPQhPpe/KXCDqPEDh/mtP
 Qv7mqJdlh8/gO9wHDY5YxvhXClmb+a/KyCq5xou05wCtO9m76DDD/AEnRIvckByCJ8oK
 c9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793672912; x=1794277712;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=43k2JoRgmvLGktezxg5Tqe/6VKPUAsfo21mLYAXJ+uI=;
 b=lT4whI53e7R3+fg0yPNY2h8e6/ZBfhQE+h9M752m7at5TkqdqzJ8UJE0E02kUv7htd
 stKUmF22tj+GJcYXiOnMcOsP5uREBoArtK6/wY080DufPq8bTRr3d1QG02Tm2bLY1ZPy
 PAcZiSD9qoqImKVc4U4Bpc0GALhkT9XFwI7x2vQtquEugYWUI4EvM5rk27n3ltojOwFZ
 dIVF1bUDnQ8jMhTJDkqMxrd+dZ3ydXLWfaG9BOSZiB4PPe9E3+D4wDAqimUgbVf+u5oL
 R/e/HcxI62Ig48yAeROsLogp4skADQV6BcHO8pWvXCedwlJFRQgwQIo75kVNHY0WsuEI
 M2Mg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0Lm7hFD5ZLDKIjFKGTW5ycD0dNk3+FKDBtYNwNV2s0gohEeE/wEoGoXDOhDEJDs0fT3YkaerOKFA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/RLLp0JPwhlwNhdHD+zyFzpWw5lhXC/qSSq4YCfesGEQ8Mw06T
 o8h3nCk1cRW6QPWU4Hs6nq1th+lT8GjWqJNMZqnOSoXd7hAwxgYFO0PhBl8qEDwBtS4YHY00HAw
 wNALG4LWmOKEM0XvLEjWFo6w2F5xWMWQ=
X-Gm-Gg: AYBFou3hU/pDFgl8e1uH1+P6D7iNq4XONE4aCOhJL6SOMRMlQ6gz/pz5o2YNS79sv32
 q5NiSwYtQUQ32wDF9b8R81VyefuaSf2XJy/hnAOyYXWdT81mW+MH+0wpp7Tsh+0p1gyA3drdx3+
 KAVP1dotsUBB690WOTeG5Cb3Ft63XFBXWthnwMcBEq7iYA0DlnWS5lt9ayxruKIKruVLSUqPfQr
 g7PDZqzQ1cOLLmjoqB655CfvsCz6zqpn2TL2CxipsiRbBkUISBtPmNcGQwr8CL2h2mW5SypT4g4
 V2zLyjUpRIWI3KHZdWVXXCl8olXFIme0d9hTmcdVRmRafHvKeBjz3S7MBK4Q8fVoa85jAAUHtWh
 UCsVdYS0LeRN/o/Ep/aM4F0Gewq4X08qnQrRfBg0dzJCoi1WsZi/wvf3ps6vxkdA2Rb3X741NcE
 wM9rvF0wK9nvLgN43q+5eOt+oLeQl0yf6SbMWv10HrdwZS1areuvpeGm2N07EaSiVLIrj1J2JxO
 uFxWehCm7opAjOl+NNhiLzflg==
X-Received: by 2002:ac8:59d3:0:b0:536:3a49:f76 with SMTP id
 d75a77b69052e-542b62a60f2mr208129931cf.27.1793672912039; Mon, 02 Nov 2026
 18:28:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
 <20261013-sahara_protocol_new_v2-v9-1-dc9f24357c4a@oss.qualcomm.com>
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-1-dc9f24357c4a@oss.qualcomm.com>
From: Daniel Pereira <danielmaraboo@gmail.com>
Date: Mon, 2 Nov 2026 23:28:20 -0300
X-Gm-Features: AclHuK-mWSKXd9lnXqiSNJlntbzfXiWNAcEZqwA15ieqTiGdj9OVEQ3Jtku0h9M
Message-ID: <CAMAsx6dwZVCVQpfh9DYVU3NoTrsbRLOiORdMKm3Yo-vQLmpyFQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] Add documentation for Sahara protocol
To: kishore.batta@oss.qualcomm.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com, 
 ogabbay@kernel.org, mani@kernel.org, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 03 Nov 2026 08:21:45 +0000
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
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Kishore,

> +| SAHARA_MODE_MEMORY_DBEUG | 0x2 | Memory debug mode. The host should |

Is "DBEUG" a typo? Shouldn't it be "SAHARA_MODE_MEMORY_DEBUG"? The
rest of the document spells it "debug".

> +| target. The Sahar client interprets|

I think this one is also a typo, right? Shouldn't it be "Sahara client"?

Thanks,
Daniel
