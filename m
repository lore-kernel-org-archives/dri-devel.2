Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F97103E19D
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82C410E714;
	Wed, 18 Mar 2026 15:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="mJ0t/PXw";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC6310E465
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:27:03 +0000 (UTC)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 9873132349C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:27:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1773847620; bh=XUl21vHhL+LbY2Xi3MlPdKDu1f5OFFZcciY5bcT+eJ4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mJ0t/PXwsJ5MZru79gI3vdPzoMKbSsNQw4J6O1GtbTPrr/d8BXQgdevEwMUT/Ae7L
 LCNs+QnplmfSsN4znSD4vf/2Uv7eqEhhnOqdTGuKc3zP9cDzJ7IQTR+Q92zQJ8kJZb
 cQotS9P/SLkWJJTstHzPZnhrGWQ1MTsGt2n+xQvDay6yt0rHfOms5z2MOnHJ6s36xM
 KB+czM8S+sR5LZghEVI+pTb0HSn8VSRPzSMVdrlWjrOYExCiKzqWyNAL3GUGA5alJh
 Gz9UMdUw9NUfm/FI8LRrhIBIaD7n7g80loh9zKKVlOVzz/KEkU2dfzikB9HtF9HGTO
 YO013G6RxPz6A==
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so67991d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:27:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWZVow8Hd5BnKyXjp5/JDyG7IjJ1sl6UXRa4NyK20r1OjGVFUY5e/3kxtopLB8VnpPPak4QprRKL/Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHQs6c+0Ety184aM/BreGSyFaxDp89v//2mKFhHP0VDCeKTc78
 VMzehEshZEyL+3TGo1XxoyE23jSWR0h4WRUD4bYmmm6tlguBmoW40pKYSC+eaQPWMPB28k/uKfT
 WvM4SU+MWFLBd2U+bmnymLLLyJnt6KtQ=
X-Received: by 2002:a05:690e:4293:20b0:64c:e7a0:7eb8 with SMTP id
 956f58d0204a3-64e9134c59fmr3433276d50.24.1773847619255; Wed, 18 Mar 2026
 08:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-atomic-v10-0-f59c8def2e70@intel.com>
 <1a4462b8-def9-4474-8382-6e99b7c8276d@intel.com>
 <aZ1OIDsVfFvyHUK5@intel.com> <5f04b5f1-744e-449e-9a45-00fd477256fc@intel.com>
 <aZ1lbnop84k4du6N@intel.com>
 <f155fae0285684108e92887e963358ea0ea158e9@intel.com>
 <1a39b9d5-ed57-4f6b-a4e2-9e26a2734c32@intel.com>
 <21d7edcec1b6fd767b066de4ec6734cea8992904@intel.com>
In-Reply-To: <21d7edcec1b6fd767b066de4ec6734cea8992904@intel.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Wed, 18 Mar 2026 16:26:48 +0100
X-Gmail-Original-Message-ID: <CAFZQkGy=P_kymzU5CdsFth9cKmyQQuWZhy5BRryf0gxULhJX=g@mail.gmail.com>
X-Gm-Features: AaiRm51I2NGi-OkAtLpMwOYBB8XOow-ApWX-oWt-BkyKRFoBuRHFjzKq2mpknrI
Message-ID: <CAFZQkGy=P_kymzU5CdsFth9cKmyQQuWZhy5BRryf0gxULhJX=g@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] User readable error codes on atomic_ioctl failure
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: "Murthy, Arun R" <arun.r.murthy@intel.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, harry.wentland@amd.com,
 uma.shankar@intel.com, 
 louis.chauvet@bootlin.com, naveen1.kumar@intel.com, 
 ramya.krishna.yella@intel.com, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 Suraj Kandpal <suraj.kandpal@intel.com>
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

Am Di., 24. Feb. 2026 um 13:07 Uhr schrieb Jani Nikula
<jani.nikula@linux.intel.com>:
> Yes. But we can't guarantee all drivers will report the *same* first
> error in the same circumstances. We can't guarantee we will maintain the
> *same* first error over time, we can't make that promise without
> painting ourselves in the corner wrt driver maintenance.

That's ok. The point of the error code is to reduce the combinatorial
explosion of possible configurations compositors have to test in order
to get a working configuration, but they're still expected to do (if
necessary) many atomic tests in series, especially when modesets are
involved. If the first reported error changes, it should still
eventually reach a working configuration, even if it may take more or
less time than before.

- Xaver
