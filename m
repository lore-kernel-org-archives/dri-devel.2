Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9992606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NFITT5d5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D3210F5F3;
	Tue,  3 Nov 2026 14:30:52 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D6110F5E3
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:30:47 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-36bd3dd31a6so73890eec.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 06:30:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793716246; cv=none;
 d=google.com; s=arc-20260327;
 b=rCspBySxXWbr7dRSDsAdu1k+e/9kS0KziwGU4Een+Rbc1VmICkB89aI6/YwBoPD0j0
 TRmtXCmNhGbyR+ZFpT7g5LxALIxYr6vm+osGvcSky2JWp4l3P8Ojo3LD3DSBwFVV7nL3
 /UJqOF/iRG4WhjI32EfXsBZPw4d5Kt3hIWWQlJn7rzWCIAe6z1XhPUpVIkyOlo6N9MJm
 WtbQ7Or5aOvFcXtYlBRksIpO/+z4BVH4Oyb92Rfyq4IgI3g7uQXI668GDbS20TtdwghO
 xvijvpmiytnX2910GTsoRiWtu1Vww1L/pxRhDWTPiZZTpwy2d+ecXhv3TMKj4o503LEc
 VCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/OyNH4m47qkiBrtBEXVKxPfbZI/Pm865e0NtmQba4xg=;
 fh=aW6ueGPzVv+8zr1BZ54SdUeBGodUEWLaTktNESzIVhA=;
 b=YQ7lPhY+4N4CsrOWKS9In+hYaN8V81Z8lTTaJTQ9hCS5ISVzKzW40CbzDYpfLFlU8/
 qD+/GInvSuR0VfZ+ypM4105tf/tXIKSgOmhOJguKKK4msMnj2gOdJZsIsFirHiS8Hk5d
 KkI238UZOK4hsLKFbZaY63s+kNRx1TjiZHcTgWZqtCQyhHa7SUz2TtWbczGEtBgS7lNq
 GUm+aeaPV29kO1e1PXFBnPlkCDXr63fMm31+4pPwJ8J/hiGqROebyqaLYoKH6ylWiV3z
 2p8y7bqkeIf8Lw0eT3um2dCaryCgXlaShZK0IjShqJYaz1OSkSD5DJti15L0qJEBzGPG
 HSmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793716246; x=1794321046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/OyNH4m47qkiBrtBEXVKxPfbZI/Pm865e0NtmQba4xg=;
 b=NFITT5d5DfgrMMdtdmPlq335LGIMtC/4PSZHttnrb4QT9/6QSXFP2/I/q2z0EP5Fqo
 +IlIUJLGtBfEq81QV/dcPwZDg83fJDxEETuSk3lY/qpQO+Bq20dZ0k9kXpTCrrNBjOTP
 XF3yQ5X8rQlf2TP3c/ZBGh3PYz0dhAsaHf6oPe1LtCDkMpF13d5vPv+9+eH//RakaQlp
 yFAYAUwUOCyCZDL//qgcVjnE9nKuV0pOkgweqRmBEGudVqzLjLkJmfuoXticoOUqO9m+
 oxc2Q5K8pLYY3m4Tk5s1e4pVLb2r5Aj4NL8zeK5GMUmuDuzbdWJQtLindgEXbeaI4Qas
 SG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716246; x=1794321046;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/OyNH4m47qkiBrtBEXVKxPfbZI/Pm865e0NtmQba4xg=;
 b=OQs5WUHNJODIrtiR4YhLzNNcjpYIST6f9WV+ZPzAv/IncutQiQEz9moCeqtUEHyib+
 9z4z8s+wd0wgYye6Hm7ERjV/ibAnrm0oybB27jN1sUgUJtUjF87U0bESRWwrLbLuCaE2
 54m9awyeDzMDS2JxJKd4wuubYdL7b1jh7Wsh0rvaJd/pyAZHHjlhMHvl8FlHzYyFAAmF
 YW2BbLF0Y5QYlsdY83rQC2yPoG9uMJ6foy/MzCltMlq6je3lNLsL01LOV++acg01lG6d
 hUrBZw3l55H8ZyA81fXkn5rklG12gDK/26y8aJl+CYaJv2l0IOvU/hV2DVL9XCsdZctr
 QvXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1z3vFrJ/KkHKFO0aR+y+ojyws6xEvKlDhCiG3YbFIVhDimBTE8wGmRvWv6AgjofWi9Pxn0V4WZak=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8U6fL3jYQEaOykpabKIm/nUgomm9XMfX5ODhsD9IfmVBCYQGui
 zZ+ggWK68fJfeKY2Wpc4TnpPRgJTdz1NKb6flIDTfFVfqEzP3bTega5BNWkAbACwAWo05Tr0wBs
 8bUkikeva+3BS5e+9DmLTWcEUEQXn0fVq7hT/
X-Gm-Gg: AYBFou21Nf9tVNrkXMXfnfhkJ9e4AyM3BA0KEobkr5JdUJPQTLvtAeg6hykR8vuDXhl
 bta9DqSEj1cuFrrqFP/x2uhtNZmdDH1a0SbyuMywhv6D0GRQiy/oEHO5zGEvbymdSZ2750C1Ige
 wO/Oppv0IJqQq1OAuMDJfKKBmein/OOfD2Lit8pC29gkea+szbIXFHmCZVi3JAYOmPLxSmbuNu8
 3VH16DF8rwiYE/lYC0AqpsIVG0Cs/Yq5P+hohJlth83/VI9iTxjzV3w/u9tiTQ13DOx6cEBzU/X
 8w0JPowOXTz2vZdjQgtWAFnJ5A+DfvYqbqiMus3bJCWm9HD73mBDkWsAqEVrh+iRGIVNofvi+vg
 J7qW861k0mw+XbngV5jepqGVv+Fwd2SSvYzYYsHRy/rjjBgSho7kzU75rPDL66Ea91/MkjSuPWy
 VGSAArPOu6Mv8vrp2k0KZrAcU=
X-Received: by 2002:a05:7022:eb46:10b0:14b:edb2:c3bc with SMTP id
 a92af1059eb24-1ac4fd01362mr31568742c88.0.1793716245958; Tue, 03 Nov 2026
 06:30:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260916144014.879355-1-ed@aicharmers.com>
 <CADnq5_MsaUDm8rcxr3_0wuEAXywxziAofOO9w-dUxYS9PUoasw@mail.gmail.com>
 <20261030123000.5573e70f@kait2en-mbp15-1>
In-Reply-To: <20261030123000.5573e70f@kait2en-mbp15-1>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 09:30:34 -0500
X-Gm-Features: AclHuK_LxctmigwVoDcx69kjcX_YjAvRxU28VYR1bNj9rG5Y2V1BrN_dTiv7lGw
Message-ID: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
To: =?UTF-8?Q?Andr=C3=A9_Eikmeyer?= <dev@deq.rocks>
Cc: Ed Schofield <ed@aicharmers.com>, amd-gfx@lists.freedesktop.org, 
 Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 30, 2026 at 7:30=E2=80=AFAM Andr=C3=A9 Eikmeyer <dev@deq.rocks>=
 wrote:
>
> On Thu, 29 Oct 2026 17:57:49 -0400
> Alex Deucher <alexdeucher@gmail.com> wrote:
>
> > @Andre Eikmeyer I think this patch should fix your system as well.
>
> Hi Alex,
>
> I guess you have seen it already but the patch doesn't match the 16,1.
> Its boards are 7340/020f and 7340/0210, and v4 only matches 0218, 0219
> and 021a.
>
> That hang is what I sent a fix for
> https://lore.kernel.org/all/20261024162109.307247-1-dev@deq.rocks/
>
> The VBIOS trains the UMC p-states at different frequencies the pp-table
> lists. The SMU hangs as soon as UCLK switches into level 2. Deferring
> the UCLK enable doesn't change the levels, so the hang just moves from
> boot to later under load.
>

It is the same issue.  I don't want two fixes for the same issue. I
just sent an updated version of this patch expanded to cover more
macs.

Alex

> The two patches can coexist after a trivial rebase.
>
> > ...your system...
>
> I need to clarify here. I actually don't own a 16,1. But I maintain a
> distro (KaiT2en) that specializes on T2 Macs. So the patches I develop
> are extensively tested by the community before submitting. Atharwa is
> part of this community. Ed is not, but Atharwa reviewed and tested the
> code.
>
> Best,
> Andre
