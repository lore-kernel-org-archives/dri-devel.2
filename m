Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ED5C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B03610E82D;
	Mon, 29 Jun 2026 11:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVj2aBc8";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B17210E052
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:59:53 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2c7c61b5292so25484845ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 00:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782719993; x=1783324793; darn=lists.freedesktop.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rezmMRoW0TY1v4PkJTz+2piz1eElRyv9KkMLuNl5nCA=;
 b=jVj2aBc8hmi7kquac02KufwaI07r52zb7UstWV3Vnfa9ylbWchKVD1+DgHzPBmQywI
 ipSEedaBqNIDbpGvXO99Q3PC1Legg3GJFNFylTqPOJ2iwqt/dl/m/a1hbrE6Ou2G+i+G
 ERYqX04ANI/M9Al0bGSgtUdh0ZYRCFmmbBlEafhvRr/kKxw/3caopM0lOhggAOBjjwm1
 IsXPtRZBAEfztoBBSx1OVmpIgpOf4mH59hDpBOLfk2jKi4RN6AP8UyrJ9qaAVV7wYKDi
 ti6bYIjrjarJwsYqdHErfke3B6edqfcSl1vPIuvSpfX1rudoF3Do02ZOPtjPvtEkfkAv
 OdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719993; x=1783324793;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rezmMRoW0TY1v4PkJTz+2piz1eElRyv9KkMLuNl5nCA=;
 b=pbfpQzhNzgnX6itJBa9BEveo8XlauPOBzz/1Hqr+OKC+ch0JLC3c2iSdCLVrsXYt+z
 W5P7Z4ysRwH5u0lpSyI6apCVC3p5mgPweIW/m3i5F5vnNnmvXgvvdUTh5yoSdr9m12ud
 MC0iSpkcD67ZkuNxeKEBJsepEjhfzFGQk68sjl+6GFBsXhGWZQUKNfBEOD9TQQ5L1hfK
 EAfwaJ3nJzEy/RR2InIsf3KiDOXRBcVT/ce88BWD3os9tBDm3XT/AxoLL/julqwlugSO
 OGqft2DTBdeVMGyVj6dkTQybZtr7kbm2Pk2+VMWoLFuMlRBKch8YUfT6zKmReGTuImoC
 kiRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RorfHb8Ym7hqWsGhYgoon/987THn4kiiKIabMYLPG4dvGjH2A8xz8v5+MoNB6Sx9dB6ZlVF+KNhtMU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxgm5PM+GhEXOw1grYNEtp0LPCQiYFDJMetzEyazawICm+grbdx
 1HZemOYmlAcrk/0380WBERkoXo5MLHsQpsNoruahplwGVougvWojI9nI
X-Gm-Gg: AfdE7cmvuUcpkzIwAJffK9X6cNHjj8o1jRpHgIrKkj3E6gRCoQzFpHIO5WLBGEdJcpr
 K+UHW1vyXNL3pb6HI3yY7MWlxK+zTLV3JRPYmJZVf44R6Z9pqDyTCVADSs5ph6VFGQwwP717fS9
 zikxvyFBLXq9tx3NPEHX2m8WFILJSQeN9YE5ZVgiVsqaGBQqNppR42h9u1x9TAL7JEi9UDjpvUz
 kaBssq+aSU6pMB/i2cCTSKTmo27tvMtm98WMhQ7lWaUAmgqdh/k8uo32FhXBpZAK5HnmTw33GHs
 nQ4yBocOAlCF+PYfrsNU/SimYnE+uNlTLIPgroPj6c1CY0CiG3NuwIfFaxHOrjKwJEyvGCS3yAi
 gNW+1fZ00xuxpy1KkguN1vsb1Pg0RTXC16VO8ogmPL3Hv8DMTTSEHcIerNiB+xaMRZqpIAQ4a41
 NApfhHqqEsd3W/vuZJDQPE925K0ZzIFOc39a6gbjdT0vb0JRAMvCPXylTAeT2dbBYByxGivFEtq
 o9SYagSr2HQQxwnmAWJwz0bH2Rm7U94pBXyfDut
X-Received: by 2002:a17:903:2443:b0:2c9:ceb9:865b with SMTP id
 d9443c01a7336-2c9ceb989a7mr46743485ad.21.1782719993052; 
 Mon, 29 Jun 2026 00:59:53 -0700 (PDT)
Received: from localhost ([143.248.188.236]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9cd6916e3sm32503885ad.40.2026.06.29.00.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 00:59:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 07:59:48 +0000
Message-Id: <DJLDHST0Y4ML.68M47LW7EDG4@gmail.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "SeungJong Ha"
 <engineer.jjhama@gmail.com>
Cc: <sashiko-reviews@lists.linux.dev>, <ojeda@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <dakr@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>
Subject: Re: [PATCH RFC 4/4] gpu: nova-core: gsp: convert GspMem to zerocopy
 via the transmute bridge
From: "SeungJong Ha" <engineer.jjhama@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
 <20260628-dma-zerocopy-bridge-v1-4-9a2895ebe30d@gmail.com>
 <20260628172200.B116D1F000E9@smtp.kernel.org>
 <20260628182154.712621-1-engineer.jjhama@gmail.com>
 <DJLCGEB0ZTL7.3C1BGJRHW35HC@nvidia.com>
In-Reply-To: <DJLCGEB0ZTL7.3C1BGJRHW35HC@nvidia.com>
X-Mailman-Approved-At: Mon, 29 Jun 2026 11:23:45 +0000
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

On Mon Jun 29, 2026 at 4:10 PM JST, Alexandre Courbot wrote:
> On Mon Jun 29, 2026 at 3:21 AM JST, SeungJong Ha wrote:
>> On Sun Jun 28, 2026 at 5:22 PM UTC, Sashiko AI review wrote:
>>> This isn't a bug introduced by this patch, but could this coherent shar=
ed
>>> memory lead to a time-of-check to time-of-use vulnerability?
>>>
>>> The driver validates lengths and checksums by reading fields like lengt=
h
>>> from GspMsgElement, which is mapped directly into shared memory. For
>>> instance, in wait_for_msg():
>>>
>>> wait_for_msg()
>>>     let (header, slice_1) =3D GspMsgElement::from_bytes_prefix(slice_1)=
.ok_or(EIO)?;
>>>
>>> However, receive_msg() seems to re-read the header fields directly from
>>> shared memory to advance the ring buffer pointer:
>>>
>>> receive_msg()
>>>     self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
>>>         message.header.length().div_ceil(GSP_PAGE_SIZE),
>>>     )?);
>>>
>>> Can a compromised hardware component modify the message length concurre=
ntly
>>> after the initial validation but before pointer advancement, potentiall=
y
>>> corrupting the host read pointer?
>>>
>>> Similarly, send_single_command() initializes a message header in shared
>>> memory and then reads its element_count to advance the write pointer:
>>>
>>> send_single_command()
>>>     let elem_count =3D dst.header.element_count();
>>>     self.seq +=3D 1;
>>>     self.gsp_mem.advance_cpu_write_ptr(elem_count);
>>>
>>> Does this allow the device to race and corrupt the host write pointer b=
y
>>> modifying element_count before it is read back?
>>
>> This is pre-existing and not changed by this patch: it only makes
>> explicit (via a checked `zerocopy` derive) what the previous `unsafe
>> impl transmute::{FromBytes, AsBytes}` already allowed implicitly -- the
>> layout is byte-identical and the message-handling path is untouched -- s=
o
>> it neither introduces nor addresses this. I'm not familiar enough with
>> the GSP threat model to judge whether the TOCTOU is in scope here; if it
>> is worth noting, I can add a TODO comment near the affected reads.
>
> So I understand that this as a copy-pasted Claude/Sashiko block, but
> would also appreciate if the human behind the keyboard could provide the
> context required to easily understand which part of the code this is
> about.

Sorry, that reply was an unedited block. Here is the concrete context.

It is the message-queue read path in gsp/cmdq.rs (wait_for_msg() /
receive_msg() / send_single_command()).
I haven't touched that logic; this patch only swaps the unsafe transmute
impls for a checked zerocopy derive. If it's worth noting, I'm happy to add
a comment near those reads.

Thanks,
SeungJong

