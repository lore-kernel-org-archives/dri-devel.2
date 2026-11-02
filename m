Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA08760A2616
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tAQEPjPC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B52C10E622;
	Mon,  2 Nov 2026 13:58:50 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564F810EE92
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:58:43 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2e8ad5b2f61so6453805ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:58:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793627923; cv=none;
 d=google.com; s=arc-20260327;
 b=OJyePR2sX744ZFVktrbZu4lQ/U/Zke9QnbPvnnXFdU4AC3gID9oRHimWlMsuRy3+WJ
 TSPwuYMVDbENV8uS8HR726CKZxmhfKoTB/vyA80a4Tn/GqOEDG/2knuw4rG/BNFvnzEH
 705ie8xzqnJK1EaMrUBya9qEbRvat2TaTwch13wFUA+VF/N8QdMw60hoR1Mm34z70quf
 8D543usLqvFJpoQSOmVsn+INHd255PMZ/bHm4PGIY2M0gYD1cNQFHk+GOqOndPUhNj88
 uZwsSHN3T7oz5JUhI4/NEiLdi4QQ+vgUHzkoiKLZOIR526uh5KlH6+sDQ7mepLvYD8zb
 CHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nJ6alN4H3+Zgsia4c2nyz/5yJfYPVV0Oy8Rx7dpjduk=;
 fh=4xH71Hj6hLkU7DLmZ3acxgDySVCGHaeEef/3ycHr4cs=;
 b=ad2z5ZNvjqZXEeRj4iI8Adaa4YV39n237HLGmJgnidD1RB8zD2ssYAGOCYqseR7IRz
 se3iXDdCnRtKHVhMII3FAuc/zwYx+Ft8WTHRpzPjMWxRTbOziFgfd4y1sxUhzurpZGwB
 wqhI4QtpF7ZukzCj/70XTAOzfjH+1J/t3BsVnzreGbed9Ct1qHeGtLbpCrH1e7RVB7U2
 pUomAICY0ILP5LRiqEIjed6BU0F1v9krGoStre8CP0liE1X5/fbJMgakz3SnJ5E1cTX1
 0W2ydIRa9IwN2A701lPxkAhpiWyT4FRDoZI7JPOiHL7o3G+ScoHqIrvuALmPv8o+nnnF
 xjYA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793627923; x=1794232723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nJ6alN4H3+Zgsia4c2nyz/5yJfYPVV0Oy8Rx7dpjduk=;
 b=tAQEPjPCMPQbsozRSzFS2HQOuql+fkyQsC7Psm7l/BYcIg+Rq7Ye6d/qQMhdtI3c1M
 H0bRcYOaSqduIMWwAgNzaXnOEZEmuzANUI8JUR4oopdHJbgisJdLVGwcUQfJWvjJap/3
 p0Yl0ndf6nT0K1Unu7R+eHoN5TdI6G/FMjEfM8Mj7ng10B/7sE7p16EzIJDcswINB4VY
 u9gcPqCtUGF1PT4qBdO8YUQwhWwMyKLMGRvdM7y2U7JJnWqGq1VZ4jGovPEJpYtkU3iW
 pfAJwzlAw3GAvkirhGjjhGgURP+4+Kv6Fz1aWLW87iLsBQviQgvvgR71ToC2a4UdcO0C
 3weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793627923; x=1794232723;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nJ6alN4H3+Zgsia4c2nyz/5yJfYPVV0Oy8Rx7dpjduk=;
 b=Gbn6c5PtdbjpeONi23LiCz9MCxJQ7d0waLP/Z4WN4jqKO+oZ+V1xjFI4CTKl1JwSK9
 iEdb9w3/TD+z+MfpmO/DKfHnmgc9H+s26ucceB2+WYOv/+V3KBJrtFACrpIawqAwEYK+
 EGT98tt47Gn1d3wbkTOLozZsg7iR54xPXDwQwbBKdf1vzzu0ycJHjs+UCkYu2XRXogle
 18GlosewlB4ygSqyz+V/xqxfvwhUFPwCkXtLwA9LbriuVPfA3xbRkaCMaANXMMRkVlf9
 lOEi1uzBeYsX5+2KYc2J/Ll2ar33vZ4gPwHqYJa/fCIGabGibzaRV6WgjRnz+z4+qMwu
 zDXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSZFyxav9tA4Tzd5/YWPPZAwSGKoCIz09+S489DlrhJ2Pcy4KS3V/54DgFHDcL04kZLsxH/9T6BU4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/xPp7JWXx8ZwwZUiHHB89F2A/zKDv1ysnwyhqIFB+ySv8PrWr1
 ywd/wCBU2H7vOGoeU6bSFV2da42ZxlctoZHivf7CTGRFudsBkEH70IcYJlojF3n3fKFLgNBAf7c
 PpnGACukK2w3DgeKbP6GNl2apHPKLMcc=
X-Gm-Gg: AYBFou3LYnfpxj92dlQ1Wg7algT2OjVTUCEiAXKrunG1zzQc/+aC2x8rAevkdWWHbv7
 TYgMmCm/aVKDIDS0ptc/KcJi1DE5Be7PD9OJXPX6yhK9Cu8baLV8mOGEDUxB3PQGzg8PaDChtcc
 qcuuj+3knOSWIeElnXzDDf4sA4VUVEat1Cui56f7RbKm9IuX05i4bNCLmD+3AVZ3w+4cO9s6MFp
 aufVsybWl3IEnvkA49p4UiLsRVIz17XMVG13iBHwM93oqmwknkKKpXtAH/aEyWsYLnWlP6CFqB6
 yt16V4KhwVoIVIG4G6ipj36MZcsbKbxycUrFUcui9Jyup2PdUvkHMX3J/xiyvvFCmHLOhm6t9o2
 YSAnXrf808YKf2i4RmqPaIAlS3DFIU1y6euvVK9IlaLAUM7kLqVVM0uHXc/yfWjX98nM58k2HbN
 RniLdBj7/cmLm9zbyGGjkJsfWitc6Fb2kg40h2qvBd9CBs
X-Received: by 2002:a17:902:d501:b0:2e9:6468:1ff1 with SMTP id
 d9443c01a7336-2eb3648bf2cmr153268595ad.2.1793627922776; Mon, 02 Nov 2026
 05:58:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAGxFSwnBDM93ouN6Aq2ppm5zF1h19XE6NJ92NT2UEhMP1P4xEg@mail.gmail.com>
In-Reply-To: <CAGxFSwnBDM93ouN6Aq2ppm5zF1h19XE6NJ92NT2UEhMP1P4xEg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 08:58:31 -0500
X-Gm-Features: AclHuK_W2nYNzhWcT-bUVBFipztB_PsZmQptpzSQo4X8vrE-d5Ne3PfFZ8Lk8pA
Message-ID: <CADnq5_PyctWJK2k4-CutYFNPkuMprmZE98d2JjodBQkTLGJhDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
To: Arnaud BERTRAND <arnaud078@gmail.com>
Cc: Oz Tiram <oz@shift-computing.de>, airlied@gmail.com,
 alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 simona@ffwll.ch
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

On Mon, Nov 2, 2026 at 3:07=E2=80=AFAM Arnaud BERTRAND <arnaud078@gmail.com=
> wrote:
>
> Hello,
>
> I have two dGPUs : a Radeon RX 6800
> XT and a Radeon RX 6800. They both report the same PCI identity
> 1002:73bf and each has a different VBIOS.
> I hit the same VFCT bus-number mismatch on 7.2.10, but with a different
> outcome: on my machine the device-identity fallback actively breaks the s=
econd
> dGPU.
> I patched my kernel to remove the fallback, but I would like to have a
> better solution for my use case.
> Would it be possible to apply the patch only to APUs ? That would keep
> Oz's APU case working but a dGPU with a stale bus number would fall
> through to its own ROM, which is the source that is
> guaranteed to match the card in the slot.
> I can provide more details if needed, I am out of my depth here.

Should be fixed with this patch series:
https://patchwork.freedesktop.org/series/176969/

Alex

> Thanks
> Arnaud
