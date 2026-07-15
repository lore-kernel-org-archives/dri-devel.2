Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14100C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C1210E1CE;
	Wed, 15 Jul 2026 15:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DdAFpNDc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9031910E1A3;
 Wed, 15 Jul 2026 15:19:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C411440350;
 Wed, 15 Jul 2026 15:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779B91F000E9;
 Wed, 15 Jul 2026 15:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784128796;
 bh=uPRJqOhJ5ehd7+9UhR8NT3FbaiC+PIupWZrQ/SZx09U=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=DdAFpNDc88INU2wPiosqcYm01E48OL4GfhJy/jDUk5cbe0HkYVqylm3R77edrbmHq
 71Ttib5rCGXs7rF7z5HQkaTDjzPyo530APiLcllFfGilPwXEssE0qNLLHTSdd86Uej
 CNMFzfOdqEq3KpLBBFodc6/M5Y2m4P8ZleAY65sLAH7qFgbcqG3spOlFxKbamVL9gm
 Bj/vWxUPWfUf6LvH19/esEN5V3lMLn1vHtb/uRaJWQYO2uzhjgc5cdzeUcV1DQTqhR
 IDmo8q83SpfwT4teoAM+JDZz4e2zM4pwdtVW6EFOK1tg8M47GkiGHmZG43R65Dhwhp
 C6t3A4jvPTMZQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 17:19:52 +0200
Message-Id: <DJZ8VG4H46XC.36XXT1A34B0TK@kernel.org>
Subject: Re: [PATCH v7 3/4] driver core: platform: unify release path
Cc: "Maximilian Luz" <luzmaximilian@gmail.com>, "Hans de Goede"
 <hansg@kernel.org>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>, "Bartosz
 Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
To: "Bartosz Golaszewski" <brgl@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
 <20260713-swnode-remove-on-dev-unreg-v7-3-6d6bc448427a@oss.qualcomm.com>
 <DJXNZLE3L756.K5DYSTKM1UHT@kernel.org>
 <CAMRc=MfOipGdiGXNgVrJVO8QOivQ-=8k3sX-nMfTS0DvdZcFnw@mail.gmail.com>
 <CAMRc=MeXwaRSDJYKeoM6PfqWqRPh9KCMF8HATFvaTWUf6N6GYA@mail.gmail.com>
In-Reply-To: <CAMRc=MeXwaRSDJYKeoM6PfqWqRPh9KCMF8HATFvaTWUf6N6GYA@mail.gmail.com>
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

On Wed Jul 15, 2026 at 5:06 PM CEST, Bartosz Golaszewski wrote:
> On Wed, 15 Jul 2026 15:52:07 +0200, Bartosz Golaszewski <brgl@kernel.org>=
 said:
>> On Mon, 13 Jul 2026 20:45:13 +0200, Danilo Krummrich <dakr@kernel.org> s=
aid:
>>> On Mon Jul 13, 2026 at 5:11 PM CEST, Bartosz Golaszewski wrote:
>>>
>>> So, either we have to special case platform_device_set_of_node() too (f=
or the
>>> case that a swnode is set already), or just require that the function m=
ust only
>>> be called when no node has been set, as all users already do; I'd go fo=
r the
>>> latter.
>>
>> This sounds good too and it should be easy to implement another test cas=
e while
>> at it.
>
> Oh but wouldn't that require us to introduce an integer return value for =
these
> functions? Or are you talking about simply updating the API contract?

Yes, we could update the API contract; we could also consider adding a WARN=
_ON()
for the case a node is already set.

> I think calling device_remove_software_node() on
> is_software_node(dev_fwnode(dev)) in platform_device_set_fwnode() be enou=
gh
> to handle that case, right?

Yes, we can special case it, but the "replace the existing node if any" par=
t of
that function is already dead code.

So, if no one needs it now, I'd rather remove it and wait for someone to ha=
ve a
valid use-case.
