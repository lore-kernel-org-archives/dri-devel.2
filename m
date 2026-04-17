Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8E6F8DFCE
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB3810E2D3;
	Fri, 17 Apr 2026 08:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="csWpib2b";
	dkim-atps=neutral
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA50210E2D3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 08:23:09 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7dbec19732eso402514a34.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 01:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776414189; cv=none;
 d=google.com; s=arc-20240605;
 b=KNBS8Pvc9YCF6hppfdXxaEVeHgiPsrZJ+vVtL0YgIo73El2ARVYY6KF1EgLhDIfDYj
 j3+nIjQcit2lE5yieB/gadJjURFSDMbjOa5d2JFuSaoH+r55Ggdp1EOTM598D+xye32A
 3cfhAl+RRzRh0/vtqz/5xZvPAbAb6NIl99la00v92l2iRgNHK5p4DIAFqiCTilkaR8cE
 teChf6P1jeM9SPeSms/Rtp+cdG146eVMjpF4Rses0VgM3p28/bFD3q6HdgcyjPiqsCl7
 CVnae6zRaOXTBqf8evDSRCH4adj72wNDrR3vpVFh+76m0orew4ash9ALLsNTy8mrcC65
 egBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=woDoqLHIajnMivWv45ENu9wE6nY7bLc4DhmibJPzpDk=;
 fh=Z4P8NdJ5BVWb9KL5LRI54MoasMbuUf9wM+m1qDS+hjA=;
 b=VMgRBu+5vTO9w9fX5qhBaxYw3vZBg6pnm3nPkKjgrXsNoTLU5yavCQXNkEiB2q04PP
 mQSz4FIzki3l/umtv/Wj3/eItpBfSxuIrIH04F2w+S/186tTp7ubIkVKUPvyYvByIAky
 mDixihzNDM8PaQ/03EXMtU8I+56rXCSvJe47Tjc2r+MUiHu6tC/b3l2sRVvKjzgPNflg
 /PQos0s5/C2DBL6pass5pXSm+4x3E6tgSSHDOWJHVgwMUqPF0IeVXcDVBhdUSvljo7UB
 U75im1W74/MAoPBE+3lPjRxRM8WdqVVNPPfzv4XEApxYZZ9UFnG/++1itx2Wic2Z5LuA
 FH1Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776414189; x=1777018989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woDoqLHIajnMivWv45ENu9wE6nY7bLc4DhmibJPzpDk=;
 b=csWpib2bR9AQyUw0JLB1H6xKcrZa4FzbQxxo33sSY15yffkKxlSyWip58tJFrQWSnF
 hAefpS0YqTrTROsSArUGf6IsFr4yNwXoA1gwMmTUiXNA88gyQReL491/lsoiGtr1f0oc
 kYqk8gENygZ3tteLJ21obxPyAOuzuR1VxnDKdvNXha6WKZh6ubyRsNt0kWxYfOxk1SDX
 Ia0BN7yjiZzDGs2St6sTfwjZQHAJiXKDNsMZ0acSe4dKQAad+/IyDfc+FcjGziSV1Rk+
 O7NyRCYp8xfZT/btLmb4s4TeCQw/Va4gn5NQwsByZBlewZ2eEA98R53M9N5cWKvWQqzf
 oR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776414189; x=1777018989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=woDoqLHIajnMivWv45ENu9wE6nY7bLc4DhmibJPzpDk=;
 b=Z8G8zCwEb+8a6kGdXnA9ABMHkFidZ2ufbae6gvCO4wdZtnX1q9jgkrQqYAgEn4/NG5
 XHNvO4b9Gyxa4OnlZ6p9A0rX27LTzY2cwYanIcSepp9Rrng7FbQXLfghCGlHlyq7ewJX
 wxjiw1DvjkjxA3Wh4tKIuCEqa37vc/ohx5+Dy3lMnLKZW7XxqC2pH8SWCspgzqUjJczG
 uoj7qtU0KCbnqb89+qAZTo0LO/i5mqmmFmvoIZt92XDWOiMhUfVh9DIcxerNBN1S9FeM
 Gk2zpyNi1oeYDP94ogU/vFVp1kddwH7+PH3mU/J8ms8VX2r/M/+jguDY3GSvUF289bdp
 9vTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ819Agpe0t0kMtMvFZWtzgjX4yNRpSGdXxcds8uICe1fnDedNd2VoXvOiCuQXld5PSWUWKa6GXHw9U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzE8D1s4Ym5eeX+j/adyxTPLdh+nzZhe8ckH8Zsx3l70hj/Uhzd
 8MJIdGqzQ0uLaT1aAOJAb/vAGL9U52AmSLL/RfEPMUQA0Mea2rgv4uy0c7odP2uGfk2xDEzKCXj
 ca1DFSpMK0GvlI2nFVpJCMCzXidCSquE=
X-Gm-Gg: AeBDieuJwHCnHs6q6KB6hW82bHY4QiqVyYzAN/Mf5oYP7O4b+S5/Sa68LnfvBJ0kaXU
 fzzN3aulaVpqeZy2fQGPBKtlDfASG3smzfrtAmytoSyEpyoqlChqG0M4hB8cxAx0J04Gha52sLM
 rdAU445rA/7nqdO/3atw2X0V0CXdIZr67O8hRla3llaV6vTYpcNoO8WlOWo0k+RhnIyleOnbcNA
 idL9TcTsrB1R4oREA+KRGZUXCLPOOh+wzclwul7Q/3EWCl7BH3/tQOmALRiI7RAoNulnHK/5Ogi
 kvPc1+gJ+Jq3t9j3xZM2seK9+Jt9K00=
X-Received: by 2002:a05:6830:81ed:b0:7d9:b58e:55ed with SMTP id
 46e09a7af769-7dc9522b228mr1064055a34.25.1776414188878; Fri, 17 Apr 2026
 01:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260417001503.26147-1-mikhail.v.gavrilov@gmail.com>
 <IA1PR12MB63074B99C20B81C7D5DFD7C5F8202@IA1PR12MB6307.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB63074B99C20B81C7D5DFD7C5F8202@IA1PR12MB6307.namprd12.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 17 Apr 2026 13:22:56 +0500
X-Gm-Features: AQROBzCXwvgzZjV7RJEnXadzoOfi3sm37MeeW-RH5FptvuaBgU_TAR3aHCn8pW4
Message-ID: <CABXGCsMnz+m3cHSQMAjOsGEz35u4usQ2TJuxSwZHQuSBEThF-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add FPU guards around dcn31/315/316
 update_bw_bounding_box
To: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Zheng,
 Austin" <Austin.Zheng@amd.com>, "Lei, Jun" <Jun.Lei@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rodrigo Siqueira <siqueira@igalia.com>, "Hung, Alex" <Alex.Hung@amd.com>, 
 "Varone, Dillon" <Dillon.Varone@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, Apr 17, 2026 at 11:50=E2=80=AFAM Ostrowski, Rafal
<Rafal.Ostrowski@amd.com> wrote:
>
> Hi Mikhail,
>
> Sorry for problems that occured on your platform.
> This issue is correctly fixed as part of this change: https://patchwork.f=
reedesktop.org/patch/718415/
> Your change seems to be duplicate of above change.
> Please retest using mentioned patch. If it works correctly, please discar=
d your change. If problem still occurs please share me details and I will w=
ork on resolving it.

Hi Rafal,

Confirmed =E2=80=94 patch 718415 fixes the warning on my hardware.
Dropping this submission as duplicate.

Tested-by sent to the original thread:
https://lore.kernel.org/all/a59292d686e3d5c17fe36e20b55996208d36a6fb.camel@=
gmail.com/

--=20
Thanks,
Mike Gavrilov.
