Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEE606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VyaCRlgX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73E410F23E;
	Mon,  9 Nov 2026 12:31:57 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com
 [209.85.161.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BDA010F23E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:31:51 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id
 006d021491bc7-7143451981fso511371eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 04:31:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794227510; cv=none;
 d=google.com; s=arc-20260327;
 b=i5GdnQW84N0XJjcC1Q2jPR3cfN6oT3rf2075uM1w7enToiwQeNPVC4G0dbGTYynfWG
 y+Pvc63lIWdu/BmbnQNh+x9aVPilIsDyx7j+ln/WKc9QuwdnQy7dv0x+nrvtYaOMGxRY
 51yM1U9tBy2R5w83mQMNHAEz5h7HKEko7pCNEowYPGhjBMS3qvpoaJnDOWbw/tQ8io0r
 TxTa91QnW6yp+w1AMixzrKuAuZNSEfzLD/bmpFi/39E/6XRBF9WYN6HL7vNAQSndwuaM
 Xj3Dc7ZjCLnGdiSnKQqGVowkB2yvUjJmfWkAk8MPQnLgP7KMMUWcQRtL7A0I1TvXm6mn
 DTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XTkQQN1Ukp1SZeaktld5RND/YMcBOJgkjTz1UoX9C+U=;
 fh=m16WiMhIKK1OedpJaopZB4gHG0eKJOSqzUwD1u08bdw=;
 b=DLyelcTPXDGyoRDSJQWcDtWnpDPBmFLA71crqJ/PxiI9t4O0kszcONYQYP4JM0d3Ke
 MsoLWk6lmYFWmL2OAyQLdNm7oA+JsmtFQZJ7hSI0zz/jvMCgvvGhxHHnV8GxmDSzHHWU
 uX26e6AwkYm0pOp6SE1cAZ71j4pzBcBnNr4BHVUFwqXlabnPL83eQkTFJ87k1KK+iN6X
 GdCUyG6de35FAtAX3pMAEN8UsyFZldxclqqRI+N9n2Gy8QdPOqqxJbuDZpUiLyab8KA8
 JwKXtT/1+xodB8qqlHKLTav1zB3RnCYVTsZBEipHPV1x//Mjd2neL8vfmzgqMRjyGth3
 qOSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794227510; x=1794832310; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XTkQQN1Ukp1SZeaktld5RND/YMcBOJgkjTz1UoX9C+U=;
 b=VyaCRlgX6BxSDpLkpSQzDo4S9XdynS+kv1zaqM5jtkdObHi8I6dP4fRQNBDUt7NJSI
 YapcZgUJm0pqUUNrq11EAkEdYj6Z+r9iP5osftownefh/ebPp3qWRBFf5VtOWPnJKspW
 RfJFAr8qinkwrafkFmHsYKP694XMkyC/WcsM8DbtVaNxkuoAEAtU6lluh5Gpy/JABKbe
 GM5iO6lgILINpUCVctnN8gH4FLjpuoDIkEPdQEAmil806hsLOlm0PPY67CCNPdlRDLVH
 g2SgpPXJwxDrG9vw62wAHFMIXnM0Ip/6Lyrpyw6Dslq7h5a9aTkXmJb3N7ETQ/haNUxx
 Wliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794227510; x=1794832310;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XTkQQN1Ukp1SZeaktld5RND/YMcBOJgkjTz1UoX9C+U=;
 b=yfdXd7E9BLzMNtw00geIpNfbqWTStTd+Z7cUdYC3zClKTAZeQ26xk24Wa0nVHwHA7J
 wjUuZL6WYnvQH0ZR0qevaCwCPdG09SoR9Z/pyEWkc+xuSyevz1FYgLCJmoxW5p1ZODq0
 7Nltxx/UubnX2+pVU/h28Rf4w6NUk0i8OWcpCXDGECmWnvXJhFBOtPka75l9vQSmCCQo
 Qdar20Y1ZD07uO1kN2PVKT+zLgGn1c7l2asU1haJge8n4dqeIZSFbZ+UznEI6fRsV3j8
 uJInXjM4qeQobAH7Vc2FgFmwqjslabHbgyWWF+qmHpX6M04xNppZmmOkVTuY5/FTANQf
 8C5Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFIGWXVz1Bml4/abFVpOHS0ugYn48c/18cj9zb6c2Q16Yuj6nCzv1JbuUd4xn6/13/35zocA4+D73A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9dR19vI4cfGJczVikiaVZ5eo3oH25oJCTfeRcRoesJLjZ6TUW0
 VhBVelKPhmA2pg5RQ7tHOeA35Fm4xAKEU4obaLvfnb/Vauh/BbX9sr01tGb8LduJ9mGVX+fnexp
 6zQW5wPBAL6dgnb1paDtQcAzDO9SBRig=
X-Gm-Gg: AYBFou0+FadL2SY7lqk5tSJoGC0ivwh7p4fMj+8aZxUI6RyVc44gSkO3XjHNz/kCc7K
 2KThk2AK5ya+Jkp3y6e4k5uIqEsSymevx1E7rlKPtRevXW7zIB+zqclpn/fZzR54/i01Xbeypjv
 z5Cy/z6v+d7J7BuWDCakZhYqxKC8xNz3+eBOVCF9mfGAd8rrTkoRzt3oNM15j4ZunKHIeJHtDZ/
 eC/50WLxq01H1Dh+FEt6f1xO2L+uIG4Y8weZTdzchQ9cxeHFMOcZ5sHy432FLjFoRfkoSiBg85r
 0I7Jwm1Fqn8x30FRQtADts1XchF3ovaR9J1imOdQ9+xVZ7/vo4FfED0lwCnYKYIWXNRoYl+dR76
 kUT1MYc9/aOFITdv8qFrW3+BVzoCBgxB2e9o=
X-Received: by 2002:a05:6820:c2cd:20b0:713:da3b:8b07 with SMTP id
 006d021491bc7-7170f266d47mr1267144eaf.54.1794227510144; Mon, 09 Nov 2026
 04:31:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
 <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
 <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
 <CAFGNeahsXsKQLoGkxTyX+-c44PnXDS-OWOQ3Y-K_T+2M4Derrg@mail.gmail.com>
 <CAFGNeajahc1Amwqg_hX43CfcJEq1E0xQK8Grv0sCukjT1TK0bA@mail.gmail.com>
 <f245aa61-ea8c-4d65-8801-f90a492d5dbd@suse.de>
 <CAFGNeagv2Lc0L_4r28k5N7Exh=pkNTESh3agUp+3NkLp0YF8VA@mail.gmail.com>
 <CAFGNeaghfuFwWMetu1D3+bnW++cC3VJo_8YcPZ8ToLO58jxwng@mail.gmail.com>
 <CAMeQTsb6CESYugWG32JHiNOVVHUUqTY1JdKCCd4Wf0Uf3T9XFw@mail.gmail.com>
 <CAFGNeahpZCnGHy8iC0FS_oALcsU7YrW6afxOe=xJi+407Q0MVQ@mail.gmail.com>
In-Reply-To: <CAFGNeahpZCnGHy8iC0FS_oALcsU7YrW6afxOe=xJi+407Q0MVQ@mail.gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Mon, 9 Nov 2026 13:31:39 +0100
X-Gm-Features: AclHuK9rb7HUZOu12XQuLJKKDH741YGakOyHQNm4JWPc2N-nov8yXP4CQPbqeNw
Message-ID: <CAMeQTsbJ3UimZVpY7NO3deNrvc5uHE0qCaUHJ9j=XK99PBhsJA@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Gabriel Gama <operatingsystemsdepression@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
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

On Mon, Nov 9, 2026 at 1:23=E2=80=AFPM Gabriel Gama
<operatingsystemsdepression@gmail.com> wrote:
>
> Hi Patrik
>
> Good question! reMESA doesn't need the original SGX firmware at all.
>
> I've been building my own implementation through reverse engineering,
> including the PDS and USSE parts, so there's no proprietary firmware
> involved or anything that needs redistribution
>
> I managed to do this without needing to look at the old Ubuntu 11.04
> with proprietary drivers (Real-time operational analysis has never
> been performed); it was all static RE at old drivers (To this day I
> wonder why I never needed it lol)

Perhaps it was required for the msvdx (video decoder). Good thing it's
not needed for 3D.
