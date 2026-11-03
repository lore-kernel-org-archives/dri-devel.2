Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B57606D823
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ir53l6w9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8365F10E569;
	Tue,  3 Nov 2026 15:14:30 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83BC10E6DB
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:14:24 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-36bd3dd31a6so82119eec.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 07:14:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793718864; cv=none;
 d=google.com; s=arc-20260327;
 b=YsgFmVjBkZ6bTD3oWxrga8agy5tTlnhNrt2q93j+WaIr42HsmP7HWgWhOCtVQsOPi+
 lbcyB5g84drSZF7u75V5l8W5OOWWTNEDawC0PkIrOp/wJeAkkrQuEj6a0BrGxFqNAyXr
 nB0/C8NMiGZVKYS7ug3umuxjwE7PTT0A2uC/JEQaElDFvEK8f5DGlgo8CN9JCv/XRjmj
 eoOb/TbBnrIDduaYfNvQfEGGdwrxmyADC+yAI+WntU5AvxWlMP1W+/M7CATKSY1Zu/3W
 hz/FWUhfj5yR9mVLRSXyfL7w1WgKyqWjcRvH9dgSiVN7isofGwIu0GyhjtoZDc/sC7P+
 pCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wJ+02nslmQcKlhyZ5fgKpqxNB0L+SRv9NHg/0WiGSU0=;
 fh=Hn3QI5g0Tiezs0eoY04EiWAxOS0AFb2v6H6MRmI/HFM=;
 b=b2LlZkWvZIAJMd4GK/FLJoS4Gt6HiX45qhRd8uwMFlC8AIbkCrTOOPkVlMyAyH8bL8
 nppjCzYt42PWHd/TAXQC/r9Wm21k+OdzBSAGckmDkokcDY969OwhFnNdJoetIQce+zHa
 RtnKjMVXg4fSQeVYeN1Xd7e+HUaw81Ykj02hPHAWRYDKMpEFs7VTXufoT+f6rA7logt9
 6J5mQG1ByprxyY+FJ9wo/xrO4pHKbrfhZNQF7uyBUIV2nSUu4vlD4XS2JV/Bs9KZa49n
 Dw7JGZMdTaH+oKp7+PMuThK7jSYSV8bGcShCXbIKzJN68NgLOJlv5OiFA2cRj71PZu0k
 sl1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793718864; x=1794323664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wJ+02nslmQcKlhyZ5fgKpqxNB0L+SRv9NHg/0WiGSU0=;
 b=ir53l6w9/hqWQJc+72c2dXNaE9fUOqD5yk1jC5i3ajNN+3A59OHRmDYHjpkzavn5p6
 abl2VEblxBaLmfxiBMdD3YwSKkkBQNhtDTgMDqrqR9AkkTpJTWr2LZnvFnYWXFys5zXm
 bQEF9xOBj+b5eIsC2C0soeytrJ+mjAxvtYXEySLybvTKkx9ZVxq0SOAA0hQEiN/BOrhr
 /6pL7nZAKoBUZ2nCPT1VN84nB3YKuzw+Xft/Vhnh5/9Ql48kW5QWmOHvjtyuAq7SbYbg
 tcH27bN00ayFJ34fYZIgKqsL2LaR4eBoJOj7a9xav163oaGt4Enuc1d2oXsn6o69Zeuc
 93Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793718864; x=1794323664;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wJ+02nslmQcKlhyZ5fgKpqxNB0L+SRv9NHg/0WiGSU0=;
 b=jH01ZmZvH8CbMMjr6PUqqddZM/GVtMB8kMb5DCdPrXwYv/GDwtx0alSBhX2H/agG7Y
 Kpw7iFJFUcTgtJEEsPl8lts8BxBWEvk/gzgeIJ/suHmid8EgNAIQqZ42laBxdYsk0RU2
 zCl6AqS602VazdxygBgKw0QubDxzUZxLKeS3uGO9Qi13QWrdaXZD5w5uHobehGJkBuHp
 BGaE8lQCKjWLdLtb8SXTWGip5fy/dWvtng2CXnfwSOZCDbGK7h6RGoF4aTDrJMJMDxN0
 tgJ3vIYUobke/46rCHf1gWgOZRxAo3P60iRLyak8cnCB996QFCX8c+uF6XXedxvzD04g
 NVYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9Abm8RwCgMz7Z5NVaI1b99j0Og7lRRZ5VK8zo4zSQ6ScSxpCHwhcN5SoJrOnguMIddXb7OAa/Zbw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8GXd/pVUZFAm83bdz9O/dt31tT3ZKcu3bratHs09OK63KQ0imZ
 7G4HfJm76LXA5TKw8qTTBLrToKnYvUY4iLOgrjLQkH5GkQbxbzqZTQJiFBJ5YEiDhdJVgGRHqTy
 wTIj01EkUj3R1Icgi/ijjx89LsOeM1nU=
X-Gm-Gg: AYBFou2toTQxX6rBYVZYM4i9EvTD0vCu2SXZra60NndY/I4PgMrSR0brAqF2cQ2pvaH
 KrI0lPWSKwN2qgjDLvgc8CdxHUOhFjXj8ghUuMJkTuKAn3T9Lmr72ZfO6dwYgC89rWXzp2340Xn
 zJ5ygsxutvbL1Gq2aD1sfzrfPxdZD+wX+6wogP0gZFoyJRAti6nDj2LVSKiiH0jx0jiLTN7vEHH
 U4NWjrnm41YQlU5i4tJaNC57xclpXa+r2S/1dadCdRCsBhk9avVcpk7CYsKeQWxlyFNmiTIWed6
 e56iv7WT9+zgoSImzLfFDysL04s3rM6Hd3AyC4u4lO0qjRdhHA+SJUeOBMvQHRIVUWevIllcUcn
 fW8/bcC2vEHfSTXG2IjXatqMgpInT8Qy/G0upeQ5bZl/Y5MHfsvGY9RotxMQCwtu7dd9Pvmp/Uk
 iZwGXoy9uHVpatfwjendjuGwDWYYegX3logZJ7K4PwRjoQ
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1ac5b7dcb2bmr33315927c88.2.1793718864045; Tue, 03 Nov 2026
 07:14:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
 <20261103150057.1227-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261103150057.1227-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 10:14:12 -0500
X-Gm-Features: AclHuK8SYp_M16l6qppN00rSt898kW3_A2MyXrVqqWgCCOaDEzcq5A-8Uxrek04
Message-ID: <CADnq5_N-sobVK3qitqABjqMv2HMyGNdxX0XMXa4TZzVnMv8MLA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, dev@deq.rocks, 
 dri-devel@lists.freedesktop.org, ed@aicharmers.com, kenneth.feng@amd.com, 
 linux-kernel@vger.kernel.org, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Nov 3, 2026 at 10:01=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > It is the same issue.  I don't want two fixes for the same issue. I
> > just sent an updated version of this patch expanded to cover more
> > macs.
> >
> > Alex
>
> How is the problems same exactly?, Does initializing UCLK later change th=
e
> PPTable?, and as said this is not even a solution for iMacs, so why are w=
e
> still trying to upstream this?, and btw initializing UCLK later with 5K,
> makes it not initialize at all, so the patch is just wrong.

I asked around internally with the windows team about this issue and
was told macs needed to enable UCLK DPM later, but no one was aware of
any uclk dpm patching.

Alex
