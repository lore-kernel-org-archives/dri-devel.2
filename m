Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D961606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VDlylGF0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B5B112334;
	Thu, 12 Nov 2026 22:25:36 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C4610E6A7
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:25:29 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-4fa872538c2so28956b6e.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:25:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794522329; cv=none;
 d=google.com; s=arc-20260327;
 b=POwDY7iKUFqWjIAQfDcLFo0zFi9abPtZ1jwj3104avwR7/oEhJf0UIUeh52NGwaYiB
 5N5q1Sbj57udW8efB0/FBa3zklla6FvvtCJDMk9+5zxgUZDRpkO9tkpOe75eJKUhQxv7
 5vWb69NkBiGSZyL1QTLTe7xdLFxNID2fkPvbL7KugZpWlssQwNRAiNosJgHU87NJuEnQ
 vjLynCEqdDEX3QkYCGDGlBgA6j1Ip5450GjkkRNR0Z1elUqH+ga8plTp01gbk/KYezXB
 7jm/kQ5Iadc3AhB9/U22pfjg2eZzMtVJwtIJfA/0K4F6CXYT4/0bZ0d/mK2rBz/6iqbb
 1SMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7MKTVXjppM6Sj39d72sw6FHgn0wjt/0qge0qOjFaJdY=;
 fh=W22SYsp5seCk0SsqkSevPI6HfXd0TK6nsU5YiHInEuE=;
 b=Wkyua+vvSrI5eAw9vnkG3oTURiGmJqt0yxstu+hBuksIfb5pfV4XpH98sK7mzuZl5c
 u2og4eUevyd01OMkeSgSyR/Z/Jma+km79GQA/VYBhVd/6k223sjpXOtsA+4JjDELILNS
 YKt+QwaH7EDqwvkEpry/MfXMrjCzlBRgg16ViKxlod53iKRHpOPEXVGGtF7ls3mf9MD4
 1VNT4cxxrlpWPmy+87J02s5oNYQYQuYHiyDaiV0HV8sVya/w7+G7uYGdGBlT55p/C6+a
 dSfpDB2rHRCITxfd5Ncp6dYV/9/Saplwy99nVXp5aDNwxlBXOrmS0py1jY96oMZAraYu
 /pww==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794522329; x=1795127129; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7MKTVXjppM6Sj39d72sw6FHgn0wjt/0qge0qOjFaJdY=;
 b=VDlylGF0t4AKPWWtFJih+ABv4J68nAGaSEEp+l2+whjIS5HDQ7DEyFDd0xbQyYIoUX
 2BoC6OFCfxU3Q5wFa2RjZzKjzvDeJ2EilWxXpPwNlxnfWDxV8yEgkhhlxXeicWEiQ6xl
 Up1itUKsUWUA8Gd5EOq+IsTOztLh9DpJq9oxlVHNJ0mrRb6qB/5y9FPnQIyoz7CM53jr
 SnTcD370NTPgzVFqzxZ1gfEWP80liJHHNA5YZqT1paW8sGuKjPhA6et78uHMfbUrwI6q
 x1ICXmBSvzZ3ggEbNlGczd98RYGXy5EuVvaerf8yFBRfqPi/48b851DQ4lW3QYEV4CM9
 W5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794522329; x=1795127129;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7MKTVXjppM6Sj39d72sw6FHgn0wjt/0qge0qOjFaJdY=;
 b=RrPJccJoYoNYULEoOTY9sZeLpR1ZLTcaCjefLKeit6Ogz6ENuy7HPGnDfAw0duBbXX
 /O5sDi3FOcSvNzIJnz9B1FBYEmvQYEKlyXwBG797un1lNA/wgMf7j5z63ul0C1zPwJMU
 37MEY7SYRZ5cs06H3tP/hbVd0N6UyGWLcSldD+HxVbzrziKCywsbx92i95YOYEyx0G7A
 2084WfwiufNJCeUjeehF46Ru2uCTVQqfb6JUCNrf/75zNBfTx/Z+SYd95ChD8Fk2h5IM
 KmTplS8x4R48TsQnkYd77/q5QcBaEundvS+xj0Ky5eikhJr3f80O/07yrrWp2BmvmqqI
 RDgw==
X-Forwarded-Encrypted: i=1;
 AL+hErHDpAyMYqZczwtMbzdmHuqyzc5Hh8GklAgzdstFrcesIUYSJ2sPrGika5SrhvwQ8aAJJ3l24hvW3bM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8qZPenyx6xl57wWNQe3wtZ6uDPAiuFxED5ozpAVNRu6Lp9cl/U
 DUaLEvn9Vj6Gb3Wc5a3WmJoNpx81p1vucD3VjUZ1SUHxW4etHAK1eye3KCD9sXb/PvFW21d9V7B
 g0v5EnRy9mNzdVYVDxt/QK+Sd2uAB3Qc=
X-Gm-Gg: AYBFou1GLWiH0qE585dbeQhCcscgAt7itNzxPK+TrAqFoXNvSmMpJFS2KOppIQYOQPz
 WvWldpHtNJOT7Aaxn0pMeWoKeJiMfz4sb/c2z9cA1KB/vjmIXREhzQpnthbQVW/joicAOjw9o3u
 qfLlE8lLb2LtxLQGTg6PFNEeBoEfFWKOXd/IZDt+xTY+3Ih2yc5YnADVahKqgvFyze/qmp1nEl7
 iK4eDCwg9lok5LXNhBFvXpfh7ysBdeJ1NZCyLSCrKf2M2BMhzZFLboKa55td1P0GbKLbMKLN63e
 lOLwnvs7a4V2aLdHpZtaj6ZO5W0vVo+lkJN0JEpMQapxKKuPO82NJMz20uBwuG/+wk6HQN9cJrW
 D8j8wq3YULZXiIerR/q6pLK5EfZYHWUUBM+OPAOr5ljhDnBZlO2VtJYDltPzvFTHQJMZB3EBGVJ
 OOPDHgUitk8zc65P3Xbn2ZtJWvF+RnYYG5q1ojiy+0ekKiRaM/7OPoiTw29g==
X-Received: by 2002:a05:6808:1927:b0:549:e9e3:9460 with SMTP id
 5614622812f47-56e5cff3837mr1010087b6e.0.1794522328745; Thu, 12 Nov 2026
 14:25:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794469153.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1794469153.git.u.kleine-koenig@baylibre.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2026 17:25:17 -0500
X-Gm-Features: AclHuK89_7-xJ0fNP96-d-HS0yUpV4nDEkjT1yR4ni6ZgFZbGukqx6Zkpd666p4
Message-ID: <CADnq5_NFNbQF4F---Y8f-K4ZGb8q6=CdDtM0K5BL_nhsNbd47w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/radeon: Cleanups around <drm/drm_pciids.h>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 3:06=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> patches 1 and 2 were already sent before
> (https://lore.kernel.org/3205129f75aba48bd1ad8fc810cf6a18e718206d.1777545=
446.git.u.kleine-koenig@baylibre.com
> and
> https://lore.kernel.org/20260430102958.136859-2-u.kleine-koenig@baylibre.=
com
> respectively). Alex asked to resend as they fell through the cracks. My
> motivation here is to have the pci_device_id items defined using named
> initializers to be able to modify struct pci_device_id. See
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre=
.com/
> for the general idea.
>
> Note that patch 3 depends on patches 1 and 2, so if amdgpu and radeon go
> in via different trees or branches, patch 3 has to wait.

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
And applied.

Thanks!

>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (3):
>   drm/amdgpu: Drop unused include of <drm/drm_pciids.h>
>   drm/radeon: Consistently define pci_device_ids using named
>     initializers
>   drm/radeon: Fold <drm/drm_pciids.h> into its only consumer
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 -
>  drivers/gpu/drm/radeon/radeon_drv.c     | 702 +++++++++++++++++++++++-
>  include/drm/drm_pciids.h                | 702 ------------------------
>  3 files changed, 700 insertions(+), 705 deletions(-)
>  delete mode 100644 include/drm/drm_pciids.h
>
>
> base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
> --
> 2.56.0.rc1
>
