Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8932A60A260E
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h7K3D2Dg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF8510E29B;
	Mon,  9 Nov 2026 19:59:43 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A840D10E214
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 19:59:37 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-36dc20d6de3so206267eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 11:59:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794254377; cv=none;
 d=google.com; s=arc-20260327;
 b=A0KcUrzE1XsBWQw7vieXS8FGZ3fGQj1d4A2/XFWrrXlIiqYxwrunHuTJdR9zF2MOUW
 ddNMZixz/LY2YfUw9lDvhWfwDwOs9XaCEstb1RbpaL79fiTByaYnJZJxNKIV773qqyMX
 CVLvAmSSNB+cSg+VFug+d71MJYl0NR0SDQ/dHMV+wvYVmvaUPPo++vrEAiiSjs70/Oqb
 zkbnAJJooiWXDwJS5xPpYBbwiEvO+OKKrDVpYrMoXB+d1qS8+UffezXNCChOljzt6BCn
 5etRhSCpEkof+/3OZfvNOTnkMRYVkOk8+U49/T9H+h2GWpzSRmceDPx+TXjQ7ms1t6wP
 H6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A3d8Z5wEIvDErSrT35kmctdWIj7cgR5OdqtBoCuGlWM=;
 fh=81zGiXsZXC3LwdRYZPP/Zpdk5FPtiyAcCrh9JKpiT88=;
 b=OGrESdiSIZ343Y13beDBT9xfqFdoQIjdPxBU9vG2p1AZPwk7tAu842HzkwkXLRxKJ5
 gLMkIr1S9o1yzW/IEwTp9o5LrdU5a/3+SJDY17wjbb8k/3HTG7TJWFXV2Lwjdih+MKBy
 l8wHtAhGbubvNEG4l+1NDOLq+hdmhThJkqgJWEsbwReqyqHqbY/WCTwFwU1nqi1lf684
 ym0BvW/tk9BbtLXYbNQ6InG0i+8hq5z9+LR540N2buIxiqX37yoxnWIdbteHGDsHIyAZ
 wqpx7Rq7i0cPTwJtagi7wI8OpLRDOIGurwAQhiBJ0hBGDmfmnYrN9PoGYpn1H2syGsK3
 RfQQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794254377; x=1794859177; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A3d8Z5wEIvDErSrT35kmctdWIj7cgR5OdqtBoCuGlWM=;
 b=h7K3D2DgsJKHYoicN1E31jsIe0cYk/6Fr6PE2NWl86KDwMf9xPyvJlHhtMF78n/uJ5
 MhhG6NcJTggZSPgni67umWuqP2hmm1QSjbjqvnNQAPVQ0eBcf2ASN9R7Pw6RsfnBCuS5
 W8ZNeq8tY/WgFbwFBjv9yadr1senyN6krPTbge0ONIPI+0acExMt/dc4XDkRSRTw2DAF
 vMkGexoCdkwQ2wYfNH9RAy/bPzXyQCZhuTeKkG67yGMQ8NeLA7+s0+hICeDnmqbPmXZQ
 lN/qXzi9Z8F1kXQNYg3vdns0goXtePAPp92K477CMJf59RAYpWx6N5pGyck3NmWA71tf
 hHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254377; x=1794859177;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A3d8Z5wEIvDErSrT35kmctdWIj7cgR5OdqtBoCuGlWM=;
 b=DkVS+3tdCJ0tbcTIvNjt10EhOYClFcSesx7lLpZdNZS8HjDqxYGY91+ozR8LsVyjC/
 8OuZO0g+ludDB7GcTA5AdJQqweAnE4eNsqA2AKCLn3lbNPWP//OvpfMbVeNM1K9mD+oQ
 NVY+0Z0SnFSMwCLVdhWKnJbIfTE+yIIZ3Zt5rDGgUCj8rnB61B0NUZyu6ARXGOy5W7pI
 FwQHRn9YhQL2k0cCZ293CJt52Rc+u2MM4ixmavtHzr3Taj1IcZvk5bSX6igIcz8Rc+Rw
 2RKnWBmtsLSSZcwfIQL5joI3WqOt2uDvkqz8HCWz7wEQod3te/qF8BDyyUgy9JbN6wrW
 T91Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGnUDRmo9h8rwUKbhTL+RlGnDA5cQ75G1SoSr+Jg8u2mtIYD7+bcJvsd9b5wcWU23kyAjQt59lMTQI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8yjUnK/BZXpYgwgfDoB7ZGwxnsG6NiWYJJvANFDPzjDOLZwjS0
 lA9JPeA6A/Lz2I1Uoo4e1QU7A1y0bG0GhbLxd6H0QpWTV8zat4bsc7tykidRqbFVWIcSD7XIY8n
 zreKcFWYwc4eSpkiF/mEdJFU/szEIh7s=
X-Gm-Gg: AYBFou0190HULuWj9vD39ugtkLfb0jRkqjHvKajTKGQR8m2KSj03S7HmINo0MV4mtJq
 uOdbhgGezeopJ0GeSca2035u5OMj0E0ijTBp9Y1b4SewVpSV/XJT4lAPxfxLWtv7JROFZ4YuCVz
 zoGM//vjz0HmpTa6PuPUW4owudAFXGG1B6ITfkQavrrWY3RS555biTwgdNlj3An1XMDQ4weVm23
 EpdVUeSEqEVLIBE7GhXI7liclwh/EiNnO0CWiXub0HXSgspxdwE1vPJT5b3MG0QDy2My9+Dwe4A
 8eqU9icoJuzY5Z8pEm84kmGlUEX/94Z40RVC83gd/sOxmyju570QWlyg8S2xWErtrw2/CKYkSZJ
 PVeKmereQ37mnBnFxmqDxXVn7l6J3fyMnskG1GtbdkHTzqeiJmcYNOEqK/2AnXDv0+IQJHdSEaS
 3SZHdJ8sk0hfJPNtWDmvdt7BFfG/wQPpP8X8yRdw05r90VB6jjw7c7QHZ2OTE=
X-Received: by 2002:a05:7022:ea86:b0:127:def:dd72 with SMTP id
 a92af1059eb24-1b3b6025be0mr804293c88.2.1794254376807; Mon, 09 Nov 2026
 11:59:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CADnq5_PjiWHEDzS5DJgB1wS72_tHp4Ju5Wwr0R0N5EK-i9fXfQ@mail.gmail.com>
 <20261104200201.8358-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261104200201.8358-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Nov 2026 14:59:25 -0500
X-Gm-Features: AclHuK_reFfmn-t9QmheX2wZpEISvfvcfsRiQmEay-P-EKxxO4O4ghKC0Fq689Q
Message-ID: <CADnq5_Po302dyx5FA9u3A8os_Q-HsA74nk2qeDadcGe97zodbQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, 
 linux-kernel@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com, 
 sunpeng.li@amd.com
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

On Wed, Nov 4, 2026 at 3:02=E2=80=AFPM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > What's the reason for this change?
>
> This is the code that fixes the SMU boot issue, that we discussed eariler=
:
>
> https://lore.kernel.org/all/20261103160553.1431-1-atharvatiwarilinuxdev@g=
mail.com/
>
> Its confirmed to be 0x4F1 as OCLP enables it, and with OCLP and no patche=
s it booted fine.
>
> I plan to add 5K support to efi libstub or something in the future, hence=
 the TODO, so we
> get 5K in simpledrm and get rid of this not good looking quirk.

That sounds like a separate logical change from the rest of the patch.
If changing the order of the init sequence fixes the SMU UCLK issue,
that should be a separate patch from the changes to enable the 5K
display.  That said, I'm not really keen on this change.  Can you dig
further and figure out what the actual issue is?  There are now 3
separate slightly different fixes for this for people with various
Macs:
1. Enabling UCLK DPM in late init
2. Using the UCLK states from the UMC DPM table
3. Changing the init order for specific Mac models

Alex
