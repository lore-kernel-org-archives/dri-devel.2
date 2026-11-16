Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959F606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pt8gjvgX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4B310F170;
	Mon, 16 Nov 2026 13:31:11 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1424810F1B8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:31:06 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-56431524c22so1052516b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:31:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794835865; cv=none;
 d=google.com; s=arc-20260327;
 b=ilye8FhtJDwYJ4ZcAfP2F/HqyDuvuGRdVrQalvRO0S5afL47nvyK25sY5vghlyOZUZ
 MiTc0WHZTBWmu77nhAbJwA8sfY+Jul5OC1M6OtPHLr4WIVq49QmaZ6OmWDpqctvaDW4n
 c0O2/9dKfwpjBJ6c9gykL/m1FoiBffqoWqjzQvGuoEOhhjrbGBNSXMF7tmqCJgrw50LL
 M9wfHlil2Kisr1/jS4eUuQhSFIda1M1qnh8qhvyaQTgWOHp81Yjf9szW64Xy4JzAceX7
 9hjTFSAh/bK8FmxZot/sBs0tMMHZmWc9WsQ8AQTZSxfBsaVbpoe2+N/jJlK+5AbL0FNp
 qYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Brg4OxuTzcas4ZcHJxTx+HSrU9XZjx2yK+pD9xbwIHw=;
 fh=gzHiB6vb7zcjYZDfJx2jqBKoPO9jjkNgor4aqXfUPrg=;
 b=nrJJXF/6Dtfkk+u8KkSKzzJrMDV4Hb4CHbE7GRDXdSOdsGwONu96pM8TjpyvvjsIIB
 brYCrZGUqVGCAFY494NxbT80Pejo9GK4tpAJWE68MtrD5nV/s/yU33FzqpASbYhnhica
 jZbu3gCzNELj6E0YClzcq6NwWq7wzvTgsaQ17M9U1nsbHCurWajsSBC1P9b/dbd9Gb95
 nhak7nc4j931SfwudkfUNI+Z8py1QuS8JwQ4XQgyPFp5SR0oZXCPqP7Cuagry7LCRwJU
 LCDkJmn/uHt6vX8BZTvJmCqFiO0fqgc1Rmnd4RbEUIRY8w4D0IuuYTVpPq4C8NyEK+gu
 cnEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794835865; x=1795440665; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Brg4OxuTzcas4ZcHJxTx+HSrU9XZjx2yK+pD9xbwIHw=;
 b=Pt8gjvgXdO4xCQSNyuO24wYVJ+ebOXsjGIA7IC+vwPN02IgtDH6vvGEM+LcG47iIPu
 vLINe9R+ZOK2SnTmtDr2N9rYNMP2OdRAaHt7909U0BVzm9gXVoxT29VCf9ImhFDP+gO1
 wtm7nYPFyx1WJAn6Ggy1GS3xIgvDg3NmJsX1VDtrL20e+xXZOYiEiMowHB5e8/cLleme
 as9wR/pc31MbHcL9vyxSYphQUuB98+2R1j0ghpfln6b226hMJACA2663teDG1rgVIzTq
 FJnBBRtwos8RezxlN1ges/eBNv87YOUd+NjBm4Cz3gNgjBANrXqXYHWO/Wlmdnm37gws
 dSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835865; x=1795440665;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Brg4OxuTzcas4ZcHJxTx+HSrU9XZjx2yK+pD9xbwIHw=;
 b=E1KW3cbt695h8lDxk3UZcITa26jW39HAjfrDXiR+cgtuHTDKbKSWZ99c6sEFfO72fH
 T7i9237lHBZ17XwQ7MQ8ezfemuyPFIf4FowRZUt+Lk4w6OFFqeWkfnDLDuFUPmiQCSSd
 wn1BuajuR15TvbrTPJMEekrPgLWG94ILTNOHRdq/AkUpeeUH47wX2Q1zSmPOWE4lhmQc
 Qza8Urycz5G4I4iuZpP3GRT+EnlLtKlONz1vrzcl41zGrtJAMPSKoAaba6jpGi0Wyrp5
 lzcBRfXwaUWWk8MSTgb87ct0Qn4flWaXS29xBIseriVBHHBKS1FPIYPxbiIxMpstipTu
 RvVA==
X-Forwarded-Encrypted: i=1;
 AL+hErHAkw4tR/nkQ4NQbcuexmvnP1yw7UmPrHiTXi6JGD9IPOl+ELTDOJVE81kTFK869UPBKczhnCQuR9A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+YOUhYy6X68226JO15npzZnKrM8M9wmcT+FFNG+U6AZOl4szst
 DAwgmjgF84GvV4cy6zVjzAQaA7eM8OUwkQHtp+7htUqXww5f+hsANOTNYneUvenA+pD6KzngKTQ
 pz4L+Vt+zwJbCkqDokWzmOyCB6mGaiso=
X-Gm-Gg: AYBFou3yqKQ8Aj90d9bThJIh1JnhYqEaRmOgpkuIRfib413W7+CKAnBp8dpcMTcWFgm
 oxeh7hk7gaYJB+X9Bx2Tr3yrpZB4/Hd6fWsh+rl/Mt4n3+cJS6qtfHba/VDk1SwNj7KHmdycNT1
 ORQlfd6hx6vndaRkAkftBgqAlQxPTEhBiszdcK5mXYj74D2g2bnQx55EKacftJlH0YIMjxTL8Ja
 fyvBCY71ILl5ddtZjE5LE2xV/2XFxJb1oxbMzB8qJic/jVUdrxi9F6bWMUYFZuWy1hnpKuF55gy
 1Djd0q3CfMA3cLkYgptkkF3rZYnZLYZ51jK/kPNyj9EwTPaHHhZNXAWQUvMW7dFMA4dBKea55SD
 v85A576Z767a7kcrxVqXDeBWYwPeYX6N0Puh/ocszUgmT8RIdIP5ZCmXr
X-Received: by 2002:a05:6808:2206:b0:571:c073:7492 with SMTP id
 5614622812f47-571c0738a26mr5603930b6e.68.1794835864903; Mon, 16 Nov 2026
 05:31:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
 <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
 <17f2783e-9157-458b-8463-f98395e391ca@suse.de>
 <CAFGNeagxEcfPuEHFt3TxKhCDoZ0HODpXwXcKpuBxKK=09FkRMw@mail.gmail.com>
 <CAFGNeaiYntE7dQ=-sgaM8gRKuZ+wQ-479ShXKW8v99YVSdHn5w@mail.gmail.com>
In-Reply-To: <CAFGNeaiYntE7dQ=-sgaM8gRKuZ+wQ-479ShXKW8v99YVSdHn5w@mail.gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Mon, 16 Nov 2026 14:30:53 +0100
X-Gm-Features: AclHuK8hOS1A4-ELwPrxsZ7cDyQv40xkr4w0Udg8GqeNR4Qc3IMpU32ye0JxHHs
Message-ID: <CAMeQTsazkHgYiCnSEC67useW++0WEY8E0RS1ShssWybrWCGuiw@mail.gmail.com>
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

Hi,
I will try to find some time this week to review your last submission.
Regarding the Mesa part, you will have to ask the Mesa people, but for
the kernel your signed-off-by tag means you comply with the developers
certificate of origin [1].

When it comes to the SGX we cannot have two different drivers
supporting the same hardware. We should address this on an IP block
level. I would suggest a modular solution where each block (2D, Video,
3D) is it's own separate entity and can be used separately or combined
from userspace. If you want to do 2D tricks to speed up the 3D engine
that needs to happen in the userspace driver. One exception would be
clearing GPU memory in kernel space. So talk to Joseph and figure out
how to combine your efforts so we don't end up with multiple drivers.

In case this is not possible I need clear technical reasons to
convince me otherwise.

Thanks
Patrik

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
sign-your-work-the-developer-s-certificate-of-origin

On Mon, Nov 16, 2026 at 12:39=E2=80=AFPM Gabriel Gama
<operatingsystemsdepression@gmail.com> wrote:
>
> Hi,
>
> Just wanted to share a quick update on how reMESA is progressing.
> The project has made quite a bit of progress on the SGX535 side. I've bee=
n working on the Mesa/Gallium integration, NIR-to-USSE shader compilation, =
resource management, and the rendering and presentation paths
> On the Dell Inspiron Mini 12, I've successfully executed GPU rendering te=
sts, including framebuffer readback validation and sampled-texture workload=
s. I've also validated a hybrid 2D path combining CPU operations with GPU-a=
ccelerated copies;
> The main remaining challenge is getting the normal OpenGL application pat=
h fully working. The experimental rendering paths have produced valid resul=
ts on real hardware, but continuous rendering, normal context creation, and=
 desktop presentation still need further qualification
> I've also published an experimental alpha release to make the current sou=
rce and development state available. It's not yet a general-purpose acceler=
ated driver, and I don't want to present it as one.
> I'm continuing to work toward a usable Mesa/Gallium implementation, with =
the goal of eventually presenting the kernel and userspace sides together, =
as suggested in our earlier discussion, I intend to clean up the formatting=
 code, etc., for MESA, but I see that I might have serious problems using A=
I, the provenance shouldn't have any serious problems; I retrieved everythi=
ng from open repositories from TI, and reverse-engineered binaries like xps=
b-glx and psb_dri.so
>
> Regarding the AI, I managed to prevent several things before it reached t=
he repository. I identified and fixed a UAF vulnerability (it literally gen=
erated the UAF code right in front of me), as well as a repository I call t=
he "bomb repository" full of leaked files, which, if I hadn't been there, w=
ould be in the repository today, None of this content was consulted; regard=
ing UAF, I reviewed it directly using expand code in the CLI I use.
>
> I wanted to know about Mesa and its AI restrictions. The best thing is th=
at Remesa doesn't have its own DRM, but it can have problems precisely beca=
use previous reverse engineering repositories have AI, and almost all of Re=
mesa code is generated with generative AI (but still revised by me at the t=
ime).
>
> I created a provenance file in my repository called PROVENANCE.md where I=
 put almost all the files I've used. I'll search for more files that I pote=
ntially used; the documentation has many JSON files and such that say this,=
 but they are obscured by newer documents.
>
> One thing I would greatly appreciate knowing about the use of AI, and whe=
ther this might prevent integration into the MESA. I've been concerned abou=
t this because of past actions of RE projects, blocking AIs, This really wo=
rries me.
>
> Just wanted to keep this discussion updated on the progress. Thanks again=
 for the feedback and guidance
>
> ty,
> gabriel
>
> Em sex., 13 de nov. de 2026 09:30, Gabriel Gama <operatingsystemsdepressi=
on@gmail.com> escreveu:
>>
>> The old 2D acceleration code can rest easy; I'm not going to touch it. I=
've been working on my own hybrid 2D approach instead, with good results. T=
he CPU was indeed faster for fills and console scrolling, while the GPU per=
formed better for large framebuffer copies.
>>
>> Ty,
>>
>> Gabriel
