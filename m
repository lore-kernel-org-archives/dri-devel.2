Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6E4606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=oKeHPNNo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0001124AD;
	Fri, 13 Nov 2026 13:18:13 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC45010E7CC
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 13:18:06 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3b155f50c24so1894218a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 05:18:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794575886; cv=none;
 d=google.com; s=arc-20260327;
 b=lZvx8OyOTrNxe5nDbavc1T/IP74KqKlsOZwiBqyk87h0k5bIAsRDZgJXHw8tC588qX
 GnLC5D5Rq8sFRxCtGO1sIlB4V8q6JKNWbQFXdOjAnqGoKPR7c3hrh5bUK+nEn3DsQ2Fr
 3cdwrro/w3dNrU/pI4X9ATzes/mtHP8cvzXrpqfT0ale8+MZu6lGapcPVabDE0d5T54n
 GwFrWRTSi6pn6Czi1r5wj7v4umJjUaNF46Q3xhKcye6kwWRVs1Xkcl4EEIycowa+ssmo
 Jbl9gSy70+83Di9FfkHJY9SgHV65VavLcqI8qRGBAbMlodOirwsG8PRljsEACWfsqxeS
 UBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2V9pKXfHF5wPvuKsUvUZ8j5JmgMsAXvasgkSG59qlpU=;
 fh=Wp15HV9gGYjlhkc7MXDqspwDaCFNPUWrR8ewMsnoZuA=;
 b=GNBfNo0y//rdADcpxDW2bwF4JCPNpUxTx2Qu5eDI1XOLOqsxO7ERDtVJu5LBwLTTcs
 1c5+bqpetWtyJa62T48slnoI3mcN2O36WbXh6iv2y3urHj/b6g0UTCYKjhyq7JROEMkb
 X9axbMQ32O+9GZyiSIrEvjiQmX1kQoaudLnk/C1QAX949+ETkO9IHR5T2VhYq+BLMx5X
 L7K66s2j7cR5PzWkLdSuiU+KEhh95iGRNWASlLxL6Y3g/LQKlsOoUFzAy/nlg9Z6J7k3
 +ciHvMBrwYDUxDuR8mLkiJsJiAQmEUaz7fAR9z/bFyrU1cFYIMw3sQ+osBSzWEIQrxMT
 mGLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1794575886; x=1795180686;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2V9pKXfHF5wPvuKsUvUZ8j5JmgMsAXvasgkSG59qlpU=;
 b=oKeHPNNoTCUvKmOPe53Rnc4y+u6dcSP/bP2pGGnBqwsbxcYbcPt4RROqnJ0jpzwshZ
 BLdJtFX0rVKUT4iUdUzriomOWxfQj+bxQoHCrI97Jtw3AuC9bZUbifK3nJ47uoDIY49U
 7W/ARJRCBo/JtUTt4Cf3p4Wssn9JFgSIIIg5Q3gQydzakNm8lvirTo0L0U+kivMljtN8
 xXR6ppOswRncaTezSZUQgwQRcsruFlCQWQtufB5xoOxMHnLhAwdVS8YTXziHbOPjbDld
 DLxfhBOvEDD0vkpJjX8b5k3q75y7tirEerRECnx5yS50ebg4NrlP7hLDUJ7KpsnalE1O
 n7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794575886; x=1795180686;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2V9pKXfHF5wPvuKsUvUZ8j5JmgMsAXvasgkSG59qlpU=;
 b=lNMcCy1v3gcO5YcLR5ssdWVVcY6lQlkqhkLFaIDFBubVq9hu9WvjtblFvI9p0hdSC2
 qtN0Tko1nSV/E21Vcxq3Q6GBLbI5HkJda6yzSS4S6Hu1bcNuLVagtVvrROjiRCAOFmNq
 +jcDG3vy6oScxy0qLGvk2nyTUgzC8MbzizxBAWANKh4D/sisRRhYErubODPDzOmCOnNe
 795K/CLHOTPPeu/fZ1nNxWuhGOCDg4p3qY0BaE3iwSvK3+2bsuyRwWxfefMriABYD3TV
 P8G+v7iyV++6TDBqz2y4LFTbHpht83sX2Dnzdfx2RayzNtxdtuT41cOqZBwaSgXfe44U
 2Ofw==
X-Forwarded-Encrypted: i=1;
 AL+hErGyR7ry2gAxW4uHSB6tuVNjXz8ghP7Et+bRhFbQF8ZN/n01vJUf1oYO+Bk6NZPLX9NrysUZACwHFpU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8HkDQwzE2ESH8yBIV9LendOHBOemPQWPZl4Yl4apcIAJlxOxNL
 pX5apGMd+/MToYiw3TOu281C0awaRAlCrsv16ra3QXwQ/DtKzqRtQOfDTfpQOwkv9Prp43T3oCv
 eVSRIJ2DcO5X4f1yZ6x7Zbg7JgEY6yqutUyQ+oqeZEA==
X-Gm-Gg: AYBFou3WAwvtHLK0zEFBuWF7wIV6dfLNPTk7ggvRw78Cf/FndlGEhAc3ORUfG1cNwks
 cGeBAFaBVn47FEYuMZD8EAwCJFfdmd2Tory8hx5CRvJjCjjtHbFI/wSDcj7LiG4vcsdjrFdeasq
 L0Umy0DoIu9WBlf6lFY9m6Umpy2UCrzXJhi/SINXFhP/sOt9K+l42CiJf42OZhVuV2wu10cYL09
 7amsMGRRUUGQvFdZgFgm4efLNTLd6cWcaPe90H8lLllTzDiIit17m7N0t9jf0fcZft3UgC5ZL7v
 SqKxBZsVip7C0qwLDap9RN1v6hzp3tNOyNw1ktQJRQw+z/g2EnYiYWMUCJ1RVcxD7BUD/eGMVv2
 vpwzPyndKlPK2/a7koR/qh+sW/r7VfXaeBLLvSdFUtoeSmDz7+SO4EYGTbwnt2zxkczV7sEE=
X-Received: by 2002:a05:6300:95:b0:3e2:10c4:a5a1 with SMTP id
 adf61e73a8af0-3f7a7ccd2d3mr1944572637.30.1794575886152; Fri, 13 Nov 2026
 05:18:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109105652.7114-1-igor.torrente@collabora.com>
 <CAPj87rM3_MCFMGSAL1P6hBzLsLNP0hNL58whe1AeegtxMvgBhA@mail.gmail.com>
 <1a1c54dc9d7.326328084617249.176092468769907716@collabora.com>
In-Reply-To: <1a1c54dc9d7.326328084617249.176092468769907716@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 13 Nov 2026 13:17:54 +0000
X-Gm-Features: AclHuK_c5CEAuB2eiFb0Y50oZOIXOdHlWyiKp11ys7KDwXVxB4P5MSG6jFK0nAo
Message-ID: <CAPj87rMXqszfmW1M7MygmGfS71fo1Q=fcdW_N9-PTvfw1W7wdg@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: Allow exporting BOs with an exclusive VM
To: Igor Torrente <igor.torrente@collabora.com>
Cc: "boris.brezillon" <boris.brezillon@collabora.com>,
 "steven.price" <steven.price@arm.com>, 
 "liviu.dudau" <liviu.dudau@arm.com>, 
 "maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
 mripard <mripard@kernel.org>, 
 tzimmermann <tzimmermann@suse.de>, airlied <airlied@gmail.com>,
 simona <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 10 Nov 2026 at 11:53, Igor Torrente <igor.torrente@collabora.com> w=
rote:
>  > Is the problem that:
>  > - the guest requests allocation of a BO with exclusive_vm_root_gem =3D=
 guest_vm
>  > - the host passes that allocation through
>  > - the host exports a dmabuf from the allocation (which fails)
>  > - the host imports a dmabuf from the allocation (?)
>  > - the guest requests the BO be attached to guest_vm
>  >
>  > i.e. is the problem that some host implementations (virglrenderer)
>  > handle BO allocation exclusively via an export/import interface?
>
> I was testing and checking a few things. This patch needs at least a
> rewording, but maybe we can drop it entirely.
>
> The virtio_gpu part of Virglrenderer used to create a transitory export
> to mmap the BO and attach it to the guest VM (not import, as I previously=
 wrote).
> With resource_map, this transitory mapping is now obsolete.
>
> Vpipe still shares buffers with the client through FDs (even non-shareabl=
e BOs).
> It seems that this is an expectation of the protocol. I will check to see=
 if we
> can avoid this for non-shareable (exclusive-VM) cases.

Yeah. If we can/should extend vpipe to not do this, that seems like a
better path forward.

> Lastly, if I=E2=80=99m not mistaken, CrosVM=E2=80=99s sandbox separates t=
he GPU device into another
> process, making the export necessary (possibly even for non-shareable BOs=
). This may
> or may not be an issue.

If allocation and rendering are performed by two separate processes,
then either they share a VM, in which case they can pass GEM handles
rather than FDs - or they don't share a VM, in which case the buffer
isn't exclusive to a single VM.

In either case, I'm glad the performance delta is pretty small. I
would be in favour of masking it out from userspace: when we get to
the point where we need to improve performance, we can look at doing
something structurally different. Allowing exports of 'private' BOs
from the kernel feels like opening a door we'll regret later.

Cheers,
Daniel
