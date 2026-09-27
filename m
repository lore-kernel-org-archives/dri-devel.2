Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6520DC98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 17:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C33D610E4A5;
	Sun, 27 Sep 2026 17:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="Qk3FG4t2";
	dkim-atps=neutral
Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com
 [74.125.231.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D08E10E0AE
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 17:34:09 +0000 (UTC)
Received: by mail-oo2-f38.google.com with SMTP id
 46e09a7af769-81be5042c56so356210a34.0
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1790530448; x=1791135248;
 darn=lists.freedesktop.org; 
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:content-type:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MuL0v1f3+J9yyQw0yqK0TvcdFgWSs593LTmvyHRza0g=;
 b=Qk3FG4t2NHLM2wOnlf2THwx7wwpnjO52mlNURVE5IbLMMc51KGb0K90+xmSOKMKu1+
 wQb4ePI1yzNqqgcejfwPaouIMzHE/nGqBaELGR/Sf3D9fwZWLjs4Han+ZUCC6RbyXPJG
 sn0tHrvf/uUkUJ9K2S4Odo9kF0WuItCnVGQvunjfqmqKjktRkpdf79Mxc7RIAreAdgMS
 3Of8Gktm9I0p/BfnblzsIsiIkp1Ymgcp8d3P5EMO0iiuqu/iZ2dAHrl/zU1DsH/Whs1+
 RyfPBDSwULTcoM8eNDRHSBggLh5EXoSIbJNIxJg0OYz8iN7Nz8uef6uUt+qX6ZEgxLAv
 DpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790530448; x=1791135248;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MuL0v1f3+J9yyQw0yqK0TvcdFgWSs593LTmvyHRza0g=;
 b=Y2e0jqnxgeAJOiAJo+jasvZmEEkaAT5ewshOYpik23RTF0OltwHuNRT0+Z6VHx2q0/
 X23dt2XrTMWeaoxpxCE3CHbhgsAHZtObd00aJ+ZcHBBpayTS5iWGWgroS/EcEpmskzxh
 Xz1N4Oa6zsFU0fNv5CS0hvWkCF+dlJdNt7GjRYuTOX57Hh256JZy3cpgMkFAPuquBNtm
 nqpPJBkUtkS5WkvQhl6BfcCovAhh0F6uNL0DOhqq7eqVeHdSru1uTQNhrmeyEowqN0ee
 n+c+5JIdyeQk3jPajd5qGzdzYx5skzYPCoQn47xrwyQ+LxczZQACCwCvVyb6vGoXNZyQ
 gULQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBcp7Pwmf280Dy7c+l6NgobxIkISs5ynZLm4vfFH32ccKcUGDx5RqHPrbpGYbbgPKRnpKaTHeERRQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kL2tsqnIBXmci1hJlkqKkMBZNLrPIj41UnPswJ2ifD7BgN/3Xr
 yVU1Pzt23G8ig2jfmkbwfc8NG3KEva2MmAwq7Rcv95DmCWFvwa4fSiVtjojOGJUMAA==
X-Gm-Gg: AYBFou2t8KJFiSrk1e3LUKKTfXDzyZSgA8N6/xmfTF2BCKsDDMAx2C2hsn3cGFrSpxz
 ZWsXoqr8vbtmpAWgxfP03DeilgLGO9mfiJvVByHto/AhBpii2KCWiessBh6h2Fqh4cxnM+EE9h3
 bMLLJcIDwSG4wn9479QFuZxKV+Y2pO8q0K48bCBAZThMM95pFZyqMes1HmNa3Gk/b0qjRNmP56k
 CQq9+V2n/4iFvFVEkhYUAwhHbkw/06LDT7TTFRWDxtwUIEIlnIvB7VJ9SR35GKVlvdbvIo6NqDJ
 r8eFZoZ8kkuGSJ/xu6/SrmmsMbLPznMc+GlY4QBif3s7RjmHL4dwD2YN6EHo6MsI2aZ+Apz63XF
 JUXgEFbuPF/gRK4fi2MaXbdbFojzlwC3Bu5IjoRihpOdBV7LHS4vc3P5WhbszWkxh32C4KySfsB
 Et3F6n8WAgrT4sPrrleuGvqyGXluKFTIewS8G/cJckG2ouXxBPcnIHc7V3Cy4XzjZHyiQk9Nsh8
 PBZc+VnCoFBXexN5l7KNlo3dHXpcg==
X-Received: by 2002:a05:6820:820:b0:6cd:3ffc:64d2 with SMTP id
 006d021491bc7-6d5bac3e146mr7371645eaf.77.1790530448403; 
 Sun, 27 Sep 2026 10:34:08 -0700 (PDT)
Received: from smtpclient.apple ([2600:381:5ba1:a8b2:19d5:7f67:de2b:c3a5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d883394af1sm2755239eaf.13.2026.09.27.10.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 10:34:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate
 offload
Date: Sun, 27 Sep 2026 10:33:53 -0700
Message-Id: <3FDF3191-94A5-42B3-A33E-12021344D7BD@amacapital.net>
References: <20260926045517.3458413-1-matthias.goergens@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Yosry Ahmed <yosry@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-api@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
 linux-man@vger.kernel.org, Karel Zak <kzak@redhat.com>,
 util-linux@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Vivi Rodrigo <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Rafael J Wysocki <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org,
 Matthias Goergens <matthias.goergens@gmail.com>
In-Reply-To: <20260926045517.3458413-1-matthias.goergens@gmail.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
X-Mailer: iPhone Mail (23G90)
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



> On Sep 25, 2026, at 9:55=E2=80=AFPM, Matthias Goergens <matthias.goergens@=
gmail.com> wrote:
>=20
> =EF=BB=BFThis RFC adds offload-only swap areas for deliberate cold-page of=
fload to
> backends unsuitable for pressure reclaim. ZFS zvol swap has documented
> deadlocks under memory pressure [3]; compressed swap is another target
> because writes may need memory despite free logical slots.

This seems unnecessarily annoying to configure. It seems to me that you=E2=80=
=99re creating a bizarrely named administrative flag that means, roughly, =E2=
=80=9Cswapping to this location may allocate memory=E2=80=9D.  Why can=E2=80=
=99t the kernel figure this out itself?


For that matter, how well does this even work in practice?  If I configure t=
wo swap devices, one =E2=80=9Coffload-only=E2=80=9D and one conventional, it=
 seems like the relative fullness of the devices will be mostly an accident o=
f what triggers swap as the system is running. If the conventional swap fill=
s up, is there a means to proactively empty it?  Under OOM conditions, will a=
nything preferentially kill tasks that reference memory in conventional swap=
?

Is the locking and recursion structure of the mm code such that we won=E2=80=
=99t have deadlocks where cgroup triggers swap to an =E2=80=9Coffload-only=E2=
=80=9D device, which allocates, which causes memory pressure, which then tri=
es to swap more to conventional swap?  (Maybe this works fine.)

For that matter, if the system is under overall memory pressure, why do you c=
are what triggered the particular swap operation that is being processed?



The remainder of the writeup is IMO somewhat incoherent.  To the extent that=
 AI was used, can you read it and make sure it makes sense?

And the first few hundred lines of patch I skimmed seem like incomprehensibl=
e churn.  Adding =E2=80=9Celigible=E2=80=9D to a bunch of calls does nothing=
 to explain what=E2=80=99s going on.

