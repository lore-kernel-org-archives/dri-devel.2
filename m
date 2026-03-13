Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13ED105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D4710EC3D;
	Fri, 13 Mar 2026 14:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="WDUFHPL9";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CE310EC3D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:16:24 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-483487335c2so20931345e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773411383; x=1774016183; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ellTIQKUVjpV3d7rtlz+Cb1dqcrKlj/Bb25VGUxyP7U=;
 b=WDUFHPL9683A+12BCqfvXGMrYzdbwievuhZfo4nFdiVXiGu14swB00pRRIpHX3cA5x
 KgeNVC/UjpB35RaS2JLIG39h6dCDWucLY9yf255Dq/7TbdLHs9maPTPqJmP4d0WkoOqF
 AQYCipiTUV4dKL2VsrTRz2VaxCLjS43JF4nlOCjB96/VHZP5tWqzpjC6D/RUHLr7jW/Q
 nzKoXgObq7mG0+Jx2v5n5ZjFEYrSu3i8McId1VPASbRuF9ha1y32a5tPx2JhMSQ6zZ6l
 TJbW0gGW/fCjXjhIbWe3bzECC3IurYNQ6MkA2WMkcJ++LIZbO3iWuPsrqWrCpSprmQsl
 zy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411383; x=1774016183;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ellTIQKUVjpV3d7rtlz+Cb1dqcrKlj/Bb25VGUxyP7U=;
 b=HxEhYWETL+Z7cbHk7n3TBoyqerOgTXybiwJzHC6xW5CPN6wpebKaV8QpZaqjFlrpeT
 cTdEFQhCvREVII17j2PnTqLxiaJNX7ytdoWnzfmpuvPxBRQGmL+j76XGSpWt7n05xSU1
 4Uxk/Lr3czReouyd3wvD91jB9H7Godb9ISSTQe9e5djUjXUQF43HtRGOnkQnY4MIAgGU
 TIdU3L7S95se6ttgyjTpdSUS8TBBwDF1rrF7q3MnKmbAm87NG7T2p2g+j+u+BrUiId3n
 ykcTCsqLXA5haPeM4/5/MmEvDzkr0zUnkCLNRjvgx7FMJtxgL0QdIOJZjeZgsRNazOOp
 igZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwqW93eYGp0dNSw2mm2zMDzjYNLNJq2VVNdJeC6FKKTkieJgWT2gotMBEMnXT9kzP2U1H+jgKjApc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUvm1qvy7UZxWeBDVB1uka+Dgsw70OlydIpASX/x8Ep81A7K+C
 TfoviabvC550OmqZKg2DVgUO2pEANpE7Hfd2pZmnXyU92uALpiVwvJQ6qTn6e1VT6Bo=
X-Gm-Gg: ATEYQzzlKwy1KS+wsJ7Qd/8fEdTBqtTpNX/6X9ZzbVCfuAzFhrWb/rrhJprxVm6H38J
 bbGqgEloUKqxwRtWcQoCYH7sitNLJIpJJwPfcXOpJ4TsxYSO7UxZKdPX+DOtB+Yb6E4pCQzX5gz
 1can7aPazFS4XmB9j+MZz7y5AO1zvwlA8R9emJYTsVg1WbrPUNzbpUhP+VUeV8hc20SURUwoYa8
 I1FgdmZa7QjYVEr9IGb6kbNHwVNQ59R0euHMNcFoAmHBfJsHeGD0u3GxHn2/mSwYzn+IaewtmYp
 SRGDGZe8rDl2JKjWC2fTgN5GGG/QMigUKNBLjotVPFJrdzl+30Eld2dEoc2jJ34cSJlF8EST2C4
 J7IC4dd08xGu1zLYMkwyiPVgCrEE3GHbHM1+Zzvl9+vMnrNv4OKencMznVsTJwzFOzyGcch70s0
 oyjjY0ihyBSV/sCV4j2esllt3+G7nsUV1/q1gdIloQMwQ=
X-Received: by 2002:a05:600c:6287:b0:485:3f72:323f with SMTP id
 5b1f17b1804b1-485566d2ff2mr57941605e9.11.1773411382974; 
 Fri, 13 Mar 2026 07:16:22 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485563953dbsm43751525e9.0.2026.03.13.07.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:16:22 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:16:20 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Natalie Vock <natalie.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
Message-ID: <cykgy6mf4nu5kkwl3uc6modkj3ppela2xgjy2ijidpyzdsnyn4@cbwivcrqa5kh>
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-2-7c71cc1492db@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pmriianp2kll5lsk"
Content-Disposition: inline
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-2-7c71cc1492db@gmx.de>
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


--pmriianp2kll5lsk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
MIME-Version: 1.0

On Fri, Mar 13, 2026 at 12:40:01PM +0100, Natalie Vock <natalie.vock@gmx.de=
> wrote:
> This helps to find a common subtree of two resources, which is important
> when determining whether it's helpful to evict one resource in favor of
> another.
>=20
> To facilitate this, add a common helper to find the ancestor of two
> cgroups using each cgroup's ancestor array.
>=20
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  include/linux/cgroup.h      | 21 +++++++++++++++++++++
>  include/linux/cgroup_dmem.h |  9 +++++++++
>  kernel/cgroup/dmem.c        | 28 ++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)

When the helper is added, the idiom in
kernel/cgroup/cgroup.c:cgroup_procs_write_permission() could perhaps be
switched to it too (structured in commits) to "optimize" migrations from
large depths.

Thanks,
Michal

--pmriianp2kll5lsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCabQcMBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ah3wwD+M2PKuVG6OqToZYy65XLc
AgTWSOf2FCryVryu7GdRkmIA/RL1VRrV6USyp/q1q1lqwwbA6eshjCbHtFOelFXs
vd0B
=B0dw
-----END PGP SIGNATURE-----

--pmriianp2kll5lsk--
