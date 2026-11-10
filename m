Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746E606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GW0J9v8p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F77310EE9C;
	Tue, 10 Nov 2026 08:33:43 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D5D10E2E4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 06:34:35 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1381776f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 22:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794292474; x=1794897274;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I9ebCGWZ0mC+PUR4y5En+fdWv9ikgrT2psh5wf3qqR0=;
 b=GW0J9v8pYCjDH8BTLkA8ciCnxx77AJrQZkZR0AUrcUST1XFhUlO/Kj23nj+ta7/k0z
 dYcFzfPtNQXVY2grRiwcIbxjki41rJQSEfd5V5u36MJI878BQo+eloWUuZjswimzOJsa
 +bxQxcN9tzNdRjP98su9olCoyiy8LDdFgBLVWWiF7BS+kCmpumL8UnpYRp7/R/RtWXYL
 Gyf/pNyG/PH68dcHX36Huxlbr8n49CupRmMgwzV3qzkGNXFuXGEod3ELmlQt9dIMTnK4
 qRwnQaKZ4b6n8SnXnbZjem+pUmbRVgttvicCkgWNTIVWLGBZaij1WAiRuSy7eKqbBs61
 aotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794292474; x=1794897274;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I9ebCGWZ0mC+PUR4y5En+fdWv9ikgrT2psh5wf3qqR0=;
 b=w/zjFR2COHSPgDcRqyQ1AuC977zWfgAqMfWP0wyPpm6zNgVsS20HZj6WOsjXJRjc3W
 VjTCQ7x8pATy6C+jSFAq0bMat/kWaB+ki9GK/He4F9j0wFddEzLq0Afj1jRqQATARLdr
 QkiwU+VdN/DNhBmZnXdhTCcYOuQLftiq6xwSj7hE/3+t8+MhCP3yWf0omnqrlqH5JfHC
 VdCOH3QXcGa3fcPxqNO1mGl0bU/WscVjCb6zjrjDj6MecF9uqyoZO3KiLvW57SSUCXS5
 IzGWlAQqmZqLTX5aBu0lx6xmy1ZUCz4n+20IFT26uvJltfDocHQaLj4IBPQ7kny5mBJj
 Lqvw==
X-Forwarded-Encrypted: i=1;
 AL+hErFihzyT1Yz0hB5cpdm9plbTqv7JSi9cye0dY/uGo0FqeU2/w4mbNC1rxt6zztoFS2TlB77A4PwSJws=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8LJAHEW6oZ00gpv5TwzTEy0yKSbcdGfgRGhhrDeaWdZm3wlBkY
 rsD0UgeP795wR94OvL4R/L8pAb6sH3ZXtKRGDSmkSoS7GfZ1wsm1D6G9K8Js4rNrJ+8=
X-Gm-Gg: AYBFou1mvtIu8/T7y6UA6y5rmCsOlVomL4O8fOvxJPltzbCgX5HVRo4npk3mebxFP68
 0hA9pbLicHXsc99QkMOpSXBPwid8YcAC5Ofn19k8rfHvc5h1VoQ7fARNofby/x5xlknNOAM1Tlc
 JhpnpHLR4WO0HsEHAJP6VoOrJ8hRDv/wYUTW1JWVVFhKjZKKJdggVJTas/gvH2FLD5cs33HDdD/
 MlVBwR167blRG0vjRB9bRpvjyDQE9x4UTMwGrkk23ysZWNFKbCguaUjvwyMuRhV5Z+UrzstJs1d
 24LI4EVeWqy/o+zw3Z0w9tHWvGqqF4llfPgFubhQ3ZYhZE5NkpwBWFj6FR9lUkjtKrISjDDQS5c
 RReUapiFFSJ0DAcdHMpnX3sbgoiXvDe9TUcHVgIz+fRktiUqcFaJspDRX/kYf9SHDDLp7uONqb6
 eCkbKsrCPOjLLKjOifAcpr+e/O/zl6vdujvSUKpSm5mXOdCR2RcSqnCZxtmBjvUjExZtuGW33QC
 h4P+t7yr8h+NbmQonXbsto9IyIm54uQ+HkU812GUpDMim4Z9uXWyyYLkf9ZBpgS9nCeqYW55W2w
 mA7g6YAN+G5hp+nIbLXu9JpzVA2Mz8aFlrZLkPhSDS9MoNB8L0tu4pdKF6txU9HGD+l4LgYq+cC
 qMA==
X-Received: by 2002:a05:6000:1884:b0:48e:4115:f3e8 with SMTP id
 ffacd0b85a97d-4982fa5d320mr3039782f8f.27.1794292474246; 
 Mon, 09 Nov 2026 22:34:34 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a495csm3025664f8f.55.2026.11.09.22.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 22:34:33 -0800 (PST)
Message-ID: <62ae500f-ab3d-4093-b7e4-5d4951419bf1@baylibre.com>
Date: Tue, 10 Nov 2026 06:34:32 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/etnaviv: add the Allwinner T527 VIP9000 hardware
 database entry
To: Phong LE <ple@baylibre.com>, Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20261102094343.2086424-1-ple@baylibre.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <20261102094343.2086424-1-ple@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 02/11/2026 09:42, Phong LE wrote:
> Add a hardware database entry for the VIP9000 NPU found in the
> Allwinner T527, as used on the Orange Pi 4A.
> 
> It's coming from allwinner BSP driver in gc_feature_database.h with
> vip9000nano-si+ IDs.

I checked the minor_features values against the vip9000nano-si+
entry in the Orange Pi T527 BSP gc_feature_database.h. They match the 
existing 0x8000/0x8002 VIPNano-Si+ entry apart from:

- MULTICORE_SEMAPHORESTALL_V3 - not used at all in vendor kernel driver
- SH_END_OF_BB - used in vendor driver PPU flop reset code, etnaviv
   appears to have equivalent behaviour.

Reviewed-by: Daniel Drake <ddrake@baylibre.com>

