Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E068F606A335
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+nstAQY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F9E10E170;
	Mon, 16 Nov 2026 14:27:18 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B22010E2FC
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 14:27:12 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c50cc7540b7so199914866b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 06:27:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794839230; cv=none;
 d=google.com; s=arc-20260327;
 b=OonaxJr2VtzksuGVzXC+Qn27tA8SkkE3FcEj8lsSlXuk0O+Kjdg3HwuI5Bsi3/NXwU
 sci4KeakxCSW4c6OxN8BskE2WV7GA+pA1fDRRSnMVqxhC5QzNq/YXic3Z6Ar+bTgSbml
 ckqoxIqWZGWC9jMv5n7NLdcxhXZBERmTL/MoP4rLYag8jPpIsogC0xCe9Jdm2ZPZDwFO
 s7co7wbQnN/j0UC/V/mBMz067UNHBRRGu0Plckx1nEdHejOvzRzxRwoMh4wu6r8RCSJe
 z4QPBkoqLyeOOeGUuizNILE5nnwtRByj1l+UOWNPB4BhEPyShosQHVpqSUPSdjHHitdD
 d2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HrYX/xFhc8GZdpnYMvRfOawIej7Z1lvx61D8oWOIR3c=;
 fh=TSz6NGglEJwBT/NiedSx9KgoAbBY9pvqwOJQBVb8sh8=;
 b=PeHXsdrdJDD2E5IUGM7w1BMvLxMkT9uE8lQOvT9TaBVZDNW9hMK6+/c9zesdUfByvc
 n8sMlQ9cDSqBahTywVe8ijAWB2Z858ykF3x7i6xELSxZP9PnVdScTMgDQ7FvPOcqx8pV
 wG3QNZ7OYQGnUnCEp1ypWFJadA7Ngf8bO9lixjhxBa3xN8H6GqyyLMVZ+iVjqVioZV7O
 xnMDq3DiRdBcCBMT1Px0gf7MDFyDrRWAcE1+GTRwgEO7ZEhn6pYirIWtVbapKpFUREWm
 iqt4QT82yQjiB5tNM62IEbwch5rA+f2A/2kEQf7LhEiG7i25GYDmmVuhdKYmc0nQ8UNg
 ep8g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794839230; x=1795444030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HrYX/xFhc8GZdpnYMvRfOawIej7Z1lvx61D8oWOIR3c=;
 b=Z+nstAQYr9yS4iMB5fRYxmqzdKf1hcE3sVspQmLm3MEMfBTVf/07UkqyK11FgQun2C
 jTHKR6Gg0XKWmVeM7HUl/si8K3SEpUPbgsi1wcdVc0LKc3MiziM/HjOhtItVPPt+eS2N
 IEP76YUdjegET4rW4dT5XCVwEeTtq/qt0M5CCN6fO2XyqzLk24QgrLUD+MHEQk6oB7Aw
 oxvTqt/Y0mzF42WSoTRYXSV/+026kXQCD4BX8omJgX2Dg0RmIKMz3Y+VeF7eE6qqfCAy
 OF2TM+b2O4TFaBhOFh07S3n1n/E84BRbXj+iNzYnC3fHpSoY5F6F2yjLcfHHBjjaGRBZ
 xcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794839230; x=1795444030;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HrYX/xFhc8GZdpnYMvRfOawIej7Z1lvx61D8oWOIR3c=;
 b=CXguvAZkaAsB57wOuhVI3Hlo4HL/JDqM/nvltWUr/c7+lAuPif0TqIT2E8sLHdV6Ab
 RRVbYb04xOiiT5Wt0YV8ozDxD4sMwPA21ZQIucQs2xYP8MiShnfj5XrnWtUkiLBrvuN2
 F40/0NqakUurwMjdey3yB5PAE99DZ2fFguK1iEEJO6ZgLtr1qszbwP3QCIa1/q7UBrVN
 iZ8sbYcdVfNG1JYuqLUfOgk+ikp943fBsuiMmcAq3vs2crNU7I5+TeLe/+M/YUglH3t2
 QrMWcqd6hTCF9WznHz+YhCsdXh7980sc7ZBf7ok7g0xq+Jt+MdmJom6ulKqZYqkS84St
 K1qQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEIOXB7AnA9xVUydDEyjfl6QMIiGkySxtPBULJOKOR7GRG1BJeTlzZ8ObtuGFtOIhUR5KyeEcj+GVA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9o2JCOmlc73fv43wKWGiefKVGFsdnfZdWdsFa+gs8rRMq4/LEz
 1uh0/iv/ibqVE7BPUJf1e8GZi+Fgd/rFhuxx0NpAOmYuVEuiSNj0YRNNylkWAjfxvYwQrNYiNIw
 HkpzQJEJGx1nGhKmNraChGirXtE8A/Q4=
X-Gm-Gg: AYBFou0/A/q3BBsCt54/3SpYqAVAbxoDvoM1ZaPxau3uvLJEqNnifqfIYg2DpASXYkD
 /oBDyzq/mg2ziuaxSG4HHo4a1vefzB+4zSsTtuts2YxPA1aaq6Ky03ESMn7x2y3Oj40Qx9DepSU
 IKVRRUlAvM8mGSoO2Bn4amUenn/RMBvTEXtLeaBTH1gkB5M8IKmjyxwir7LcQBvrGH9kMzddAa2
 EolRwlrIBF6DRIYdcSa4aWh1ewMeeSqNoVo/tTbVTogEGcesUbkqpMG0fxTusbmwM67UyKj4h62
 MNlAVFXR7lHaZx/PHEJ9LIjOUomrUVFy3Q/uEoCM90SHFZMpsFuvcIEYoJeU8MRJs6Zr9V4o23X
 lgvbHY1G89HetW21YaYIEIS8bMK7GnlUb9yk=
X-Received: by 2002:a17:906:c14e:b0:c3f:c878:7c1d with SMTP id
 a640c23a62f3a-c5096307650mr843636266b.9.1794839229990; Mon, 16 Nov 2026
 06:27:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
 <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
 <17f2783e-9157-458b-8463-f98395e391ca@suse.de>
 <CAFGNeagxEcfPuEHFt3TxKhCDoZ0HODpXwXcKpuBxKK=09FkRMw@mail.gmail.com>
 <CAFGNeaiYntE7dQ=-sgaM8gRKuZ+wQ-479ShXKW8v99YVSdHn5w@mail.gmail.com>
 <CAMeQTsazkHgYiCnSEC67useW++0WEY8E0RS1ShssWybrWCGuiw@mail.gmail.com>
 <CAFGNeajczb-2Xcjfaj82hc-hprJXRHsr8uSudO32j6S17T+YQw@mail.gmail.com>
In-Reply-To: <CAFGNeajczb-2Xcjfaj82hc-hprJXRHsr8uSudO32j6S17T+YQw@mail.gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Mon, 16 Nov 2026 15:26:55 +0100
X-Gm-Features: AclHuK8pWvM4AZkyXmva7JPnjoXXiKchiyJF4kVvSDx1vCnvs-0PHppzjf6giuY
Message-ID: <CAMeQTsb-Tjzu6i8Fa4X6Ta-JdRPd6vf--eEePTzZKvPuPX5GGg@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Gabriel Gama <operatingsystemsdepression@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Joseph Telaak <jttelaak04@gmail.com>, 
 dri-devel@lists.freedesktop.org, Joseph Telaak <joseph@telaak.dev>
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

On Mon, Nov 16, 2026 at 3:09=E2=80=AFPM Gabriel Gama
<operatingsystemsdepression@gmail.com> wrote:
>
> Hi,
>
> If I'm not mistaken, Joseph removed his kernel RFCs (This is in his GitHu=
b repo)

He offered to work together with you? Two drivers for the same
hardware is a waste of time and resources for everybody. Lets keep it
simple.

> For Poulsbo I'll stick with the GMA500 drm, it makes much more sense;

Why? You have not clearly shown why the 3D engine on poulsbo is
different enough to warrant a special driver.

> Once I finish reverse-engineering the SGX544MP2, I plan to develop a sepa=
rate DRM driver for it.

Again, why don't you join Joseph on this? Mesa is not going to accept
3 different drivers either if the hardware is similar. If there is a
big architectural jump I could understand it but then you need to show
me that it is the case.

>
> Thanks for taking the time to look into my patches!
>
> ty,
> gabriel
