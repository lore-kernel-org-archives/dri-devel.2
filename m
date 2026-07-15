Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EF3C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056CA10E1CD;
	Wed, 15 Jul 2026 15:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aOLoj8Tj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C0510E1CD
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 15:06:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A987F6136E
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 15:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAF51F00ADE
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 15:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784127993;
 bh=Fq3EApb3mdMsCrCnwSH+pp0h1+urKkk6TgufwcsavTA=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=aOLoj8Tj2RQN5x1dDzawSawtdyB9nPVBhVa7WtniQPYpMDe/SryaWchW1ZkWdsCuP
 gbSf6YlKessyGwU3ovN3KqV94StcTiS1D/XLOY7r8T/p81mD4vZJo4AmPQTYrXwQ79
 gfvTo500lBQaE9zha/uoIJs1LpXdByVs+k+CChcHO3lnbDKWhmtMdszYEORsrgwwCw
 R6HRos61VfXcvcPcS/c07lLC2URwFx4BeiPOL20cCx+s0kxK/vZ1oUN7av1+gVdAqD
 BNbGwrkrfLbMUAZTPhcJ/A+EvOuh6sE2ZlolfIwHDQZo0RBxS7BQLBQxf1OukeyhXE
 Xhz8tUI8jzHDw==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5b0117d49dcso5291993e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 08:06:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrzEfbST2MLbMhAPCVsDEHBYch3wCnLr7RPb9M9YpiDmXYCrxY+M67hwPghuI34dR2j74LCryS7p20=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqKWIbkl6E9CVaAwV00BrCatC5IT/UtJ0DkPRz0vW7sfrCvee4
 NKhR7Yg1JI/blgYph0Vd1HFplneFVioKjR7NGieTkAdfnyQ5HCyZx2SDeLrJbUXEVEkZMMa+BjH
 RuWLwke4R8rdjQXdTcFwBDqnQozqJIN8WhIgAu0zGPg==
X-Received: by 2002:a05:6512:6185:b0:5b1:4fab:fbd4 with SMTP id
 2adb3069b0e04-5b159b8bbf7mr1391447e87.59.1784127991827; Wed, 15 Jul 2026
 08:06:31 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 10:06:30 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 10:06:30 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAMRc=MfOipGdiGXNgVrJVO8QOivQ-=8k3sX-nMfTS0DvdZcFnw@mail.gmail.com>
MIME-Version: 1.0
References: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
 <20260713-swnode-remove-on-dev-unreg-v7-3-6d6bc448427a@oss.qualcomm.com>
 <DJXNZLE3L756.K5DYSTKM1UHT@kernel.org>
 <CAMRc=MfOipGdiGXNgVrJVO8QOivQ-=8k3sX-nMfTS0DvdZcFnw@mail.gmail.com>
Date: Wed, 15 Jul 2026 10:06:30 -0500
X-Gmail-Original-Message-ID: <CAMRc=MeXwaRSDJYKeoM6PfqWqRPh9KCMF8HATFvaTWUf6N6GYA@mail.gmail.com>
X-Gm-Features: AUfX_myDholJDSN2cDMXGUzfVzc3qcKtFWO9_fcTJk6A17fI1HiyRxBYBU-_K18
Message-ID: <CAMRc=MeXwaRSDJYKeoM6PfqWqRPh9KCMF8HATFvaTWUf6N6GYA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] driver core: platform: unify release path
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Danilo Krummrich <dakr@kernel.org>
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

On Wed, 15 Jul 2026 15:52:07 +0200, Bartosz Golaszewski <brgl@kernel.org> said:
> On Mon, 13 Jul 2026 20:45:13 +0200, Danilo Krummrich <dakr@kernel.org> said:
>> On Mon Jul 13, 2026 at 5:11 PM CEST, Bartosz Golaszewski wrote:
>>
>> So, either we have to special case platform_device_set_of_node() too (for the
>> case that a swnode is set already), or just require that the function must only
>> be called when no node has been set, as all users already do; I'd go for the
>> latter.
>
> This sounds good too and it should be easy to implement another test case while
> at it.

Oh but wouldn't that require us to introduce an integer return value for these
functions? Or are you talking about simply updating the API contract?

I think calling device_remove_software_node() on
is_software_node(dev_fwnode(dev)) in platform_device_set_fwnode() be enough
to handle that case, right?

Bart
