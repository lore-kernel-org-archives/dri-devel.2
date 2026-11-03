Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56754606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJ6HPdNb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F095310F2B1;
	Wed,  4 Nov 2026 08:58:27 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC72310F84C
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:59:20 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso8445f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 12:59:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793739559; cv=none;
 d=google.com; s=arc-20260327;
 b=WF/Qq1uMujxqVreGvTu+X+r1tWL5pZEz+8Yto0EtSHzphxHLT2HcyKhRmasrR3BQNP
 7pB45fP9Gx6VkegeT/uCsxOzjU2JEeOP2iT5KsTxPXB2vG/CIl51dUF95sP3JEFP5jPh
 u9l7ZKXvoX/RsfHNr1lRM4DsCXnDaAho5UGqftm/V6qcUjuhTsJv8I+qs1hTszY9pJaF
 bAvCiaGFJRdtM/HLREPGttFoWMEsXGXzoDSG8fRW5SPY2OhIafN72jaEbxHR7YdSa5kp
 3HEMZ5K+WmcqPlyw+Yq/Qcp7LfKg6RijlpDytvZrUkDH4GlTuh+zaixc24To0S3cZkr7
 avug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N522AsLlTU0HGBzik0UilBrcnusjUUdJmnwssk6MniI=;
 fh=Uh+n1RVyNLui3KdHQZgO5Ssz02JJox2ycX4si6LFlm4=;
 b=iTnUf5qWSYtGOZBxC59fZZyvd42eFJeNCXxPF9uNsNeGc1Kbm14eGbMKqeoBohrxhe
 S6YZoiWNA/N9wrVsLdpzSTtKf0csRIVaHU8G8MEnkuZWpgvRpIq2jcK1sbrre8G+JWh4
 B9pE5hVPLB5OzZNU2nklfdiSfnVbJpPUqteKurUJuTAgo89h/AsBibAAj7AGcxG/aZOH
 Xxy+orC+ygeQa2Ziez0d5/TDbWAfoq79TpVrK+uAI9itJOtjtjPtju37TNPQBsOG4dao
 JGTA/m8imXJzwvnZPyREKQE4nbXDoc9+qGGo+cqyigV/6fh+MCdh/qvpYN1KZ4YlpDEL
 v56A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793739559; x=1794344359; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N522AsLlTU0HGBzik0UilBrcnusjUUdJmnwssk6MniI=;
 b=UJ6HPdNbdwg0HQSq+lySKJr2HTV7+KOAAss2l7NgX8CG/sJBtkPnmUN4RkYHq9Sdzz
 6VQnJRH9aU7okO/Nze76Iomap2HkQHMu+b4d0iKs13bVUtz40MWh7YIUcxDE9ws97Pm7
 HVTFc3wbcOcIhPCOfNez47UbMAU81qbRWet2+mmnORyL+Ao0dpXWmHMhTMnx7MNz3KFD
 g3yR8Z3tOy4gMNHz9g3lgn8lQjghFsLz+bG+/1BW8/Ow9EkCFT15SAaK9E8saF2iZgu7
 cj78UjXKhr0INeoBXNvj08HcarAJC85xYMAG6/wfm8+622aq8sUQUz7pkJFbTV/JXGYc
 7ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793739559; x=1794344359;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N522AsLlTU0HGBzik0UilBrcnusjUUdJmnwssk6MniI=;
 b=k92hwr/O5sYtm/llH2Bf/iHGRx/ubSrUQMck34XI0KfGYpE7eDVrW1HxWOtuGOCO6u
 sQTtNjsh6fv8rZ4JKjivlFRJa2mIStX8ISTfr6G+xvG7g14h6RLN83JdoYnM3XsnabyJ
 eUBhjzA3GiPfXDRobNnEHQki8IblOiA9P/KH7VxASm9gMavA/DkN7SsOW9Rwun2wcozF
 Q86TtEWPvDTtm7KI6B+ZX6Efov/WnKHNAWnqyUDvgcAmXFf5Nhh5jrPBIT23Af6j0qMv
 GygkrB9opV+UDEruPeeOt7oKYxz3KVzmiFRHG/O3Pm+3l+6Ki43V2pTD6IOzHBl66mFx
 JeLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxp67Q5J3U/htaOm1g4btH0IfFQWB0Hs+3Wpx6jmSV3sz4qpXd+EBRZoTPWbSM4qmFx0FASGPhNB3s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8adxdFw9d76AQ2bZE9tAq+i1DvwMM+/9PG2C1Ka2a3bQ1q9Wq0
 Rk3sdGSzNcWkOZiB8W27RIAX+YxIPcQj2NgDcsB5WJxOWs015g6vQ+Cmh95Y/QUwoq30A40o9tY
 d7f7zfrfpVAyq27vVmLIG006JrQNRuv8=
X-Gm-Gg: AYBFou1Mvi4hhkWE8fvTe8GnBXBut59LCCQurxT6+gtvsxGzs27XaFKsJ/CrPHdSXmX
 TA8XPEw06fsZ+JxvAbMi4FmZfozTax2frjuYzIJHlx5n58WU81vLH1UE66MElQY6MfWPqEGweJX
 +dUWe8LseitP7qbQRt+3u0JafKNUjuN56PYZ1/0HiSq88jlpJ90loht/Ym/wC+aPI7kZtd5Vu2z
 /FFndcM26Uxt7rmSQHm5qWE40kvRaYQNz90ifxLkzypVagTOPubpQzjh7Jxn4GBwVGwtqZEQBo4
 AdJOgYCty/L1vl9vICtxBo0uMlyMsma3y+aTQ3gwWSz4LRrTfg4JQZ56abtT3kHx9kjVkVClIL1
 dG7aTvdlLAxu7a3dJcZ2+R1w0riCNyLMmg/TD+Zg=
X-Received: by 2002:a05:6000:1449:b0:48d:ff71:dd9d with SMTP id
 ffacd0b85a97d-48e6e2ef786mr30220280f8f.23.1793739558923; Tue, 03 Nov 2026
 12:59:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAGxFSwnBDM93ouN6Aq2ppm5zF1h19XE6NJ92NT2UEhMP1P4xEg@mail.gmail.com>
 <CADnq5_PyctWJK2k4-CutYFNPkuMprmZE98d2JjodBQkTLGJhDA@mail.gmail.com>
In-Reply-To: <CADnq5_PyctWJK2k4-CutYFNPkuMprmZE98d2JjodBQkTLGJhDA@mail.gmail.com>
From: Arnaud BERTRAND <arnaud078@gmail.com>
Date: Tue, 3 Nov 2026 21:59:06 +0100
X-Gm-Features: AclHuK9LGpsbyCsaaCaEXiY3-KA_CdLHeIgy5ZFJMBas5Xa9tgkDNg4pPpu0HGs
Message-ID: <CAGxFSw=PgG+hewz5eNcDDma57+oJE2qd25mZByyJ+4dFhsGpYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Oz Tiram <oz@shift-computing.de>, airlied@gmail.com,
 alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> On Mon. Nov  2. 2026 at 14:58, Alex Deucher <alexdeucher@gmail.com> wrote=
 :
>
> >On Mon, Nov 2, 2026 at 3:07=E2=80=AFAM Arnaud BERTRAND <arnaud078@gmail.=
com> wrote:
> >
> > Hello,
> >
> > I have two dGPUs : a Radeon RX 6800
> > XT and a Radeon RX 6800. They both report the same PCI identity
> > 1002:73bf and each has a different VBIOS.
> > I hit the same VFCT bus-number mismatch on 7.2.10, but with a different
> > outcome: on my machine the device-identity fallback actively breaks the=
 second
> > dGPU.
> > I patched my kernel to remove the fallback, but I would like to have a
> > better solution for my use case.
> > Would it be possible to apply the patch only to APUs ? That would keep
> > Oz's APU case working but a dGPU with a stale bus number would fall
> > through to its own ROM, which is the source that is
> > guaranteed to match the card in the slot.
> > I can provide more details if needed, I am out of my depth here.
>
> Should be fixed with this patch series:
> https://patchwork.freedesktop.org/series/176969/
This patch series applied on top of kernel 7.3.0 indeed fixed the
issue for me. Thanks Alex and Mario for the swift answers.
>
> Alex
>
> > Thanks
> > Arnaud
