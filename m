Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17A6C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 11:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CFBD10E07B;
	Sat, 27 Jun 2026 11:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="SqgbIsCb";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259EE10E07B;
 Sat, 27 Jun 2026 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1782561198; x=1783165998; i=markus.elfring@web.de;
 bh=AuS/t2UY/ZAp88Kb/fuw3whfu9puV4exo+Edxqq8OAI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SqgbIsCb2JDoG7uo6kghmYBwj/1BE7mqX2SCN7eQLdiH32VjnyXSrwMlJ9U1rE20
 tmzos1nmm74uPWiDAaC9rLWKXcPRzwL+oxmvW2nUeYSJD2EyiiAf4KnUw93kutg3o
 JuTRh9XNN/MdZPlMhbNrLra2jgUiSwGsOlFotWDuRaPFjYYfNZb1phvUCtiKL1Gym
 sahrkNMitsoperVVQHOXjDXJ2kYpEPbJDow2a0kNgOemcO+F45viGiM1fp65WiFac
 wXKMcRGx0RSSzsHHg2SLlChMGDrB0kWYKRH1ac/Ynw6ZKqhoqnzd0oYuyr0grCqYQ
 C7Zug/KYD3X6SluRdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6tr-1xBgDd14xn-00frEx; Sat, 27
 Jun 2026 13:53:18 +0200
Message-ID: <0d82b2ff-5451-4ba5-9a02-fec93b93484f@web.de>
Date: Sat, 27 Jun 2026 13:53:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Remove redundant NULL check before
 kfree in mod_power_create()
To: Ziran Zhang <zhangcoder@yeah.net>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Simona Vetter <simona@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, Rodrigo Siqueira <siqueira@igalia.com>
References: <20260627092612.5282-1-zhangcoder@yeah.net>
 <20260627100945.5826-1-zhangcoder@yeah.net>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260627100945.5826-1-zhangcoder@yeah.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m8zl9ATZHigD1tudup3XSjJiH3UPZDHG9+XGd/ffRo2nWFqbdDq
 frSDTc0EaLYihtCCg7EKQLrF085Y5nrnEm+7H3N1HAHJ1qEJI00xeXa/GW5K3qoS6QJa0fC
 h23YlTtyNgsGVO80hpKMjIl6FqMeqMr3DHS7Uw3i6Z+kRNF6G0eXZmyqWWSbiyF3DQc6qgm
 bXFeM3XmumKo6JKEPKeSA==
UI-OutboundReport: notjunk:1;M01:P0:wfIA+cYhf0A=;lZDbQ1uBj1cvyi5xyc+jvCSWpbT
 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
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

> kfree() safely handles NULL pointers, so there is no need to check for
> NULL before calling kfree().
=E2=80=A6

How do you think about to append parentheses to another function name
in the summary phrase?

Regards,
Markus
