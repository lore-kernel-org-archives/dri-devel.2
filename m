Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A99BCD4F3D
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 08:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3F510E1B6;
	Fri, 22 May 2026 08:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H08HdUBu";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28F510E669
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 08:31:36 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso6743524a34.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 01:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779438696; cv=none;
 d=google.com; s=arc-20240605;
 b=aH7brWZKPnCzNae7MgwkUDUrb7xE1/Q1jlyYZt9uUig3HDmOUy8eApsArCwC0A1GOw
 uxlAMjRt5jZMw35U0EjNsTiC5Sjuz2z/SUFAWTaUZTFqj/t8NoGaiJDLbLwCnEhZ1HEE
 JAlSmbw+eQKP270IUQUTFZtUobFmkszGyRUHpUDniUfmALVKwYeCHAfnhUsrA2ZRx6Rj
 v2A+NrIVqkc3mzt7a8WQhbbupSoSWUU17uWkt7zrE3TBMQr8jTYLsXhpaCV8UvypTIW6
 8LAj5f3vGiqrh8CyJUbAIOz444uFkFNdPRXYJy/XX6ADk1fSuJMMKHzOirreheZ+tbXD
 N6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9ThiWo7n+RoKO5Fmewf5eOm/6gdGdTn6HMevgFDP/mU=;
 fh=cVK9hrYfXWnRxMY908yHqnem0qSHYYsGRb9lDgiW7w8=;
 b=HyZDSB9jVMvrlNHmxr1HRH1flJXuBnjfeopHj2NvCue6CaNB4NxZ21YeY1Hgbd3H+a
 aHnXNcZBwvXQEQi4pF1Lkx+IrSCArN52niTrWjE7tCSt5996WZTScxDQ35ZKz4F6drN0
 KJ8da0kN1fQ9Vd8sv/i6qJrq01vHU1PY20K3Ya258QqmUDzUyrHGoFWDiyOf3L1Q65lT
 NjvA/VlffDr2rc8hMOuEt1ULR1csyQpCFdzsq4PfUqFRagr/AbsnLE7HM+L08JhUMIrc
 YDs9Pxnpbnu5jz1ns/eZhPfJQ7FlYqhzR3IEacWyObQmg/M9LP6uvCwTcUUUx/yAY9T/
 Gjng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779438696; x=1780043496; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ThiWo7n+RoKO5Fmewf5eOm/6gdGdTn6HMevgFDP/mU=;
 b=H08HdUBuwu46VvkyPvPg+b68rk6rGandYdFqq0c3AIBmcg8W2Vz0fX0OfH7snP3B/w
 Pmng3OdGQ8or8K709Bk3nafh7I8X/u16Ymfay5J4peN5vibd4S7/drGU7S2c7GoE+OZI
 cYIVkk8eXTlXMXV/au6hO4HcMcw4cI1XOVy8/TAIpUwVhgBDXbl/JQYw7XhMwcKq7Ewj
 rVuMBKudUF9BepjdZD88GgLwQBmZFuXPyy6OXzM+c5YW48n9YYwnr0scgBLNoX2M142g
 z9+/mIb/Non3vlBSAcySIo1BnQt3+kymY2TI//zvzkX6w9a2AkJ0FlupckLChkpsYR2J
 bO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779438696; x=1780043496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ThiWo7n+RoKO5Fmewf5eOm/6gdGdTn6HMevgFDP/mU=;
 b=R7bCJ5yIVJ0cYizE+kO0Mt6Vy0OnulR9dJh1cxp4eftNEyxf2qAeVn2c7bFO1aEvdf
 3S9CbFJPGwQwjhaO9T/L9/dsybzdvx5yLq/yMHqme39KIBTwys0HaRbnaj+J7mV52wf3
 +eK3GP+k7E2858YJi3AeXrNi2Ka3YDMgQ2EtxaHuufG3DFprUSClp9H2EzTonwa++QCj
 YRCyo64QOl2MvRX+XfYvNSe89dmB2Xm+aBZt8mShjaLAjHopyeAJCmjhUQPSNm5maRTS
 E4LLi6EQBbJGzImt/mHzRd1WdMOvIzLgI9z1XUvLAgCa1AvUBuUW/zSzhNP0HAWfo7o8
 Zo4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HhO/ICpm0werIT1A0FeCyOobUFjzmcSF5e3cbc1t92wBXjHLBpgauVLdzTpjMEvysJPBJZIh4Xw8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxngzO0c/YtQMiJl4curWbkQb0cG7YJXPinpiZ+AGW8Qrmbmn2O
 aAzoJ2/c5alaW4LiqDUHkNj4eBy4X58NShonejI07+HE+lOpmKEoQLB4OSvjZjquxkX+jhCmfbQ
 j6LYM5Q5GTNHQ3DTsOZ7eaRb7+pLPSqs=
X-Gm-Gg: Acq92OHe50VJvJ9hbJ/lOQC3trVbScytOumG4YteWDepqrQaVsSteBwBYrmHK+8W2j7
 YBaYDfCxKyKklLnqfAltQzUSKrzrBLz3fBPAeo7ktKZT0jZ1Ug8H0tNovmqXUiL2LJJL81X3xw8
 8CqDbLBJ7UYmvf5PWArt6sGbbJ2aZYRWZHKBoftPlJOiKP7Khv3odTBYhjRG+4GH0ujjSKfzxaZ
 VIImer8vLGQks+hG48KBhZnZziGOuZPh7WP1r7Z3siyDV2jeKgXnL9+kdJbH6ZauyudCQsHhD9B
 YtwZUaHMQw==
X-Received: by 2002:a05:6830:4707:b0:7d7:570b:6800 with SMTP id
 46e09a7af769-7e5feef54dbmr1560827a34.23.1779438695670; Fri, 22 May 2026
 01:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260521104335.28978-1-mikhail.v.gavrilov@gmail.com>
 <20260521150841.20625-1-mikhail.v.gavrilov@gmail.com>
 <20260521150841.20625-3-mikhail.v.gavrilov@gmail.com>
 <55aee3e4-9003-4694-b0fa-277a8c2bbbc4@amd.com>
In-Reply-To: <55aee3e4-9003-4694-b0fa-277a8c2bbbc4@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 22 May 2026 13:31:23 +0500
X-Gm-Features: AVHnY4LSbTM-4tTWAVOgrISJCrLtgJ-GyODBgDohHuk9RVR7oadaYTWLeSuLNrM
Message-ID: <CABXGCsPPY3qX7Ad-a7==nmA5R7aejCTCrmWYpn-9OQQU=1eMMA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/amdgpu: fix recursive ww_mutex acquire in
 amdgpu_devcoredump_format
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
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

Thanks for the review. v6 will:

 - trim the commit message: drop the reproducer paragraph, keep just
   the problem description and the solution
 - move the IB dumping into its own function
 - replace the break-based flow inside drm_exec_until_all_locked() with
   goto error handling, and drop the now-superfluous `locked` variable
 - not call drm_exec_fini() in the locking helper on the error path

One thing I'd like to confirm before respinning =E2=80=94 the !mapping case=
 in
the locking loop:

mapping =3D amdgpu_vm_bo_lookup_mapping(vm, pfn);
if (!mapping)
    continue;

You commented "That's also an error, it could be that we just want to
print the IB start address in that case."

My reading: a missing mapping is not fatal to the whole dump. For that
IB there is simply nothing to lock, so the locking loop should move on
to the next IB, and the content loop then still emits the
"IB #N 0x<addr> <dw>" header with no body (it already does this via
goto output_ib_content). The dump continues for the remaining IBs.

So in the locking loop I'd keep `continue` for !mapping, and reserve
goto-abort only for real errors (drm_exec_lock_obj() failure, VM not
found). Is that what you intended, or should a missing mapping abort
the whole IB dump?

--=20
Thanks,
Mike.
