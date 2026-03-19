Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868E6107528A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D61A110E921;
	Thu, 19 Mar 2026 09:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="f63Ile1p";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630FC10E921
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:40:42 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso740731f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773913241; x=1774518041; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ksv+ktKaC8GevXcLZ+qMKcgkHRuEIu5UtXoIbyr6KGc=;
 b=f63Ile1ps3zpUFCmSC9snoF08/GynRbSLJWYc0b2V2J1Gxa8JQFOXP5g5eATTGRr2q
 UNwBhWrfVP7upNmeXoA6Sv5QrQ7XFYHbcVsqegkD3ErxLO2AnZiWEjnaTozo7okGZblO
 FWHoJevN6dGvYpg6p2x9LtIHMdue737uVm0AQ2ZPQzDf9eQCqgzFitRgmOeWoTvs21LT
 ZzBMQ0BaJsoACQfjKeEWHX4Q5+ivFhBiKMZhxy3tZC/OINAr8GnBvYYVhtpHs9lTghzr
 iexvtUM+hcbTTkjxIN/EKGn5r7x7jz/jQTN01jA4MQ6GyqtVI3cAc11SfR8Rlvo5iLeI
 n1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773913241; x=1774518041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ksv+ktKaC8GevXcLZ+qMKcgkHRuEIu5UtXoIbyr6KGc=;
 b=FT+yD8DdlU9WCeyl14fmoXX6rsMI8qhLDYp04PweE33RoqqYs16jh09KTqUii05jjw
 C5fJ5d0mNqK0dhTaXkmxCdzK+XtTVq3J6VaeH1wF1tRA7EOdYzGV4VuLdelQ2pJysOZb
 XvUHj5xtnAXw6LawR9gxL0lDKnWsYX6CLfA1WhdAkDXGCim0qbC9zSuwDC7dHWTM9O5n
 dfmbDWZLuEd1QpUTzQTDfVcLs4i/TYOSlv+6gzKeJP0bfTTiqMhpG1pKWbOx4UkYuWCs
 yY33VVQ/Q2+Gwh07FZ6vO3gP+ZLSmEozSBsuY4JOkAJYH53AHH3t65BbHNKYyXw5wqcq
 oXyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN2nLQhCAWBrNgBKiDQPEY4D0Q/5nR2tDJCoZ5nhqfwsqSBif2jB1FnTyWuuuS3wrQZ4k2pG1n38Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/3b8pRMQLGmfutjxfoyyZZ/3mucDDznkv+dexT0H2Q4/jWLyG
 zEpnyzzGxZlOWObB6gekwQgGzErsn9It+bR4DBR7wvnUhCSCPrF3BriCT5pjrbE+7G3yiNdxrus
 hy4Y5
X-Gm-Gg: ATEYQzzukIuLz1G/FL8LFjQpGWs0u9x4kmpa91QXB24i9yEU6vBNAp1S/bqF8TjDtmB
 SP4/wFcxTcMMi0pb7hDOtfBek1pNcGsbdmGHbH6HRb0JbDSwLnJZg5hJLgpfKXPoXNNGpsSc8xR
 p6pCgRa7lotqdXm5hwpJC+d0BXoRX7KjDerid2LfM+6za7zzeak7zKwdQNxjbHaAk/uSPOl/57k
 ii+yxOPsp62X9kicAHC/OMmUfl9+HnjebMU51ac5/WJGYYEuww/2p67PT6p2qpY0t6Mnguw8iSv
 ZaYWjlgiTstT/xWTRdTvlQThaq7mYXmNakRtbW7qeSRDLiuMo0m356EZajzD7PFP9GXeq8jqbZg
 X87NfhZlDa/MS3zwMzoTorWJjiPKoyOUpLiBmB8wDA+eBpCz58altUCp20WbudvfUH6kHz5irTD
 Kl6NXb2Dkf1GJDTYeuVHN43CeF68ZVaC+X94hsWgL8KQg=
X-Received: by 2002:a05:6000:40df:b0:439:dfae:8083 with SMTP id
 ffacd0b85a97d-43b527c8185mr11899125f8f.38.1773913240768; 
 Thu, 19 Mar 2026 02:40:40 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852aa8sm13291972f8f.15.2026.03.19.02.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 02:40:40 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:40:38 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>,
 Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] cgroup/dmem: return error when failing to set dmem.max
Message-ID: <2q5heaiptuzya3nkmskzudeorda5segp7t2sf76btmjcgaip3n@unslzqgudcv5>
References: <20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com>
 <02c0752a-1a66-4938-9f5e-152c8c98741f@lankhorst.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aikibhpbtycrduju"
Content-Disposition: inline
In-Reply-To: <02c0752a-1a66-4938-9f5e-152c8c98741f@lankhorst.se>
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


--aikibhpbtycrduju
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/dmem: return error when failing to set dmem.max
MIME-Version: 1.0

On Thu, Mar 19, 2026 at 08:33:12AM +0100, Maarten Lankhorst <dev@lankhorst.=
se> wrote:
> The semantics of dmemcg should not substantially differ from the memory c=
group
> controller. I believe the memory cgroup controller does allow setting a l=
ower
> max, and will evict until below the new max.
>=20
> See mm/memcontrol.c:memory_max_write
>=20
> We should probably do the same in dmemcg instead, although we currently h=
ave no
> mechanism to evict, setting a new lower max at least prevents future allo=
cations
> from failing.

+1

Yes, if the dmem resource is preemptible, the limit decrement should take an
action to fullfill the limit (like with memory.max).
Even as non-preemptible resource, the behavior could be more consistent
with misc controller that allows "storing" any value (with the effect of
preventing further growth).

Thanks,
Michal

--aikibhpbtycrduju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCabvEhBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhoFQD/Xj/3hWTWWjgyzyS5VfxQ
PXZGrYFoikR/GSRiLFv6JW8A/jfpwR80FGuMsA73ceRBxHElklIgX47i2XquoClx
W24K
=xuQS
-----END PGP SIGNATURE-----

--aikibhpbtycrduju--
