Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1B8C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF8610E1FC;
	Fri, 31 Jul 2026 09:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="CIrj/aOI";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E467310E1FC
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:22:57 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so592466a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 02:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785489777; cv=none;
 d=google.com; s=arc-20260327;
 b=R1LgvZ8fx/FN8+B2ARlQOmAy3MDSJnZPjVx7f03fFehUp3n5NQKdL+ZOBeukiNtGyx
 ZjExdAg8O3IyGMxVLPOnPGHVZGE5ekx6doQcGVI7rhLEIO8QA+zcVTNVWggSGr2hX0Hm
 nc/7VEDQqWG9vItszQIcwAqY9v5jN6U0+AEW61muHW+sp/TfaFpaP0/9DSYjxFSrfTMQ
 6Ij7H8edr4L/vNMNVmOy8k9YlxZAffeIMCQocrI3GRE/dC0zSFFrW4ukoCATpy2C3R3z
 HHBSRRW+rAnnKOTnqPIaooZfpMssZ4lpuAtVDnhjzuvI3CuqM+sToP/vJd7GtaK8o99H
 k1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BPBPlELSCeE22IoU3+/4TogNXuJ7tB9ieEeJ9Oi94U0=;
 fh=u/QHWRX+2ZgMdTrSDy8FR8P+kPY4/1OATYnTYkWqN+s=;
 b=MIp416GEbTTYEVU8YKP8XcrekdRG3COsNYrsT5f7UlU0ASesmdCYE3rUOByjXsF85U
 IdsdHU8GfHF/NuSvil06cymlAoXM1SMSiSSsS8DeWDO41ljnJJ2OZJbbr14Czw+/0quw
 PDz7kft+S4VaTy3+ZRVRZC4HGogWTXUmgQ1OluWcLxkia7POXRdK6/bo0VsFJAdxhGVS
 ytKYt/QXp5+NJDHs5+PwuOuDpOGv+hiTOIzs619zhJNfuN+6w2Os/yTRKLVI1rdduEwB
 RWP4kKCFmuY0AoP2YBWCsKM6mDazgZaFHSzMdB5e0Wy83g9/1VmppNCX+NwMMHPNLjfp
 pmfQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785489777; x=1786094577; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BPBPlELSCeE22IoU3+/4TogNXuJ7tB9ieEeJ9Oi94U0=;
 b=CIrj/aOI6pFO+e+3H31xxtTluLk6mDsxPCKozPSDNYB15t1+rDILgxtFlACGE71KAX
 SV1bCfJgZg7v6zuTNywhMYL3DmhqtKSbxHSyo6DnOW/QpfiQFId1JmotxHQuvfZHVmrW
 VC9jQDqFV5Wk/nwsvsYsc1YamA+IRg2KK08J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785489777; x=1786094577;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BPBPlELSCeE22IoU3+/4TogNXuJ7tB9ieEeJ9Oi94U0=;
 b=MAf5pkLR+fx6UqopU+mMtYe2RdykUiYwfYr0JEzX0A7sEqME50EFhz4e07rw6d5q8s
 KVzmNKmGTDLspRUezqyXN8t8bl2cZs2zKd2iNlfSgDmzAjy6PTdIUBMRLlEbAO8ksGNT
 VT5ElZJ59KMp7xKQpKHQqyXZWigbHqOeUgjVzSsYOfbV8uynUewZzwq0ARIAWM2q3Asq
 mMtrnhmfZihor7lEjgFJZj5Hn9b2AjEY7HJv44fGSOQO3I7sliEXZxBidtqAjE/l/3IS
 eqkRnc0lY/r+bSzjWdBpL3BzKncLvt0WnrhzrBLuMRDBAgUnSivsBywM4Sz4JW1BAzTd
 r7Kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJ31aHhiW3dr5M1/97iOXxuJ7p79uXb9OIz1NCuFxoHWXs2VuGT4yr1C5FItsjmUA7hCpavjdvkzQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmmClwcLzTVxO31s8jEKBnJBLOE+wj9FDbUGIJx8gm85PIwYtk
 vX2NrCVTdkz+1KaYm6VZeXtXZMe8wlJbojJnnlt27Qy6V1pHVJA9rzRVeg6ZvuWWRwjhV7Lfr2v
 UU4pmXrKinAR2oyGYFUGjEPdu9+64a98P7/FFIJqILw==
X-Gm-Gg: AR+sD13xLGqZDG1d4SM6W4mNjouM7m3slhp7cSfNMM6gkhEHdjCpRU3wRfV9m7EXXzg
 j2voI63VnLdFq92aWoh7bZr7hNSSsusU2aqYN9znVmfesLvszV7mAOB4fjkIyL5eAB8MJjwTKdt
 ye5uHRpdlGMXbTfIUfp0nqZNIB0QKDiRMjrFkSvBgmCuamibAWEGkzSBNTSrwnpIn2I9rFcKuwS
 rkYtC4wcUeW/LdYHF2AUcuyQDtDXaWhkze8HOz2T/N9QfsYHnVQg0PNBLznizp7ixyKsiQGhAM6
 DpVgoajOyXF4IKTArrkcoOLg1CuGrQ3oHM9VIi6+d839ILh1ffWKa5OaqyuJKJ/pvmDd51eV8Lf
 ZmGg=
X-Received: by 2002:a17:90b:5290:b0:381:5a08:6291 with SMTP id
 98e67ed59e1d1-38fb140cf5fmr1166898a91.20.1785489777410; Fri, 31 Jul 2026
 02:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260730182640.2808572-1-daniel@0x0f.com>
 <6bbf7e18-92b9-4d18-beb0-0c9812fc7ba8@gmx.de>
 <CAFr9PX=JX_s+J+5twareTYC_U6SRGazXo0XDP6e4r2R4f+q3CA@mail.gmail.com>
 <e21366e9-6ca6-4607-a54b-cf30ce6e5d1f@gmx.de>
In-Reply-To: <e21366e9-6ca6-4607-a54b-cf30ce6e5d1f@gmx.de>
From: Daniel Palmer <daniel@0x0f.com>
Date: Fri, 31 Jul 2026 18:22:45 +0900
X-Gm-Features: AUfX_mwpdylyx5h0RWS5nOxouYDwdQMa7NA-FmPXoBBXrXXK5SNnFDK_OPxCpLs
Message-ID: <CAFr9PXkDwHZA-0X+FQQ9_fqceMH1M4Nneky9Hr7bj5Lm0Oyzyw@mail.gmail.com>
Subject: Re: [PATCH 0/5] fbdev: tdfxfb: Make "unbooted" cards work
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Helge,

On Fri, 31 Jul 2026 at 18:12, Helge Deller <deller@gmx.de> wrote:
> > Sashiko flagged up some things that are valid. Should I send a v2 or send fixes?
> I prefer a clean-up v2 version.
> Dropping and replacing patches is easy for me as long as they are in the for-next branch.

Ok. I'll send a v2 in a few hours.

Thanks,

Daniel
