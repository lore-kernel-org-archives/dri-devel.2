Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAA606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nvT27K6L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4D810E2E9;
	Sat, 28 Nov 2026 06:00:25 +0000 (UTC)
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F096610E2E9
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 06:00:18 +0000 (UTC)
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-36f936424f2so1744118eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 22:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795845618; x=1796450418; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yx5muuRug6Ngslv8GFhxTqWkNl+hXZLEfzWI8Nj0s5M=;
 b=nvT27K6LNtbJzMEK5wt0m9glkcljACzTyivgB2HfiATkSBz100jY6eaGWleUTG9NUS
 GI6W3OUOC/56TKtOIfQMs18/EWLLIauJxPz9E19fh0MzPoGbdbF4OfSZIAqHCh6QBN0r
 CghFIxbNySDsxtUCEwX3W85ElKCtOFrm9BjneeZRoQNkhCsYgVxQIWVuiHy0TlXDBa8z
 osVJtPFRgSzjkyvKu3KOQRstTlaOL+dr0uEQvFN/IM7W83P4z9nNtLhM6i9uNT3GpPwW
 61YsyoH+NIlfCwaMIixRoSqbdlyBYrcBdcOAYsfv08NbIxGfl3QzbHnjGQD9ueS7dMdy
 wAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795845618; x=1796450418;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yx5muuRug6Ngslv8GFhxTqWkNl+hXZLEfzWI8Nj0s5M=;
 b=wGMZubnPRG0CFUDfGC3PCQ68QLuns7XaqLy5xdTZv2WDaRdfDgpvpc8wE6rzpTO8qk
 Fc0wE2FwvrIk3jJ7rjLrhP9NLOwGRQAfD6DVcwOvqkiiF5DbkJ2C20gMEx76iqX4RVN5
 N4QVfQ92GEK6si3jO1TBf6Dt5rTbKOLQX2qmlJZe5K0ChnUEAW4Us6GxqPP+pieW8KT5
 D37Ek6rM+5fPnsquP1XIkpYDv2Cb54z83JafMcSFpKco/0rS12AKwQ2iGX45eQ26Yu+V
 39/kJ8F8+sjswHrs2lBMdp95su724gM+BsEhvItPR4SyESrn2Wv0VVVvJ8vs8FNEJcr0
 z1Zw==
X-Gm-Message-State: APuU4Z89gMWejTfn7RH+4jojCOA6lkdL4dXH+T3OzlBwbub/iJBlEKTD
 C6hFv+llEw9y+JJ2yUM07wK05og3LEzzByYV/NGO9OhDRz2ZgGcl/VDI0sn1mVwkbSs7x0O/
X-Gm-Gg: AZFdTZePhbmB8KssuTWEQdg2kgwhfWqdPk0meUx491mo6rX+idzvpcjS8KwcTXYwtnv
 0hPl+OxG5lVdxWEoRoMeXWFnBl3Va4mDmqDx3jsMQ6ckXjb9RKKPa2tZwGAMKKy2P/6QzJ3WO/E
 2xjSHM+WzG++1h41MplBGoA3i0HlfB4hVcdw7XZ0nB1rkhSM51QlWEdQLooDtBLAMYVNM7FnvyY
 8PF9qDhcYO0D4Tk1YfIYShVT6ZoV13G9rkZP93BoESrm5eLvDDrQvX8AMpLtmAVhPCBnlzdfaqv
 e6+BZXaEUHfQ6oiGM9gKBHxnPhgC8FxwrwS4hK8MThChcI0tj4BYIWPzW8ZbEObNDvHyHDv6d0S
 QzgwzOfIBIi+zgbydI4Bw3xYcVQfy2bAzhF2e1M7uMjiErD+ZZukhexwezUXQsliRr1b5mwtWZz
 m5QD4+8immyrt2b6dgBX5cYtISgFHCE+dVD2L3Ppv2ml18NEa/+EkNpW8qlI1SQrQwq4PdrAzfd
 YlPLBsjPoF6yIUkA8TezYPuKhZWN1MSmsUCLZdA4aw1mPOW2tffrWctC3qC8/qArWllLJkvH68A
 IlYr2I1Z78g4XHP76/kCoxJhUvyTUfifKnv7yTKY
X-Received: by 2002:a05:7301:7004:b0:386:c5b8:960b with SMTP id
 5a478bee46e88-386c5b89f9emr12711890eec.17.1795845618162; 
 Fri, 27 Nov 2026 22:00:18 -0800 (PST)
Received: from localhost ([2403:2c80:17:1e::20a9])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm92752118eec.4.2026.11.27.22.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 22:00:17 -0800 (PST)
Date: Sat, 28 Nov 2026 14:00:14 +0800
From: Cody Kang <codykang.hk@gmail.com>
To: Zhi Long <longzhi@gmail.com>
Cc: dri-devel@lists.freedesktop.org, spacemit@lists.linux.dev
Subject: Re: drm/spacemit: K1 DPU and the K3 display series
Message-ID: <1f0150e7-4f59-4b51-9641-774b403e8859@gmail.com>
In-Reply-To: <CAGEQorPo=UkuF-o5+c7exvXzaj4uudM_f7ek_6GnSumMyYngdA@mail.gmail.com>
References: <CAGEQorPo=UkuF-o5+c7exvXzaj4uudM_f7ek_6GnSumMyYngdA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

Hi Long Zhi,

Thanks for reaching out.

On Tue, 24 Nov 2026 11:46:55 +0800, Zhi Long wrote:
[...]
> Do you or SpacemiT plan to add the K1 to this driver?

No, I have no plan for the K1. This series covers the K3 only. I
cannot answer for SpacemiT, but from what I know, there are already
people working with SpacemiT on that.

[...]
> 1. Would a K1 variant fit into your driver, for example with a second
>    register map and a second back end next to dpu_saturn_hee.c? In v3 you
>    removed the ops table, so I am not sure which structure you want.

I have no preference to give. The ops table was dropped in v3 after
Thomas Zimmermann's review of v2. That made sense: at this moment I
cannot tell whether those ops would be useful for the K1.

> 2. Is there register documentation for the K1 DPU that can be shared? I
>    took several values from the vendor boot loader without knowing what
>    they mean.

Sorry, I have none to share. It has to come from SpacemiT.

Cody
