Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26371606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FAy5D7oR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AC210E411;
	Tue, 27 Oct 2026 15:22:35 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D8E10E411
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:22:29 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-7cc30120465so184152137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793114548; cv=none;
 d=google.com; s=arc-20260327;
 b=W7DNajkDxuMIyU2J9bEzA7kNvaj8jwcQQgech/ge5E6QcnmtxU16ayMI5fxyO7U2LP
 1t4C2Qmzm5lpeYLyoLR9GJ1nWpEoQLXMgvlhes9QPdVfmIJFqk7AzEakUK3RW08rENme
 JmyVAxnD7eeadxPzRqOWE1BqgKrSP55hvOrJj0nXJ6ZbYUHMUJHCqrhmy9G/saB2OWTQ
 7fnq+B66g9BjwCNkV5e4/sxxnymLYbPv5JLNHOWcdUjmliE565bFOo1DfpKgTNCyV4JX
 U/1tjcATdwD1+WXOE170JWKfvR7j858josi02CJkOkO21PI7QwBSx8g5cbis5mk9r/fE
 fxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0gy1GbYoTDZfjLk4adPcTo+vL8RJLAqdM+FNRZN+GPw=;
 fh=SfFjdRSWbiz2VaVh4GeFCp5f93Q5eGwOSrFXAJ3xYMw=;
 b=gIeLP5CgkhEkdMYc5NO1w7XSoioP+M4JS45sONyqpw9WNs1cfiIdJpGDCvDtBGsXnT
 ULUXyxpqXdP1320WciGoum3RHWMh4sWkHOiQZcB7JKiT1mpiFfZsnmmo1sl3wCFrZ64y
 4fESQBywAbLbWztC7P2h9KERhzQ/JnREsCj2QsDEFOhOM6zNHZ9g/nO6VHVVBFGZq0X3
 R5kdXBaexBgknZw3/9FSkqmahkREUP1z6kOVdYkkARyp2CHeKd5LsfudPOFJg4MSJAq/
 A17LGQQz11IdEcS4748SrCAfO42ikrQUXYtpB/t7rWWsBZ2tpUGpM8ipDFiGeI3QnBQB
 7egA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793114548; x=1793719348; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0gy1GbYoTDZfjLk4adPcTo+vL8RJLAqdM+FNRZN+GPw=;
 b=FAy5D7oRF9k9sY5C6/vK2lVsfISUyVziIwCWz5bBgyJuDiKNKniqMWEOmTiTnQhwpe
 r4EO0Sf9TXU9LY0DQd1Uc+UrKXvuvwPKXobV0VEloen6y2fNJj3L4YFw9NsUNahWtFQq
 2DrztvLUC042BOgetWZsre/AAvBv4cEbVmh+DctAIq/PYEMxLV5v0/qdW8z3t+JvlF+o
 4pxXBrJcnOMl4TfmwBzxJkjSTXr2Jb9zZmrA/hOgO2O41/tmYuzXdwzwVsqPp+d8Lx8N
 qNyDTCy/UpWPwvtwp8r0rGIZMPQ0YX/jZS293UJSNI/tq1K6QeSbNaFfqJoQm1VvIUGi
 HquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114548; x=1793719348;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0gy1GbYoTDZfjLk4adPcTo+vL8RJLAqdM+FNRZN+GPw=;
 b=StwluuHb1ItBm9ZLCPIWR5P+++cQBfxhh5BJtTrp6ZjWcC40poso0NZcW/v50YcYch
 tjKu+3Kbsgq9yWOPQrtXvckln4Nf+U31umjEoqPwE1594ifvyueddon5g2A/awHd8QMD
 r81wOR+h2QXLYbkznG8v+GH/XBwCfod+1nfbzebp6GjFp7MHB8Ql9vIhsfNmr0mD7DTF
 qQh92YHsqg7s7Nuk0JOKJwmAA86TaeJD+ufj0FsLh95NDS6mBZfXkqijBTT/onDVoMop
 vveH6kUA/iRzpR0FO7HdAIsHW8pkWLYNzuEiy1w3zX71oOkttb3GSX5xOErLoetZHHKN
 00Gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXgwjemQTn8Nvi9wOG4tMAzpRjQqYZ7hZsbusJ6DhfcHkZb8xRx02qrRVCF+FUeUjlhXojZULWM3U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLaedwlCkK1eEfF58ZqycrgpN9j2nCeKC1b2Rj1ylwd4c/AIFxs
 OQpRhU0gJ2SSA4VfOlcsbmREOk0d05SmsRpLzzPVQhe8EltgcgCtCCpLQk+LYrmzwyCr6QZ5uGv
 zadms/4xnLnL3kR7w3n/ig6GmHAOwtv0=
X-Gm-Gg: AYBFou0+et51jmwySIqvpx+LZC/TRdiwDjSNF4QtX3WdAmMXsZ4i+AVKO8D5zHnscpm
 dTRgIv+KpmHrBSk9hyvxhydVw6bnO+t8t7xc8MwxqE9Z/bM38EqA8Er1MK9G6k3Bd45eHYglqiF
 CrVUsDEokpHyBAq0/CDOjUuy+8oS8w+KSlv7JBHY06x+V3GoBxJL+wKmdeHNhbIYKH4Zya61UnN
 TF1RhQbiyUnOn7eDIKVGwGiME3C0fEdISf7gHJ+tU/ERdNTzWjbCJ7lus3QiTUs/K4pe0Ly8AUp
 cYB7aPxSgJmEy3KxXSh3pJPY98JlToqY1nE5ymvt2DmMNZnGqceigYQRuaSV5SecRa2tTiOYeSc
 JruShz7rSjxenhqIXyfMc+ZAzoniBCnEubzFD0m07X1v5XS8hEMfLYTzLxXnSsFP24mzjZ2S2D0
 jhtc60d8ntKc9OLmGhy1NjerY=
X-Received: by 2002:a05:6102:3250:10b0:7cc:174b:f7ca with SMTP id
 ada2fe7eead31-7ce5c6ba0dfmr4003174137.0.1793114548478; Tue, 27 Oct 2026
 08:22:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CADnq5_O2tEUHOcbiKL8c4UHpy3AmOWtmM7A8o3jP2qLwkx2jUQ@mail.gmail.com>
 <20261027082913.8002-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261027082913.8002-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2026 11:22:15 -0400
X-Gm-Features: AclHuK-Adz3pXhRznVuw9H0EI3Am4aff3rHKztB_BB4zRj3ojyCoORRQiP8JW0I
Message-ID: <CADnq5_PYSbB-Ges6vVgNcR4ZjYH4TxLZeAShifdV9uuH8swQzA@mail.gmail.com>
Subject: Re: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX keeps
 the GPU off
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, bhelgaas@google.com, bp@alien8.de, 
 christian.koenig@amd.com, dave.hansen@linux.intel.com, dev@deq.rocks, 
 dri-devel@lists.freedesktop.org, hansg@kernel.org, harry.wentland@amd.com, 
 hpa@zytor.com, ilpo.jarvinen@linux.intel.com, kenneth.feng@amd.com, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, mingo@redhat.com, 
 platform-driver-x86@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com, 
 sunpeng.li@amd.com, tglx@kernel.org, x86@kernel.org
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 4:29=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > You can drop this.  Nothing about this is GMUX specific.
>
> I agree, but there needs to be another variable. Using pm_runtime_suspend=
ed
> or using any other pm function will not work, as amdgpu_pmops_runtime_res=
ume
> also requires hardware access and even though hardware is accessable by t=
hen
> pm core will show that its runtime suspended.
>

I guess the runpm code doesn't update the status until after
resume/suspend?  If so, call it something like runpm_active.

Alex
