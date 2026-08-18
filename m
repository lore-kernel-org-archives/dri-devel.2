Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC42C5DF80
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9CA910EA75;
	Tue, 18 Aug 2026 09:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="jDDbIaXd";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE9310EA73
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787043792; x=1787648592; i=deller@gmx.de;
 bh=aiI7aO9fESat5um8JZb3M3gREOmyxOMLPXsaFUxvaII=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jDDbIaXdVA3KPzYeBaUK556DKPiTww/1Q6pJH7HTariw+GKiPBvWlI1vE9mTAOdP
 F6X1/GceE5lj3XFuqn6AxqCXRgKOw0XKIumWgHHFc4UlA9jVmqjO1ONGBZElMIRWT
 iwGWMlF4NXENKYXfbRKgtioQxt+iA3sbAw7xVcgZRZZfTzfmgn92RjBVgNTvQDuYG
 kYWtwXeq8oY2rhAiYaPdlw5dOdH/TyJeubsOzn0CISxwyf3aj4pSbvVRgV4JBeaQZ
 LNJGcjrYoW5BZVPTdKIrLhiYI4XMei4WDj4AvT8jkSHvuuYgg+1H/7h9yid7qWmbd
 NNXCfE6wF3tc1unYmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1xU9KO3yF1-00N3vx; Tue, 18
 Aug 2026 11:03:12 +0200
Message-ID: <5164081e-2eaf-498e-a320-c26c50b6f9e2@gmx.de>
Date: Tue, 18 Aug 2026 11:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: platinumfb: add error checking for ioremap calls
To: yuebingkun <yuebingkun@kylinos.cn>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260817063942.308926-1-yuebingkun@kylinos.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260817063942.308926-1-yuebingkun@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1/b1v3NOPQTKew4FkpbJBFz11XkgvUQYkCniuwcg9JtTKuJUSk5
 IXx+CSkdOJTFxFc2H2TlOZtR4oZS1mh7PhL1jPct6VP1RQKoNjsuiN/+wHwZAIc1vAj6LLk
 TNxXVUNBRf10per+QSzILFJBaukHKVNFSJko2KSl0bBoX0ta6szYLE5EBHGWX7EqbXzYOz2
 5uYRXbUY5BV/pLVYrj1cA==
UI-OutboundReport: notjunk:1;M01:P0:QfHWeLidaO4=;VE7kJQrddk+xzg1d2W4zUTFVujb
 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
 twbKOFxFaSPeeDZOofAt7bu7Cg==
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

On 8/17/26 08:39, yuebingkun wrote:
> The ioremap() and ioremap_wt() calls in platinumfb_probe() were not
> checked for failure. If any of these mappings fail, the driver would
> dereference NULL pointers, leading to a kernel panic.
>=20
> Add proper error checking and use goto-based cleanup to avoid code
> duplication across the error paths.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

That Fixes line ^^^ has no value, so I dropped it.

> Signed-off-by: yuebingkun <yuebingkun@kylinos.cn>

Would be nice to have your Name written out here, e.g. Yue Bing Kun (or so=
mething),
but I've left it as-is for now. In case you resend with full name, I can r=
eplace it
in the git tree.

>   drivers/video/fbdev/platinumfb.c | 36 ++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)
Patch applied (with the Fixes line dropped).

Thanks!
Helge
