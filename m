Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A97C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E219C10E160;
	Tue, 30 Jun 2026 04:22:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lek8dzdl";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D028510E13F
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 04:22:07 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-37fc02e660bso1736839a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 21:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782793327; x=1783398127; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HxIwnvg1dJPUJwltpuvbg1AsYwjZf+P/fmHcIreJDzI=;
 b=Lek8dzdlwfGeTrgCBC4+rlO9z6FmFYGn21Q5xVweq1HLg5mUCZY1ZYJHDLW37Kj95X
 IKhjulREFBkT5aSGS0SQU5JJcMdDHnqeA3L+FL3PDg6YrbB+T/Gzf97DOJmQutzV+KZJ
 +EB/UNCoBqhacQL72XPzBinyuPVfj13atAIiq4e41+SXFiO1PKzXnJy+fzTe0wv0pbO4
 261s0I1LQo/ugqLednmA0aJDLbdVRzcTycA1oZvm0vKoFt9/AR86lwxlUIZaGmkFNpmo
 0bGkJRzajHggBX/EmGNZSaX+yZe2zJPb+4MkuaWLjTKzxb3Kg0XDD7OLRCxJ3UHHtV2Y
 OZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782793327; x=1783398127;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HxIwnvg1dJPUJwltpuvbg1AsYwjZf+P/fmHcIreJDzI=;
 b=hM68uM8gzRrjNkpQrOmtRrzfWc9Vezj6mBHmDTwZtqcjRHSiyOXd3fhAB9Xzzx4Rsk
 AcYZ1ZnVHBSL1PM3U27Nlg8Yd44vSMdNrkoUVperjeOYpoqr6gCPHxmrsQGmlpndgOVQ
 4zSoX2UUuGz4W+WDQB/tzDbK9CN2hMLdco3rqajbgUKTJuFKl7tVNpGMXf5TL7WJo/NJ
 aKdwVsjH/1y3FMiMGHpKqvXL7s8zsdWZUk76hL6VuhZzfJy9wWHxBzEhYb2gWg5VVYFY
 Be2zomx66oWTJBgDr5MgCm+QqUF2NWRxm++9ynNgMTvxyut+4sC+VmoyQnDyQqBgNLBe
 BjnA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5u+v2G0bEuTVBj85qhD5loS2fNDdUeT2wPd1pq38saAqNMrUuxms+8j2hQ8pB1aalCfvDT1sOrOY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNTux9on91E7y4riKg2GeKTTuKN2PTWL+Lb1kNMOniM1j5s0kz
 koJroujFMnTVuxeUkaFXICo/tO1mtDiLqq+RxJYLTartHm6yj7sgMk5DLebGhd2t
X-Gm-Gg: AfdE7cnp9BJrOt+qLWWZ6apXry4PLqwU7jP4zESYTgBJ7L67HAvRfCp5pKzMWqCINhb
 GR8ROvqg2jJgb7/xgVkK5EAlSQ17SajjqsRg86NtvaNGxPtchllTiy2QdyuNkYrlLOi5PGmukZk
 Jb2fFbCWduuJWePHAH3amtokCZ8m9pIQVHBeFhGSrTdeKtSllAl4Fblj4uLvalDyhBoRqWjeRkG
 YQatw6cI2QiWO1PXPW5WuRpDU9FeRJvaaWCQC9Z8Nl2dc5wSdteJTiw6ZvD1A9Y7T0G9NmSqz31
 yVvUqTW8NQWR2Bgjvwm9zgfOJ/XqY9pC40RVqpGm2HFzpM4YQGd68YrPTznxpL2Uokhqw+gRY1Y
 Y6o3FkvBRsOX7EUOvK7lKz0pCwVx1yE3kMG3y3B8288/awj5mWhajm0mNf0wz7P+CjbA9D+N/mU
 REJgDMmEOE4TOgBOnhVWKnthg4RXNIAveYnwh0hT0Y2EmfsUc8NnXbySb/2E90GgBXii0mimo3+
 AUs6pB+vzH25j+L4piILRKxuO5EdJWTSRu7ZkSBHkdJyy+3bYjuIsLX5tIcKPU+2mgNPzTvkm79
 7SumcMF7bSoZBxqpT+qzdpw=
X-Received: by 2002:a17:90b:47:b0:37f:9ce3:ca95 with SMTP id
 98e67ed59e1d1-3805278b763mr1468080a91.30.1782793327254; 
 Mon, 29 Jun 2026 21:22:07 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:80e5:49e2:c5b5:4cc0?
 ([2601:1c0:5780:9200:80e5:49e2:c5b5:4cc0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38052f47a3dsm832403a91.13.2026.06.29.21.22.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 21:22:06 -0700 (PDT)
Message-ID: <c3f61201-f1d0-4302-b726-04ae16294fa8@gmail.com>
Date: Mon, 29 Jun 2026 21:22:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fbdev: claim Cyber2000 SPARC I/O aperture before
 ioremap
To: Helge Deller <deller@gmx.de>, linux@armlinux.org.uk
Cc: tzimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260616043035.11952-1-chintanlike@gmail.com>
 <5879368e-1a91-4d4d-9243-dd9de9d06962@gmx.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <5879368e-1a91-4d4d-9243-dd9de9d06962@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 6/23/26 00:57, Helge Deller wrote:
> On 6/16/26 06:30, Chintan Patel wrote:
>> Claim the memory resource associated with the Cyber2000 SPARC MMIO
>> aperture before accessing it.
>>
>> This is part of the effort to request memory regions in fbdev drivers.
> 
> IMHO this patch doesn't make much sense.
> The PCI regions (e.g. for x86) are already requested one level higher 
> and are being kept reserved.
> This patch here only touches the SPARC code inside a path which is e.g. 
> being used everytime the machine wakes up from sleep (does sparc even 
> suspends?). So, instead here, I think (if you want to make this robust) 
> the region should be reserved e.g. in cyberpro_common_probe(), but I'm 
> not sure if this is even worth the effort....?
> 
> Helge

Hi Helge,

Thanks for the explanation.

That makes sense. I was following the fbdev TODO item to request memory
regions, but I agree that reserving and releasing the region in
cyberpro_pci_enable_mmio() isn't the right lifetime if the function can
be called multiple times.

I'll take a closer look at whether the reservation belongs in
cyberpro_common_probe(). If not, I'll drop this patch.

Thanks,
Chintan

